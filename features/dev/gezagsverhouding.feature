#language: nl

Functionaliteit: Persoon: gezagsverhouding

  Abstract Scenario: persoon heeft 'gezagsverhouding' veld: 'indicatie gezag minderjarige (32.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde |
    | indicatie gezag minderjarige (32.10) | 12     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <naam>                          |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                    | waarde           |
    | indicatieGezagMinderjarige.code         | 12               |
    | indicatieGezagMinderjarige.omschrijving | ouder1 en ouder2 |

    Voorbeelden:
    | naam                                    |
    | indicatieGezagMinderjarige              |
    | indicatieGezagMinderjarige.code         |
    | indicatieGezagMinderjarige.omschrijving |

  Scenario: persoon heeft 'gezagsverhouding' veld: 'indicatie curateleregister (33.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                               | waarde |
    | indicatie curateleregister (33.10) | 1      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieCurateleRegister       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                      | waarde |
    | indicatieCurateleRegister | true   |

  Abstract Scenario: 'gezagsverhouding' veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | inOnderzoek                     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                              | waarde                            |
    | inOnderzoek.indicatieCurateleRegister             | <curateleregister in onderzoek>   |
    | inOnderzoek.indicatieGezagMinderjarige            | <gezag minderjarige in onderzoek> |
    | inOnderzoek.datumIngangOnderzoekGezag.type        | Datum                             |
    | inOnderzoek.datumIngangOnderzoekGezag.datum       | 2002-07-01                        |
    | inOnderzoek.datumIngangOnderzoekGezag.langFormaat | 1 juli 2002                       |

    Voorbeelden:
    | gba in onderzoek waarde | gezag minderjarige in onderzoek | curateleregister in onderzoek |
    | 110000                  | true                            | true                          |
    | 113200                  | true                            |                               |
    | 113210                  | true                            |                               |
    | 113300                  |                                 | true                          |
    | 113310                  |                                 | true                          |

  Abstract Scenario: 'indicatie gezag minderjarige (32.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | indicatie gezag minderjarige (32.10) | 1                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieGezagMinderjarige      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                              | waarde      |
    | indicatieGezagMinderjarige.code                   | 1           |
    | indicatieGezagMinderjarige.omschrijving           | ouder1      |
    | inOnderzoek.indicatieGezagMinderjarige            | true        |
    | inOnderzoek.datumIngangOnderzoekGezag.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekGezag.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekGezag.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 110000                  |
    | 113200                  |
    | 113210                  |

  Abstract Scenario: 'indicatie curateleregister (33.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | indicatie curateleregister (33.10) | 1                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieCurateleRegister      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                              | waarde      |
    | indicatieCurateleRegister                   | true           |
    | inOnderzoek.indicatieCurateleRegister            | true        |
    | inOnderzoek.datumIngangOnderzoekGezag.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekGezag.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekGezag.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 110000                  |
    | 113300                  |
    | 113310                  |

  Abstract Scenario: '<in onderzoek veld>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | <in onderzoek veld>             | <waarde>                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | gba in onderzoek waarde | in onderzoek veld                    | waarde | field                      |
    | 113200                  | indicatie gezag minderjarige (32.10) | 1      | indicatieCurateleRegister  |
    | 113210                  | indicatie gezag minderjarige (32.10) | 2      | indicatieCurateleRegister  |
    | 113300                  | indicatie curateleregister (33.10)   | 1      | indicatieGezagMinderjarige |
    | 113310                  | indicatie curateleregister (33.10)   | 1      | indicatieGezagMinderjarige |
