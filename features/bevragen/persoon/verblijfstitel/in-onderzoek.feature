#language: nl

Functionaliteit: Persoon: verblijfstitel velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle verblijfstitel velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel                  |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                                         | waarde            |
    | inOnderzoek.aanduiding                       | <aanduiding io>   |
    | inOnderzoek.datumEinde                       | <datum einde io>  |
    | inOnderzoek.datumIngang                      | <datum ingang io> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum             |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002       |

    Voorbeelden:
    | aanduiding in onderzoek | aanduiding io | datum einde io | datum ingang io | type                        |
    | 100000                  | true          | true           | true            | hele categorie persoon      |
    | 103900                  | true          | true           | true            | hele groep verblijfstitel   |
    | 103910                  | true          |                |                 | aanduiding verblijfstitel   |
    | 103920                  |               | true           |                 | datum einde verblijfstitel  |
    | 103930                  |               |                | true            | datum ingang verblijfstitel |
