# language: nl

Functionaliteit: Naamgebruik in een lopende tekst wanneer de geslachtsnaam van de partner leeg of onbekend is


  Regel: Aanduiding naamgebruik "E" (eigen naam) wordt gehanteerd voor een persoon wanneer de geslachtsnaam van de partner leeg of onbekend is en de naam van de partner wordt gebruikt
    - de geslachtsnaam van de partner is leeg of onbekend (.)
    - aanduidingNaamgebruik is ongelijk aan "E" (eigen)

    Abstract Scenario: naam van de partner is '<partner geslachtsnaam>' bij aanduiding naamgebruik "<naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000334' heeft de volgende gegevens
        | naam                                 | waarde        |
        | geslachtsaanduiding (04.10)          | V             |
        | voornamen (02.10)                    |               |
        | adellijke titel of predicaat (02.20) |               |
        | voorvoegsel (02.30)                  | de            |
        | geslachtsnaam (02.40)                | Boer          |
        | aanduiding naamgebruik (61.10)       | <naamgebruik> |
        En de persoon heeft een 'partner' met de volgende gegevens
        | naam                                 | waarde                  |
        | adellijke titel of predicaat (02.20) |                         |
        | voorvoegsel (02.30)                  |                         |
        | geslachtsnaam (02.40)                | <partner geslachtsnaam> |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000334                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde                  |
        | gebruikInLopendeTekst | <gebruikinlopendetekst> |

        Voorbeelden:
        | partner geslachtsnaam | naamgebruik | gebruikinlopendetekst  |
        | .                     | E           | mevrouw De Boer        |
        | .                     | P           | mevrouw De Boer        |
        | .                     | V           | mevrouw De Boer        |
        | .                     | N           | mevrouw De Boer        |
        |                       | E           | mevrouw De Boer        |
        |                       | P           | mevrouw De Boer        |
        |                       | V           | mevrouw De Boer        |
        |                       | N           | mevrouw De Boer        |
        | Jansen                | E           | mevrouw De Boer        |
        | Jansen                | P           | mevrouw Jansen         |
        | Jansen                | V           | mevrouw Jansen-de Boer |
        | Jansen                | N           | mevrouw De Boer-Jansen |
