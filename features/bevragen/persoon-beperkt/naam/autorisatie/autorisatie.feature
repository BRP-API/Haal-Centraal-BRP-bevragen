# language: nl

@autorisatie
Functionaliteit: Autorisatie voor naam in PersoonBeperkt

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                                 | waarde  |
      | voornamen (02.10)                    | Pieter  |
      | adellijke titel of predicaat (02.20) | JH      |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      | geslachtsaanduiding (04.10)          | M       |
      | aanduiding naamgebruik (61.10)       | E       |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) |
      | 0518                 | 2628HJ           | 2                  |


  Regel: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven

    @fout-case
    Abstract Scenario: Afnemer vraagt om <fields> en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken> 81120 81160  | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2628HJ                      |
      | huisnummer | 2                           |
      | fields     | <fields>                    |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                                    | ad hoc rubrieken                | missende autorisatie |
      | naam.voornamen                            | 10220 10230 10240 PANM01 PANM02 | 10210                |
      | naam.adellijkeTitelPredicaat              | 10210 10230 10240 PANM01 PANM02 | 10220                |
      | naam.adellijkeTitelPredicaat.code         | 10210 10230 10240 PANM01 PANM02 | 10220                |
      | naam.adellijkeTitelPredicaat.omschrijving | 10210 10230 10240 PANM01 PANM02 | 10220                |
      | naam.voorvoegsel                          | 10210 10220 10240 PANM01 PANM02 | 10230                |
      | naam.geslachtsnaam                        | 10210 10220 10230 PANM01 PANM02 | 10240                |
      | naam.voorletters                          | 10210 10220 10230 10240 PANM02  | PANM01               |
      | naam.volledigeNaam                        | 10210 10220 10230 10240 PANM01  | PANM02               |
      | naam                                      | 10220 10230 10240 PANM01 PANM02 | 10210                |
      | naam                                      | 10210 10230 10240 PANM01 PANM02 | 10220                |
      | naam                                      | 10210 10220 10240 PANM01 PANM02 | 10230                |
      | naam                                      | 10210 10220 10230 PANM01 PANM02 | 10240                |
      | naam                                      | 10210 10220 10230 10240 PANM02  | PANM01               |
      | naam                                      | 10210 10220 10230 10240 PANM01  | PANM02               |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)    | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <minimale autorisatie> 81120 81160 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2628HJ                      |
      | huisnummer | 2                           |
      | fields     | <fields>                    |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | fields                                    | minimale autorisatie                  |
      | naam.voornamen                            | 10210                                 |
      | naam.adellijkeTitelPredicaat              | 10220                                 |
      | naam.adellijkeTitelPredicaat.code         | 10220                                 |
      | naam.adellijkeTitelPredicaat.omschrijving | 10220                                 |
      | naam.voorvoegsel                          | 10230                                 |
      | naam.geslachtsnaam                        | 10240                                 |
      | naam.voorletters                          | PANM01                                |
      | naam.volledigeNaam                        | PANM02                                |
      | naam                                      | 10210 10220 10230 10240 PANM01 PANM02 |

