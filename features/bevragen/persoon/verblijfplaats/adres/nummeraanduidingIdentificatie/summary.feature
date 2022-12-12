  #language: nl
  
  Functionaliteit: Leveren nummeraanduidingIdentificatie 

    Rule: nummeraanduidingIdentificatie wordt gevuld vanuit de identificatiecode nummeraanduiding (11.90)

        Abstract Scenario: nummeraanduidingIdentificatie heeft een valide waarde
            Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
            | naam                            | waarde     |
            | functie adres (10.10)           | W          |
            En de 'verblijfplaats' heeft de volgende 'adres' gegevens
            | naam                                       | waarde           |
            | gemeente_code                              | 0518             |
            | straatnaam (11.10)                         | Spui             |
            | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |
            Als personen wordt gezocht met de volgende parameters
            | naam                | waarde                                       |
            | type                | RaadpleegMetBurgerservicenummer              |
            | burgerservicenummer | 000000152                                    |
            | fields              | verblijfplaats.nummeraanduidingIdentificatie |
            Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
            | naam                                         | waarde           |
            | type                                         | Adres            |
            | nummeraanduidingIdentificatie                | 0599200000219678 |


