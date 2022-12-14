# language: nl

@proxy @ready @post-assert
Functionaliteit: Als gebruiker van de API wil ik geen onbekend waardes ontvangen
  zodat ik deze niet hoef te (kunnen) interpreteren en ik geen code voor hoef te schrijven om deze situatie af te vangen

  Wanneer in de registratie specifieke waarden gereserveerd zijn voor een onbekende waarde, worden deze waarden niet doorgegeven in de API.
  Wanneer een element in de registratie een standaardwaarde heeft, die betekent dat de waarde onbekend is, wordt het corresponderende veld niet opgenomen in de response.


Rule: een veld wordt niet opgenomen wanneer het de standaardwaarde bevat
  Het gaat om de volgende properties en standaardwaardes van de persoon:
  | property                                         | standaardwaarde  |
  | ------------------------------------------------ | ---------------- |
  | naam.geslachtsnaam                               | .                |
  | ouders.naam.geslachtsnaam                        | .                |
  | partners.naam.geslachtsnaam                      | .                |
  | partners.soortVerbintenis                        | .                |
  | kinderen.naam.geslachtsnaam                      | .                |

  Scenario: onbekend waarde "." voor geslachtsnaam
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                 |
    | type                | RaadpleegMetBurgerservicenummer        |
    | burgerservicenummer | 000000152                              |
    | fields              | burgerservicenummer,naam.geslachtsnaam |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |
    En heeft de persoon een leeg 'naam' object

  Scenario: onbekend waarde in een partner voor soortVerbintenis
    Gegeven de persoon met burgerservicenummer '000000206' heeft een 'partner' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer (01.20) | 000000218 |
    | soort verbintenis (15.10)   | .         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000206                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000218 |

