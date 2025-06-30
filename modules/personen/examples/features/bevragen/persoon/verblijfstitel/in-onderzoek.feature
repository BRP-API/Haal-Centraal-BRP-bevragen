#language: nl

Functionaliteit: verblijfstitel velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle verblijfstitel velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                              | waarde                    |
    | aanduiding verblijfstitel (39.10) | 09                        |
    | aanduiding in onderzoek (83.10)   | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel                  |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde                         |
    | aanduiding.code                              | 09                             |
    | aanduiding.omschrijving                      | Art. 9 van de Vreemdelingenwet |
    | inOnderzoek.aanduiding                       | <aanduiding io>                |
    | inOnderzoek.datumEinde                       | <datum einde io>               |
    | inOnderzoek.datumIngang                      | <datum ingang io>              |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                    |

    Voorbeelden:
    | aanduiding in onderzoek | aanduiding io | datum einde io | datum ingang io | type                        |
    | 100000                  | true          | true           | true            | hele categorie persoon      |
    | 103900                  | true          | true           | true            | hele groep verblijfstitel   |
    | 103910                  | true          |                |                 | aanduiding verblijfstitel   |
    | 103920                  |               | true           |                 | datum einde verblijfstitel  |
    | 103930                  |               |                | true            | datum ingang verblijfstitel |

  Abstract Scenario: 'aanduiding verblijfstitel' is in onderzoek
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

  Abstract Scenario: 'datum ingang verblijfstitel' is in onderzoek
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
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datumIngang                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 100000                  |
    | 103900                  |
    | 103930                  |

  Abstract Scenario: 'datum einde verblijfstitel' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                              | waarde                    |
    | aanduiding verblijfstitel (39.10) | 09                        |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.datumEinde       |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datumEinde                       | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 100000                  |
    | 103900                  |
    | 103920                  |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                              | waarde                    |
    | aanduiding verblijfstitel (39.10) | 09                        |
    | aanduiding in onderzoek (83.10)   | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon zonder 'verblijfstitel' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | fields                     | type                        |
    | 103910                  | verblijfstitel.datumIngang | aanduiding verblijfstitel   |
    | 103930                  | verblijfstitel.datumEinde  | datum ingang verblijfstitel |
    | 103920                  | verblijfstitel.datumIngang | datum einde verblijfstitel  |
