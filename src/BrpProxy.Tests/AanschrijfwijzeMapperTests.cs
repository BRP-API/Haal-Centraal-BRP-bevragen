using BrpProxy.Mappers;
using FluentAssertions;
using HaalCentraal.BrpProxy.Generated;
using Xunit;

namespace BrpProxy.Tests
{
    public class AanschrijfwijzeMapperTests
    {
        [Fact]
        public void PersoonMetPartnerZonderAanduidingNaamgebruikHeeftGeenAanschrijfwijzeNaam()
        {
            var persoon = new NaamPersoon
            {
                Geslachtsnaam = "Jansen",
                Partners = new[]
                {
                    new Partner
                    {
                        Naam = new NaamGerelateerde { Geslachtsnaam = "Aedel"}
                    }
                }
            };

            var actual = persoon.Aanschrijfwijze();

            actual.Should().NotBeNull();
            actual!.Naam.Should().BeNull();
        }

        [Fact]
        public void PersoonMetPartnerMetPredicaatZonderAanduidingNaamgebruikHeeftGeenAanschrijfwijzeNaam()
        {
            var persoon = new NaamPersoon
            {
                Geslachtsnaam = "Jansen",
                AdellijkeTitelPredicaat = new AdellijkeTitelPredicaatType { Code = "JH" },
                Partners = new[]
                {
                    new Partner
                    {
                        Naam = new NaamGerelateerde { Geslachtsnaam = "Aedel"}
                    }
                }
            };

            var actual = persoon.Aanschrijfwijze();

            actual.Should().NotBeNull();
            actual!.Naam.Should().BeNull();
        }

        [Fact]
        public void PersoonMetPartnerMetAdellijkeTitelZonderAanduidingNaamgebruikHeeftGeenAanschrijfwijzeNaam()
        {
            var persoon = new NaamPersoon
            {
                Geslachtsnaam = "Jansen",
                AdellijkeTitelPredicaat = new AdellijkeTitelPredicaatType { Code = "B" },
                Partners = new[]
                {
                    new Partner
                    {
                        Naam = new NaamGerelateerde { Geslachtsnaam = "Aedel"}
                    }
                }
            };

            var actual = persoon.Aanschrijfwijze();

            actual.Should().NotBeNull();
            actual!.Naam.Should().BeNull();
        }

        [Fact]
        public void PersoonMetPartnerMetHoffelijkheidstitelZonderAanduidingNaamgebruikHeeftGeenAanschrijfwijzeNaam()
        {
            var persoon = new NaamPersoon
            {
                Geslachtsnaam = "Jansen",
                Geslacht = new Waardetabel { Code = "V" },
                Partners = new[]
                {
                    new Partner
                    {
                        Naam = new NaamGerelateerde
                        {
                            Geslachtsnaam = "Aedel",
                            AdellijkeTitelPredicaat = new AdellijkeTitelPredicaatType { Code = "B" }
                        }
                    }
                }
            };

            var actual = persoon.Aanschrijfwijze();

            actual.Should().NotBeNull();
            actual!.Naam.Should().BeNull();
        }
    }
}
