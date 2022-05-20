using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles
{
    public class KindConverter : ITypeConverter<GbaKind, AbstractKind>
    {
        public AbstractKind Convert(GbaKind source, AbstractKind destination, ResolutionContext context)
        {
            return source switch
            {
                { Naam.Geslachtsnaam: var geslachtsnaam } when geslachtsnaam == "." => context.Mapper.Map<KindOnbekend>(source),
                _ => context.Mapper.Map<Kind>(source),
            };
        }
    }
}