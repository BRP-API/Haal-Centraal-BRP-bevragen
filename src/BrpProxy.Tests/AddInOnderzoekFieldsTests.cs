using BrpProxy.Validators;
using FluentAssertions;
using Xunit;

namespace BrpProxy.Tests
{
    public class AddInOnderzoekFieldsTests
    {
        [Theory]
        [InlineData(new[] { "burgerservicenummer" },
                    new[]
                        {
                            "burgerservicenummer",
                            "inOnderzoek.burgerservicenummer",
                            "inOnderzoek.datumIngangOnderzoekPersoon"
                        })]

        [InlineData(new[] { "aNummer" },
                    new[] { "aNummer" })]

        [InlineData(new[] { "europeesKiesrecht" },
                    new[] { "europeesKiesrecht" })]

        [InlineData(new[] { "geheimhoudingPersoonsgegevens" },
                    new[] { "geheimhoudingPersoonsgegevens" })]

        [InlineData(new[] { "opschortingBijhouding" },
                    new[] { "opschortingBijhouding" })]

        [InlineData(new[] { "rni" },
                    new[] { "rni" })]

        [InlineData(new[] { "uitsluitingKiesrecht" },
                    new[] { "uitsluitingKiesrecht" })]
        [InlineData(new[] { "uitsluitingKiesrecht.uitgeslotenVanKiesrecht" },
                    new[] { "uitsluitingKiesrecht.uitgeslotenVanKiesrecht" })]

        [InlineData(new[] { "verificatie" },
                    new[] { "verificatie" })]

        [InlineData(new[] { "aNummer", "leeftijd" },
                    new[] {
                            "aNummer",
                            "leeftijd",
                            "inOnderzoek.leeftijd",
                            "inOnderzoek.datumIngangOnderzoekPersoon" })]


        [InlineData(new[] { "datumEersteInschrijvingGBA" },
                    new[] { "datumEersteInschrijvingGBA" })]

        [InlineData(new[] { "gemeenteVanInschrijving", "datumInschrijvingInGemeente" },
                    new[] {
                            "gemeenteVanInschrijving",
                            "inOnderzoek.gemeenteVanInschrijving",
                            "datumInschrijvingInGemeente",
                            "inOnderzoek.datumInschrijvingInGemeente",
                            "inOnderzoek.datumIngangOnderzoekGemeente" })]

        [InlineData(new[] { "geslacht" },
                    new[] {
                            "geslacht",
                            "inOnderzoek.geslacht",
                            "inOnderzoek.datumIngangOnderzoekPersoon" })]

        [InlineData(new[] { "indicatieGezagMinderjarige" },
                    new[] {
                            "indicatieGezagMinderjarige",
                            "inOnderzoek.indicatieGezagMinderjarige",
                            "inOnderzoek.datumIngangOnderzoekGezag" })]

        [InlineData(new[] { "indicatieCurateleRegister" },
                    new[] {
                            "indicatieCurateleRegister",
                            "inOnderzoek.indicatieCurateleRegister",
                            "inOnderzoek.datumIngangOnderzoekGezag" })]

        [InlineData(new[] { "adressering" },
                    new[] { "adressering", "adressering.inOnderzoek" })]

        [InlineData(new[] { "adressering.aanhef" },
                    new[] { "adressering.aanhef",
                            "adressering.inOnderzoek.aanhef",
                            "adressering.inOnderzoek.datumIngangOnderzoekPersoon",
                            "adressering.inOnderzoek.datumIngangOnderzoekPartner"})]

        [InlineData(new[] { "adressering.aanschrijfwijze.naam" },
                    new[] { "adressering.aanschrijfwijze.naam",
                            "adressering.inOnderzoek.aanschrijfwijze",
                            "adressering.inOnderzoek.datumIngangOnderzoekPersoon",
                            "adressering.inOnderzoek.datumIngangOnderzoekPartner"})]

        [InlineData(new[] { "adressering.adresregel1" },
                    new[] { "adressering.adresregel1",
                            "adressering.inOnderzoek.adresregel1",
                            "adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats"})]

        [InlineData(new[] { "geboorte" },
                    new[] { "geboorte", "geboorte.inOnderzoek" })]

        [InlineData(new[] { "immigratie" },
                    new[] { "immigratie", "immigratie.inOnderzoek" })]

        [InlineData(new[] { "kinderen" },
                    new[] { "kinderen", "kinderen.inOnderzoek" })]
        [InlineData(new[] { "kinderen.burgerservicenummer" },
                    new[] { "kinderen.burgerservicenummer",
                            "kinderen.inOnderzoek.burgerservicenummer",
                            "kinderen.inOnderzoek.datumIngangOnderzoek"})]
        [InlineData(new[] { "kinderen.geboorte" },
                    new[] { "kinderen.geboorte", "kinderen.geboorte.inOnderzoek" })]
        [InlineData(new[] { "kinderen.geboorte.datum" },
                    new[] { "kinderen.geboorte.datum",
                            "kinderen.geboorte.inOnderzoek.datum",
                            "kinderen.geboorte.inOnderzoek.datumIngangOnderzoek"})]

        [InlineData(new[] { "naam" },
                    new[] { "naam", "naam.inOnderzoek"})]
        [InlineData(new[] { "naam.geslachtsnaam" },
                    new[] { "naam.geslachtsnaam",
                            "naam.inOnderzoek.geslachtsnaam",
                            "naam.inOnderzoek.datumIngangOnderzoek" })]

