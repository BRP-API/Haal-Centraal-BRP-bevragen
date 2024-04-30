using BrpProxy.Validators;
using FluentAssertions;
using System.Collections.Generic;
using Xunit;

namespace BrpProxy.Tests
{
    public class ReplaceDatumAndWaardetabelPropertyFieldPathsTests
    {
        [Theory]
        [InlineData(new string[] { "adresseringBinnenland" }, new string[] { "adressering.aanhef", "adressering.aanschrijfwijze", "adressering.gebruikInLopendeTekst", "adressering.adresregel1", "adressering.adresregel2" })]
        [InlineData(new string[] { "adresseringBinnenland.aanhef" }, new string[] { "adressering.aanhef" })]
        [InlineData(new string[] { "adresseringBinnenland.aanschrijfwijze" }, new string[] { "adressering.aanschrijfwijze" })]
        [InlineData(new string[] { "adresseringBinnenland.aanschrijfwijze.naam" }, new string[] { "adressering.aanschrijfwijze.naam" })]
        public void AdresseringBinnenland(IEnumerable<string> input, IEnumerable<string> expected)
        {
            input.ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths().Should().BeEquivalentTo(expected);
        }

        [Theory]
        [InlineData(new string[] { "geboorte.datum" }, new string[] { "geboorte.datum" })]
        [InlineData(new string[] { "geboorte.datum.datum" }, new string[] { "geboorte.datum" })]
        public void Geboorte(IEnumerable<string> input, IEnumerable<string> expected)
        {
            input.ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths().Should().BeEquivalentTo(expected);
        }

        [Theory]
        [InlineData(new string[] { "kinderen.geboorte.datum" }, new string[] { "kinderen.geboorte.datum" })]
        [InlineData(new string[] { "kinderen.geboorte.datum.datum" }, new string[] { "kinderen.geboorte.datum" })]
        public void Kind(IEnumerable<string> input, IEnumerable<string> expected)
        {
            input.ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths().Should().BeEquivalentTo(expected);
        }

        [Theory]
        [InlineData(new string[] { "overlijden.datum" }, new string[] { "overlijden.datum" })]
        [InlineData(new string[] { "overlijden.datum.datum" }, new string[] { "overlijden.datum" })]
        public void Overlijden(IEnumerable<string> input, IEnumerable<string> expected)
        {
            input.ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths().Should().BeEquivalentTo(expected);
        }

        [Theory]
        [InlineData(new string[] { "partners.aangaanHuwelijkPartnerschap.datum" }, new string[] { "partners.aangaanHuwelijkPartnerschap.datum" })]
        [InlineData(new string[] { "partners.aangaanHuwelijkPartnerschap.datum.datum" }, new string[] { "partners.aangaanHuwelijkPartnerschap.datum" })]
        [InlineData(new string[] { "partners.geboorte.datum" }, new string[] { "partners.geboorte.datum" })]
        [InlineData(new string[] { "partners.geboorte.datum.datum" }, new string[] { "partners.geboorte.datum" })]
        [InlineData(new string[] { "partners.naam.adellijkeTitelPredicaat.soort" }, new string[] { "partners.naam.adellijkeTitelPredicaat" })]
        public void Partner(IEnumerable<string> input, IEnumerable<string> expected)
        {
            input.ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths().Should().BeEquivalentTo(expected);
        }

        [Theory]
        [InlineData(new string[] { "verblijfplaats" }, new string[] { "verblijfplaats" })]
        [InlineData(new string[] { "verblijfplaats.adresseerbaarObjectIdentificatie" }, new string[] { "verblijfplaats.adresseerbaarObjectIdentificatie" })]

