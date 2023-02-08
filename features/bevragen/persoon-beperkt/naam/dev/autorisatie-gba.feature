# language: nl

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
      | gemeente_code | postcode (11.60) | huisnummer (11.20) |
      | 0518          | 2628HJ           | 2                  |


  Rule: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven

    @fout-case
    Abstract Scenario: Afnemer vraagt om <fields> en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
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
      | fields                                    | ad hoc rubrieken                      | missende autorisatie |
      | naam.voornamen                            | 10120 10220 10230 10240 081120 081160 | 10210                |
      | naam.adellijkeTitelPredicaat              | 10120 10210 10230 10240 081120 081160 | 10220                |
      | naam.adellijkeTitelPredicaat.code         | 10120 10210 10230 10240 081120 081160 | 10220                |
      | naam.adellijkeTitelPredicaat.omschrijving | 10120 10210 10230 10240 081120 081160 | 10220                |
      | naam.voorvoegsel                          | 10120 10210 10220 10240 081120 081160 | 10230                |
      | naam.geslachtsnaam                        | 10120 10210 10220 10230 081120 081160 | 10240                |


  Rule: Wanneer met fields gevraagd wordt om voorletters en de gebruiker is niet geautoriseerd voor voornamen, wordt een foutmelding gegeven

    Scenario: Afnemer vraagt om naam.voorletters en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10210 081120 081160             | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2628HJ                      |
      | huisnummer | 2                           |
      | fields     | naam.voorletters            |
      Dan heeft de response 1 persoon

    @fout-case
    Scenario: Afnemer vraagt om naam.voorletters en is niet geautoriseerd voor 10210
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10220 10230 10240 081120 081160 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2628HJ                      |
      | huisnummer | 2                           |
      | fields     | naam.voorletters            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |


  Rule: Wanneer met fields gevraagd wordt om volledigeNaam en de gebruiker is niet geautoriseerd voor alle velden waaruit die wordt samengesteld, wordt een foutmelding gegeven

    Scenario: Afnemer vraagt om naam.volledigeNaam en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)             | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10210 10220 10230 10240 10410 081120 081160 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2628HJ                      |
      | huisnummer | 2                           |
      | fields     | naam.volledigeNaam          |
      Dan heeft de response 1 persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om naam.volledigeNaam en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2628HJ                      |
      | huisnummer | 2                           |
      | fields     | naam.volledigeNaam          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                      | missende autorisatie |
      | 10220 10230 10240 10410 081120 081160 | 10210                |
      | 10210 10230 10240 10410 081120 081160 | 10220                |
      | 10210 10220 10240 10410 081120 081160 | 10230                |
      | 10210 10220 10230 10410 081120 081160 | 10240                |
      | 10210 10220 10230 10240 081120 081160 | 10410                |
