# language: nl

Functionaliteit: Het juiste gebruik van hoodfletters in de voorvoegsels bij het opstellen van de aanhef 

  Abstract Scenario: hoofdlettergebruik in voorvoegsels bij aanduidingNaamgebruik "<naamgebruik>", geslacht "<geslacht>" en <voorbeeld>
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                           | waarde          |
    | geslachtsaanduiding (04.10)    | <geslacht>      |
    | voornamen (02.10)              | <voornamen>     |
    | voorvoegsel (02.30)            | <voorvoegsel>   |
    | geslachtsnaam (02.40)          | <geslachtsnaam> |
    | aanduiding naamgebruik (61.10) | <naamgebruik>   |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                  | waarde                  |
    | voorvoegsel (02.30)   | <partner voorvoegsel>   |
    | geslachtsnaam (02.40) | <partner geslachtsnaam> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
    | voorbeeld                     | geslacht | naamgebruik | voornamen | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | aanhef                                       |
    | voorvoegsel in kleine letters | V        | E           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte mevrouw In het Zonnetje              |
    | voorvoegsel in kleine letters | O        | E           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte J.R. in het Zonnetje                 |
    | geen voornamen                | O        | E           |           | in het      | Zonnetje      | 't                  | Wolkje                | Geachte In het Zonnetje                      |
    | voorvoegsel met hoofdletters  | V        | E           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte mevrouw Op Den Berghe                |
    | voorvoegsel met hoofdletters  | O        | E           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte J.R. Op Den Berghe                   |
    | voorvoegsel begint met accent | V        | P           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte mevrouw 't Wolkje                    |
    | voorvoegsel met hoofdletters  | V        | P           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte mevrouw Van Der Broeck               |
    | voorvoegsel met hoofdletters  | O        | P           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte J.R. Van Der Broeck                  |
    | voorvoegsel begint met accent | V        | V           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte mevrouw 't Wolkje-in het Zonnetje    |
    | voorvoegsel met hoofdletters  | V        | V           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte mevrouw Van Der Broeck-Op Den Berghe |
    | voorvoegsel met hoofdletters  | O        | V           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte J.R. Van Der Broeck-Op Den Berghe    |
    | voorvoegsel in kleine letters | V        | N           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte mevrouw In het Zonnetje-'t Wolkje    |
    | voorvoegsel met hoofdletters  | V        | N           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte mevrouw Op Den Berghe-Van Der Broeck |
    | voorvoegsel met hoofdletters  | O        | N           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte J.R. Op Den Berghe-Van Der Broeck    |
