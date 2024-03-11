# language: nl

@autorisatie
Functionaliteit: autorisatie voor aanhef

  Rule: Vragen met fields om aanhef, wanneer de gebruiker niet geautoriseerd is voor alle velden waaruit aanhef wordt afgeleid, geeft een foutmelding
  
    Abstract Scenario: Afnemer vraagt om aanhef en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 PANM03                    | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) | aanduiding naamgebruik (61.10) |
      | Pieter            | Maassen               | M                           | E                              |
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
      | fields                       |
      | adressering.aanhef           |
      | adresseringBinnenland.aanhef |

    @fout-case
    Abstract Scenario: Afnemer vraagt om aanhef en is niet geautoriseerd voor PA.NM.03
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                                                                  | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10120 10210 10220 10230 10240 10410 16110 50220 50230 50240 50610 50710 PANM01 PANM02 PANM04 PAVP05 PAVP06 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) | aanduiding naamgebruik (61.10) |
      | Pieter            | Maassen               | M                           | E                              |
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
      | fields                       |
      | adressering.aanhef           |
      | adresseringBinnenland.aanhef |
