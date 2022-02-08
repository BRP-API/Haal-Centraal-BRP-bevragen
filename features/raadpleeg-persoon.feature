#language: nl
Functionaliteit: Raadpleeg persoon

  Scenario: Zoek met valide burgerservicenummer

      Gegeven het systeem heeft een persoon met de volgende gegevens
      | identificatie                        | burgerservicenummer |
      | 4cbcf7fd-d788-4be5-8ebc-17decde26131 | 999999321           |
      Als personen wordt geraadpleegd met de volgende parameters
      | naam                 | waarde                               |
      | persoonIdentificatie | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | fields               | burgerservicenummer                  |
      Dan bevat de response een persoon met de volgende gegevens 
      | burgerservicenummer |
      | 999999321           |
