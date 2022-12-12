  #language: nl
  
  Functionaliteit: Leveren adresseerbaarObjectIdentificatie 

    Rule: adresseerbaarObjectIdentificatie wordt gevuld vanuit de identificatiecode verblijfplaats (11.80)

      Abstract Scenario: adresseerbaarObjectIdentificatie heeft een valide waarde
        Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
        | naam                            | waarde                    |
        | functie adres (10.10)           | W          |
        En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | naam                                     | waarde           |
        | gemeente_code                            | 0518             |
        | straatnaam (11.10)                       | Spui             |
        | identificatiecode verblijfplaats (11.80) | 0599010000208579 |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                                          |
        | type                | RaadpleegMetBurgerservicenummer                 |
        | burgerservicenummer | 000000152                                       |
        | fields              | verblijfplaats.adresseerbaarObjectIdentificatie |
        Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
        | naam                                         | waarde           |
        | type                                         | Adres            |
        | adresseerbaarObjectIdentificatie             | 0599010000208579 |
 