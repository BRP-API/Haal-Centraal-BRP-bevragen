# language: nl

Functionaliteit: Aanhef opstellen wanneer de geslachtsnaam van de persoon leeg of onbekend is. 

  Regel: Wanneer de geslachtsnaam van de persoon leeg of onbekend is en de naam van de persoon wordt gebruikt, wordt aanhef niet opgenomen
    De aanhef wordt niet opgenomen in het antwoord wanneer aan alle volgende condities is voldaan:
      - de geslachtsnaam van de persoon is leeg of onbekend (.)
      - aanduidingNaamgebruik is ongelijk aan "P" (partner)
      - de aanhef is geen aanspreekvorm voor de adellijke titel van de persoon ("Hoogwelgeboren heer", "Hoogwelgeboren vrouwe", "Hooggeboren heer", "Hooggeboren vrouwe" of "Hoogheid")
      - de aanhef is geen aanspreekvorm van een hoffelijkheidstitel op basis van de adellijke titel van de partner ("Hoogwelgeboren vrouwe", "Hooggeboren vrouwe" of "Hoogheid")

  Abstract Scenario: naam van de persoon is onbekend bij aanduiding naamgebruik "<naamgebruik>"
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                           | waarde        |
    | geslachtsaanduiding (04.10)    | V             |
    | geslachtsnaam (02.40)          | .             |
    | aanduiding naamgebruik (61.10) | <naamgebruik> |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   | de     |
    | geslachtsnaam (02.40) | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
    | naamgebruik | aanhef                  | leveren naam |
    | P           | Geachte mevrouw De Boer | WEL          |

  Abstract Scenario: naam van de persoon is onbekend bij aanduiding naamgebruik "<naamgebruik>"
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                           | waarde        |
    | geslachtsaanduiding (04.10)    | V             |
    | geslachtsnaam (02.40)          | .             |
    | aanduiding naamgebruik (61.10) | <naamgebruik> |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   | de     |
    | geslachtsnaam (02.40) | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met een leeg 'adressering' object

    Voorbeelden:
        | naamgebruik |
        | E           |
        | V           |
        | N           |

  Abstract Scenario: persoon met onbekende naam heeft adellijkeTitelPredicaat "<adellijkeTitelPredicaat>" en geslacht "<geslacht>" en naamgebruik "<naamgebruik>"
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                                 | waarde                    |
    | geslachtsaanduiding (04.10)          | <geslacht>                |
    | voornamen (02.10)                    | Jo Anne                   |
    | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat> |
    | aanduiding naamgebruik (61.10)       | <naamgebruik>             |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   | de     |
    | geslachtsnaam (02.40) | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
        | geslacht | adellijkeTitelPredicaat | naamgebruik | aanhef                  | leveren naam |
        | M        | G                       | E           | Hooggeboren heer        | WEL          |
        | M        | G                       | V           | Hooggeboren heer        | WEL          |
        | M        | G                       | N           | Hooggeboren heer        | WEL          |
        | M        | G                       | P           | Geachte heer De Boer    | WEL          |
        | V        | G                       | E           | Hooggeboren vrouwe      | WEL          |
        | V        | JV                      | P           | Geachte mevrouw De Boer | WEL          |

  Abstract Scenario: persoon met onbekende naam heeft adellijkeTitelPredicaat "<adellijkeTitelPredicaat>" en geslacht "<geslacht>" en naamgebruik "<naamgebruik>"
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
    | naam                                 | waarde                    |
    | geslachtsaanduiding (04.10)          | <geslacht>                |
    | voornamen (02.10)                    | Jo Anne                   |
    | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat> |
    | aanduiding naamgebruik (61.10)       | <naamgebruik>             |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   | de     |
    | geslachtsnaam (02.40) | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met een leeg 'adressering' object

    Voorbeelden:
    | geslacht | adellijkeTitelPredicaat | naamgebruik |
    | O        | G                       | E           |
    | V        | JV                      | E           |
    | V        | JV                      | V           |
    | V        | JV                      | N           |