Rule: een veld van type Waardetabel wordt niet opgenomen wanneer de code de onbekendwaarde voor de betreffende tabel bevat
  Het gaat om de volgende properties en standaardwaardes van de persoon:
  | property                                    | standaardwaarde |
  | geboorte.plaats                             | 0000            |
  | geboorte.land                               | 0000            |
  | overlijden.plaats                           | 0000            |
  | overlijden.land                             | 0000            |
  | nationaliteit.nationaliteit                 | 0000            |
  | nationaliteit.redenOpname                   | 000             |
  | verblijfplaats.gemeenteVanInschrijving      | 0000            |
  | verblijfplaats.land                         | 0000            |
  | verblijfplaats.landVanwaarIngeschreven      | 0000            |
  | ouders.geboorte.plaats                      | 0000            |
  | ouders.geboorte.land                        | 0000            |
  | partners.geboorte.plaats                    | 0000            |
  | partners.geboorte.land                      | 0000            |
  | partners.aangaanHuwelijkPartnerschap.plaats | 0000            |
  | partners.aangaanHuwelijkPartnerschap.land   | 0000            |
  | kinderen.geboorte.plaats                    | 0000            |
  | kinderen.geboorte.land                      | 0000            |

  Abstract Scenario: onbekend waarde voor <groep> <veld>
    Gegeven de persoon met burgerservicenummer '000000206' heeft de volgende gegevens
    | naam      | waarde   |
    | <element> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000206                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000206 |
    En heeft de persoon een leeg 'geboorte' object

    Voorbeelden:
    | groep          | veld       | element                           | waarde |
    | geboorte       | plaats     | geboorteplaats (03.20)            | 0000   |
    | geboorte       | land       | geboorteland (03.30)              | 0000   |

  Abstract Scenario: onbekend waarde voor <groep> <veld>
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'overlijden' gegevens
    | naam      | waarde   |
    | <element> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000139                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000139 |
    | overlijden.indicatieOverleden | true      |

    Voorbeelden:
    | groep          | veld       | element                           | waarde | 
    | overlijden     | plaats     | plaats overlijden (08.20)         | 0000   |
    | overlijden     | land       | land overlijden (08.30)           | 0000   |

  Scenario: onbekend waarde voor: gemeente van inschrijving (09.10)
    Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde | 
    | functie adres (10.10)             | W      | 
    | gemeente van inschrijving (09.10) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                      |
    | type                | RaadpleegMetBurgerservicenummer             |
    | burgerservicenummer | 000000231                                   |
    | fields              | burgerservicenummer,gemeenteVanInschrijving |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000231 |

  Scenario: onbekend waarde voor immigratie: land vanwaar ingeschreven (14.10)
   Gegeven de persoon met burgerservicenummer '000000243' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde   |
    | land vanwaar ingeschreven (14.10) | 0000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000243                       |
    | fields              | burgerservicenummer,immigratie.landVanwaarIngeschreven      |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000243 |

  Scenario: onbekend waarde voor geboorte plaats
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende gegevens
    | naam                   | waarde |
    | geboorteplaats (03.20) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000267                           |
    | fields              | burgerservicenummer,geboorte.plaats |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000267 |
    En heeft de persoon een leeg 'geboorte' object


 Abstract Scenario: onbekend waarde voor een <groep>.<veld> bij ouders
    Gegeven de persoon met burgerservicenummer '000000267' heeft een ouder '1' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer (01.20) | 000000279 |
    | <element>                   | <waarde>  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                 |
    | type                | RaadpleegMetBurgerservicenummer                                                        |
    | burgerservicenummer | 000000267                                                                              |
    | fields              | burgerservicenummer,<relatie field>.burgerservicenummer,<relatie field>.<groep>.<veld> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000267 |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer         | 000000279 |
    En heeft de '<relatie>' een leeg '<groep>' object

    Voorbeelden:
    | relatie | relatie field | groep                       | veld   | element                                                             | waarde |
    | ouder   | ouders        | geboorte                    | plaats | geboorteplaats (03.20)                                              | 0000   |
    | ouder   | ouders        | geboorte                    | land   | geboorteland (03.30)                                                | 0000   |
  
   Abstract Scenario: onbekend waarde in een <relatie> voor <groep> <veld>
    Gegeven de persoon met burgerservicenummer '000000267' heeft een '<relatie>' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer (01.20) | 000000279 |
    | <element>                   | <waarde>  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                 |
    | type                | RaadpleegMetBurgerservicenummer                                                        |
    | burgerservicenummer | 000000267                                                                              |
    | fields              | burgerservicenummer,<relatie field>.burgerservicenummer,<relatie field>.<groep>.<veld> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000267 |
    En heeft de persoon een '<relatie>' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer         | 000000279 |
    En heeft de '<relatie>' een leeg '<groep>' object 
    
    Voorbeelden:
    | relatie | relatie field | groep                       | veld   | element                                                             | waarde | 
    | partner | partners      | geboorte                    | plaats | geboorteplaats (03.20)                                              | 0000   |
    | partner | partners      | geboorte                    | land   | geboorteland (03.30)                                                | 0000   |
    | partner | partners      | aangaanHuwelijkPartnerschap | plaats | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0000   |
    | partner | partners      | aangaanHuwelijkPartnerschap | land   | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 0000   |
    | kind    | kinderen      | geboorte                    | plaats | geboorteplaats (03.20)                                              | 0000   |
    | kind    | kinderen      | geboorte                    | land   | geboorteland (03.30)                                                | 0000   |

  Scenario: onbekend waarde voor nationaliteit
    Gegeven de persoon met burgerservicenummer '000000280' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0000     |
    | reden opname (63.10)            | 311      |
    | datum ingang geldigheid (85.10) | 20030417 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000280                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000280 |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam                              | waarde                               |
    | type                              | NationaliteitOnbekend                |
    | redenOpname.code                  | 311                                  |
    | redenOpname.omschrijving          | Vaststelling onbekende nationaliteit |
    | datumIngangGeldigheid.type        | Datum                                |
    | datumIngangGeldigheid.datum       | 2003-04-17                           |
    | datumIngangGeldigheid.langFormaat | 17 april 2003                        |

  Scenario: onbekend waarde voor reden opname nationaliteit
    Gegeven de persoon met burgerservicenummer '000000280' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0052     |
    | reden opname (63.10)            | 000      |
    | datum ingang geldigheid (85.10) | 20030417 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000280                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000280 |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam                              | waarde        |
    | type                              | Nationaliteit |
    | nationaliteit.code                | 0052          |
    | nationaliteit.omschrijving        | Belgische     |
    | datumIngangGeldigheid.type        | Datum         |
    | datumIngangGeldigheid.datum       | 2003-04-17    |
    | datumIngangGeldigheid.langFormaat | 17 april 2003 |

Rule: de onbekend waarde voor geslacht wordt wel geleverd

  Scenario: een onbekend waarde bij geslacht wordt wel opgenomen in de response
   Gegeven de persoon met burgerservicenummer '000000292' heeft de volgende gegevens
    | naam                        | waarde    |
    | geslachtsaanduiding (04.10) | O         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000292                       |
    | fields              | burgerservicenummer,geslacht    |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 000000292 |
    | geslacht.code         | O         |
    | geslacht.omschrijving | onbekend  |

Rule: de onbekend waarde voor redenOpschortingBijhouding wordt wel geleverd

  Scenario: een onbekend waarde bij reden opschorting bijhouding wordt wel opgenomen in de response
  #  Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende 'opschortingBijhouding' gegevens (opschortingBijhouding wordt in de lo3_pl tabel (inschrijving) vastgeglegd)
   Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde   |
    | datum opschorting bijhouding (67.10) | 20211218 |
    | reden opschorting bijhouding (67.20) | .        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 000000309                                 |
    | fields              | burgerservicenummer,opschortingBijhouding |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000309 |
    En heeft de persoon alleen de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde           |
    | reden.code         | .                |
    | reden.omschrijving | onbekend         |
    | datum.type         | Datum            |
    | datum.datum        | 2021-12-18       |
    | datum.langFormaat  | 18 december 2021 |

