# language: nl

Functionaliteit: Naamgebruik in een lopende tekst wanneer de geslachtsnaam van de persoon leeg of onbekend is

  Regel: Wanneer de geslachtsnaam van de persoon leeg of onbekend is en de naam van de persoon wordt gebruikt, wordt aanhef niet opgenomen
    De aanhef wordt niet opgenomen in het antwoord wanneer aan alle volgende condities is voldaan:
      - de geslachtsnaam van de persoon is leeg of onbekend (.)
      - aanduidingNaamgebruik is ongelijk aan "P" (partner)
      
    Scenario: naam van de persoon is onbekend bij aanduiding naamgebruik "<naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                           | waarde |
      | geslachtsaanduiding (04.10)    | V      |
      | geslachtsnaam (02.40)          | .      |
      | aanduiding naamgebruik (61.10) | P      |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000139                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                  | waarde          |
      | gebruikInLopendeTekst | mevrouw De Boer |

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
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000139                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | naamgebruik |
      | E           |
      | V           |
      | N           |
