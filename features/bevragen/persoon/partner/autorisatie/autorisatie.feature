# language: nl

@autorisatie
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


  Regel: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven

    Abstract Scenario: Afnemer vraagt om partners.<fields> en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
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
      | fields              | partners.<fields>               |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | fields                                          | ad hoc rubrieken               |
      | burgerservicenummer                             | 50120                          |
      | naam.voornamen                                  | 50210                          |
      | naam.adellijkeTitelPredicaat                    | 50220                          |
      | naam.voorvoegsel                                | 50230                          |
      | naam.geslachtsnaam                              | 50240                          |
      | naam.voorletters                                | PAHP01                         |
      | naam                                            | 50210 50220 50230 50240 PAHP01 |
      | geboorte.datum                                  | 50310                          |
      | geboorte.datum.type                             | 50310                          |
      | geboorte.datum.datum                            | 50310                          |
      | geboorte.datum.langFormaat                      | 50310                          |
      | geboorte.datum.jaar                             | 50310                          |
      | geboorte.datum.maand                            | 50310                          |
      | geboorte.datum.onbekend                         | 50310                          |
      | geboorte.plaats                                 | 50320                          |
      | geboorte.land                                   | 50330                          |
      | geboorte                                        | 50310 50320 50330              |
      | geslacht                                        | 50410                          |
      | aangaanHuwelijkPartnerschap.datum               | 50610                          |
      | aangaanHuwelijkPartnerschap.plaats              | 50620                          |
      | aangaanHuwelijkPartnerschap.plaats.code         | 50620                          |
      | aangaanHuwelijkPartnerschap.plaats.omschrijving | 50620                          |
      | aangaanHuwelijkPartnerschap.land                | 50630                          |
      | aangaanHuwelijkPartnerschap                     | 50610 50620 50630              |
      | ontbindingHuwelijkPartnerschap.datum            | 50710                          |
      | soortVerbintenis                                | 51510                          |

    Scenario: Afnemer vraagt om partners en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                                                  | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners                        |
      Dan heeft de response 1 persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om partners en is niet geautoriseerd voor <missende autorisatie>
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
      | fields              | partners                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                                                           | missende autorisatie |
      | 10120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50120                |
      | 10120 50120 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50210                |
      | 10120 50120 50210 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50220                |
      | 10120 50120 50210 50220 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50230                |
      | 10120 50120 50210 50220 50230 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50240                |
      | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | 10120 50120 50210 50220 50230 50240 50310 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50320                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50410 50610 50620 50630 50710 51510 PAHP01 | 50330                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50610 50620 50630 50710 51510 PAHP01 | 50410                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50620 50630 50710 51510 PAHP01 | 50610                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50630 50710 51510 PAHP01 | 50620                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50710 51510 PAHP01 | 50630                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 51510 PAHP01 | 50710                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 PAHP01 | 51510                |
      | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510  | PAHP01               |

    @fout-case
    Abstract Scenario: Afnemer vraagt om partners.<fields> en is niet geautoriseerd voor <missende autorisatie>
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
      | fields              | partners.<fields>               |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                               | ad hoc rubrieken                                                                           | missende autorisatie |
      | burgerservicenummer                  | 10120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50120                |
      | naam.voornamen                       | 10120 50120 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50210                |
      | naam.adellijkeTitelPredicaat         | 10120 50120 50210 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50220                |
      | naam.voorvoegsel                     | 10120 50120 50210 50220 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50230                |
      | naam.geslachtsnaam                   | 10120 50120 50210 50220 50230 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50240                |
      | naam.voorletters                     | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510  | PAHP01               |
      | naam                                 | 10120 50120 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50210                |
      | naam                                 | 10120 50120 50210 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50220                |
      | naam                                 | 10120 50120 50210 50220 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50230                |
      | naam                                 | 10120 50120 50210 50220 50230 50310 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50240                |
      | naam                                 | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510  | PAHP01               |
      | geboorte.datum                       | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | geboorte.datum.type                  | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | geboorte.datum.datum                 | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | geboorte.datum.langFormaat           | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | geboorte.datum.jaar                  | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | geboorte.datum.maand                 | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | geboorte.datum.onbekend              | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | geboorte.plaats                      | 10120 50120 50210 50220 50230 50240 50310 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50320                |
      | geboorte.plaats.code                 | 10120 50120 50210 50220 50230 50240 50310 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50320                |
      | geboorte.plaats.omschrijving         | 10120 50120 50210 50220 50230 50240 50310 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50320                |
      | geboorte.land                        | 10120 50120 50210 50220 50230 50240 50310 50320 50410 50610 50620 50630 50710 51510 PAHP01 | 50330                |
      | geboorte.land.code                   | 10120 50120 50210 50220 50230 50240 50310 50320 50410 50610 50620 50630 50710 51510 PAHP01 | 50330                |
      | geboorte.land.omschrijving           | 10120 50120 50210 50220 50230 50240 50310 50320 50410 50610 50620 50630 50710 51510 PAHP01 | 50330                |
      | geboorte                             | 10120 50120 50210 50220 50230 50240 50320 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50310                |
      | geboorte                             | 10120 50120 50210 50220 50230 50240 50310 50330 50410 50610 50620 50630 50710 51510 PAHP01 | 50320                |
      | geboorte                             | 10120 50120 50210 50220 50230 50240 50310 50320 50410 50610 50620 50630 50710 51510 PAHP01 | 50330                |
      | geslacht                             | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50610 50620 50630 50710 51510 PAHP01 | 50410                |
      | aangaanHuwelijkPartnerschap.datum    | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50620 50630 50710 51510 PAHP01 | 50610                |
      | aangaanHuwelijkPartnerschap.plaats   | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50630 50710 51510 PAHP01 | 50620                |
      | aangaanHuwelijkPartnerschap.land     | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50710 51510 PAHP01 | 50630                |
      | aangaanHuwelijkPartnerschap          | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50620 50630 50710 51510 PAHP01 | 50610                |
      | aangaanHuwelijkPartnerschap          | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50630 50710 51510 PAHP01 | 50620                |
      | aangaanHuwelijkPartnerschap          | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50710 51510 PAHP01 | 50630                |
      | ontbindingHuwelijkPartnerschap.datum | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 51510 PAHP01 | 50710                |
      | soortVerbintenis                     | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 PAHP01 | 51510                |
      | soortVerbintenis.code                | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 PAHP01 | 51510                |
      | soortVerbintenis.omschrijving        | 10120 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 PAHP01 | 51510                |

  Regel: voor het vragen en beoordelen van partnergegevens is geen autorisatie nodig voor indicatie onjuist (58410)

    Scenario: huwelijk is onjuist en afnemer heeft geen autorisatie voor indicatie onjuist (58410)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)            | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 50120 50210 50220 50230 50240 PAHP01 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000061' heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde          |
      | voornamen (02.10)                                                  | Daan            |
      | voorvoegsel (02.30)                                                | de              |
      | geslachtsnaam (02.40)                                              | Vries           |
      | geboortedatum (03.10)                                              | 19830715        |
      | soort verbintenis (15.10)                                          | H               |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20031107        |
      | gemeente document (82.10)                                          | 0518            |
      | datum document (82.20)                                             | 20031109        |
      | beschrijving document (82.30)                                      | PL gerelateerde |
      | ingangsdatum geldigheid (85.10)                                    | 20031107        |
      | datum van opneming (86.10)                                         | 20031109        |
      En het 'partner' is gecorrigeerd naar de volgende gegevens
      | naam                            | waarde           |
      | gemeente document (82.10)       | 0518             |
      | datum document (82.20)          | 20040105         |
      | beschrijving document (82.30)   | D27894-2004-A782 |
      | ingangsdatum geldigheid (85.10) | 20031107         |
      | datum van opneming (86.10)      | 20040112         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                     |
      | type                | RaadpleegMetBurgerservicenummer            |
      | burgerservicenummer | 000000061                                  |
      | fields              | partners.naam,partners.burgerservicenummer |
      Dan heeft de response een persoon zonder 'partner' gegevens
