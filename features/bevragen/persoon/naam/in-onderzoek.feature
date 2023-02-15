#language: nl

Functionaliteit: naam velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle naam velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde               |
    | inOnderzoek.voornamen                        | <voornamen io>       |
    | inOnderzoek.adellijkeTitelPredicaat          | <titel/predicaat io> |
    | inOnderzoek.voorvoegsel                      | <voorvoegsel io>     |
    | inOnderzoek.geslachtsnaam                    | <geslachtsnaam io>   |
    | inOnderzoek.aanduidingNaamgebruik            | <naamgebruik io>     |
    | inOnderzoek.voorletters                      | <voorletters io>     |
    | inOnderzoek.volledigeNaam                    | <volledige naam io>  |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01           |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002          |

    Voorbeelden:
    | aanduiding in onderzoek | voornamen io | titel/predicaat io | voorvoegsel io | geslachtsnaam io | naamgebruik io | voorletters io | volledige naam io | type                      |
    | 010000                  | true         | true               | true           | true             | true           | true           | true              | hele categorie persoon    |
    | 010200                  | true         | true               | true           | true             |                | true           | true              | hele groep naam           |
    | 010210                  | true         |                    |                |                  |                | true           | true              | voornamen                 |
    | 010220                  |              | true               |                |                  |                |                | true              | adellijke titel/predicaat |
    | 010230                  |              |                    | true           |                  |                |                | true              | voorvoegsel               |
    | 010240                  |              |                    |                | true             |                |                | true              | geslachtsnaam             |
    | 010400                  |              |                    |                |                  |                |                | true              | hele groep geslacht       |
    | 010410                  |              |                    |                |                  |                |                | true              | geslachtsaanduiding       |
    | 016100                  |              |                    |                |                  | true           |                |                   | hele groep naamgebruik    |
    | 016110                  |              |                    |                |                  | true           |                |                   | aanduiding naamgebruik    |

  Abstract Scenario: '<type>' is in onderzoek en voornamen wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voornamen                  |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voornamen                                    | Jan         |
    | inOnderzoek.voornamen                        | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 010200                  | hele groep naam        |
    | 010210                  | voornamen              |

  Abstract Scenario: '<type>' is in onderzoek en voorvoegsel wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voorvoegsel (02.30)             | van de                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voorvoegsel                |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorvoegsel                                  | van de      |
    | inOnderzoek.voorvoegsel                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 010200                  | hele groep naam        |
    | 010230                  | voorvoegsel            |

  Abstract Scenario: '<type>' is in onderzoek en geslachtsnaam wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.geslachtsnaam              |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | geslachtsnaam                                | Jansen      |
    | inOnderzoek.geslachtsnaam                    | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 010200                  | hele groep naam        |
    | 010240                  | geslachtsnaam          |

  Abstract Scenario: '<type>' is in onderzoek en adellijkeTitelPredicaat wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | adellijke titel of predicaat (02.20) | JH                        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.adellijkeTitelPredicaat    |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | adellijkeTitelPredicaat.code                 | JH          |
    | adellijkeTitelPredicaat.omschrijving         | jonkheer    |
    | adellijkeTitelPredicaat.soort                | predicaat   |
    | inOnderzoek.adellijkeTitelPredicaat          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                      |
    | 010000                  | hele categorie persoon    |
    | 010200                  | hele groep naam           |
    | 010220                  | adellijke titel/predicaat |

  Abstract Scenario: '<type>' is in onderzoek en aanduidingNaamgebruik wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | aanduiding naamgebruik (61.10)  | V                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.aanduidingNaamgebruik      |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde                                                                  |
    | aanduidingNaamgebruik.code                   | V                                                                       |
    | aanduidingNaamgebruik.omschrijving           | geslachtsnaam echtgenoot/geregistreerd partner voor eigen geslachtsnaam |
    | inOnderzoek.aanduidingNaamgebruik            | true                                                                    |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                                                   |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                                              |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                                             |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 016100                  | hele groep naamgebruik |
    | 016110                  | aanduiding naamgebruik |

  Abstract Scenario: '<type>' is in onderzoek en voorletters wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voorletters                |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | voorletters                                  | J.          |
    | inOnderzoek.voorletters                      | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 010200                  | hele groep naam        |
    | 010210                  | voornamen              |

  Abstract Scenario: '<type>' is in onderzoek en volledigeNaam wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | voornamen (02.10)               | Jan                       |
    | geslachtsnaam (02.40)           | Jansen                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.volledigeNaam              |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde      |
    | volledigeNaam                                | Jan Jansen  |
    | inOnderzoek.volledigeNaam                    | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                      |
    | 010000                  | hele categorie persoon    |
    | 010200                  | hele groep naam           |
    | 010210                  | voornamen                 |
    | 010220                  | adellijke titel/predicaat |
    | 010230                  | voorvoegsel               |
    | 010240                  | geslachtsnaam             |
    | 010400                  | hele groep geslacht       |
    | 010410                  | geslachtsaanduiding       |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.<field>                    |
    Dan heeft de response een persoon zonder 'naam' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | field                   | type                      |
    | 010210                  | adellijkeTitelPredicaat | voornamen                 |
    | 010220                  | voorvoegsel             | adellijke titel/predicaat |
    | 010230                  | geslachtsnaam           | voorvoegsel               |
    | 010240                  | aanduidingNaamgebruik   | geslachtsnaam             |
    | 016100                  | geslachtsnaam           | hele groep naamgebruik    |
    | 016110                  | voornamen               | aanduiding naamgebruik    |
