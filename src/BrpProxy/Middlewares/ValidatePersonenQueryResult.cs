using HaalCentraal.BrpProxy.Generated;
using FluentValidation.Results;

namespace BrpProxy.Middlewares
{
    public class ValidatePersonenQueryResult
    {
        public static ValidatePersonenQueryResult CreateFrom(ValidationResult result, ICollection<string>? fields, HttpContext context)
        {
            if (result.IsValid)
            {
                return new ValidatePersonenQueryResult(fields);
            }

            var invalidParams = from error in result.Errors
                                select new InvalidParams
                                {
                                    Name = $"{char.ToLowerInvariant(error.PropertyName[0])}{error.PropertyName[1..]}",
                                    Code = error.ErrorMessage.Split("||")[0],
                                    Reason = error.ErrorMessage.Split("||")[1]
                                };
            var titel = invalidParams.Any(x => x.Code == "required")
                ? "Minimale combinatie van parameters moet worden opgegeven."
                : "Een of meerdere parameters zijn niet correct.";
            var code = invalidParams.Any(x => x.Code == "required")
                ? "paramsCombination"
                : "paramsValidation";

            return new ValidatePersonenQueryResult(context.CreateBadRequestFoutbericht(titel, code, invalidParams));
        }

        public static ValidatePersonenQueryResult CreateFrom(ValidationResult result, HttpContext context)
        {
            var invalidParams = from error in result.Errors
                                select new InvalidParams
                                {
                                    Name = "type",
                                    Code = error.ErrorMessage.Split("||")[0],
                                    Reason = error.ErrorMessage.Split("||")[1]
                                };
            var titel = invalidParams.Any(x => x.Code == "required")
                ? "Minimale combinatie van parameters moet worden opgegeven."
                : "Een of meerdere parameters zijn niet correct.";
            var code = invalidParams.Any(x => x.Code == "required")
                ? "paramsCombination"
                : "paramsValidation";

            return new ValidatePersonenQueryResult(context.CreateBadRequestFoutbericht(titel, code, invalidParams));
        }

        private ValidatePersonenQueryResult(ICollection<string>? fields)
        {
            IsValid = true;
            Fields = fields;
        }

        private ValidatePersonenQueryResult(BadRequestFoutbericht foutbericht)
        {
            IsValid = false;
            Foutbericht = foutbericht;
        }

        public bool IsValid { get; }
        public ICollection<string>? Fields { get; }
        public BadRequestFoutbericht? Foutbericht { get; }
    }
}
