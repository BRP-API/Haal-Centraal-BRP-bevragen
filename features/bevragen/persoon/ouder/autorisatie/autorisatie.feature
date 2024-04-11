# language: nl

@autorisatie
Functionaliteit: autorisatie oudergegevens Persoon

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | voornamen (02.10) |
      | Lisette           |

  Rule: Voor het vragen van ouderaanduiding met fields, moet de afnemer geautoriseerd zijn voor ten minste één gegeven van ouder 1 én ten minste één gegeven van ouder 2 uit de groepen 01, 02, 03, 04 en/of 62.
    De impliciete autorisatie voor het ontvangen van inOnderzoek op oudergegevens wordt voor het ouderAanduiding veld niet meegenomen.

    @fout-case
    Abstract Scenario: Afnemer is <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders.ouderAanduiding          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken              | missende autorisatie                                            |
      | 10120 10210 10220 10230 10240 | niet geautoriseerd voor oudergegevens                           |
      | 10120 20210 20220 20230 20240 | niet geautoriseerd voor ouder 2                                 |
      | 10120 30210 30220 30230 30240 | niet geautoriseerd voor ouder 1                                 |
      | 10120 28510 28610 38510 38610 | niet geautoriseerd voor oudergegevens in groep 1, 2, 3, 4 of 62 |

    Abstract Scenario: Afnemer is wel geautoriseerd voor <autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders.ouderAanduiding          |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | ad hoc rubrieken               | autorisatie                                                  |
      | 10120 20120 30120              | exact 1 gegeven uit groep 01                                 |
      | 10120 20240 30240              | exact 1 gegeven uit groep 02                                 |
      | 10120 20310 30310              | exact 1 gegeven uit groep 03                                 |
      | 10120 20410 30410              | exact 1 gegeven uit groep 04                                 |
      | 10120 26210 36210              | exact 1 gegeven uit groep 62                                 |
      | 10120 20110 30110              | A-nummer uit groep 01 dat niet voorkomt in de resource       |
      | 10120 20310 30210              | exact 1 gegeven van ouder 1 en 1 ander gegeven van ouder 2   |
      | 10120 20120 20240 30310 306210 | meerdere gegevens van ouder 1 en andere gegevens van ouder 2 |
      | 10120 PAOU01                   | alleen voorletters van ouder(s)                              |

      
  Rule: Vragen met fields om een gegeven van ouders, wanneer de afnemer niet geautoriseerd is voor dan gegeven van ouder 1 én van ouder 2, geeft een foutmelding

    Abstract Scenario: Afnemer vraagt ouders.<fields> en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders.<fields>                 |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | ad hoc rubrieken                                       | fields                                              |
      | 20120 30120                                            | burgerservicenummer                                 |
      | 20210 30210                                            | naam.voornamen                                      |
      | 20220 30220                                            | naam.adellijkeTitelPredicaat                        |
      | 20220 30220                                            | naam.adellijkeTitelPredicaat.code                   |
      | 20220 30220                                            | naam.adellijkeTitelPredicaat.omschrijving           |
      | 20220 30220                                            | naam.adellijkeTitelPredicaat.soort                  |
      | 20230 30230                                            | naam.voorvoegsel                                    |
      | 20240 30240                                            | naam.geslachtsnaam                                  |
      | PAOU01                                                 | naam.voorletters                                    |
      | 20210 20220 20230 20240 30210 30220 30230 30240 PAOU01 | naam                                                |
      | 20310 30310                                            | geboorte.datum                                      |
      | 20310 30310                                            | geboorte.datum.type                                 |
      | 20310 30310                                            | geboorte.datum.datum                                |
      | 20310 30310                                            | geboorte.datum.langFormaat                          |
      | 20310 30310                                            | geboorte.datum.jaar                                 |
      | 20310 30310                                            | geboorte.datum.maand                                |
      | 20310 30310                                            | geboorte.datum.onbekend                             |
      | 20320 30320                                            | geboorte.plaats                                     |
      | 20320 30320                                            | geboorte.plaats.code                                |
      | 20320 30320                                            | geboorte.plaats.omschrijving                        |
      | 20330 30330                                            | geboorte.land                                       |
      | 20330 30330                                            | geboorte.land.code                                  |
      | 20330 30330                                            | geboorte.land.omschrijving                          |
      | 20310 20320 20330 30310 30320 30330                    | geboorte                                            |
      | 20410 30410                                            | geslacht                                            |
      | 20410 30410                                            | geslacht.code                                       |
      | 20410 30410                                            | geslacht.omschrijving                               |
      | 26210 36210                                            | datumIngangFamilierechtelijkeBetrekking             |
      | 26210 36210                                            | datumIngangFamilierechtelijkeBetrekking.type        |
      | 26210 36210                                            | datumIngangFamilierechtelijkeBetrekking.datum       |
      | 26210 36210                                            | datumIngangFamilierechtelijkeBetrekking.langFormaat |
      | 26210 36210                                            | datumIngangFamilierechtelijkeBetrekking.jaar        |
      | 26210 36210                                            | datumIngangFamilierechtelijkeBetrekking.maand       |
      | 26210 36210                                            | datumIngangFamilierechtelijkeBetrekking.onbekend    |

    @fout-case
    Abstract Scenario: Afnemer is <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 000000024                                      |
      | fields              | ouders.datumIngangFamilierechtelijkeBetrekking |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken | missende autorisatie                                                  |
      | 20240 30240      | niet geautoriseerd voor dit gegeven (wel voor een ander oudergegeven) |
      | 26210            | niet geautoriseerd voor ouder 2                                       |
      | 36210            | niet geautoriseerd voor ouder 1                                       |

    @fout-case
    Abstract Scenario: Afnemer is niet geautoriseerd voor <fields>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders.<fields>                 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                                                                                         | ontbrekende autorisatie | fields                                              |
      | 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20120                   | burgerservicenummer                                 |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 30120                   | burgerservicenummer                                 |
      | 20120 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20210                   | naam.voornamen                                      |
      | 20120 20210 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20220                   | naam.adellijkeTitelPredicaat                        |
      | 20120 20210 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20220                   | naam.adellijkeTitelPredicaat.code                   |
      | 20120 20210 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20220                   | naam.adellijkeTitelPredicaat.omschrijving           |
      | 20120 20210 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20220                   | naam.adellijkeTitelPredicaat.soort                  |
      | 20120 20210 20220 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20230                   | naam.voorvoegsel                                    |
      | 20120 20210 20220 20230 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20240                   | naam.geslachtsnaam                                  |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 30210                   | naam.voornamen                                      |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 30220                   | naam.adellijkeTitelPredicaat                        |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30240 30310 30320 30330 30410 36210 PAOU01 | 30230                   | naam.voorvoegsel                                    |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30310 30320 30330 30410 36210 PAOU01 | 30240                   | naam.geslachtsnaam                                  |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210  | PAOU01                  | naam.voorletters                                    |
      | 20120 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20210                   | naam                                                |
      | 20120 20210 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20220                   | naam                                                |
      | 20120 20210 20220 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20230                   | naam                                                |
      | 20120 20210 20220 20230 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20240                   | naam                                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 30210                   | naam                                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 30220                   | naam                                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30240 30310 30320 30330 30410 36210 PAOU01 | 30230                   | naam                                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30310 30320 30330 30410 36210 PAOU01 | 30240                   | naam                                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210  | PAOU01                  | naam                                                |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte.datum                                      |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte.datum.type                                 |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte.datum.datum                                |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte.datum.langFormaat                          |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte.datum.jaar                                 |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte.datum.maand                                |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte.datum.onbekend                             |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte.datum                                      |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte.datum.type                                 |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte.datum.datum                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte.datum.langFormaat                          |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte.datum.jaar                                 |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte.datum.maand                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte.datum.onbekend                             |
      | 20120 20210 20220 20230 20240 20310 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20320                   | geboorte.plaats                                     |
      | 20120 20210 20220 20230 20240 20310 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20320                   | geboorte.plaats.code                                |
      | 20120 20210 20220 20230 20240 20310 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20320                   | geboorte.plaats.omschrijving                        |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30330 30410 36210 PAOU01 | 30320                   | geboorte.plaats                                     |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30330 30410 36210 PAOU01 | 30320                   | geboorte.plaats.code                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30330 30410 36210 PAOU01 | 30320                   | geboorte.plaats.omschrijving                        |
      | 20120 20210 20220 20230 20240 20310 20320 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20330                   | geboorte.land                                       |
      | 20120 20210 20220 20230 20240 20310 20320 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20330                   | geboorte.land.code                                  |
      | 20120 20210 20220 20230 20240 20310 20320 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20330                   | geboorte.land.omschrijving                          |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30410 36210 PAOU01 | 30330                   | geboorte.land                                       |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30410 36210 PAOU01 | 30330                   | geboorte.land.code                                  |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30410 36210 PAOU01 | 30330                   | geboorte.land.omschrijving                          |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte                                            |
      | 20120 20210 20220 20230 20240 20310 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20320                   | geboorte                                            |
      | 20120 20210 20220 20230 20240 20310 20320 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20330                   | geboorte                                            |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte                                            |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30330 30410 36210 PAOU01 | 30320                   | geboorte                                            |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30410 36210 PAOU01 | 30330                   | geboorte                                            |
      | 20120 20210 20220 20230 20240 20310 20320 20330 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20410                   | geslacht                                            |
      | 20120 20210 20220 20230 20240 20310 20320 20330 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20410                   | geslacht.code                                       |
      | 20120 20210 20220 20230 20240 20310 20320 20330 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20410                   | geslacht.omschrijving                               |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 36210 PAOU01 | 30410                   | geslacht                                            |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 36210 PAOU01 | 30410                   | geslacht.code                                       |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 36210 PAOU01 | 30410                   | geslacht.omschrijving                               |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 26210                   | datumIngangFamilierechtelijkeBetrekking             |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 26210                   | datumIngangFamilierechtelijkeBetrekking.type        |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 26210                   | datumIngangFamilierechtelijkeBetrekking.datum       |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 26210                   | datumIngangFamilierechtelijkeBetrekking.langFormaat |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 26210                   | datumIngangFamilierechtelijkeBetrekking.jaar        |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 26210                   | datumIngangFamilierechtelijkeBetrekking.maand       |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 26210                   | datumIngangFamilierechtelijkeBetrekking.onbekend    |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 PAOU01 | 36210                   | datumIngangFamilierechtelijkeBetrekking             |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 PAOU01 | 36210                   | datumIngangFamilierechtelijkeBetrekking.type        |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 PAOU01 | 36210                   | datumIngangFamilierechtelijkeBetrekking.datum       |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 PAOU01 | 36210                   | datumIngangFamilierechtelijkeBetrekking.langFormaat |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 PAOU01 | 36210                   | datumIngangFamilierechtelijkeBetrekking.jaar        |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 PAOU01 | 36210                   | datumIngangFamilierechtelijkeBetrekking.maand       |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 PAOU01 | 36210                   | datumIngangFamilierechtelijkeBetrekking.onbekend    |

    Scenario: Afnemer vraagt hele groep ouders en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                                                                                      | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders                          |
      Dan heeft de response 1 persoon

    @fout-case
    Abstract Scenario: Afnemer is niet geautoriseerd voor ouders door ontbrekende autorisatie voor <niet geautoriseerd veld>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders                          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                                                                                         | ontbrekende autorisatie | niet geautoriseerd veld                 |
      | 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20120                   | burgerservicenummer                     |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 30120                   | burgerservicenummer                     |
      | 20120 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20210                   | naam                                    |
      | 20120 20210 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20220                   | naam                                    |
      | 20120 20210 20220 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20230                   | naam                                    |
      | 20120 20210 20220 20230 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20240                   | naam                                    |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 30210                   | naam                                    |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 30220                   | naam                                    |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30240 30310 30320 30330 30410 36210 PAOU01 | 30230                   | naam                                    |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30310 30320 30330 30410 36210 PAOU01 | 30240                   | naam                                    |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210  | PAOU01                  | naam                                    |
      | 20120 20210 20220 20230 20240 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20310                   | geboorte                                |
      | 20120 20210 20220 20230 20240 20310 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20320                   | geboorte                                |
      | 20120 20210 20220 20230 20240 20310 20320 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20330                   | geboorte                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30320 30330 30410 36210 PAOU01 | 30310                   | geboorte                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30330 30410 36210 PAOU01 | 30320                   | geboorte                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30410 36210 PAOU01 | 30330                   | geboorte                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 20410                   | geslacht                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 36210 PAOU01 | 30410                   | geslacht                                |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 PAOU01 | 26210                   | datumIngangFamilierechtelijkeBetrekking |
      | 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 30120 30210 30220 30230 30240 30310 30320 30330 30410 PAOU01 | 36210                   | datumIngangFamilierechtelijkeBetrekking |
