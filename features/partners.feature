# language: nl

@post-assert
Functionaliteit: Huwelijken en geregistreerd partnerschappen van een persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- het (de) huwelijk(en) of geregistreerd partnerschap(pen) geleverd.
  Dit bevat de gegevens over de relatie (huwelijk of partnerschap) plus enkele identificerende eigenschappen van de persoon waarmee het huwelijk of partnerschap is aangegaan.

  # RvIG levert personen in de vorm GbaPersoon, waarin alleen onbewerkte GBA-V gegevens worden geleverd
  # Als er een (of meer) actuele partner is worden geen ontbonden huwelijken/partnerschappen geleverd
  # Als er alleen ontbonden huwelijken/partnerschappen zijn levert de RvIG alleen de ex-partner met de meest recente datum ontbinding
  # Een proxy vertaalt dit naar de vorm Persoon, waarin sommige gegevens in bewerkte vorm worden opgenomen en waarin informatievragen kunnen zitten
  # Een voorbeeld van een informatievraag is naam.aanschrijfwijze, waarin op basis van de aanduiding naamgebruik, de naam van de persoon en de naam van de (ex)partner een aanschrijfnaam wordt samengesteld

  @gba
  Rule: Als er een of meer actuele huwelijken/partnerschappen aanwezig zijn worden alleen die actuele partners geleverd.
    - Als er een (of meer) actuele partner(s) is/zijn worden deze geleverd en worden geen ontbonden huwelijken/partnerschappen geleverd

    @gba
    Scenario: een actuele partner en geen ontbonden partner(s)
      Gegeven de persoon met burgerservicenummer '555550001' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geboorteplaats (03.20) | geboorteland (03.30) | geslachtsaanduiding (04.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | soort verbintenis (15.10) |
      | 555550002                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030                 | M                           | 20171103                                                           | 0513                                                                | 6030                                                              | H                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 555550002 |
      | geslacht.code                 | M         |
      | geslacht.omschrijving         | man       |
      | soortVerbintenis.code         | H         |
      | soortVerbintenis.omschrijving | huwelijk  |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam                         | waarde |
      | voornamen                    | Jan    |
      | adellijkeTitelPredicaat.code | JH     |
      | voorvoegsel                  | van    |
      | geslachtsnaam                | Aedel  |
      En heeft de 'partner' de volgende 'geboorte' gegevens
      | naam              | waarde      |
      | datum.type        | Datum       |
      | datum.datum       | 1982-05-26  |
      | datum.langFormaat | 26 mei 1982 |
      | plaats.code       | 0599        |
      | land.code         | 6030        |
      En heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam              | waarde          |
      | datum.type        | Datum           |
      | datum.datum       | 2017-11-03      |
      | datum.langFormaat | 3 november 2017 |
      | plaats.code       | 0513            |
      | land.code         | 6030            |

    @gba
    Scenario: een actuele partner en een ontbonden partner
      Gegeven de persoon met burgerservicenummer 555550003 heeft de volgende huwelijken/partnerschappen in de registratie
      | Stapel | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Geboorteplaats (03.20) | Geboorteland | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Plaats aangaan (06.20) | Land aangaan (06.30) | Datum ontbinding (07.10) | soort verbintenis (15.10) |
      | 1      | 5         | 555550004                   | Marieke           |                                      |                     | Groenen               | 19861004              | 0503                   | 6030         | V                           | 20210720              | Dunvegan               | 6039                 |                          | P                         |
      | 2      | 5         | 555550005                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030         | M                           |                       |                        |                      | 20191210                 |                           |
      | 2      | 55        | 555550005                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030         | M                           | 20171103              | 0513                   | 6030                 |                          | H                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '555550003' een partner met de volgende gegevens
      | naam                          | waarde                     |
      | burgerservicenummer           | 555550004                  |
      | geslacht.code                 | V                          |
      | geslacht.omschrijving         | vrouw                      |
      | soortVerbintenis.code         | P                          |
      | soortVerbintenis.omschrijving | geregistreerd partnerschap |
      En heeft de partner met burgerservicenummer '555550004' de volgende 'naam' gegevens
      | naam          | waarde  |
      | voornamen     | Marieke |
      | geslachtsnaam | Groenen |
      En heeft de partner met burgerservicenummer '555550004' de volgende 'geboorte' gegevens
      | naam   | waarde   |
      | datum  | 19861004 |
      | plaats | 0503     |
      | land   | 6030     |
      En heeft de partner met burgerservicenummer '555550004' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam   | waarde   |
      | datum  | 20210720 |
      | plaats | Dunvegan |
      | land   | 6039     |
      En de partner met burgerservicenummer '555550004' heeft GEEN 'ontbindingHuwelijkPartnerschap' gegevens
      En heeft de persoon met burgerservicenummer '555550003' géén partner met burgerservicenummer '555550005'

  @gba
  Rule: Als er geen actueel huwelijk/partnerschap aanwezig is, maar wel een of meer ontbonden huwelijken/partnerschappen wordt de ex-partner met de meest recent ontbonden partnerschap geleverd.
  - Als er alleen ontbonden huwelijken/partnerschappen zijn levert de RvIG alleen de ex-partner met de meest recente datum ontbinding
  - Voor een ontbonden huwelijk of partnerschap worden de aangaanHuwelijkPartnerschap gegevens gehaald uit de meest recente historische categorie 55

  @gba
  Rule: Een partner wordt niet opgenomen wanneer het huwelijk of het partnerschap onjuist is
    - Een huwelijk of partnerschap is onjuist wanneer het categorie 5 voorkomen geen (waarden in) groepen 01, 02, 03, 04, 06, 07 en 15 heeft.
    - Wanneer een van de gegevens in groepen 01, 02, 03, 04, 06, 07 en 15 een standaardwaarde heeft, geldt dat hier als het bestaan van een waarde en is de partner niet onjuist

    # N.B. Het meest recente categorie 55 voorkomen heeft dan een waarde voor Onjuist (84.10).

    @gba
    Scenario: Huwelijk/partnerschap is onjuist
      Gegeven de persoon met burgerservicenummer 999993008 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Voornamen (02.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | Onjuist (84.10) | Registergemeente akte (81.10) | Aktenummer (81.20) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
        | 5         |                   |                       |                           |                          |                          |                 | 0518                          | 5XC1111            | 20050818                        | 20050818                   |
        | 55        | Youssef Saïd      | 20050811              | P                         |                          |                          | O               | 0518                          | 5XC1111            | 20050811                        | 20050812                   |
      En in categorie 5 zijn alleen groepen of 81 of 82, 85 en 86 opgenomen en geen groepen 01, 02, 03, 04, 06, 07 en 15
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993008                       |
      | fields              | partners                        |
      Dan bevat het antwoord GEEN partners

    @gba
    Scenario: Partner is volledig onbekend (dus niet onjuist)
      Gegeven de persoon met burgerservicenummer 999993008 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Voornamen (02.10) | Geslachtsnaam (02.40) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | Onjuist (84.10) | Registergemeente akte (81.10) | Aktenummer (81.20) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
        | 5         |                   | .                     | 00000000              | .                         |                          |                          |                 | 0518                          | 5XC1111            | 20050818                        | 20050818                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993380                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999993380' alleen 'partners' met de volgende gegevens
      | naam                          | waarde   |
      | soortVerbintenis.code         | .        |
      | soortVerbintenis.omschrijving | onbekend |
      En heeft de partner de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | .      |
      En heeft de partner de volgende aangaanHuwelijkPartnerschap gegevens
      | naam  | waarde   |
      | datum | 00000000 |


  @gba
  Rule: De geleverde partnergegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
    Bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van de partner

    @gba
    Scenario: De partner heeft geslachtswijziging en naamswijziging ondergaan, maar de gevraagde persoon erkent dit niet
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen | geslacht (04.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) |
      | 5         | 555550002                   | Karel     | M                | 20091102              |                          |
      En de partner met burgerservicenummer 555550002 heeft haar geslacht en voornamen gewijzigd zodat de volgende persoonsgegevens in de registratie op haar persoonslijst staan:
      | Categorie | Voornamen (02.10) | Geslachtsaanduiding (04.10) |
      | 1         | Charlotte         | V                           |
      | 51        | Karel             | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 555550001                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de persoon met burgerservicenummer '555550001' alleen 'partners' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      | geslacht            | M         |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |
