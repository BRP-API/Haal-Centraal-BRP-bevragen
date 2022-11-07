# language: nl

Functionaliteit: Waardetabel met code en omschrijving
    Een veld dat wordt gevuld vanuit een in de BRP opgeslagen code die refereert naar een code in een
    landelijke tabel, wordt geleverd met zowel de code als de bijbehorende omschrijving.

    Naast velden met een waarde uit een landelijke tabel zijn er ook velden die in de BRP zijn gedefinieerd
    met een lijst van vaste mogelijke waarden. Deze mogelijke waarden en de bijbehorende omschrijvingen staan beschreven
    in de tabelwaarden feature.

    Mogelijke codes en omschrijvingen zijn te raadplegen met de API BRP tabellen bevragen.
    Zie https://github.com/VNG-Realisatie/Haal-Centraal-BRP-tabellen-bevragen

    Achtergrond:
      Gegeven landelijke tabel "Gemeenten" heeft de volgende waarden
      | code | omschrijving              |
      | 0064 | Bolsward                  |
      | 0362 | Amstelveen                |
      | 0492 | Bergschenhoek             |
      | 0502 | Capelle aan den IJssel    |
      | 1326 | 's Heer Hendriks Kinderen |

      Gegeven landelijke tabel "Landen" heeft de volgende waarden
      | code | omschrijving         |
      | 5077 | Wallis en Futuna     |
      | 5084 | Mayotte              |
      | 5109 | Sint Eustatius       |
      | 6059 | São Tomé en Principe |

      Gegeven landelijke tabel "Gezagsverhouding" heeft de volgende waarden
      | code | omschrijving                                         |
      |   1D | Ouder1 en een derde hebben het gezag                 |

      Gegeven landelijke tabel "Functie_adres" heeft de volgende waarden
      # Functie_adres is geen landelijke tabel maar een lijst mogelijke waarden uit het LO-gba
      # De automation-code ondersteunt nu de step "Gegeven tabel "Functie_Adres" heeft de volgende waarden" nog niet.
      | code | omschrijving                                         |
      | B    | briefadres                                           |

      Gegeven landelijke tabel "Adellijke_Titel_Predicaat" heeft de volgende waarden
      | code | omschrijving | soort     |
      |   BS | barones      | titel     |
      |   JH | jonkheer     | predicaat |
      |    R | ridder       | titel     |

  Rule: Bij een veld gedefinieerd als Waardetabel op een landelijke tabel wordt de omschrijving geleverd die in die tabel hoort bij de code

    Abstract Scenario: Omschrijving bij code voor <tabel>
      Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende '<groepsnaam>' gegevens
      | <lo3-naam>      |
      | <waarde-code>   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000176                       |
      | fields              | <fieldnaam>                     |
      Dan heeft de response een persoon met de volgende '<propertynaam>' gegevens
      | naam                        | waarde                |
      | <prefix>code                | <waarde-code>         |
      | <prefix>omschrijving        | <waarde-omschrijving> |

      Voorbeelden:
      | tabel            | waarde-code | waarde-omschrijving                  | groepsnaam       | lo3-naam                             | propertynaam               | fieldnaam                          | prefix                   |
      | Gezagsverhouding | 1D          | Ouder1 en een derde hebben het gezag | gezagsverhouding | indicatie gezag minderjarige (32.10) | indicatieGezagMinderjarige | indicatieGezagMinderjarige         |                          |
      | Gemeenten        | 1326        | 's Heer Hendriks Kinderen            | verblijfplaats   | gemeente van inschrijving (09.10)    | gemeenteVanInschrijving    | gemeenteVanInschrijving            |                          |
      | Landen           | 5013        | Nieuw-Zeeland                        | overlijden       | land overlijden (08.30)              | overlijden                 | overlijden.land                    | land.                    |
      | Gemeenten        | 1210        | Vlaardinger-Ambacht                  | overlijden       | plaats overlijden (08.20)            | overlijden                 | overlijden.plaats                  | plaats.                  |
      | Landen           | 9015        | Windwardeilanden                     | verblijfplaats   | land vanwaar ingeschreven (14.10)    | immigratie                 | immigratie.landVanwaarIngeschreven | landVanwaarIngeschreven. |
      | Verblijfstitel   | 09          | Art. 9 van de Vreemdelingenwet       | verblijfstitel   | aanduiding verblijfstitel (39.10)    | verblijfstitel             | verblijfstitel.aanduiding          | aanduiding.              |


    Abstract Scenario: Omschrijving bij code voor <tabel> bij Verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | <lo3-naam>      |
      | <waarde-code>   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000188                       |
      | fields              | <fieldnaam>                     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                        | waarde                |
      | <prefix>code                | <waarde-code>         |
      | <prefix>omschrijving        | <waarde-omschrijving> |

      Voorbeelden:
      | tabel         | waarde-code | waarde-omschrijving | lo3-naam                       | fieldnaam           | prefix              |
      | Functie_adres | B           | briefadres          | functieAdres.code (10.10)      | functieAdres        | functieAdres.       |
      | Landen        | 9087        | Djibouti            | land adres buitenland (13.10)  | verblijfplaats      | land. |

      Rule: voor adellijkeTitelPredicaat wordt naast 'code' en 'omschrijving' ook 'soort' geleverd

    Abstract Scenario: Omschrijving en soort bij code voor Adellijke titel/predicaat (02.20)
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
      | naam                                 | waarde    |
      | adellijke titel of predicaat (02.20) | <waarde>  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000188                       |
      | fields              | naam.adellijkeTitelPredicaat    |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                 | waarde         |
      | adellijkeTitelPredicaat.code         | <waarde>       |
      | adellijkeTitelPredicaat.omschrijving | <omschrijving> |
      | adellijkeTitelPredicaat.soort        | <soort>        |

      Voorbeelden:
      | waarde | omschrijving | soort     |
      | BS     | barones      | titel     |
      | JH     | jonkheer     | predicaat |
      | R      | ridder       | titel     |

    Abstract Scenario: Omschrijving bij code voor <relatie> <element>
      Gegeven de persoon met burgerservicenummer '000000206' heeft een <relatie> met de volgende gegevens
      | <element> |
      | <waarde>  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000206                       |
      | fields              | <fields>.<groep>                |
      Dan heeft de response een persoon met een '<relatiedan>' met de volgende '<groep>' gegevens
      | naam                | waarde         |
      | <veld>.code         | <waarde>       |
      | <veld>.omschrijving | <omschrijving> |

      Voorbeelden:
      | element                                                             | relatie   | relatiedan | groep                       | veld   | waarde | omschrijving           | fields   |
      | geboorteplaats (03.20)                                              | 'kind'    | kind       | geboorte                    | plaats | 0362   | Amstelveen             | kinderen |
      | geboorteland (03.30)                                                | 'kind'    | kind       | geboorte                    | land   | 5077   | Wallis en Futuna       | kinderen |
      | geboorteplaats (03.20)                                              | ouder '1' | ouder      | geboorte                    | plaats | 0492   | Bergschenhoek          | ouders   |
      | geboorteland (03.30)                                                | ouder '1' | ouder      | geboorte                    | land   | 5084   | Mayotte                | ouders   |
      | geboorteplaats (03.20)                                              | 'partner' | partner    | geboorte                    | plaats | 0064   | Bolsward               | partners |
      | geboorteland (03.30)                                                | 'partner' | partner    | geboorte                    | land   | 5109   | Sint Eustatius         | partners |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 'partner' | partner    | aangaanHuwelijkPartnerschap | plaats | 0502   | Capelle aan den IJssel | partners |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 'partner' | partner    | aangaanHuwelijkPartnerschap | land   | 6059   | São Tomé en Principe   | partners |

    Abstract Scenario: Omschrijving en soort bij code voor <relatie> met adellijke titel of predicaat
      Gegeven de persoon met burgerservicenummer '000000218' heeft een <relatie> met de volgende gegevens
      | adellijke titel of predicaat (02.20) |
      | <waarde>  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000218                       |
      | fields              | <fields>.naam.adellijkeTitelPredicaat    |
      Dan heeft de response een persoon met een '<relatiedan>' met de volgende gegevens
      | naam                                 | waarde         |
      | naam.adellijkeTitelPredicaat.code         | <waarde>       |
      | naam.adellijkeTitelPredicaat.omschrijving | <omschrijving> |
      | naam.adellijkeTitelPredicaat.soort        | <soort>        |

      Voorbeelden:
      | relatie   | relatiedan | waarde | omschrijving | soort     | fields   |
      | 'kind'    | kind       | BS     | barones      | titel     | kinderen |
      | ouder '1' | ouder      | JH     | jonkheer     | predicaat | ouders   |
      | 'partner' | partner    | R      | ridder       | titel     | partners |

    Rule: wanneer voor de code geen bijbehorende waarde voorkomt in de tabel, wordt alleen de code geleverd

      Abstract Scenario: code voor <element> komt niet voor in de tabel <tabel>
        Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende gegevens
        | <element> |
        | <waarde>  |
        Als gba personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000231                       |
        | fields              | <groep>.<veld>                  |
        Dan heeft de response een persoon met alleen de volgende '<groep>' gegevens
        | naam                | waarde         |
        | <veld>.code         | <waarde>       |

        Voorbeelden:
        | element                           | tabel               | groep                        | veld                    | waarde |
        | geboorteland (03.30)              | Landen              | geboorte                     | land                    | 1234   |

      Abstract Scenario: code voor <element> komt niet voor in de tabel <tabel>
        Gegeven de persoon met burgerservicenummer '000000243' heeft de volgende '<groep>' gegevens
        | <element> |
        | <waarde>  |
        Als gba personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000243                       |
        | fields              | <groep>                         |
        Dan heeft de response een persoon met alleen de volgende '<groep>' gegevens
        | naam                | waarde         |
        | <veld>.code         | <waarde>       |

        Voorbeelden:
        | element                           | tabel               | groep          | veld                    | waarde |
        | land overlijden (08.30)           | Landen              | overlijden     | land                    | 1234   |
        | aanduiding verblijfstitel (39.10) | Verblijfstitel      | verblijfstitel | aanduiding              | 01     |

      Abstract Scenario: code voor <element> komt niet voor in de tabel <tabel>
        Gegeven de persoon met burgerservicenummer '000000255' heeft de volgende 'verblijfplaats' gegevens
        | <element> |
        | <waarde>  |
        Als gba personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000255                       |
        | fields              | <groep>                         |
        Dan heeft de response een persoon met alleen de volgende '<groep>' gegevens
        | naam                | waarde         |
        | <veld>.code         | <waarde>       |

        Voorbeelden:
        | element                           | tabel               | groep                        | veld                    | waarde |
        | land adres buitenland (13.10)     | Landen              | verblijfplaats               | land                    | 1234   |
        | land vanwaar ingeschreven (14.10) | Landen              | immigratie                   | landVanwaarIngeschreven | 1234   |
        # In het laatste voorbeeld zou eigenlijk de "groep" immigratie moeten zijn. Echter is dit nog niet geïmplementeerd in de automation code. Als dit correct geïmplementeerd is kan de kolom "fields" vervallen en kan daarvoer "groep" gebruikt worden

    Rule: wanneer de waarde voor een plaats geen valide gemeentecode bevat wordt deze geleverd in de omschrijving
      - de waarde voor plaats is een gemeentecode wanneer het bestaat uit 4 cijfers

      Scenario: Plaats is buitenlandse plaats of locatie bij code voor geboorteplaats (Als de code niet voorkomt in tabel gemeenten)
        Gegeven de persoon met burgerservicenummer '000000280' heeft de volgende gegevens
        | geboorteplaats (03.20) |
        | Berlijn                |
        Als gba personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000280                       |
        | fields              | geboorte.plaats                 |
        Dan heeft de response een persoon met alleen de volgende 'geboorte' gegevens
        | naam                | waarde   |
        | plaats.code         | Berlijn  |
        | plaats.omschrijving | Berlijn  |

      Scenario: Plaats is buitenlandse plaats of locatie bij code voor Overlijden
        Gegeven de persoon met burgerservicenummer '000000292' heeft de volgende 'overlijden' gegevens
        | plaats overlijden (08.20) |
        | 51° N.B. 4° O.L.          |
        Als gba personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000292                       |
        | fields              | overlijden.plaats                  |
        Dan heeft de response een persoon met alleen de volgende 'overlijden' gegevens
        | naam                | waarde            |
        | plaats.code         | 51° N.B. 4° O.L.  |
        | plaats.omschrijving | 51° N.B. 4° O.L.  |


      Abstract Scenario: Plaats is buitenlandse plaats of locatie bij code voor <relatie> <element>
        Gegeven de persoon met burgerservicenummer '000000309' heeft een <relatie> met de volgende gegevens
        | <element>           |
        | <waarde>            |
        Als gba personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000309                       |
        | fields              | <fields>.<groep>                |
        Dan heeft de response een persoon met een '<relatiedan>' met de volgende '<groep>' gegevens
        | naam                | waarde   |
        | plaats.code         | <waarde> |
        | plaats.omschrijving | <waarde> |

        Voorbeelden:
        | element                                                             | tabel        | relatie   | relatiedan | groep                       | waarde            | fields   |
        | geboorteplaats (03.20)                                              | 33 Gemeenten | 'kind'    | kind       | geboorte                    | Brussel           | kinderen |
        | geboorteplaats (03.20)                                              | 33 Gemeenten | ouder '1' | ouder      | geboorte                    | 52°2'43N4°22'39"O | ouders   |
        | geboorteplaats (03.20)                                              | 33 Gemeenten | 'partner' | partner    | geboorte                    | London            | partners |
        | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 33 Gemeenten | 'partner' | partner    | aangaanHuwelijkPartnerschap | Köln              | partners |
