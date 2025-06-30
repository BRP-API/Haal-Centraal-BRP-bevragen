# language: nl

Functionaliteit: Naamgebruik in een lopende tekst voor een persoon met meerdere actuele partners


Regel: Bij meerdere actuele (niet ontbonden) huwelijken/partnerschappen worden de naamgegevens van de eerste partner (oudste relatie) gebruikt voor het samenstellen van de gebruikInLopendeTekst

  Scenario: meerdere actuele relaties
    Gegeven de persoon met burgerservicenummer '000000280' heeft de volgende gegevens
      | naam                           | waarde             |
      | geslachtsaanduiding (04.10)    | V                  |
      | voorvoegsel (02.30)            |                    |
      | geslachtsnaam (02.40)          | Groen              |
      | voornamen (02.10)              | Ferdinand Cornelis |
      | aanduiding naamgebruik (61.10) | V                  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde    |
      | burgerservicenummer (01.20)                                        | 000000292 |
      | voorvoegsel (02.30)                                                |           |
      | geslachtsnaam (02.40)                                              | Geel      |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19580401  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde    |
      | burgerservicenummer (01.20)                                        | 000000309 |
      | voorvoegsel (02.30)                                                |           |
      | geslachtsnaam (02.40)                                              | Roodt     |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19610808  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000280                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                  | waarde             |
      | gebruikInLopendeTekst | mevrouw Geel-Groen |

    Scenario: Persoon met meerdere actuele partners
      Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende gegevens
      | naam                           | waarde             |
      | voornamen (02.10)              | Ferdinand Cornelis |
      | geslachtsnaam (02.40)          | Groen              |
      | geslachtsaanduiding (04.10)    | V                  |
      | aanduiding naamgebruik (61.10) | N                  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde   |
      | voorvoegsel (02.30)                                                | de       |
      | geslachtsnaam (02.40)                                              | Wit      |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19620104 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde   |
      | voorvoegsel (02.30)                                                | in 't    |
      | geslachtsnaam (02.40)                                              | Roodt    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19610831 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde   |
      | geslachtsnaam (02.40)                                              | Geel     |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19581215 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde   |
      | geslachtsnaam (02.40)                                              | Zwart    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19590203 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000309                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                  | waarde             |
      | gebruikInLopendeTekst | mevrouw Groen-Geel |
