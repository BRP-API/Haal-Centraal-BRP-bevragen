namespace Brp.Shared.Infrastructure.Protocollering;

public class ProtocolleerResult
{
    public ProtocolleerResult(bool isSuccess, IEnumerable<string> errors)
    {
        IsSuccess = isSuccess;
        Errors = new(errors);
    }

    public bool IsSuccess { get; }

    public List<string> Errors { get; }
}
