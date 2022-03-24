using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles
{
    public class NationaliteitConverter : ITypeConverter<GbaNationaliteit, AbstractNationaliteit?>
    {
        public AbstractNationaliteit? Convert(GbaNationaliteit source, AbstractNationaliteit? destination, ResolutionContext context)
        {
            return source switch
            {
                { Nationaliteit.Code: var code } when code != "0000" => context.Mapper.Map<Nationaliteit>(source),
                { AanduidingBijzonderNederlanderschap.Code: var code } when code == "B" => context.Mapper.Map<BehandeldAlsNederlander>(source),
                { AanduidingBijzonderNederlanderschap.Code: var code } when code == "V" => context.Mapper.Map<VastgesteldNietNederlander>(source),
                _ => null
            };
        }
    }
}