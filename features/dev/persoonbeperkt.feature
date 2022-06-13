#language: nl

@post-assert
Functionaliteit: PersoonBeperkt

  Abstract Scenario: persoon heeft veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <naam>                              |
    Dan heeft de response een persoon met de volgende gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                    | naam                  | waarde    |
    | burgerservicenummer         | burgerservicenummer   | 999995078 |
    | geslachtsaanduiding (04.10) | geslacht.code         | M         |
    | geslacht.omschrijving       | geslacht.omschrijving | man       |

  Abstract Scenario: persoon heeft veld: 'indicatie geheim (70.10)'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                     | waarde       |
    | indicatie geheim (70.10) | <gba waarde> |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | geheimhoudingPersoonsgegevens       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | geheimhoudingPersoonsgegevens | <waarde>  |

    Voorbeelden:
    | gba waarde | waarde |
    | 1          | true   |
    | 2          | true   |
    | 3          | true   |
    | 4          | true   |
    | 5          | true   |
    | 6          | true   |
    | 7          | true   |

  Scenario: persoon heeft veld: 'indicatie geheim (70.10)' met waarde 0
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                     | waarde       |
    | indicatie geheim (70.10) | 0 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | geheimhoudingPersoonsgegevens       |
    Dan heeft de response een leeg persoon object

  Abstract Scenario: geboortedatum is een volledig datum
    Gegeven het systeem heeft een persoon met de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde  |
    | geboortedatum (03.10) | <datum> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | <datum>                             |
    | fields        | leeftijd                            |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam     | waarde     |
    | leeftijd | <leeftijd> |

    Voorbeelden:
    | datum              | leeftijd |
    | vandaag - 10 jaar  | 10       |
    | gisteren - 15 jaar | 15       |
    | morgen - 20 jaar   | 19       |

  Abstract Scenario: gevraagde veld heeft geen waarde
    Gegeven het systeem heeft een persoon met de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 20020202 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 2002-02-02                          |
    | fields        | <fields>                            |
    Dan heeft de response een leeg persoon object

    Voorbeelden:
    | fields                        |
    | burgerservicenummer           |
    | geheimhoudingPersoonsgegevens |
    | geslacht                      |
    | geslacht.code                 |
    | geslacht.omschrijving         |
