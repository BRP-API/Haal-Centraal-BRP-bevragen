# language: nl

@proxy @post-assert
Functionaliteit: in onderzoek
  Wanneer de juistheid van een gegeven onderzocht wordt, en daardoor de waarde van een geleverd gegeven mogelijk onjuist is, wordt naast het betreffende veld ook in inOnderzoek een veld met dezelfde naam opgenomen. Deze krijgt dan de boolean waarde true.

  Een categorie kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele groepen of elementen binnen de categorie in onderzoek zijn.

  Een veld dat niet in onderzoek is, wordt niet in inOnderzoek opgenomen, ook niet met de waarde false of null.

  Een overzicht van de vertaling van een inOnderzoek elementwaarde (gegeven 83.10) naar welke velden in inOnderzoek moeten worden opgenomen (met de waarde true) staat in /features/in onderzoek.xlsx.

  Ook wanneer een gegeven geen waarde heeft en daardoor niet in het antwoord opgenomen wordt kan het in onderzoek zijn. In dat geval wordt alleen in inOnderzoek een veld opgenomen met die naam en de waarde true.

  @gba
  Rule: wanneer een gegeven uit een categorie gevraagd is en er zit onderzoek op die categorie, dan wordt ook inOnderzoek geleverd
    - het gaat om groep 83 in de categorie
    - deze wordt geleverd wanneer in het antwoord ten minste één gegeven uit de categorie is gevraagd met fields
    - deze wordt ook geleverd wanneer het gevraagde gegeven geen waarde heeft en daarom niet geleverd is in het antwoord

    @gba
    Abstract Scenario: vragen om <fields> bij <in onderzoek> in onderzoek
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende persoonsgegevens in de registratie
      | categorie | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 1         | 555550001                   | Arnitta           |                     | 19231213              | <waarde>                        | 20120920                       |                               |
      En de persoon met burgerservicenummer 555550001 heeft de volgende oudergegevens in de registratie
      | Categorie | Voornamen (02.10) | Geslachtsaanduiding (04.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 2         | Noa               | V                           |                                 |                                |                               |
      | 3         | Jan               | M                           |                                 |                                |                               |
      En de persoon met burgerservicenummer 555550001 heeft de volgende partnergegevens in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 5         | 555550002                   | Karel     | M                           | 20091102              |                          |                                 |                                |                               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | ouders,partners,<fields>        |
      Dan heeft de persoon de volgende 'persoonInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | <waarde> |
      | datumIngangOnderzoek          | 20120920 |
      En heeft de persoon GEEN 'naam.inOnderzoek' gegevens
      En heeft de persoon GEEN 'geboorte.inOnderzoek' gegevens
      En heeft de persoon GEEN 'verblijfplaats' gegevens
      En heeft de ouder met ouderAanduiding '1' GEEN 'inOnderzoek' gegevens
      En heeft de ouder met ouderAanduiding '2' GEEN 'inOnderzoek' gegevens
      En heeft de partner met burgerservicenummer '555550002' GEEN 'inOnderzoek' gegevens

      Voorbeelden:
      | in onderzoek           | waarde | fields      |
      | hele categorie persoon | 010000 | naam        |
      | groep naam             | 010200 | voorvoegsel |
      | geboortedatum          | 010310 | naam        |

    @gba
    Scenario: persoon heeft gezagInOnderzoek en persoonInOnderzoek
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende persoonsgegevens in de registratie
      | categorie | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 1         | 555550001                   | Arnitta           |                     | 19231213              | 010410                          | 20120920                       |                               |
      En de persoon met burgerservicenummer 555550001 heeft de volgende gezagsverhoudinggegevens in de registratie
      | Categorie | indicatie curatele (33.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 11        | 1                          | 113310                          | 20101205                       |                               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | geslacht,indicatieCurateleRegister |
      Dan heeft de persoon de volgende 'persoonInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 010410   |
      | datumIngangOnderzoek          | 20120920 |
      En heeft de persoon de volgende 'gezagInOnderzoek' gegevens
      | naam                          | waarde   |
      | aanduidingGegevensInOnderzoek | 113310   |
      | datumIngangOnderzoek          | 20101205 |


    @gba
    Scenario: persoon in onderzoek maar niet vragen om gegevens uit categorie persoon
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende persoonsgegevens in de registratie
      | categorie | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 1         | 555550001                   | Arnitta           |                     | 19231213              | 010000                          | 20120920                       |                               |
      En de persoon met burgerservicenummer 555550001 heeft de volgende oudergegevens in de registratie
      | Categorie | Voornamen (02.10) | Geslachtsaanduiding (04.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 2         | Noa               | V                           |                                 |                                |                               |
      | 3         | Jan               | M                           |                                 |                                |                               |
      En de persoon met burgerservicenummer 555550001 heeft de volgende partnergegevens in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 5         | 555550002                   | Karel     | M                           | 20091102              |                          |                                 |                                |                               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | ouders,partners                 |
      Dan heeft de persoon GEEN 'persoonInOnderzoek' gegevens
      En heeft de ouder met ouderAanduiding '1' GEEN 'inOnderzoek' gegevens
      En heeft de ouder met ouderAanduiding '2' GEEN 'inOnderzoek' gegevens
      En heeft de partner met burgerservicenummer '555550002' GEEN 'inOnderzoek' gegevens

  @gba
  Rule: in onderzoek wordt niet opgenomen wanneer het onderzoek beëindigd is
    - Datum einde onderzoek (83.30) heeft een waarde

    @gba
    Scenario: onderzoek is beëindigd
      Gegeven de persoon met burgerservicenummer 999994888 heeft de volgende persoonsgegevens in de registratie
      | categorie | burgerservicenummer (01.20) | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 1         | 999994888                   | Arnitta           | 19231213              | 010000                          | 20120920                       | 20120922                      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                            |
      | type                | RaadpleegMetBurgerservicenummer                   |
      | burgerservicenummer | 999994888                                         |
      | fields              | burgerservicenummer,naam.voornamen,geboorte.datum |
      Dan heeft de persoon met burgerservicenummer '555550001' GEEN 'persoonInOnderzoek' gegevens
      En heeft de persoon met burgerservicenummer '999994888' GEEN 'naam.inOnderzoek' gegevens
      En heeft de persoon met burgerservicenummer '999994888' GEEN 'geboorte.inOnderzoek' gegevens


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
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam                                     | waarde   |
      | aanduiding gegevens in onderzoek (83.10) | 047310   |
      | datum ingang onderzoek (83.20)           | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam | waarde                |
      | type | NationaliteitOnbekend |

    @proxy
    Abstract Scenario: persoon heeft <gegeven in onderzoek> in onderzoek dat niet is gevraagd met fields
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde    |
      | burgerservicenummer                         | 555550001 |
      | aanduiding gegevens in onderzoek (01.83.10) | <waarde>  |
      | datum ingang onderzoek (01.83.20)           | 20220307  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <fields>                        |
      Dan heeft de response een leeg persoon object

      Voorbeelden:
      | waarde | gegeven in onderzoek   | fields                      |
      | 010000 | hele categorie persoon | kinderen                    |
      | 010200 | hele groep naam        | geslacht,geboorte.datum     |
      | 010210 | voornamen              | geboorte,naam.geslachtsnaam |

  @proxy
  Rule: wanneer een element in de bron in onderzoek is, wordt het gegeven in het antwoord dat daaruit gevuld wordt ook in inOnderzoek opgenomen met de waarde true

    Abstract Scenario: persoon heeft <veld> in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde                |
      | burgerservicenummer                         | 555550001             |
      | aanduiding gegevens in onderzoek (01.83.10) | <in onderzoek waarde> |
      | datum ingang onderzoek (01.83.20)           | 20220307              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <veld>                          |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                | waarde       |
      | <veld>                                              | <waarde>     |
      | inOnderzoek.<veld>                                  | true         |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | in onderzoek waarde | veld                | waarde    |
      | 010120              | burgerservicenummer | 555550001 |
      | 010410              | geslacht            |           |

    Abstract Scenario: persoon heeft <groep> <veld> in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde    |
      | burgerservicenummer                         | 555550001 |
      | aanduiding gegevens in onderzoek (01.83.10) | <waarde>  |
      | datum ingang onderzoek (01.83.20)           | 20220307  |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                   | waarde |
      | geboorteplaats (03.20) | 0344   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.<veld>                  |
      Dan heeft de response een persoon met de volgende '<groep>' gegevens
      | naam                                         | waarde       |
      | inOnderzoek.<veld>                           | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | veld                    | groep    |
      | 010220 | adellijkeTitelPredicaat | naam     |
      | 016110 | aanduidingNaamgebruik   | naam     |
      | 010310 | datum                   | geboorte |

    Abstract Scenario: persoon heeft <veld> van verblijfplaats in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde   |
      | straatnaam (11.10)                       | straat   |
      | aanduiding gegevens in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)           | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 555550001                           |
      | fields              | verblijfplaats.verblijfadres.<veld> |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde       |
      | type                                                       | Adres        |
      | verblijfadres.inOnderzoek.<veld>                           | true         |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | veld                    |
      | 081120 | huisnummer              |
      | 081130 | huisletter              |
      | 081140 | huisnummertoevoeging    |
      | 081150 | aanduidingBijHuisnummer |
      | 081160 | postcode                |
      | 081170 | woonplaats              |

    Abstract Scenario: persoon heeft <veld> van verblijfplaats in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde              |
      | locatiebeschrijving (12.10)              | locatiebeschrijving |
      | aanduiding gegevens in onderzoek (83.10) | <waarde>            |
      | datum ingang onderzoek (83.20)           | 20220307            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 555550001                           |
      | fields              | verblijfplaats.verblijfadres.<veld> |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde              |
      | type                                                       | Locatie             |
      | verblijfadres.locatiebeschrijving                          | locatiebeschrijving |
      | verblijfadres.inOnderzoek.<veld>                           | true                |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07          |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum               |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022        |

      Voorbeelden:
      | waarde | veld                |
      | 081210 | locatiebeschrijving |

    Abstract Scenario: persoon heeft <veld> van verblijfplaats in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde                |
      | land adres buitenland (13.10)            | 1234                  |
      | aanduiding gegevens in onderzoek (83.10) | <in onderzoek waarde> |
      | datum ingang onderzoek (83.20)           | 20220307              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 555550001                           |
      | fields              | verblijfplaats.verblijfadres.<veld> |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde                   |
      | type                                                       | VerblijfplaatsBuitenland |
      | verblijfadres.<veld>.code                                  | <waarde>                 |
      | verblijfadres.inOnderzoek.<veld>                           | true                     |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07               |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022             |

      Voorbeelden:
      | in onderzoek waarde | veld   | waarde |
      | 081310              | land   | 1234   |
      | 081350              | regel3 |        |

    Scenario: persoon heeft aanduiding van verblijfstitel in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfstitel' gegevens
      | naam                                     | waarde   |
      | aanduiding gegevens in onderzoek (83.10) | 103910   |
      | datum ingang onderzoek (83.20)           | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfstitel.aanduiding       |
      Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
      | naam                                         | waarde       |
      | inOnderzoek.aanduiding                       | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

    Abstract Scenario: persoon heeft <veld> van ouder in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'ouder' met de volgende gegevens
      | naam                                     | waarde   |
      | ouderAanduiding                          | <ouder>  |
      | aanduiding gegevens in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)           | 20220307 |
      En de persoon heeft een 'ouder' met alleen de volgende gegevens
      | naam            | waarde         |
      | ouderAanduiding | <andere ouder> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | ouders                          |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                                         | waarde       |
      | ouderAanduiding                              | <ouder>      |
      | inOnderzoek.<veld>                           | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam            | waarde         |
      | ouderAanduiding | <andere ouder> |

      Voorbeelden:
      | waarde | veld                                    | ouder | andere ouder |
      | 020120 | burgerservicenummer                     | 1     | 2            |
      | 030410 | geslacht                                | 2     | 1            |
      | 026210 | datumIngangFamilierechtelijkeBetrekking | 1     | 2            |

    Abstract Scenario: persoon heeft <groep> <veld> van partner in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde    |
      | burgerservicenummer                      | 555550002 |
      | aanduiding gegevens in onderzoek (83.10) | <waarde>  |
      | datum ingang onderzoek (83.20)           | 20220307  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En de 'partner' heeft de volgende 'geboorte' gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 19660404 |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20100910 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | partners.<groep>.inOnderzoek    |
      Dan heeft de response een persoon met een 'partner' met de volgende '<groep>' gegevens
      | naam                                         | waarde       |
      | inOnderzoek.<veld>                           | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | veld          | groep                       |
      | 050240 | geslachtsnaam | naam                        |
      | 050320 | plaats        | geboorte                    |
      | 050610 | datum         | aangaanHuwelijkPartnerschap |

      Scenario: persoon heeft gegevens geslacht, gemeenteVanInschrijving en indicatieCurateleRegister in onderzoek
        Gegeven het systeem heeft een persoon met de volgende gegevens
        | naam                                        | waarde    |
        | burgerservicenummer                         | 555550001 |
        | aanduiding gegevens in onderzoek (01.83.10) | 010410    |
        | datum ingang onderzoek (01.83.20)           | 20220307  |
        | aanduiding gegevens in onderzoek (11.83.10) | 113310    |
        | datum ingang onderzoek (11.83.20)           | 20101205  |
        En de persoon heeft de volgende 'verblijfplaats' gegevens
        | naam                                     | waarde   |
        | aanduiding gegevens in onderzoek (83.10) | 080910   |
        | datum ingang onderzoek (83.20)           | 20030405 |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                                                     |
        | type                | RaadpleegMetBurgerservicenummer                            |
        | burgerservicenummer | 555550001                                                  |
        | fields              | geslacht,indicatieCurateleRegister,gemeenteVanInschrijving |
        Dan heeft de response een persoon met de volgende gegevens
        | naam                                                 | waarde          |
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


  @proxy
  Rule: wanneer een groep in de bron in onderzoek is, wordt elk gegeven in het antwoord dat gevuld wordt uit een van de elementen in die groep ook in inOnderzoek opgenomen met de waarde true
    - de elementcode voor onderzoek eindigt op 00

    Scenario: persoon heeft hele groep naam in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde    |
      | burgerservicenummer                         | 555550001 |
      | aanduiding gegevens in onderzoek (01.83.10) | 010200    |
      | datum ingang onderzoek (01.83.20)           | 20220307  |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                                              |
      | type                | RaadpleegMetBurgerservicenummer                                                                                     |
      | burgerservicenummer | 555550001                                                                                                           |
      | fields              | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,naam.aanduidingNaamgebruik,geboorte |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
      | naam                                         | waarde        |
      | geslachtsnaam                                | geslachtsnaam |
      | inOnderzoek.voornamen                        | true          |
      | inOnderzoek.adellijkeTitelPredicaat          | true          |
      | inOnderzoek.voorvoegsel                      | true          |
      | inOnderzoek.geslachtsnaam                    | true          |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07    |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum         |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022  |

    Scenario: kind heeft hele groep geboorte in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'kind' met de volgende gegevens
      | naam                                     | waarde    |
      | burgerservicenummer                      | 555550002 |
      | aanduiding gegevens in onderzoek (83.10) | 090300    |
      | datum ingang onderzoek (83.20)           | 20220307  |
      En het 'kind' heeft de volgende 'geboorte' gegevens
      | naam                   | waarde |
      | geboorteplaats (03.20) | 0599   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | kinderen.geboorte               |
      Dan heeft de response een persoon met een 'kind' met alleen de volgende 'geboorte' gegevens
      | naam                                         | waarde       |
      | plaats.code                                  | 0599         |
      | inOnderzoek.datum                            | true         |
      | inOnderzoek.plaats                           | true         |
      | inOnderzoek.land                             | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

    Abstract Scenario: partner heeft <nauwkeurigheid> soort verbintenis in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde   |
      | aanduiding gegevens in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)           | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | partners                        |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
      | naam                                         | waarde       |
      | inOnderzoek.soortVerbintenis                 | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | waarde | nauwkeurigheid |
      | 051500 | groep          |
      | 051510 | element        |

  @proxy
  Rule: wanneer een categorie in de bron in onderzoek is, wordt elk gegeven in het antwoord dat gevuld wordt uit een van de elementen in die categorie ook in inOnderzoek opgenomen met de waarde true
    - de elementcode voor onderzoek eindigt op 0000

    Scenario: hele categorie persoon is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde    |
      | burgerservicenummer                         | 555550001 |
      | aanduiding gegevens in onderzoek (01.83.10) | 010000    |
      | datum ingang onderzoek (01.83.20)           | 20220307  |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                   | waarde |
      | geboorteplaats (03.20) | 0518   |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam               | waarde |
      | straatnaam (11.10) | straat |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                      |
      | type                | RaadpleegMetBurgerservicenummer                                             |
      | burgerservicenummer | 555550001                                                                   |
      | fields              | burgerservicenummer,naam,geboorte,geslacht,leeftijd,verblijfplaats,partners |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                | waarde       |
      | burgerservicenummer                                 | 555550001    |
      | inOnderzoek.burgerservicenummer                     | true         |
      | inOnderzoek.leeftijd                                | true         |
      | inOnderzoek.geslacht                                | true         |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 7 maart 2022 |
      En heeft de persoon de volgende 'naam' gegevens
      | naam                                         | waarde        |
      | geslachtsnaam                                | geslachtsnaam |
      | volledigeNaam                                | geslachtsnaam |
      | inOnderzoek.voornamen                        | true          |
      | inOnderzoek.adellijkeTitelPredicaat          | true          |
      | inOnderzoek.voorvoegsel                      | true          |
      | inOnderzoek.geslachtsnaam                    | true          |
      | inOnderzoek.aanduidingNaamgebruik            | true          |
      | inOnderzoek.voorletters                      | true          |
      | inOnderzoek.volledigeNaam                    | true          |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07    |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum         |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022  |
      En heeft de persoon de volgende 'geboorte' gegevens
      | naam                                         | waarde       |
      | plaats.code                                  | 0518         |
      | inOnderzoek.datum                            | true         |
      | inOnderzoek.plaats                           | true         |
      | inOnderzoek.land                             | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                    | waarde |
      | type                    | Adres  |
      | verblijfadres.straat    | straat |
      | verblijfadres.korteNaam | straat |
      En heeft de persoon een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |

    Scenario: hele categorie kind is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'kind' met de volgende gegevens
      | naam                                     | waarde    |
      | burgerservicenummer                      | 555550002 |
      | aanduiding gegevens in onderzoek (83.10) | 090000    |
      | datum ingang onderzoek (83.20)           | 20220307  |
      En het 'kind' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En het 'kind' heeft de volgende 'geboorte' gegevens
      | naam                   | waarde |
      | geboorteplaats (03.20) | 0599   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                           |
      | type                | RaadpleegMetBurgerservicenummer                                                  |
      | burgerservicenummer | 555550001                                                                        |
      | fields              | burgerservicenummer,kinderen.burgerservicenummer,kinderen.naam,kinderen.geboorte |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En heeft de persoon een 'kind' met de volgende gegevens
      | naam                                         | waarde       |
      | burgerservicenummer                          | 555550002    |
      | inOnderzoek.burgerservicenummer              | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft het 'kind' de volgende 'naam' gegevens
      | naam                                         | waarde        |
      | geslachtsnaam                                | geslachtsnaam |
      | inOnderzoek.voornamen                        | true          |
      | inOnderzoek.adellijkeTitelPredicaat          | true          |
      | inOnderzoek.voorvoegsel                      | true          |
      | inOnderzoek.geslachtsnaam                    | true          |
      | inOnderzoek.voorletters                      | true          |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07    |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum         |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022  |
      En heeft het 'kind' de volgende 'geboorte' gegevens
      | naam                                         | waarde       |
      | plaats.code                                  | 0599         |
      | inOnderzoek.datum                            | true         |
      | inOnderzoek.plaats                           | true         |
      | inOnderzoek.land                             | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

    Scenario: hele categorie verblijfplaats van een adres is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde   |
      | straat                                   | spui     |
      | huisnummer                               | 70       |
      | aanduiding gegevens in onderzoek (83.10) | 080000   |
      | datum ingang onderzoek (83.20)           | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde       |
      | type                                                       | Adres        |
      | inOnderzoek.adresseerbaarObjectIdentificatie               | true         |
      | inOnderzoek.datumIngangGeldigheid                          | true         |
      | inOnderzoek.datumVan                                       | true         |
      | inOnderzoek.functieAdres                                   | true         |
      | inOnderzoek.nummeraanduidingIdentificatie                  | true         |
      | verblijfadres.huisnummer                                   | 70           |
      | verblijfadres.korteNaam                                    | spui         |
      | verblijfadres.straat                                       | spui         |
      | verblijfadres.inOnderzoek.aanduidingBijHuisnummer          | true         |
      | verblijfadres.inOnderzoek.huisletter                       | true         |
      | verblijfadres.inOnderzoek.huisnummer                       | true         |
      | verblijfadres.inOnderzoek.huisnummertoevoeging             | true         |
      | verblijfadres.inOnderzoek.korteNaam                        | true         |
      | verblijfadres.inOnderzoek.postcode                         | true         |
      | verblijfadres.inOnderzoek.straat                           | true         |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      | verblijfadres.inOnderzoek.woonplaats                       | true         |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022 |


    Scenario: hele categorie verblijfplaats van een locatiebeschrijving is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde                     |
      | locatiebeschrijving                      | Woonboot in de Grote Sloot |
      | aanduiding gegevens in onderzoek (83.10) | 080000                     |
      | datum ingang onderzoek (83.20)           | 20220307                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde                     |
      | type                                                       | Locatie                    |
      | inOnderzoek.datumVan                                       | true                       |
      | inOnderzoek.datumIngangGeldigheid                          | true                       |
      | inOnderzoek.functieAdres                                   | true                       |
      | verblijfadres.locatiebeschrijving                          | Woonboot in de Grote Sloot |
      | verblijfadres.inOnderzoek.locatiebeschrijving              | true                       |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07                 |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                      |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022               |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07                 |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum                      |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022               |

    Scenario: hele categorie verblijfplaats van een verblijfplaats buitenland is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde          |
      | land adres buitenland (13.10)            | 5010            |
      | regel 1 adres buitenland (13.30)         | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40)         | Bruxelles       |
      | aanduiding gegevens in onderzoek (83.10) | 080000          |
      | datum ingang onderzoek (83.20)           | 20220307        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde                   |
      | type                                                       | VerblijfplaatsBuitenland |
      | inOnderzoek.datumVan                                       | true                     |
      | inOnderzoek.datumIngangGeldigheid                          | true                     |
      | verblijfadres.regel1                                       | Rue du pomme 25          |
      | verblijfadres.regel2                                       | Bruxelles                |
      | verblijfadres.land.code                                    | 5010                     |
      | verblijfadres.inOnderzoek.regel1                           | true                     |
      | verblijfadres.inOnderzoek.regel2                           | true                     |
      | verblijfadres.inOnderzoek.regel3                           | true                     |
      | verblijfadres.inOnderzoek.land                             | true                     |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07               |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022             |
      | inOnderzoek.datumIngangOnderzoek.datum                     | 2022-03-07               |
      | inOnderzoek.datumIngangOnderzoek.type                      | Datum                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat               | 7 maart 2022             |

  @proxy
  Rule: een afgeleid gegeven wordt in inOnderzoek opgenomen wanneer ten minste één van de gegevens waaruit het wordt afgeleid in onderzoek staat

    @proxy
    Abstract Scenario: leeftijd van de persoon in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde    |
      | burgerservicenummer                         | 555550001 |
      | aanduiding gegevens in onderzoek (01.83.10) | <waarde>  |
      | datum ingang onderzoek (01.83.20)           | 20220307  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
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

    @proxy
    Abstract Scenario: indicatieOverleden van de persoon in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                                     | waarde   |
      | datum                                    | 20220218 |
      | aanduiding gegevens in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)           | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | overlijden.indicatieOverleden   |
      Dan heeft de response een persoon met de volgende 'overlijden' gegevens
      | naam                                         | waarde       |
      | indicatieOverleden                           | true         |
      | inOnderzoek.indicatieOverleden               | true         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

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
      En de persoon heeft een 'ouder' met de volgende gegevens
      | naam                                     | waarde   |
      | ouderAanduiding                          | 1        |
      | aanduiding gegevens in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)           | 20220307 |
      En de 'ouder' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En de persoon heeft een 'ouder' met de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 2      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 555550001                                      |
      | fields              | ouders.ouderAanduiding,ouders.naam.voorletters |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                                              | waarde       |
      | ouderAanduiding                                   | 1            |
      | naam.inOnderzoek.voorletters                      | true         |
      | naam.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | naam.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | naam.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
      En heeft de persoon een 'ouder' met alleen de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 2      |

      Voorbeelden:
      | gegeven in onderzoek   | waarde | ouder | andere ouder |
      | voornamen van ouder 1  | 020210 | 1     | 2            |
      | groep naam van ouder 1 | 020200 | 1     | 2            |
      | categorie ouder 1      | 020000 | 1     | 2            |

    @proxy
    Abstract Scenario: voorletters van een ouder in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'ouder' met de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 1      |
      En de persoon heeft een 'ouder' met de volgende gegevens
      | naam                                     | waarde   |
      | ouderAanduiding                          | 2        |
      | aanduiding gegevens in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)           | 20220307 |
      En de 'ouder' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 555550001                                      |
      | fields              | ouders.ouderAanduiding,ouders.naam.voorletters |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 1      |
      En heeft de persoon een 'ouder' met alleen de volgende gegevens
      | naam                                              | waarde       |
      | ouderAanduiding                                   | 2            |
      | naam.inOnderzoek.voorletters                      | true         |
      | naam.inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
      | naam.inOnderzoek.datumIngangOnderzoek.type        | Datum        |
      | naam.inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |

      Voorbeelden:
      | gegeven in onderzoek   | waarde | ouder | andere ouder |
      | voornamen van ouder 2  | 030210 | 2     | 1            |
      | groep naam van ouder 2 | 030200 | 2     | 1            |
      | categorie ouder 2      | 030000 | 2     | 1            |

    @proxy
    Abstract Scenario: verblijfplaats datumVan in onderzoek omdat <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde                        |
      | datum aanvang adreshouding (10.30)       | <datumAanvangAdreshouding>    |
      | straat (11.10)                           | <straat>                      |
      | huisnummer (11.20)                       | <huisnummer>                  |
      | locatiebeschrijving (12.10)              | <locatiebeschrijving>         |
      | land (13.10)                             | <land>                        |
      | datum aanvang adres buitenland (13.20)   | <datumAanvangAdresBuitenland> |
      | regel 1 adres buitenland (13.30)         | <adresregel1>                 |
      | regel 2 adres buitenland (13.40)         | <adresregel2>                 |
      | aanduiding gegevens in onderzoek (83.10) | <waarde>                      |
      | datum ingang onderzoek (83.20)           | 20220307                      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
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
      | gegeven in onderzoek        | waarde | straat | huisnummer | locatiebeschrijving        | datumAanvangAdreshouding | adresregel1     | adresregel2 | land | datumAanvangAdresBuitenland | type                     |
      | datumAanvangAdreshouding    | 081030 | Spui   | 70         |                            | 20040701                 |                 |             |      |                             | Adres                    |
      | groep adreshouding          | 081000 | Spui   | 70         |                            | 20040701                 |                 |             |      |                             | Adres                    |
      | categorie verblijfplaats    | 081000 | Spui   | 70         |                            | 20040701                 |                 |             |      |                             | Adres                    |
      | datumAanvangAdreshouding    | 081030 |        |            | Woonboot in de Grote Sloot | 20040701                 |                 |             |      |                             | Locatie                  |
      | datumAanvangAdresBuitenland | 081320 |        |            |                            |                          | Rue du pomme 25 | Bruxelles   | 5010 | 20040701                    | VerblijfplaatsBuitenland |
      | verblijf buitenland         | 081320 |        |            |                            |                          | Rue du pomme 25 | Bruxelles   | 5010 | 20040701                    | VerblijfplaatsBuitenland |
      | datumAanvangAdresBuitenland | 081320 |        |            |                            |                          |                 |             | 0000 | 20040701                    | VerblijfplaatsOnbekend   |

    @proxy
    Scenario: indicatieVestigingVanuitBuitenland in onderzoek omdat landVanWaarIngeschreven is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'immigratie' gegevens
      | naam                                     | waarde   |
      | aanduiding gegevens in onderzoek (83.10) | 081410   |
      | datum ingang onderzoek (83.20)           | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                        |
      | type                | RaadpleegMetBurgerservicenummer               |
      | burgerservicenummer | 555550001                                     |
      | fields              | immigratie.indicatieVestigingVanuitBuitenland |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                                           | waarde       |
      | inOnderzoek.indicatieVestigingVanuitBuitenland | true         |
      | inOnderzoek.datumIngangOnderzoek.datum         | 2022-03-07   |
      | inOnderzoek.datumIngangOnderzoek.type          | Datum        |
      | inOnderzoek.datumIngangOnderzoek.langFormaat   | 7 maart 2022 |

    @proxy
    Abstract Scenario: verblijfplaats adresregel1, adresregel2 en woonplaats in onderzoek bij <gegeven in onderzoek> is in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde   |
      | straatnaam (11.10)                       | straat   |
      | aanduiding gegevens in onderzoek (83.10) | <waarde> |
      | datum ingang onderzoek (83.20)           | 20220307 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                              |
      | type                | RaadpleegMetBurgerservicenummer                     |
      | burgerservicenummer | 555550001                                           |
      | fields              | adresregel1,adresregel2,straat,korteNaam,woonplaats |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                                       | waarde              |
      | type                                                       | Adres               |
      | verblijfadres.straat                                       | straat              |
      | verblijfadres.korteNaam                                    | straat              |
      | verblijfadres.inOnderzoek.korteNaam                        | <korteNaam>         |
      | verblijfadres.inOnderzoek.straat                           | <straat>            |
      | verblijfadres.inOnderzoek.woonplaats                       | <woonplaats>        |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | <datum>             |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | <datum type>        |
      | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | <datum langFormaat> |
      En heeft de persoon de volgende 'adressering' gegevens
      | naam                                                       | waarde        |
      | inOnderzoek.adresregel1                                    | <adresregel1> |
      | inOnderzoek.adresregel2                                    | <adresregel2> |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2022-03-07    |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum         |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 7 maart 2022  |

      #hier betekent leeg dat het inOnderzoek gegeven niet is opgenomen in het antwoord
      Voorbeelden:
      | gegeven in onderzoek      | waarde | adresregel1 | adresregel2 | korteNaam | straat | woonplaats | datum      | datum type | datum langFormaat |
      | gemeenteVanInschrijving   | 080910 |             | true        |           |        | true       | 2022-03-07 | Datum      | 7 maart 2022      |
      | straat                    | 081110 | true        |             | true      | true   |            | 2022-03-07 | Datum      | 7 maart 2022      |
      | naamOpenbareRuimte        | 081115 | true        |             |           | true   |            | 2022-03-07 | Datum      | 7 maart 2022      |
      | huisnummer                | 081120 | true        |             |           |        |            | 2022-03-07 | Datum      | 7 maart 2022      |
      | woonplaats                | 081170 |             | true        |           |        | true       | 2022-03-07 | Datum      | 7 maart 2022      |
      | locatiebeschrijving       | 081210 | true        |             |           |        |            |            |            |                   |
      | regel 1 adres buitenland  | 081330 | true        |             |           |        |            |            |            |                   |
      | groep gemeente            | 080900 |             | true        |           |        | true       | 2022-03-07 | Datum      | 7 maart 2022      |
      | groep adres               | 081100 | true        | true        | true      | true   | true       | 2022-03-07 | Datum      | 7 maart 2022      |
      | groep locatiebeschrijving | 081200 | true        |             |           |        |            |            |            |                   |
      | groep verblijf buitenland | 081300 | true        | true        |           |        |            |            |            |                   |
      | categorie verblijfplaats  | 080000 | true        | true        | true      | true   | true       | 2022-03-07 | Datum      | 7 maart 2022      |

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
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde                  |
      | voornamen (02.10)              | Piet                    |
      | geslachtsnaam (02.40)          | Groenen                 |
      | aanduiding naamgebruik (61.10) | <aanduidingNaamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde    |
      | burgerservicenummer                      | 555550002 |
      | aanduiding gegevens in onderzoek (83.10) | <waarde>  |
      | datum ingang onderzoek (83.20)           | 20220307  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Geel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                       |
      | type                | RaadpleegMetBurgerservicenummer              |
      | burgerservicenummer | 555550001                                    |
      | fields              | aanhef,aanschrijfwijze,gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                  | waarde                  |
      | aanhef                | <aanhef>                |
      | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

      Voorbeelden:
      | omschrijving                               | waarde | aanduidingNaamgebruik | in onderzoek | aanhef               | gebruikInLopendeTekst |
      | partner in onderzoek en gebruik eigen naam | 050000 | E                     | GEEN         | Geachte heer Groenen | de heer Groenen       |
      | voornamen in onderzoek                     | 050210 | P                     | GEEN         | Geachte heer Geel    | de heer Geel          |
      | aangaanHuwelijkPartnerschap in onderzoek   | 050600 | P                     | GEEN         | Geachte heer Geel    | de heer Geel          |

    @proxy
    Abstract Scenario: samengestelde namen bij <omschrijving>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde                  |
      | voornamen (02.10)              | Piet                    |
      | geslachtsnaam (02.40)          | Groenen                 |
      | aanduiding naamgebruik (61.10) | <aanduidingNaamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde    |
      | burgerservicenummer                      | 555550002 |
      | aanduiding gegevens in onderzoek (83.10) | <waarde>  |
      | datum ingang onderzoek (83.20)           | 20220307  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Geel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                       |
      | type                | RaadpleegMetBurgerservicenummer              |
      | burgerservicenummer | 555550001                                    |
      | fields              | aanhef,aanschrijfwijze,gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                | waarde                  |
      | aanhef                                              | <aanhef>                |
      | gebruikInLopendeTekst                               | <gebruikInLopendeTekst> |
      | inOnderzoek.aanhef                                  | true                    |
      | inOnderzoek.aanschrijfwijze                         | true                    |
      | inOnderzoek.gebruikInLopendeTekst                   | true                    |
      | inOnderzoek.datumIngangOnderzoekPartner.type        | Datum                   |
      | inOnderzoek.datumIngangOnderzoekPartner.datum       | 2022-03-07              |
      | inOnderzoek.datumIngangOnderzoekPartner.langFormaat | 7 maart 2022            |

      Voorbeelden:
      | omschrijving                                            | waarde | aanduidingNaamgebruik | in onderzoek | aanhef                    | gebruikInLopendeTekst |
      | partner in onderzoek en gebruik partner naam            | 050000 | P                     | WEL          | Geachte heer Geel         | de heer Geel          |
      | partner in onderzoek en gebruik partner na eigen naam   | 050000 | N                     | WEL          | Geachte heer Groenen-Geel | de heer Groenen-Geel  |
      | partner in onderzoek en gebruik partner voor eigen naam | 050000 | V                     | WEL          | Geachte heer Geel-Groenen | de heer Geel-Groenen  |
      | groep naam van partner in onderzoek                     | 050200 | P                     | WEL          | Geachte heer Geel         | de heer Geel          |
      | adellijkeTitelPredicaat in onderzoek                    | 050220 | P                     | WEL          | Geachte heer Geel         | de heer Geel          |
      | voorvoegsel in onderzoek                                | 050230 | P                     | WEL          | Geachte heer Geel         | de heer Geel          |
      | geslachtsnaam in onderzoek                              | 050240 | P                     | WEL          | Geachte heer Geel         | de heer Geel          |
