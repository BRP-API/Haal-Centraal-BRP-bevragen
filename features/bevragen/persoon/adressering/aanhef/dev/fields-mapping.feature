#language: nl

Functionaliteit: Fields vertalen van proxy naar gba voor aanhef

  Rule: Voor sommige gevraagde velden in fields moeten (aanvullend) andere velden worden geleverd
    De vertaling van in fields gevraagde veld(paden) en in GbaPersoon te leveren velden staat in features/fields-mapping-gba.csv.
    Het in fields gevraagde pad staat in kolom "volledig pad". De bijbehorende waarde in kolom "gba pad" beschrijft de waarde van te leveren velden in GbaPersoon.
    Wanneer 1 veld in fields meer dan 1 veld in GbaPersoon vraagt, staan de verschillende GbaPersoon paden gescheiden met een |.

    Abstract Scenario: <fields> is gevraagd
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                                 | waarde    |
      | geslachtsaanduiding (04.10)          | M         |
      | voornamen (02.10)                    | Jan Peter |
      | adellijke titel of predicaat (02.20) | JH        |
      | voorvoegsel (02.30)                  | te        |
      | geslachtsnaam (02.40)                | Hoogh     |
      | aanduiding naamgebruik (61.10)       | E         |
      En de persoon heeft een 'ex-partner' met de volgende gegevens
      | naam                                                         | waarde         |
      | voornamen (02.10)                                            | Anna Catharina |
      | adellijke titel of predicaat (02.20)                         | BS             |
      | voorvoegsel (02.30)                                          | van den        |
      | geslachtsnaam (02.40)                                        | Aedel          |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20211109       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <fields>                        |
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
      En heeft de 'partner' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20211109 |

      Voorbeelden:
      | fields                            |
      | adressering.aanhef                |
      | aanhef                            |
      | aanhef,aanschrijfwijze            |
    