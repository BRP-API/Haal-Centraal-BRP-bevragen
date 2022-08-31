# language: nl

@post-assert
Functionaliteit: Ouders van een persoon raadplegen
  Van een persoon kunnen ouders worden geleverd.
  Dit bevat gegevens over de familierechtelijke betrekking plus enkele identificerende eigenschappen van de ouder.

@gba
Rule: De ouder in categorie 2 heeft ouderAanduiding "1" en de ouder in categorie 3 heeft ouderAanduiding "2"

  @gba
  Scenario: Persoon heeft twee ouders
    Gegeven de persoon met burgerservicenummer '999993653' heeft een 'ouder' uit categorie '2' met de volgende gegevens
    | voornamen (02.10)  |
    | Lisette            |
    En de persoon heeft een 'ouder' uit categorie '3' met de volgende gegevens
    | voornamen (02.10)  |
    | Guîllaumé          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 999993653                                    |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 1      |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam      | waarde  |
    | voornamen | Lisette |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 2      |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam      | waarde    |
    | voornamen | Guîllaumé |

@gba
Rule: de actuele gegevens van ouders worden geleverd

  @gba
  Scenario: oudergegevens gecorrigeerd
    Gegeven de persoon met burgerservicenummer '999996186' heeft een categorie '2' 'ouder' met de volgende gegevens
    | voornamen (02.10)  |
    | Chantal            |
    En de persoon heeft een categorie '3' 'ouder' met de volgende gegevens
    | voornamen (02.10)  |
    | Christiaan         |
    En de categorie '3' 'ouder' is gecorrigeerd naar de volgende gegevens
    | voornamen (02.10)  |
    | Mark               |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 999996186                                    |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 1      |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam      | waarde  |
    | voornamen | Chantal |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 2      |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam      | waarde    |
    | voornamen | Mark      |

  @gba
  Scenario: geslachtswijziging ouder
    Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende ouders in de registratie
    | Categorie | Voornamen (02.10)  | Geslachtsaanduiding (04.10) |
    | 2         | Noa                | V                           |
    | 3         | Johanna            | V                           |
    | 53        | John               | M                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                       |
    | type                | RaadpleegMetBurgerservicenummer                              |
    | burgerservicenummer | 555550001                                                    |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen,ouders.geslacht |
    Dan heeft de ouder met ouderAanduiding '1' de volgende gegevens
    | naam                  | waarde |
    | ouderAanduiding       | 1      |
    | geslacht.code         | V      |
    | geslacht.omschrijving | vrouw  |
    En heeft de ouder met ouderAanduiding '1' volgende 'naam' gegevens
    | naam      | waarde |
    | voornamen | Noa    |
    En heeft de ouder met ouderAanduiding '2' de volgende gegevens
    | naam                  | waarde |
    | ouderAanduiding       | 2      |
    | geslacht.code         | V      |
    | geslacht.omschrijving | vrouw  |
    En heeft de ouder met ouderAanduiding '2' de volgende 'naam' gegevens
    | naam      | waarde  |
    | voornamen | Johanna |

  @gba
  Scenario: adoptie
    Gegeven de persoon met burgerservicenummer 999996629 heeft de volgende ouders in de registratie
    | Categorie | Voornamen (02.10)  | Datum ingang familierechtelijke betrekking (62.10) | Onjuist (84.10) |
    | 2         | Olivia Ghislaine   | 20190317                                           |                 |
    | 52        | Me'Lisa            | 20170106                                           |                 |
    | 52        |                    | 00000000                                           | O               |
    | 3         | Kevin              | 20190317                                           |                 |
    | 53        |                    |                                                    |                 |
    | 53        |                    | 00000000                                           | O               |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                      |
    | type                | RaadpleegMetBurgerservicenummer                                                             |
    | burgerservicenummer | 999996629                                                                                   |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen,ouders.datumIngangFamilierechtelijkeBetrekking |
    Dan heeft de ouder met ouderAanduiding '1' de volgende gegevens
    | naam                                          | waarde   |
    | ouderAanduiding                               | 1        |
    | datumIngangFamilierechtelijkeBetrekking.datum | 20190317 |
    En heeft de ouder met ouderAanduiding '1' de volgende 'naam' gegevens
    | naam      | waarde           |
    | voornamen | Olivia Ghislaine |
    En heeft de ouder met ouderAanduiding '2' de volgende gegevens
    | naam                                          | waarde   |
    | ouderAanduiding                               | 2        |
    | datumIngangFamilierechtelijkeBetrekking.datum | 20190317 |
    En heeft de ouder met ouderAanduiding '2' de volgende 'naam' gegevens
    | naam      | waarde    |
    | voornamen | Kevin     |

  @gba
  Scenario: ontkenning gevolgd door erkenning
    Gegeven de persoon met burgerservicenummer 999996162 heeft de volgende ouders in de registratie
    | Categorie | Voornamen (02.10)  | Onjuist (84.10) |
    | 2         | Chantal            |                 |
    | 3         | Wieger             |                 |
    | 53        |                    |                 |
    | 53        | Mark               | O               |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 999996162                                    |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen |
    Dan heeft de ouder met ouderAanduiding '1' de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 1      |
    En heeft de ouder met ouderAanduiding '1' de volgende 'naam' gegevens
    | naam      | waarde  |
    | voornamen | Chantal |
    En heeft de ouder met ouderAanduiding '2' de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 2      |
    En heeft de ouder met ouderAanduiding '2' de volgende 'naam' gegevens
    | naam      | waarde    |
    | voornamen | Wieger    |

