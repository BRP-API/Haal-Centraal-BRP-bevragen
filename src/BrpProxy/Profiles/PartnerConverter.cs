using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles
{
    public class PartnerConverter : ITypeConverter<GbaPartner, AbstractPartner>
    {
        private readonly IMapper _mapper;

        public PartnerConverter(IMapper mapper)
        {
            _mapper = mapper;
        }
        public AbstractPartner Convert(GbaPartner source, AbstractPartner destination, ResolutionContext context)
        {
            return source.OntbindingHuwelijkPartnerschap == null
                ? _mapper.Map<Partner>(source)
                : new OntbondenPartner();
        }
    }
}