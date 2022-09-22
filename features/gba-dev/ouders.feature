# language: nl

@post-assert
Functionaliteit: Ouders van een persoon raadplegen
  Van een persoon kunnen ouders worden geleverd.
  Dit bevat gegevens over de familierechtelijke betrekking plus enkele identificerende eigenschappen van de ouder.

@gba
Rule: De ouder in categorie 2 heeft ouderAanduiding "1" en de ouder in categorie 3 heeft ouderAanduiding "2"

  Scenario: Persoon heeft twee ouders
    Gegeven de persoon met burgerservicenummer '000000152' heeft een ouder '1' met de volgende gegevens
    | voornamen (02.10)  |
    | Lisette            |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | voornamen (02.10)  |
    | Guîllaumé          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000152                                    |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde  |
    | ouderAanduiding | 1       |
    | naam.voornamen  | Lisette |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam            | waarde    |
    | ouderAanduiding | 2         |
    | naam.voornamen  | Guîllaumé |

@gba
Rule: de actuele gegevens van ouders worden geleverd

  Scenario: oudergegevens gecorrigeerd
    Gegeven de persoon met burgerservicenummer '000000164' heeft een ouder '1' met de volgende gegevens
    | voornamen (02.10)  |
    | Chantal            |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | voornamen (02.10)  |
    | Christiaan         |
    En de ouder '2' is gecorrigeerd naar de volgende gegevens
    | voornamen (02.10)  |
    | Mark               |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000164                                    |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde  |
    | ouderAanduiding | 1       |
    | naam.voornamen  | Chantal |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 2      |
    | naam.voornamen  | Mark   |

  Scenario: geslachtswijziging ouder
    Gegeven de persoon met burgerservicenummer '000000176' heeft een ouder '1' met de volgende gegevens
    | voornamen (02.10) | geslachtsaanduiding (04.10) |
    | Noa               | V                           |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | voornamen (02.10)  | geslachtsaanduiding (04.10) |
    | John               | M                           |
    En de ouder '2' is gewijzigd naar de volgende gegevens
    | voornamen (02.10)  | geslachtsaanduiding (04.10) |
    | Johanna            | V                           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                       |
    | type                | RaadpleegMetBurgerservicenummer                              |
    | burgerservicenummer | 000000176                                                    |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen,ouders.geslacht |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                  | waarde |
    | ouderAanduiding       | 1      |
    | geslacht.code         | V      |
    | geslacht.omschrijving | vrouw  |
    | naam.voornamen        | Noa    |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam                  | waarde  |
    | ouderAanduiding       | 2       |
    | geslacht.code         | V       |
    | geslacht.omschrijving | vrouw   |
    | naam.voornamen        | Johanna |

  Scenario: adoptie
    Gegeven de persoon met burgerservicenummer '000000188' heeft een ouder '1' met de volgende gegevens
    | voornamen (02.10) | datum ingang familierechtelijke betrekking (62.10) |
    | Me'Lisa           | 20170106                                           |
    En de ouder '1' is gecorrigeerd naar de volgende gegevens
    | voornamen (02.10) | datum ingang familierechtelijke betrekking (62.10) |
    | Olivia Ghislaine  | 20190317                                           |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | datum ingang familierechtelijke betrekking (62.10) |
    | 00000000                                           |
    En de ouder '2' is gecorrigeerd naar de volgende gegevens
    | voornamen (02.10) | datum ingang familierechtelijke betrekking (62.10) |
    | Kevin             | 20190317                                           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                      |
    | type                | RaadpleegMetBurgerservicenummer                                                             |
    | burgerservicenummer | 000000188                                                                                   |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen,ouders.datumIngangFamilierechtelijkeBetrekking |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                                    | waarde           |
    | naam.voornamen                          | Olivia Ghislaine |
    | ouderAanduiding                         | 1                |
    | datumIngangFamilierechtelijkeBetrekking | 20190317         |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam                                    | waarde   |
    | naam.voornamen                          | Kevin    |
    | ouderAanduiding                         | 2        |
    | datumIngangFamilierechtelijkeBetrekking | 20190317 |

  Scenario: ontkenning gevolgd door erkenning
    Gegeven de persoon met burgerservicenummer '000000206' heeft een ouder '1' met de volgende gegevens
    | voornamen (02.10) | 
    | Chantal           | 
    En de persoon heeft een ouder '2' met de volgende gegevens
    | voornamen (02.10)  |
    | Mark               |
    En de ouder '2' is gecorrigeerd naar de volgende gegevens
    | voornamen (02.10)  | 
    |                    | 
    En de ouder '2' is gecorrigeerd naar de volgende gegevens
    | voornamen (02.10)  | 
    | Wieger             | 
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000206                                    |
    | fields              | ouders.ouderAanduiding,ouders.naam.voornamen |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam            | waarde  |
    | naam.voornamen  | Chantal |
    | ouderAanduiding | 1       |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam            | waarde |
    | naam.voornamen  | Wieger |
    | ouderAanduiding | 2      |

