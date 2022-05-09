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
  | verblijfplaats.straat                            | .                |
  | verblijfplaats.huisnummer                        | 0                |
  | verblijfplaats.woonplaats                        | .                |
  | verblijfplaats.nummeraanduidingIdentificatie     | 0000000000000000 |
  | verblijfplaats.adresseerbaarObjectIdentificatie  | 0000000000000000 |
  | ouders.naam.geslachtsnaam                        | .                |
  | partners.naam.geslachtsnaam                      | .                |
  | partners.soortVerbintenis                        | .                |
  | kinderen.naam.geslachtsnaam                      | .                |
  | reisdocumentnummers                              | .........        |

  Scenario: onbekend waarde "." voor geslachtsnaam
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                 |
    | type                | RaadpleegMetBurgerservicenummer        |
    | burgerservicenummer | 999992934                              |
    | fields              | burgerservicenummer,naam.geslachtsnaam |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |

  Scenario: onbekend waarde "." voor straat
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam               | waarde |
    | straatnaam (11.10) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 999992934                                 |
    | fields              | burgerservicenummer,verblijfplaats.straat |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

  Scenario: onbekend waarde "0" voor huisnummer
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam               | waarde     |
    | straatnaam (11.10) | een straat |
    | huisnummer (11.20) | 0          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 999992934                                     |
    | fields              | burgerservicenummer,verblijfplaats.huisnummer |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

  Abstract Scenario: onbekend waarde "<waarde>" voor <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam               | waarde     |
    | straatnaam (11.10) | een straat |
    | <element>          | <waarde>   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | groep          | veld                             | element                                  | waarde           |
    | verblijfplaats | woonplaats                       | woonplaatsnaam (11.70)                   | .                |
    | verblijfplaats | nummeraanduidingIdentificatie    | nummeraanduidingIdentificatie (11.90)    | 0000000000000000 |
    | verblijfplaats | adresseerbaarObjectIdentificatie | adresseerbaarObjectIdentificatie (11.80) | 0000000000000000 |

  Scenario: onbekend waarde in een partner voor soortVerbintenis
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft een partner met de volgende gegevens
    | naam                      | waarde    |
    | burgerservicenummer       | 999992935 |
    | soort verbintenis (15.10) | .         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 999992934                                     |
    | fields              | burgerservicenummer,partners.soortVerbintenis |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon een 'partner' met alleen de volgende gegevens
    | naam | waarde  |
    | type | Partner |

  Scenario: onbekend waarde voor reisdocumentnummer
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'reisdocumentnummers'
    | reisdocumentnummer |
    | .........          |
    | Pk5Q8cA31          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999992934                               |
    | fields              | burgerservicenummer,reisdocumentnummers |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende 'reisdocumentnummers'
    | reisdocumentnummers |
    | Pk5Q8cA31           |

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
  | verblijfstitel.aanduiding                   | 00              |
  | ouders.geboorte.plaats                      | 0000            |
  | ouders.geboorte.land                        | 0000            |
  | partners.geboorte.plaats                    | 0000            |
  | partners.geboorte.land                      | 0000            |
  | partners.aangaanHuwelijkPartnerschap.plaats | 0000            |
  | partners.aangaanHuwelijkPartnerschap.land   | 0000            |
  | kinderen.geboorte.plaats                    | 0000            |
  | kinderen.geboorte.land                      | 0000            |

  Abstract Scenario: onbekend waarde voor <groep> <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam      | waarde   |
    | <element> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |

    Voorbeelden:
    | groep          | veld       | element                           | waarde |
    | geboorte       | plaats     | geboorteplaats (03.20)            | 0000   |
    | geboorte       | land       | geboorteland (03.30)              | 0000   |
    | overlijden     | plaats     | plaats overlijden (08.20)         | 0000   |
    | overlijden     | land       | land overlijden (08.30)           | 0000   |
    | verblijfstitel | aanduiding | aanduiding verblijfstitel (39.10) | 00     |

  Abstract Scenario: onbekend waarde voor adres: <groep> <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam               | waarde     |
    | straatnaam (11.10) | een straat |
    | <element>          | <waarde>   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende '<groep>' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | groep          | veld                    | element                            | waarde |
    | verblijfplaats | gemeenteVanInschrijving | gemeente van inschrijving (09.10)  | 0000   |
    | verblijfplaats | landVanwaarIngeschreven | land van waar ingeschreven (14.10) | 0000   |

  Abstract Scenario: onbekend waarde voor locatie: <groep> <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam                        | waarde                  |
    | locatiebeschrijving (12.10) | een locatiebeschrijving |
    | <element>                   | <waarde>                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende '<groep>' gegevens
    | naam | waarde  |
    | type | Locatie |

    Voorbeelden:
    | groep          | veld                    | element                            | waarde |
    | verblijfplaats | gemeenteVanInschrijving | gemeente van inschrijving (09.10)  | 0000   |
    | verblijfplaats | landVanwaarIngeschreven | land van waar ingeschreven (14.10) | 0000   |

  Abstract Scenario: onbekend waarde voor verblijfplaats onbekend: <groep> <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam         | waarde   |
    | land (13.10) | 0000     |
    | <element>    | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende '<groep>' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |

    Voorbeelden:
    | groep          | veld                    | element                           | waarde |
    | verblijfplaats | gemeenteVanInschrijving | gemeente van inschrijving (09.10) | 0000   |

  Abstract Scenario: onbekend waarde voor verblijfplaats buitenland: <groep> <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam         | waarde   |
    | land (13.10) | 6014     |
    | <element>    | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende '<groep>' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | groep          | veld                    | element                           | waarde |
    | verblijfplaats | gemeenteVanInschrijving | gemeente van inschrijving (09.10) | 0000   |

  Scenario: geboorte plaats zonder code
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                | waarde  |
    | plaats.omschrijving | Brussel |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | geboorte.plaats                 |
    Dan heeft de response een persoon met alleen de volgende 'geboorte' gegevens
    | naam                | waarde  |
    | plaats.omschrijving | Brussel |

  Scenario: onbekend waarde voor geboorte plaats
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                   | waarde |
    | geboorteplaats (03.20) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 999992934                           |
    | fields              | burgerservicenummer,geboorte.plaats |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |

  Abstract Scenario: onbekend waarde in een <relatie> voor <groep> <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft een '<relatie>' met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992935 |
    En de '<relatie>' heeft de volgende '<groep>' gegevens
    | naam      | waarde   |
    | <element> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                 |
    | type                | RaadpleegMetBurgerservicenummer                                                        |
    | burgerservicenummer | 999992934                                                                              |
    | fields              | burgerservicenummer,<relatie field>.burgerservicenummer,<relatie field>.<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon een '<relatie>' met alleen de volgende gegevens
    | naam                | waarde    |
    | type                | <type>    |
    | burgerservicenummer | 999992935 |

    Voorbeelden:
    | relatie | relatie field | type    | groep                       | veld   | element                                                             | waarde |
    | ouder   | ouders        | Ouder   | geboorte                    | plaats | geboorteplaats (03.20)                                              | 0000   |
    | ouder   | ouders        | Ouder   | geboorte                    | land   | geboorteland (03.30)                                                | 0000   |
    | partner | partners      | Partner | geboorte                    | plaats | geboorteplaats (03.20)                                              | 0000   |
    | partner | partners      | Partner | geboorte                    | land   | geboorteland (03.30)                                                | 0000   |
    | partner | partners      | Partner | aangaanHuwelijkPartnerschap | plaats | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0000   |
    | partner | partners      | Partner | aangaanHuwelijkPartnerschap | land   | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 0000   |
    | kind    | kinderen      | Kind    | geboorte                    | plaats | geboorteplaats (03.20)                                              | 0000   |
    | kind    | kinderen      | Kind    | geboorte                    | land   | geboorteland (03.30)                                                | 0000   |

  Scenario: onbekend waarde voor nationaliteit
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0000     |
    | reden opname (63.10)            | 311      |
    | ingangsdatum geldigheid (85.10) | 20030417 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 999992934                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam                        | waarde                |
    | type                        | NationaliteitOnbekend |
    | redenOpname.code            | 311                   |
    | datumIngangGeldigheid.type  | Datum                 |
    | datumIngangGeldigheid.datum | 2003-04-17            |

  Scenario: onbekend waarde voor reden opname nationaliteit
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0052     |
    | reden opname (63.10)            | 000      |
    | ingangsdatum geldigheid (85.10) | 20030417 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 999992934                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam                        | waarde        |
    | type                        | Nationaliteit |
    | nationaliteit.code          | 0052          |
    | datumIngangGeldigheid.type  | Datum         |
    | datumIngangGeldigheid.datum | 2003-04-17    |

