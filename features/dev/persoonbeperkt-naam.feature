#language: nl

@post-assert
Functionaliteit: Naam velden van PersoonBeperkt

  Scenario: persoon heeft 'naam' veld: 'geslachtsnaam (02.40)'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
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
    | fields        | naam.geslachtsnaam                  |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde  |
    | geslachtsnaam | Maassen |

  Abstract Scenario: persoon heeft 'naam' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | <gba naam>            | <waarde> |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.<naam>                         |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                             | naam                                 | waarde      |
    | voornamen (02.10)                    | voornamen                            | voornamen   |
    | voorvoegsel (02.30)                  | voorvoegsel                          | voorvoegsel |
    | adellijke titel of predicaat (02.20) | adellijkeTitelPredicaat.code         | JH          |
    | adellijkeTitelPredicaat.omschrijving | adellijkeTitelPredicaat.omschrijving | jonkheer    |

  Scenario: persoon heeft 'naam' veld: 'voorletters'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde     |
    | geslachtsnaam (02.40) | Maassen    |
    | voornamen (02.10)     | Jan Pieter |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.voorletters                    |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | J.P.   |

  Scenario: persoon heeft 'naam' veld: 'volledigeNaam'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde     |
    | geslachtsnaam (02.40) | Maassen    |
    | voorvoegsel (02.30)   | van den    |
    | voornamen (02.10)     | Jan Pieter |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.volledigeNaam                  |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde                     |
    | volledigeNaam | Jan Pieter van den Maassen |
