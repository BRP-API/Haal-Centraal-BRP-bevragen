#language: nl

@gba
Functionaliteit: partner buitenlandse geboorteplaats of locatie (persoon)

  Regel: wanneer de waarde voor een geboorteplaats(03.20) geen valide gemeentecode bevat wordt de plaats geleverd in de omschrijving en wordt veld code niet geleverd
    - een valide gemeentecode bestaat uit vier cijfers en komt voor in de landelijke tabel Gemeenten

    Abstract Scenario: Geboorteplaats is een <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                   | waarde           |
      | geboorteplaats (03.20) | <geboorteplaats> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | partners.geboorte.plaats        |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende 'geboorte' gegevens
      | naam                | waarde           |
      | plaats.omschrijving | <geboorteplaats> |

      Voorbeelden:
      | geboorteplaats      | omschrijving                    |
      | Berlijn             | buitenlandse plaatsnaam         |
      | 52°2'43N4°22'39"O   | locatieaanduiding               |
      | A.B. USS Enterprise | locatie aan boord van een schip |

  Regel: wanneer de waarde voor een plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) geen valide gemeentecode bevat wordt de plaats geleverd in de omschrijving en wordt veld code niet geleverd
    - een valide gemeentecode bestaat uit vier cijfers en komt voor in de landelijke tabel Gemeenten

    Abstract Scenario: Plaats aangaan huwelijk/partnerschap is een <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                                                                | waarde            |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | <plaats huwelijk> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                      |
      | type                | RaadpleegMetBurgerservicenummer             |
      | burgerservicenummer | 000000012                                   |
      | fields              | partners.aangaanHuwelijkPartnerschap.plaats |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde           |
      | plaats.omschrijving | <plaats huwelijk> |

      Voorbeelden:
      | plaats huwelijk         | omschrijving                    |
      | Berlijn                 | buitenlandse plaatsnaam         |
      | 0,27729° Z, 73,41797° O | locatieaanduiding               |
      | A.B. Black Pearl        | locatie aan boord van een schip |
