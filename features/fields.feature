#language: nl

@post-assert
Functionaliteit: Fields
  Als consumer van de BRP API
  Wil ik kunnen aangeven welke gegevens van de gevonden personen ik terug wil krijgen
  Zodat ik alleen de gegevens terug krijg waarvoor ik doelbinding heb

  Achtergrond:
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                             | waarde    |
    | anummer                          | 123456789 |
    | burgerservicenummer              | 999995078 |
    | geslachtsaanduiding (04.10)      | M         |
    | geslachtsaanduiding.omschrijving | man       |
    En de persoon heeft de volgende 'naam' gegevens
    | naam          | waarde   |
    | geslachtsnaam | Groenen  |
    | voornamen     | Franklin |
    En de persoon heeft een partner met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992935 |

  Scenario: Gevraagde veld is een 'root' gegeven van de persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999995078                       |
    | fields              | burgerservicenummer             |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |

  Scenario: Gevraagde velden zijn 'root' gegevens van de persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999995078                       |
    | fields              | burgerservicenummer,aNummer     |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    | aNummer             | 123456789 |

  Scenario: Gevraagde veld is een gegeven van een gegevensgroep van de persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 999995078                                    |
    | fields              | burgerservicenummer,geslachtsaanduiding.code |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                     | waarde    |
    | burgerservicenummer      | 999995078 |
    | geslachtsaanduiding.code | M         |

  Scenario: Gevraagde veld is een gegevensgroep van de persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999995078                               |
    | fields              | burgerservicenummer,geslachtsaanduiding |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                             | waarde    |
    | burgerservicenummer              | 999995078 |
    | geslachtsaanduiding.code         | M         |
    | geslachtsaanduiding.omschrijving | man       |

  Scenario: Gevraagde velden zijn gegevens van één gegevengroep van de persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                |
    | type                | RaadpleegMetBurgerservicenummer                       |
    | burgerservicenummer | 999995078                                             |
    | fields              | burgerservicenummer,naam.geslachtsnaam,naam.voornamen |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En heeft de persoon met burgerservicenummer '999995078' de volgende 'naam' gegevens
    | naam          | waarde   |
    | geslachtsnaam | Groenen  |
    | voornamen     | Franklin |

  Scenario: Gevraagde velden zijn gegevens van meerdere gegevensgroepen van de persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                    |
    | type                | RaadpleegMetBurgerservicenummer                                           |
    | burgerservicenummer | 999995078                                                                 |
    | fields              | burgerservicenummer,geslachtsaanduiding,naam.geslachtsnaam,naam.voornamen |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                             | waarde    |
    | burgerservicenummer              | 999995078 |
    | geslachtsaanduiding.code         | M         |
    | geslachtsaanduiding.omschrijving | man       |
    En heeft de persoon met burgerservicenummer '999995078' de volgende 'naam' gegevens
    | naam          | waarde   |
    | geslachtsnaam | Groenen  |
    | voornamen     | Franklin |

  Scenario: Gevraagde veld is een gegeven van een gegevensgroep collectie van de persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                           |
    | type                | RaadpleegMetBurgerservicenummer                  |
    | burgerservicenummer | 999995078                                        |
    | fields              | burgerservicenummer,partners.burgerservicenummer |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En heeft de persoon met burgerservicenummer '999995078' een 'partner' met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992935 |
    | type                | Partner   |

  Abstract Scenario: Gevraagde veld heeft geen waarde voor de persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999995078                       |
    | fields              | burgerservicenummer,<veld>      |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |

    Voorbeelden:
    | veld                          |
    | geheimhoudingPersoonsgegevens |
    | naam.voorvoegsel              |

Rule: Wanneer velden van polymorf gegevensgroep wordt gevraagd, wordt altijd het 'type' veld van de gegevensgroep terug gegeven

  Abstract Scenario: Gevraagde veld is een polymorf gegevensgroep van de persoon
    Gegeven de persoon heeft de volgende 'geboorte' gegevens
    | naam  | waarde      |
    | datum | <GBA datum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999995078                          |
    | fields              | burgerservicenummer,geboorte.datum |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En heeft de persoon met burgerservicenummer '999995078' de volgende 'geboorte' gegevens
    | naam           | waarde     |
    | datum.type     | <type>     |
    | datum.datum    | <datum>    |
    | datum.jaar     | <jaar>     |
    | datum.maand    | <maand>    |
    | datum.onbekend | <onbekend> |

    Voorbeelden:
    | GBA datum | type           | datum      | jaar | maand | onbekend |
    | 20020220  | Datum          | 2002-02-20 |      |       |          |
    | 20020200  | JaarMaandDatum |            | 2002 | 2     |          |
    | 20020000  | JaarDatum      |            | 2002 |       |          |
    | 00000000  | OnbekendDatum  |            |      |       | true     |

  Abstract Scenario: Gevraagde veld is een gegeven van een andere type van de polymorf gegevensgroep
    Gegeven de persoon heeft de volgende 'geboorte' gegevens
    | naam  | waarde      |
    | datum | <GBA datum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 999995078                                |
    | fields              | burgerservicenummer,geboorte.datum.datum |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En heeft de persoon met burgerservicenummer '999995078' de volgende 'geboorte' gegevens
    | naam       | waarde |
    | datum.type | <type> |

    Voorbeelden:
    | GBA datum | type           |
    | 20020200  | JaarMaandDatum |
    | 20020000  | JaarDatum      |
    | 00000000  | OnbekendDatum  |

Rule: Wanneer een persoon geheimhouding heeft, wordt dit bij elke vraag terug gegeven

  Abstract Scenario: Persoon heeft <titel>
    Gegeven de persoon heeft de volgende gegevens
    | naam                          | waarde              |
    | geheimhoudingPersoonsgegevens | <gba geheimhouding> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999995078                       |
    | fields              | burgerservicenummer             |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                          | waarde          |
    | burgerservicenummer           | 999995078       |
    | geheimhoudingPersoonsgegevens | <geheimhouding> |

    Voorbeelden:
    | titel              | gba geheimhouding | geheimhouding |
    | wel geheimhouding  | 7                 | true          |
    | wel geheimhouding  | 6                 | true          |
    | wel geheimhouding  | 5                 | true          |
    | wel geheimhouding  | 4                 | true          |
    | wel geheimhouding  | 3                 | true          |
    | wel geheimhouding  | 2                 | true          |
    | wel geheimhouding  | 1                 | true          |
    | geen geheimhouding | 0                 |               |

Rule: Wanneer een persoon is opgeschort en de reden hiervan is bekend, dan wordt dit bij elke vraag terug gegeven

  Scenario: persoon heeft opschorting bijhouding
    En de persoon heeft de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde               |
    | reden.code         | overlijden           |
    | reden.omschrijving | persoon is overleden |
    | datum              | 20151001             |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999995078                       |
    | fields              | burgerservicenummer             |
    Dan heeft de persoon met burgerservicenummer '999995078' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En heeft de persoon met burgerservicenummer '999995078' de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde               |
    | reden.code         | overlijden           |
    | reden.omschrijving | persoon is overleden |

Rule: Wanneer een gevraagde veld in onderzoek is, dan wordt het corresponderende in onderzoek veld altijd terug gegeven
  # Scenario's worden toegevoegd als in onderzoek feature is geïmplementeerd
  # Fout-cases worden in een aparte feature file beschreven
