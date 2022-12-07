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
    | identificatiecode verblijfplaats (11.80)   | 0599010000208579 |
    | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde          |
    | type                 | Adres           |
    | datumVan.type        | Datum           |
    | datumVan.datum       | 2015-08-08      |
    | datumVan.langFormaat | 8 augustus 2015 |

    Voorbeelden:
    | fields                  |
    | verblijfplaats.datumVan |

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
    | fields                               |
    | verblijfplaats.datumIngangGeldigheid |

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
    | fields                                   |
    | verblijfplaats.functieAdres              |
    | verblijfplaats.functieAdres.code         |
    | verblijfplaats.functieAdres.omschrijving |

  Abstract Scenario: 'identificatiecode verblijfplaats (11.80)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                             | waarde           |
    | type                             | Adres            |
    | adresseerbaarObjectIdentificatie | 0599010000208579 |

    Voorbeelden:
    | fields                                          |
    | verblijfplaats.adresseerbaarObjectIdentificatie |

  Abstract Scenario: 'identificatiecode nummeraanduiding (11.90)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                          | waarde           |
    | type                          | Adres            |
    | nummeraanduidingIdentificatie | 0599200000219678 |

    Voorbeelden:
    | fields                                       |
    | verblijfplaats.nummeraanduidingIdentificatie |

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
