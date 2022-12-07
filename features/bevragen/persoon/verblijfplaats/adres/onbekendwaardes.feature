# language: nl

@proxy @ready @post-assert
Functionaliteit: Als gebruiker van de API wil ik geen onbekend waardes ontvangen binnen het adres
  zodat ik deze niet hoef te (kunnen) interpreteren en ik geen code voor hoef te schrijven om deze situatie af te vangen

  Wanneer in de registratie specifieke waarden gereserveerd zijn voor een onbekende waarde, worden deze waarden niet doorgegeven in de API.
  Wanneer een element in de registratie een standaardwaarde heeft, die betekent dat de waarde onbekend is, wordt het corresponderende veld niet opgenomen in de response.

Rule: een veld wordt niet opgenomen wanneer het de standaardwaarde bevat
  Het gaat om de volgende properties en standaardwaardes van de persoon:
  | property                                         | standaardwaarde  |
  | ------------------------------------------------ | ---------------- |
  | verblijfplaats.straat                            | .                |
  | verblijfplaats.huisnummer                        | 0                |
  | verblijfplaats.woonplaats                        | .                |
  | verblijfplaats.nummeraanduidingIdentificatie     | 0000000000000000 |
  | verblijfplaats.adresseerbaarObjectIdentificatie  | 0000000000000000 |

    Scenario: onbekend waarde "." voor straat 
    Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | straatnaam (11.10) | .      |
    | huisnummer (11.20) | 1      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000164                           |
    | fields              | burgerservicenummer,verblijfplaats  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde       |   
    | burgerservicenummer | 000000164    |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam                      | waarde    |
    | type                      | Adres     |
    | verblijfadres.huisnummer  | 1         | 
    | functieAdres.code         | W         |
    | functieAdres.omschrijving | woonadres |

  Scenario: onbekend waarde "0" voor huisnummer
    Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde      |
    | gemeente_code      | 0518        |
    | straatnaam (11.10) | een straat  |
    | huisnummer (11.20) | 0           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000176                           |
    | fields              | burgerservicenummer,verblijfplaats  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde       |   
    | burgerservicenummer | 000000176    |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam                      | waarde     |
    | type                      | Adres      |
    | verblijfadres.straat      | een straat |
    | functieAdres.code         | W          |
    | functieAdres.omschrijving | woonadres  |

  Abstract Scenario: onbekend waarde "<waarde>" voor <element>
   Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |    
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens   
    | naam               | waarde     |
    | gemeente_code      | 0344       |
    | straatnaam (11.10) | een straat |
    | <element>          | <waarde>   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000188                       |
    | fields              | verblijfplaats.verblijfadres    |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                 | waarde     |
    | type                 | Adres      |
    | verblijfadres.straat | een straat |

    Voorbeelden:
    | field                                           | element                                    | waarde           |
    | verblijfplaats.verblijfadres.woonplaats         | woonplaats (11.70)                         | .                |
    | verblijfplaats.nummeraanduidingIdentificatie    | identificatiecode nummeraanduiding (11.90) | 0000000000000000 |
    | verblijfplaats.adresseerbaarObjectIdentificatie | identificatiecode verblijfplaats (11.80)   | 0000000000000000 |

  Scenario: volledig onbekende datum aanvang adreshouding in verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000371' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde     |
    | functie adres (10.10)              | W          |
    | datum aanvang adreshouding (10.30) | 00000000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000371                               |
    | fields              | verblijfplaats.datumVan                 |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                 |
    | type                 | VerblijfplaatsOnbekend |
    | datumVan.type        | DatumOnbekend          |
    | datumVan.onbekend    | true                   |
    | datumVan.langFormaat | onbekend               |