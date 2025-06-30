# language: nl

Functionaliteit: Aanhef opstellen wanneer de geslachtsnaam van de partner van de persoon leeg of onbekend is. 

Regel: Aanduiding naamgebruik "E" (eigen naam) wordt gehanteerd voor een persoon wanneer de geslachtsnaam van de partner leeg of onbekend is en de naam van de partner wordt gebruikt
  De aanhef wordt samengesteld voor aanduiding naamgebruik "E" wanneer aan alle volgende condities is voldaan:
    - de geslachtsnaam van de partner is leeg of onbekend (.)
    - aanduidingNaamgebruik is ongelijk aan "E" (eigen)
    - de aanhef is geen aanspreekvorm voor de adellijke titel van de persoon ("Hoogwelgeboren heer", "Hoogwelgeboren vrouwe", "Hooggeboren heer", "Hooggeboren vrouwe" of "Hoogheid")
    - de aanhef is geen aanspreekvorm van een hoffelijkheidstitel op basis van de adellijke titel van de partner ("Hoogwelgeboren vrouwe", "Hooggeboren vrouwe" of "Hoogheid")

  Abstract Scenario: naam van de partner is onbekend bij aanduiding naamgebruik "<naamgebruik>"
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                           | waarde        |
    | geslachtsaanduiding (04.10)    | V             |
    | voorvoegsel (02.30)            | de            |
    | geslachtsnaam (02.40)          | Boer          |
    | aanduiding naamgebruik (61.10) | <naamgebruik> |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                                 | waarde |
    | geslachtsnaam (02.40)                | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam   | waarde                  |
    | aanhef | Geachte mevrouw De Boer |

    Voorbeelden:
    | naamgebruik |
    | E           |
    | P           |
    | V           |
    | N           |

  Abstract Scenario: persoon heeft en geslacht "<geslacht>" en naamgebruik "<naamgebruik>" en heeft partner met onbekende naam en adellijkeTitelPredicaat "<adellijkeTitelPredicaat partner>"
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                        | waarde     |
    | geslachtsaanduiding (04.10) | <geslacht> |
    | voornamen (02.10)                    | Jo Anne       |
    | voorvoegsel (02.30)                  | de            |
    | geslachtsnaam (02.40)                | Boer          |
    | aanduiding naamgebruik (61.10)       | <naamgebruik> |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                                 | waarde                            |
    | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat partner> |
    | geslachtsnaam (02.40)                | .                                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
    | geslacht | adellijkeTitelPredicaat partner | naamgebruik | aanhef                  |
    | V        | G                               | E           | Geachte mevrouw De Boer |
    | V        | G                               | V           | Hooggeboren vrouwe      |
    | V        | G                               | N           | Hooggeboren vrouwe      |
    | V        | G                               | P           | Hooggeboren vrouwe      |
    | M        | G                               | V           | Geachte heer De Boer    |
    | O        | G                               | V           | Geachte J.A. de Boer    |
    | V        | GI                              | V           | Geachte mevrouw De Boer |
    | V        | JH                              | V           | Geachte mevrouw De Boer |
