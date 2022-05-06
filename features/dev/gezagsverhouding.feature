#language: nl

@post-assert
Functionaliteit: Gezagsverhouding

  Abstract Scenario: persoon heeft 'gezagsverhouding' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'gezagsverhouding' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | gezagsverhouding                |
    Dan heeft de response een persoon met de volgende 'gezagsverhouding' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                                | naam                                    | waarde                            |
    | indicatie gezag minderjarige (32.10)    | indicatieGezagMinderjarige.code         | 12                                |
    | indicatieGezagMinderjarige.omschrijving | indicatieGezagMinderjarige.omschrijving | Ouder1 en ouder2 hebben het gezag |
    | indicatie curateleregister (33.10)      | indicatieCurateleRegister               | true                              |

  Abstract Scenario: persoon's gezagsverhouding velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'gezagsverhouding' gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | gezagsverhouding                |
    Dan heeft de response een persoon met de volgende 'gezagsverhouding' gegevens
    | naam                                   | waarde                            |
    | inOnderzoek.indicatieCurateleRegister  | <curateleregister in onderzoek>   |
    | inOnderzoek.indicatieGezagMinderjarige | <gezag minderjarige in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type  | Datum                             |
    | inOnderzoek.datumIngangOnderzoek.datum | 2002-07-01                        |

    Voorbeelden:
    | gba in onderzoek waarde | gezag minderjarige in onderzoek | curateleregister in onderzoek |
    | 110000                  | true                            | true                          |
    | 113200                  | true                            |                               |
    | 113210                  | true                            |                               |
    | 113300                  |                                 | true                          |
    | 113310                  |                                 | true                          |