Rule: datumvelden waarde "00000000": worden vertaald naar DatumOnbekend

  Scenario: volledig onbekende datum Opschorting Bijhouding, europeeskiesrecht en kiesrecht
    Gegeven de persoon met burgerservicenummer '000000322' heeft de volgende 'inschrijving' gegevens
    | naam                                             | waarde   |
    | datum opschorting bijhouding (67.10)             | 00000000 |
    | Europees kiesrecht (31.10)                       | 1        |
    | einddatum uitsluiting Europees kiesrecht (31.30) | 00000000 |
    | aanduiding uitgesloten kiesrecht (38.10)         | A        |
    | einddatum uitsluiting kiesrecht (38.20)          | 00000000 | 
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000322                          |
    | fields              | burgerservicenummer,opschortingBijhouding.datum,europeesKiesrecht.einddatumUitsluiting,uitsluitingKiesrecht.einddatum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000322 |
    En heeft de persoon de volgende 'opschortingBijhouding' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |
    En heeft de persoon de volgende 'europeesKiesrecht' gegevens
    | naam                             | waarde        |
    | einddatumUitsluiting.type        | DatumOnbekend |
    | einddatumUitsluiting.onbekend    | true          |
    | einddatumUitsluiting.langFormaat | onbekend      | 
    En heeft de persoon de volgende 'uitsluitingKiesrecht' gegevens
    | naam                  | waarde        |
    | einddatum.type        | DatumOnbekend |
    | einddatum.onbekend    | true          |
    | einddatum.langFormaat | onbekend      | 

  Scenario: volledig onbekende geboortedatum 
    Gegeven de persoon met burgerservicenummer '000000334' heeft de volgende gegevens
    | naam                         | waarde   |
    | geboortedatum (03.10)        | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000334                          |
    | fields              | burgerservicenummer,geboorte.datum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000334 |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      | 

  Scenario: volledig onbekende einddatum en begindatum verblijfstitel
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfstitel' gegevens
    | naam                                | waarde   |
    | datum einde verblijfstitel (39.20)  | 00000000 |
    | datum ingang verblijfstitel (39.30) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000346                          |
    | fields              | burgerservicenummer,verblijfstitel.datumEinde,verblijfstitel.datumIngang |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000346 |
    En heeft de persoon de volgende 'verblijfstitel' gegevens
    | naam                    | waarde   |
    | datumEinde.type         | DatumOnbekend |
    | datumEinde.onbekend     | true          |
    | datumEinde.langFormaat  | onbekend      | 
    | datumIngang.type        | DatumOnbekend |
    | datumIngang.onbekend    | true          |
    | datumIngang.langFormaat | onbekend      | 
  
  Scenario: volledig onbekende overlijdensdatum
    Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende 'overlijden' gegevens
    | naam                      | waarde   |
    | datum overlijden (08.10)  | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000358                          |
    | fields              | burgerservicenummer,overlijden.datum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000358 |
    En heeft de persoon de volgende 'overlijden' gegevens
    | naam               | waarde        |
    | indicatieOverleden | true          |
    | datum.type         | DatumOnbekend |
    | datum.onbekend     | true          |
    | datum.langFormaat  | onbekend      | 

  Scenario: volledig onbekende datum inschrijving 
     Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende 'verblijfplaats' gegevens
    | naam                                       | waarde    |
    | datum inschrijving in de gemeente (09.20)  | 00000000  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000358                       |
    | fields              | datumInschrijvingInGemeente     |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                                    | waarde        |
    | datumInschrijvingInGemeente.type        | DatumOnbekend |
    | datumInschrijvingInGemeente.onbekend    | true          |
    | datumInschrijvingInGemeente.langFormaat | onbekend      |

  Scenario: volledig onbekende geboortedatum bij ouder
   Gegeven de persoon met burgerservicenummer '000000395' heeft een ouder '1' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer (01.20) | 000000401 |
    | geboortedatum (03.10)       | 00000000  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 000000395                                 |
    | fields              | burgerservicenummer,ouders.burgerservicenummer,ouders.geboorte.datum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000395 |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000401 |
    En heeft de 'ouder' de volgende 'geboorte' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

  Scenario: volledig onbekende geboortedatum bij kind
   Gegeven de persoon met burgerservicenummer '000000395' heeft een 'kind' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer (01.20) | 000000401 |
    | geboortedatum (03.10)       | 00000000  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 000000395                                 |
    | fields              | burgerservicenummer,kinderen.burgerservicenummer,kinderen.geboorte.datum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000395 |
    En heeft de persoon een 'kind' met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000401 |
    En heeft de 'kind' de volgende 'geboorte' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

 Scenario: volledig onbekende geboortedatum en datum aanvang huwelijk bij partner
   Gegeven de persoon met burgerservicenummer '000000395' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde    |
    | burgerservicenummer (01.20)                                        | 000000401 |
    | geboortedatum (03.10)                                              | 00000000  |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 00000000  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 000000395                                 |
    | fields              | burgerservicenummer,partners.burgerservicenummer,partners.geboorte.datum,partners.aangaanHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000395 |
    En heeft de persoon een 'partner' met alleen de volgende gegevens
    | naam                              | waarde    |
    | burgerservicenummer               | 000000401 |
    En heeft de 'partner' de volgende 'geboorte' gegevens    
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |
    En heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      | 