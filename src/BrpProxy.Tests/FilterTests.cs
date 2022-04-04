using BrpProxy.Validators;
using FluentAssertions;
using HaalCentraal.BrpProxy.Generated;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
            Partners = new Collection<AbstractPartner>
            {
                new Partner
                {
                    Burgerservicenummer = "12345"
                },
                new Partner
                {
                    Burgerservicenummer = "23456"
                },
                new OnbekendPartner
                {
                    IndicatieOnbekend = true
                }
            },
            Ouders = new Collection<AbstractOuder>
            {
                new Ouder
                {
                    Burgerservicenummer = "12345"
                },
                new Ouder
                {
                    Burgerservicenummer = "23456"
                },
                new OnbekendOuder
                {
                    IndicatieOnbekend = true
                }
            },
            Nationaliteiten = new Collection<AbstractNationaliteit>
            {
                new Nationaliteit
                {
                    Nationaliteit1 = new Waardetabel{ Code = "1"}
                },
                new Nationaliteit
                {
                    Nationaliteit1 = new Waardetabel { Code = "2"}
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
            Kinderen = new Collection<AbstractKind>
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
                },
                new OnbekendKind
                {
                    IndicatieOnbekend = true
                }
            },
            Verblijfplaats = new Adres
            {
                Postcode = "2628HJ",
                Huisnummer = 2
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

    [Fact]
    public void FilterPropertyInMultipleNestedComplexProperty()
    {
        personen[0].Filter(new[] { "geboorte.datum.datum" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Geboorte = new Geboorte
                {
                    Datum = new VolledigeDatum
                    {
                        Datum = DateTime.Today
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterMultiplePropertiesInMultipleNestedComplexProperty()
    {
        personen[0].Filter(new[] { "geboorte.datum.datum", "geboorte.inOnderzoek.datum", "geboorte.inOnderzoek.datumIngangOnderzoek.datum" })!.ToJson()
            .Should().Be(
            new Persoon
            {
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
                }
            }.ToJson());
    }

    [Fact]
    public void FilterPartnersCollection()
    {
        personen[0].Filter(new[] { "partners.burgerservicenummer" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Partners = new Collection<AbstractPartner>
                {
                    new Partner
                    {
                        Burgerservicenummer = "12345"
                    },
                    new Partner
                    {
                        Burgerservicenummer = "23456"
                    },
                    new OnbekendPartner
                    {
                        IndicatieOnbekend = true
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
                Ouders = new Collection<AbstractOuder>
                {
                    new Ouder
                    {
                        Burgerservicenummer = "12345"
                    },
                    new Ouder
                    {
                        Burgerservicenummer = "23456"
                    },
                    new OnbekendOuder
                    {
                        IndicatieOnbekend = true
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
                Kinderen = new Collection<AbstractKind>
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
                    },
                    new OnbekendKind
                    {
                        IndicatieOnbekend = true
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
                Kinderen = new Collection<AbstractKind>
                {
                    new Kind
                    {
                        Burgerservicenummer = "12345"
                    },
                    new Kind
                    {
                        Burgerservicenummer = "23456"
                    },
                    new OnbekendKind
                    {
                        IndicatieOnbekend = true
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterNationaliteitenCollection()
    {
        personen[0].Filter(new[] { "nationaliteiten.nationaliteit1" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Nationaliteiten = new Collection<AbstractNationaliteit>
                {
                    new Nationaliteit
                    {
                        Nationaliteit1 = new Waardetabel{ Code = "1"}
                    },
                    new Nationaliteit
                    {
                        Nationaliteit1 = new Waardetabel { Code = "2"}
                    },
                    new BehandeldAlsNederlander
                    {
                    },
                    new VastgesteldNietNederlander
                    {
                    }
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
                Land = new Waardetabel
                {
                    Code = "1234",
                    Omschrijving = "een land"
                }
            }
        };

        persoon.Filter(new[] { "verblijfplaats.land.omschrijving", "verblijfplaats.inOnderzoek.land" })!.ToJson()
            .Should().Be(
            new Persoon
            {
                Verblijfplaats = new VerblijfplaatsBuitenland
                {
                    Land = new Waardetabel
                    {
                        Omschrijving = "een land"
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
                    Partners = new Collection<AbstractPartner>
                    {
                        new Partner { Burgerservicenummer = "12345" },
                        new Partner { Burgerservicenummer = "23456" },
                        new OnbekendPartner { IndicatieOnbekend = true}
                    }
                },
                new Persoon { Burgerservicenummer = "23456" }
            }.ToJson());
    }
}
