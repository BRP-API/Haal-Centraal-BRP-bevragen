#language: nl

Functionaliteit: Persoon: gezagsverhouding velden vragen met fields

  Abstract Scenario: 'indicatie gezag minderjarige (32.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde |
    | indicatie gezag minderjarige (32.10) | 12     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                    | waarde                            |
    | indicatieGezagMinderjarige.code         | 12                                |
    | indicatieGezagMinderjarige.omschrijving | Ouder1 en ouder2 hebben het gezag |

    Voorbeelden:
    | fields                                  |
    | indicatieGezagMinderjarige              |
    | indicatieGezagMinderjarige.code         |
    | indicatieGezagMinderjarige.omschrijving |

  Scenario: 'indicatie curateleregister (33.10)' wordt gevraagd met field pad 'indicatieCurateleRegister'
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
