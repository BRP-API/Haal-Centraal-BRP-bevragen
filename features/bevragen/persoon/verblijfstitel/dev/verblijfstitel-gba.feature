#language: nl

Functionaliteit: GBA persoon: Verblijfstitel

Achtergrond:
  Gegeven landelijke tabel "Verblijfstitel" heeft de volgende waarden
  | code | omschrijving                                                                   |
  |   00 | Onbekend                                                                       |
  |   09 | Art. 9 van de Vreemdelingenwet                                                 |
  |   37 | Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. niet-actief, arbeid spec. |

  Scenario: verblijfstitel heeft geen verblijfstitel
    Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000103                       |
    | fields              | verblijfstitel.aanduiding       |
    Dan heeft de response een persoon zonder gegevens

  Scenario: verblijfstitel heeft geen datum einde
    Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende 'verblijfstitel' gegevens
    | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) |
    | 37                                | 20210315                            |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000103                       |
    | fields              | verblijfstitel.aanduiding       |
    Dan heeft de response een persoon met alleen de volgende 'verblijfstitel' gegevens
    | naam                    | waarde                                                                              |
    | aanduiding.code         | 37                                                                                  |
    | aanduiding.omschrijving | Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. niet-actief, arbeid spec. |

  Scenario: verblijfstitel heeft een datum einde
    Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'verblijfstitel' gegevens
    | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) | datum einde verblijfstitel (39.20) |
    | 37                                | 19980201                            | 20020701                            |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000140                       |
    | fields              | verblijfstitel.aanduiding       |
    Dan heeft de response een persoon zonder gegevens

  Scenario: persoon's verblijfstitel velden is in onderzoek geweest
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfstitel' gegevens
    | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
    | 09                                | 20010327                            | 103910                          | 20020101                       | 20040201                     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel                  |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde                          |
    | aanduiding.code                              | 09                              |
    | aanduiding.omschrijving                      | Art. 9 van de Vreemdelingenwet  |
    | datumIngang                                  | 20010327                        |


  Scenario: persoon's verblijfstitel velden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfstitel' gegevens
    | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 09                                | 20010315                            | 103910                          | 20020101                       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel                  |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde                          |
    | inOnderzoek.aanduidingGegevensInOnderzoek    | 103910                          |
    | inOnderzoek.datumIngangOnderzoek             | 20020101                        |
    | aanduiding.code                              | 09                              |
    | aanduiding.omschrijving                      | Art. 9 van de Vreemdelingenwet  |
    | datumIngang                                  | 20010315                        |

  Scenario: persoon's verblijfstitel velden is onbekend
    Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'verblijfstitel' gegevens
    | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) |
    | 00                                | 20010315                            |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | verblijfstitel                  |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde                          |
    | aanduiding.code                              | 00                              |
    | aanduiding.omschrijving                      | Onbekend                        |
    | datumIngang                                  | 20010315                        |