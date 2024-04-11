using Serilog;
using System.Security.Cryptography.X509Certificates;

namespace BrpProxy.DelegatingHandlers;

public class X509Handler : DelegatingHandler
{
    private readonly IWebHostEnvironment _environment;
    private readonly IConfiguration _configuration;
    private readonly IDiagnosticContext _diagnosticContext;

    public X509Handler(IWebHostEnvironment environment, IConfiguration configuration, IDiagnosticContext diagnosticContext)
    {
        _environment = environment;
        _configuration = configuration;
        _diagnosticContext = diagnosticContext;
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

                        _diagnosticContext.Set("X509Handler", $"Certificate '{path}' added for mTLS authentication");
                    }
                    catch(Exception ex)
                    {
                        _diagnosticContext.SetException(ex);
                    }
                }
            }
            else
            {
                _diagnosticContext.Set("X509Handler", $"Certificate '{path}' does not exist");
            }
        }
        else
        {
            _diagnosticContext.Set("X509Handler", "No certificate and/or password provided");
        }

        return base.SendAsync(request, cancellationToken);
    }
}
