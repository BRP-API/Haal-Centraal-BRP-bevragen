#language: nl

Functionaliteit: Gezag Persoon beperkt: Opschorting bijhouding

  Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |


  Regel: personen met afgevoerde persoonslijst worden niet gevonden bij het zoeken
    Een afgevoerde persoonslijst heeft opschorting bijhouding reden "F" (fout)

    Scenario: persoon opgeschort met reden "F" (fout) wordt gezocht met adresseerbaar object identificatie
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | F                                    |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 0 personen

  Regel: personen op een logisch verwijderde persoonslijst worden niet gevonden bij het zoeken

    Abstract Scenario: persoon opgeschort met reden "W" (wissen) wordt gezocht met adresseerbaar object identificatie
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | W                                    |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 0 personen

      Voorbeelden:
      | inclusief overleden personen | zoek overleden personen type |
      | true                         | inclusief                    |
      | false                        | exclusief                    |

  Regel: overleden personen worden niet gevonden bij het zoeken

    Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met adresseerbaar object identificatie
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | O                                    |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 0 personen

  Regel: opschortingBijhouding wordt automatisch geleverd indien van toepassing

    Abstract Scenario: persoon opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) wordt gezocht met adresseerbaar object identificatie
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | <reden opschorting bijhouding>       |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                     | waarde                           |
      | burgerservicenummer                      | 000000024                        |
      | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
      | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
      | opschortingBijhouding.datum.type         | Datum                            |
      | opschortingBijhouding.datum.datum        | 2022-08-29                       |
      | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022                 |

      Voorbeelden:
      | reden opschorting bijhouding | reden opschorting omschrijving |
      | E                            | emigratie                      |
      | M                            | ministerieel besluit           |
      | R                            | pl is aangelegd in de rni      |
      | .                            | onbekend                       |
