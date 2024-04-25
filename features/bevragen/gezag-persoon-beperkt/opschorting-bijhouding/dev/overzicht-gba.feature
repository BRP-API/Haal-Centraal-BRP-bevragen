#language: nl

@gba
Functionaliteit: opschorting bijhouding (gezag persoon beperkt)


    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |


  Regel: opschortingBijhouding wordt automatisch geleverd indien van toepassing

    Abstract Scenario: persoon opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) wordt gezocht met adresseerbaar object identificatie
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | <reden opschorting bijhouding>       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                     | waarde                           |
      | burgerservicenummer                      | 000000024                        |
      | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
      | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
      | opschortingBijhouding.datum              | 20220829                         |

      Voorbeelden:
      | reden opschorting bijhouding | reden opschorting omschrijving |
      | E                            | emigratie                      |
      | M                            | ministerieel besluit           |
      | R                            | pl is aangelegd in de rni      |
      | .                            | onbekend                       |
