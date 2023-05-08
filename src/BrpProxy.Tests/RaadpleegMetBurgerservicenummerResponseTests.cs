using BrpProxy.Middlewares;
using FluentAssertions;
using HaalCentraal.BrpProxy.Generated;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Xunit;

namespace BrpProxy.Tests
{
    public static partial class Helpers
    {
        public static string RemoveWhiteSpaces(this string s)
        {
            return Regex.Replace(s, @"\s+", "");
        }

        public static string ReplaceDoubleQuotesWithSingleQuotes(this string s)
        {
            return s.Replace('"', '\'');
        }
    }

    public class RaadpleegMetBurgerservicenummerResponseTests
    {
        [Fact]
        public void EmptyRaadpleegMetBurgerservicenummerResponseShouldBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse()
                .ToJsonWithoutNullAndDefaultValues()
                .ReplaceDoubleQuotesWithSingleQuotes()
                .Should()
                .Be(@"{
                        'type': 'RaadpleegMetBurgerservicenummer'
                      }"
                .RemoveWhiteSpaces());
        }

        [Fact]
        public void EmptyPersonenListShouldBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>()
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void EmptyPersoonShouldBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon()
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                        {}
                    ]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void EmptyAdresShouldBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon
                    {
                        Verblijfplaats = new Adres()
                    }
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                      {
                        'verblijfplaats':{
                          'type':'Adres'
                        }
                      }
                    ]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void EmptyAdresInOnderzoekShouldNotBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon
                    {
                        Verblijfplaats = new Adres
                        {
                            InOnderzoek = new AdresInOnderzoek()
                        }
                    }
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                      {
                        'verblijfplaats':{
                          'type':'Adres'
                        }
                      }
                    ]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void AdresInOnderzoekWithOnlyDatumIngangOnderzoekShouldNotBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon
                    {
                        Verblijfplaats = new Adres
                        {
                            InOnderzoek = new AdresInOnderzoek
                            {
                                DatumIngangOnderzoek = new VolledigeDatum
                                {
                                    Datum = new DateTimeOffset(2022,12,1,0,0,0,TimeSpan.Zero)
                                }
                            }
                        }
                    }
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                      {
                        'verblijfplaats':{
                          'type':'Adres'
                        }
                      }
                    ]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void AdresInOnderzoekWithOneOrMoreInOnderzoekPropertiesShouldBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon
                    {
                        Verblijfplaats = new Adres
                        {
                            InOnderzoek = new AdresInOnderzoek
                            {
                                DatumVan = true,
                                DatumIngangOnderzoek = new VolledigeDatum
                                {
                                    Datum = new DateTimeOffset(2022,12,1,0,0,0,TimeSpan.Zero)
                                }
                            }
                        }
                    }
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                      {
                        'verblijfplaats':{
                          'type':'Adres',
                          'inOnderzoek':{
                            'datumVan':true,
                            'datumIngangOnderzoek':{
                              'type':'Datum',
                              'datum':'2022-12-01'
                            }
                          }
                        }
                      }
                    ]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void EmptyVerblijfAdresShouldBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon
                    {
                        Verblijfplaats = new Adres
                        {
                            Verblijfadres = new VerblijfadresBinnenland()
                        }
                    }
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                      {
                        'verblijfplaats':{
                          'type':'Adres',
                          'verblijfadres':{}
                        }
                      }
                    ]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void EmptyVerblijfadresBinnenlandInOnderzoekShouldNotBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon
                    {
                        Verblijfplaats = new Adres
                        {
                            Verblijfadres = new VerblijfadresBinnenland
                            {
                                InOnderzoek = new VerblijfadresBinnenlandInOnderzoek()
                            }
                        }
                    }
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                      {
                        'verblijfplaats':{
                          'type':'Adres',
                          'verblijfadres':{}
                        }
                      }
                    ]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void VerblijfadresBinnenlandInOnderzoekWithOnlyDatumIngangOnderzoekShouldNotBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon
                    {
                        Verblijfplaats = new Adres
                        {
                            Verblijfadres = new VerblijfadresBinnenland
                            {
                                InOnderzoek = new VerblijfadresBinnenlandInOnderzoek
                                {
                                    DatumIngangOnderzoek = new VolledigeDatum
                                    {
                                        Datum = new DateTimeOffset(2022,12,1,0,0,0,TimeSpan.Zero)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                      {
                        'verblijfplaats':{
                          'type':'Adres',
                          'verblijfadres':{}
                        }
                      }
                    ]
                  }"
            .RemoveWhiteSpaces());
        }

        [Fact]
        public void VerblijfadresBinnenlandInOnderzoekWithOneOrMoreInOnderzoekPropertiesShouldBeSerialized()
        {
            new RaadpleegMetBurgerservicenummerResponse
            {
                Personen = new List<Persoon>
                {
                    new Persoon
                    {
                        Verblijfplaats = new Adres
                        {
                            Verblijfadres = new VerblijfadresBinnenland
                            {
                                InOnderzoek = new VerblijfadresBinnenlandInOnderzoek
                                {
                                    Huisnummer = true,
                                    DatumIngangOnderzoek = new VolledigeDatum
                                    {
                                        Datum = new DateTimeOffset(2022,12,1,0,0,0,TimeSpan.Zero)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .ToJsonWithoutNullAndDefaultValues()
            .ReplaceDoubleQuotesWithSingleQuotes()
            .Should()
            .Be(@"{
                    'type':'RaadpleegMetBurgerservicenummer',
                    'personen':[
                      {
                        'verblijfplaats':{
                          'type':'Adres',
                          'verblijfadres':{
                            'inOnderzoek':{
                              'huisnummer':true,
                              'datumIngangOnderzoek':{
                                'type':'Datum',
                                'datum':'2022-12-01'
                              }
                            }
                          }
                        }
                      }
                    ]
                  }"
            .RemoveWhiteSpaces());
        }
    }
}
