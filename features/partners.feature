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

  Rule: Als er een of meer actuele huwelijken/partnerschappen aanwezig zijn worden alleen die actuele partners geleverd.
    - Als er een (of meer) actuele partner(s) is/zijn worden deze geleverd en worden geen ontbonden huwelijken/partnerschappen geleverd

    @gba
    Scenario: een actuele partner en geen ontbonden partner(s)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                   | waarde    |
      | burgerservicenummer (01.20)                                            | 555550002 |
      | voornamen (05.02.10)                                                   | Jan       |
      | adellijke titel of predicaat (05.02.20)                                | JH        |
      | voorvoegsel (05.02.30)                                                 | van       |
      | geslachtsnaam (05.02.40)                                               | Aedel     |
      | geboortedatum (05.03.10)                                               | 19820526  |
      | geboorteplaats (05.03.20)                                              | 0599      |
      | geboorteland (05.03.30)                                                | 6030      |
      | geslachtsaanduiding (04.10)                                            | M         |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (05.06.10)  | 20171103  |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (05.06.20) | 0513      |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (05.06.30)   | 6030      |
      | soort verbintenis (15.10)                                              | H         |
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
      | naam                                 | waarde   |
      | voornamen                            | Jan      |
      | adellijkeTitelPredicaat.code         | JH       |
      | adellijkeTitelPredicaat.omschrijving | jonkheer |
      | voorvoegsel                          | van      |
      | geslachtsnaam                        | Aedel    |
      En heeft de 'partner' de volgende 'geboorte' gegevens
      | naam                | waarde    |
      | datum               | 19820526  |
      | plaats.code         | 0599      |
      | plaats.omschrijving | Rotterdam |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |
      En heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20171103  |
      | plaats.code         | 0513      |
      | plaats.omschrijving | Gouda     |
      | land.code           | 6030      |
      | land.omschrijving   | Nederland |

    @gba
    Scenario: een actuele partner en een ontbonden partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 555550003 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde    |
      | burgerservicenummer (01.20)                                           | 555550004 |
      | voornamen (05.02.10)                                                  | Marieke   |
      | geslachtsnaam (05.02.40)                                              | Groenen   |
      | geboortedatum (05.03.10)                                              | 19861004  |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (05.06.10) | 20210720  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                            | waarde    |
      | burgerservicenummer (01.20)                                     | 555550005 |
      | voornamen (05.02.10)                                            | Jan       |
      | geslachtsnaam (05.02.40)                                        | Aedel     |
      | datum ontbinding huwelijk/geregistreerd partnerschap (05.07.10) | 20191210  |
      Als personen wordt gezocht via de GBA met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                              | waarde    |
      | burgerservicenummer               | 555550004 |
      | naam.voornamen                    | Marieke   |
      | naam.geslachtsnaam                | Groenen   |
      | geboorte.datum                    | 19861004  |
      | aangaanHuwelijkPartnerschap.datum | 20210720  |

    Scenario: een actuele partner en een ontbonden partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 555550003 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde    |
      | burgerservicenummer (01.20)                                           | 555550004 |
      | voornamen (05.02.10)                                                  | Marieke   |
      | geslachtsnaam (05.02.40)                                              | Groenen   |
      | geboortedatum (05.03.10)                                              | 19861004  |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (05.06.10) | 20210720  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                            | waarde    |
      | burgerservicenummer (01.20)                                     | 555550005 |
      | voornamen (05.02.10)                                            | Jan       |
      | geslachtsnaam (05.02.40)                                        | Aedel     |
      | datum ontbinding huwelijk/geregistreerd partnerschap (05.07.10) | 20191210  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam          | waarde  |
      | voorletters   | M.      |
      | voornamen     | Marieke |
      | geslachtsnaam | Groenen |
      En heeft de 'partner' de volgende 'geboorte' gegevens
      | naam              | waarde         |
      | datum.type        | Datum          |
      | datum.datum       | 1986-10-04     |
      | datum.langFormaat | 4 oktober 1986 |
      En heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam              | waarde       |
      | datum.type        | Datum        |
      | datum.datum       | 2021-07-20   |
      | datum.langFormaat | 20 juli 2021 |

  Rule: Als er geen actueel huwelijk/partnerschap aanwezig is, maar wel een of meer ontbonden huwelijken/partnerschappen wordt de ex-partner met de meest recent ontbonden partnerschap geleverd.
  - Als er alleen ontbonden huwelijken/partnerschappen zijn levert de RvIG alleen de ex-partner met de meest recente datum ontbinding
  - Voor een ontbonden huwelijk of partnerschap worden de aangaanHuwelijkPartnerschap gegevens gehaald uit de meest recente historische categorie 55

    @gba
    Scenario: alleen ontbonden partners
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 555550006 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde    |
      | burgerservicenummer (01.20)                                           | 555550007 |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (55.06.10) | 20210720  |
      | datum ontbinding huwelijk/geregistreerd partnerschap (05.07.10)       | 20220301  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde    |
      | burgerservicenummer (01.20)                                           | 555550008 |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (55.06.10) | 20171103  |
      | datum ontbinding huwelijk/geregistreerd partnerschap (05.07.10)       | 20191210  |
      Als personen wordt gezocht via de GBA met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550006                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                                 | waarde    |
      | burgerservicenummer                  | 555550007 |
      | aangaanHuwelijkPartnerschap.datum    | 20210720  |
      | ontbindingHuwelijkPartnerschap.datum | 20220301  |

    Scenario: alleen ontbonden partners
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 555550006 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde    |
      | burgerservicenummer (01.20)                                           | 555550007 |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (55.06.10) | 20210720  |
      | datum ontbinding huwelijk/geregistreerd partnerschap (05.07.10)       | 20220301  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde    |
      | burgerservicenummer (01.20)                                           | 555550008 |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (55.06.10) | 20171103  |
      | datum ontbinding huwelijk/geregistreerd partnerschap (05.07.10)       | 20191210  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550006                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                                             | waarde       |
      | burgerservicenummer                              | 555550007    |
      | aangaanHuwelijkPartnerschap.datum.type           | Datum        |
      | aangaanHuwelijkPartnerschap.datum.datum          | 2021-07-20   |
      | aangaanHuwelijkPartnerschap.datum.langFormaat    | 20 juli 2021 |
      | ontbindingHuwelijkPartnerschap.datum.type        | Datum        |
      | ontbindingHuwelijkPartnerschap.datum.datum       | 2022-03-01   |
      | ontbindingHuwelijkPartnerschap.datum.langFormaat | 1 maart 2022 |

  @gba
  Rule: Een partner wordt niet opgenomen wanneer het huwelijk of het partnerschap onjuist is
    - Een huwelijk of partnerschap is onjuist wanneer het categorie 5 voorkomen geen (waarden in) groepen 01, 02, 03, 04, 06, 07 en 15 heeft.
    - Wanneer een van de gegevens in groepen 01, 02, 03, 04, 06, 07 en 15 een standaardwaarde heeft, geldt dat hier als het bestaan van een waarde en is de partner niet onjuist

    # N.B. Het meest recente categorie 55 voorkomen heeft dan een waarde voor Onjuist (84.10).

    Scenario: Huwelijk/partnerschap is onjuist
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 999993008 |
      En de persoon heeft een 'partner' met alleen of groep 81 of groepen 82, 85 en 86 
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993008                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een leeg 'partners' array

    @gba
    Scenario: Partner is volledig onbekend (dus niet onjuist)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 999993008 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde   |
      | voornamen (05.02.10)                                                  |          |
      | geslachtsnaam (05.02.40)                                              | .        |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (05.06.10) | 00000000 |
      | soort verbintenis (15.10)                                             | .        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993008                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                          | waarde   |
      | soortVerbintenis.code         | .        |
      | soortVerbintenis.omschrijving | onbekend |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | .      |
      En heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 00000000 |

    Scenario: Partner is volledig onbekend (dus niet onjuist)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 999993008 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde   |
      | voornamen (05.02.10)                                                  |          |
      | geslachtsnaam (05.02.40)                                              | .        |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (05.06.10) | 00000000 |
      | soort verbintenis (15.10)                                             | .        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993008                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met een leeg 'naam' object
      En heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam              | waarde        |
      | datum.type        | DatumOnbekend |
      | datum.onbekend    | true          |
      | datum.langFormaat | onbekend      |

  Rule: De geleverde partnergegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
    Bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van de partner

    Scenario: De partner heeft geslachtswijziging en naamswijziging ondergaan, maar de gevraagde persoon erkent dit niet
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                                  | waarde    |
      | burgerservicenummer (01.20)                                           | 555550002 |
      | geslachtsaanduiding (04.10)                                           | M         |
      | voornamen (05.02.10)                                                  | Karel     |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (05.06.10) | 20091102  |
      En het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 555550002 |
      | geslachtsaanduiding (04.10) | V         |
      | voornamen (05.02.10)        | Charlotte |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 555550001                                            |
      | fields              | partners.burgerservicenummer,partners.naam.voornamen |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |

  Rule: Als er een actueel huwelijk of geregistreerd partnerschap is wordt alleen dit actueel huwelijk of geregistreerd partnerschap teruggegeven,
          als er geen actueel huwelijk of geregistreerd partnerschap is, maar wel een ontbonden huwelijk of geregistreerd partnerschap dan wordt alleen het meest recente ontbonden huwelijk of geregistreerd partnerschap geleverd.

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
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En heeft de 'partner' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |

  Rule: Wanneer geen van de gevraagde gegevens van de partner een waarde heeft, wordt er een 'partners' zonder gegevens geleverd.
    - Dit is het geval wanneer elk gevraagd gegeven van de partner leeg is of een standaardwaarde/onbekend waarde heeft die niet geleverd wordt (zie onbekend_waardes.feature).

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
