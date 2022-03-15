# language: nl

@proxy
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

  Abstract Scenario: onbekend waarde "<waarde>" voor <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon heeft de volgende <groep> gegevens
    | naam   | waarde   |
    | <veld> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende '<groep>' gegevens NIET
    | naam   | 
    | <veld> |

    Voorbeelden:
    | groep          | veld                              | waarde           |
    | naam           | geslachtsnaam                     | .                |
    | verblijfplaats | straat                            | .                |
    | verblijfplaats | huisnummer                        | 0                |
    | verblijfplaats | woonplaats                        | .                |
    | verblijfplaats | nummeraanduidingIdentificatie     | 0000000000000000 |
    | verblijfplaats | adresseerbaarObjectIdentificatie  | 0000000000000000 |

  Scenario: onbekend waarde in een partner voor soortVerbintenis
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon heeft een partner met de volgende gegevens
    | naam                        | waarde             |
    | burgerservicenummer         | 999992935          |
    | soort verbintenis (15.10)   | .                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                     |
    | type                | RaadpleegMetBurgerservicenummer                                            |
    | burgerservicenummer | 999992934                                                                  |
    | fields              | burgerservicenummer,partners.soortVerbintenis                              |
    Dan bevat de persoon met burgerservicenummer '999992934' alleen de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |

  Scenario: onbekend waarde voor reisdocumentnummer
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon met burgerservicenummer '999992934' heeft de volgende actueel geldige reisdocumentnummers
    | reisdocumentnummers |
    | .........           |
    | Pk5Q8cA31           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999992934                               |
    | fields              | burgerservicenummer,reisdocumentnummers |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' alleen de volgende reisdocumentnummers
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
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon heeft de volgende <groep> gegevens
    | naam        | waarde   |
    | <veld>.code | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan bevat de persoon met burgerservicenummer '999992934' alleen de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |

    Voorbeelden:
    | groep          | veld                    | waarde |
    | geboorte       | plaats                  | 0000   |
    | geboorte       | land                    | 0000   |
    | overlijden     | plaats                  | 0000   |
    | overlijden     | land                    | 0000   |
    | verblijfplaats | gemeenteVanInschrijving | 0000   |
    | verblijfplaats | land                    | 0000   |
    | verblijfplaats | landVanwaarIngeschreven | 0000   |
    | verblijfstitel | aanduiding              | 00     |

  Scenario: buitenlandse plaats zonder code
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon heeft de volgende geboorte gegevens
    | plaats.omschrijving | Brussel |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 999992934                           |
    | fields              | burgerservicenummer,geboorte.plaats |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' alleen de volgende 'geboorte' gegevens
    | naam                | waarde  |
    | plaats.omschrijving | Brussel |

  Abstract Scenario: onbekend waarde in een <relatie> voor <groep> <veld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon heeft een <relatie> met de volgende gegevens
    | naam                        | waarde             |
    | burgerservicenummer         | 999992935          |
    En de <relatie> met burgerservicenummer '999992935' heeft de volgende <groep> gegevens
    | naam        | waarde   |
    | <veld>.code | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                     |
    | type                | RaadpleegMetBurgerservicenummer                                            |
    | burgerservicenummer | 999992934                                                                  |
    | fields              | burgerservicenummer,<relatie>.burgerservicenummer,<relatie>.<groep>.<veld> |
    Dan bevat de persoon met burgerservicenummer '999992934' alleen de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |

    Voorbeelden:
    | relatie  | groep                       | veld   | waarde |
    | ouders   | geboorte                    | plaats | 0000   |
    | ouders   | geboorte                    | land   | 0000   |
    | partners | geboorte                    | plaats | 0000   |
    | partners | geboorte                    | land   | 0000   |
    | partners | aangaanHuwelijkPartnerschap | plaats | 0000   |
    | partners | aangaanHuwelijkPartnerschap | land   | 0000   |
    | kinderen | geboorte                    | plaats | 0000   |
    | kinderen | geboorte                    | land   | 0000   |

  Scenario: onbekend waarde voor nationaliteit
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon met burgerservicenummer '999992934' heeft de volgende nationaliteit gegevens
    | naam                  | waarde   |
    | nationaliteit         | 0000     |
    | redenOpname           | 311      |
    | datumIngangGeldigheid | 20030417 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 999992934                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' een nationaliteit met alleen de volgende gegevens
    | redenOpname.code            | 311                                  |
    | redenOpname.omschrijving    | Vaststelling onbekende nationaliteit |
    | datumIngangGeldigheid.datum | 2003-04-17                           |
    
  Scenario: onbekend waarde voor reden opname nationaliteit
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon met burgerservicenummer '999992934' heeft de volgende nationaliteit gegevens
    | naam                  | waarde   |
    | nationaliteit         | 0052     |
    | redenOpname           | 000      |
    | datumIngangGeldigheid | 20030417 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 999992934                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' een nationaliteit met alleen de volgende gegevens
    | nationaliteit.code          | 0052       |
    | nationaliteit.omschrijving  | Belgische  |
    | datumIngangGeldigheid.datum | 2003-04-17 |

