# language: nl

@gba @autorisatie
Functionaliteit: Autorisatie voor naam

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                                 | waarde  |
      | voornamen (02.10)                    | Pieter  |
      | adellijke titel of predicaat (02.20) | JH      |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      | geslachtsaanduiding (04.10)          | M       |
      | aanduiding naamgebruik (61.10)       | E       |


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
      | fields                                    | ad hoc rubrieken              | missende autorisatie |
      | naam.voornamen                            | 10120 10220 10230 10240 16110 | 10210                |
      | naam.adellijkeTitelPredicaat              | 10120 10210 10230 10240 16110 | 10220                |
      | naam.adellijkeTitelPredicaat.code         | 10120 10210 10230 10240 16110 | 10220                |
      | naam.adellijkeTitelPredicaat.omschrijving | 10120 10210 10230 10240 16110 | 10220                |
      | naam.voorvoegsel                          | 10120 10210 10220 10240 16110 | 10230                |
      | naam.geslachtsnaam                        | 10120 10210 10220 10230 16110 | 10240                |
      | naam.aanduidingNaamgebruik                | 10120 10210 10220 10230 10240 | 16110                |

    @fout-case
    Abstract Scenario: Afnemer vraagt om hele groep naam en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam                            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                    | missende autorisatie |
      | 10120 10220 10230 10240 10410 16110 | 10210                |
      | 10120 10210 10230 10240 10410 16110 | 10220                |
      | 10120 10210 10220 10240 10410 16110 | 10230                |
      | 10120 10210 10220 10230 10410 16110 | 10240                |
      | 10120 10210 10220 10230 10240 16110 | 10410                |
      | 10120 10210 10220 10230 10240 10410 | 16110                |


  Rule: Wanneer met fields gevraagd wordt om voorletters en de gebruiker is niet geautoriseerd voor voornamen, wordt een foutmelding gegeven

    Scenario: Afnemer vraagt om naam.voorletters en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210                     | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam.voorletters                |
      Dan heeft de response 1 persoon

    @fout-case
    Scenario: Afnemer vraagt om naam.voorletters en is niet geautoriseerd voor 10210
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10220 10230 10240         | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam.voorletters                |
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
      | Rubrieknummer ad hoc (35.95.60)     | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210 10220 10230 10240 10410 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam.volledigeNaam              |
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
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam.volledigeNaam              |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken              | missende autorisatie |
      | 10120 10220 10230 10240 10410 | 10210                |
      | 10120 10210 10230 10240 10410 | 10220                |
      | 10120 10210 10220 10240 10410 | 10230                |
      | 10120 10210 10220 10230 10410 | 10240                |
      | 10120 10210 10220 10230 10240 | 10410                |
