# language: nl

Functionaliteit: Waardetabel met code en omschrijving
    Een veld dat wordt gevuld vanuit een in de BRP opgeslagen code die refereert naar een code in een 
    landelijke tabel, wordt geleverd met zowel de code als de bijbehorende omschrijving.

    Naast velden met een waarde uit een landelijke tabel zijn er ook velden die in de BRP zijn gedefinieerd 
    met een lijst van vaste mogelijke waarden. Deze mogelijke waarden en de bijbehorende omschrijvingen staan beschreven 
    in de tabelwaarden feature.

    Mogelijke codes en omschrijvingen zijn te raadplegen met de API BRP tabellen bevragen.
    Zie https://github.com/VNG-Realisatie/Haal-Centraal-BRP-tabellen-bevragen

  @gba
  Rule: Bij een veld gedefinieerd als Waardetabel op een landelijke tabel wordt de omschrijving geleverd die in die tabel hoort bij de code

    Abstract Scenario: Omschrijving bij code voor <element>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      | <element>           | <waarde>  |
      En het systeem heeft landelijke tabel '<tabel>' met de volgende gegevens
      | code     | omschrijving   |
      | <waarde> | <omschrijving> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <veld>                          |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde         |
      | <veld>.code         | <waarde>       |
      | <veld>.omschrijving | <omschrijving> |

      Voorbeelden:
      | element                              | tabel                    | veld                       | waarde | omschrijving                         |
      | Gemeente van inschrijving (09.10)    | 33 Gemeenten             | gemeenteVanInschrijving    | 1326   | 's Heer Hendriks Kinderen            |
      | Indicatie gezag minderjarige (32.10) | 61 Gezagsverhoudingtabel | indicatieGezagMinderjarige | 1D     | Ouder1 en een derde hebben het gezag |

    Abstract Scenario: Omschrijving bij code voor <element>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      | <element>           | <waarde>  |
      En het systeem heeft landelijke tabel '<tabel>' met de volgende gegevens
      | code     | omschrijving   |
      | <waarde> | <omschrijving> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.<veld>                  |
      Dan heeft de response een persoon met de volgende '<groep>' gegevens
      | naam                | waarde         |
      | <veld>.code         | <waarde>       |
      | <veld>.omschrijving | <omschrijving> |

      Voorbeelden:
      | element                           | tabel                  | groep                        | veld                    | waarde | omschrijving                                                     |
      | Geboorteplaats (03.20)            | 33 Gemeenten           | geboorte                     | plaats                  | 0880   | Wormerland                                                       |
      | Geboorteland (03.30)              | 34 Landen              | geboorte                     | land                    | 6030   | Nederland                                                        |
      | Plaats overlijden (08.20)         | 33 Gemeenten           | overlijden                   | plaats                  | 1210   | Vlaardinger-Ambacht                                              |
      | Land overlijden (08.30)           | 34 Landen              | overlijden                   | land                    | 5013   | Nieuwzeeland                                                     |
      | Land adres buitenland (13.10)     | 34 Landen              | verblijfplaats.verblijfadres | land                    | 9087   | Djibouti                                                         |
      | Land vanwaar ingeschreven (14.10) | 34 Landen              | immigratie                   | landVanwaarIngeschreven | 9015   | Windwardeilanden                                                 |
      | Aanduiding verblijfstitel (39.10) | 56 Verblijfstiteltabel | verblijfstitel               | aanduiding              | 91     | Vw 2000 art. 115, lid 4, vergunning onbepaalde tijd, arbeid vrij |

    Abstract Scenario: Omschrijving bij code voor <element>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      | <element>           | <waarde>  |
      En het systeem heeft landelijke tabel '<tabel>' met de volgende gegevens
      | code     | omschrijving   |
      | <waarde> | <omschrijving> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | nationaliteiten.<veld>          |
      Dan heeft de response een persoon een 'nationaliteit' met de volgende gegevens
      | naam                | waarde         |
      | <veld>.code         | <waarde>       |
      | <veld>.omschrijving | <omschrijving> |
      
      Voorbeelden:
      | element                            | tabel                                     | veld          | waarde | omschrijving                             |
      | nationaliteit (05.10)              | 32 nationaliteiten                        | nationaliteit | 0064   | Italiaanse                               |
      | Reden opname nationaliteit (63.10) | 37 Reden opnemen/beëindigen nationaliteit | redenOpname   | 301    | Vaststelling bezit vreemde nationaliteit |

    Abstract Scenario: Omschrijving bij code voor <relatie> <element>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een '<relatie>' met de volgende gegevens
      | <element>           | <waarde>  |
      En het systeem heeft landelijke tabel '<tabel>' met de volgende gegevens
      | code     | omschrijving   |
      | <waarde> | <omschrijving> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <relatie>.<groep>.<veld>        |
      Dan heeft de response een persoon een '<relatie>' met de volgende gegevens
      | naam                | waarde         |
      | <veld>.code         | <waarde>       |
      | <veld>.omschrijving | <omschrijving> |

      Voorbeelden: 
      | element                                                             | tabel        | relatie | groep                       | veld   | waarde | omschrijving           |
      | Geboorteplaats (03.20)                                              | 33 Gemeenten | kind    | geboorte                    | plaats | 0362   | Amstelveen             |
      | Geboorteland (03.30)                                                | 34 Landen    | kind    | geboorte                    | land   | 5077   | Wallis en Futuna       |
      | Geboorteplaats (03.20)                                              | 33 Gemeenten | ouder   | geboorte                    | plaats | 0492   | Bergschenhoek          |
      | Geboorteland (03.30)                                                | 34 Landen    | ouder   | geboorte                    | land   | 5084   | Mayotte                |
      | Geboorteplaats (03.20)                                              | 33 Gemeenten | partner | geboorte                    | plaats | 0064   | Bolsward               |
      | Geboorteland (03.30)                                                | 34 Landen    | partner | geboorte                    | land   | 5109   | Sint Eustatius         |
      | Plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 33 Gemeenten | partner | aangaanHuwelijkPartnerschap | plaats | 0502   | Capelle aan den IJssel |
      | Land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 34 Landen    | partner | aangaanHuwelijkPartnerschap | land   | 6059   | São Tomé en Principe   |

  @gba
  Rule: voor adellijkeTitelPredicaat wordt ook soort geleverd die in die tabel hoort bij de code

    Abstract Scenario: Omschrijving en soort bij code voor Adellijke titel/predicaat (02.20)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                              | waarde    |
      | burgerservicenummer               | 555550001 |
      | Adellijke titel/predicaat (02.20) | <waarde>  |
      En het systeem heeft landelijke tabel '38 Adellijke titel/predicaat' met de volgende gegevens
      | code | omschrijving | soort     |
      | BS   | barones      | titel     |
      | JH   | jonkheer     | predicaat |
      | R    | ridder       | titel     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
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
      
    Abstract Scenario: Omschrijving en soort bij code voor <relatie> Adellijke titel/predicaat (02.20)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                              | waarde    |
      | burgerservicenummer               | 555550001 |
      En de persoon heeft een '<relatie>' met de volgende gegevens
      | Adellijke titel/predicaat (02.20) | <waarde>  |
      En het systeem heeft landelijke tabel '38 Adellijke titel/predicaat' met de volgende gegevens
      | code | omschrijving | soort     |
      | BS   | barones      | titel     |
      | JH   | jonkheer     | predicaat |
      | R    | ridder       | titel     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <relatie>.naam.adellijkeTitelPredicaat    |
      Dan heeft de response een persoon een '<relatie>' met de volgende gegevens
      | naam                                 | waarde         |
      | adellijkeTitelPredicaat.code         | <waarde>       |
      | adellijkeTitelPredicaat.omschrijving | <omschrijving> |
      | adellijkeTitelPredicaat.soort        | <soort>        |

      Voorbeelden:
      | relatie | waarde | omschrijving | soort     |
      | kind    | BS     | barones      | titel     |
      | ouder   | JH     | jonkheer     | predicaat |
      | partner | R      | ridder       | titel     |

  Rule: wanneer voor de code geen bijbehorende waarde voorkomt in de tabel, wordt alleen de code geleverd

    Abstract Scenario: geen omschrijving bij code voor <element>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      | <element>           | <waarde>  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.<veld>                  |
      Dan heeft de response een persoon met alleen de volgende '<groep>' gegevens
      | naam                | waarde         |
      | <veld>.code         | <waarde>       |

      Voorbeelden:
      | element                           | tabel                  | groep                        | veld                    | waarde |
      | Geboorteplaats (03.20)            | 33 Gemeenten           | geboorte                     | plaats                  | 9876   |
      | Geboorteland (03.30)              | 34 Landen              | geboorte                     | land                    | 1234   |
      | Plaats overlijden (08.20)         | 33 Gemeenten           | overlijden                   | plaats                  | 9876   |
      | Land overlijden (08.30)           | 34 Landen              | overlijden                   | land                    | 1234   |
      | Land adres buitenland (13.10)     | 34 Landen              | verblijfplaats.verblijfadres | land                    | 1234   |
      | Land vanwaar ingeschreven (14.10) | 34 Landen              | immigratie                   | landVanwaarIngeschreven | 1234   |
      | Aanduiding verblijfstitel (39.10) | 56 Verblijfstiteltabel | verblijfstitel               | aanduiding              | 01     |

  Rule: wanneer de waarde voor een plaats geen valide gemeentecode bevat wordt deze geleverd in de omschrijving
    - de waarde voor plaats is een gemeentecode wanneer het bestaat uit 4 cijfers

    Abstract Scenario: Plaats is buitenlandse plaats of locatie bij code voor <element>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      | <element>           | <waarde>  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.plaats                  |
      Dan heeft de response een persoon met alleen de volgende '<groep>' gegevens
      | naam                | waarde   |
      | plaats.omschrijving | <waarde> |

      Voorbeelden:
      | element                   | tabel        | groep      | waarde           |
      | Geboorteplaats (03.20)    | 33 Gemeenten | geboorte   | Berlijn          |
      | Plaats overlijden (08.20) | 33 Gemeenten | overlijden | 51° N.B. 4° O.L. |
      
    Abstract Scenario: Plaats is buitenlandse plaats of locatie bij code voor <relatie> <element>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een '<relatie>' met de volgende gegevens
      | <element>           | <waarde>  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <relatie>.<groep>.plaats        |
      Dan heeft de response een persoon een '<relatie>' met de volgende gegevens
      | naam                | waarde   |
      | plaats.omschrijving | <waarde> |

      Voorbeelden: 
      | element                                                             | tabel        | relatie | groep                       | waarde            |
      | Geboorteplaats (03.20)                                              | 33 Gemeenten | kind    | geboorte                    | Brussel           |
      | Geboorteplaats (03.20)                                              | 33 Gemeenten | ouder   | geboorte                    | 52°2'43N4°22'39"O |
      | Geboorteplaats (03.20)                                              | 33 Gemeenten | partner | geboorte                    | London            |
      | Plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 33 Gemeenten | partner | aangaanHuwelijkPartnerschap | Köln              |

