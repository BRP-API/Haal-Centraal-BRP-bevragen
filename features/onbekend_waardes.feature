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
    | naam               | waarde   |
    | <veld> (<element>) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende '<groep>' gegevens NIET
    | naam   |
    | <veld> |

    Voorbeelden:
    | groep          | veld                             | element | waarde           |
    | naam           | geslachtsnaam                    | 02.40   | .                |
    | verblijfplaats | straat                           | 11.10   | .                |
    | verblijfplaats | huisnummer                       | 11.20   | 0                |
    | verblijfplaats | woonplaats                       | 11.70   | .                |
    | verblijfplaats | nummeraanduidingIdentificatie    | 11.90   | 0000000000000000 |
    | verblijfplaats | adresseerbaarObjectIdentificatie | 11.80   | 0000000000000000 |

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
    En de persoon met burgerservicenummer '999992934' heeft de volgende actueel geldige reisdocumentnummers (35.20)
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
    En bevat de persoon met burgerservicenummer '999992934' alleen de volgende 'reisdocumentnummers'
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
    | naam               | waarde   |
    | <veld> (<element>) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 999992934                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan bevat de persoon met burgerservicenummer '999992934' alleen de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |

    Voorbeelden:
    | groep          | veld                    | element | waarde |
    | geboorte       | plaats                  | 03.20   | 0000   |
    | geboorte       | land                    | 03.30   | 0000   |
    | overlijden     | plaats                  | 08.20   | 0000   |
    | overlijden     | land                    | 08.30   | 0000   |
    | verblijfplaats | gemeenteVanInschrijving | 09.10   | 0000   |
    | verblijfplaats | land                    | 13.10   | 0000   |
    | verblijfplaats | landVanwaarIngeschreven | 14.10   | 0000   |
    | verblijfstitel | aanduiding              | 39.10   | 00     |

  Scenario: buitenlandse plaats zonder code
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon heeft de volgende geboorte gegevens
    | naam           | waarde  |
    | plaats (03.20) | Brussel |
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
    | naam               | waarde   |
    | <veld> (<element>) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                     |
    | type                | RaadpleegMetBurgerservicenummer                                            |
    | burgerservicenummer | 999992934                                                                  |
    | fields              | burgerservicenummer,<relatie>.burgerservicenummer,<relatie>.<groep>.<veld> |
    Dan bevat de persoon met burgerservicenummer '999992934' alleen de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |

    Voorbeelden:
    | relatie  | groep                       | veld   | element | waarde |
    | ouders   | geboorte                    | plaats | 03.20   | 0000   |
    | ouders   | geboorte                    | land   | 03.30   | 0000   |
    | partners | geboorte                    | plaats | 03.20   | 0000   |
    | partners | geboorte                    | land   | 03.30   | 0000   |
    | partners | aangaanHuwelijkPartnerschap | plaats | 06.20   | 0000   |
    | partners | aangaanHuwelijkPartnerschap | land   | 06.30   | 0000   |
    | kinderen | geboorte                    | plaats | 03.20   | 0000   |
    | kinderen | geboorte                    | land   | 03.30   | 0000   |

  Scenario: onbekend waarde voor nationaliteit
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon met burgerservicenummer '999992934' heeft de volgende nationaliteit gegevens
    | naam                          | waarde   |
    | nationaliteit (05.10)         | 0000     |
    | redenOpname (63.10)           | 311      |
    | datumIngangGeldigheid (85.10) | 20030417 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 999992934                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' een nationaliteit met alleen de volgende gegevens
    | redenOpname           | 311        |
    | datumIngangGeldigheid | 2003-04-17 |

  Scenario: onbekend waarde voor reden opname nationaliteit
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    En de persoon met burgerservicenummer '999992934' heeft de volgende nationaliteit gegevens
    | naam                          | waarde   |
    | nationaliteit (05.10)         | 0052     |
    | redenOpname (63.10)           | 000      |
    | datumIngangGeldigheid (85.10) | 20030417 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 999992934                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' een nationaliteit met alleen de volgende gegevens
    | nationaliteit         | 0052       |
    | datumIngangGeldigheid | 2003-04-17 |

