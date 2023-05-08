#language: nl

Functionaliteit: Persoon beperkt: geboorte velden vragen met fields

  Abstract Scenario: 'geboortedatum (03.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 1983-05-26  |
    | datum.langFormaat | 26 mei 1983 |

    Voorbeelden:
    | fields                     |
    | geboorte.datum             |
    | geboorte.datum.type        |
    | geboorte.datum.datum       |
    | geboorte.datum.langFormaat |
