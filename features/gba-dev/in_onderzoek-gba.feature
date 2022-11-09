# language: nl

Functionaliteit: in onderzoek
  Wanneer de juistheid van een gegeven, een groep of een hele categorie onderzocht wordt, en daardoor de waarde van een of meerdere geleverde gegevens mogelijk onjuist is, 
  wordt, ook zonder dat daar in fields om gevraagd wordt, naast het/de gevraagde veld(en) in persoonInOnderzoek, gezagInOnderzoek of in een of meerdere inOnderzoek groepen 
  (afhankelijk van de categorie waarop in onderzoek van toepassing is) een aanduidingGegevensInOnderzoek opgenomen. 
  Deze krijgt/krijgen als waarde de 6-cijferige code die refereert aan een categorie, groep of gegeven dat in onderzoek is.

  Rule: wanneer een gegeven uit een categorie gevraagd is en er zit onderzoek op die categorie, een groep van die categorie of een gegeven van die categorie dan wordt aanduidingGegevensInOnderzoek geleverd.
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
      | naam      | waarde            |
      | voornamen | Arnitta           |
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
      | fields              | naam                            |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde  |
      | voornamen | Arnitta |
      En heeft de persoon de volgende 'persoonInOnderzoek' gegevens 
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 010310   |
      | datumIngangOnderzoek          | 20120920 |

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
	  En heeft de persoon een leeg 'naam' object

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

  Scenario: naam ouder 1 in onderzoek en een ouder naam gegeven wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                            | waarde    |
    | aanduiding in onderzoek (83.10) | 020200    |
    | datum ingang onderzoek (83.20)  | 20020701  |
    | burgerservicenummer (01.20)     | 000000013 |
    | geslachtsnaam (02.40)           | Groen     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.naam.geslachtsnaam       |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                                      | waarde   |
    | inOnderzoek.aanduidingGegevensInOnderzoek | 020200   |
    | inOnderzoek.datumIngangOnderzoek          | 20020701 |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam          | waarde |
    | geslachtsnaam | Groen  |

  Scenario: naam ouder 1 in onderzoek maar een ander ouder gegeven wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                            | waarde    |
    | aanduiding in onderzoek (83.10) | 020200    |
    | datum ingang onderzoek (83.20)  | 20020701  |
    | burgerservicenummer (01.20)     | 000000013 |
    | geslachtsnaam (02.40)           | Groen     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.burgerservicenummer      |
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                                      | waarde    |
    | burgerservicenummer                       | 000000013 |
    | inOnderzoek.aanduidingGegevensInOnderzoek | 020200    |
    | inOnderzoek.datumIngangOnderzoek          | 20020701  |

  Scenario: naam ouder 1 in onderzoek en een niet-ouder gegeven wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                            | waarde    |
    | aanduiding in onderzoek (83.10) | 020200    |
    | datum ingang onderzoek (83.20)  | 20020701  |
    | burgerservicenummer (01.20)     | 000000013 |
    | geslachtsnaam (02.40)           | Groen     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |

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
