# language: nl

Functionaliteit: Adresregels adressering buitenland vullen

  Rule: Voor een buitenlands adres worden de adresregels en land gevuld uit de gegevens over verblijf buitenland (groep 13)

    Scenario: persoon verblijft in het buitenland
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde          |
      | gemeente van inschrijving (09.10) | 1999            |
      | land (13.10)                      | 5010            |
      | regel 1 adres buitenland (13.30)  | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40)  | Bruxelles       |
      | regel 3 adres buitenland (13.50)  | postcode 1000   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                   |
      | type                | RaadpleegMetBurgerservicenummer                                                          |
      | burgerservicenummer | 000000346                                                                                |
      | fields              | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam              | waarde          |
      | adresregel1       | Rue du pomme 25 |
      | adresregel2       | Bruxelles       |
      | adresregel3       | postcode 1000   |
 
  Rule: Adresregels die een waarde hebben worden niet geleverd als het land geen waarde heeft. 
    - een standaardwaarde in de bron geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

    Scenario: land is onbekend
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                 |
      | gemeente van inschrijving (09.10)      | 1999                   |
      | land (13.10)                           | 0000                   |
      | datum aanvang adres buitenland (13.20) | 20191104               |
      | regel 2 adres buitenland (13.40)       | Pietermaai 19, Curaçao |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                   |
      | type                | RaadpleegMetBurgerservicenummer                                                          |
      | burgerservicenummer | 000000346                                                                                |
      | fields              | burgerservicenummer,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000346 |
      En heeft de persoon een leeg 'adressering' object