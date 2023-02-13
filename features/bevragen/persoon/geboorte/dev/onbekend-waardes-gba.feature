#language: nl

@gba
Functionaliteit: geboorte

    Scenario: persoon heeft onbekend geboorte gegevens 
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                   | waarde   |
      | geboortedatum (03.10)  | 00000000 |
      | geboorteplaats (03.20) | 0000     |
      | geboorteland (03.30)   | 0000     |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | geboorte                        |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
      | naam                | waarde   |
      | datum               | 00000000 |
      | plaats.code         | 0000     |
      | plaats.omschrijving | Onbekend |
      | land.code           | 0000     |
      | land.omschrijving   | Onbekend |
