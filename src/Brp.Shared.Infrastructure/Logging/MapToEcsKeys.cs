namespace Brp.Shared.Infrastructure.Logging;

internal static class MapToEcsKeys
{
    public const string EcsRequestBody = "ecs.request.body";
    public const string EcsRequestContentType = "ecs.request.content-type";
    public const string EcsResponseBody = "ecs.response.body";
    public const string EcsResponseContentType = "ContentType"; // wordt automatisch gemapt naar ecs.response.content-type als deze naam wordt gebruikt
}

public static class LogConstants
{
    public const string Autorisatie = "autorisatie";
    public const string Protocollering = "protocollering";
    public const string RequestHeaders = "request.headers";
    public const string ResponseHeaders = "response.headers";
}