@gba
Rule: de geleverde oudergegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
  # Bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van de ouder

  Scenario: De ouder heeft geslachtswijziging ondergaan, maar de gevraagde persoon erkent dit niet
    Gegeven de persoon met burgerservicenummer '000000218' heeft een ouder '1' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsaanduiding (04.10) |
    | 000007896                   | Ellen             | V                           |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsaanduiding (04.10) |
    | 000007897                   | Karel             | M                           |
    En de ouder '2' is gecorrigeerd naar de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsaanduiding (04.10) |
    | 000007897                   | Charlotte         | V                           |
    En de ouder '2' is gecorrigeerd naar de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsaanduiding (04.10) |
    | 000007897                   | Karel             | M                           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                  |
    | type                | RaadpleegMetBurgerservicenummer                                                         |
    | burgerservicenummer | 000000218                                                                               |
    | fields              | ouders.ouderAanduiding,ouders.burgerservicenummer,ouders.geslacht,ouders.naam.voornamen |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 000007896 |
    | geslacht.code         | V         |
    | geslacht.omschrijving | vrouw     |
    | naam.voornamen        | Ellen     |
    | ouderAanduiding       | 1         |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 000007897 |
    | geslacht.code         | M         |
    | geslacht.omschrijving | man       |
    | naam.voornamen        | Karel     |
    | ouderAanduiding       | 2         |

@gba
Rule: Wanneer alleen gegevens in groep 81, 82, 83, 84, 85 en/of 86 zijn opgenomen en geen gegevens in groep 1, 2, 3, 4 of 62, dan wordt de ouder niet opgenomen
  Gebruik van de fields parameter heeft geen invloed op het leveren van een ouder

  Scenario: vondeling (onbekende ouder met ouderaanduiding "1" en geen ouder met ouderaanduiding "2")
    Gegeven de persoon met burgerservicenummer '000000231' heeft een ouder '1' met de volgende gegevens
    | datum ingang familierechtelijke betrekking (62.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
    | 20190614                                           | .                     | V                           |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | aktenummer (81.20) | ingangsdatum geldigheid (85.10) |
    | 2•E0001            | 20160518                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000231                       |
    | fields              | ouders                          |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                                    | waarde   |
    | ouderAanduiding                         | 1        |
    | naam.geslachtsnaam                      | .        |
    | geslacht.code                           | V        |
    | geslacht.omschrijving                   | vrouw    |
    | datumIngangFamilierechtelijkeBetrekking | 20190614 |

  Scenario: volledig onbekende ouder
    Gegeven de persoon met burgerservicenummer '000000243' heeft een ouder '1' met de volgende gegevens
    | geslachtsnaam (02.40) | datum ingang familierechtelijke betrekking (62.10) |
    | .                     | 00000000                                           |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | aktenummer (81.20) | ingangsdatum geldigheid (85.10) |
    | 2•E0001            | 20160518                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000243                       |
    | fields              | ouders                          |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                                    | waarde   |
    | ouderAanduiding                         | 1        |
    | naam.geslachtsnaam                      | .        |
    | datumIngangFamilierechtelijkeBetrekking | 00000000 |

  Scenario: met fields vragen om gegevens zonder waarde
    Gegeven de persoon met burgerservicenummer '000000255' heeft een ouder '1' met de volgende gegevens
    | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
    | Jansen                | V                           | 20190614                                           |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | aktenummer (81.20) | ingangsdatum geldigheid (85.10) |
    | 2•E0001            | 20160518                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                      |
    | type                | RaadpleegMetBurgerservicenummer             |
    | burgerservicenummer | 000000255                                   |
    | fields              | ouders.naam.voornamen,ouders.geboorte.datum |
    Dan heeft de response een persoon met een 'ouder' zonder gegevens
