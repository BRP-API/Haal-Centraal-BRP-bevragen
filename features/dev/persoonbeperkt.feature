#language: nl

Functionaliteit: Persoon beperkt

  Abstract Scenario: gevraagde veld heeft geen waarde
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    | geboortedatum (03.10) | 20020202 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 2002-02-02                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | fields                        |
    | geheimhoudingPersoonsgegevens |
    | geslacht                      |
    | geslacht.code                 |
    | geslacht.omschrijving         |
