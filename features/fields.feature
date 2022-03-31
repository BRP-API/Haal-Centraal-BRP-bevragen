#language: nl

@post-assert
Functionaliteit: Fields
  Als consumer van de BRP API
  Wil ik kunnen aangeven welke gegevens van de gevonden personen ik terug wil krijgen
  Zodat ik alleen de gegevens terug krijg waarvoor ik doelbinding heb

  Achtergrond:
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                  | waarde     |
      | aNummer (01.10)                       | 2352984859 |
      | burgerservicenummer                   | 999995078  |
      | geslachtsaanduiding (04.10)           | M          |
      | geslachtsaanduiding.omschrijving      | man        |
      | geheimhoudingPersoonsgegevens (70.10) | 0          |
      | inOnderzoek (83.10)                   |            |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde   |
      | voornamen (02.10)                    | Franklin |
      | naam.adellijkeTitelPredicaat (02.20) |          |
      | voorvoegsel (02.30)                  | in den   |
      | geslachtsnaam (02.40)                | Groenen  |
      | aanduidingNaamgebruik (61.10)        | E        |
      En de persoon heeft een partner met de volgende gegevens
      | naam                             | waarde    |
      | burgerservicenummer              | 999992935 |
      | naam.voornamen (02.10)           | Marlies   |
      | geboorte.plaats (03.20)          | 0000      |
      | geslachtsaanduiding.omschrijving | vrouw     |
      En de persoon heeft GEEN 'overlijden' gegevens
      En de persoon heeft de volgende 'kiesrecht' gegevens
      | naam                            | waarde |
      | uitgeslotenVanKiesrecht (38.10) | true   |

  Rule: De API levert alleen velden die gevraagd zijn met de fields parameter
    - gebruik van de fields parameter is verplicht
    - een veld wordt gevraagd door de veldnaam op te nemen in fields
    - vraag meerdere velden door de veldnamen door een komma gescheiden op te nemen
    - veldnamen zijn case sensitive
    - een veld in een groep of collectie kan worden gevraagd door het pad met punt gescheiden op te geven
    - alle velden van een groep kunnen worden gevraagd door de veldnaam van de groep in fields op te nemen
    - de volgorde van veldnamen in fields heeft geen invloed op de volgorde van velden in de response
    - wanneer een gevraagd veld geen waarde heeft voor de persoon, wordt het veld niet opgenomen in de response

    Scenario: Gevraagd veld is een 'root' gegeven van de persoon
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999995078                       |
      | fields              | burgerservicenummer             |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |

    Scenario: Gevraagd velden zijn 'root' gegevens van de persoon
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999995078                       |
      | fields              | burgerservicenummer,aNummer     |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde     |
      | burgerservicenummer | 999995078  |
      | aNummer             | 2352984859 |

    Scenario: Gevraagd veld is een gegeven van een gegevensgroep van de persoon
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                       |
      | type                | RaadpleegMetBurgerservicenummer              |
      | burgerservicenummer | 999995078                                    |
      | fields              | burgerservicenummer,geslachtsaanduiding.code |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                     | waarde    |
      | burgerservicenummer      | 999995078 |
      | geslachtsaanduiding.code | M         |

    Scenario: Gevraagd veld is een gegevensgroep van de persoon
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 999995078                               |
      | fields              | burgerservicenummer,geslachtsaanduiding |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
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
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |
      En heeft de persoon met burgerservicenummer '999995078' alleen de volgende 'naam' gegevens
      | naam          | waarde   |
      | geslachtsnaam | Groenen  |
      | voornamen     | Franklin |

    Scenario: Gevraagde velden zijn gegevens van meerdere gegevensgroepen van de persoon
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                          |
      | type                | RaadpleegMetBurgerservicenummer                                 |
      | burgerservicenummer | 999995078                                                       |
      | fields              | burgerservicenummer,geslachtsaanduiding.code,naam.geslachtsnaam |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                     | waarde    |
      | burgerservicenummer      | 999995078 |
      | geslachtsaanduiding.code | M         |
      En heeft de persoon met burgerservicenummer '999995078' alleen de volgende 'naam' gegevens
      | naam          | waarde  |
      | geslachtsnaam | Groenen |

    Scenario: Gevraagd veld is een gegeven van een gegevensgroep collectie van de persoon
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                         |
      | type                | RaadpleegMetBurgerservicenummer                                |
      | burgerservicenummer | 999995078                                                      |
      | fields              | burgerservicenummer,partners.type,partners.burgerservicenummer |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |
      En heeft de persoon met burgerservicenummer '999995078' een 'partner' met alleen de volgende gegevens
      | naam                | waarde    |
      | type                | Partner   |
      | burgerservicenummer | 999992935 |

    Abstract Scenario: Gevraagd veld heeft geen waarde voor de persoon
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999995078                       |
      | fields              | burgerservicenummer,<veld>      |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |

      Voorbeelden:
      | veld                            | opmerking                                                       |
      | naam.adellijkeTitelPredicaat    |                                                                 |
      | inOnderzoek.geslachtsaanduiding |                                                                 |
      | geheimhoudingPersoonsgegevens   | geheimhoudingPersoonsgegevens wordt niet opgenomen bij waarde 0 |
      | partners.geboorte.plaats        | plaats wordt niet opgenomen bij standaardwaarde 0000            |

  Rule: optioneel mag je (het begin van) het pad weglaten wanneer dit uniek verwijst naar 1 veld in de resource
    - wanneer het opgegeven pad exact verwijst naar een veld en tegelijkertijd als deel van een pad verwijst naar een ander veld, wordt alleen het veld met het exacte pad opgenomen in de response
    - wanneer het opgegeven pad niet exact verwijst naar een veld en tegelijkertijd als deel van een pad verwijst naar meerdere ander velden, wordt een foutmelding gegeven
    - wanneer het opgegeven pad verwijst naar een veld en tegelijkertijd naar het gelijknamige veld in inOnderzoek, worden beide velden opgenomen in de response wanneer ze een waarde hebben

    # zie fields-mapping.csv voor een overzicht van alle mogelijke gehele of gedeeltelijke paden voor het aanwijzen van de personen velden: 
    #  een fields veld(pad) in de linker kolom wordt vertaald naar het volledig pad in de tweede kolom
    #  wanneer een in fields opgegeven veld(pad) niet voorkomt in de linker kolom, geeft dat een foutmelding

    Abstract Scenario: opgeven <pad> levert het veld
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999995078                       |
      | fields              | burgerservicenummer,<pad>       |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                            | waarde    |
      | burgerservicenummer             | 999995078 |
      | naam.aanduidingNaamgebruik.code | E         |

      Voorbeelden:
      | pad                             |
      | naam.aanduidingNaamgebruik.code |
      | aanduidingNaamgebruik.code      |

    Abstract Scenario: opgegeven pad is volledig pad én deel van pad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999995078                       |
      | fields              | burgerservicenummer,<pad>       |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |
      | <pad>               | <waarde>  |

      Voorbeelden:
      | pad                              | waarde    | opmerking                                                                               |
      | geslachtsaanduiding.omschrijving | man       | levert geslachtsaanduiding.omschrijving, niet partners.geslachtsaanduiding.omschrijving |
      | naam.voornamen                   | Franklin  | levert naam.voornamen, niet partners.naam.voornamen                                     |    

  Rule: Wanneer velden van polymorfe gegevensgroep wordt gevraagd, wordt altijd het 'type' veld van de gegevensgroep terug gegeven
    - wanneer het gegeven geen waarde heeft (ook niet onbekend) wordt de gegevensgroep niet geleverd en dus ook 'type' niet teruggegeven

    Abstract Scenario: Gevraagd veld is een polymorfe gegevensgroep van de persoon
      Gegeven de persoon heeft de volgende 'geboorte' gegevens
      | naam  | waarde      |
      | datum | <GBA datum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 999995078                          |
      | fields              | burgerservicenummer,geboorte.datum |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |
      En heeft de persoon met burgerservicenummer '999995078' alleen de volgende 'geboorte' gegevens
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

    Abstract Scenario: Gevraagd veld is een gegeven van een andere type van de polymorfe gegevensgroep
      Gegeven de persoon heeft de volgende 'geboorte' gegevens
      | naam  | waarde      |
      | datum | <GBA datum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                   |
      | type                | RaadpleegMetBurgerservicenummer          |
      | burgerservicenummer | 999995078                                |
      | fields              | burgerservicenummer,geboorte.datum.datum |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |
      En heeft de persoon met burgerservicenummer '999995078' alleen de volgende 'geboorte' gegevens
      | naam       | waarde |
      | datum.type | <type> |

      Voorbeelden:
      | GBA datum | type           |
      | 20020200  | JaarMaandDatum |
      | 20020000  | JaarDatum      |
      | 00000000  | OnbekendDatum  |

    Abstract Scenario: Gevraagd veld is een polymorfe gegevensgroep van de persoon en heeft geen waarde
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                   |
      | type                | RaadpleegMetBurgerservicenummer          |
      | burgerservicenummer | 999995078                                |
      | fields              | burgerservicenummer,overlijden.datum,kiesrecht.uitgeslotenVanKiesrecht,kiesrecht.einddatumUitsluitingKiesrecht |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |
      En heeft de persoon met burgerservicenummer '999995078' GEEN 'overlijden' gegevens
      En heeft de persoon met burgerservicenummer '999995078' alleen de volgende 'kiesrecht' gegevens
      | naam                    | waarde |
      | uitgeslotenVanKiesrecht | true   |

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
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
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
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |
      | datum              | 20151001   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999995078                       |
      | fields              | burgerservicenummer             |
      Dan heeft de persoon met burgerservicenummer '999995078' alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999995078 |
      En heeft de persoon met burgerservicenummer '999995078' alleen de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |

  Rule: Wanneer een gevraagd veld in onderzoek is, dan wordt het corresponderende in onderzoek veld altijd terug gegeven
    # Scenario's worden toegevoegd als in onderzoek feature is geïmplementeerd
