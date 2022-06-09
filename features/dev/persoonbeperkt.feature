#language: nl

@post-assert
Functionaliteit: PersoonBeperkt

  Abstract Scenario: persoon heeft veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    | <gba naam>          | <waarde>  |
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
    | burgerservicenummer      | 999995078    |
    | indicatie geheim (70.10) | <gba waarde> |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                            |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum               |
    | geslachtsnaam | Maassen                                           |
    | geboortedatum | 1983-05-26                                        |
    | fields        | burgerservicenummer,geheimhoudingPersoonsgegevens |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 999995078 |
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

  Abstract Scenario: geboortedatum is een volledig datum
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En de persoon heeft de volgende 'naam' gegevens
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
