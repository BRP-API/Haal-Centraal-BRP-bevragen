# language: nl

@gba
Functionaliteit: kind - geboorte

  Scenario: Kind heeft onbekend geboorte gegevens
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'kind' met de volgende gegevens
    | naam                   | waarde   |
    | geboortedatum (03.10)  | 00000000 |
    | geboorteplaats (03.20) | 0000     |
    | geboorteland (03.30)   | 0000     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | kinderen.geboorte               |
    Dan heeft de response een persoon met een 'kind' met de volgende 'geboorte' gegevens
    | naam                | waarde   |
    | datum               | 00000000 |
    | plaats.code         | 0000     |
    | plaats.omschrijving | Onbekend |
    | land.code           | 0000     |
    | land.omschrijving   | Onbekend |

Regel: wanneer geboorteplaats (03.20) geen valide gemeentecode bevat, dan wordt de plaats geleverd in de omschrijving veld en wordt het code veld niet geleverd
      - een valide gemeentecode bestaat uit vier cijfers en komt voor in de landelijke tabel Gemeenten
      - als de waarde in de geboorteplaats (03.20) niet voorkomt in de landelijke tabel Gemeenten, dan wordt de waarde alleen in de omschrijving opgenomen. (Buitenlandse plaatsnaam of coördinaten)

  Scenario: Plaats is buitenlandse plaats of locatie bij code voor kind geboorte
    Gegeven de persoon met burgerservicenummer '000000309' heeft een 'kind' met de volgende gegevens
    | geboorteplaats (03.20) |
    | Brussel                |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000309                       |
    | fields              | kinderen.geboorte.plaats        |
    Dan heeft de response een persoon met een 'kind' met de volgende 'geboorte' gegevens
    | naam                | waarde  |
    | plaats.omschrijving | Brussel |
