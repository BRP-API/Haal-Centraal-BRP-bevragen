#language: nl

@protocollering
Functionaliteit: Protocollering zoekrubrieken ZoekMetAdresseerbaarObjectIdentificatie

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) |
      | 2683754153      |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010000219679                         |

  Rule: Gebruikte parameters worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met alleen de verplichte parameters
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010000219679                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 081180                 |

    Scenario: Zoek persoon met parameter gemeenteVanInschrijving
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010000219679                        |
      | gemeenteVanInschrijving          | 0599                                    |
      | fields                           | burgerservicenummer                     |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 080910, 081180         |


  Rule: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met inclusiefOverledenPersonen
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010000219679                        |
      | fields                           | burgerservicenummer                     |
      | inclusiefOverledenPersonen       | true                                    |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 081180                 |