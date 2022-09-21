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
      | naam                                    | waarde          |
      | burgerservicenummer                     | 000000103       |
      | naam.voornamen                          | Karel           |
      | naam.voorletters                        | K.              |
      | geslacht.code                           | M               |
      | geslacht.omschrijving                   | man             |
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
      | fields              | naam.voorvoegsel |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                      | waarde  |
      | inOnderzoek.voornamen     | true    |
      | inOnderzoek.voorletters   | true    |
      | inOnderzoek.volledigeNaam | true    |

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

  @proxy
  Rule: in onderzoek wordt niet opgenomen wanneer het gegeven of de groep die onderzocht wordt niet wordt gevraagd
    Dit is het geval wanneer gegevens in onderzoek zijn die:
    - niet in de resource voorkomen
    - niet gevraagd zijn met fields

    @proxy
    Scenario: persoon heeft EU-persoonsnummer van nationaliteit in onderzoek die niet voorkomt in de resource
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de nationaliteit heeft volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 047310   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 555550001                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '555550001' GEEN 'inOnderzoek' gegevens
      En heeft de nationaliteit GEEN 'inOnderzoek' gegevens

    @proxy
    Abstract Scenario: persoon heeft <gegeven in onderzoek> in onderzoek dat niet is gevraagd met fields
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <fields>                        |
      Dan heeft de persoon GEEN 'inOnderzoek' gegevens

      Voorbeelden:
      | waarde | gegeven in onderzoek   | fields                      |
      | 010000 | hele categorie persoon | kinderen                    |
      | 010200 | hele groep naam        | geslacht,geboorte.datum     |
      | 010210 | voornamen              | geboorte,naam.geslachtsnaam |

  @proxy
  Rule: wanneer een element in de bron in onderzoek is, wordt het gegeven in het antwoord dat daaruit gevuld wordt ook in inOnderzoek opgenomen met de waarde true

    Abstract Scenario: persoon heeft <veld> in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft de volgende 'persoonInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <veld>                          |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende 'inOnderzoek' gegevens
      | naam                                    | waarde       |
      | <veld>                                  | true         |
      | datumIngangOnderzoekPersoon.datum       | 2022-03-07   |
      | datumIngangOnderzoekPersoon.type        | Datum        |
      | datumIngangOnderzoekPersoon.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | veld                |
      | 010120 | burgerservicenummer |
      | 010410 | geslacht            |

    Abstract Scenario: persoon heeft <groep> <veld> in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft de volgende 'persoonInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.<veld>                  |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende '<groep>.inOnderzoek' gegevens
      | naam                             | waarde       |
      | <veld>                           | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | veld                      | groep            |
      | 010220 | adellijkeTitelPredicaat   | naam             |
      | 016110 | aanduidingNaamgebruik     | naam             |
      | 010310 | datum                     | geboorte         |

    Abstract Scenario: persoon heeft <veld> van <groep> in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft de volgende '<groep>.inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.<veld>                  |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende '<groep>.inOnderzoek' gegevens
      | naam                             | waarde       |
      | <veld>                           | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | veld                      | groep            |
      | 081120 | huisnummer                | verblijfplaats   |
      | 081130 | huisletter                | verblijfplaats   |
      | 081140 | huisnummertoevoeging      | verblijfplaats   |
      | 081150 | aanduidingBijHuisnummer   | verblijfplaats   |
      | 081160 | postcode                  | verblijfplaats   |
      | 081170 | woonplaats                | verblijfplaats   |
      | 081210 | locatiebeschrijving       | verblijfplaats   |
      | 081310 | land                      | verblijfplaats   |
      | 081350 | adresregel3               | verblijfplaats   |
      | 103910 | aanduiding                | verblijfstitel   |

    Abstract Scenario: persoon heeft <veld> van ouder in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft een ouder met de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 1      |
      En de persoon heeft een ouder met de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 2      |
      En de ouder met ouderAanduiding '<ouder>' heeft volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      En ouder met ouderAanduiding '<andere ouder>' heeft GEEN 'inOnderzoek' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | ouders.<veld>                   |
      Dan heeft de ouder met ouderAanduiding '<ouder>' de volgende 'inOnderzoek' gegevens
      | naam                             | waarde       |
      | <veld>                           | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de ouder met ouderAanduiding '<andere ouder>' GEEN 'inOnderzoek' gegevens
      En heeft de persoon GEEN 'inOnderzoek' gegevens

      Voorbeelden:
      | waarde | veld                                    | ouder | andere ouder |
      | 020220 | burgerservicenummer                     | 1     | 2            |
      | 030410 | geslacht                                | 2     | 1            |
      | 026210 | datumIngangFamilierechtelijkeBetrekking | 1     | 2            |

    Abstract Scenario: persoon heeft <groep> <veld> van partner in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de partner met burgerservicenummer '555550002' heeft volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | partners.<veld>                 |
      Dan heeft de partner met burgerservicenummer '555550002' de volgende '<groep>.inOnderzoek' gegevens
      | naam                             | waarde       |
      | <veld>                           | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de partner met burgerservicenummer '555550002' GEEN 'inOnderzoek' gegevens

      Voorbeelden:
      | waarde | veld                        | groep    |
      | 050240 | geslachtsnaam               | naam     |
      | 050310 | plaats                      | geboorte |
      | 050610 | aangaanHuwelijkPartnerschap | datum    |

      Scenario: persoon heeft gegevens geslacht, gemeenteVanInschrijving en indicatieCurateleRegister in onderzoek
        Gegeven het systeem heeft een persoon met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer         | 555550001 |
        En de persoon heeft de volgende 'persoonInOnderzoek' gegevens
        | naam                          | waarde   |
        | aanduidingGegevensInOnderzoek | 010410   |
        | datumIngangOnderzoek          | 20220307 |
        En de persoon heeft de volgende 'gezagInOnderzoek' gegevens
        | naam                          | waarde   |
        | aanduidingGegevensInOnderzoek | 113310   |
        | datumIngangOnderzoek          | 20101205 |
        En de persoon heeft de volgende 'verblijfplaats.inOnderzoek' gegevens
        | naam                          | waarde   |
        | aanduidingGegevensInOnderzoek | 080910   |
        | datumIngangOnderzoek          | 20030405 |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                                                     |
        | type                | RaadpleegMetBurgerservicenummer                            |
        | burgerservicenummer | 555550001                                                  |
        | fields              | geslacht,indicatiecurateleregister,gemeentevaninschrijving |
        Dan heeft de persoon met burgerservicenummer '555550001' de volgende 'inOnderzoek' gegevens
        | naam                                     | waarde          |
        | geslacht                                 | true            |
        | gemeenteVanInschrijving                  | true            |
        | indicatieCurateleRegister                | true            |
        | datumIngangOnderzoekPersoon.datum        | 2022-03-07      |
        | datumIngangOnderzoekPersoon.type         | Datum           |
        | datumIngangOnderzoekPersoon.langFormaat  | 7 maart 2022    |
        | datumIngangOnderzoekGemeente.datum       | 2003-04-05      |
        | datumIngangOnderzoekGemeente.type        | Datum           |
        | datumIngangOnderzoekGemeente.langFormaat | 5 april 2003    |
        | datumIngangOnderzoekGezag.datum          | 2010-12-05      |
        | datumIngangOnderzoekGezag.type           | Datum           |
        | datumIngangOnderzoekGezag.langFormaat    | 5 december 2010 |


  @proxy
  Rule: wanneer een groep in de bron in onderzoek is, wordt elk gegeven in het antwoord dat gevuld wordt uit een van de elementen in die groep ook in inOnderzoek opgenomen met de waarde true
    - de elementcode voor onderzoek eindigt op 00

    Scenario: persoon heeft hele groep naam in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft de volgende 'persoonInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 010200   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                                              |
      | type                | RaadpleegMetBurgerservicenummer                                                                                     |
      | burgerservicenummer | 555550001                                                                                                           |
      | fields              | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,naam.aanduidingNaamgebruik,geboorte |
      Dan heeft de persoon met burgerservicenummer '555550001' alleen de volgende 'naam.inOnderzoek' gegevens
      | naam                             | waarde     |
      | voornamen                        | true       |
      | adellijkeTitelPredicaat          | true       |
      | voorvoegsel                      | true       |
      | geslachtsnaam                    | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon GEEN 'inOnderzoek' gegevens
      En heeft de persoon GEEN 'geboorte.inOnderzoek' gegevens

    Scenario: kind heeft hele groep geboorte in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft een kind met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En het kind met burgerservicenummer '555550002' heeft volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 090300   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | kinderen                        |
      Dan heeft het kind met burgerservicenummer '555550002' alleen de volgende 'geboorte.inOnderzoek' gegevens
      | naam                             | waarde     |
      | datum                            | true       |
      | plaats                           | true       |
      | land                             | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft het kind met burgerservicenummer '555550002' GEEN 'inOnderzoek' gegevens
      En heeft het kind met burgerservicenummer '555550002' GEEN 'naam.inOnderzoek' gegevens
      En heeft de persoon met burgerservicenummer '555550001' GEEN 'inOnderzoek' gegevens
      En heeft de persoon met burgerservicenummer '555550001' GEEN 'geboorte.inOnderzoek' gegevens

    Abstract Scenario: partner heeft <nauwkeurigheid> soort verbintenis in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de partner met burgerservicenummer '555550002' heeft volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | partners                        |
      Dan heeft de partner met burgerservicenummer '555550002' alleen de volgende 'inOnderzoek' gegevens
      | naam                             | waarde     |
      | soortVerbintenis                 | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de partner met burgerservicenummer '555550002' GEEN 'naam.inOnderzoek' gegevens
      En heeft de partner met burgerservicenummer '555550002' GEEN 'geboorte.inOnderzoek' gegevens
      En heeft de persoon met burgerservicenummer '555550001' GEEN 'persoonInOnderzoek' gegevens

      Voorbeelden:
      | waarde | nauwkeurigheid |
      | 051500 | groep          |
      | 051510 | element        |

  @proxy
  Rule: wanneer een categorie in de bron in onderzoek is, wordt elk gegeven in het antwoord dat gevuld wordt uit een van de elementen in die categorie ook in inOnderzoek opgenomen met de waarde true
    - de elementcode voor onderzoek eindigt op 0000

    Scenario: hele categorie persoon is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft de volgende 'PersoonInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 010000   |
      | datumIngangOnderzoek          | 20220307 |
      En de persoon heeft GEEN 'verblijfplaats.inOnderzoek' gegevens
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de partner met burgerservicenummer '555550002' heeft GEEN 'inOnderzoek' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                             |
      | type                | RaadpleegMetBurgerservicenummer                                    |
      | burgerservicenummer | 555550001                                                          |
      | fields              | burgerservicenummer,naam,geboorte,geslacht,verblijfplaats,partners |
      Dan heeft de persoon met burgerservicenummer '555550001' alleen de volgende 'persoonInOnderzoek' gegevens
      | naam                             | waarde     |
      | burgerservicenummer              | true       |
      | leeftijd                         | true       |
      | geslacht                         | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon met burgerservicenummer '555550001' de volgende 'naam.inOnderzoek' gegevens
      | naam                             | waarde     |
      | voornamen                        | true       |
      | adellijkeTitelPredicaat          | true       |
      | voorvoegsel                      | true       |
      | geslachtsnaam                    | true       |
      | aanduidingNaamgebruik            | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon met burgerservicenummer '555550001' de volgende 'geboorte.inOnderzoek' gegevens
      | naam                             | waarde     |
      | datum                            | true       |
      | plaats                           | true       |
      | land                             | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon met burgerservicenummer '555550001' GEEN 'verblijfplaats.inOnderzoek' gegevens
      En heeft de partner met burgerservicenummer '555550002' GEEN 'inOnderzoek' gegevens
      En heeft de partner met burgerservicenummer '555550002' GEEN 'naam.inOnderzoek' gegevens
      En heeft de partner met burgerservicenummer '555550002' GEEN 'geboorte.inOnderzoek' gegevens

    Scenario: hele categorie kind is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft GEEN 'persoonInOnderzoek' gegevens
      En de persoon heeft een kind met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En het kind met burgerservicenummer '555550002' heeft de volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 090000   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                           |
      | type                | RaadpleegMetBurgerservicenummer                                                  |
      | burgerservicenummer | 555550001                                                                        |
      | fields              | burgerservicenummer,kinderen.burgerservicenummer,kinderen.naam,kinderen.geboorte |
      Dan heeft het kind met burgerservicenummer '555550002' de volgende 'inOnderzoek' gegevens
      | naam                             | waarde     |
      | burgerservicenummer              | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft het kind met burgerservicenummer '555550002' de volgende 'naam.inOnderzoek' gegevens
      | naam                       | waarde     |
      | voornamen                  | true       |
      | adellijkeTitelPredicaat    | true       |
      | voorvoegsel                | true       |
      | geslachtsnaam              | true       |
      | datumIngangOnderzoek.datum | 2022-03-07 |
      | datumIngangOnderzoek.type  | Datum      |
      En heeft het kind met burgerservicenummer '555550002' de volgende 'geboorte.inOnderzoek' gegevens
      | naam                             | waarde     |
      | datum                            | true       |
      | plaats                           | true       |
      | land                             | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon met burgerservicenummer '555550001' GEEN 'persoonInOnderzoek' gegevens
      En heeft de persoon met burgerservicenummer '555550001' GEEN 'naam.inOnderzoek' gegevens
      En heeft de persoon met burgerservicenummer '555550001' GEEN 'geboorte.inOnderzoek' gegevens

    Scenario: hele categorie verblijfplaats van een adres is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft GEEN 'persoonInOnderzoek' gegevens
      En persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats' gegevens
      | naam       | waarde |
      | straat     | spui   |
      | huisnummer | 70     |
      En persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 080000   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                             | waarde     |
      | aanduidingBijHuisnummer          | true       |
      | datumIngangGeldigheid            | true       |
      | datumVestigingInNederland        | true       |
      | functieAdres                     | true       |
      | huisletter                       | true       |
      | huisnummer                       | true       |
      | huisnummertoevoeging             | true       |
      | nummeraanduidingIdentificatie    | true       |
      | adresseerbaarObjectIdentificatie | true       |
      | landVanwaarIngeschreven          | true       |
      | straat                           | true       |
      | postcode                         | true       |
      | korteNaam                        | true       |
      | woonplaats                       | true       |
      | datumIngangOnderzoek.datum       | 2022-03-07 |
      | datumIngangOnderzoek.type        | Datum      |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |


    Scenario: hele categorie verblijfplaats van een locatiebeschrijving is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft GEEN 'persoonInOnderzoek' gegevens
      En persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats' gegevens
      | naam                | waarde                     |
      | locatiebeschrijving | Woonboot in de Grote Sloot |
      En persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 080000   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft het kind met burgerservicenummer '555550002' de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                             | waarde       |
      | datumVestigingInNederland        | true         |
      | functieAdres                     | true         |
      | landVanwaarIngeschreven          | true         |
      | locatiebeschrijving              | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |

    Scenario: hele categorie verblijfplaats van een verblijfplaats buitenland is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft GEEN 'persoonInOnderzoek' gegevens
      En persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats' gegevens
      | naam        | waarde          |
      | land        | 5010            |
      | adresregel1 | Rue du pomme 25 |
      | adresregel2 | Bruxelles       |
      En persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 080000   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft het kind met burgerservicenummer '555550002' de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                             | waarde       |
      | adresregel1                      | true         |
      | adresregel2                      | true         |
      | adresregel3                      | true         |
      | land                             | true         |
      | datumIngangGeldigheid            | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |

  @proxy
  Rule: een afgeleid gegeven wordt in inOnderzoek opgenomen wanneer ten minste één van de gegevens waaruit het wordt afgeleid in onderzoek staat

    @proxy
    Abstract Scenario: leeftijd van de persoon in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft volgende 'persoonInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | leeftijd                        |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende 'persoonInOnderzoek' gegevens
      | naam                                    | waarde     |
      | leeftijd                                | true       |
      | datumIngangOnderzoekPersoon.datum       | 2022-03-07 |
      | datumIngangOnderzoekPersoon.type        | Datum      |
      | datumIngangOnderzoekPersoon.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | reden                        | waarde |
      | geboortedatum van de persoon | 010310 |
      | groep geboorte               | 010300 |
      | categorie persoon            | 010000 |

    @proxy
    Abstract Scenario: indicatieOverleden van de persoon in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft volgende 'overlijden' gegevens
      | naam  | waarde   |
      | datum | 20220218 |
      En de persoon heeft volgende 'overlijden.inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | overlijden.indicatieOverleden   |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende 'overlijden.inOnderzoek' gegevens
      | naam                             | waarde       |
      | indicatieOverleden               | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | reden                | waarde |
      | datum overlijden     | 060810 |
      | groep overlijden     | 060800 |
      | categorie overlijden | 060000 |

    @proxy
    Abstract Scenario: voorletters van een ouder in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een ouder met de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 1      |
      En de persoon heeft een ouder met de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 2      |
      En de ouder met ouderAanduiding '<ouder>' heeft de volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      En de ouder met ouderAanduiding '<andere ouder>' heeft GEEN 'inOnderzoek' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 555550001                                      |
      | fields              | ouders.ouderAanduiding,ouders.naam.voorletters |
      Dan heeft de ouder met ouderAanduiding '<ouder>' de volgende 'naam.inOnderzoek' gegevens
      | naam                             | waarde       |
      | voorletters                      | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de ouder met ouderAanduiding '<andere ouder>' GEEN 'naam.inOnderzoek' gegevens
      En heeft de ouder met ouderAanduiding '<ouder>' GEEN 'inOnderzoek' gegevens
      En heeft de ouder met ouderAanduiding '<andere ouder>' GEEN 'inOnderzoek' gegevens

      Voorbeelden:
      | gegeven in onderzoek   | waarde | ouder  | andere ouder |
      | voornamen van ouder 1  | 020210 | 1      | 2            |
      | groep naam van ouder 1 | 020200 | 1      | 2            |
      | categorie ouder 1      | 020000 | 1      | 2            |
      | voornamen van ouder 2  | 030210 | 2      | 1            |
      | groep naam van ouder 2 | 030200 | 2      | 1            |
      | categorie ouder 2      | 030000 | 2      | 1            |

    @proxy
    Abstract Scenario: verblijfplaats datumVan in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                | waarde                        |
      | datumAanvangAdreshouding (10.30)    | <datumAanvangAdreshouding>    |
      | straat (11.10)                      | <straat>                      |
      | huisnummer (11.20)                  | <huisnummer>                  |
      | locatiebeschrijving (12.10)         | <locatiebeschrijving>         |
      | land (13.10)                        | <land>                        |
      | datumAanvangAdresBuitenland (13.20) | <datumAanvangAdresBuitenland> |
      | adresregel1 (13.30)                 | <adresregel1>                 |
      | adresregel2 (13.40)                 | <adresregel2>                 |
      En de persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft persoon met burgerservicenummer '555550001' de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                             | waarde       |
      | datumVan                         | true         |
      | datumIngangOnderzoek.datum       | 2022-03-07   |
      | datumIngangOnderzoek.type        | Datum        |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | gegeven in onderzoek        | waarde | straat | huisnummer | locatiebeschrijving        | datumAanvangAdreshouding | adresregel1     | adresregel2 | land | datumAanvangAdresBuitenland |
      | datumAanvangAdreshouding    | 081030 | Spui   | 70         |                            | 20040701                 |                 |             |      |                             |
      | groep adreshouding          | 081000 | Spui   | 70         |                            | 20040701                 |                 |             |      |                             |
      | categorie verblijfplaats    | 081000 | Spui   | 70         |                            | 20040701                 |                 |             |      |                             |
      | datumAanvangAdreshouding    | 081030 |        |            | Woonboot in de Grote Sloot | 20040701                 |                 |             |      |                             |
      | datumAanvangAdresBuitenland | 081320 |        |            |                            |                          | Rue du pomme 25 | Bruxelles   | 5010 | 20040701                    |
      | verblijf buitenland         | 081320 |        |            |                            |                          | Rue du pomme 25 | Bruxelles   | 5010 | 20040701                    |
      | datumAanvangAdresBuitenland | 081320 |        |            |                            |                          |                 |             | 0000 | 20040701                    |

    @proxy
    Scenario: indicatieVestigingVanuitBuitenland in onderzoek omdat landVanWaarIngeschreven is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 081410   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 555550001                              |
      | fields              | verblijfplaats.indicatieVestigingVanuitBuitenland |
      Dan heeft persoon met burgerservicenummer '555550001' de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                                    | waarde       |
      | indicatieVestigingVanuitBuitenland      | true         |
      | datumIngangOnderzoek.datum              | 2022-03-07   |
      | datumIngangOnderzoek.type               | Datum        |
      | datumIngangOnderzoekPersson.langFormaat | 7 maart 2022 |

    @proxy
    Abstract Scenario: verblijfplaats adresregel1, adresregel2 en woonplaats in onderzoek bij <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon met burgerservicenummer '555550001' heeft de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                              |
      | type                | RaadpleegMetBurgerservicenummer                     |
      | burgerservicenummer | 555550001                                           |
      | fields              | adresregel1,adresregel2,straat,korteNaam,woonplaats |
      Dan heeft persoon met burgerservicenummer '555550001' de volgende 'verblijfplaats.inOnderzoek' gegevens
      | naam                             | waarde        |
      | adresregel1                      | <adresregel1> |
      | adresregel2                      | <adresregel2> |
      | korteNaam                        | <korteNaam>   |
      | straat                           | <straat>      |
      | woonplaats                       | <woonplaats>  |
      | datumIngangOnderzoek.datum       | 2022-03-07    |
      | datumIngangOnderzoek.type        | Datum         |
      | datumIngangOnderzoek.langFormaat | 7 maart 2022  |

      #hier betekent leeg dat het inOnderzoek gegeven niet is opgenomen in het antwoord
      Voorbeelden:
      | gegeven in onderzoek      | waarde | adresregel1 | adresregel2 | korteNaam | straat | woonplaats |
      | gemeenteVanInschrijving   | 080910 |             | true        |           |        | true       |
      | straat                    | 081110 | true        |             | true      | true   |            |
      | naamOpenbareRuimte        | 081115 |             |             |           | true   |            |
      | huisnummer                | 081120 | true        |             |           |        |            |
      | woonplaats                | 081170 |             | true        |           |        |            |
      | locatiebeschrijving       | 081210 | true        |             |           |        |            |
      | adresregel1               | 081330 | true        |             |           |        |            |
      | groep gemeente            | 080900 |             | true        |           |        | true       |
      | groep adres               | 081100 | true        | true        | true      | true   | true       |
      | groep locatiebeschrijving | 081200 | true        |             |           |        |            |
      | groep verblijf buitenland | 081300 | true        | true        |           |        |            |
      | categorie verblijfplaats  | 080000 | true        | true        | true      | true   | true       |

    @proxy
    Abstract Scenario: nationaliteit <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam                                     | waarde                                |
      | nationaliteit (05.10)                    | <nationaliteit>                       |
      | bijzonder Nederlanderschap (65.10)       | <aanduidingBijzonderNederlanderschap> |
      | ingangsdatum geldigheid (85.10)          | <datumIngangGeldigheid>               |
      | aanduiding gegevens in onderzoek (83.10) | <waarde>                              |
      | datum ingang onderzoek (83.20)           | 20220307                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | nationaliteiten.inOnderzoek     |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                                         | waarde                       |
      | type                                         | <nationaliteit type>         |
      | inOnderzoek.type                             | <type in onderzoek>          |
      | inOnderzoek.nationaliteit                    | <nationaliteit in onderzoek> |
      | inOnderzoek.redenOpname                      | <redenOpname in onderzoek>   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07                   |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022                 |

      Voorbeelden:
      | gegeven in onderzoek                                    | nationaliteit | aanduidingBijzonderNederlanderschap | nationaliteit type         | datumIngangGeldigheid | waarde | type in onderzoek | nationaliteit in onderzoek | redenOpname in onderzoek |
      | hele categorie nationaliteit                            | 0052          |                                     | Nationaliteit              | 19560317              | 040000 | true              | true                       | true                     |
      | hele categorie bij onbekende nationaliteit              | 0000          |                                     | NationaliteitOnbekend      | 00000000              | 040000 | true              |                            | true                     |
      | hele categorie bij vastgesteld niet-Nederlander         |               | V                                   | VastgesteldNietNederlander | 19710417              | 040000 | true              |                            | true                     |
      | hele categorie bij behandeld als Nederlander            |               | B                                   | BehandeldAlsNederlander    | 19520831              | 040000 | true              |                            | true                     |
      | nationaliteit                                           | 0052          |                                     | Nationaliteit              | 19560317              | 040510 | true              | true                       |                          |
      | onbekende nationaliteit                                 | 0000          |                                     | NationaliteitOnbekend      | 19560317              | 040510 | true              |                            |                          |
      | reden opname                                            | 0052          |                                     | Nationaliteit              | 19560317              | 046310 |                   |                            | true                     |
      | bijzonder Nederlanderschap vastgesteld niet-Nederlander |               | V                                   | VastgesteldNietNederlander | 19710417              | 046510 | true              |                            |                          |
      | bijzonder Nederlanderschap behandeld als Nederlander    |               | B                                   | BehandeldAlsNederlander    | 19710417              | 046510 | true              |                            |                          |

  @proxy
  Rule: onderzoek van een partnergegeven leidt alleen tot inOnderzoek van een samengesteld naamgegeven wanneer daarin de partnernaam wordt gebruikt
    - naam.aanduidingNaamgebruik is ongelijk aan 'E'
    - een of meerdere van de partner naamgegevens voorvoegsel, adellijkeTitelPredicaat of geslachtsnaam zijn in onderzoek
    - betreft aanhef, aanschrijfwijze en gebruikInLopendeTekst

    @proxy
    Abstract Scenario: samengestelde namen bij <omschrijving>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon met burgerservicenummer '555550001' heeft de volgende 'naam' gegevens
      | naam                          | waarde                  |
      | voornamen (02.10)             | Piet                    |
      | geslachtsnaam (02.40)         | Groenen                 |
      | aanduidingNaamgebruik (61.10) | <aanduidingNaamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de partner met burgerservicenummer '555550002' heeft volgende 'inOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 050200   |
      | datumIngangOnderzoek          | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                      |
      | type                | RaadpleegMetBurgerservicenummer                             |
      | burgerservicenummer | 555550001                                                   |
      | fields              | naam.aanhef,naam.aanschrijfwijze,naam.gebruikInLopendeTekst |
      Dan heeft persoon met burgerservicenummer '555550001' <in onderzoek> 'naam.inOnderzoek' gegevens

      Voorbeelden:
      | omschrijving                                            | waarde | aanduidingNaamgebruik | in onderzoek |
      | partner in onderzoek en gebruik eigen naam              | 050000 | E                     | GEEN         |
      | partner in onderzoek en gebruik partner naam            | 050000 | P                     | WEL          |
      | partner in onderzoek en gebruik partner na eigen naam   | 050000 | N                     | WEL          |
      | partner in onderzoek en gebruik partner voor eigen naam | 050000 | V                     | WEL          |
      | groep naam van partner in onderzoek                     | 050200 | P                     | WEL          |
      | voornamen in onderzoek                                  | 050210 | P                     | GEEN         |
      | adellijkeTitelPredicaat in onderzoek                    | 050220 | P                     | WEL          |
      | voorvoegsel in onderzoek                                | 050230 | P                     | WEL          |
      | geslachtsnaam in onderzoek                              | 050240 | P                     | WEL          |
      | aangaanHuwelijkPartnerschap in onderzoek                | 050600 | P                     | GEEN         |
