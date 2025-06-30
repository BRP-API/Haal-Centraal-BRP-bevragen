# language: nl

Functionaliteit: Aanhef opstellen wanneer de persoon meerdere actuele partners heeft. 

Regel: Bij meerdere actuele (niet ontbonden) huwelijken/partnerschappen worden de naamgegevens van de eerste partner (oudste relatie) gebruikt voor het samenstellen van de aanhef

  Abstract Scenario: meerdere actuele relaties
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                           | waarde             |
    | geslachtsaanduiding (04.10)    | V                  |
    | geslachtsnaam (02.40)          | Groen              |
    | voornamen (02.10)              | Ferdinand Cornelis |
    | aanduiding naamgebruik (61.10) | V                  |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde            |
    | geslachtsnaam (02.40)                                              | Geel              |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | <datum partner 1> |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde            |
    | geslachtsnaam (02.40)                                              | Roodt             |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | <datum partner 2> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam   | waarde                 |
    | aanhef | Geachte mevrouw <naam> |

    Voorbeelden:
    | datum partner 1 | datum partner 2 | naam        | omschrijving                                                                                                                      |
    | 19580401        | 19610808        | Geel-Groen  |                                                                                                                                   |
    | 19580401        | 19610800        | Geel-Groen  |                                                                                                                                   |
    | 19580401        | 19610000        | Geel-Groen  |                                                                                                                                   |
    | 19580401        | 00000000        | Roodt-Groen | partner met datum onbekend wordt eerste partner                                                                                   |
    | 19610800        | 19610808        | Geel-Groen  | jaar en maand zijn bekend en zijn gelijk, partner met dag onbekend wordt eerste partner                                           |
    | 19610000        | 19610800        | Geel-Groen  | partner 1 alleen jaar bekend, partner 2 jaar en maand bekend, jaar gelijk, partner met maand en dag onbekend wordt eerste partner |
