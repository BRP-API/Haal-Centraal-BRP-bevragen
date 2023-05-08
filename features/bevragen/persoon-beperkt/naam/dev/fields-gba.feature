#language: nl

@gba
Functionaliteit: naam velden vragen met fields (persoon beperkt)

  Scenario: 'voorletters' wordt gevraagd met field pad 'naam.voorletters'
    Gegeven de persoon met burgerservicenummer '000000413' heeft de volgende gegevens
    | naam                  | waarde     |
    | geslachtsnaam (02.40) | Maassen    |
    | geboortedatum (03.10) | 19830526   |
    | voornamen (02.10)     | Jan Pieter |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.voorletters                    |
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam      | waarde     |
    | voornamen | Jan Pieter |

  Abstract Scenario: 'volledige naam' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                                 | waarde     |
    | geslachtsaanduiding (04.10)          | V          |
    | geslachtsnaam (02.40)                | Maassen    |
    | geboortedatum (03.10)                | 19830526   |
    | voorvoegsel (02.30)                  | van den    |
    | voornamen (02.10)                    | Jan Pieter |
    | adellijke titel of predicaat (02.20) | JH         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde |
    | geslacht.code         | V      |
    | geslacht.omschrijving | vrouw  |
    En heeft de persoon de volgende 'naam' gegevens
    | naam                                 | waarde     |
    | geslachtsnaam                        | Maassen    |
    | voorvoegsel                          | van den    |
    | voornamen                            | Jan Pieter |
    | adellijkeTitelPredicaat.code         | JH         |
    | adellijkeTitelPredicaat.soort        | predicaat  |
    | adellijkeTitelPredicaat.omschrijving | jonkheer   |

    Voorbeelden:
    | fields             |
    | naam.volledigeNaam |
    | naam               |
