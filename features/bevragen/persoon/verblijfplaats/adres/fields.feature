# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland (adres) velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | datum ingang geldigheid (85.10)    | 20220222 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                                       | waarde           |
    | gemeentecode (92.10)                       | 0518             |
    | straatnaam (11.10)                         | Spui             |
    | identificatiecode verblijfplaats (11.80)   | 0599010000208579 |
    | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde          |
    | type                 | Adres           |
    | datumVan.type        | Datum           |
    | datumVan.datum       | 2015-08-08      |
    | datumVan.langFormaat | 8 augustus 2015 |

    Voorbeelden:
    | fields                                        |
    | verblijfplaats.datumVan                       |
    | verblijfplaats.datumVan.type                  |
    | verblijfplaats.datumVan.datum                 |
    | verblijfplaats.datumVan.langFormaat           |
    | verblijfplaats.datumVan.jaar                  |
    | verblijfplaats.datumVan.maand                 |
    | verblijfplaats.datumVan.onbekend              |
    | verblijfplaatsBinnenland.datumVan             |
    | verblijfplaatsBinnenland.datumVan.type        |
    | verblijfplaatsBinnenland.datumVan.datum       |
    | verblijfplaatsBinnenland.datumVan.langFormaat |
    | verblijfplaatsBinnenland.datumVan.jaar        |
    | verblijfplaatsBinnenland.datumVan.maand       |
    | verblijfplaatsBinnenland.datumVan.onbekend    |
    
  Abstract Scenario: 'datum ingang geldigheid (85.10)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde           |
    | type                              | Adres            |
    | datumIngangGeldigheid.type        | Datum            |
    | datumIngangGeldigheid.datum       | 2022-02-22       |
    | datumIngangGeldigheid.langFormaat | 22 februari 2022 |

    Voorbeelden:
    | fields                                                     |
    | verblijfplaats.datumIngangGeldigheid                       |
    | verblijfplaats.datumIngangGeldigheid.type                  |
    | verblijfplaats.datumIngangGeldigheid.datum                 |
    | verblijfplaats.datumIngangGeldigheid.langFormaat           |
    | verblijfplaats.datumIngangGeldigheid.jaar                  |
    | verblijfplaats.datumIngangGeldigheid.maand                 |
    | verblijfplaats.datumIngangGeldigheid.onbekend              |
    | verblijfplaatsBinnenland.datumIngangGeldigheid             |
    | verblijfplaatsBinnenland.datumIngangGeldigheid.type        |
    | verblijfplaatsBinnenland.datumIngangGeldigheid.datum       |
    | verblijfplaatsBinnenland.datumIngangGeldigheid.langFormaat |
    | verblijfplaatsBinnenland.datumIngangGeldigheid.jaar        |
    | verblijfplaatsBinnenland.datumIngangGeldigheid.maand       |
    | verblijfplaatsBinnenland.datumIngangGeldigheid.onbekend    |
    
  Abstract Scenario: 'functie adres (10.10)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde    |
    | type                      | Adres     |
    | functieAdres.code         | W         |
    | functieAdres.omschrijving | woonadres |

    Voorbeelden:
    | fields                                             |
    | verblijfplaats.functieAdres                        |
    | verblijfplaats.functieAdres.code                   |
    | verblijfplaats.functieAdres.omschrijving           |
    | verblijfplaatsBinnenland.functieAdres              |
    | verblijfplaatsBinnenland.functieAdres.code         |
    | verblijfplaatsBinnenland.functieAdres.omschrijving |

  Scenario: 'identificatiecode verblijfplaats (11.80)' wordt gevraagd met field pad 'verblijfplaats.adresseerbaarObjectIdentificatie'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                          |
    | type                | RaadpleegMetBurgerservicenummer                 |
    | burgerservicenummer | 000000152                                       |
    | fields              | verblijfplaats.adresseerbaarObjectIdentificatie |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                             | waarde           |
    | type                             | Adres            |
    | adresseerbaarObjectIdentificatie | 0599010000208579 |

  Scenario: 'identificatiecode nummeraanduiding (11.90)' wordt gevraagd met field pad 'verblijfplaats.nummeraanduidingIdentificatie'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000152                                    |
    | fields              | verblijfplaats.nummeraanduidingIdentificatie |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                          | waarde           |
    | type                          | Adres            |
    | nummeraanduidingIdentificatie | 0599200000219678 |

  Scenario: alle adres velden wordt gevraagd met field pad 'verblijfplaats'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde           |
    | type                              | Adres            |
    | datumVan.type                     | Datum            |
    | datumVan.datum                    | 2015-08-08       |
    | datumVan.langFormaat              | 8 augustus 2015  |
    | datumIngangGeldigheid.type        | Datum            |
    | datumIngangGeldigheid.datum       | 2022-02-22       |
    | datumIngangGeldigheid.langFormaat | 22 februari 2022 |
    | functieAdres.code                 | W                |
    | functieAdres.omschrijving         | woonadres        |
    | adresseerbaarObjectIdentificatie  | 0599010000208579 |
    | nummeraanduidingIdentificatie     | 0599200000219678 |
    | verblijfadres.korteStraatnaam     | Spui             |
