#language: nl

Functionaliteit: Persoon: gezagsverhouding velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en indicatieCurateleRegister en indicatieGezagMinderjarige worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                               |
    | type                | RaadpleegMetBurgerservicenummer                      |
    | burgerservicenummer | 000000152                                            |
    | fields              | indicatieCurateleRegister,indicatieGezagMinderjarige |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                              | waarde                  |
    | inOnderzoek.indicatieCurateleRegister             | <curateleregister io>   |
    | inOnderzoek.indicatieGezagMinderjarige            | <gezag minderjarige io> |
    | inOnderzoek.datumIngangOnderzoekGezag.type        | Datum                   |
    | inOnderzoek.datumIngangOnderzoekGezag.datum       | 2002-07-01              |
    | inOnderzoek.datumIngangOnderzoekGezag.langFormaat | 1 juli 2002             |

    Voorbeelden:
    | aanduiding in onderzoek | gezag minderjarige io | curateleregister io | type                            |
    | 110000                  | true                  | true                | hele categorie gezagsverhouding |
    | 113200                  | true                  |                     | hele groep gezag minderjarige   |
    | 113210                  | true                  |                     | indicatie gezag minderjarige    |
    | 113300                  |                       | true                | hele groep curatele             |
    | 113310                  |                       | true                | indicatie curateleregister      |

  Abstract Scenario: '<type>' is in onderzoek en indicatieGezagMinderjarige wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieGezagMinderjarige      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                              | waarde      |
    | inOnderzoek.indicatieGezagMinderjarige            | true        |
    | inOnderzoek.datumIngangOnderzoekGezag.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekGezag.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekGezag.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                            |
    | 110000                  | hele categorie gezagsverhouding |
    | 113200                  | hele groep gezag minderjarige   |
    | 113210                  | indicatie gezag minderjarige    |

  Abstract Scenario: '<type>' is in onderzoek en indicatieCurateleRegister wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieCurateleRegister       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                              | waarde      |
    | inOnderzoek.indicatieCurateleRegister             | true        |
    | inOnderzoek.datumIngangOnderzoekGezag.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekGezag.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekGezag.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                            |
    | 110000                  | hele categorie gezagsverhouding |
    | 113300                  | hele groep curatele             |
    | 113310                  | indicatie curateleregister      |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | field                      | type                          |
    | 113200                  | indicatieCurateleRegister  | hele groep gezag minderjarige |
    | 113210                  | indicatieCurateleRegister  | indicatieGezagMinderjarige    |
    | 113300                  | indicatieGezagMinderjarige | hele groep curatele           |
    | 113310                  | indicatieGezagMinderjarige | indicatie curateleregister    |
