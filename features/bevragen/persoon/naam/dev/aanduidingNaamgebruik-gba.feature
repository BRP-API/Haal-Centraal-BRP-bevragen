# language: nl

@gba
Functionaliteit: Aanduiding naamgebruik


  Regel: Bij de code voor aanduidingNaamgebruik moet de juiste omschrijving worden geleverd
    De juiste omschrijving staat in https://github.com/VNG-Realisatie/Haal-Centraal-BRP-tabellen-bevragen/blob/master/docs/tabelwaarden.csv
    En in het Logisch Ontwerp BRP bij Mogelijke waarden van element 61.10

    Abstract Scenario: Persoon heeft aanduiding naamgebruik '<naamgebruik code>'
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                           | waarde             |
      | aanduiding naamgebruik (61.10) | <naamgebruik code> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000139                       |
      | fields              | naam.aanduidingNaamgebruik      |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                               | waarde                     |
      | aanduidingNaamgebruik.code         | <naamgebruik code>         |
      | aanduidingNaamgebruik.omschrijving | <naamgebruik omschrijving> |

      Voorbeelden:
      | naamgebruik code | naamgebruik omschrijving                                                |
      | E                | eigen geslachtsnaam                                                     |
      | N                | geslachtsnaam echtgenoot/geregistreerd partner na eigen geslachtsnaam   |
      | P                | geslachtsnaam echtgenoot/geregistreerd partner                          |
      | V                | geslachtsnaam echtgenoot/geregistreerd partner voor eigen geslachtsnaam |
      