Rule: de onbekendwaarde voor geslachtsaanduiding wordt wel geleverd

  Scenario: een onbekendwaarde bij geslachtsaanduiding wordt wel opgenomen in de response
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer         | 999992934 |
    | geslachtsaanduiding         | O         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999992934                               |
    | fields              | burgerservicenummer,geslachtsaanduiding |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' de volgende 'geslachtsaanduiding' gegevens
    | naam         | waarde   |
    | code         | O        |
    | omschrijving | onbekend |

Rule: de onbekendwaarde voor redenOpschortingBijhouding wordt wel geleverd

  Scenario: een onbekendwaarde bij redenOpschortingBijhouding wordt wel opgenomen in de response
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer         | 999992934 |
    En de persoon heeft de volgende opschortingBijhouding gegevens
    | reden | .        |
    | datum | 20211218 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999992934                               |
    | fields              | burgerservicenummer,redenOpschortingBijhouding |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde     |
    | reden.code         | .          |
    | reden.omschrijving | onbekend   |
    | datum.type         | Datum      |
    | datum.datum        | 2021-12-18 |

Rule: datumvelden waarde "00000000": worden vertaald naar OnbekendDatum

  Scenario: een onbekendwaarde bij redenOpschortingBijhouding wordt wel opgenomen in de response
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer         | 999992934 |
    En de persoon heeft de volgende opschortingBijhouding gegevens
    | reden | O        |
    | datum | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999992934                               |
    | fields              | burgerservicenummer,redenOpschortingBijhouding |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde        |
    | reden.code         | O             |
    | reden.omschrijving | overlijden    |
    | datum.type         | OnbekendDatum |
    | datum.onbekend     | true          |

  Scenario: er wordt geen link gemaakt op basis van een onbekendwaarde
    Gegeven de persoon heeft een reisdocument met reisdocumentnummer "........."
    En de persoon heeft geen ander actueel reisdocument
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord _links.reisdocumenten niet aanwezig

  Scenario: vullen van indicatieVestigingVanuitBuitenland
    Gegeven de registratie persoon 999990317 kent een verblijfplaats.datumVestigingInNederland = 19900808
    Als de persoon met burgerservicenummer 999990317 wordt geraadpleegd
    Dan heeft in het antwoord verblijfplaats.datumVestigingInNederland.datum de waarde 1990-08-08
    En heeft attribuut verblijfplaats.indicatieVestigingVanuitBuitenland de waarde true

    Gegeven de registratie persoon kent een verblijfplaats.datumVestigingInNederland = 00000000
    Als de persoon wordt geraadpleegd
    Dan heeft attribuut verblijfplaats.indicatieVestigingVanuitBuitenland de waarde true
    En is in het antwoord verblijfplaats.datumVestigingInNederland niet aanwezig

    Gegeven de registratie persoon 999993653 kent geen verblijfplaats.datumVestigingInNederland
    Als de persoon met burgerservicenummer 999993653 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.datumVestigingInNederland niet aanwezig
    En is in het antwoord verblijfplaats.indicatieVestigingVanuitBuitenland niet aanwezig

  Scenario: vullen van vanuitVertrokkenOnbekendWaarheen
    Gegeven de registratie persoon 999995121 kent een verblijfplaats.landVanwaarIngeschreven = 0000
    Als de persoon met burgerservicenummer 999995121 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.landVanwaarIngeschreven niet aanwezig
    En heeft attribuut verblijfplaats.vanuitVertrokkenOnbekendWaarheen de waarde true

    Gegeven de registratie persoon 999990317 kent een verblijfplaats.landVanwaarIngeschreven = 7046
    Als de persoon met burgerservicenummer 999990317 wordt geraadpleegd
    Dan heeft attribuut verblijfplaats.landVanwaarIngeschreven.code de waarde 7046
    En is in het antwoord verblijfplaats.vanuitVertrokkenOnbekendWaarheen niet aanwezig

    Gegeven de registratie persoon 999993653 kent geen verblijfplaats.landVanwaarIngeschreven
    Als de persoon met burgerservicenummer 999993653 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.landVanwaarIngeschreven niet aanwezig
    En is in het antwoord verblijfplaats.vanuitVertrokkenOnbekendWaarheen niet aanwezig

  Scenario: vullen van vertrokkenOnbekendWaarheen
    Gegeven de registratie persoon 999993586 kent een verblijfplaats.verblijfBuitenland.land = 0000
    Als de persoon met burgerservicenummer 999993586 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.verblijfBuitenland.land niet aanwezig
    En heeft attribuut verblijfplaats.verblijfBuitenland.vertrokkenOnbekendWaarheen de waarde true

    Gegeven de registratie persoon 999992326 kent een verblijfplaats.verblijfBuitenland.land = 6003
    Als de persoon met burgerservicenummer 999992326 wordt geraadpleegd
    Dan heeft attribuut verblijfplaats.verblijfBuitenland.land.code de waarde 6003
    En is in het antwoord verblijfplaats.verblijfBuitenland.vertrokkenOnbekendWaarheen niet aanwezig

    Gegeven de registratie persoon 999993653 is in een Nederlandse gemeente
    Als de persoon met burgerservicenummer 999993653 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.verblijfBuitenland niet aanwezig

