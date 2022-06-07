# language: nl

@proxy @post-assert
Functionaliteit: verblijfplaats binnenland

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 555550001                           |
    | fields              | verblijfplaats.verblijfadres.<naam> |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde   |
    | type                 | Adres    |
    | verblijfadres.<naam> | <waarde> |

    Voorbeelden:
    | gba naam                          | naam                         | waarde        |
    | straatnaam (11.10)                | korteNaam                    | Spui          |
    | naam openbare ruimte (11.15)      | straat                       | Spui          |
    | huisnummer (11.20)                | huisnummer                   | 123           |
    | huisletter (11.30)                | huisletter                   | a             |
    | huisnummertoevoeging (11.40)      | huisnummertoevoeging         | 2             |
    | aanduiding bij huisnummer (11.50) | aanduidingBijHuisnummer.code | to            |
    | postcode (11.60)                  | postcode                     | 1234AA        |
    | woonplaatsnaam (11.70)            | woonplaats                   | 's-Gravenhage |

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam               | waarde   |
    | straatnaam (11.10) | Spui     |
    | <gba naam>         | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde   |
    | type   | Adres    |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                                   | naam                             | waarde           |
    | functie adres (10.10)                      | functieAdres.code                | W                |
    | identificatiecode verblijfplaats (11.80)   | adresseerbaarObjectIdentificatie | 0599010000208579 |
    | identificatiecode nummeraanduiding (11.90) | nummeraanduidingIdentificatie    | 0599200000219678 |

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam               | waarde       |
    | straatnaam (11.10) | Spui         |
    | <gba naam>         | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam               | waarde         |
    | type               | Adres          |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                           | gba waarde | naam                  | waarde     | lang formaat     |
    | datum aanvang adreshouding (10.30) | 20220128   | datumVan              | 2022-01-28 | 28 januari 2022  |
    | datum ingang geldigheid (85.10)    | 20220222   | datumIngangGeldigheid | 2022-02-22 | 22 februari 2022 |

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld met onbekend waarde: '<gba naam>'
      Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde       |
    | naam openbare ruimte (11.15) | Spui         |
    | <gba naam>                   | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba naam                                 | gba waarde       | naam                             |
    | straatnaam (11.10)                       | .                | verblijfadres.straat             |
    | huisnummer (11.20)                       | 0                | verblijfadres.huisnummer         |
    | woonplaatsnaam (11.70)                   | .                | verblijfadres.woonplaats         |
    | adresseerbaarObjectIdentificatie (11.80) | 0000000000000000 | adresseerbaarObjectIdentificatie |
    | nummeraanduidingIdentificatie (11.90)    | 0000000000000000 | nummeraanduidingIdentificatie    |
