# language: nl

@proxy @post-assert
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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000097                       |
      | fields              | ouders,partners,naam            |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde            |
      | voornamen                                    | Arnitta           |
      En heeft de persoon de volgende 'persoonInOnderzoek' gegevens 
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 010000   |
      | datumIngangOnderzoek          | 20120920 |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam                              | waarde |
      | naam.voornamen                    | Noa    |
      | geslacht.code                     | V      |
      | geslacht.omschrijving             | vrouw  |
      | ouderAanduiding                   | 1      |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam                              | waarde |
      | naam.voornamen                    | Jan    |
      | geslacht.code                     | M      |  
      | geslacht.omschrijving             | man    |
      | ouderAanduiding                   | 2      |
      En heeft de persoon een 'partner' met de volgende gegevens
      | naam                              | waarde    |
      | burgerservicenummer               | 000000103 |
      | naam.voornamen                    | Karel     |
      | geslacht.code                     | M         |
      | geslacht.omschrijving             | man       |
      | aangaanHuwelijkPartnerschap.datum | 20091102  |

    Scenario: vragen om naam bij geboortedatum in onderzoek
      Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | Arnitta           | 19231213              | 010310                          | 20120920                       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000097                       |
      | fields              | naam            |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                      | waarde  |
      | voornamen                 | Arnitta |

    Scenario: vragen om voorvoegsel zonder waarde bij groep naam in onderzoek
      Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | Arnitta           | 19231213              | 010200                          | 20120920                       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                           |
      | type                | RaadpleegMetBurgerservicenummer  |
      | burgerservicenummer | 000000115                        |
      | fields              | naam.voorvoegsel |
      Dan heeft de response een persoon met de volgende 'persoonInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 010200   |
      | datumIngangOnderzoek          | 20120920 |

    Scenario: persoon heeft gezagInOnderzoek en persoonInOnderzoek
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | 
      | Arnitta           | 19231213              | 010410                          | 20120920                       |
      En de persoon heeft de volgende 'gezagsverhouding' gegevens
      | indicatie curateleregister (33.10) |aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1                                  | 113310                         | 20101205                       |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000139                          |
      | fields              | geslacht,indicatieCurateleRegister |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                             | waarde   |
      | indicatieCurateleRegister                        | true     |
      | persoonInOnderzoek.aanduidingGegevensInOnderzoek | 010410   |
      | persoonInOnderzoek.datumIngangOnderzoek          | 20120920 |
      | gezagInOnderzoek.aanduidingGegevensInOnderzoek   | 113310   |
      | gezagInOnderzoek.datumIngangOnderzoek            | 20101205 |

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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000140                       |
      | fields              | ouders                          |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                  | waarde |
      | naam.voornamen        | Noa    |
      | geslacht.code         | V      |
      | geslacht.omschrijving | vrouw  |
      | ouderAanduiding       | 1      |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam                  | waarde |
      | naam.voornamen        | Jan    |
      | geslacht.code         | M      |
      | geslacht.omschrijving | man    |
      | ouderAanduiding       | 2      |

  Rule: in onderzoek wordt niet opgenomen wanneer het onderzoek beëindigd is
    - Datum einde onderzoek (83.30) heeft een waarde

    Scenario: onderzoek is beëindigd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | 
      | Arnitta           | 19231213              | 010000                          | 20120920                       | 20120922                      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                            |
      | type                | RaadpleegMetBurgerservicenummer                   |
      | burgerservicenummer | 000000152                                         |
      | fields              | burgerservicenummer,naam.voornamen,geboorte.datum |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |
      | naam.voornamen      | Arnitta   |
      | geboorte.datum      | 19231213  |