Rule: de onbekend waarde voor geslacht wordt wel geleverd

  Scenario: een onbekend waarde bij geslacht wordt wel opgenomen in de response
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer         | 999992934 |
    | geslachtsaanduiding (04.10) | O         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | burgerservicenummer,geslacht    |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    | geslacht.code       | O         |

Rule: de onbekend waarde voor redenOpschortingBijhouding wordt wel geleverd

  Scenario: een onbekend waarde bij reden opschorting bijhouding wordt wel opgenomen in de response
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'opschortingBijhouding' gegevens
    | naam                                 | waarde   |
    | datum opschorting bijhouding (67.10) | 20211218 |
    | reden opschorting bijhouding (67.20) | .        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 999992934                                 |
    | fields              | burgerservicenummer,opschortingBijhouding |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende 'opschortingBijhouding' gegevens
    | naam        | waarde     |
    | reden.code  | .          |
    | datum.type  | Datum      |
    | datum.datum | 2021-12-18 |

Rule: datumvelden waarde "00000000": worden vertaald naar DatumOnbekend

  Abstract Scenario: volledig onbekende datum in <groep> <element>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam      | waarde   |
    | <element> | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 555550001                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon alleen de volgende '<groep>' gegevens
    | naam            | waarde        |
    | <veld>.type     | DatumOnbekend |
    | <veld>.onbekend | true          |

    Voorbeelden:
    | groep                 | element                                          | veld                                  |
    | geboorte              | geboortedatum (03.10)                            | datum                                 |
    | overlijden            | datum overlijden (08.10)                         | datum                                 |
    | opschortingBijhouding | datum opschorting bijhouding (67.10)             | datum                                 |
    | verblijfstitel        | datum einde verblijfstitel (39.20)               | datumEinde                            |
    | verblijfstitel        | datum ingang verblijfstitel (39.30)              | datumIngang                           |
    | kiesrecht             | einddatum uitsluiting europees kiesrecht (31.30) | einddatumUitsluitingEuropeesKiesrecht |
    | kiesrecht             | einddatum uitsluiting kiesrecht (38.30)          | einddatumUitsluitingKiesrecht         |

  Abstract Scenario: volledig onbekende datum in adres: <element>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam               | waarde     |
    | straatnaam (11.10) | een straat |
    | <element>          | 00000000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 555550001                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon alleen de volgende '<groep>' gegevens
    | naam            | waarde        |
    | type            | Adres         |
    | <veld>.type     | DatumOnbekend |
    | <veld>.onbekend | true          |

    Voorbeelden:
    | groep          | element                                   | veld                        |
    | verblijfplaats | datum inschrijving in de gemeente (09.20) | datumInschrijvingInGemeente |
    | verblijfplaats | datum aanvang adreshouding (10.30)        | datumVan                    |

  Abstract Scenario: volledig onbekende datum in verblijfplaats buitenland: <element>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende '<groep>' gegevens
    | naam         | waarde   |
    | land (13.10) | 6014     |
    | <element>    | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 555550001                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon alleen de volgende '<groep>' gegevens
    | naam            | waarde                   |
    | type            | VerblijfplaatsBuitenland |
    | <veld>.type     | DatumOnbekend            |
    | <veld>.onbekend | true                     |

    Voorbeelden:
    | groep          | element                                | veld     |
    | verblijfplaats | datum aanvang adres buitenland (13.20) | datumVan |

  Abstract Scenario: volledig onbekende datum bij <relatie> in <groep> datum
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een '<relatie>' met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550002 |
    En de '<relatie>' heeft de volgende '<groep>' gegevens
    | naam      | waarde   |
    | <element> | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                |
    | type                | RaadpleegMetBurgerservicenummer                                                       |
    | burgerservicenummer | 555550001                                                                             |
    | fields              | burgerservicenummer,<relatie field>.burgerservicenummer,<relatie field>.<groep>.datum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon een '<relatie>' met alleen de volgende gegevens
    | naam                | waarde    |
    | type                | <type>    |
    | burgerservicenummer | 555550002 |
    En heeft de '<relatie>' alleen de volgende '<groep>' gegevens
    | naam           | waarde        |
    | datum.type     | DatumOnbekend |
    | datum.onbekend | true          |

    Voorbeelden:
    | relatie | relatie field | type    | groep                       | element                                                            |
    | ouder   | ouders        | Ouder   | geboorte                    | geboortedatum (03.10)                                              |
    | partner | partners      | Partner | aangaanHuwelijkPartnerschap | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | partner | partners      | Partner | geboorte                    | geboortedatum (03.10)                                              |
    | kind    | kinderen      | Kind    | geboorte                    | geboortedatum (03.10)                                              |

