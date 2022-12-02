# language: nl

Functionaliteit: overlijden GBA: Altijd leveren van overlijdensdatum van een overleden persoon

  Wanneer een consumer van de BRP API gegevens bevraagt van een overleden persoon
  Dan levert de GBA api altijd de overlijdensdatum zodat de indicatieOverleden door de proxy op "true" gezet kan worden

  Rule: overlijden.datum wordt altijd meegeleverd als een persoon is overleden. Dit veld wordt altijd meegeleverd, ook als het niet met fields is gevraagd

    Abstract Scenario: niet-overleden persoon wordt geraadpleegd met burgerservicenummer en <sub titel>
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |

      Voorbeelden:
      | sub titel                             | fields                         |
      | overlijden velden wordt gevraagd      | burgerservicenummer,overlijden |
      | overlijden velden wordt niet gevraagd | burgerservicenummer            |

    Scenario: overleden persoon wordt geraadpleegd met burgerservicenummer en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20020701 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000139                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000139 |
      | overlijden.datum              | 20020701  |

    Scenario: personen wordt gezocht met geslachtsnaam en geboortedatum inclusief overleden personen en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      En de persoon heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000139 |
      | overlijden.datum              | 19630405  |

    Scenario: overleden persoon wordt geraadpleegd met burgerservicenummer en datum overlijden veld wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetBurgerservicenummer      |
      | burgerservicenummer | 000000139                            |
      | fields              | burgerservicenummer,overlijden.datum |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000139 |
      En heeft de persoon de volgende 'overlijden' gegevens
      | naam               | waarde      |
      | datum              | 20020701    |


    Abstract Scenario: overleden persoon wordt geraadpleegd met burgerservicenummer, <field> overlijden is onbekend en wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20020701 |
      | <naam gba element>       | 0000     |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000139                              |
      | fields              | burgerservicenummer,overlijden.<field> |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                            | waarde    |
      | burgerservicenummer             | 000000139 |
      | overlijden.datum                | 20020701  |
      | overlijden.<field>.code         | 0000      |
      | overlijden.<field>.omschrijving | Onbekend |

      Voorbeelden:
      | naam gba element          | field  |
      | plaats overlijden (08.20) | plaats |
      | land overlijden (08.30)   | land   |

  Rule: indicatieOverleden is in onderzoek wanneer ten minste één van de andere overlijden gegevens in onderzoek zijn

    Abstract Scenario: <gegeven in onderzoek> is in onderzoek en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'overlijden' gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | datum overlijden (08.10)        | 20020701                  |
      | plaats overlijden (08.20)       | 0518                      |
      | land overlijden (08.30)         | 6030                      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000139                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                    | waarde                    |
      | burgerservicenummer                                     | 000000139                 |
      | overlijden.datum                                        | 20020701                  |
      | overlijden.inOnderzoek                                  | <gba in onderzoek waarde> |

      Voorbeelden:
      | gegeven in onderzoek | gba in onderzoek waarde |
      | categorie overlijden | 060000                  |
      | groep overlijden     | 060800                  |
      | datum overlijden     | 060810                  |
      | plaats overlijden    | 060820                  |
      | land overlijden      | 060830                  |
