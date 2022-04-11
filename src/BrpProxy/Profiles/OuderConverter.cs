using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles
{
    public class OuderConverter : ITypeConverter<GbaOuder, AbstractOuder>
    {
        public AbstractOuder Convert(GbaOuder source, AbstractOuder destination, ResolutionContext context)
        {
            return source switch
            {
                { Naam.Geslachtsnaam: var geslachtsnaam } when geslachtsnaam == "." => context.Mapper.Map<OnbekendOuder>(source),

                _ => context.Mapper.Map<Ouder>(source)
            };
        }
    }
}