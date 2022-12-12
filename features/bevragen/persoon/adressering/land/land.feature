# language: nl

Functionaliteit: Land adressering vullen

  Rule: Land wordt alleen geleverd als er sprake is van een buitenlands adres en wordt gevuld met de waarde van land (13.10) uit verblijf buitenland (groep 13)

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
      | fields              | adressering.land |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam              | waarde          |
      | land.code         | 5010            |
      | land.omschrijving | België          |

  Rule: Land wordt alleen geleverd als tenminste land (13.10) en één van de regels adres buitenland een waarde hebben
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

    Scenario: Land wordt niet geleverd als alleen land (13.10) een  waarde heeft en geen van de adresregelsbuitenland (13,30, 13.40, 13.50) een waarde heeft
      Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | gemeente van inschrijving (09.10)      | 1999     |
      | land (13.10)                           | 5107     |
      | datum aanvang adres buitenland (13.20) | 20191104 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                   |
      | type                | RaadpleegMetBurgerservicenummer                                                          |
      | burgerservicenummer | 000000358                                                                                |
      | fields              | burgerservicenummer,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000358 |
      En heeft de persoon een leeg 'adressering' object
