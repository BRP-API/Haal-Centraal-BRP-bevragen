#language: nl

@gba
Functionaliteit: overlijden buitenlandse plaats of locatie (persoon)

  Regel: wanneer de waarde voor een plaats overlijden (08.20) geen valide gemeentecode bevat wordt de plaats geleverd in de omschrijving en wordt veld code niet geleverd
    - een valide gemeentecode bestaat uit vier cijfers en komt voor in de landelijke tabel Gemeenten

    Abstract Scenario: Overlijdensplaats is een <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000280' heeft de volgende 'overlijden' gegevens
      | plaats overlijden (08.20) |
      | <overlijdensplaats>       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000280                       |
      | fields              | overlijden.plaats               |
      Dan heeft de response een persoon met alleen de volgende 'overlijden' gegevens
      | naam                | waarde              |
      | plaats.omschrijving | <overlijdensplaats> |

      Voorbeelden:
      | overlijdensplaats | omschrijving                    |
      | Berlijn           | buitenlandse plaatsnaam         |
      | 52°2'43N4°22'39"O | locatieaanduiding               |
      | A.B. Titanic      | locatie aan boord van een schip |
