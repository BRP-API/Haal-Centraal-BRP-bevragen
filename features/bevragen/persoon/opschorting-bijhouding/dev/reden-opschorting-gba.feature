#language: nl

@gba
Functionaliteit: reden opschorting bijhouding (persoon)

  Rule: Bij de code voor reden opschorting bijhouding moet de juiste omschrijving worden geleverd
     De juiste omschrijving staat in https://github.com/VNG-Realisatie/Haal-Centraal-BRP-tabellen-bevragen/blob/master/docs/tabelwaarden.csv
     En in het Logisch Ontwerp BRP bij Mogelijke waarden van element 67.20

    Abstract Scenario: Opgeschorte persoonslijst wegens "<reden opschorting omschrijving>"
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | <reden opschorting bijhouding>       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                     | waarde                           |
      | burgerservicenummer                      | 000000024                        |
      | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
      | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

      Voorbeelden:
      | reden opschorting bijhouding | reden opschorting omschrijving |
      | O                            | overlijden                     |
      | E                            | emigratie                      |
      | M                            | ministerieel besluit           |
      | R                            | pl is aangelegd in de rni      |
      | F                            | fout                           |
      | .                            | onbekend                       |

  Scenario: volledig onbekende datum Opschorting Bijhouding
    Gegeven de persoon met burgerservicenummer '000000322' heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde   |
    | datum opschorting bijhouding (67.10) | 00000000 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000322                       |
    | fields              | opschortingBijhouding.datum     |
    Dan heeft de response een persoon met alleen de volgende 'opschortingBijhouding' gegevens
    | naam  | waarde   |
    | datum | 00000000 |
