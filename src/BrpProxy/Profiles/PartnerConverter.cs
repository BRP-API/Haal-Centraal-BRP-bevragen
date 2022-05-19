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
            //if (
            //    source.AangaanHuwelijkPartnerschap is null &&
            //    string.IsNullOrEmpty(source.Burgerservicenummer) &&
            //    source.Geboorte is null &&
            //    source.Geslachtsaanduiding is null &&
            //    source.InOnderzoek is null &&
            //    source.Naam is { Geslachtsnaam: "." } &&
            //    source.OntbindingHuwelijkPartnerschap is null &&
            //    source.SoortVerbintenis is null
            //   ) return new PartnerOnbekend();

            //if (
            //    source.AangaanHuwelijkPartnerschap is null &&
            //    string.IsNullOrEmpty(source.Burgerservicenummer) &&
            //    source.Geboorte is { Datum: "00000000" } or { Plaats.Code: "0000" } or { Land.Code: "0000" } &&
            //    source.Geslachtsaanduiding is null &&
            //    source.InOnderzoek is null &&
            //    source.Naam is null &&
            //    source.OntbindingHuwelijkPartnerschap is null &&
            //    source.SoortVerbintenis is null
            //   ) return new PartnerOnbekend();

            //if (
            //    source.AangaanHuwelijkPartnerschap is null &&
            //    string.IsNullOrEmpty(source.Burgerservicenummer) &&
            //    source.Geboorte is null &&
            //    source.Geslachtsaanduiding is null &&
            //    source.InOnderzoek is null &&
            //    source.Naam is null &&
            //    source.OntbindingHuwelijkPartnerschap is null &&
            //    source is { SoortVerbintenis.Code : "." }
            //    ) return new PartnerOnbekend();

            //if (
            //    source.AangaanHuwelijkPartnerschap is { Datum: "00000000" } or { Plaats.Code: "0000" } or { Land.Code: "0000" } &&
            //    string.IsNullOrEmpty(source.Burgerservicenummer) &&
            //    source.Geboorte is null &&
            //    source.Geslachtsaanduiding is null &&
            //    source.InOnderzoek is null &&
            //    source.Naam is null &&
            //    source.OntbindingHuwelijkPartnerschap is null &&
            //    source.SoortVerbintenis is null
            //   ) return new PartnerOnbekend();

            //if (
            //    source.AangaanHuwelijkPartnerschap is null &&
            //    string.IsNullOrEmpty(source.Burgerservicenummer) &&
            //    source.Geboorte is null &&
            //    source.Geslachtsaanduiding is null &&
            //    source.InOnderzoek is not null &&
            //    source.Naam is null &&
            //    source.OntbindingHuwelijkPartnerschap is null &&
            //    source.SoortVerbintenis is null
            //   ) return new PartnerOnbekend();

            if (source.OntbindingHuwelijkPartnerschap != null) return _mapper.Map<OntbondenPartner>(source);

            return _mapper.Map<Partner>(source);
            //return source.OntbindingHuwelijkPartnerschap == null
            //    ? _mapper.Map<Partner>(source)
            //    : new OntbondenPartner();
        }
    }
}