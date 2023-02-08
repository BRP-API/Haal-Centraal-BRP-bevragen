# language: nl

Functionaliteit: Gba persoon: kind - geboorte

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
