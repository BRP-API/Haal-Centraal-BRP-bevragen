#language: nl

Functionaliteit: samenstellen van adresregels wanneer één of meerdere verblijfplaats velden de standaardwaarde heeft

  Als consumer van de BRP bevragen API
  Wil ik dat de verblijfplaats gegevens van een persoon kan worden gevraagd conform NEN 5825:2002
  Zodat ik de adresgegevens van de persoon op de correcte manier kan gebruiken 

Regel: adresregels voor een adres worden niet geleverd als 'straatnaam (11.10)' of 'huisnummer (11.20)' de standaardwaarde als waarde hebben

  Abstract Scenario: persoon heeft een adres met <omschrijving>
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
    | 0518                 | <straatnaam>       | <huisnummer>       |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                                                                   |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum                                                      |
    | geslachtsnaam | Maassen                                                                                  |
    | geboortedatum | 1983-05-26                                                                               |
    | fields        | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | straatnaam               | huisnummer | omschrijving                       |
    |                          | 88         | een lege straatnaam                |
    | .                        | 88         | een straatnaam met standaardwaarde |
    | Jonkheer van Riemsdijkln | 0          | een huisnummer met standaardwaarde |

Regel: adresregels voor een verblijfplaats buitenland worden niet geleverd als 'land (13.10)' de standwaarde heeft of 'regel 1 adres buitenland (13.30)', 'regel 2 adres buitenland (13.40)' en 'regel 3 adres buitenland (13.50)' hebben de standaardwaarde

  Scenario: persoon heeft een verblijfplaats buitenland en 'land (13.10)' heeft de standaardwaarde
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 0000         | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                                                                   |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum                                                      |
    | geslachtsnaam | Maassen                                                                                  |
    | geboortedatum | 1983-05-26                                                                               |
    | fields        | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon zonder gegevens

  Scenario: persoon heeft een verblijfplaats buitenland en 'regel 1 adres buitenland (13.30)', 'regel 2 adres buitenland (13.40)' en 'regel 3 adres buitenland (13.50)' hebben de standaardwaarde
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 0000         |                                  |                                  |                                  |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                                                                   |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum                                                      |
    | geslachtsnaam | Maassen                                                                                  |
    | geboortedatum | 1983-05-26                                                                               |
    | fields        | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon zonder gegevens
