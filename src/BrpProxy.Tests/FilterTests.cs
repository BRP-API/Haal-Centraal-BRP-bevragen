using BrpProxy.Validators;
using FluentAssertions;
using HaalCentraal.BrpProxy.Generated;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using Xunit;

namespace BrpProxy.Tests;

public static class JsonConvertExtensions
{
    public static string? ToJson(this object obj)
    {
        return obj != null ? JsonConvert.SerializeObject(obj) : null;
    }
}

public class FilterTests
{
    private readonly IList<Persoon> personen = new List<Persoon>
    {
        new Persoon
        {
            Burgerservicenummer = "12345",
            Naam = new NaamPersoon
            {
                Geslachtsnaam = "Doe",
                Voornamen = "John"
            },
            Geboorte = new Geboorte
            {
                Datum = new VolledigeDatum
                {
                    Datum = DateTime.Today
                },
                InOnderzoek = new GeboorteInOnderzoek
                {
                    Datum = true,
                    DatumIngangOnderzoek = new VolledigeDatum
                    {
                        Datum = DateTime.Today
                    }
                }
            },
            Partners = new Collection<Partner>
            {
                new Partner
                {
                    Burgerservicenummer = "12345"
                },
                new Partner
                {
                    Burgerservicenummer = "23456"
                }
            },
            Ouders = new Collection<Ouder>
            {
                new Ouder
                {
                    Burgerservicenummer = "12345"
                },
                new Ouder
                {
                    Burgerservicenummer = "23456"
                }
            },
            Nationaliteiten = new Collection<AbstractNationaliteit>
            {
                new NationaliteitBekend
                {
                    Nationaliteit = new Waardetabel{ Code = "1"}
                },
                new NationaliteitBekend
                {
                    Nationaliteit = new Waardetabel { Code = "2"}
                },
                new BehandeldAlsNederlander
                {
                    RedenOpname = new Waardetabel{ Code= "3"}
                },
                new VastgesteldNietNederlander
                {
                    RedenOpname= new Waardetabel{ Code= "4"}
                }
            },
            Kinderen = new Collection<Kind>
            {
                new Kind
                {
                    Burgerservicenummer = "12345",
                    Naam = new NaamGerelateerde
                    {
                        Geslachtsnaam = "Doe"
                    }
                },
                new Kind
                {
                    Burgerservicenummer = "23456"
                }
            },
            Verblijfplaats = new Adres
            {
                Verblijfadres = new VerblijfadresBinnenland
                {
                    Postcode = "2628HJ",
                    Huisnummer = 2
                }
            },
            Gezag = new Collection<AbstractGezagsrelatie>
            {
                new TweehoofdigOuderlijkGezag
                {
                    Minderjarige = new Minderjarige
                    {
                        Burgerservicenummer = "12345",
                    },
                    Ouders = new Collection<GezagOuder>
                    {
                        new GezagOuder
                        {
                            Burgerservicenummer = "23456"
                        }
                    }
                }
            }
        },
        new Persoon
        {
            Burgerservicenummer = "23456",
            Naam = new NaamPersoon
            {
                Geslachtsnaam = "Doe",
                Voornamen = "John"
            },
        }
    };
    
    [Fact]
    public void FilterSimpleProperty()
    {
        personen[0].Filter(new[] { "burgerservicenummer" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Burgerservicenummer = "12345"
            }
            .ToJson());
    }

    [Fact]
    public void FilterComplexProperty()
    {
        personen[0].Filter(new[] { "naam" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Naam = new NaamPersoon
                {
                    Geslachtsnaam = "Doe",
                    Voornamen = "John"
                }
            }
            .ToJson());
    }

    [Fact]
    public void FilterMultipleProperties()
    {
        personen[0].Filter(new[] { "naam", "burgerservicenummer" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Burgerservicenummer = "12345",
                Naam = new NaamPersoon
                {
                    Geslachtsnaam = "Doe",
                    Voornamen = "John"
                }
            }
            .ToJson());
    }

    [Fact]
    public void FilterMultiplePropertiesFromComplexProperty()
    {
        personen[0].Filter(new[] { "naam.geslachtsnaam", "naam.voornamen" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Naam = new NaamPersoon
                {
                    Geslachtsnaam = "Doe",
                    Voornamen = "John"
                }
            }.ToJson());
    }

    //[Fact]
    //public void FilterPropertyInMultipleNestedComplexProperty()
    //{
    //    personen[0].Filter(new[] { "geboorte.datum.datum" })!.ToJson()
    //        .Should().Be(
    //        new Persoon
    //        {
    //            Geboorte = new Geboorte
    //            {
    //                Datum = new VolledigeDatum
    //                {
    //                    Datum = DateTime.Today
    //                }
    //            }
    //        }.ToJson());
    //}