        [InlineData(new[] { "nationaliteiten" },
                    new[] { "nationaliteiten", "nationaliteiten.inOnderzoek" })]
        [InlineData(new[] { "nationaliteiten.datumIngangGeldigheid" },
                    new[] { "nationaliteiten.datumIngangGeldigheid" })]
        [InlineData(new[] { "nationaliteiten.nationaliteit" },
                    new[] { "nationaliteiten.nationaliteit",
                            "nationaliteiten.inOnderzoek.nationaliteit",
                            "nationaliteiten.inOnderzoek.datumIngangOnderzoek" })]

        [InlineData(new[] { "ouders" },
                    new[] { "ouders", "ouders.inOnderzoek" })]
        [InlineData(new[] { "ouders.burgerservicenummer" },
                    new[] { "ouders.burgerservicenummer",
                            "ouders.inOnderzoek.burgerservicenummer",
                            "ouders.inOnderzoek.datumIngangOnderzoek"})]
        [InlineData(new[] { "ouders.ouderAanduiding" },
                    new[] { "ouders.ouderAanduiding" })]
        [InlineData(new[] { "ouders.geboorte" },
                    new[] { "ouders.geboorte", "ouders.geboorte.inOnderzoek" })]
        [InlineData(new[] { "ouders.geboorte.datum" },
                    new[] { "ouders.geboorte.datum",
                            "ouders.geboorte.inOnderzoek.datum",
                            "ouders.geboorte.inOnderzoek.datumIngangOnderzoek"})]

        [InlineData(new[] { "overlijden"},
                    new[] { "overlijden", "overlijden.inOnderzoek"})]
        [InlineData(new[] { "overlijden.datum" },
                    new[] { "overlijden.datum",
                            "overlijden.inOnderzoek.datum",
                            "overlijden.inOnderzoek.datumIngangOnderzoek"})]
        [InlineData(new[] { "overlijden.land" },
                    new[] { "overlijden.land",
                            "overlijden.inOnderzoek.land",
                            "overlijden.inOnderzoek.datumIngangOnderzoek"})]

        [InlineData(new[] { "partners" },
                    new[] { "partners", "partners.inOnderzoek" })]
        [InlineData(new[] { "partners.aangaanHuwelijkPartnerschap" },
                    new[] { "partners.aangaanHuwelijkPartnerschap", "partners.aangaanHuwelijkPartnerschap.inOnderzoek" })]
        [InlineData(new[] { "partners.ontbindingHuwelijkPartnerschap" },
                    new[] { "partners.ontbindingHuwelijkPartnerschap", "partners.ontbindingHuwelijkPartnerschap.inOnderzoek" })]

        [InlineData(new[] { "verblijfplaats"},
                    new[] { "verblijfplaats", "verblijfplaats.inOnderzoek"})]
        [InlineData(new[] { "verblijfplaats.datumVan" },
                    new[] {
                            "verblijfplaats.datumVan",
                            "verblijfplaats.inOnderzoek.type",
                            "verblijfplaats.inOnderzoek.datumVan",
                            "verblijfplaats.inOnderzoek.datumIngangOnderzoek" })]
        [InlineData(new[] { "verblijfplaats.datumVan", "verblijfplaats.functieAdres" },
                    new[] {
                            "verblijfplaats.datumVan",
                            "verblijfplaats.inOnderzoek.datumVan",
                            "verblijfplaats.functieAdres",
                            "verblijfplaats.inOnderzoek.functieAdres",
                            "verblijfplaats.inOnderzoek.type",
                            "verblijfplaats.inOnderzoek.datumIngangOnderzoek" })]
        [InlineData(new[] { "verblijfplaats.verblijfadres" },
                    new[] {
                            "verblijfplaats.inOnderzoek.type",
                            "verblijfplaats.inOnderzoek.datumIngangOnderzoek",
                            "verblijfplaats.verblijfadres",
                            "verblijfplaats.verblijfadres.inOnderzoek" })]
        [InlineData(new[] { "verblijfplaats.verblijfadres.officieleStraatnaam" },
                    new[] {
                            "verblijfplaats.inOnderzoek.type",
                            "verblijfplaats.inOnderzoek.datumIngangOnderzoek",
                            "verblijfplaats.verblijfadres.officieleStraatnaam",
                            "verblijfplaats.verblijfadres.inOnderzoek.officieleStraatnaam",
                            "verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek" })]
        [InlineData(new[] { "verblijfplaats.verblijfadres.officieleStraatnaam", "verblijfplaats.verblijfadres.huisnummer" },
                    new[] {
                            "verblijfplaats.inOnderzoek.type",
                            "verblijfplaats.inOnderzoek.datumIngangOnderzoek",
                            "verblijfplaats.verblijfadres.officieleStraatnaam",
                            "verblijfplaats.verblijfadres.inOnderzoek.officieleStraatnaam",
                            "verblijfplaats.verblijfadres.huisnummer",
                            "verblijfplaats.verblijfadres.inOnderzoek.huisnummer",
                            "verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek" })]

        [InlineData(new[] { "verblijfstitel" },
                    new[] { "verblijfstitel", "verblijfstitel.inOnderzoek" })]
        public void Verblijfplaats(string[] input, string[] expected)
        {
            input.AddInOnderzoekFields().Should().BeEquivalentTo(expected);
        }
    }
}
