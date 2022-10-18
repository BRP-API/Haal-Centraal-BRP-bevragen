# language: nl

Functionaliteit: overlijden: indicatie overleden

  Wanneer een consumer van de BRP API gegevens bevraagd van een overleden persoon
  Dan wil de consumer hiervan worden geattendeerd middels een indicatie bij de gevraagde gegevens

  Rule: indicatieOverleden heeft de waarde true als de betreffende persoon is overleden. Dit veld wordt altijd meegeleverd, ook als het niet met fields is gevraagd

    Abstract Scenario: niet-overleden persoon wordt geraadpleegd met burgerservicenummer en <sub titel>
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      Als personen wordt gezocht met de volgende parameters
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
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20020701 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      | overlijden.indicatieOverleden | true      |

    Scenario: personen wordt gezocht met geslachtsnaam en geboortedatum inclusief overleden personen en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      En de persoon heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      | overlijden.indicatieOverleden | true      |

    Scenario: overleden persoon wordt geraadpleegd met burgerservicenummer en datum overlijden veld wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetBurgerservicenummer      |
      | burgerservicenummer | 000000152                            |
      | fields              | burgerservicenummer,overlijden.datum |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |
      En heeft de persoon de volgende 'overlijden' gegevens
      | naam               | waarde      |
      | indicatieOverleden | true        |
      | datum.type         | Datum       |
      | datum.datum        | 2002-07-01  |
      | datum.langFormaat  | 1 juli 2002 |

    Abstract Scenario: overleden persoon wordt geraadpleegd met burgerservicenummer, <field> overlijden is onbekend en wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20020701 |
      | <naam gba element>       | 0000     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000152                              |
      | fields              | burgerservicenummer,overlijden.<field> |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      | overlijden.indicatieOverleden | true      |

      Voorbeelden:
      | naam gba element          | field  |
      | plaats overlijden (08.20) | plaats |
      | land overlijden (08.30)   | land   |

  Rule: leeftijd veld wordt niet geleverd voor overleden personen

    Scenario: overleden persoon wordt geraadpleegd met burgerservicenummer, leeftijd wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | leeftijd                        |
      Dan heeft de response een persoon met alleen de volgende 'overlijden' gegevens
      | naam               | waarde |
      | indicatieOverleden | true   |

  Rule: indicatieOverleden is in onderzoek wanneer ten minste één van de andere overlijden gegevens in onderzoek zijn

    Abstract Scenario: <gegeven in onderzoek> is in onderzoek en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | datum overlijden (08.10)        | 20020701                  |
      | plaats overlijden (08.20)       | 0518                      |
      | land overlijden (08.30)         | 6030                      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                    | waarde      |
      | burgerservicenummer                                     | 000000152   |
      | overlijden.indicatieOverleden                           | true        |
      | overlijden.inOnderzoek.indicatieOverleden               | true        |
      | overlijden.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | overlijden.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | overlijden.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | gegeven in onderzoek | gba in onderzoek waarde |
      | categorie overlijden | 060000                  |
      | groep overlijden     | 060800                  |
      | datum overlijden     | 060810                  |
      | plaats overlijden    | 060820                  |
      | land overlijden      | 060830                  |