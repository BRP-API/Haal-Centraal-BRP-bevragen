# language: nl

Functionaliteit: Als gemeente wil ik de juiste partnergegevens gebruiken in de aanschrijfwijze van mijn burgers
  Wanneer een persoon -om welke reden dan ook- meer dan één niet-ontbonden huwelijk of partnerschap heeft, 
  dan wordt het eerst gesloten huwelijk/partnerschap gebruikt bij het samenstellen van de aanschrijfwijze


    Scenario: Persoon met meerdere actuele partners
      Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende gegevens
      | naam                           | waarde             |
      | voornamen (02.10)              | Ferdinand Cornelis |
      | geslachtsnaam (02.40)          | Groen              |
      | aanduiding naamgebruik (61.10) | N                  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde   |
      | geslachtsnaam (02.40)                                              | Geel     |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19580401 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde   |
      | voorvoegsel (02.30)                                                | in 't    |
      | geslachtsnaam (02.40)                                              | Roodt    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19610831 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                           |
      | type                | RaadpleegMetBurgerservicenummer  |
      | burgerservicenummer | 000000309                        |
      | fields              | adressering.aanschrijfwijze.naam |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde          |
      | aanschrijfwijze.naam | F.C. Groen-Geel |

    Scenario: Persoon met meerdere actuele partners
      Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende gegevens
      | naam                           | waarde             |
      | voornamen (02.10)              | Ferdinand Cornelis |
      | geslachtsnaam (02.40)          | Groen              |
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
      | naam                | waarde                           |
      | type                | RaadpleegMetBurgerservicenummer  |
      | burgerservicenummer | 000000309                        |
      | fields              | adressering.aanschrijfwijze.naam |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde          |
      | aanschrijfwijze.naam | F.C. Groen-Geel |
