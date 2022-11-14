# language: nl

Functionaliteit: in onderzoek
  Wanneer de juistheid van een gegeven onderzocht wordt, en daardoor de waarde van een geleverd gegeven mogelijk onjuist is, wordt naast het betreffende veld ook in inOnderzoek een veld met dezelfde naam opgenomen. Deze krijgt dan de boolean waarde true.

  Een categorie kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele groepen of elementen binnen de categorie in onderzoek zijn.

  Een veld dat niet in onderzoek is, wordt niet in inOnderzoek opgenomen, ook niet met de waarde false of null.

  Een overzicht van de vertaling van een inOnderzoek elementwaarde (gegeven 83.10) naar welke velden in inOnderzoek moeten worden opgenomen (met de waarde true) staat in /features/in onderzoek.xlsx.

  Ook wanneer een gegeven geen waarde heeft en daardoor niet in het antwoord opgenomen wordt kan het in onderzoek zijn. In dat geval wordt alleen in inOnderzoek een veld opgenomen met die naam en de waarde true.

  Rule: wanneer een gegeven uit een categorie gevraagd is en er zit onderzoek op die categorie, dan wordt ook inOnderzoek voor dat veld geleverd
    - het gaat om groep 83 in de categorie
    - deze wordt ook geleverd wanneer het gevraagde gegeven geen waarde heeft en daarom niet geleverd is in het antwoord

    Scenario: vragen om naam bij hele categorie persoon in onderzoek
      Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | Arnitta           | 19231213              | 010000                          | 20120920                       |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Noa               | V                           |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Jan               | M                           |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsaanduiding (04.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000103                   | Karel             | M                           | 20091102                                                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000097                       |
      | fields              | ouders,partners,naam            |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde            |
      | voornamen                                    | Arnitta           |
      | voorletters                                  | A.                |
      | volledigeNaam                                | Arnitta           |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum             |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2012-09-20        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 20 september 2012 |
      | inOnderzoek.voornamen                        | true              |
      | inOnderzoek.adellijkeTitelPredicaat          | true              |
      | inOnderzoek.voorvoegsel                      | true              |
      | inOnderzoek.geslachtsnaam                    | true              |
      | inOnderzoek.voorletters                      | true              |
      | inOnderzoek.aanduidingNaamgebruik            | true              |
      | inOnderzoek.volledigeNaam                    | true              |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam                              | waarde |
      | naam.voornamen                    | Noa    |
      | naam.voorletters                  | N.     |
      | geslacht.code                     | V      |
      | geslacht.omschrijving             | vrouw  |
      | ouderAanduiding                   | 1      |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam                              | waarde |
      | naam.voornamen                    | Jan    |
      | naam.voorletters                  | J.     |  
      | geslacht.code                     | M      |  
      | geslacht.omschrijving             | man    |
      | ouderAanduiding                   | 2      |
      En heeft de persoon een 'partner' met de volgende gegevens
      | naam                                          | waarde          |
      | burgerservicenummer                           | 000000103       |
      | naam.voornamen                                | Karel           |
      | naam.voorletters                              | K.              |
      | geslacht.code                                 | M               |
      | geslacht.omschrijving                         | man             |
      | aangaanHuwelijkPartnerschap.datum.type        | Datum           |
      | aangaanHuwelijkPartnerschap.datum.datum       | 2009-11-02      |
      | aangaanHuwelijkPartnerschap.datum.langFormaat | 2 november 2009 |

    Scenario: vragen om naam bij geboortedatum in onderzoek
      Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | Arnitta           | 19231213              | 010310                          | 20120920                       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000097                       |
      | fields              | naam            |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                      | waarde  |
      | voornamen                 | Arnitta |
      | voorletters               | A.      |
      | volledigeNaam             | Arnitta |

    Scenario: vragen om voorvoegsel zonder waarde bij groep naam in onderzoek
      Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | Arnitta           | 19231213              | 010200                          | 20120920                       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                           |
      | type                | RaadpleegMetBurgerservicenummer  |
      | burgerservicenummer | 000000115                        |
      | fields              | naam.voorvoegsel                 |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                | waarde  |
      | inOnderzoek.voorvoegsel             | true    |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum             |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2012-09-20        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 20 september 2012 |

    Scenario: persoon heeft gezagInOnderzoek en persoonInOnderzoek
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | Arnitta           | 19231213              | 010410                          | 20120920                       |
      En de persoon heeft de volgende 'gezagsverhouding' gegevens
      | indicatie curateleregister (33.10) |aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1                                  | 113310                         | 20101205                       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000139                          |
      | fields              | geslacht,indicatieCurateleRegister |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                | waarde            |
      | indicatieCurateleRegister                           | true              |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum             |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2012-09-20        |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 20 september 2012 |
      | inOnderzoek.geslacht                                | true              |
      | inOnderzoek.datumIngangOnderzoekGezag.type          | Datum             |
      | inOnderzoek.datumIngangOnderzoekGezag.datum         | 2010-12-05        |
      | inOnderzoek.datumIngangOnderzoekGezag.langFormaat   | 5 december 2010   |
      | inOnderzoek.indicatieCurateleRegister               | true              |

    Scenario: persoon in onderzoek maar niet vragen om gegevens uit categorie persoon
      Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | Arnitta           | 19231213              | 010000                          | 20120920                       |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Noa               | V                           |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Jan               | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000140                       |
      | fields              | ouders                          |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                  | waarde |
      | naam.voornamen        | Noa    |
      | naam.voorletters      | N.     |
      | geslacht.code         | V      |
      | geslacht.omschrijving | vrouw  |
      | ouderAanduiding       | 1      |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam                  | waarde |
      | naam.voornamen        | Jan    |
      | naam.voorletters      | J.     |
      | geslacht.code         | M      |
      | geslacht.omschrijving | man    |
      | ouderAanduiding       | 2      |

  Rule: in onderzoek wordt niet opgenomen wanneer het onderzoek beëindigd is
    - Datum einde onderzoek (83.30) heeft een waarde

    Scenario: onderzoek is beëindigd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | 
      | Arnitta           | 19231213              | 010000                          | 20120920                       | 20120922                      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                            |
      | type                | RaadpleegMetBurgerservicenummer                   |
      | burgerservicenummer | 000000152                                         |
      | fields              | burgerservicenummer,naam.voornamen,geboorte.datum |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                       | waarde           |
      | burgerservicenummer        | 000000152        |
      | naam.voornamen             | Arnitta          |
      | geboorte.datum.type        | Datum            |
      | geboorte.datum.datum       | 1923-12-13       |
      | geboorte.datum.langFormaat | 13 december 1923 |

  Rule: in onderzoek wordt niet opgenomen wanneer het gegeven of de groep die onderzocht wordt niet wordt gevraagd
    Dit is het geval wanneer gegevens in onderzoek zijn die:
    - niet in de resource voorkomen
    - niet gevraagd zijn met fields

    Scenario: persoon heeft EU-persoonsnummer van nationaliteit in onderzoek die niet voorkomt in de resource
      Gegeven de persoon met burgerservicenummer '000000267' heeft een 'nationaliteit' met de volgende gegevens
      | naam                            | waarde   |
      | nationaliteit (05.10)           | 0001     |
      | aanduiding in onderzoek (83.10) | 047310   |
      | datum ingang onderzoek (83.20)  | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000267                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                       | waarde        |
      | burgerservicenummer                        | 000000267     |
      En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
      | naam                       | waarde        |
      | type                       | Nationaliteit |
      | nationaliteit.code         | 0001          |
      | nationaliteit.omschrijving | Nederlandse   |

    Scenario: persoon heeft hele categorie persoon in onderzoek dat niet is gevraagd met fields
      Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende gegevens
      | naam                            | waarde   |
      | aanduiding in onderzoek (83.10) | 010000   | 
      | datum ingang onderzoek (83.20)  | 20220307 |
      En de persoon heeft een 'kind' met de volgende gegevens
      | naam                            | waarde          |
      | voornamen (02.10)               | Daan            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000279                       |
      | fields              | kinderen                        |
      Dan heeft de response een persoon met een 'kind' met de volgende gegevens
      | naam             | waarde |
      | naam.voornamen   | Daan   |
      | naam.voorletters | D.     |

    Scenario: persoon heeft hele groep naam in onderzoek dat niet is gevraagd met fields
      Gegeven de persoon met burgerservicenummer '000000280' heeft de volgende gegevens
      | naam                            | waarde   |
      | aanduiding in onderzoek (83.10) | 010200   | 
      | datum ingang onderzoek (83.20)  | 20220307 |
      | geslachtsaanduiding (04.10)     | M        |
      | geboortedatum (03.10)           | 20010928 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000280                       |
      | fields              | geslacht,geboorte.datum         |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                       | waarde            |
      | geslacht.code              | M                 |
      | geslacht.omschrijving      | man               |
      | geboorte.datum.type        | Datum             |
      | geboorte.datum.langFormaat | 28 september 2001 |
      | geboorte.datum.datum       | 2001-09-28        |

    Scenario: persoon heeft voornamen in onderzoek dat niet is gevraagd met fields
      Gegeven de persoon met burgerservicenummer '000000292' heeft de volgende gegevens
      | naam                            | waarde     |
      | aanduiding in onderzoek (83.10) | 010210     | 
      | datum ingang onderzoek (83.20)  | 20220307   |
      | geslachtsnaam (02.40)           | Zonderling |
      | geboortedatum (03.10)           | 20010928   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000292                       |
      | fields              | geboorte,naam.geslachtsnaam     |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                       | waarde            |
      | naam.geslachtsnaam         | Zonderling        |
      | geboorte.datum.type        | Datum             |
      | geboorte.datum.langFormaat | 28 september 2001 |
      | geboorte.datum.datum       | 2001-09-28        |

  Rule: wanneer een element in de bron in onderzoek is, wordt het gegeven in het antwoord dat daaruit gevuld wordt ook in inOnderzoek opgenomen met de waarde true

    Abstract Scenario: persoon heeft <in onderzoek> in onderzoek
      Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20220307                  |
      | geslachtsaanduiding (04.10)     | M                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000309                       |
      | fields              | <veld>                          |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                | waarde       |
      | <veld>                                              | <waarde>     |
      | inOnderzoek.<in onderzoek>                          | true         |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | aanduiding in onderzoek | in onderzoek        | veld                | waarde     |
      | 010120                  | burgerservicenummer | burgerservicenummer | 000000309  |
      | 010410                  | geslacht            | geslacht.code       | M          |

    Abstract Scenario: persoon heeft <groep> <in onderzoek> in onderzoek
      Gegeven de persoon met burgerservicenummer '000000310' heeft de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20220307                  |
      | <naam>                          | <bronwaarde>              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000310                       |
      | fields              | <groep>.<veld>                  |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                 | waarde        |
      | <groep>.<veld>                                       | <waarde>      |
      | <groep>.datum.type                                   | <type>        |
      | <groep>.datum.langFormaat                            | <langFormaat> |
      | <groep>.inOnderzoek.<in onderzoek>                   | true          |
      | <groep>.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07    |
      | <groep>.inOnderzoek.datumIngangOnderzoek.type        | Datum         |
      | <groep>.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022  |

      Voorbeelden:
      | aanduiding in onderzoek | in onderzoek            | veld                         | groep    | waarde     | naam                                 | bronwaarde | type  | langFormaat       |
      | 010220                  | adellijkeTitelPredicaat | adellijkeTitelPredicaat.code | naam     | H          | adellijke titel of predicaat (02.20) | H          |       |                   |
      | 016110                  | aanduidingNaamgebruik   | aanduidingNaamgebruik.code   | naam     | E          | aanduiding naamgebruik (61.10)       | E          |       |                   |
      | 010310                  | datum                   | datum.datum                  | geboorte | 2001-09-28 | geboortedatum (03.10)                | 20010928   | Datum | 28 september 2001 |

    Abstract Scenario: persoon heeft <veld> van verblijfadres in onderzoek
      Gegeven de persoon met burgerservicenummer '000000322' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                    |
      | functieAdres.code (10.10)              | W                         |
      | aanduiding in onderzoek (83.10)        | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)         | 20220307                  |
      | gemeente van inschrijving (09.10)      | 0599                      |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde   |
      | <column naam>        | <waarde> |
      | gemeentecode (92.10) | 599      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000322                           |
      | fields              | verblijfplaats.verblijfadres.<veld> |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                                      | waarde       |
      | verblijfplaats.type                                                       | <Type>       |
      | verblijfplaats.verblijfadres.<veld>                                       | <waarde>     |
      | verblijfplaats.verblijfadres.inOnderzoek.<veld>                           | true         |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | aanduiding in onderzoek | veld                 | waarde               | column naam                  | Type    |
      | 081120                  | huisnummer           | 22                   | huisnummer (11.20)           | Adres   |
      | 081130                  | huisletter           | a                    | huisletter (11.30)           | Adres   |
      | 081140                  | huisnummertoevoeging | bis                  | huisnummertoevoeging (11.40) | Adres   |
      | 081160                  | postcode             | 1234AB               | postcode (11.60)             | Adres   |
      | 081170                  | woonplaats           | 0599                 | woonplaats (11.70)           | Adres   |
      | 081210                  | locatiebeschrijving  | In de grootste sloot | locatiebeschrijving (12.10)  | Locatie |
	  
    Scenario: persoon heeft adresregel3 van verblijfplaats in onderzoek
      Gegeven de persoon met burgerservicenummer '000000322' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                         |
      | regel 3 adres buitenland (13.50)       | Entrance 2, 4th floor, Apt. 22 |
      | aanduiding in onderzoek (83.10)        | 081350                         |
      | datum ingang onderzoek (83.20)         | 20220307                       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000322                           |
      | fields              | verblijfplaats.verblijfadres.regel3 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                                      | waarde                         |
      | verblijfplaats.type                                                       | VerblijfplaatsBuitenland       |
      | verblijfplaats.verblijfadres.regel3                                       | Entrance 2, 4th floor, Apt. 22 |
      | verblijfplaats.verblijfadres.inOnderzoek.regel3                           | true                           |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07                     |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                          |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022                   |

    Scenario: persoon heeft aanduiding van verblijfstitel in onderzoek
      Gegeven de persoon met burgerservicenummer '000000322' heeft de volgende 'verblijfstitel' gegevens
      | naam                              | waarde   |
      | aanduiding verblijfstitel (39.10) | 15       |
      | aanduiding in onderzoek (83.10)   | 103910   |
      | datum ingang onderzoek (83.20)    | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000322                       |
      | fields              | verblijfstitel.aanduiding       |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                        | waarde                                                                           |
      | verblijfstitel.aanduiding.code                              | 15                                                                               |
      | verblijfstitel.aanduiding.omschrijving                      | Benelux of EG richtl nrs 68/360/EEG, 73/148/EEG 75/34/EEG, verord nr 1251/70/EEG |
      | verblijfstitel.inOnderzoek.aanduiding                       | true                                                                             |
      | verblijfstitel.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07                                                                       |
      | verblijfstitel.inOnderzoek.datumIngangOnderzoek.type        | Datum                                                                            |
      | verblijfstitel.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022                                                                     |

    Abstract Scenario: persoon heeft <veld> van ouder in onderzoek
      Gegeven de persoon met burgerservicenummer '000000334' heeft een ouder '<ouder>' met de volgende gegevens
      | naam                            | waarde   |
      | voornamen (02.10)               | Willy    |
      | aanduiding in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)  | 20220307 |
      En de persoon heeft een ouder '<andere ouder>' met de volgende gegevens
      | naam                          | waarde   |
      | voornamen (02.10)             | Renée    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000334                       |
      | fields              | ouders.<veld>                   |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                                         | waarde       |
      | inOnderzoek.<veld>                           | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon een 'ouder' zonder gegevens

      Voorbeelden:
      | waarde | veld                                    | ouder | andere ouder |
      | 020120 | burgerservicenummer                     | 1     | 2            |
      | 030410 | geslacht                                | 2     | 1            |
      | 026210 | datumIngangFamilierechtelijkeBetrekking | 1     | 2            |

    Abstract Scenario: persoon heeft <groep> <veld> van partner in onderzoek
      Gegeven de persoon met burgerservicenummer '000000346' heeft een 'partner' met de volgende gegevens
      | naam                            | waarde    |
      | burgerservicenummer (01.20)     | 000000358 |
      | aanduiding in onderzoek (83.10) | <waarde>  |
      | datum ingang onderzoek (83.20)  | 20220307  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000346                       |
      | fields              | partners.<groep>.<veld>         |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                                                 | waarde       |
      | <groep>.inOnderzoek.<veld>                           | true         |
      | <groep>.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | <groep>.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | <groep>.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | veld          | groep                       |
      | 050240 | geslachtsnaam | naam                        |
      | 050310 | plaats        | geboorte                    |
      | 050610 | datum         | aangaanHuwelijkPartnerschap |

    Scenario: persoon heeft gegevens geslacht, gemeenteVanInschrijving en indicatieCurateleRegister in onderzoek
      Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende gegevens
      | geslachtsaanduiding (04.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | V                           | 010410                          | 20220307                       |
      En de persoon heeft de volgende 'gezagsverhouding' gegevens
      | indicatie curateleregister (33.10) |aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1                                  | 113310                         | 20101205                       |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | 0599                              | 080910                          | 20030405                       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                     |
      | type                | RaadpleegMetBurgerservicenummer                            |
      | burgerservicenummer | 000000358                                                  |
      | fields              | geslacht,indicatieCurateleRegister,gemeenteVanInschrijving |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                 | waarde          |
      | geslacht.code                                        | V               |
      | geslacht.omschrijving                                | vrouw           |
      | gemeenteVanInschrijving.code                         | 0599            |
      | gemeenteVanInschrijving.omschrijving                 | Rotterdam       |
      | indicatieCurateleRegister                            | true            |
      | inOnderzoek.geslacht                                 | true            |
      | inOnderzoek.gemeenteVanInschrijving                  | true            |
      | inOnderzoek.indicatieCurateleRegister                | true            |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum        | 2022-03-07      |
      | inOnderzoek.datumIngangOnderzoekPersoon.type         | Datum           |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat  | 7 maart 2022    |
      | inOnderzoek.datumIngangOnderzoekGemeente.datum       | 2003-04-05      |
      | inOnderzoek.datumIngangOnderzoekGemeente.type        | Datum           |
      | inOnderzoek.datumIngangOnderzoekGemeente.langFormaat | 5 april 2003    |
      | inOnderzoek.datumIngangOnderzoekGezag.datum          | 2010-12-05      |
      | inOnderzoek.datumIngangOnderzoekGezag.type           | Datum           |
      | inOnderzoek.datumIngangOnderzoekGezag.langFormaat    | 5 december 2010 |

  Rule: wanneer een groep in de bron in onderzoek is, wordt elk gegeven in het antwoord dat gevuld wordt uit een van de elementen in die groep ook in inOnderzoek opgenomen met de waarde true
    - de elementcode voor onderzoek eindigt op 00

    Scenario: persoon heeft hele groep naam in onderzoek
      Gegeven de persoon met burgerservicenummer '000000371' heeft de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | 010200                          | 20220307                       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                                              |
      | type                | RaadpleegMetBurgerservicenummer                                                                                     |
      | burgerservicenummer | 000000371                                                                                                           |
      | fields              | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,naam.aanduidingNaamgebruik,geboorte |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                              | waarde       |
      | naam.inOnderzoek.voornamen                        | true         | 
      | naam.inOnderzoek.adellijkeTitelPredicaat          | true         |
      | naam.inOnderzoek.voorvoegsel                      | true         |
      | naam.inOnderzoek.geslachtsnaam                    | true         |
      | naam.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | naam.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | naam.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

    Scenario: kind heeft hele groep geboorte in onderzoek
      Gegeven de persoon met burgerservicenummer '000000383' heeft een 'kind' met de volgende gegevens
      | naam                            | waarde    |
      | burgerservicenummer (01.20)     | 000000395 |
      | aanduiding in onderzoek (83.10) | 090300    |
      | datum ingang onderzoek (83.20)  | 20220307  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000383                       |
      | fields              | kinderen                        |
      Dan heeft de response een persoon met een 'kind' met de volgende gegevens
      | naam                                                  | waarde       |
      | burgerservicenummer                                   | 000000395    |
      | geboorte.inOnderzoek.datum                            | true         |
      | geboorte.inOnderzoek.plaats                           | true         |
      | geboorte.inOnderzoek.land                             | true         |
      | geboorte.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | geboorte.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | geboorte.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

    Abstract Scenario: partner heeft <nauwkeurigheid> soort verbintenis in onderzoek
      Gegeven de persoon met burgerservicenummer '000000395' heeft een 'partner' met de volgende gegevens
      | naam                            | waarde    |
      | burgerservicenummer (01.20)     | 000000401 |
      | aanduiding in onderzoek (83.10) | <waarde>  |
      | datum ingang onderzoek (83.20)  | 20220307  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000395                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                                         | waarde       |
      | burgerservicenummer                          | 000000401    |
      | inOnderzoek.soortVerbintenis                 | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | nauwkeurigheid |
      | 051500 | groep          |
      | 051510 | element        |

  Rule: wanneer een categorie in de bron in onderzoek is, wordt elk gegeven in het antwoord dat gevuld wordt uit een van de elementen in die categorie ook in inOnderzoek opgenomen met de waarde true
    - de elementcode voor onderzoek eindigt op 0000

    Scenario: hele categorie persoon is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000413' heeft de volgende gegevens
      | naam                            | waarde   |
      | aanduiding in onderzoek (83.10) | 010000   |
      | datum ingang onderzoek (83.20)  | 20220307 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 000000425 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                             |
      | type                | RaadpleegMetBurgerservicenummer                                    |
      | burgerservicenummer | 000000413                                                          |
      | fields              | burgerservicenummer,naam,geboorte,geslacht,verblijfplaats,partners |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                  | waarde       |
      | burgerservicenummer                                   | 000000413    |
      | inOnderzoek.burgerservicenummer                       | true         |
      | inOnderzoek.geslacht                                  | true         |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum         | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoekPersoon.type          | Datum        |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat   | 7 maart 2022 |
      | naam.inOnderzoek.voornamen                            | true         |
      | naam.inOnderzoek.adellijkeTitelPredicaat              | true         |
      | naam.inOnderzoek.voorvoegsel                          | true         |
      | naam.inOnderzoek.geslachtsnaam                        | true         |
      | naam.inOnderzoek.voorletters                          | true         |
      | naam.inOnderzoek.aanduidingNaamgebruik                | true         |
      | naam.inOnderzoek.volledigeNaam                        | true         |
      | naam.inOnderzoek.datumIngangOnderzoek.datum           | 2022-03-07   |
      | naam.inOnderzoek.datumIngangOnderzoek.type            | Datum        |
      | naam.inOnderzoek.datumIngangOnderzoek.langFormaat     | 7 maart 2022 |
      | geboorte.inOnderzoek.datum                            | true         |
      | geboorte.inOnderzoek.plaats                           | true         |
      | geboorte.inOnderzoek.land                             | true         |
      | geboorte.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | geboorte.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | geboorte.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon een 'partner' met de volgende gegevens
      | naam                 | waarde    |
      | burgerservicenummer  | 000000425 |

    Scenario: hele categorie kind is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000437' heeft een 'kind' met de volgende gegevens
      | naam                            | waarde    |
      | burgerservicenummer (01.20)     | 000000449 |
      | aanduiding in onderzoek (83.10) | 090000    |
      | datum ingang onderzoek (83.20)  | 20220307  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                           |
      | type                | RaadpleegMetBurgerservicenummer                                                  |
      | burgerservicenummer | 000000437                                                                        |
      | fields              | burgerservicenummer,kinderen.burgerservicenummer,kinderen.naam,kinderen.geboorte |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000437 |
      En heeft de persoon een 'kind' met de volgende gegevens
      | naam                                                  | waarde       |
      | burgerservicenummer                                   | 000000449    |
      | inOnderzoek.burgerservicenummer                       | true         |
      | inOnderzoek.datumIngangOnderzoek.datum                | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type                 | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat          | 7 maart 2022 |
      | naam.inOnderzoek.voornamen                            | true         |
      | naam.inOnderzoek.adellijkeTitelPredicaat              | true         |
      | naam.inOnderzoek.voorvoegsel                          | true         |
      | naam.inOnderzoek.geslachtsnaam                        | true         |
      | naam.inOnderzoek.voorletters                          | true         |
      | naam.inOnderzoek.datumIngangOnderzoek.datum           | 2022-03-07   |
      | naam.inOnderzoek.datumIngangOnderzoek.type            | Datum        |
      | naam.inOnderzoek.datumIngangOnderzoek.langFormaat     | 7 maart 2022 |
      | geboorte.inOnderzoek.datum                            | true         |
      | geboorte.inOnderzoek.plaats                           | true         |
      | geboorte.inOnderzoek.land                             | true         |
      | geboorte.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | geboorte.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | geboorte.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

    Scenario: de groep adres van de categorie verblijfplaats is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000450' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde   |
      | aanduiding in onderzoek (83.10)   | 081100   |
      | datum ingang onderzoek (83.20)    | 20220307 |
      | gemeente van inschrijving (09.10) | 0518     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde |
      | straatnaam (11.10)                | spui   |
      | huisnummer (11.20)                | 70     |
      | gemeentecode (92.10)              | 0518   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000450                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000450 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde        |
      | type                                                       | Adres         |
      | verblijfadres.huisnummer                                   | 70            |
      | verblijfadres.straat                                       | spui          |
      | verblijfadres.korteNaam                                    | spui          |
      | verblijfadres.woonplaats                                   | 's-Gravenhage |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07    |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum         |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022  |
      | verblijfadres.inOnderzoek.aanduidingBijHuisnummer          | true          |
      | verblijfadres.inOnderzoek.huisletter                       | true          |
      | verblijfadres.inOnderzoek.huisnummer                       | true          |
      | verblijfadres.inOnderzoek.huisnummertoevoeging             | true          |
      | verblijfadres.inOnderzoek.straat                           | true          |
      | verblijfadres.inOnderzoek.postcode                         | true          |
      | verblijfadres.inOnderzoek.korteNaam                        | true          |
      | verblijfadres.inOnderzoek.woonplaats                       | true          |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07    |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum         |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022  |
      | inOnderzoek.type                                           | true          |
      | inOnderzoek.nummeraanduidingIdentificatie                  | true          |
      | inOnderzoek.adresseerbaarObjectIdentificatie               | true          |

    Scenario: een element van de groep adres van de categorie verblijfplaats is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000462' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde   |
      | aanduiding in onderzoek (83.10)   | 081120   |
      | datum ingang onderzoek (83.20)    | 20220307 |
      | gemeente van inschrijving (09.10) | 0518     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde |
      | straatnaam (11.10)                | spui   |
      | huisnummer (11.20)                | 70     |
      | gemeentecode (92.10)              | 0518   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000462                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000462 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde        |
      | type                                                       | Adres         |
      | verblijfadres.huisnummer                                   | 70            |
      | verblijfadres.straat                                       | spui          |
      | verblijfadres.korteNaam                                    | spui          |
      | verblijfadres.woonplaats                                   | 's-Gravenhage |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07    |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum         |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022  |
      | verblijfadres.inOnderzoek.huisnummer                       | true          |

    Abstract Scenario: <component in onderzoek> van de categorie verblijfplaats is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                          |
      | aanduiding in onderzoek (83.10)   | <aanduidingGegevensInOnderzoek> |
      | datum ingang onderzoek (83.20)    | 20220307                        |
      | gemeente van inschrijving (09.10) | 0599                            |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde                       |
      | locatiebeschrijving (12.10)       | Woonboot in de Grotere Sloot |
      | gemeentecode (92.10)              | 0599                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000279                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000279 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde                       |
      | type                                                       | Locatie                      |
      | verblijfadres.locatiebeschrijving                          | Woonboot in de Grotere Sloot |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07                   |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022                 |
      | verblijfadres.inOnderzoek.locatiebeschrijving              | true                         |
      | inOnderzoek.type                                           | true                         |

      Voorbeelden:
      | aanduidingGegevensInOnderzoek | component in onderzoek                               |
      | 081200                        | de groep locatie                                     |
      | 081210                        | het element locatiebeschrijving van de groep locatie |

    Scenario: de groep adres buitenland van de categorie verblijfplaats is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000280' heeft de volgende 'verblijfplaats' gegevens
      | naam                             | waarde          |
      | aanduiding in onderzoek (83.10)  | 081300          |
      | datum ingang onderzoek (83.20)   | 20220307        |
      | land (13.10)                     | 5010            |
      | regel 1 adres buitenland (13.30) | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40) | Bruxelles       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000280                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000280 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde                   |
      | type                                                       | VerblijfplaatsBuitenland |
      | verblijfadres.regel1                                       | Rue du pomme 25          |
      | verblijfadres.regel2                                       | Bruxelles                |
      | verblijfadres.land.code                                    | 5010                     |
      | verblijfadres.land.omschrijving                            | België                   |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07               |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022             |
      | verblijfadres.inOnderzoek.regel1                           | true                     |
      | verblijfadres.inOnderzoek.regel2                           | true                     |
      | verblijfadres.inOnderzoek.regel3                           | true                     |
      | verblijfadres.inOnderzoek.land                             | true                     |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07               |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022             |
      | inOnderzoek.type                                           | true                     |
      | inOnderzoek.datumVan                                       | true                     |

    Scenario: het element land van de groep adres buitenland van de categorie verblijfplaats is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000474' heeft de volgende 'verblijfplaats' gegevens
      | naam                             | waarde          |
      | aanduiding in onderzoek (83.10)  | 081310          |
      | datum ingang onderzoek (83.20)   | 20220307        |
      | land (13.10)                     | 5010            |
      | regel 1 adres buitenland (13.30) | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40) | Bruxelles       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000474                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000474 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde                   |
      | type                                                       | VerblijfplaatsBuitenland |
      | verblijfadres.regel1                                       | Rue du pomme 25          |
      | verblijfadres.regel2                                       | Bruxelles                |
      | verblijfadres.land.code                                    | 5010                     |
      | verblijfadres.land.omschrijving                            | België                   |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07               |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022             |
      | verblijfadres.inOnderzoek.land                             | true                     |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07               |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022             |
      | inOnderzoek.type                                           | true                     |

    Scenario: hele categorie verblijfplaats van een adres is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000486' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde   |
      | aanduiding in onderzoek (83.10)   | 080000   |
      | datum ingang onderzoek (83.20)    | 20220307 |
      | gemeente van inschrijving (09.10) | 0518     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde |
      | straatnaam (11.10)                | spui   |
      | huisnummer (11.20)                | 70     |
      | gemeentecode (92.10)              | 0518   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000486                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000486 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde        |
      | type                                                       | Adres         |
      | verblijfadres.huisnummer                                   | 70            |
      | verblijfadres.straat                                       | spui          |
      | verblijfadres.korteNaam                                    | spui          |
      | verblijfadres.woonplaats                                   | 's-Gravenhage |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07    |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum         |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022  |
      | verblijfadres.inOnderzoek.aanduidingBijHuisnummer          | true          |
      | verblijfadres.inOnderzoek.huisletter                       | true          |
      | verblijfadres.inOnderzoek.huisnummer                       | true          |
      | verblijfadres.inOnderzoek.huisnummertoevoeging             | true          |
      | verblijfadres.inOnderzoek.straat                           | true          |
      | verblijfadres.inOnderzoek.postcode                         | true          |
      | verblijfadres.inOnderzoek.korteNaam                        | true          |
      | verblijfadres.inOnderzoek.woonplaats                       | true          |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07    |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum         |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022  |
      | inOnderzoek.type                                           | true          |
      | inOnderzoek.datumVan                                       | true          |
      | inOnderzoek.datumIngangGeldigheid                          | true          |
      | inOnderzoek.nummeraanduidingIdentificatie                  | true          |
      | inOnderzoek.adresseerbaarObjectIdentificatie               | true          |
      | inOnderzoek.functieAdres                                   | true          |

    Scenario: hele categorie verblijfplaats van een locatiebeschrijving is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000498' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde   |
      | aanduiding in onderzoek (83.10)   | 080000   |
      | datum ingang onderzoek (83.20)    | 20220307 |
      | gemeente van inschrijving (09.10) | 0599     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde                       |
      | locatiebeschrijving (12.10)       | Woonboot in de Grotere Sloot |
      | gemeentecode (92.10)              | 0599                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000498                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000498 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde                       |
      | type                                                       | Locatie                      |
      | verblijfadres.locatiebeschrijving                          | Woonboot in de Grotere Sloot |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07                   |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022                 |
      | verblijfadres.inOnderzoek.locatiebeschrijving              | true                         |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07                   |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum                        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022                 |
      | inOnderzoek.type                                           | true                         |
      | inOnderzoek.datumVan                                       | true                         |
      | inOnderzoek.functieAdres                                   | true                         |
      | inOnderzoek.datumIngangGeldigheid                          | true                         |

    Scenario: hele categorie verblijfplaats van een verblijfplaats buitenland is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000504' heeft de volgende 'verblijfplaats' gegevens
      | naam                             | waarde          |
      | aanduiding in onderzoek (83.10)  | 080000          |
      | datum ingang onderzoek (83.20)   | 20220307        |
      | land (13.10)                     | 5010            |
      | regel 1 adres buitenland (13.30) | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40) | Bruxelles       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000504                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000504 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde                   |
      | type                                                       | VerblijfplaatsBuitenland |
      | verblijfadres.regel1                                       | Rue du pomme 25          |
      | verblijfadres.regel2                                       | Bruxelles                |
      | verblijfadres.land.code                                    | 5010                     |
      | verblijfadres.land.omschrijving                            | België                   |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07               |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022             |
      | verblijfadres.inOnderzoek.regel1                           | true                     |
      | verblijfadres.inOnderzoek.regel2                           | true                     |
      | verblijfadres.inOnderzoek.regel3                           | true                     |
      | verblijfadres.inOnderzoek.land                             | true                     |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07               |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022             |
      | inOnderzoek.type                                           | true                     |
      | inOnderzoek.datumVan                                       | true                     |
      | inOnderzoek.datumIngangGeldigheid                          | true                     |

  Rule: een afgeleid gegeven wordt in inOnderzoek opgenomen wanneer ten minste één van de gegevens waaruit het wordt afgeleid in onderzoek staat

    Abstract Scenario: leeftijd van de persoon in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000516' heeft de volgende gegevens
      | naam                             | waarde   |
      | aanduiding in onderzoek (83.10)  | <waarde> |
      | datum ingang onderzoek (83.20)   | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000516                       |
      | fields              | leeftijd                        |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                | waarde       |
      | inOnderzoek.leeftijd                                | true         |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | reden                        | waarde |
      | geboortedatum van de persoon | 010310 |
      | groep geboorte               | 010300 |
      | categorie persoon            | 010000 |

    Abstract Scenario: indicatieOverleden van de persoon in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000528' heeft de volgende 'overlijden' gegevens
      | naam                             | waarde   |
      | aanduiding in onderzoek (83.10)  | <waarde> |
      | datum ingang onderzoek (83.20)   | 20220307 |
      | datum overlijden (08.10)         | 20220218 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000528                       |
      | fields              | overlijden.indicatieOverleden   |
      Dan heeft de response een persoon met de volgende 'overlijden' gegevens
      | naam                                         | waarde       |
      | indicatieOverleden                           | true         |
      | inOnderzoek.indicatieOverleden               | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | gegeven in onderzoek | reden                | waarde |
      | datum van overlijden | datum overlijden     | 060810 |
      | groep overlijden     | groep overlijden     | 060800 |
      | categorie overlijden | categorie overlijden | 060000 |

    Abstract Scenario: voorletters van een ouder in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000541' heeft een ouder '<ouder>' met de volgende gegevens
      | naam                            | waarde           |
      | aanduiding in onderzoek (83.10) | <waarde>         |
      | datum ingang onderzoek (83.20)  | 20220307         |
      | voornamen (02.10)               | <voornaam ouder> |
      En de persoon heeft een ouder '<andere ouder>' met de volgende gegevens
      | naam              | waarde                  |
      | voornamen (02.10) | <voornaam andere ouder> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 000000541                                      |
      | fields              | ouders.ouderAanduiding,ouders.naam.voorletters |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                                              | waarde       |
      | ouderAanduiding                                   | <ouder>      |
      | naam.voorletters                                  | R.           |
      | naam.inOnderzoek.voorletters                      | true         |
      | naam.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | naam.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | naam.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam             | waarde         |
      | ouderAanduiding  | <andere ouder> |
      | naam.voorletters | W.             |

      Voorbeelden:
      | gegeven in onderzoek   | waarde | ouder  | voornaam ouder | andere ouder | voornaam andere ouder |
      | voornamen van ouder 1  | 020210 | 1      | Renée          | 2            | Willy                 |
      | groep naam van ouder 1 | 020200 | 1      | Renée          | 2            | Willy                 |
      | categorie ouder 1      | 020000 | 1      | Renée          | 2            | Willy                 |
      | voornamen van ouder 2  | 030210 | 2      | Renée          | 1            | Willy                 |
      | groep naam van ouder 2 | 030200 | 2      | Renée          | 1            | Willy                 |
      | categorie ouder 2      | 030000 | 2      | Renée          | 1            | Willy                 |

    Abstract Scenario: verblijfplaats datumVan in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000553' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                        |
      | datum aanvang adreshouding (10.30)     | <datumAanvangAdreshouding>    |
      | datum aanvang adres buitenland (13.20) | <datumAanvangAdresBuitenland> |
      | aanduiding in onderzoek (83.10)        | <waarde>                      |
      | datum ingang onderzoek (83.20)         | 20220307                      |
      | land (13.10)                           | <land>                        |
      | regel 1 adres buitenland (13.30)       | <adresregel1>                 |
      | regel 2 adres buitenland (13.40)       | <adresregel2>                 |
      | gemeente van inschrijving (09.10)      | <gemeente>                    |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                | waarde                |
      | straatnaam (11.10)                  | <straat>              |
      | huisnummer (11.20)                  | <huisnummer>          |
      | locatiebeschrijving (12.10)         | <locatiebeschrijving> |
      | gemeentecode (92.10)                | <gemeente>            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000553                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                         | waarde       |
      | type                                         | <type>       |
      | datumVan.type                                | Datum        |
      | datumVan.datum                               | 2004-07-01   |
      | datumVan.langFormaat                         | 1 juli 2004  |
      | inOnderzoek.datumVan                         | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | gegeven in onderzoek        | waarde | straat | huisnummer | locatiebeschrijving          | datumAanvangAdreshouding | adresregel1     | adresregel2 | land | datumAanvangAdresBuitenland | gemeente | type                     |
      | datumAanvangAdreshouding    | 081030 | Spui   | 71         |                              | 20040701                 |                 |             |      |                             | 0518     | Adres                    |
      | groep adreshouding          | 081000 | Spui   | 71         |                              | 20040701                 |                 |             |      |                             | 0518     | Adres                    |
      | categorie verblijfplaats    | 081000 | Spui   | 71         |                              | 20040701                 |                 |             |      |                             | 0518     | Adres                    |
      | datumAanvangAdreshouding    | 081030 |        |            | Woonboot in de Grotere Sloot | 20040701                 |                 |             |      |                             | 0599     | Locatie                  |
      | datumAanvangAdresBuitenland | 081320 |        |            |                              |                          | Rue du pomme 26 | Bruxelles   | 5010 | 20040701                    | 0000     | VerblijfplaatsBuitenland |
      | verblijf buitenland         | 081320 |        |            |                              |                          | Rue du pomme 26 | Bruxelles   | 5010 | 20040701                    | 0000     | VerblijfplaatsBuitenland |
      | datumAanvangAdresBuitenland | 081320 |        |            |                              |                          |                 |             | 0000 | 20040701                    | 0000     | VerblijfplaatsOnbekend   |

    Scenario: indicatieVestigingVanuitBuitenland in onderzoek omdat datumVestigingInNederland is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000565' heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde   |
      | aanduiding in onderzoek (83.10) | 081420   |
      | datum ingang onderzoek (83.20)  | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                        |
      | type                | RaadpleegMetBurgerservicenummer               |
      | burgerservicenummer | 000000565                                     |
      | fields              | immigratie.indicatieVestigingVanuitBuitenland |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                                                | waarde       |
      | inOnderzoek.indicatieVestigingVanuitBuitenland      | true         |
      | inOnderzoek.datumIngangOnderzoek.datum              | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type               | Datum        |
      | inOnderzoek.datumIngangOnderzoekPersson.langFormaat | 7 maart 2022 |

    Abstract Scenario: verblijfplaats adresregel1, adresregel2 en woonplaats in onderzoek bij <gegeven in onderzoek> is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000577' heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde   |
      | aanduiding in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)  | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                              |
      | type                | RaadpleegMetBurgerservicenummer                     |
      | burgerservicenummer | 000000577                                           |
      | fields              | adresregel1,adresregel2,straat,korteNaam,woonplaats |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                                      | waarde                  |
      | adressering.inOnderzoek.adresregel1                                       | <adresregel1>           |
      | adressering.inOnderzoek.adresregel2                                       | <adresregel2>           |
      | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum          | 2022-03-07              |
      | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.type           | Datum                   |
      | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat    | 7 maart 2022            |
      | verblijfplaats.type                                                       | <type>                  |
      | verblijfplaats.inOnderzoek.type                                           | <verbl.plaatstype>      |
      | verblijfplaats.verblijfadres.inOnderzoek.korteNaam                        | <korteNaam>             |
      | verblijfplaats.verblijfadres.inOnderzoek.straat                           | <straat>                |
      | verblijfplaats.verblijfadres.inOnderzoek.woonplaats                       | <woonplaats>            |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | <verbl.adres datum>     |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | <verbl.adres datumtype> |
      | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | <verbl.adres lang>      |

      #hier betekent leeg dat het inOnderzoek gegeven niet is opgenomen in het antwoord
      Voorbeelden:
      | gegeven in onderzoek      | waarde | type                   | adresregel1 | adresregel2 | korteNaam | straat | woonplaats | verbl.plaatstype | verbl.adres datum | verbl.adres datumtype | verbl.adres lang |
      | gemeenteVanInschrijving   | 080910 | VerblijfplaatsOnbekend |             | true        |           |        |            |                  |                   |                       |                  | 
      | straat                    | 081110 | VerblijfplaatsOnbekend | true        |             | true      | true   |            |                  |                   |                       |                  | 
      | naamOpenbareRuimte        | 081115 | VerblijfplaatsOnbekend | true        |             |           | true   |            |                  |                   |                       |                  | 
      | huisnummer                | 081120 | VerblijfplaatsOnbekend | true        |             |           |        |            |                  |                   |                       |                  | 
      | woonplaats                | 081170 | VerblijfplaatsOnbekend |             | true        |           |        | true       |                  |                   |                       |                  | 
      | locatiebeschrijving       | 081210 | VerblijfplaatsOnbekend | true        |             |           |        |            | true             | 2022-03-07        | Datum                 | 7 maart 2022     | 
      | adresregel1               | 081330 | VerblijfplaatsOnbekend | true        |             |           |        |            |                  |                   |                       |                  | 
      | groep gemeente            | 080900 | VerblijfplaatsOnbekend |             | true        |           |        |            |                  |                   |                       |                  | 
      | groep adres               | 081100 | VerblijfplaatsOnbekend | true        | true        | true      | true   | true       | true             | 2022-03-07        | Datum                 | 7 maart 2022     | 
      | groep locatiebeschrijving | 081200 | VerblijfplaatsOnbekend | true        |             |           |        |            | true             | 2022-03-07        | Datum                 | 7 maart 2022     | 
      | groep verblijf buitenland | 081300 | VerblijfplaatsOnbekend | true        | true        |           |        |            | true             | 2022-03-07        | Datum                 | 7 maart 2022     | 
      | categorie verblijfplaats  | 080000 | VerblijfplaatsOnbekend | true        | true        | true      | true   | true       | true             | 2022-03-07        | Datum                 | 7 maart 2022     | 

    Abstract Scenario: <gegeven in onderzoek> is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000589' heeft een 'nationaliteit' met de volgende gegevens
      | naam                               | waarde                                |
      | nationaliteit (05.10)              | <nationaliteit>                       |
      | bijzonder Nederlanderschap (65.10) | <aanduidingBijzonderNederlanderschap> |
      | datum ingang geldigheid (85.10)    | <datumIngangGeldigheid>               |
      | aanduiding in onderzoek (83.10)    | <waarde>                              |
      | datum ingang onderzoek (83.20)     | 20220307                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000589                       |
      | fields              | nationaliteiten.inOnderzoek     |
      Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
      | naam                                         | waarde                       |
      | type                                         | <nationaliteit type>         |
      | inOnderzoek.type                             | <type in onderzoek>          |
      | inOnderzoek.nationaliteit                    | <nationaliteit in onderzoek> |
      | inOnderzoek.redenOpname                      | <redenOpname in onderzoek>   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07                   |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022                 |

      Voorbeelden:
      | gegeven in onderzoek                                          | nationaliteit | aanduidingBijzonderNederlanderschap | nationaliteit type         | datumIngangGeldigheid | waarde | type in onderzoek | nationaliteit in onderzoek | redenOpname in onderzoek |
      | hele categorie nationaliteit                                  | 0052          |                                     | Nationaliteit              | 19560317              | 040000 | true              | true                       | true                     |
      | hele categorie nationaliteit bij onbekende nationaliteit      | 0000          |                                     | NationaliteitOnbekend      | 00000000              | 040000 | true              |                            | true                     |
      | hele categorie nationaliteit bij vastgesteld niet-Nederlander |               | V                                   | VastgesteldNietNederlander | 19710417              | 040000 | true              |                            | true                     |
      | hele categorie nationaliteit bij behandeld als Nederlander    |               | B                                   | BehandeldAlsNederlander    | 19520831              | 040000 | true              |                            | true                     |
      | veld nationaliteit                                            | 0052          |                                     | Nationaliteit              | 19560317              | 040510 | true              | true                       |                          |
      | veld nationaliteit bij onbekende nationaliteit                | 0000          |                                     | NationaliteitOnbekend      | 19560317              | 040510 | true              |                            |                          |
      | reden opname                                                  | 0052          |                                     | Nationaliteit              | 19560317              | 046310 |                   |                            | true                     |
      | veld nationaliteit type bij vastgesteld niet-Nederlander      |               | V                                   | VastgesteldNietNederlander | 19710417              | 046510 | true              |                            |                          |
      | veld nationaliteit type bij behandeld als Nederlander         |               | B                                   | BehandeldAlsNederlander    | 19710417              | 046510 | true              |                            |                          |

  Rule: onderzoek van een partnergegeven leidt alleen tot inOnderzoek van een samengesteld naamgegeven wanneer daarin de partnernaam wordt gebruikt
    - naam.aanduidingNaamgebruik is ongelijk aan 'E'
    - een of meerdere van de partner naamgegevens voorvoegsel, adellijkeTitelPredicaat of geslachtsnaam zijn in onderzoek
    - betreft aanhef, aanschrijfwijze en gebruikInLopendeTekst

    Abstract Scenario: samengestelde namen bij <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000590' heeft de volgende gegevens
      | naam                           | waarde                  |
      | voornamen (02.10)              | Piet                    |
      | geslachtsnaam (02.40)          | Groenen                 |
      | aanduiding naamgebruik (61.10) | <aanduidingNaamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                            | waarde    |
      | burgerservicenummer (01.20)     | 000000607 |
      | aanduiding in onderzoek (83.10) | <waarde>  |
      | datum ingang onderzoek (83.20)  | 20220307  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000590                       |
      | fields              | burgerservicenummer,adressering.inOnderzoek.aanhef,adressering.inOnderzoek.aanschrijfwijze,adressering.inOnderzoek.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                            | waarde         |
      | burgerservicenummer                                             | 000000590      |
      | adressering.inOnderzoek.aanhef                                  | <in onderzoek> |
      | adressering.inOnderzoek.aanschrijfwijze                         | <in onderzoek> |
      | adressering.inOnderzoek.gebruikInLopendeTekst			        | <in onderzoek> |
      | adressering.inOnderzoek.datumIngangOnderzoekPartner.type        | <datum type>   |
      | adressering.inOnderzoek.datumIngangOnderzoekPartner.datum       | <datum datum>  |
      | adressering.inOnderzoek.datumIngangOnderzoekPartner.langFormaat | <datum lang>   |

      Voorbeelden:
      | omschrijving                                            | waarde | aanduidingNaamgebruik | in onderzoek | datum type | datum datum | datum lang   |
      | partner in onderzoek en gebruik eigen naam              | 050000 | E                     |              |            |             |              |
      | partner in onderzoek en gebruik partner naam            | 050000 | P                     | true         | Datum      | 2022-03-07  | 7 maart 2022 |
      | partner in onderzoek en gebruik partner na eigen naam   | 050000 | N                     | true         | Datum      | 2022-03-07  | 7 maart 2022 |
      | partner in onderzoek en gebruik partner voor eigen naam | 050000 | V                     | true         | Datum      | 2022-03-07  | 7 maart 2022 |
      | groep naam van partner in onderzoek                     | 050200 | P                     | true         | Datum      | 2022-03-07  | 7 maart 2022 |
      | adellijkeTitelPredicaat in onderzoek                    | 050220 | P                     | true         | Datum      | 2022-03-07  | 7 maart 2022 |
      | voorvoegsel in onderzoek                                | 050230 | P                     | true         | Datum      | 2022-03-07  | 7 maart 2022 |
      | geslachtsnaam in onderzoek                              | 050240 | P                     | true         | Datum      | 2022-03-07  | 7 maart 2022 |

    Abstract Scenario: samengestelde namen bij <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000590' heeft de volgende gegevens
      | naam                           | waarde                  |
      | voornamen (02.10)              | Piet                    |
      | geslachtsnaam (02.40)          | Groenen                 |
      | aanduiding naamgebruik (61.10) | <aanduidingNaamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                            | waarde    |
      | burgerservicenummer (01.20)     | 000000607 |
      | aanduiding in onderzoek (83.10) | <waarde>  |
      | datum ingang onderzoek (83.20)  | 20220307  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                      |
      | type                | RaadpleegMetBurgerservicenummer                             |
      | burgerservicenummer | 000000590                                                   |
      | fields              | burgerservicenummer,adressering.inOnderzoek.aanhef,adressering.inOnderzoek.aanschrijfwijze,adressering.inOnderzoek.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                            | waarde         |
      | burgerservicenummer                                             | 000000590      |
      En heeft de persoon een leeg 'adressering' object
	  
      Voorbeelden:
      | omschrijving                                            | waarde | aanduidingNaamgebruik |
      | partner in onderzoek en gebruik eigen naam              | 050000 | E                     |
      | voornamen in onderzoek                                  | 050210 | P                     |
      | aangaanHuwelijkPartnerschap in onderzoek                | 050600 | P                     |
