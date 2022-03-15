# language: nl

Functionaliteit: Huwelijken en geregistreerd partnerschappen van een persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- het (de) huwelijk(en) of geregistreerd partnerschap(pen) geleverd.
  Dit bevat de gegevens over de relatie (huwelijk of partnerschap) plus enkele identificerende eigenschappen van de persoon waarmee het huwelijk of partnerschap is aangegaan.

  # RvIG levert personen in de vorm GbaPersoon, waarin alleen onbewerkte GBA-V gegevens worden geleverd
  # Dit betekent dat in 'partners' zowel actuele partners zitten als ontbonden partners
  # Een proxy vertaalt dit naar de vorm Persoon, waarin sommige gegevens in bewerkte vorm worden opgenomen en waarin informatievragen kunnen zitten
  # Een voorbeeld van een informatievraag is naam.aanschrijfwijze, waarin op basis van de aanduiding naamgebruik, de naam van de persoon en de naam van de (ex)partner een aanschrijfnaam wordt samengesteld
  # De proxy verwijdert de partners met datum ontbinding die geleverd zijn in de GbaPersoon

  @gba
  Rule: Het gegeven 'partners' in GbaPersoon bevat ook ontbonden huwelijken en partnerschappen

    @gba
    Scenario: een actuele partner en geen ontbonden partner(s)
      Gegeven de persoon met burgerservicenummer 999992934 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Geboorteplaats (03.20) | Geboorteland | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Plaats aangaan (06.20) | Land aangaan (06.30) | Datum ontbinding (07.10) | soort verbintenis (15.10) |
      | 5         | 555550001                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030         | M                           | 20171103              | 0513                   | 6030                 |                          | H                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999992934' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 555550001           |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | voornamen                            | Jan       |
      | adellijkeTitelPredicaat.code         | JH        |
      | adellijkeTitelPredicaat.omschrijving | jonkheer  |
      | adellijkeTitelPredicaat.soort        | predicaat |
      | voorvoegsel                          | van       |
      | geslachtsnaam                        | Aedel     |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'geboorte' gegevens
      | naam                | waarde    |
      | datum               | 19820526  |
      | plaats.code         | 0599      |
      | plaats.omschrijving | Rotterdam |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'soortVerbintenis' gegevens
      | naam         | waarde   |
      | code         | H        |
      | omschrijving | huwelijk |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20171103  |
      | plaats.code         | 0513      |
      | plaats.omschrijving | Gouda     |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En de partner met burgerservicenummer '555550001' heeft GEEN ontbindingHuwelijkPartnerschap gegevens

    @gba
    Scenario: een actuele partner en een ontbonden partner
      Gegeven de persoon met burgerservicenummer 999992934 heeft de volgende huwelijken/partnerschappen in de registratie
      | Stapel | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Geboorteplaats (03.20) | Geboorteland | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Plaats aangaan (06.20) | Land aangaan (06.30) | Datum ontbinding (07.10) | soort verbintenis (15.10) |
      | 1      | 5         | 555550002                   | Marieke           |                                      |                     | Groenen               | 19861004              | 0503                   | 6030         | V                           | 20210720              | Dunvegan               | 6039                 |                          | P                         |
      | 2      | 5         |                             |                   |                                      |                     |                       |                       |                        |              |                             |                       |                        |                      | 20191210                 |                           |
      | 2      | 55        | 555550001                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030         | M                           | 20171103              | 0513                   | 6030                 |                          | H                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999992934' een partner met de volgende gegevens
      | burgerservicenummer |
      | 555550001           |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | voornamen                            | Jan       |
      | adellijkeTitelPredicaat.code         | JH        |
      | adellijkeTitelPredicaat.omschrijving | jonkheer  |
      | adellijkeTitelPredicaat.soort        | predicaat |
      | voorvoegsel                          | van       |
      | geslachtsnaam                        | Aedel     |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'geboorte' gegevens
      | naam                | waarde    |
      | datum               | 19820526  |
      | plaats.code         | 0599      |
      | plaats.omschrijving | Rotterdam |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'soortVerbintenis' gegevens
      | naam         | waarde   |
      | code         | H        |
      | omschrijving | huwelijk |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20171103  |
      | plaats.code         | 0513      |
      | plaats.omschrijving | Gouda     |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20191210  |
      En heeft de persoon met burgerservicenummer '999992934' een partner met de volgende gegevens
      | burgerservicenummer |
      | 555550002           |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | V      |
      | omschrijving | vrouw  |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'naam' gegevens
      | naam                                 | waarde  |
      | voornamen                            | Marieke |
      | adellijkeTitelPredicaat.code         |         |
      | adellijkeTitelPredicaat.omschrijving |         |
      | adellijkeTitelPredicaat.soort        |         |
      | voorvoegsel                          |         |
      | geslachtsnaam                        | Groenen |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'geboorte' gegevens
      | naam                | waarde    |
      | datum               | 19861004  |
      | plaats.code         | 0503      |
      | plaats.omschrijving | Delft     |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'soortVerbintenis' gegevens
      | naam         | waarde                     |
      | code         | P                          |
      | omschrijving | geregistreerd partnerschap |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde          |
      | datum               | 20210720        |
      | plaats.code         |                 |
      | plaats.omschrijving | Dunvegan        |
      | land.code           | 6039            |
      | land.omschrijving   | Grootbrittannië |
      En de partner met burgerservicenummer '555550002' heeft GEEN ontbindingHuwelijkPartnerschap gegevens

    @gba
    Scenario: alleen ontbonden partners
      Gegeven de persoon met burgerservicenummer 999992934 heeft de volgende huwelijken/partnerschappen in de registratie
      | Stapel | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Geboorteplaats (03.20) | Geboorteland | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Plaats aangaan (06.20) | Land aangaan (06.30) | Datum ontbinding (07.10) | soort verbintenis (15.10) |
      | 1      | 5         |                             |                   |                                      |                     |                       |                       |                        |              |                             |                       |                        |                      | 20220301                 |                           |
      | 1      | 55        | 555550002                   | Marieke           |                                      |                     | Groenen               | 19861004              | 0503                   | 6030         | V                           | 20210720              | Dunvegan               | 6039                 |                          | P                         |
      | 2      | 5         |                             |                   |                                      |                     |                       |                       |                        |              |                             |                       |                        |                      | 20191210                 |                           |
      | 2      | 55        | 555550001                   | Jan               | JH                                   | van                 | Aedel                 | 19820526              | 0599                   | 6030         | M                           | 20171103              | 0513                   | 6030                 |                          | H                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999992934' een partner met de volgende gegevens
      | burgerservicenummer |
      | 555550001           |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | voornamen                            | Jan       |
      | adellijkeTitelPredicaat.code         | JH        |
      | adellijkeTitelPredicaat.omschrijving | jonkheer  |
      | adellijkeTitelPredicaat.soort        | predicaat |
      | voorvoegsel                          | van       |
      | geslachtsnaam                        | Aedel     |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'geboorte' gegevens
      | naam                | waarde    |
      | datum               | 19820526  |
      | plaats.code         | 0599      |
      | plaats.omschrijving | Rotterdam |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'soortVerbintenis' gegevens
      | naam         | waarde   |
      | code         | H        |
      | omschrijving | huwelijk |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20171103  |
      | plaats.code         | 0513      |
      | plaats.omschrijving | Gouda     |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20191210  |
      En heeft de persoon met burgerservicenummer '999992934' een partner met de volgende gegevens
      | burgerservicenummer |
      | 555550002           |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | V      |
      | omschrijving | vrouw  |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'naam' gegevens
      | naam                                 | waarde  |
      | voornamen                            | Marieke |
      | adellijkeTitelPredicaat.code         |         |
      | adellijkeTitelPredicaat.omschrijving |         |
      | adellijkeTitelPredicaat.soort        |         |
      | voorvoegsel                          |         |
      | geslachtsnaam                        | Groenen |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'geboorte' gegevens
      | naam                | waarde    |
      | datum               | 19861004  |
      | plaats.code         | 0503      |
      | plaats.omschrijving | Delft     |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'soortVerbintenis' gegevens
      | naam         | waarde                     |
      | code         | P                          |
      | omschrijving | geregistreerd partnerschap |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde          |
      | datum               | 20210720        |
      | plaats.code         |                 |
      | plaats.omschrijving | Dunvegan        |
      | land.code           | 6039            |
      | land.omschrijving   | Grootbrittannië |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20220301  |

  
  @gba
  Rule: Een partner wordt niet opgenomen wanneer het huwelijk of het partnerschap onjuist is
    Een huwelijk of partnerschap is onjuist wanneer het categorie 5 voorkomen geen (waarden in) groepen 01, 02, 03, 04, 06, 07 en 15 heeft.
    
    # N.B. Het meest recente categorie 55 voorkomen heeft dan een waarde voor Onjuist (84.10).
    # N.B. Wanneer een van de gegevens in groepen 01, 02, 03, 04, 06, 07 en 15 een standaardwaarde heeft, geldt dat hier als het bestaan van een waarde en is de partner niet onjuist

    @gba
    Scenario: Huwelijk/partnerschap is onjuist
      Gegeven de persoon met burgerservicenummer 999993008 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Voornamen (02.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | Onjuist (84.10) | Registergemeente akte (81.10) | Aktenummer (81.20) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
        | 5         |                   |                       |                           |                          |                          |                 | 0518                          | 5XC1111            | 20050818                        | 20050818                   |
        | 55        | Youssef Saïd      | 20050811              | P                         |                          |                          | O               | 0518                          | 5XC1111            | 20050811                        | 20050812                   |
      En in categorie 5 zijn alleen groepen of 81 of 82, 85 en 86 opgenomen en geen groepen 01, 02, 03, 04, 06, 07 en 15
      Als de persoon met burgerservicenummer 999993008 wordt geraadpleegd met fields=partners
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
      Dan heeft de persoon met burgerservicenummer '999993380' exact 1 'partners'
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
      | Categorie | Burgerservicenummer (01.20) | Voornamen | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) |
      | 5         | 555550002                   | Karel     | M                           | 20091102              |                          |
      En de partner met burgerservicenummer 555550002 heeft haar geslachtsaanduiding en voornamen gewijzigd zodat de volgende persoonsgegevens in de registratie op haar persoonslijst staan:
      | Categorie | Voornamen (02.10) | Geslachtsaanduiding (04.10) |
      | 1         | Charlotte         | V                           |
      | 51        | Karel             | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 555550001                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de persoon met burgerservicenummer '555550001' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 555550002           |
      En heeft de partner met burgerservicenummer '555550002' de volgende geslachtsaanduiding gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner met burgerservicenummer '555550002' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |


  @proxy
  Rule: Alleen een actueel huwelijk of geregistreerd partnerschap wordt teruggegeven
    Een huwelijk of partnerschap is actueel wanneer het niet is ontbonden: ontbindingHuwelijkPartnerschap komt niet voor (heeft geen waarde)

    @proxy
    Scenario: Actueel huwelijk
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990184 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                  | waarde    |
      | burgerservicenummer   | 555550001 |
      | soortVerbintenis.code | H         |
      En de partner met burgerservicenummer '555550001' heeft de volgende naam gegevens
      | naam      | waarde |
      | voornamen | Merel  |
      En de partner met burgerservicenummer '555550001' heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 999990184                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de persoon met burgerservicenummer '999990184' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992935           |
      En heeft de partner met burgerservicenummer '999992935' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Merel  |

    @proxy
    Scenario: Actueel partnerschap
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993380 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                  | waarde    |
      | burgerservicenummer   | 555550002 |
      | soortVerbintenis.code | p         |
      En de partner met burgerservicenummer '555550002' heeft de volgende naam gegevens
      | naam      | waarde   |
      | voornamen | Reindert |
      En de partner met burgerservicenummer '555550002' heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 999993380                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de persoon met burgerservicenummer '999993380' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992935           |
      En heeft de partner met burgerservicenummer '999992935' de volgende 'naam' gegevens
      | naam      | waarde   |
      | voornamen | Reindert |

    @proxy
    Scenario: Huwelijk/partnerschap is ontbonden
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992806 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de partner met burgerservicenummer '555550003' heeft de volgende naam gegevens
      | naam      | waarde |
      | voornamen | Osama  |
      En de partner met burgerservicenummer '555550003' heeft de volgende ontbindingHuwelijkPartnerschap gegevens
      | naam  | waarde   |
      | datum | 20011109 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993380                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999992806' GEEN 'partners'

    @proxy
    Scenario: Een actueel huwelijk en een ontbonden huwelijk
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999991553 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En de partner met burgerservicenummer '555550004' heeft de volgende naam gegevens
      | naam      | waarde |
      | voornamen | Karel  |
      En de partner met burgerservicenummer '555550004' heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam  | waarde   |
      | datum | 20091102 |
      En de partner met burgerservicenummer '555550004' heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En de partner met burgerservicenummer '555550005' heeft de volgende naam gegevens
      | naam      | waarde |
      | voornamen | Björn  |
      En de partner met burgerservicenummer '555550005' heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam  | waarde   |
      | datum | 19870714 |
      En de partner met burgerservicenummer '555550005' heeft de volgende ontbindingHuwelijkPartnerschap gegevens
      | naam  | waarde   |
      | datum | 20080706 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 999991553                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de persoon met burgerservicenummer '999991553' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 555550004           |
      En heeft de partner met burgerservicenummer '555550004' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |
  

  @proxy
  Rule: Wanneer de geslachtsnaam van de partner onbekend is, wordt de partner geleverd met type "OnbekendPartner" en indicatieOnbekend met waarde true
    - Dit is het geval wanneer geslachtsnaam dan de standaardwaarde "." heeft
    - Wanneer van de partner en het huwelijk/partnerschap wel gegevens geregistreerd zijn, maar geen van de met fields gevraagde gegevens heeft een waarde, dan is het type "Partner" en wordt indicatieOnbekend NIET opgenomen

    # Onderliggende aanname is dat wanneer de geslachtsnaam van de partner onbekend is, ook andere (identificerende) partnergegevens niet bekend zijn of niet relevant.

    @proxy
    Scenario: Partner is volledig onbekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993008 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer |           |
      En de partner heeft GEEN 'geslachtsaanduiding' gegevens
      En de partner heeft alleen de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | geslachtsnaam                        | .         |
      En de partner heeft alleen de volgende 'geboorte' gegevens
      | naam                | waarde    |
      | datum               | 00000000  |
      En de partner heeft de volgende 'soortVerbintenis' gegevens
      | naam         | waarde   |
      | code         | .        |
      En de partner heeft alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 19560327  |      
      En de partner met burgerservicenummer '555550005' heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993008                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999993008' exact 1 'partners'
      En heeft de partner alleen de volgende gegevens
      | naam              | waarde          |
      | type              | OnbekendPartner |
      | indicatieOnbekend | true            |

    @proxy
    Scenario: Met fields zijn alleen velden zonder waarde gevraagd
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993008 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En de partner heeft GEEN 'geslachtsaanduiding' gegevens
      En de partner heeft alleen de volgende 'naam' gegevens
      | naam                                 | waarde           |
      | voornamen                            |                  |
      | geslachtsnaam                        | Ali bin Mohammed |
      En de partner heeft alleen de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 19750730 |
      En de partner heeft de volgende 'soortVerbintenis' gegevens
      | naam | waarde |
      | code | H      |
      En de partner heeft alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20190829 |
      En de partner met burgerservicenummer '555550005' heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetBurgerservicenummer                 |
      | burgerservicenummer | 999993008                                       |
      | fields              | partners.voornamen,partners.geslachtsaanduiding |
      Dan heeft de persoon met burgerservicenummer '999993008' exact 1 'partners'
      En heeft de partner alleen de volgende gegevens
      | naam | waarde  |
      | type | Partner |