@gba
Rule: de geleverde oudergegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
  # Bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van de ouder

  @gba
  Scenario: De ouder heeft geslachtswijziging ondergaan, maar de gevraagde persoon erkent dit niet
    Gegeven de persoon met burgerservicenummer 555550003 heeft de volgende ouders in de registratie
    | Categorie | Burgerservicenummer (01.20) | Voornamen | Geslachtsaanduiding (04.10) |
    | 2         | 555550004                   | Karel     | M                           |
    | 3         | 555550005                   | Ellen     | V                           |
    En de ouder met burgerservicenummer 555550004 heeft haar geslacht en voornamen gewijzigd zodat de volgende persoonsgegevens in de registratie op haar persoonslijst staan:
    | Categorie | Voornamen | Geslachtsaanduiding (04.10) |
    | 1         | Charlotte | V                           |
    | 51        | Karel     | M                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                  |
    | type                | RaadpleegMetBurgerservicenummer                                                         |
    | burgerservicenummer | 555550003                                                                               |
    | fields              | ouders.ouderAanduiding,ouders.burgerservicenummer,ouders.geslacht,ouders.naam.voornamen |
    Dan heeft de ouder met ouderAanduiding '1' de volgende gegevens
    | naam                  | waarde    |
    | ouderAanduiding       | 1         |
    | burgerservicenummer   | 555550004 |
    | geslacht.code         | M         |
    | geslacht.omschrijving | man       |
    En heeft de ouder met ouderAanduiding '1' de volgende 'naam' gegevens
    | naam      | waarde |
    | voornamen | Karel  |

