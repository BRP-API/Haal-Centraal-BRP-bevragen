# language: nl


Functionaliteit: properties die gevuld zijn met standaard-waardes worden ongewijzigd geleverd voor de verblijfplaats. 

  Wanneer in de registratie specifieke waarden gereserveerd zijn voor een onbekende waarde, worden deze waarden ongewijzigd geleverd door de GBA-API.
  Wanneer een element in de registratie een standaardwaarde heeft, die betekent dat de waarde onbekend is, wordt het corresponderende veld opgenomen in de response met de betreffende waarde. 


Rule: de volgende standaardwaarden worden ongewijzigd geleverd bij de verblijfplaats
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
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000164                           |
    | fields              | burgerservicenummer,verblijfplaats  |
    Dan heeft de response een persoon met de volgende gegevens 
    | naam                | waarde    |
    | burgerservicenummer | 000000164 | 
    En heeft de persoon alleen de volgende 'verblijfplaats' gegevens
    | naam                      | waarde    |
    | functieAdres.code         | W         |
    | functieAdres.omschrijving | woonadres |
    | straat                    | .         |
    | huisnummer                | 1         |

  Scenario: onbekend waarde "0" voor huisnummer
    Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde      |
    | gemeente_code      | 0518        |
    | straatnaam (11.10) | een straat  |
    | huisnummer (11.20) | 0           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000176                           |
    | fields              | burgerservicenummer,verblijfplaats  |
    Dan heeft de response een persoon met de volgende gegevens 
    | naam                | waarde    |
    | burgerservicenummer | 000000176 | 
    En heeft de persoon alleen de volgende 'verblijfplaats' gegevens
    | naam                      | waarde     |
    | functieAdres.code         | W          |
    | functieAdres.omschrijving | woonadres  |
    | straat                    | een straat |
    | huisnummer                | 0          |
 
  Abstract Scenario: onbekend waarde "<waarde>" voor <element>
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |    
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens   
    | naam               | waarde     |
    | gemeente_code      | 0344       |
    | straatnaam (11.10) | een straat |
    | <element>          | <waarde>   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000188                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam    | waarde   |
    | <field> | <waarde> |

    Voorbeelden:
    | field                            | element                                    | waarde           |
    | woonplaats                       | woonplaats (11.70)                         | .                |
    | nummeraanduidingIdentificatie    | identificatiecode nummeraanduiding (11.90) | 0000000000000000 |
    | adresseerbaarObjectIdentificatie | identificatiecode verblijfplaats (11.80)   | 0000000000000000 |

Rule: datumvelden waarde "00000000" worden geleverd
  
  Scenario: volledig onbekende datum aanvang adreshouding in adres
    Gegeven de persoon met burgerservicenummer '000000371' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde     |
    | functie adres (10.10)              | W          |
    | datum aanvang adreshouding (10.30) | 00000000   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000371                               |
    | fields              | verblijfplaats.datumAanvangAdreshouding |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                     | waarde        |
    | datumAanvangAdreshouding | 00000000      |

  Scenario: volledig onbekende datum in verblijfplaats buitenland
    Gegeven de persoon met burgerservicenummer '000000383' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | land adres buitenland (13.10)          | 6014     |
    | datum aanvang adres buitenland (13.20) | 00000000 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                     |
    | type                | RaadpleegMetBurgerservicenummer            |
    | burgerservicenummer | 000000383                                  |
    | fields              | verblijfplaats.datumAanvangAdresBuitenland |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                        | waarde   |
    | datumAanvangAdresBuitenland | 00000000 |
