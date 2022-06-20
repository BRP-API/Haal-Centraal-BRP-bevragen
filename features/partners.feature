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
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Geboorteplaats (03.20) | Geboorteland | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Plaats aangaan (06.20) | Land aangaan (06.30) | Datum ontbinding (07.10) | soort verbintenis (15.10) |
      | 5         | 555550002                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030         | M                           | 20171103              | 0513                   | 6030                 |                          | H                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '555550001' alleen 'partners' met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 555550002 |
      | geslacht.code                 | M         |
      | geslacht.omschrijving         | man       |
      | soortVerbintenis.code         | H         |
      | soortVerbintenis.omschrijving | huwelijk  |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'naam' gegevens
      | naam                    | waarde |
      | voornamen               | Jan    |
      | adellijkeTitelPredicaat | JH     |
      | voorvoegsel             | van    |
      | geslachtsnaam           | Aedel  |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'geboorte' gegevens
      | naam   | waarde   |
      | datum  | 19820526 |
      | plaats | 0599     |
      | land   | 6030     |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam   | waarde   |
      | datum  | 20171103 |
      | plaats | 0513     |
      | land   | 6030     |
      En de partner met burgerservicenummer '555550002' heeft GEEN 'ontbindingHuwelijkPartnerschap' gegevens

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
    Scenario: alleen ontbonden partners
      Gegeven de persoon met burgerservicenummer 555550006 heeft de volgende huwelijken/partnerschappen in de registratie
      | Stapel | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Geboorteplaats (03.20) | Geboorteland | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Plaats aangaan (06.20) | Land aangaan (06.30) | Datum ontbinding (07.10) | soort verbintenis (15.10) |
      | 1      | 5         | 555550007                   | Marieke           |                                      |                     | Groenen               | 19861004              | 0503                   | 6030         | V                           |                       |                        |                      | 20220301                 |                           |
      | 1      | 55        | 555550007                   | Marieke           |                                      |                     | Groenen               | 19861004              | 0503                   | 6030         | V                           | 20210720              | Dunvegan               | 6039                 |                          | P                         |
      | 2      | 5         | 555550008                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030         | M                           |                       |                        |                      | 20191210                 |                           |
      | 2      | 55        | 555550008                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030         | M                           | 20171103              | 0513                   | 6030                 |                          | H                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550006                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '555550006' een partner met de volgende gegevens
      | naam                         | waarde                     |
      | burgerservicenummer          | 555550007                  |
      | geslacht.code                | V                          |
      | geslacht.omschrijving        | vrouw                      |
      | soortVerbintenis.code        | P                          |
      | soorVerbintenis.omschrijving | geregistreerd partnerschap |
      En heeft de partner met burgerservicenummer '555550007' de volgende 'naam' gegevens
      | naam                    | waarde  |
      | voornamen               | Marieke |
      | adellijkeTitelPredicaat |         |
      | voorvoegsel             |         |
      | geslachtsnaam           | Groenen |
      En heeft de partner met burgerservicenummer '555550007' de volgende 'geboorte' gegevens
      | naam   | waarde   |
      | datum  | 19861004 |
      | plaats | 0503     |
      | land   | 6030     |
      En heeft de partner met burgerservicenummer '555550007' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam   | waarde   |
      | datum  | 20210720 |
      | plaats | Dunvegan |
      | land   | 6039     |
      En heeft de partner met burgerservicenummer '555550007' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20220301 |
      En heeft de persoon met burgerservicenummer '555550006' géén partner met burgerservicenummer '555550008'

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


  @proxy
  Rule: Als er een actueel huwelijk of geregistreerd partnerschap is wordt alleen dit actueel huwelijk of geregistreerd partnerschap teruggegeven,
          als er geen actueel huwelijk of geregistreerd partnerschap is, maar wel een ontbonden huwelijk of geregistreerd partnerschap dan wordt alleen het meest recente ontbonden huwelijk of geregistreerd partnerschap geleverd.

    @proxy
    Scenario: Actueel huwelijk
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990184 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 555550001 |
      | soortVerbintenis.code         | H         |
      | soortVerbintenis.omschrijving | huwelijk  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Merel  |
      En de 'partner' heeft GEEN 'ontbindingHuwelijkPartnerschap' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 999990184                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Merel  |

    @proxy
    Scenario: Actueel partnerschap
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993380 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                          | waarde                     |
      | burgerservicenummer           | 555550002                  |
      | soortVerbintenis.code         | P                          |
      | soortVerbintenis.omschrijving | geregistreerd partnerschap |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam      | waarde   |
      | voornamen | Reindert |
      En de 'partner' heeft GEEN 'ontbindingHuwelijkPartnerschap' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 999993380                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam      | waarde   |
      | voornamen | Reindert |

    @proxy
    Abstract Scenario: Huwelijk/partnerschap is ontbonden <omschrijving>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992806 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Osama  |
      En de 'partner' heeft de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde             |
      | datum | <datum ontbinding> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992806                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam        | waarde |
      | voorletters | O.     |
      | voornamen   | Osama  |
      En heeft de 'partner' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam              | waarde              |
      | datum.type        | <datum-type>        |
      | datum.datum       | <datum-datum>       |
      | datum.langFormaat | <datum-langFormaat> |
      | datum.onbekend    | <datum-onbekend>    |

      Voorbeelden:
      | omschrijving            | datum ontbinding | datum-type    | datum-datum | datum-langFormaat | datum-onbekend |
      | met bekende einddatum   | 20011109         | Datum         | 2001-11-09  | 9 november 2001   |                |
      | met onbekende einddatum | 00000000         | DatumOnbekend |             | onbekend          | true           |

    @proxy
    Scenario: Een actueel huwelijk en een ontbonden huwelijk
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999991553 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20091102 |
      En de 'partner' heeft GEEN 'ontbindingHuwelijkPartnerschap' gegevens
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Björn  |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 19870714 |
      En de 'partner' heeft de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20080706 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 999991553                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                | waarde                                               |
      | burgerservicenummer | 555550004           |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |


  @proxy
  Rule: Wanneer geen van de gevraagde gegevens van de partner een waarde heeft, wordt er een 'partners' zonder gegevens geleverd.
    - Dit is het geval wanneer elk gevraagd gegeven van de partner leeg is of een standaardwaarde/onbekend waarde heeft die niet geleverd wordt (zie onbekend_waardes.feature).

    @proxy
    Scenario: Met fields zijn alleen velden zonder waarde gevraagd
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993008 |
      En de persoon heeft een 'partner' met alleen de volgende 'naam' gegevens
      | naam          | waarde           |
      | voornamen     |                  |
      | geslachtsnaam | Ali bin Mohammed |
      En de 'partner' heeft GEEN 'ontbindingHuwelijkPartnerschap' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993008                       |
      | fields              | partners.naam.voornamen         |
      Dan heeft de response een persoon met een leeg 'partner' object
