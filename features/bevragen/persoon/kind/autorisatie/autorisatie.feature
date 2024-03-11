# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van kindgegevens van Persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                                             | missende autorisatie | ad hoc rubrieken                                                         |
      | kinderen                                           | 90120                | 90210 90220 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen                                           | 90210                | 90120 90220 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen                                           | 90220                | 90120 90210 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen                                           | 90230                | 90120 90210 90220 90240 90310 90320 90330 PAKD01                         |
      | kinderen                                           | 90240                | 90120 90210 90220 90230 90310 90320 90330 PAKD01                         |
      | kinderen                                           | 90310                | 90120 90210 90220 90230 90240 90320 90330 PAKD01                         |
      | kinderen                                           | 90320                | 90120 90210 90220 90230 90240 90310 90330 PAKD01                         |
      | kinderen                                           | 90330                | 90120 90210 90220 90230 90240 90310 90320 PAKD01                         |
      | kinderen                                           | PAKD01               | 90120 90210 90220 90230 90240 90310 90320 90330                          |
      | kinderen.burgerservicenummer                       | 90120                | 90210 90220 90230 90240 90310 90320 90330 20120 30120 50120 PAKD01       |
      | kinderen.geboorte                                  | 90310                | 90120 90210 90220 90230 90240 90320 90330 PAKD01                         |
      | kinderen.geboorte                                  | 90320                | 90120 90210 90220 90230 90240 90310 90330 PAKD01                         |
      | kinderen.geboorte                                  | 90330                | 90120 90210 90220 90230 90240 90310 90320 PAKD01                         |
      | kinderen.geboorte.datum                            | 90310                | 90120 90210 90220 90230 90240 90320 90330 10210 20210 30210 50210 PAKD01 |
      | kinderen.geboorte.datum.langFormaat                | 90310                | 90120 90210 90220 90230 90240 90320 90330 PAKD01                         |
      | kinderen.geboorte.datum.type                       | 90310                | 90120 90210 90220 90230 90240 90320 90330 PAKD01                         |
      | kinderen.geboorte.datum.datum                      | 90310                | 90120 90210 90220 90230 90240 90320 90330 PAKD01                         |
      | kinderen.geboorte.datum.onbekend                   | 90310                | 90120 90210 90220 90230 90240 90320 90330 PAKD01                         |
      | kinderen.geboorte.datum.jaar                       | 90310                | 90120 90210 90220 90230 90240 90320 90330 PAKD01                         |
      | kinderen.geboorte.datum.maand                      | 90310                | 90120 90210 90220 90230 90240 90320 90330 PAKD01                         |
      | kinderen.geboorte.land                             | 90330                | 90120 90210 90220 90230 90240 90310 90320 10330 20330 30330 50330 PAKD01 |
      | kinderen.geboorte.land.code                        | 90330                | 90120 90210 90220 90230 90240 90310 90320 PAKD01                         |
      | kinderen.geboorte.land.omschrijving                | 90330                | 90120 90210 90220 90230 90240 90310 90320 PAKD01                         |
      | kinderen.geboorte.plaats                           | 90320                | 90120 90210 90220 90230 90240 90310 90330 PAKD01                         |
      | kinderen.geboorte.plaats.code                      | 90320                | 90120 90210 90220 90230 90240 90310 90330 PAKD01                         |
      | kinderen.geboorte.plaats.omschrijving              | 90320                | 90120 90210 90220 90230 90240 90310 90330 PAKD01                         |
      | kinderen.naam                                      | 90210                | 90120 90220 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen.naam                                      | 90220                | 90120 90210 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen.naam                                      | 90230                | 90120 90210 90220 90240 90310 90320 90330 PAKD01                         |
      | kinderen.naam                                      | 90240                | 90120 90210 90220 90230 90310 90320 90330 PAKD01                         |
      | kinderen.naam                                      | PAKD01               | 90120 90210 90220 90230 90240 90310 90320 90330                          |
      | kinderen.naam.adellijkeTitelPredicaat              | 90220                | 90120 90210 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen.naam.adellijkeTitelPredicaat.code         | 90220                | 90120 90210 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen.naam.adellijkeTitelPredicaat.omschrijving | 90220                | 90120 90210 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen.naam.adellijkeTitelPredicaat.soort        | 90220                | 90120 90210 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen.naam.geslachtsnaam                        | 90240                | 90120 90210 90220 90230 90310 90320 90330 10240 20240 30240 50240 PAKD01 |
      | kinderen.naam.voorletters                          | PAKD01               | 90120 90220 90230 90240 90310 90320 90330                                |
      | kinderen.naam.voornamen                            | 90210                | 90120 90220 90230 90240 90310 90320 90330 PAKD01                         |
      | kinderen.naam.voorvoegsel                          | 90230                | 90120 90210 90220 90240 90310 90320 90330 PAKD01                         |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | fields                                             | ad hoc rubrieken                                       |
      | kinderen                                           | 90120 90210 90220 90230 90240 90310 90320 90330 PAKD01 |
      | kinderen.burgerservicenummer                       | 90120                                                  |
      | kinderen.geboorte                                  | 90310 90320 90330                                      |
      | kinderen.geboorte.datum                            | 90310                                                  |
      | kinderen.geboorte.datum.langFormaat                | 90310                                                  |
      | kinderen.geboorte.datum.type                       | 90310                                                  |
      | kinderen.geboorte.datum.datum                      | 90310                                                  |
      | kinderen.geboorte.datum.onbekend                   | 90310                                                  |
      | kinderen.geboorte.datum.jaar                       | 90310                                                  |
      | kinderen.geboorte.datum.maand                      | 90310                                                  |
      | kinderen.geboorte.land                             | 90330                                                  |
      | kinderen.geboorte.land.code                        | 90330                                                  |
      | kinderen.geboorte.land.omschrijving                | 90330                                                  |
      | kinderen.geboorte.plaats                           | 90320                                                  |
      | kinderen.geboorte.plaats.code                      | 90320                                                  |
      | kinderen.geboorte.plaats.omschrijving              | 90320                                                  |
      | kinderen.naam                                      | 90210 90220 90230 90240 PAKD01                         |
      | kinderen.naam.adellijkeTitelPredicaat              | 90220                                                  |
      | kinderen.naam.adellijkeTitelPredicaat.code         | 90220                                                  |
      | kinderen.naam.adellijkeTitelPredicaat.omschrijving | 90220                                                  |
      | kinderen.naam.adellijkeTitelPredicaat.soort        | 90220                                                  |
      | kinderen.naam.geslachtsnaam                        | 90240                                                  |
      | kinderen.naam.voorletters                          | PAKD01                                                 |
      | kinderen.naam.voornamen                            | 90210                                                  |
      | kinderen.naam.voorvoegsel                          | 90230                                                  |