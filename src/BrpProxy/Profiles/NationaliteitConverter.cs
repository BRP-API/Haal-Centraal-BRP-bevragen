using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class NationaliteitConverter : ITypeConverter<GbaNationaliteit, AbstractNationaliteit?>
{
    public AbstractNationaliteit? Convert(GbaNationaliteit source, AbstractNationaliteit? destination, ResolutionContext context)
    {
        return source switch
        {
            { Nationaliteit.Code: var code } when code == "0002" => context.Mapper.Map<BehandeldAlsNederlander>(source),
            { Nationaliteit.Code: var code } when code == "0500" => context.Mapper.Map<VastgesteldNietNederlander>(source),
            { Nationaliteit.Code: var code } when code == "0499" => context.Mapper.Map<Staatloos>(source),
            { Nationaliteit.Code: var code } when code != "0000" => context.Mapper.Map<NationaliteitBekend>(source),
            { AanduidingBijzonderNederlanderschap: var code } when code == "B" => context.Mapper.Map<BehandeldAlsNederlander>(source),
            { AanduidingBijzonderNederlanderschap: var code } when code == "V" => context.Mapper.Map<VastgesteldNietNederlander>(source),
            _ => context.Mapper.Map<NationaliteitOnbekend>(source)
        };
    }
}
