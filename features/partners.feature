# language: nl

Functionaliteit: Huwelijken en geregistreerd partnerschappen van een persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- het (de) huwelijk(en) of geregistreerd partnerschap(pen) geleverd.
  Dit bevat de gegevens over de relatie (huwelijk of partnerschap) plus enkele identificerende eigenschappen van de persoon waarmee het huwelijk of partnerschap is aangegaan.

  Rule: Alleen een actueel huwelijk of geregistreerd partnerschap wordt teruggegeven.
    Een huwelijk of partnerschap is actueel wanneer het niet is ontbonden: groep 07 Ontbinding huwelijk/geregistreerd partnerschap komt niet voor (heeft geen waarde)

    Scenario: Actueel huwelijk
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990184 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde |
      | voornamen (02.10) | Merel  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 20010215 |
      | soort verbintenis (15.10) | H        |
      En de partner heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990184                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999990184' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992935           |
      En heeft de partner met burgerservicenummer '999992935' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Merel  |

    Scenario: Actueel partnerschap
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993380 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde   |
      | voornamen (02.10) | Reindert |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 20040506 |
      | soort verbintenis (15.10) | P        |
      En de partner heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993380                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999993380' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992935           |
      En heeft de partner met burgerservicenummer '999992935' de volgende 'naam' gegevens
      | naam      | waarde   |
      | voornamen | Reindert |

    Scenario: Huwelijk/partnerschap is ontbonden
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992806 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde |
      | aanduiding naamgebruik (61.10) | E      |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde |
      | voornamen (02.10) | Osama  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 20000115 |
      En de partner heeft de volgende ontbindingHuwelijkPartnerschap gegevens
      | naam                     | waarde   |
      | datum ontbinding (07.10) | 20011109 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993380                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999993380' GEEN 'partners'

    Scenario: Een actueel huwelijk en een ontbonden huwelijk
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999991553 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde |
      | voornamen (02.10) | Karel  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 20091102 |
      En de partner heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992936 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde |
      | voornamen (02.10) | Björn  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 19870714 |
      | indicatie onjuist (84.10) |          |
      En de partner heeft de volgende ontbindingHuwelijkPartnerschap gegevens
      | naam                     | waarde   |
      | datum ontbinding (07.10) | 20080706 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999991553                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999991553' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992935           |
      En heeft de partner met burgerservicenummer '999992935' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |

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
    Scenario: Partner is volledig onbekend
      Gegeven de persoon met burgerservicenummer 999993008 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Voornamen (02.10) | Geslachtsnaam (02.40) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | Onjuist (84.10) | Registergemeente akte (81.10) | Aktenummer (81.20) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
        | 5         |                   | .                     | 00000000              | .                         |                          |                          |                 | 0518                          | 5XC1111            | 20050818                        | 20050818                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993380                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '999993380' exact 1 'partners'

  Rule: de geleverde partnergegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
    Bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van de partner

    @gba
    Scenario: De partner heeft geslachtswijziging ondergaan, maar de gevraagde persoon erkent dit niet
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Burgerservicenummer (01.20) | Voornamen | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) |
        | 5         | 555550002                   | Karel     | M                           | 20091102              |                          |
      En de partner met burgerservicenummer 555550002 heeft haar geslachtsaanduiding en voornamen gewijzigd zodat de volgende persoonsgegevens in de registratie op haar persoonslijst staan:
        | Categorie | Voornamen | Geslachtsaanduiding (04.10) |
        | 1         | Charlotte | V                           |
        | 51        | Karel     | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | partners                        |
      Dan heeft de persoon met burgerservicenummer '555550001' exact 1 'partners'
      En heeft de persoon met burgerservicenummer '555550001' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 555550002           |
      En heeft de partner met burgerservicenummer '555550001' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |

  Rule: wanneer een samengestelde naam wordt gevraagd waarin de geslachtsnaam van de partner wordt gebruikt, dan wordt de partner geleverd, ook wanneer daar niet om gevraagd is met fields
    Wanneer in fields NIET is gevraagd om 'partners' wordt toch de partner geleverd in GbaPersoon wanneer aan alle volgende condities is voldaan:
      - naam.aanschrijfwijze, naam.aanhef of naam.gebruikinlopendetekst is gevraagd in fields
      - de naam van de partner wordt gebruikt: naam.aanduidingNaamgebruik ongelijk is aan 'E'
    
    Van een partner waar niet in fields om wordt gevraagd worden de volgende gegevens geleverd:
      - naam.adellijkeTitelPredikaat
      - naam.voorvoegsel
      - naam.geslachtsnaam
      - geslachtsaanduiding
      - ontbindingHuwelijkPartnerschap.datum

    # RvIG levert personen in de vorm GbaPersoon, waarin alleen onbewerkte GBA-V gegevens worden geleverd
    # Een proxy vertaalt dit naar de vorm Persoon, waarin sommige gegevens in bewerkte vorm worden opgenomen en waarin informatievragen kunnen zitten
    # Een voorbeeld van een informatievraag is naam.aanschrijfwijze, waarin op basis van de aanduiding naamgebruik, de naam van de persoon en de naam van de partner een aanschrijfnaam wordt samengesteld
    # Wanneer een persoon de naam van de ex-partner of overleden partner nog gebruikt, wordt in de GbaPersoon ook de ex-partner aan de proxy geleverd.

    @gba
    Abstract Scenario: Leveren actuele partner bij <naamgebruik> en <fields>
      Gegeven de persoon met burgerservicenummer 999992930 heeft de volgende persoonsgegevens in de registratie
      | Categorie | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40)  | Aanduiding naamgebruik (61.10) |
      | 1         | Rie               |                                      | de                  | Wit                    | <naamgebruik>                  |
      En de persoon met burgerservicenummer 999992930 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) |
      | 5         | 999992931                   | Jan               | JH                                   | van                 | Aedel                 | M                           | 20090314              | H                         |                          |                          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992930                       |
      | fields              | naam                            |
      Dan heeft de persoon met burgerservicenummer '999992930' exact 1 'partners'
      En heeft de partner de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner alleen de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | adellijkeTitelPredikaat.code         | JH        |
      | adellijkeTitelPredikaat.omschrijving | Jonkheer  |
      | adellijkeTitelPredikaat.soort        | predikaat |
      | voorvoegsel                          | van       |
      | geslachtsnaam                        | Aedel     |
      En heeft de partner geen andere gegevens dan 'naam' en 'geslachtsaanduiding'

      Voorbeelden:
      | naamgebruik | fields                        |
      | P           | naam.aanschrijfwijze          |
      | V           | naam.aanschrijfwijze          |
      | N           | naam.aanschrijfwijze          |
      | P           | naam.aanhef                   |
      | P           | naam.gebruikInLopendeTekst    |
      | P           | naam.geslachtsnaam            |
      | P           | naam.aanschrijfwijze.naam     |
      | P           | naam                          |
      | P           | leeftijd,naam.aanschrijfwijze |
      | P           | naam.aanschrijfwijze,partners |

    @gba
    Abstract Scenario: Niet leveren huwelijk/partnerschap bij <naamgebruik> en <fields>
      Gegeven de persoon met burgerservicenummer 999992932 heeft de volgende persoonsgegevens in de registratie
      | Categorie | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40)  | Aanduiding naamgebruik (61.10) |
      | 1         | Rie               |                                      | de                  | Wit                    | <naamgebruik>                  |
      En de persoon met burgerservicenummer 999992932 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | 
      | 5         | 999992933                   | Jan               | JH                                   | van                 | Aedel                 | M                           | 20090314              | H                         |                          |                          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992932                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '999992932' GEEN 'partners'

      Voorbeelden:
      | naamgebruik | fields                        |
      | E           | naam.aanschrijfwijze          |
      | E           | partners,naam.aanschrijfwijze |
      | P           | naam.geslachtsnaam            |
      | P           | naam.voorletters              |
      | P           | naam.aanduidingNaamgebruik    |
      | P           | leeftijd                      |

    @gba
    Scenario: Vragen om ander partnergegeven
      Gegeven de persoon met burgerservicenummer 999992934 heeft de volgende persoonsgegevens in de registratie
      | Categorie | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40)  | Aanduiding naamgebruik (61.10) |
      | 1         | Rie               |                                      | de                  | Wit                    | P                              |
      En de persoon met burgerservicenummer 999992934 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) |
      | 5         | 999992935                   | Jan               | JH                                   | van                 | Aedel                 | M                           | 20090314              | H                         |                          |                          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetBurgerservicenummer                 |
      | burgerservicenummer | 999992934                                       |
      | fields              | naam,partners.aangaanHuwelijkPartnerschap.datum |
      Dan heeft de persoon met burgerservicenummer '999992934' exact 1 'partners'
      En heeft de partner de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner alleen de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | adellijkeTitelPredikaat.code         | JH        |
      | adellijkeTitelPredikaat.omschrijving | Jonkheer  |
      | adellijkeTitelPredikaat.soort        | predikaat |
      | voorvoegsel                          | van       |
      | geslachtsnaam                        | Aedel     |
      En heeft de partner de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                 | waarde    |
      | datum.datum                          | 20090314  |
      En heeft de partner geen andere gegevens dan 'naam' en 'geslachtsaanduiding' en 'aangaanHuwelijkPartnerschap'

  Rule: Wanneer er geen actueel huwelijk of geregistreerd partnerschap is en er is een samengestelde naam gevraagd waarin de geslachtsnaam van de partner wordt gebruikt, dan wordt de laatst ontbonden partner geleverd
    Een ontbonden huwelijk of partnerschap wordt geleverd in GbaPersoon wanneer aan alle volgende condities is voldaan:
      - naam.aanschrijfwijze, naam.aanhef of naam.gebruikinlopendetekst is gevraagd in fields
      - de naam van de partner wordt gebruikt: naam.aanduidingNaamgebruik ongelijk is aan 'E'
    
    Van een ontbonden partner worden de volgende gegevens geleverd:
      - naam.adellijkeTitelPredikaat
      - naam.voorvoegsel
      - naam.geslachtsnaam
      - geslachtsaanduiding
      - ontbindingHuwelijkPartnerschap.datum

    @gba
    Abstract Scenario: Leveren ontbonden huwelijk/partnerschap bij <naamgebruik> en <fields>
      Gegeven de persoon met burgerservicenummer 999992934 heeft de volgende persoonsgegevens in de registratie
      | Categorie | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40)  | Aanduiding naamgebruik (61.10) |
      | 1         | Rie               |                                      | de                  | Wit                    | <naamgebruik>                  |
      En de persoon met burgerservicenummer 999992934 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | 
      | 5         |                             |                   |                                      |                     |                       |                             |                       |                           | 20171103                 | O                        | 
      | 55        | 999992935                   | Jan               | JH                                   | van                 | Aedel                 | M                           | 20090314              | H                         |                          |                          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '999992934' exact 1 'partners'
      En heeft de partner de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner alleen de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | adellijkeTitelPredikaat.code         | JH        |
      | adellijkeTitelPredikaat.omschrijving | Jonkheer  |
      | adellijkeTitelPredikaat.soort        | predikaat |
      | voorvoegsel                          | van       |
      | geslachtsnaam                        | Aedel     |
      En heeft de partner de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                 | waarde    |
      | datum.datum                          | 20171103  |
      En heeft de partner geen andere gegevens dan 'naam' en 'geslachtsaanduiding' en 'ontbindingHuwelijkPartnerschap'

      Voorbeelden:
      | naamgebruik | fields                        |
      | P           | naam.aanschrijfwijze          |
      | V           | naam.aanschrijfwijze          |
      | N           | naam.aanschrijfwijze          |
      | P           | naam.aanhef                   |
      | P           | naam.gebruikInLopendeTekst    |
      | P           | naam.geslachtsnaam            |
      | P           | naam.aanschrijfwijze.naam     |
      | P           | naam                          |
      | P           | leeftijd,naam.aanschrijfwijze |
      | P           | naam.aanschrijfwijze,partners |

    @gba
    Abstract Scenario: Niet leveren ontbonden huwelijk/partnerschap bij <naamgebruik> en <fields>
      Gegeven de persoon met burgerservicenummer 999992934 heeft de volgende persoonsgegevens in de registratie
      | Categorie | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40)  | Aanduiding naamgebruik (61.10) |
      | 1         | Rie               |                                      | de                  | Wit                    | <naamgebruik>                  |
      En de persoon met burgerservicenummer 999992934 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | 
      | 5         |                             |                   |                                      |                     |                       |                             |                       |                           | 20171103                 | O                        | 
      | 55        | 999992935                   | Jan               | JH                                   | van                 | Aedel                 | M                           | 20090314              | H                         |                          |                          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '999993380' GEEN 'partners'

      Voorbeelden:
      | naamgebruik | fields                        |
      | E           | naam.aanschrijfwijze          |
      | E           | partners,naam.aanschrijfwijze |
      | P           | naam.geslachtsnaam            |
      | P           | naam.voorletters              |
      | P           | naam.aanduidingNaamgebruik    |
      | P           | partners                      |
      | P           | partners.naam                 |
      | P           | leeftijd                      |

    @gba
    Scenario: Persoon met meerdere ontbonden partners
      Gegeven de persoon met burgerservicenummer 999992936 heeft de volgende persoonsgegevens in de registratie
      | Categorie | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40)  | Aanduiding naamgebruik (61.10) |
      | 1         | Rie               |                                      | de                  | Wit                    | P                              |
      En de persoon met burgerservicenummer 999992936 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) |
      | 5         |                             |                   |                                      |                     |                       |                             |                       |                           | 20190116                 | S                        | 
      | 55        | 999992938                   | Cees              |                                      | de                  | Vries                 | M                           | 20180622              | H                         |                          |                          |
      | 5         |                             |                   |                                      |                     |                       |                             |                       |                           | 20171103                 | O                        | 
      | 55        | 999992937                   | Jan               | JH                                   | van                 | Aedel                 | M                           | 20090314              | H                         |                          |                          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992936                       |
      | fields              | naam                            |
      Dan heeft de persoon met burgerservicenummer '999992934' exact 1 'partners'
      En heeft de partner de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner alleen de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | voorvoegsel                          | de        |
      | geslachtsnaam                        | Vries     |
      En heeft de partner alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                 | waarde    |
      | datum.datum                          | 20190116  |
      En heeft de partner geen andere gegevens dan 'naam' en 'geslachtsaanduiding' en 'ontbindingHuwelijkPartnerschap'

    @gba
    Scenario: Persoon met actuele en meerdere ontbonden partners
      Gegeven de persoon met burgerservicenummer 999992939 heeft de volgende persoonsgegevens in de registratie
      | Categorie | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40)  | Aanduiding naamgebruik (61.10) |
      | 1         | Rie               |                                      | de                  | Wit                    | P                              |
      En de persoon met burgerservicenummer 999992934 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | adellijke titel of predikaat (02.20) | voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) |
      | 55        | 999992942                   | Wim               |                                      |                     | Zwart                 | M                           | 20190828              | P                         |                          |                          |
      | 5         |                             |                   |                                      |                     |                       |                             |                       |                           | 20190116                 | S                        | 
      | 55        | 999992941                   | Cees              |                                      | de                  | Vries                 | M                           | 20180622              | H                         |                          |                          |
      | 5         |                             |                   |                                      |                     |                       |                             |                       |                           | 20171103                 | O                        | 
      | 55        | 999992940                   | Jan               | JH                                   | van                 | Aedel                 | M                           | 20090314              | H                         |                          |                          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam                            |
      Dan heeft de persoon met burgerservicenummer '999992939' exact 1 'partners'
      En heeft de partner de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En heeft de partner alleen de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | geslachtsnaam                        | Zwart     |
      En heeft de partner geen andere gegevens dan 'naam' en 'geslachtsaanduiding'

  Rule: Partnergegevens die zijn toegevoegd ten behoeve van het samenstellen van een naam worden verwijderd uit het antwoord
    Een partner in GbaPersoon met een waarde in ontbindingHuwelijkPartnerschap.datum wordt niet opgenomen in Persoon
    Partnergegevens in GbaPersoon waar niet om gevraagd is met fields worden niet opgenomen in Persoon

    @proxy
    Scenario: Niet leveren van ontbonden partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992806 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde |
      | aanduiding naamgebruik (61.10) | P      |
      En de persoon heeft exact 1 'partners'
      En heeft de partner de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde    |
      | voorvoegsel                          | de        |
      | geslachtsnaam                        | Vries     |
      En de partner heeft de volgende ontbindingHuwelijkPartnerschap gegevens
      | naam                                 | waarde    |
      | datum.datum                          | 20190116  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992806                       |
      | fields              | naam,partners                   |
      Dan heeft de persoon met burgerservicenummer '999992806' GEEN 'partners'

    @proxy
    Scenario: Niet leveren van partner waar niet om gevraagd is met fields
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992807 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde |
      | aanduiding naamgebruik (61.10) | P      |
      En de persoon heeft exact 1 'partners'
      En heeft de partner de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde    |
      | voorvoegsel                          | de        |
      | geslachtsnaam                        | Vries     |
      En de partner heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992807                       |
      | fields              | naam                            |
      Dan heeft de persoon met burgerservicenummer '999992807' GEEN 'partners'

    @proxy
    Scenario: Niet leveren van partnergegevens waar niet om gevraagd is met fields
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992807 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde |
      | aanduiding naamgebruik (61.10) | P      |
      En de persoon heeft exact 1 'partners'
      En heeft de partner de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992808 |
      En heeft de partner de volgende 'geslachtsaanduiding' gegevens
      | naam         | waarde |
      | code         | M      |
      | omschrijving | man    |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde    |
      | voornamen                            | Cees      |
      | voorvoegsel                          | de        |
      | geslachtsnaam                        | Vries     |
      En de partner heeft GEEN ontbindingHuwelijkPartnerschap gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                    |
      | type                | RaadpleegMetBurgerservicenummer                           |
      | burgerservicenummer | 999992807                                                 |
      | fields              | naam,partners.naam.voornamen,partners.burgerservicenummer |
      En heeft de persoon met burgerservicenummer '999992807' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992808           |
      En heeft de partner met burgerservicenummer '999992807' alleen de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | voornamen                            | Cees      |
      En heeft de partner geen andere gegevens dan 'naam' en 'burgerservicenummer'

  TODO: bepalen OnbekendPartner
    @proxy
    Scenario: Partner is volledig onbekend

    @proxy
    Scenario: Met fields zijn alleen velden zonder waarde gevraagd

