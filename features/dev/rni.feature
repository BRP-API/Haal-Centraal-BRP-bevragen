# language: nl

Functionaliteit: Persoon: RNI

  Rule: wanneer er geen RNI-deelnemer is en er wordt niet om gevraagd met fields, wordt het niet geleverd

    Scenario: geen RNI-deelnemer en niet vragen om rni
      Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
      | naam                  | waarde |
      | voornamen (02.10)     | Peter  |
      | geslachtsnaam (02.40) | Jansen |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000036                       |
      | fields              | naam.voornamen                  |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Peter  |
      #En heeft de persoon GEEN 'rni'

  Rule: wanneer er geen RNI-deelnemer is en er wordt om gevraagd met fields, wordt het geleverd als lege array

    Scenario: geen RNI-deelnemer en met fields vragen om rni
      Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
      | naam                  | waarde |
      | voornamen (02.10)     | Peter  |
      | geslachtsnaam (02.40) | Jansen |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000036                       |
      | fields              | naam.voornamen,rni              |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Peter  |
      En heeft de persoon geen 'rni' gegevens