    //[Fact]
    //public void FilterMultiplePropertiesInMultipleNestedComplexProperty()
    //{
    //    personen[0].Filter(new[] { "geboorte.datum.datum", "geboorte.inOnderzoek.datum", "geboorte.inOnderzoek.datumIngangOnderzoek.datum" })!.ToJson()
    //        .Should().Be(
    //        new Persoon
    //        {
    //            Geboorte = new Geboorte
    //            {
    //                Datum = new VolledigeDatum
    //                {
    //                    Datum = DateTime.Today
    //                },
    //                InOnderzoek = new GeboorteInOnderzoek
    //                {
    //                    Datum = true,
    //                    DatumIngangOnderzoek = new VolledigeDatum
    //                    {
    //                        Datum = DateTime.Today
    //                    }
    //                }
    //            }
    //        }.ToJson());
    //}

    [Fact]
    public void FilterPartnersCollection()
    {
        personen[0].Filter(new[] { "partners.burgerservicenummer" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Partners = new Collection<Partner>
                {
                    new Partner
                    {
                        Burgerservicenummer = "12345"
                    },
                    new Partner
                    {
                        Burgerservicenummer = "23456"
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterOudersCollection()
    {
        personen[0].Filter(new[] { "ouders.burgerservicenummer" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Ouders = new Collection<Ouder>
                {
                    new Ouder
                    {
                        Burgerservicenummer = "12345"
                    },
                    new Ouder
                    {
                        Burgerservicenummer = "23456"
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterKindCollection()
    {
        personen[0].Filter(new[] { "kinderen" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Kinderen = new Collection<Kind>
                {
                    new Kind
                    {
                        Burgerservicenummer = "12345",
                        Naam = new NaamGerelateerde
                        {
                            Geslachtsnaam = "Doe"
                        }
                    },
                    new Kind
                    {
                        Burgerservicenummer = "23456"
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterPropertyInKindCollection()
    {
        personen[0].Filter(new[] { "kinderen.burgerservicenummer" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Kinderen = new Collection<Kind>
                {
                    new Kind
                    {
                        Burgerservicenummer = "12345"
                    },
                    new Kind
                    {
                        Burgerservicenummer = "23456"
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterNationaliteitenCollection()
    {
        personen[0].Filter(new[] { "nationaliteiten.type" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Nationaliteiten = new Collection<AbstractNationaliteit>
                {
                    new NationaliteitBekend(),
                    new NationaliteitBekend(),
                    new BehandeldAlsNederlander(),
                    new VastgesteldNietNederlander()
                }
            }.ToJson());
    }

    [Fact]
    public void FilterFieldInComplexPropertyInCombinatieMetFilterInOnderzoekComplexProperty()
    {
        var persoon = new Persoon
        {
            Verblijfplaats = new VerblijfplaatsBuitenland
            {
                Verblijfadres = new VerblijfadresBuitenland
                {
                    Land = new Waardetabel
                    {
                        Code = "1234",
                        Omschrijving = "een land"
                    }
                }
            }
        };

        persoon.Filter(new[] { "verblijfplaats.verblijfadres.land.omschrijving", "verblijfplaats.verblijfadres.inOnderzoek.land" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Verblijfplaats = new VerblijfplaatsBuitenland
                {
                    Verblijfadres = new VerblijfadresBuitenland
                    {
                        Land = new Waardetabel
                        {
                            Omschrijving = "een land"
                        }
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterCollection()
    {
        personen.FilterList(new[] { "burgerservicenummer" })!.ToJson()
            .Should().Be(
            new Collection<Persoon>()
            {
                new Persoon { Burgerservicenummer = "12345" },
                new Persoon { Burgerservicenummer = "23456" }
            }.ToJson());
    }

    [Fact]
    public void FilterNestedCollection()
    {
        personen.FilterList(new[] { "burgerservicenummer", "partners.burgerservicenummer" })!.ToJson()
            .Should().Be(
            new Collection<Persoon>()
            {
                new Persoon {
                    Burgerservicenummer = "12345",
                    Partners = new Collection<Partner>
                    {
                        new Partner { Burgerservicenummer = "12345" },
                        new Partner { Burgerservicenummer = "23456" }
                    }
                },
                new Persoon { Burgerservicenummer = "23456" }
            }.ToJson());
    }

    [Theory]
    [InlineData("gezag")]
    [InlineData("gezag.type")]
    [InlineData("gezag.ouder")]
    public void FilterGezag(string field)
    {
        personen[0].Filter(new[] { field })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Gezag = new Collection<AbstractGezagsrelatie>
                {
                    new TweehoofdigOuderlijkGezag
                    {
                        Minderjarige = new Minderjarige
                        {
                            Burgerservicenummer = "12345",
                        },
                        Ouders = new Collection<GezagOuder>
                        {
                            new GezagOuder
                            {
                                Burgerservicenummer = "23456"
                            }
                        }
                    }
                }
            }.ToJson());
    }
}
