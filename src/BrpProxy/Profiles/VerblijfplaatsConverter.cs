using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfplaatsConverter : ITypeConverter<GbaVerblijfplaats, AbstractVerblijfplaats?>
{
    public AbstractVerblijfplaats? Convert(GbaVerblijfplaats source, AbstractVerblijfplaats? destination, ResolutionContext context)
    {
        return source switch
        {
            { Land.Code: var code } when code != "0000" => context.Mapper.Map<VerblijfplaatsBuitenland>(source),
            { Land.Code: "0000" } => context.Mapper.Map<VerblijfplaatsOnbekend>(source),
            { Straat: var straat, Huisnummer: var huisnummer } when !string.IsNullOrEmpty(straat) || huisnummer > 0 => context.Mapper.Map<Adres>(source),
            { Locatiebeschrijving: var locatiebeschrijving } when !string.IsNullOrWhiteSpace(locatiebeschrijving) => context.Mapper.Map<Locatie>(source),
            _=> null,
        };
    }
}