Rule: vertalen (onbekend)waarden naar indicator
  - elke waarde voor datumVestigingInNederland (incl. 00000000) geeft indicatieVestigingVanuitBuitenland met de waarde true
  - onbekend land vanwaar ingeschreven (waarde 0000) geeft vanuitVerblijfplaatsOnbekend met de waarde true
  - onbekend land verblijf buitenland (waarde 0000) geeft verblijfplaatsOnbekend
  - elke waarde voor overlijdensdatum (incl. 00000000) geeft indicatieOverleden met de waarde true

  Abstract Scenario: indicatieVestigingVanuitBuitenland en vanuitVerblijfplaatsOnbekend bij datum vestiging '<datum>' uit land '<land>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde     |
    | straatnaam (11.10)                   | een straat |
    | datum vestiging in nederland (14.20) | <datum>    |
    | land vanwaar ingeschreven (14.10)    | <land>     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                            |
    | type                | RaadpleegMetBurgerservicenummer                                                                                   |
    | burgerservicenummer | 999992934                                                                                                         |
    | fields              | burgerservicenummer,verblijfplaats.indicatieVestigingVanuitBuitenland,verblijfplaats.vanuitVerblijfplaatsOnbekend |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                               |
    | type                               | Adres                                |
    | indicatieVestigingVanuitBuitenland | <indicatieVestigingVanuitBuitenland> |
    | vanuitVerblijfplaatsOnbekend       | <vanuitVerblijfplaatsOnbekend>       |

    Voorbeelden:
    | datum    | land | indicatieVestigingVanuitBuitenland | vanuitVerblijfplaatsOnbekend |
    | 19870214 | 6023 | true                               |                              |
    | 19490000 | 6024 | true                               |                              |
    | 19931100 | 6065 | true                               |                              |
    | 00000000 | 6029 | true                               |                              |
    | 19870214 | 0000 | true                               | true                         |
    | 00000000 | 0000 | true                               | true                         |
    |          |      |                                    |                              |

  Abstract Scenario: verblijfplaatsOnbekend bij land verblijfplaats '<land>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde        |
    | land adres buitenland (13.10)    | <land>        |
    | regel 1 adres buitenland (13.30) |               |
    | regel 2 adres buitenland (13.40) | <adresregel2> |
    | straatnaam (11.10)               | <straat>      |
    | huisnummer (11.20)               | <huisnummer>  |
    | postcode (11.60)                 |               |
    | locatiebeschrijving (12.10)      |               |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                        |
    | type                | RaadpleegMetBurgerservicenummer                                               |
    | burgerservicenummer | 999992934                                                                     |
    | fields              | burgerservicenummer,verblijfplaats.type,verblijfplaats.verblijfplaatsOnbekend |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende 'verblijfplaats' gegevens
    | naam                   | waarde     |
    | type                   | <type>     |
    | verblijfplaatsOnbekend | <onbekend> |

    Voorbeelden:
    | land | adresregel2 | straat | huisnummer | type                     | onbekend |
    | 6033 |             |        |            | VerblijfplaatsBuitenland |          |
    | 6033 | onbekend    |        |            | VerblijfplaatsBuitenland |          |
    | 0000 |             |        |            | VerblijfplaatsOnbekend   | true     |
    | 0000 | VOW         |        |            | VerblijfplaatsOnbekend   | true     |
    |      |             | .      | 0          | Adres                    |          |

  Abstract Scenario: indicatieOverleden bij overlijdensdatum '<overlijdensdatum>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam                      | waarde   |
    | datum overlijden (08.10)  | <datum>  |
    | plaats overlijden (08.20) | <plaats> |
    | land overlijden (08.30)   | <land>   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 999992934                                         |
    | fields              | burgerservicenummer,overlijden.indicatieOverleden |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En heeft de persoon alleen de volgende 'overlijden' gegevens
    | naam               | waarde               |
    | indicatieOverleden | <indicatieOverleden> |

    Voorbeelden:
    | datum    | plaats | land | indicatieOverleden |
    | 20010219 | 1403   | 6030 | true               |
    | 20010200 | 1403   | 6030 | true               |
    | 20010000 | 1403   | 6030 | true               |
    | 00000000 | 1403   | 6030 | true               |
    | 00000000 | 0000   | 0000 | true               |
    | 00000000 |        |      | true               |
    |          |        |      |                    |
