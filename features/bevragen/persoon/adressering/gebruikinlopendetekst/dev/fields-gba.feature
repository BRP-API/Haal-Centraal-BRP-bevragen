#language: nl

@gba
Functionaliteit: adressering gebruikInLopendeTekst veld vragen met fields

  Regel: Voor adressering.gebruikInLopendeTekst in fields moeten andere velden worden geleverd

    Scenario: adressering.gebruikInLopendeTekst is gevraagd
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
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000139                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                  | waarde |
      | geslacht.code         | M      |
      | geslacht.omschrijving | man    |
      En heeft de persoon de volgende 'naam' gegevens
      | naam                                 | waarde              |
      | voornamen                            | Jan Peter           |
      | adellijkeTitelPredicaat.code         | JH                  |
      | adellijkeTitelPredicaat.omschrijving | jonkheer            |
      | adellijkeTitelPredicaat.soort        | predicaat           |
      | voorvoegsel                          | te                  |
      | geslachtsnaam                        | Hoogh               |
      | aanduidingNaamgebruik.code           | E                   |
      | aanduidingNaamgebruik.omschrijving   | eigen geslachtsnaam |
      En heeft de response een persoon met een 'partner' met de volgende 'naam' gegevens
      | naam                                 | waarde  |
      | adellijkeTitelPredicaat.code         | BS      |
      | adellijkeTitelPredicaat.omschrijving | barones |
      | adellijkeTitelPredicaat.soort        | titel   |
      | voorvoegsel                          | van den |
      | geslachtsnaam                        | Aedel   |
      En heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20010809 |
      En heeft de 'partner' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20211109 |

    Scenario: persoon heeft meerdere actuele huwelijken/partnerschappen
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                                 | waarde    |
      | geslachtsnaam (02.40)                | Maassen   |
      | geslachtsaanduiding (04.10)          | V         |
      | aanduiding naamgebruik (61.10)       | E         |
      En de persoon heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | Groen                 | 20201001                                                           |
      En de persoon heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | Geel                  | 20220414                                                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000012                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                  | waarde |
      | geslacht.code         | V      |
      | geslacht.omschrijving | vrouw  |
      En heeft de persoon de volgende 'naam' gegevens
      | naam                                 | waarde              |
      | geslachtsnaam                        | Maassen             |
      | aanduidingNaamgebruik.code           | E                   |
      | aanduidingNaamgebruik.omschrijving   | eigen geslachtsnaam |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                              | waarde   |
      | naam.geslachtsnaam                | Groen    |
      | aangaanHuwelijkPartnerschap.datum | 20201001 |
      En heeft de persoon een 'partner' met de volgende gegevens
      | naam                              | waarde   |
      | naam.geslachtsnaam                | Geel     |
      | aangaanHuwelijkPartnerschap.datum | 20220414 |
