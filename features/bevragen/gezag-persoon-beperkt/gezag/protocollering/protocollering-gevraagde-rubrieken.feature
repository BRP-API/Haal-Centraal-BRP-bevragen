#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor gezag

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0599010000219679                         |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000024        |
      | 000000012       | OG2        | 000000048        |


  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP

    Scenario: Met fields vragen om gezag wordt vastgelegd als gevraagde rubrieken PAGZ01
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010000219679                        |
      | fields                           | gezag                                   |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | PAGZ01                      |
