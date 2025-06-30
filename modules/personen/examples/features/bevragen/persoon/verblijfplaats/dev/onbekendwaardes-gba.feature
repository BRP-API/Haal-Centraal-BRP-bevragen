# language: nl

@gba
Functionaliteit: verblijfplaats velden met standaard-waardes worden ongewijzigd geleverd 

  Wanneer in de registratie specifieke waarden gereserveerd zijn voor een onbekende waarde, worden deze waarden ongewijzigd geleverd door de GBA-API.
  Wanneer een element in de registratie een standaardwaarde heeft, die betekent dat de waarde onbekend is, wordt het corresponderende veld opgenomen in de response met de betreffende waarde. 


Regel: de volgende standaardwaarden worden ongewijzigd geleverd bij de verblijfplaats
  Het gaat om de volgende properties en standaardwaardes van de persoon:
  | property                                         | standaardwaarde  |
  | ------------------------------------------------ | ---------------- |
  | verblijfplaats.straat                            | .                |
  | verblijfplaats.huisnummer                        | 0                |
  | verblijfplaats.woonplaats                        | .                |
  | verblijfplaats.nummeraanduidingIdentificatie     | 0000000000000000 |
  | verblijfplaats.adresseerbaarObjectIdentificatie  | 0000000000000000 |
  | verblijfplaats.land                              | 0000             |

  Scenario: onbekend waarde "." voor straatnaam
    Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | straatnaam (11.10)   | .      |
    | huisnummer (11.20)   | 1      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000164                                    |
    | fields              | verblijfplaats.verblijfadres.korteStraatnaam |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde |
    | straat | .      |

  Scenario: onbekend waarde "0" voor huisnummer
    Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde     |
    | gemeentecode (92.10) | 0518       |
    | straatnaam (11.10)   | een straat |
    | huisnummer (11.20)   | 0          |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000176                               |
    | fields              | verblijfplaats.verblijfadres.huisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam       | waarde     |
    | straat     | een straat |
    | huisnummer | 0          |
 
  Abstract Scenario: onbekend waarde "<waarde>" voor <element>
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens   
    | naam                 | waarde     |
    | gemeentecode (92.10) | 0344       |
    | straatnaam (11.10)   | een straat |
    | <element>            | <waarde>   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000188                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam    | waarde     |
    | straat  | een straat |
    | <field> | <waarde>   |

    Voorbeelden:
    | fields                                          | field                            | element                                    | waarde           |
    | verblijfplaats.verblijfadres.woonplaats         | woonplaats                       | woonplaats (11.70)                         | .                |
    | verblijfplaats.nummeraanduidingIdentificatie    | nummeraanduidingIdentificatie    | identificatiecode nummeraanduiding (11.90) | 0000000000000000 |
    | verblijfplaats.adresseerbaarObjectIdentificatie | adresseerbaarObjectIdentificatie | identificatiecode verblijfplaats (11.80)   | 0000000000000000 |

Regel: datumvelden waarde "00000000" worden geleverd
  
  Scenario: volledig onbekende datum aanvang adreshouding in adres
    Gegeven de persoon met burgerservicenummer '000000371' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | functie adres (10.10)              | W        |
    | datum aanvang adreshouding (10.30) | 00000000 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens   
    | naam                 | waarde     |
    | gemeentecode (92.10) | 0344       |
    | straatnaam (11.10)   | een straat |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000371                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                     | waarde     |
    | straat                   | een straat |
    | datumAanvangAdreshouding | 00000000   |

  Scenario: volledig onbekende datum in verblijfplaats buitenland
    Gegeven de persoon met burgerservicenummer '000000383' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | land adres buitenland (13.10)          | 6014     |
    | datum aanvang adres buitenland (13.20) | 00000000 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000383                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                       |
    | land.code                   | 6014                         |
    | land.omschrijving           | Verenigde Staten van Amerika |
    | datumAanvangAdresBuitenland | 00000000                     |

Regel: wanneer er voor een code geen bijbehorende waarde voorkomt in de tabel, wordt alleen de code geleverd

  Scenario: code voor land adres buitenland (13.10) komt niet voor in de tabel Landen
    Gegeven de persoon met burgerservicenummer '000000255' heeft de volgende 'verblijfplaats' gegevens
    | land adres buitenland (13.10) |
    | 1234                          |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                            |
    | type                | RaadpleegMetBurgerservicenummer   |
    | burgerservicenummer | 000000255                         |
    | fields              | verblijfplaats.verblijfadres.land |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam      | waarde |
    | land.code | 1234   |