@gba
Rule: Wanneer alleen gegevens in groep 81, 82, 83, 84, 85 en/of 86 zijn opgenomen en geen gegevens in groep 1, 2, 3, 4 of 62, dan wordt de ouder niet opgenomen
  Gebruik van de fields parameter heeft geen invloed op het leveren van een ouder

  @gba
  Scenario: vondeling (onbekende ouder met ouderaanduiding "1" en geen ouder met ouderaanduiding "2")
    Gegeven de persoon met burgerservicenummer 999993008 heeft de volgende ouders in de registratie
    | Categorie | Voornamen (02.10)  | Geslachtsnaam | Geboortedatum (03.10) | Geslachtsaanduiding (04.10) | Datum ingang familierechtelijke betrekking (62.10) |
    | 2         |                    | .             |                       | V                           | 20190614                                           |
    | 3         |                    |               |                       |                             |                                                    |
    En in categorie 3 komt alleen groep 81 en groep 85 voor
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999993008                       |
    | fields              | ouders                          |
    Dan bevat de persoon alleen ouders met de volgende gegevens
    | naam                                    | waarde   |
    | ouderAanduiding                         | 1        |
    En heeft de ouder met ouderAanduiding '1' de volgende gegevens
    | naam                                    | waarde   |
    | ouderAanduiding                         | 1        |
    | geslacht.code                           | V        |
    | geslacht.omschrijving                   | vrouw    |
    | datumIngangFamilierechtelijkeBetrekking | 20190614 |
    En de ouder met ouderAanduiding '1' heeft GEEN 'geboorte' gegevens
    En heeft de ouder met ouderAanduiding '1' alleen de volgende 'naam' gegevens
    | naam          | waarde |
    | geslachtsnaam | .      |

  @gba
  Scenario: volledig onbekende ouder
    Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende ouders in de registratie
    | Categorie | Voornamen (02.10)  | Geslachtsnaam | Geboortedatum (03.10) | Geslachtsaanduiding (04.10) | Datum ingang familierechtelijke betrekking (62.10) |
    | 2         |                    | .             |                       |                             | 00000000                                           |
    | 3         |                    |               |                       |                             |                                                    |
    En in categorie 3 komt alleen groep 81 en groep 85 voor
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders                          |
    Dan bevat de persoon alleen ouders met de volgende gegevens
    | naam                                    | waarde   |
    | ouderAanduiding                         | 1        |
    En heeft de ouder met ouderAanduiding '1' de volgende gegevens
    | naam                                    | waarde   |
    | ouderAanduiding                         | 1        |
    | datumIngangFamilierechtelijkeBetrekking | 00000000 |
    En de ouder met ouderAanduiding '1' heeft GEEN 'geslacht' gegevens
    En de ouder met ouderAanduiding '1' heeft GEEN 'geboorte' gegevens
    En heeft de ouder met ouderAanduiding '1' alleen de volgende 'naam' gegevens
    | naam          | waarde |
    | geslachtsnaam | .      |

  @gba
  Scenario: met fields vragen om gegevens zonder waarde
    Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende ouders in de registratie
    | Categorie | Voornamen (02.10)  | Geslachtsnaam | Geboortedatum (03.10) | Geslachtsaanduiding (04.10) | Datum ingang familierechtelijke betrekking (62.10) |
    | 2         |                    | Jansen        |                       | V                           | 20190614                                           |
    | 3         |                    |               |                       |                             |                                                    |
    En in categorie 3 komt alleen groep 81 en groep 85 voor
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                 |
    | type                | RaadpleegMetBurgerservicenummer        |
    | burgerservicenummer | 555550001                              |
    | fields              | ouders.voornamen,ouders.geboorte.datum |
    Dan heeft de persoon met burgerservicenummer '555550001' exact 1 ouders
    En heeft de ouder GEEN gegevens

@proxy
Rule: Wanneer van de ouder wel gegevens geregistreerd zijn, maar geen van de met fields gevraagde gegevens heeft een waarde, dan wordt er een 'ouders' zonder gegevens geleverd

  @proxy
  Scenario: geen gegevens door fields levert een 'ouders' zonder gegevens
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met de volgende gegevens
    | naam                                            | waarde   |
    | ouderAanduiding                                 | 1        |
    | geslachtsaanduiding (04.10)                     | V        |
    | datumIngangFamilierechtelijkeBetrekking (62.10) | 20190614 |
    En de 'ouder' heeft alleen de volgende 'naam' gegevens
    | naam                  | waarde            |
    | geslachtsnaam (02.40) | Ibin binti Yalniz |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                      |
    | type                | RaadpleegMetBurgerservicenummer             |
    | burgerservicenummer | 555550001                                   |
    | fields              | ouders.naam.voornamen,ouders.geboorte.datum |
    Dan heeft de response een persoon met een leeg 'ouder' object
