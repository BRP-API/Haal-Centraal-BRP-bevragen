#language: nl

Functionaliteit: samenstellen van adresregels wanneer één of meerdere verblijfplaats velden de standaardwaarde heeft voor gezag persoon beperkt

  Als consumer van de BRP bevragen API
  Wil ik dat de verblijfplaats gegevens van een persoon kan worden gevraagd conform NEN 5825:2002
  Zodat ik de adresgegevens van de persoon op de correcte manier kan gebruiken 


  Regel: adresregels voor een adres worden niet geleverd als 'straatnaam (11.10)' of 'huisnummer (11.20)' de standaardwaarde als waarde hebben

    Abstract Scenario: persoon heeft een adres met <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | functie adres (10.10) |
      | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | <straatnaam>       | <huisnummer>       | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                                                                   |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie                                                  |
      | adresseerbaarObjectIdentificatie | 0599010051001502                                                                         |
      | fields                           | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon zonder gegevens

      Voorbeelden:
      | straatnaam               | huisnummer | omschrijving                       |
      |                          | 88         | een lege straatnaam                |
      | .                        | 88         | een straatnaam met standaardwaarde |
      | Jonkheer van Riemsdijkln | 0          | een huisnummer met standaardwaarde |
