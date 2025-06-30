# language: nl

Functionaliteit: overlijden

  Wanneer een consumer van de BRP API gegevens bevraagt van een overleden persoon
  Dan wil de consumer hiervan worden geattendeerd middels een indicatie bij de gevraagde gegevens zonder expliciet om overlijden gegevens te vragen met de fields parameter

  Regel: opschorting bijhouding met reden "O" wordt altijd geleverd als de gevraagde persoon is overleden. Ook als het niet met fields is gevraagd

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

    Scenario: overlijden gegevens wordt niet gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |
      En heeft de persoon de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |

    Scenario: datum overlijden wordt gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
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
      | datum.type         | Datum       |
      | datum.datum        | 2002-07-01  |
      | datum.langFormaat  | 1 juli 2002 |
      En heeft de persoon de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |

    Abstract Scenario: <field> overlijden met waarde onbekend wordt gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20020701 |
      | <naam gba element>       | 0000     |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000152                              |
      | fields              | burgerservicenummer,overlijden.<field> |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      En heeft de persoon de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |
      En heeft de persoon geen 'overlijden' gegevens

      Voorbeelden:
      | naam gba element          | field  |
      | plaats overlijden (08.20) | plaats |
      | land overlijden (08.30)   | land   |

  Regel: leeftijd veld wordt niet geleverd voor overleden personen

    Scenario: leeftijd wordt gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geboortedatum (03.10) |
      | 19500304              |
      En de persoon heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | leeftijd                        |
      Dan heeft de response een persoon met alleen de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |
