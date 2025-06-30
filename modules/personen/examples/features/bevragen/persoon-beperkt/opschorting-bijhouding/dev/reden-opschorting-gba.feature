#language: nl

@gba
Functionaliteit: reden opschorting bijhouding (persoon beperkt)

  Regel: Bij de code voor reden opschorting bijhouding moet de juiste omschrijving worden geleverd
     De juiste omschrijving staat in https://github.com/VNG-Realisatie/Haal-Centraal-BRP-tabellen-bevragen/blob/master/docs/tabelwaarden.csv
     En in het Logisch Ontwerp BRP bij Mogelijke waarden van element 67.20

    Abstract Scenario: Opgeschorte persoonslijst wegens "<reden opschorting omschrijving>"
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Vries                 | 19781103              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | <reden opschorting bijhouding>       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Vries                               |
      | geboortedatum              | 1978-11-03                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                     | waarde                           |
      | burgerservicenummer                      | 000000024                        |
      | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
      | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
      | opschortingBijhouding.datum              | 20220829                         |

      Voorbeelden:
      | reden opschorting bijhouding | reden opschorting omschrijving |
      | O                            | overlijden                     |
      | E                            | emigratie                      |
      | M                            | ministerieel besluit           |
      | R                            | pl is aangelegd in de rni      | 
      | .                            | onbekend                       |
