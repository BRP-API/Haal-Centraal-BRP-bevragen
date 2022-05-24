using Newtonsoft.Json;

namespace BrpProxy.Middlewares
{
    public static class JsonConvertExtensions
    {
        public static string ToJson(this object obj)
        {
            return JsonConvert.SerializeObject(obj);
        }
    }
}
