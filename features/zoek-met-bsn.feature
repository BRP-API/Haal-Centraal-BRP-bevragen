#language: nl

@ready @post-assert
Functionaliteit: Zoek met burgerservicenummer(s)

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer |
    | 999999321           |
    | 999999322           |
    | 999999323           |
    | 999999324           |
    | 999999325           |

Rule: Er moet minimaal één burgerservicenummer worden opgegeven

  Scenario: Zoek met valide burgerservicenummer
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999321 |

  Scenario: Zoek met meerdere valide burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321,999999322,999999323   |
    | fields              | burgerservicenummer             |
    Dan heeft de response 3 personen
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999321 |
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999322 |
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999323 |

  @fout-case
  Scenario: Zoek zonder burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                          |
    | type   | RaadpleegMetBurgerservicenummer |
    | fields | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                | reason                  |
    | required | burgerservicenummer | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | <burgerservicenummers>          |
    | fields              | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | <detail>                                                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason   |
    | <code> | <name> | <reason> |

    Voorbeelden:
    | burgerservicenummers | titel                                   | detail                                                 | code     | name                   | reason                                      |
    |                      | Zoek met leeg burgerservicenummer lijst | De foutieve parameter(s) zijn: burgerservicenummer.    | minItems | burgerservicenummer    | Array bevat minder dan 1 items.             |
    | 1234567890           | Zoek met ongeldig burgerservicenummer   | De foutieve parameter(s) zijn: burgerservicenummer[0]. | pattern  | burgerservicenummer[0] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

  @fout-case
  Scenario: burgerservicenummer parameter is geen array
    Als personen wordt gezocht met de volgende parameters
    | naam                             | waarde                          |
    | type                             | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer (als string) | 999994086                       |
    | fields                           | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name                | reason                   |
    | array | burgerservicenummer | Parameter is geen array. |

  @fout-case
  Scenario: Zoek met meerdere ongeldige burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 1234567890,123456789,1234567890 |
    | fields              | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                         |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                    |
    | title    | Een of meerdere parameters zijn niet correct.                                  |
    | status   | 400                                                                            |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer[0], burgerservicenummer[2]. |
    | code     | paramsValidation                                                               |
    | instance | /haalcentraal/api/brp/personen                                                 |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name                   | reason                                      |
    | pattern | burgerservicenummer[0] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |
    | pattern | burgerservicenummer[2] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

Rule: Er mag maximaal 20 burgerservicenummers worden opgegeven

  @fout-case
  Scenario: Zoek met meer dan 20 burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                                                                                            |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                                                                                   |
    | burgerservicenummer | 999999321,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802 |
    | fields              | burgerservicenummer                                                                                                                                                                                               |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                | reason                         |
    | maxItems | burgerservicenummer | Array bevat meer dan 20 items. |


Rule: bij raadplegen van een persoon op burgerservicenummer van een afgevoerde persoonslijst wordt maximaal burgerservicenummer en opschorting bijhouding geleverd
  - wanneer reden opschorting bijhouding (07.67.20) is opgenomen met de waarde "F" (fout), wordt 
      - ten minste opschortingBijhouding.reden geleverd
      - en indien gevraagd in fields ook aNummer, burgerservicenummer en opschortingBijhouding.datum

  Scenario: Raadpleeg persoon op afgevoerde persoonslijst levert alleen gevraagde aNummer, burgerservicenummer en opschorting
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft de volgende 'persoon' gegevens
    | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 0123456789      | 000000024                   | William           | de                  | Vries                 | 20040526              | M                           |
    En de persoon heeft een ouder '1' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 000000036                   | Corry             | van                 | Zon                   | 19730428              | V                           |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 20040603                        |
    #En de persoon heeft de volgende 'verblijfplaats' gegevens
    #| gemeente van inschrijving (09.10) | functieAdres (10.10) | datum aanvang adreshouding (10.30) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
    #| 0518                              | W                    | 20170423                           | Spui               | 70                 | 1234AA           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                            |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                   |
    | burgerservicenummer | 000000024                                                                                                                                         |
    | fields              | aNummer, burgerservicenummer,naam,geboorte,leeftijd,geslacht,ouders,nationaliteiten,verblijfplaats,gemeenteVanInschrijving, opschortingBijhouding |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde           |
    | aNummer                                  | 0123456789       |
    | burgerservicenummer                      | 000000024        |
    | opschortingBijhouding.reden.code         | F                |
    | opschortingBijhouding.reden.omschrijving | fout             |
    | opschortingBijhouding.datum.type         | Datum            |
    | opschortingBijhouding.datum.datum        | 2022-08-29       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022 |

  Scenario: Raadpleeg persoon op afgevoerde persoonslijst levert alleen opschorting reden
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft de volgende 'persoon' gegevens
    | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 0123456789      | 000000024                   | William           | de                  | Vries                 | 20040526              | M                           |
    En de persoon heeft een ouder '1' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 000000036                   | Corry             | van                 | Zon                   | 19730428              | V                           |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 20040603                        |
    #En de persoon heeft de volgende 'verblijfplaats' gegevens
    #| gemeente van inschrijving (09.10) | functieAdres (10.10) | datum aanvang adreshouding (10.30) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
    #| 0518                              | W                    | 20170423                           | Spui               | 70                 | 1234AA           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                            |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                   |
    | burgerservicenummer | 000000024                                                                                                                                         |
    | fields              | naam,geboorte,leeftijd,geslacht,ouders,nationaliteiten,verblijfplaats,gemeenteVanInschrijving |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde           |
    | opschortingBijhouding.reden.code         | F                |
    | opschortingBijhouding.reden.omschrijving | fout             |