Rule: vertalen (onbekend)waarden naar indicator
  - elke waarde voor datumVestigingInNederland (incl. 00000000) geeft indicatieVestigingVanuitBuitenland met de waarde true
  - onbekend land vanwaar ingeschreven (waarde 0000) geeft vanuitVerblijfplaatsOnbekend met de waarde true
  - onbekend land verblijf buitenland (waarde 0000) geeft verblijfplaatsOnbekend
  - elke waarde voor overlijdensdatum (incl. 00000000) geeft indicatieOverleden met de waarde true

  Abstract Scenario: indicatieVestigingVanuitBuitenland en vanuitVerblijfplaatsOnbekend bij datum vestiging '<datum>' uit land '<land>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende verblijfplaats gegevens
    | naam                      | waarde  |
    | datumVestigingInNederland | <datum> |
    | landVanwaarIngeschreven   | <land>  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                            |
    | type                | RaadpleegMetBurgerservicenummer                                                                                   |
    | burgerservicenummer | 999992934                                                                                                         |
    | fields              | burgerservicenummer,verblijfplaats.indicatieVestigingVanuitBuitenland,verblijfplaats.vanuitVerblijfplaatsOnbekend |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                               |
    | indicatieVestigingVanuitBuitenland | <indicatieVestigingVanuitBuitenland> |
    | vanuitVerblijfplaatsOnbekend       | <vanuitVerblijfplaatsOnbekend>       |

    Voorbeelden:
    | datum    | land | indicatieVestigingVanuitBuitenland | vanuitVerblijfplaatsOnbekend |
    | 19871402 | 6023 | true                               |                              |
    | 19490000 | 6024 | true                               |                              |
    | 19931100 | 6065 | true                               |                              |
    | 00000000 | 6029 | true                               |                              |
    | 19871402 | 0000 | true                               | true                         |
    | 00000000 | 0000 | true                               | true                         |
    |          |      |                                    |                              |

  Abstract Scenario: verblijfplaatsOnbekend bij land verblijfplaats '<land>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende verblijfplaats gegevens
    | naam                | waarde       |
    | land                | <land>       |
    | adresregel1         |              |
    | adresregel2         | <adresregel2> |
    | straat              | <straat>     |
    | huisnummer          | <huisnummer> |
    | postcode            |              |
    | locatiebeschrijving |              |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                    |
    | type                | RaadpleegMetBurgerservicenummer                           |
    | burgerservicenummer | 999992934                                                 |
    | fields              | burgerservicenummer,verblijfplaats.type,verblijfplaats.verblijfplaatsOnbekend |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' de volgende 'verblijfplaats' gegevens
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
    En de persoon heeft de volgende overlijden gegevens
    | naam   | waarde   |
    | datum  | <datum>  |
    | plaats | <plaats> |
    | land   | <land>   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 999992934                                         |
    | fields              | burgerservicenummer,overlijden.indicatieOverleden |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' de volgende 'overlijden' gegevens
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
