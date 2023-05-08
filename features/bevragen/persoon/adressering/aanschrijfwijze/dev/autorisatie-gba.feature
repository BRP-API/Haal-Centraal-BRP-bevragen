# language: nl

@gba @autorisatie
Functionaliteit: autorisatie voor aanschrijfwijze

  Rule: Vragen met fields om aanschrijfwijze, wanneer de gebruiker niet geautoriseerd is voor alle velden waaruit aanschrijfwijze wordt afgeleid, geeft een foutmelding
  
    Abstract Scenario: Afnemer vraagt om <fields> en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                         | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210 10220 10230 10240 10410 16110 50220 50230 50240 50610 50710 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                                 | waarde  |
      | geslachtsaanduiding (04.10)          | V       |
      | voornamen (02.10)                    | Jo      |
      | adellijke titel of predicaat (02.20) | BS      |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      | aanduiding naamgebruik (61.10)       | E       |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde   |
      | voornamen (02.10)                                                  | Mike     |
      | adellijke titel of predicaat (02.20)                               | R        |
      | voorvoegsel (02.30)                                                | de       |
      | geslachtsnaam (02.40)                                              | Boer     |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19580401 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.<fields>            |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | fields               |
      | aanschrijfwijze      |
      | aanschrijfwijze.naam |

    Scenario: Afnemer vraagt om aanschrijfwijze.aanspreekvorm en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)           | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10220 10410 16110 50220 50610 50710 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                                 | waarde  |
      | geslachtsaanduiding (04.10)          | V       |
      | voornamen (02.10)                    | Jo      |
      | adellijke titel of predicaat (02.20) | BS      |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      | aanduiding naamgebruik (61.10)       | E       |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde   |
      | voornamen (02.10)                                                  | Mike     |
      | adellijke titel of predicaat (02.20)                               | R        |
      | voorvoegsel (02.30)                                                | de       |
      | geslachtsnaam (02.40)                                              | Boer     |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19580401 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                    |
      | type                | RaadpleegMetBurgerservicenummer           |
      | burgerservicenummer | 000000024                                 |
      | fields              | adressering.aanschrijfwijze.aanspreekvorm |
      Dan heeft de response 1 persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om aanschrijfwijze en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) | aanduiding naamgebruik (61.10) |
      | Pieter            | Maassen               | M                           | E                              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                                  | missende autorisatie                                               |
      | 10120 10220 10230 10240 10410 16110 50220 50230 50240 50610 50710 | voornamen (10210)                                                  |
      | 10120 10210 10230 10240 10410 16110 50220 50230 50240 50610 50710 | adellijke titel of predicaat (10220)                               |
      | 10120 10210 10220 10240 10410 16110 50220 50230 50240 50610 50710 | voorvoegsel (10230)                                                |
      | 10120 10210 10220 10230 10410 16110 50220 50230 50240 50610 50710 | geslachtsnaam (10240)                                              |
      | 10120 10210 10220 10230 10240 16110 50220 50230 50240 50610 50710 | geslacht (10410)                                                   |
      | 10120 10210 10220 10230 10240 10410 50220 50230 50240 50610 50710 | aanduiding naamgebruik (16110)                                     |
      | 10120 10210 10220 10230 10240 10410 16110 50230 50240 50610 50710 | partner adellijke titel of predicaat (50220)                       |
      | 10120 10210 10220 10230 10240 10410 16110 50220 50240 50610 50710 | partner voorvoegsel (50230)                                        |
      | 10120 10210 10220 10230 10240 10410 16110 50220 50230 50610 50710 | partner geslachtsnaam (50240)                                      |
      | 10120 10210 10220 10230 10240 10410 16110 50220 50230 50240 50710 | datum huwelijkssluiting/aangaan geregistreerd partnerschap (50610) |
      | 10120 10210 10220 10230 10240 10410 16110 50220 50230 50240 50610 | datum ontbinding huwelijk/geregistreerd partnerschap (50710)       |

    @fout-case
    Abstract Scenario: Afnemer vraagt om aanschrijfwijze.aanspreekvorm en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) | aanduiding naamgebruik (61.10) |
      | Pieter            | Maassen               | M                           | E                              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                    |
      | type                | RaadpleegMetBurgerservicenummer           |
      | burgerservicenummer | 000000024                                 |
      | fields              | adressering.aanschrijfwijze.aanspreekvorm |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                    | missende autorisatie                                               |
      | 10120 10410 16110 50220 50610 50710 | adellijke titel of predicaat (10220)                               |
      | 10120 10220 16110 50220 50610 50710 | geslacht (10410)                                                   |
      | 10120 10220 10410 50220 50610 50710 | aanduiding naamgebruik (16110)                                     |
      | 10120 10220 10410 16110 50610 50710 | partner adellijke titel of predicaat (50220)                       |
      | 10120 10220 10410 16110 50220 50710 | datum huwelijkssluiting/aangaan geregistreerd partnerschap (50610) |
      | 10120 10220 10410 16110 50220 50610 | datum ontbinding huwelijk/geregistreerd partnerschap (50710)       |
