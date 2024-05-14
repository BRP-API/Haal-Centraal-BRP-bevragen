# language: nl

Functionaliteit: Als gebruiker van de API wil ik geen onbekend waardes ontvangen binnen het adres
  zodat ik deze niet hoef te (kunnen) interpreteren en ik geen code voor hoef te schrijven om deze situatie af te vangen

  Wanneer in de registratie specifieke waarden gereserveerd zijn voor een onbekende waarde, worden deze waarden niet doorgegeven in de API.
  Wanneer een element in de registratie een standaardwaarde heeft, die betekent dat de waarde onbekend is, wordt het corresponderende veld niet opgenomen in de response.

Regel: Niet leveren van de standaard/onbekend waarde van een adres veld
  Het gaat om de volgende properties en standaardwaardes van de persoon:
  | property                                   | standaardwaarde  |
  | ------------------------------------------ | ---------------- |
  | straatnaam (11.10)                         | .                |
  | huisnummer (11.20)                         | 0                |
  | woonplaats (11.70)                         | .                |
  | identificatiecode nummeraanduiding (11.90) | 0000000000000000 |
  | identificatiecode verblijfplaats (11.80)   | 0000000000000000 |

  Scenario: onbekend waarde "." voor straatnaam 
    Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | straatnaam (11.10)   | .      |
    | huisnummer (11.20)   | 1      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000164                                    |
    | fields              | verblijfplaats.verblijfadres.korteStraatnaam |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens


  Scenario: onbekend waarde "0" voor huisnummer
    Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde     |
    | gemeentecode (92.10) | 0518       |
    | straatnaam (11.10)   | een straat |
    | huisnummer (11.20)   | 0          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000176                               |
    | fields              | verblijfplaats.verblijfadres.huisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Abstract Scenario: onbekend waarde "<waarde>" voor <element>
   Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens   
    | naam                 | waarde     |
    | gemeentecode (92.10) | 0344       |
    | straatnaam (11.10)   | een straat |
    | <element>            | <waarde>   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000188                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | field                                           | element                                    | waarde           |
    | verblijfplaats.nummeraanduidingIdentificatie    | identificatiecode nummeraanduiding (11.90) | 0000000000000000 |
    | verblijfplaats.adresseerbaarObjectIdentificatie | identificatiecode verblijfplaats (11.80)   | 0000000000000000 |

  Scenario: onbekend waarde "." voor woonplaats (11.70)
   Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens   
    | naam                 | waarde     |
    | gemeentecode (92.10) | 0344       |
    | straatnaam (11.10)   | een straat |
    | woonplaats (11.70)   | .          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000188                               |
    | fields              | verblijfplaats.verblijfadres.woonplaats |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Scenario: volledig onbekende datum aanvang adreshouding in verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000371' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | functie adres (10.10)              | W        |
    | datum aanvang adreshouding (10.30) | 00000000 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens   
    | naam                 | waarde     |
    | gemeentecode (92.10) | 0344       |
    | straatnaam (11.10)   | een straat |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000371                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                 | waarde        |
    | type                 | Adres         |
    | datumVan.type        | DatumOnbekend |
    | datumVan.onbekend    | true          |
    | datumVan.langFormaat | onbekend      |
