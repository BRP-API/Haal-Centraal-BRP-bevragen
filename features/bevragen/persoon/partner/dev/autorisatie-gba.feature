# language: nl

Functionaliteit: autorisatie partners

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'partner' met de volgende gegevens
      | naam                                                                | waarde    |
      | burgerservicenummer (01.20)                                         | 000000188 |
      | voornamen (02.10)                                                   | Pieter    |
      | adellijke titel of predicaat (02.20)                                | JH        |
      | voorvoegsel (02.30)                                                 | van den   |
      | geslachtsnaam (02.40)                                               | Aedel     |
      | geboortedatum (03.10)                                               | 19580701  |
      | geboorteplaats (03.20)                                              | Berlijn   |
      | geboorteland (03.30)                                                | 6029      |
      | geslachtsaanduiding (04.10)                                         | M         |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | 20010808  |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | Parijs    |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 5002      |
      | soort verbintenis (15.10)                                           | P         |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                         | waarde    |
      | burgerservicenummer (01.20)                                  | 000000188 |
      | voornamen (02.10)                                            | Pieter    |
      | adellijke titel of predicaat (02.20)                         | JH        |
      | voorvoegsel (02.30)                                          | van den   |
      | geslachtsnaam (02.40)                                        | Aedel     |
      | geboortedatum (03.10)                                        | 19580701  |
      | geboorteplaats (03.20)                                       | Berlijn   |
      | geboorteland (03.30)                                         | 6029      |
      | geslachtsaanduiding (04.10)                                  | M         |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20180317  |
      | soort verbintenis (15.10)                                    | P         |


  Rule: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven

    Scenario: Afnemer vraagt om partners en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                                           | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode |        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                                            | waarde                     |
      | burgerservicenummer                             | 000000188                  |
      | naam.voornamen                                  | Pieter                     |
      | naam.adellijkeTitelPredicaat.code               | JH                         |
      | naam.adellijkeTitelPredicaat.omschrijving       | jonkheer                   |
      | naam.adellijkeTitelPredicaat.soort              | predicaat                  |
      | naam.voorvoegsel                                | van den                    |
      | naam.geslachtsnaam                              | Aedel                      |
      | geboorte.datum                                  | 19580701                   |
      | geboorte.plaats.omschrijving                    | Berlijn                    |
      | geboorte.land.code                              | 6029                       |
      | geboorte.land.omschrijving                      | Duitsland                  |
      | geslacht.code                                   | M                          |
      | geslacht.omschrijving                           | man                        |
      | aangaanHuwelijkPartnerschap.datum               | 20010808                   |
      | aangaanHuwelijkPartnerschap.plaats.omschrijving | Parijs                     |
      | aangaanHuwelijkPartnerschap.land.code           | 5002                       |
      | aangaanHuwelijkPartnerschap.land.omschrijving   | Frankrijk                  |
      | ontbindingHuwelijkPartnerschap.datum            | 20180317                   |
      | soortVerbintenis.code                           | P                          |
      | soortVerbintenis.omschrijving                   | geregistreerd partnerschap |

    @fout-case
    Abstract Scenario: Afnemer vraagt om partners en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode |        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                                                    | missende autorisatie |
      | 10120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50120                |
      | 10120 50120 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50210                |
      | 10120 50120 50210 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50220                |
      | 10120 50120 50210 50220 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50230                |
      | 10120 50120 50210 50220 50230 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50240                |
      | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 | 50310                |
      | 10120 50120 50210 50220 50230 50240 50310 50330 50410 50610 50620 50630 50710 51510 | 50320                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50410 50610 50620 50630 50710 51510 | 50330                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50610 50620 50630 50710 51510 | 50410                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50620 50630 50710 51510 | 50610                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50630 50710 51510 | 50620                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50710 51510 | 50630                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 51510 | 50710                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 | 51510                |

    @fout-case
    Abstract Scenario: Afnemer vraagt om partners.<fields> en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode |        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners.<fields>               |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                               | ad hoc rubrieken                                                                    | missende autorisatie |
      | burgerservicenummer                  | 10120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50120                |
      | naam.voornamen                       | 10120 50120 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50210                |
      | naam.adellijkeTitelPredicaat         | 10120 50120 50210 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50220                |
      | naam.voorvoegsel                     | 10120 50120 50210 50220 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50230                |
      | naam.geslachtsnaam                   | 10120 50120 50210 50220 50230 50310 50320 50330 50410 50610 50620 50630 50710 51510 | 50240                |
      | geboorte.datum                       | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 | 50310                |
      | geboorte.plaats                      | 10120 50120 50210 50220 50230 50240 50310 50330 50410 50610 50620 50630 50710 51510 | 50320                |
      | geboorte.land                        | 10120 50120 50210 50220 50230 50240 50310 50320 50410 50610 50620 50630 50710 51510 | 50330                |
      | geslacht                             | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50610 50620 50630 50710 51510 | 50410                |
      | aangaanHuwelijkPartnerschap.datum    | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50620 50630 50710 51510 | 50610                |
      | aangaanHuwelijkPartnerschap.plaats   | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50630 50710 51510 | 50620                |
      | aangaanHuwelijkPartnerschap.land     | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50710 51510 | 50630                |
      | ontbindingHuwelijkPartnerschap.datum | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 51510 | 50710                |
      | soortVerbintenis                     | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 | 51510                |