        [InlineData(new string[] { "verblijfplaats.datumIngangGeldigheid" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaats.datumIngangGeldigheid.type" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaats.datumIngangGeldigheid.datum" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaats.datumIngangGeldigheid.langFormaat" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaats.datumIngangGeldigheid.jaar" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaats.datumIngangGeldigheid.maand" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaats.datumIngangGeldigheid.onbekend" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]

        [InlineData(new string[] { "verblijfplaats.datumVan" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaats.datumVan.type" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaats.datumVan.datum" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaats.datumVan.langFormaat" }, new string[] { "verblijfplaats.datumVan" } )]
        [InlineData(new string[] { "verblijfplaats.datumVan.jaar" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaats.datumVan.maand" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaats.datumVan.onbekend" }, new string[] { "verblijfplaats.datumVan" })]

        [InlineData(new string[] { "verblijfplaats.functieAdres" }, new string[] { "verblijfplaats.functieAdres" })]
        [InlineData(new string[] { "verblijfplaats.functieAdres.code" }, new string[] { "verblijfplaats.functieAdres" })]
        [InlineData(new string[] { "verblijfplaats.functieAdres.omschrijving" }, new string[] { "verblijfplaats.functieAdres" })]

        [InlineData(new string[] { "verblijfplaats.nummeraanduidingIdentificatie" }, new string[] { "verblijfplaats.nummeraanduidingIdentificatie" })]
        [InlineData(new string[] { "verblijfplaats.type" }, new string[] { "verblijfplaats.type" })]

        [InlineData(new string[] { "verblijfplaats.verblijfadres" }, new string[] { "verblijfplaats.verblijfadres" })]
        [InlineData(new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer" }, new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer" })]
        [InlineData(new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer.code" }, new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer" })]
        [InlineData(new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer.omschrijving" }, new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer" })]
        [InlineData(new string[] { "verblijfplaats.verblijfadres.land" }, new string[] { "verblijfplaats.verblijfadres.land" })]
        [InlineData(new string[] { "verblijfplaats.verblijfadres.land.code" }, new string[] { "verblijfplaats.verblijfadres.land" })]
        [InlineData(new string[] { "verblijfplaats.verblijfadres.land.omschrijving" }, new string[] { "verblijfplaats.verblijfadres.land" })]
        [InlineData(new string[] { "verblijfplaats.verblijfadres.postcode" }, new string[] { "verblijfplaats.verblijfadres.postcode" })]
        public void Verblijfplaats(IEnumerable<string> input, IEnumerable<string> expected)
        {
            input.ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths().Should().BeEquivalentTo(expected);
        }

        [Theory]
        [InlineData(new string[] { "verblijfplaatsBinnenland" }, new string[] { "verblijfplaats" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie" }, new string[] { "verblijfplaats.adresseerbaarObjectIdentificatie" })]

        [InlineData(new string[] { "verblijfplaatsBinnenland.datumIngangGeldigheid" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumIngangGeldigheid.type" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumIngangGeldigheid.datum" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumIngangGeldigheid.langFormaat" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumIngangGeldigheid.jaar" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumIngangGeldigheid.maand" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumIngangGeldigheid.onbekend" }, new string[] { "verblijfplaats.datumIngangGeldigheid" })]

        [InlineData(new string[] { "verblijfplaatsBinnenland.datumVan" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumVan.datum" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumVan.type" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumVan.langFormaat" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumVan.jaar" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumVan.maand" }, new string[] { "verblijfplaats.datumVan" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.datumVan.onbekend" }, new string[] { "verblijfplaats.datumVan" })]

        [InlineData(new string[] { "verblijfplaatsBinnenland.functieAdres" }, new string[] { "verblijfplaats.functieAdres" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.functieAdres.code" }, new string[] { "verblijfplaats.functieAdres" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.functieAdres.omschrijving" }, new string[] { "verblijfplaats.functieAdres" })]

        [InlineData(new string[] { "verblijfplaatsBinnenland.nummeraanduidingIdentificatie" }, new string[] { "verblijfplaats.nummeraanduidingIdentificatie" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.type" }, new string[] { "verblijfplaats.type" })]

        [InlineData(new string[] { "verblijfplaatsBinnenland.verblijfadres" }, new string[] { "verblijfplaats.verblijfadres" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer" }, new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.code" }, new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.omschrijving" }, new string[] { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.verblijfadres.land" }, new string[] { "verblijfplaats.verblijfadres.land" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.verblijfadres.land.code" }, new string[] { "verblijfplaats.verblijfadres.land" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.verblijfadres.land.omschrijving" }, new string[] { "verblijfplaats.verblijfadres.land" })]
        [InlineData(new string[] { "verblijfplaatsBinnenland.verblijfadres.postcode" }, new string[] { "verblijfplaats.verblijfadres.postcode" })]
        public void VerblijfplaatsBinnenland(IEnumerable<string> input, IEnumerable<string> expected)
        {
            input.ReplaceDatumWaardeTabelVerblijfplaatsBinnenlandPropertyFieldPaths().Should().BeEquivalentTo(expected);
        }
    }
}
