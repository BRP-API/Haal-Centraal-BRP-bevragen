#language: nl

@post-assert
Functionaliteit: Persoon

  Abstract Scenario: persoon heeft veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    | <gba naam>          | <waarde>  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,<naam>      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    | <naam>              | <waarde>  |

    Voorbeelden:
    | gba naam                    | naam                  | waarde     |
    | anummer (01.10)             | aNummer               | 1234567890 |
    | geslachtsaanduiding (04.10) | geslacht.code         | M          |
    | geslacht.omschrijving       | geslacht.omschrijving | man        |

  Abstract Scenario: persoon heeft veld: 'indicatie geheim (70.10)'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                     | waarde       |
    | burgerservicenummer      | 555550001    |
    | indicatie geheim (70.10) | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 555550001                                         |
    | fields              | burgerservicenummer,geheimhoudingPersoonsgegevens |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 555550001 |
    | geheimhoudingPersoonsgegevens | <waarde>  |

    Voorbeelden:
    | gba waarde | waarde |
    | 0          |        |
    | 1          | true   |
    | 2          | true   |
    | 3          | true   |
    | 4          | true   |
    | 5          | true   |
    | 6          | true   |
    | 7          | true   |

  Abstract Scenario: persoon heeft datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde       |
    | burgerservicenummer | 555550001    |
    | <gba naam>          | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,<naam>      |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde         |
    | burgerservicenummer | 555550001      |
    | <naam>.type         | Datum          |
    | <naam>.datum        | <waarde>       |
    | <naam>.langFormaat  | <lang formaat> |

    Voorbeelden:
    | gba naam                              | gba waarde | naam                       | waarde     | lang formaat |
    | datum eerste inschrijving GBA (68.10) | 20020701   | datumEersteInschrijvingGBA | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: persoon's velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                     | waarde                    |
    | burgerservicenummer                      | 555550001                 |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 555550001                             |
    | fields              | burgerservicenummer,geslacht,leeftijd |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                         | waarde                             |
    | burgerservicenummer                          | 555550001                          |
    | inOnderzoek.burgerservicenummer              | <burgerservicenummer in onderzoek> |
    | inOnderzoek.geslacht                         | <geslacht in onderzoek>            |
    | inOnderzoek.leeftijd                         | <leeftijd in onderzoek>            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                              |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                         |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | burgerservicenummer in onderzoek | geslacht in onderzoek | leeftijd in onderzoek |
    | 010000                  | true                             | true                  | true                  |
    | 010100                  | true                             |                       |                       |
    | 010120                  | true                             |                       |                       |
    | 010400                  |                                  | true                  |                       |
    | 010410                  |                                  | true                  |                       |

  Abstract Scenario: persoon's naam velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                     | waarde                    |
    | burgerservicenummer                      | 555550001                 |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Groen  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | naam                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde                                      |
    | geslachtsnaam                                | Groen                                       |
    | volledigeNaam                                | Groen                                       |
    | inOnderzoek.voornamen                        | <voornamen in onderzoek>                    |
    | inOnderzoek.adellijkeTitelPredicaat          | <adellijke titel of predicaat in onderzoek> |
    | inOnderzoek.voorvoegsel                      | <voorvoegsel in onderzoek>                  |
    | inOnderzoek.geslachtsnaam                    | <geslachtsnaam in onderzoek>                |
    | inOnderzoek.aanduidingNaamgebruik            | <aanduiding naamgebruik in onderzoek>       |
    | inOnderzoek.voorletters                      | <voorletters in onderzoek>                  |
    | inOnderzoek.volledigeNaam                    | <volledige naam in onderzoek>               |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                 |

    Voorbeelden:
    | gba in onderzoek waarde | voornamen in onderzoek | adellijke titel of predicaat in onderzoek | voorvoegsel in onderzoek | geslachtsnaam in onderzoek | aanduiding naamgebruik in onderzoek | voorletters in onderzoek | volledige naam in onderzoek |
    | 010000                  | true                   | true                                      | true                     | true                       | true                                | true                     | true                        |
    | 010200                  | true                   | true                                      | true                     | true                       |                                     | true                     | true                        |
    | 010210                  | true                   |                                           |                          |                            |                                     | true                     | true                        |
    | 010220                  |                        | true                                      |                          |                            |                                     |                          | true                        |
    | 010230                  |                        |                                           | true                     |                            |                                     |                          | true                        |
    | 010240                  |                        |                                           |                          | true                       |                                     |                          | true                        |
    | 016100                  |                        |                                           |                          |                            | true                                |                          |                             |
    | 016110                  |                        |                                           |                          |                            | true                                |                          |                             |

  Abstract Scenario: persoon's geboorte velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                     | waarde                    |
    | burgerservicenummer                      | 555550001                 |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19630405 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | geboorte                        |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                                         | waarde                |
    | datum.type                                   | Datum                 |
    | datum.datum                                  | 1963-04-05            |
    | datum.langFormaat                            | 5 april 1963          |
    | inOnderzoek.datum                            | <datum in onderzoek>  |
    | inOnderzoek.plaats                           | <plaats in onderzoek> |
    | inOnderzoek.land                             | <land in onderzoek>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                 |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01            |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002           |

    Voorbeelden:
    | gba in onderzoek waarde | datum in onderzoek | plaats in onderzoek | land in onderzoek |
    | 010000                  | true               | true                | true              |
    | 010300                  | true               | true                | true              |
    | 010310                  | true               |                     |                   |
    | 010320                  |                    | true                |                   |
    | 010330                  |                    |                     | true              |

  Abstract Scenario: geboortedatum is een volledig datum
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde  |
    | geboortedatum (03.10) | <datum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam     | waarde     |
    | leeftijd | <leeftijd> |

    Voorbeelden:
    | datum              | leeftijd |
    | vandaag - 10 jaar  | 10       |
    | gisteren - 15 jaar | 15       |
    | morgen - 20 jaar   | 19       |

  Scenario: geboortedatum is een onbekend datum
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,leeftijd    |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |

  Scenario: maand en dag van geboortedatum is onbekend
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 20000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,leeftijd    |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |

  Abstract Scenario: dag van geboortedatum is onbekend
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde          |
    | geboortedatum (03.10) | <geboortedatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | burgerservicenummer,leeftijd    |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 555550001  |
    | leeftijd            | <leeftijd> |

    Voorbeelden:
    | geboortedatum            | leeftijd |
    | volgende maand - 10 jaar | 9        |
    | vorige maand - 10 jaar   | 10       |
    | deze maand - 10 jaar     |          |

  Scenario: persoon is overleden
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550007 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20040319 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550007                       |
    | fields              | burgerservicenummer,leeftijd    |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550007 |
