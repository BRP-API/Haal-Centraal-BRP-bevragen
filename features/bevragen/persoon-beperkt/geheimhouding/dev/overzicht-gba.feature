# language: nl

@gba
Functionaliteit: geheimhouding - niet verstrekken van gegevens van een persoon aan derden (persoon beperkt)

  Abstract Scenario: 'indicatie geheim (70.10)' met waarde <waarde> wordt gevraagd met veld pad 'geheimhoudingPersoonsgegevens'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Jansen                | 19630405              |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde   |
    | indicatie geheim (70.10) | <waarde> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1963-04-05                          |
    | fields        | geheimhoudingPersoonsgegevens       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde   |
    | geheimhoudingPersoonsgegevens | <waarde> |

    Voorbeelden:
    | waarde |
    | 1      |
    | 2      |
    | 3      |
    | 4      |
    | 5      |
    | 6      |
    | 7      |

  Scenario: 'indicatie geheim (70.10)' met waarde 0 wordt gevraagd met veld pad 'geheimhoudingPersoonsgegevens'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Jansen                | 19630405              |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 0      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1963-04-05                          |
    | fields        | geheimhoudingPersoonsgegevens       |
    Dan heeft de response een leeg persoon object

  Abstract Scenario: 'indicatie geheim (70.10)' met waarde <waarde> wordt ook geleverd wanneer daar niet om gevraagd is
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Jansen                | 19630405              |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde   |
    | indicatie geheim (70.10) | <waarde> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1963-04-05                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000152 |
    | geheimhoudingPersoonsgegevens | <waarde>  |

    Voorbeelden:
    | waarde |
    | 1      |
    | 2      |
    | 3      |
    | 4      |
    | 5      |
    | 6      |
    | 7      |
