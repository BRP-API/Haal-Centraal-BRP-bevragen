namespace Brp.Shared.Infrastructure.Logging;

internal static class MapToEcsKeys
{
    public const string EcsRequestBody = "ecs.request.body";
    public const string EcsRequestContentType = "ecs.request.content-type";
    public const string EcsResponseBody = "ecs.response.body";
    public const string EcsResponseContentType = "ContentType"; // wordt automatisch gemapt als deze naam wordt gebruikt
}
