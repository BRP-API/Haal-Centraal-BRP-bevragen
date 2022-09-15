# language: nl

@post-assert
Functionaliteit: Kinderen van een persoon raadplegen
  Van een persoon worden -indien gevraagd met de fields parameter- de kinderen geleverd.
  Dit bevat enkele identificerende eigenschappen van de kinderen.

  Rule: de actuele gegevens van kinderen worden geleverd

    Scenario: de naam van een kind is gecorrigeerd
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | William           | de                  | Boer                  |
      En het 'kind' is gecorrigeerd naar de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | William           | de                  | Vries                 |
      En het 'kind' is gewijzigd naar de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) |
      | William           | Postma                |
      En de persoon heeft nog een 'kind' met de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | Sebastiaan        | de                  | Boer                  |
      En de persoon heeft nog een 'kind' met de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) |
      | Walter            | Messeritz             |
      En het 'kind' is gecorrigeerd naar de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | Walter            | de                  | Boer                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' met de volgende gegevens
      | naam               | waarde  |
      | naam.voornamen     | William |
      | naam.geslachtsnaam | Postma  |
      En heeft de persoon een 'kind' met de volgende gegevens
      | naam               | waarde     |
      | naam.voornamen     | Sebastiaan |
      | naam.voorvoegsel   | de         |
      | naam.geslachtsnaam | Boer       |
      En heeft de persoon een 'kind' met de volgende gegevens
      | naam               | waarde |
      | naam.voornamen     | Walter |
      | naam.voorvoegsel   | de     |
      | naam.geslachtsnaam | Boer   |
