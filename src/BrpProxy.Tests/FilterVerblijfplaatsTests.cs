using BrpProxy.Middlewares;
using BrpProxy.Validators;
using FluentAssertions;
using HaalCentraal.BrpProxy.Generated;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;

namespace BrpProxy.Tests
{
    public class FilterVerblijfplaatsTests
    {
        private readonly IList<Persoon> personen = new List<Persoon>
        {
            new Persoon
            {
                Verblijfplaats = new Adres
                {
                    DatumIngangGeldigheid = new VolledigeDatum
                    {
                        Datum = new DateTimeOffset(2022, 12, 1, 0, 0, 0, TimeSpan.Zero)
                    },
                    FunctieAdres = new Waardetabel
                    {
                        Code = "W",
                        Omschrijving = "woonadres"
                    },
                    Verblijfadres = new VerblijfadresBinnenland
                    {
                        OfficieleStraatnaam = "Spui"
                    },
                    InOnderzoek = new AdresInOnderzoek
                    {
                        Type = true
                    }
                }
            },
            new Persoon
            {
                Verblijfplaats = new Locatie
                {
                    DatumIngangGeldigheid = new VolledigeDatum
                    {
                        Datum = new DateTimeOffset(2022, 12, 1, 0, 0, 0, TimeSpan.Zero)
                    },
                    FunctieAdres = new Waardetabel
                    {
                        Code = "W",
                        Omschrijving = "woonadres"
                    },
                    Verblijfadres = new VerblijfadresLocatie
                    {
                        Locatiebeschrijving = "Woonboot"
                    }
                }
            }
        };

        [Fact]
        public void FilterOneField()
        {
            personen[0].Filter(new[] { "verblijfplaats.datumIngangGeldigheid" })
                .ToJsonWithoutNullAndDefaultValues()
                .Should()
                .Be(new Persoon
                    {
                        Verblijfplaats = new Adres
                        {
                            DatumIngangGeldigheid = new VolledigeDatum
                            {
                                Datum = new DateTimeOffset(2022, 12, 1, 0, 0, 0, TimeSpan.Zero)
                            }
                        }
                    }
                .ToJsonWithoutNullAndDefaultValues());
        }

        [Fact]
        public void FilterTypeOfVerblijfplaatsShouldReturnEmptyAdres()
        {
            personen[0].Filter(new[] { "verblijfplaats.type"})
                .ToJsonWithoutNullAndDefaultValues()
                .Should()
                .Be(new Persoon
                {
                    Verblijfplaats = new Adres()
                }
                .ToJsonWithoutNullAndDefaultValues());
        }

        [Fact]
        public void FilterTypeOfVerblijfplaatsShouldReturnEmptyLocatie()
        {
            personen[1].Filter(new[] { "verblijfplaats.type" })
                .ToJsonWithoutNullAndDefaultValues()
                .Should()
                .Be(new Persoon
                {
                    Verblijfplaats = new Locatie()
                }
                .ToJsonWithoutNullAndDefaultValues());
        }

        [Fact]
        public void FilterInOnderzoekTypeProperty()
        {
            personen[0].Filter(new[] { "verblijfplaats.inOnderzoek.type" })
                .ToJsonWithoutNullAndDefaultValues()
                .Should()
                .Be(new Persoon
                {
                    Verblijfplaats = new Adres
                    {
                        InOnderzoek = new AdresInOnderzoek
                        {
                            Type = true
                        }
                    }
                }
                .ToJsonWithoutNullAndDefaultValues());
        }
    }
}
