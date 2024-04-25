#language: nl

@gba
Functionaliteit: Buitenlandse geboorteplaats of locatie (persoon)

  Regel: wanneer de waarde voor een geboorteplaats(03.20) geen valide gemeentecode bevat wordt de plaats geleverd in de omschrijving en wordt veld code niet geleverd
    - een valide gemeentecode bestaat uit vier cijfers en komt voor in de landelijke tabel Gemeenten

    Abstract Scenario: Geboorteplaats is een <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000280' heeft de volgende gegevens
      | geboorteplaats (03.20) |
      | <geboorteplaats>       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000280                       |
      | fields              | geboorte.plaats                 |
      Dan heeft de response een persoon met alleen de volgende 'geboorte' gegevens
      | naam                | waarde           |
      | plaats.omschrijving | <geboorteplaats> |

      Voorbeelden:
      | geboorteplaats     | omschrijving                    |
      | Berlijn            | buitenlandse plaatsnaam         |
      | 52°2'43N4°22'39"O  | locatieaanduiding               |
      | A.B. Pakjesboot 12 | locatie aan boord van een schip |

  Regel: wanneer voor de code geen bijbehorende waarde voorkomt in de tabel, wordt alleen de code geleverd

    Scenario: code voor geboorteland (03.30) komt niet voor in de tabel Landen
      Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende gegevens
      | geboorteland (03.30) |
      | 1234                 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000231                       |
      | fields              | geboorte.land                   |
      Dan heeft de response een persoon met alleen de volgende 'geboorte' gegevens
      | naam      | waarde |
      | land.code | 1234   |
