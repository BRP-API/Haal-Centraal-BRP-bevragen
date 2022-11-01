using System.Security.Cryptography.X509Certificates;

namespace BrpProxy.DelegatingHandlers;

public class X509Handler : DelegatingHandler
{
    private readonly ILogger<X509Handler> _logger;
    private readonly IWebHostEnvironment _environment;
    private readonly IConfiguration _configuration;

    public X509Handler(ILogger<X509Handler> logger, IWebHostEnvironment environment, IConfiguration configuration)
    {
        _logger = logger;
        _environment = environment;
        _configuration = configuration;
    }

    protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
    {
        var certificate = _configuration["ClientCertificate:Name"];
        var password = _configuration["ClientCertificate:Password"];

        if (!string.IsNullOrWhiteSpace(certificate) &&
            !string.IsNullOrWhiteSpace(password))
        {
            var path = Path.Combine(_environment.ContentRootPath, "certificates", certificate);
            if (File.Exists(path))
            {
                var innerHandler = this.InnerHandler;
                while(innerHandler is DelegatingHandler handler)
                {
                    innerHandler = handler.InnerHandler;
                }
                if(innerHandler is HttpClientHandler httpClientHandler)
                {
                    try
                    {
                        var x509Certificate = new X509Certificate2(path, password);

                        httpClientHandler.ClientCertificates.Add(x509Certificate);

                        _logger.LogDebug("X509Handler.SendAsync. Certificate '{path}' added for mTLS authentication", path);
                    }
                    catch(Exception ex)
                    {
                        _logger.LogWarning(ex, $"X509Handler.SendAsync: {ex.Message}");
                    }
                }
            }
            else
            {
                _logger.LogWarning("X509Handler.SendAsync: Certificate file '{path}' does not exist", path);
            }
        }
        else
        {
            _logger.LogDebug("X509Handler:SendAsync: No certificate and/or password provided");
        }

        return base.SendAsync(request, cancellationToken);
    }
}
