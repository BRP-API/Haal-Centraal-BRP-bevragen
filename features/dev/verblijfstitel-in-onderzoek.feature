#language: nl

Functionaliteit: Persoon: verblijfstitel in onderzoek

  Abstract Scenario: verblijfstitel veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.inOnderzoek      |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde                      |
    | inOnderzoek.aanduiding                       | <aanduiding in onderzoek>   |
    | inOnderzoek.datumEinde                       | <datum einde in onderzoek>  |
    | inOnderzoek.datumIngang                      | <datum ingang in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                 |

    Voorbeelden:
    | gba in onderzoek waarde | aanduiding in onderzoek | datum ingang in onderzoek | datum einde in onderzoek |
    | 100000                  | true                    | true                      | true                     |
    | 103900                  | true                    | true                      | true                     |
    | 103910                  | true                    |                           |                          |
    | 103920                  |                         |                           | true                     |
    | 103930                  |                         | true                      |                          |

  Abstract Scenario: 'aanduiding verblijfstitel (39.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                              | waarde                    |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    | aanduiding verblijfstitel (39.10) | 09                        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.aanduiding       |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde                         |
    | aanduiding.code                              | 09                             |
    | aanduiding.omschrijving                      | Art. 9 van de Vreemdelingenwet |
    | inOnderzoek.aanduiding                       | true                           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                    |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 100000                  |
    | 103900                  |
    | 103910                  |

  Abstract Scenario: 'datum ingang verblijfstitel (39.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                                | waarde                    |
    | aanduiding in onderzoek (83.10)     | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)      | 20020701                  |
    | datum ingang verblijfstitel (39.30) | 19980201                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.datumIngang      |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde          |
    | datumIngang.type                             | Datum           |
    | datumIngang.datum                            | 1998-02-01      |
    | datumIngang.langFormaat                      | 1 februari 1998 |
    | inOnderzoek.datumIngang                      | true            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum           |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01      |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002     |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 100000                  |
    | 103900                  |
    | 103930                  |

  Abstract Scenario: 'datum einde verblijfstitel (39.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    En de 'verblijfstitel' is gewijzigd naar de volgende gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    | datum einde verblijfstitel (39.20) | 20251231                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.datumEinde       |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde           |
    | datumEinde.type                              | Datum            |
    | datumEinde.datum                             | 2025-12-31       |
    | datumEinde.langFormaat                       | 31 december 2025 |
    | inOnderzoek.datumEinde                       | true             |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum            |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01       |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002      |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 100000                  |
    | 103900                  |
    | 103920                  |

  Abstract Scenario: 'aanduiding verblijfstitel (39.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                              | waarde                    |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    | aanduiding verblijfstitel (39.10) | 09                        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.datumIngang      |
    Dan heeft de response een persoon zonder 'verblijfstitel' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 103910                  |

  Abstract Scenario: 'datum ingang verblijfstitel (39.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                                | waarde                    |
    | aanduiding in onderzoek (83.10)     | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)      | 20020701                  |
    | datum ingang verblijfstitel (39.30) | 19980201                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.datumEinde       |
    Dan heeft de response een persoon zonder 'verblijfstitel' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 103930                  |

  Abstract Scenario: 'datum einde verblijfstitel (39.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    En de 'verblijfstitel' is gewijzigd naar de volgende gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    | datum einde verblijfstitel (39.20) | 20251231                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.aanduiding       |
    Dan heeft de response een persoon zonder 'verblijfstitel' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 103920                  |