Rule: de onbekendwaarde voor geslachtsaanduiding wordt wel geleverd

  Scenario: een onbekendwaarde bij geslachtsaanduiding wordt wel opgenomen in de response
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer         | 999992934 |
    | geslachtsaanduiding (04.10) | O         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999992934                               |
    | fields              | burgerservicenummer,geslachtsaanduiding |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    | geslachtsaanduiding | O         |

Rule: de onbekendwaarde voor redenOpschortingBijhouding wordt wel geleverd

  Scenario: een onbekendwaarde bij reden opschorting bijhouding wordt wel opgenomen in de response
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer         | 999992934 |
    En de persoon heeft de volgende opschortingBijhouding gegevens
    | naam          | waarde   |
    | datum (67.10) | 20211218 |
    | reden (67.20) | .        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999992934                               |
    | fields              | burgerservicenummer,redenOpschortingBijhouding |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '999992934' de volgende 'opschortingBijhouding' gegevens
    | naam  | waarde     |
    | reden | .          |
    | datum | 2021-12-18 |

Rule: datumvelden waarde "00000000": worden vertaald naar DatumOnbekend

  Abstract Scenario: volledig onbekende datum in <groep> <element>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende <groep> gegevens
    | naam      | waarde   |
    | <element> | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 555550001                          |
    | fields              | burgerservicenummer,<groep>.<veld> |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 999992934 |
    En bevat de persoon met burgerservicenummer '555550001' alleen de volgende '<groep>' gegevens
    | naam               | waarde        |
    | datum.type         | DatumOnbekend |
    | datum.onbekend     | true          |

    Voorbeelden:
    | groep                 | element                                       | veld                                  |
    | geboorte              | datum (03.10)                                 | datum                                 |
    | overlijden            | datum (08.10)                                 | datum                                 |
    | opschortingBijhouding | datum (67.10)                                 | datum                                 |
    | verblijfplaats        | datumInschrijvingInGemeente (09.20)           | datumInschrijvingInGemeente           |
    | verblijfplaats        | datumAanvangAdreshouding (10.30)              | datumVan                              |
    | verblijfplaats        | datumAanvangAdresBuitenland (13.20)           | datumVan                              |
    | verblijfstitel        | datumEinde (39.20)                            | datumEinde                            |
    | verblijfstitel        | datumIngang (39.30)                           | datumIngang                           |
    | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht (31.30) | einddatumUitsluitingEuropeesKiesrecht |
    | kiesrecht             | einddatumUitsluitingKiesrecht (38.30)         | einddatumUitsluitingKiesrecht         |

  Abstract Scenario: volledig onbekende datum bij <relatie> in <groep> datum
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 555550001  |
    En de persoon heeft een <relatie> met de volgende gegevens
    | naam                        | waarde             |
    | burgerservicenummer         | 555550002          |
    En de <relatie> met burgerservicenummer '555550002' heeft de volgende <groep> gegevens
    | naam              | waarde   |
    | datum (<element>) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                     |
    | type                | RaadpleegMetBurgerservicenummer                                            |
    | burgerservicenummer | 555550001                                                                  |
    | fields              | burgerservicenummer,<relatie>.burgerservicenummer,<relatie>.<groep>.<veld> |
    Dan bevat de <relatie> met burgerservicenummer '555550002' alleen de volgende '<groep>' gegevens
    | naam           | waarde        |
    | datum.type     | DatumOnbekend |
    | datum.onbekend | true          |

    Voorbeelden:
    | relatie  | groep                       | element |
    | ouders   | geboorte                    | 03.10   |
    | partners | aangaanHuwelijkPartnerschap | 06.10   |
    | partners | geboorte                    | 03.10   |
    | kinderen | geboorte                    | 03.10   |

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
    |          |        |      |                    |
