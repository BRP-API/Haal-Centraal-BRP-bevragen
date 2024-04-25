#language: nl

@gba
Functionaliteit: gezagsverhouding

  Achtergrond:
    Gegeven landelijke tabel "Gezagsverhouding" heeft de volgende waarden
    | code | waarde                                                |
    | 1    | Ouder1 heeft het gezag                                |
    | 12   | Ouder1 en ouder2 hebben het gezag                     |
    | 1D   | Ouder1 en een derde hebben het gezag                  |
    | 2    | Ouder2 heeft het gezag                                |
    | 2D   | Ouder2 en een derde hebben het gezag                  |
    | D    | Een of meer derden hebben het gezag                   |
    | 3D   | ouder1 + ouder2 + een of meer derden hebben het gezag |


  Abstract Scenario: persoon heeft 'gezagsverhouding' veld: 'indicatie gezag minderjarige (32.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde |
    | indicatie gezag minderjarige (32.10) | 12     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <naam>                          |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                    | waarde                            |
    | indicatieGezagMinderjarige.code         | 12                                |
    | indicatieGezagMinderjarige.omschrijving | Ouder1 en ouder2 hebben het gezag |

    Voorbeelden:
    | naam                                    |
    | indicatieGezagMinderjarige              |
    | indicatieGezagMinderjarige.code         |
    | indicatieGezagMinderjarige.omschrijving |

  Abstract Scenario: persoon heeft 'indicatie gezag minderjarige (32.10)' met waarde '<code>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde |
    | indicatie gezag minderjarige (32.10) | <code> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieGezagMinderjarige      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                    | waarde         |
    | indicatieGezagMinderjarige.code         | <code>         |
    | indicatieGezagMinderjarige.omschrijving | <omschrijving> |

    Voorbeelden:
    | code | omschrijving                                          |
    | 1    | Ouder1 heeft het gezag                                |
    | 12   | Ouder1 en ouder2 hebben het gezag                     |
    | 1D   | Ouder1 en een derde hebben het gezag                  |
    | 2    | Ouder2 heeft het gezag                                |
    | 2D   | Ouder2 en een derde hebben het gezag                  |
    | D    | Een of meer derden hebben het gezag                   |
    | 3D   | ouder1 + ouder2 + een of meer derden hebben het gezag |
    | 4    |                                                       |

  Scenario: persoon heeft 'gezagsverhouding' veld: 'indicatie curateleregister (33.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                               | waarde |
    | indicatie curateleregister (33.10) | 1      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieCurateleRegister       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                      | waarde |
    | indicatieCurateleRegister | true   |

  Abstract Scenario: 'gezagsverhouding' veld(en) van persoon is/zijn in onderzoek en indicatieGezagMinderjarige is gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde                    |
    | indicatie gezag minderjarige (32.10) | 12                        |
    | indicatie curateleregister (33.10)   | 1                         |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieGezagMinderjarige      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                           | waarde                            |
    | indicatieGezagMinderjarige.code                | 12                                |
    | indicatieGezagMinderjarige.omschrijving        | Ouder1 en ouder2 hebben het gezag |
    | gezagInOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde>         |
    | gezagInOnderzoek.datumIngangOnderzoek          | 20020701                          |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 110000                  |
    | 113200                  |
    | 113210                  |
    | 113300                  |
    | 113310                  |

  Abstract Scenario: 'gezagsverhouding' veld(en) van persoon is/zijn in onderzoek en indicatieCurateleRegister is gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde                    |
    | indicatie gezag minderjarige (32.10) | 12                        |
    | indicatie curateleregister (33.10)   | 1                         |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieCurateleRegister       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                           | waarde                            |
    | indicatieCurateleRegister                      | true                              |
    | gezagInOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde>         |
    | gezagInOnderzoek.datumIngangOnderzoek          | 20020701                          |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 110000                  |
    | 113200                  |
    | 113210                  |
    | 113300                  |
    | 113310                  |

  Abstract Scenario: 'indicatie gezag minderjarige (32.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | indicatie gezag minderjarige (32.10) | 1                         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieGezagMinderjarige      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                           | waarde                    |
    | indicatieGezagMinderjarige.code                | 1                         |
    | indicatieGezagMinderjarige.omschrijving        | Ouder1 heeft het gezag    |
    | gezagInOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | gezagInOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 110000                  |
    | 113200                  |
    | 113210                  |

  Abstract Scenario: 'indicatie curateleregister (33.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    | indicatie curateleregister (33.10) | 1                         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieCurateleRegister       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                           | waarde                    |
    | indicatieCurateleRegister                      | true                      |
    | gezagInOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | gezagInOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 110000                  |
    | 113300                  |
    | 113310                  |

  Abstract Scenario: 'indicatie gezag minderjarige (32.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | indicatie gezag minderjarige (32.10) | <waarde>                  |
    | indicatie curateleregister (33.10)   | 1                         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieCurateleRegister       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                           | waarde                    |
    | indicatieCurateleRegister                      | true                      |
    | gezagInOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | gezagInOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde | waarde |
    | 113200                  | 1      |
    | 113210                  | 2      |

  Abstract Scenario: 'indicatie curateleregister (33.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | indicatie gezag minderjarige (32.10) | 1                         |
    | indicatie curateleregister (33.10)   | <waarde>                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieGezagMinderjarige      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                           | waarde                    |
    | indicatieGezagMinderjarige.code                | 1                         |
    | indicatieGezagMinderjarige.omschrijving        | Ouder1 heeft het gezag    |
    | gezagInOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | gezagInOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde | waarde |
    | 113300                  | 1      |
    | 113310                  | 1      |

  Scenario: persoon met 'indicatie curateleregister (33.10)' wordt gewijzigd naar geen 'indicatie curateleregister (33.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                               | waarde   |
    | indicatie curateleregister (33.10) | 1        |
    | datum van opneming (86.10)         | 20080706 |
    En de 'gezagsverhouding' is gewijzigd naar de volgende gegevens
    | naam                       | waarde   |
    | datum van opneming (86.10) | 20080707 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieCurateleRegister       |
    Dan heeft de response een persoon zonder gegevens

  Regel: Onjuiste gegevens worden niet geleverd.
  Scenario: persoon heeft 'gezagsverhouding' veld: 'indicatie gezag minderjarige (32.10)' en de gezagsverhouding is gecorrigeerd naar onjuist
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'gezagsverhouding' gegevens
    | naam                                 | waarde |
    | indicatie gezag minderjarige (32.10) | 12     |
    En de 'gezagsverhouding' is gecorrigeerd naar de volgende gegevens
    | naam                       | waarde   |
    | datum van opneming (86.10) | 20080707 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | indicatieGezagMinderjarige      |
    Dan heeft de response een persoon zonder gegevens
