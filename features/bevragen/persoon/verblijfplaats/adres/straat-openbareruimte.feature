# language: nl

Functionaliteit: Straat en korteNaam vullenAdresvelden vullen

  Rule: Voor een binnenlands adres wordt veld "straat" gevuld met de naam openbare ruimte (11.15) wanneer die bekend is, en anders met straatnaam (11.10). Veld "korteNaam" wordt gevuld met straatnaam (11.10).

    Abstract Scenario: opnemen straat bij een binnenlands adres
    Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                  | waarde      |
      | functie adres (10.10) | W           |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                         | waarde                 |
      | straatnaam (11.10)           | <straatnaam>           |
      | naam openbare ruimte (11.15) | <naam openbare ruimte> |
      | gemeente_code                | 0518                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                     |
      | type                | RaadpleegMetBurgerservicenummer                                            |
      | burgerservicenummer | <burgerservicenummer>                                                      |
      | fields              | verblijfplaats.verblijfadres.straat,verblijfplaats.verblijfadres.korteNaam |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                      | waarde      |
      | type                      | Adres       |
      | verblijfadres.straat      | <straat>    |
      | verblijfadres.korteNaam   | <korteNaam> |

      Voorbeelden:
      | burgerservicenummer | straatnaam               | naam openbare ruimte                    | straat                                  | korteNaam                |
      | 000000152           | Kappeyne v d Cappellostr | Annelien Kappeyne van de Coppellostraat | Annelien Kappeyne van de Coppellostraat | Kappeyne v d Cappellostr |
      | 000000164           | Zomerdijkstraat          |                                         | Zomerdijkstraat                         | Zomerdijkstraat          |
