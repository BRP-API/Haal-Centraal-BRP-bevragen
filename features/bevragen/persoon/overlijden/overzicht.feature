# language: nl

Functionaliteit: Persoon: overlijden

  Wanneer een consumer van de BRP API gegevens bevraagd van een overleden persoon
  Dan wil de consumer hiervan worden geattendeerd middels een indicatie bij de gevraagde gegevens zonder expliciet om overlijden gegevens te vragen met de fields parameter

  Rule: indicatieOverleden heeft de waarde true als de gevraagde persoon is overleden. Dit veld wordt altijd meegeleverd, ook als het niet met fields is gevraagd

    Abstract Scenario: <sub titel> van een niet-overleden persoon
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

    Abstract Scenario: overlijden gegevens wordt niet gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | naam                     | waarde             |
      | datum overlijden (08.10) | <datum overlijden> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      | overlijden.indicatieOverleden | true      |

      Voorbeelden:
      | datum overlijden |
      | 20020701         |
      | 20020700         |
      | 20020000         |
      | 00000000         |

    Scenario: datum overlijden wordt gevraagd van een overleden persoon
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

    Abstract Scenario: <field> overlijden met waarde onbekend wordt gevraagd van een overleden persoon
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

    Scenario: leeftijd wordt gevraagd van een overleden persoon
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

  Rule: indicatieOverleden is in onderzoek wanneer 'datum overlijden (08.10)' in onderzoek is

    Abstract Scenario: <type> is in onderzoek en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | datum overlijden (08.10)        | 20020701                  |
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
      | aanduiding in onderzoek | type                      |
      | 060000                  | hele categorie overlijden |
      | 060800                  | hele groep overlijden     |
      | 060810                  | datum overlijden          |

    Abstract Scenario: <type> is in onderzoek en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | datum overlijden (08.10)        | 20020701                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      | overlijden.indicatieOverleden | true      |

      Voorbeelden:
      | aanduiding in onderzoek | type              |
      | 060820                  | plaats overlijden |
      | 060830                  | land overlijden   |
