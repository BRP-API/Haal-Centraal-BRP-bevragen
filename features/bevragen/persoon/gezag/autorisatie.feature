# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van gezag van Persoon


    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000024        |
      | 000000012       | OG2        | 000000048        |

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 113210 113310             | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                                     |
      | gezag                                      |
      | gezag.type                                 |
      | gezag.minderjarige                         |
      | gezag.ouders                               |
      | gezag.ouder                                |
      | gezag.derde                                |
      | gezag.derden                               |
      | gezag.minderjarige.burgerservicenummer     |
      | gezag.ouders.burgerservicenummer           |
      | gezag.ouder.burgerservicenummer            |
      | gezag.derde.burgerservicenummer            |
      | gezag.derden.burgerservicenummer           |
      | gezag.ouders,gezag.ouder                   |
      | gezag.type,gezag.minderjarige,gezag.ouders |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 PAGZ01                    | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | TweehoofdigOuderlijkGezag |
      | minderjarige.burgerservicenummer | 000000012                 |
      En heeft 'gezag' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
      En heeft 'gezag' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |

      Voorbeelden:
      | fields                                     |
      | gezag                                      |
      | gezag.type                                 |
      | gezag.minderjarige                         |
      | gezag.ouders                               |
      | gezag.ouder                                |
      | gezag.derde                                |
      | gezag.derden                               |
      | gezag.minderjarige.burgerservicenummer     |
      | gezag.ouders.burgerservicenummer           |
      | gezag.ouder.burgerservicenummer            |
      | gezag.derde.burgerservicenummer            |
      | gezag.derden.burgerservicenummer           |
      | gezag.ouders,gezag.ouder                   |
