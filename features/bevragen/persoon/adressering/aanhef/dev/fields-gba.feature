#language: nl

Functionaliteit: Fields vertalen van proxy naar gba voor aanhef

  Rule: Voor adressering.aanhef in fields moeten andere velden worden geleverd

    Scenario: aanhef is gevraagd
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                                 | waarde    |
      | geslachtsaanduiding (04.10)          | M         |
      | voornamen (02.10)                    | Jan Peter |
      | adellijke titel of predicaat (02.20) | JH        |
      | voorvoegsel (02.30)                  | te        |
      | geslachtsnaam (02.40)                | Hoogh     |
      | aanduiding naamgebruik (61.10)       | E         |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde         |
      | voornamen (02.10)                                                  | Anna Catharina |
      | adellijke titel of predicaat (02.20)                               | BS             |
      | voorvoegsel (02.30)                                                | van den        |
      | geslachtsnaam (02.40)                                              | Aedel          |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20010809       |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                               | waarde         |
      | voornamen (02.10)                                                  | Anna Catharina |
      | adellijke titel of predicaat (02.20)                               | BS             |
      | voorvoegsel (02.30)                                                | van den        |
      | geslachtsnaam (02.40)                                              | Aedel          |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10)       | 20211109       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.aanhef              |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                  | waarde |
      | geslacht.code         | M      |
      | geslacht.omschrijving | man    |
      En heeft de persoon de volgende 'naam' gegevens
      | naam                                 | waarde              |
      | voornamen                            | Jan Peter           |
      | adellijkeTitelPredicaat.code         | JH                  |
      | adellijkeTitelPredicaat.omschrijving | Jonkheer            |
      | adellijkeTitelPredicaat.soort        | predicaat           |
      | voorvoegsel                          | te                  |
      | geslachtsnaam                        | Hoogh               |
      | aanduidingNaamgebruik.code           | E                   |
      | aanduidingNaamgebruik.omschrijving   | eigen geslachtsnaam |
      En heeft de response een persoon met een 'partner' met de volgende 'naam' gegevens
      | naam                                 | waarde  |
      | adellijkeTitelPredicaat.code         | BS      |
      | adellijkeTitelPredicaat.omschrijving | Barones |
      | adellijkeTitelPredicaat.soort        | titel   |
      | voorvoegsel                          | van den |
      | geslachtsnaam                        | Aedel   |
      En heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20010809 |
      En heeft de 'partner' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20211109 |
   