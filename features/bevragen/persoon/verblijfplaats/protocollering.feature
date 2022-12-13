#language: nl

Functionaliteit: protocollering gevraagde en geleverde gegevens verblijfplaats

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 8468619643 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | gemeente van inschrijving (09.10)  | 0518     |
      | functie adres (10.10)              | W        |
      | datum aanvang adreshouding (10.30) | 20190714 |
      | datum ingang geldigheid (85.10)    | 20190714 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde           |
      | gemeente_code                              | 0518             |
      | straatnaam (11.10)                         | Borgesiusstraat  |
      | naam openbare ruimte (11.15)               | Borgesiusstraat  |
      | huisnummer (11.20)                         | 103              |
      | huisletter (11.30)                         | b                |
      | huisnummertoevoeging (11.40)               | 2                |
      | postcode (11.60)                           | 2497BV           |
      | woonplaats (11.70)                         | Scheveningen     |
      | identificatiecode verblijfplaats (11.80)   | 0518010000747448 |
      | identificatiecode nummeraanduiding (11.90) | 0518200000747446 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 4767504128 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | gemeente van inschrijving (09.10)  | 0628     |
      | functie adres (10.10)              | W        |
      | datum aanvang adreshouding (10.30) | 20141003 |
      | datum ingang geldigheid (85.10)    | 20141003 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde   |
      | gemeente_code                     | 0628     |
      | straatnaam (11.10)                | Zijldijk |
      | huisnummer (11.20)                | 11       |
      | aanduiding bij huisnummer (11.50) | by       |
      | postcode (11.60)                  | 2362XJ   |
      En de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5875306514 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | gemeente van inschrijving (09.10)  | 0628     |
      | functie adres (10.10)              | W        |
      | datum aanvang adreshouding (10.30) | 20141003 |
      | datum ingang geldigheid (85.10)    | 20141003 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                        | waarde                            |
      | gemeente_code               | 0530                              |
      | locatiebeschrijving (12.10) | Woonboot tegenover de Grote Sloot |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 7946419843 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde          |
      | gemeente van inschrijving (09.10)      | 1999            |
      | land (13.10)                           | 5010            |
      | datum aanvang adres buitenland (13.20) | 20210301        |
      | regel 1 adres buitenland (13.30)       | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40)       | Bruxelles       |
      | regel 3 adres buitenland (13.50)       | postcode 1000   |
      En de persoon met burgerservicenummer '000000061' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 1041968780 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | gemeente van inschrijving (09.10)      | 1999     |
      | land (13.10)                           | 0000     |
      | datum aanvang adres buitenland (13.20) | 00000000 |


  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden opgenomen.
    # het is nog niet duidelijk in hoeverre de volgorde van rubrieken een bepaalde volgorde of sortering aan moet houden (voor testbaarheid is dat wel nodig)

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als zoekrubrieken <zoek rubrieken>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_zoek_rubrieken |
      | 8468619643 | <zoek rubrieken>       |

      Voorbeelden:
      | fields                                                    | zoek rubrieken                                                                                                                       |
      | verblijfplaats.functieAdres                               | 081010 081110 081210 081310                                                                                                          |
      | verblijfplaats.adresseerbaarObjectIdentificatie           | 081110 081180 081210 081310                                                                                                          |
      | verblijfplaats.nummeraanduidingIdentificatie              | 081110 081190 081210 081310                                                                                                          |
      | verblijfplaats.datumVan                                   | 081030 081110 081210 081310 081320                                                                                                   |
      | verblijfplaats.verblijfadres.korteNaam                    | 081110 081210 081310                                                                                                                 |
      | verblijfplaats.verblijfadres.straat                       | 081110 081115 081210 081310                                                                                                          |
      | verblijfplaats.verblijfadres.huisnummer                   | 081110 081120 081210 081310                                                                                                          |
      | verblijfplaats.verblijfadres.huisletter                   | 081110 081130 081210 081310                                                                                                          |
      | verblijfplaats.verblijfadres.huisnummertoevoeging         | 081110 081140 081210 081310                                                                                                          |
      | verblijfplaats.verblijfadres.aanduidingBijHuisnummer      | 081110 081150 081210 081310                                                                                                          |
      | verblijfplaats.verblijfadres.postcode                     | 081110 081160 081210 081310                                                                                                          |
      | verblijfplaats.verblijfadres.woonplaats                   | 081110 081170 081210 081310                                                                                                          |
      | verblijfplaats.verblijfadres.locatiebeschrijving          | 081110 081210 081310                                                                                                                 |
      | verblijfplaats.verblijfadres.land                         | 081110 081210 081310                                                                                                                 |
      | verblijfplaats.verblijfadres.regel1                       | 081110 081210 081310 081330                                                                                                          |
      | verblijfplaats.verblijfadres.regel2                       | 081110 081210 081310 081340                                                                                                          |
      | verblijfplaats.verblijfadres.regel3                       | 081110 081210 081310 081350                                                                                                          |
      | verblijfplaats.datumIngangGeldigheid                      | 081110 081210 081310 088510                                                                                                          |
      | verblijfplaats.verblijfadres                              | 081110 081115 081120 081130 081140 081150 081160 081170 081210 081310 081330 081340 081350                                           |
      | verblijfplaats                                            | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 081310 081320 081330 081340 081350 088510 |
      | verblijfplaatsBinnenland.datumVan                         | 081030 081110 081210                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid            | 081110 081210 088510                                                                                                                 |
      | verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie | 081110 081180 081210                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres                    | 081110 081115 081120 081130 081140 081150 081160 081170 081210                                                                       |
      | verblijfplaatsBinnenland                                  | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 088510                                    |

  Rule: In het antwoord geleverde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Alleen velden die echt geleverd zijn, dus een waarde hebben in de response, worden opgenomen als geleverde rubriek
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden opgenomen.
    
    Abstract Scenario: Gevraagde veld <fields veld> wordt vastgelegd als geleverde rubriek <rubrieknummer>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>                       |
      | fields              | <fields>         |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_geleverde_rubrieken |
      | <A-nummer> | <geleverde rubrieken>       |

      Voorbeelden:
      | A-nummer   | burgerservicenummer | fields                                 | geleverde rubrieken                                                                        |
      | 8468619643 | 000000012           | verblijfplaats.datumVan                | 081030 081110                                                                              |
      | 8468619643 | 000000012           | verblijfplaats.verblijfadres           | 081110 081115 081120 081130 081140 081160 081170                                           |
      | 8468619643 | 000000012           | verblijfplaatsBinnenland.verblijfadres | 081110 081115 081120 081130 081140 081160 081170                                           |
      | 8468619643 | 000000012           | verblijfplaats                         | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 088510 |
      | 8468619643 | 000000012           | verblijfplaatsBinnenland               | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 088510 |
      | 4767504128 | 000000024           | verblijfplaats.datumVan                | 081030 081110                                                                              |
      | 4767504128 | 000000024           | verblijfplaats.verblijfadres           | 081110 081120 081150 081170                                                                |
      | 4767504128 | 000000024           | verblijfplaatsBinnenland.verblijfadres | 081110 081120 081150 081170                                                                |
      | 4767504128 | 000000024           | verblijfplaats                         | 081010 081030 081110 081120 081150 081170 088510                                           |
      | 4767504128 | 000000024           | verblijfplaatsBinnenland               | 081010 081030 081110 081120 081150 081170 088510                                           |
      | 5875306514 | 000000036           | verblijfplaats.datumVan                | 081030 081210                                                                              |
      | 5875306514 | 000000036           | verblijfplaats.verblijfadres           | 081210                                                                                     |
      | 5875306514 | 000000036           | verblijfplaatsBinnenland.verblijfadres | 081210                                                                                     |
      | 5875306514 | 000000036           | verblijfplaats                         | 081010 081030 081210 088510                                                                |
      | 5875306514 | 000000036           | verblijfplaatsBinnenland               | 081010 081030 081210 088510                                                                |
      | 7946419843 | 000000048           | verblijfplaats.datumVan                | 081310 081320                                                                              |
      | 7946419843 | 000000048           | verblijfplaats.verblijfadres           | 081310 081330 081340 081350                                                                |
      | 7946419843 | 000000048           | verblijfplaatsBinnenland.verblijfadres |                                                                                            |
      | 7946419843 | 000000048           | verblijfplaats                         | 081310 081320 081330 081340 081350 088510                                                  |
      | 7946419843 | 000000048           | verblijfplaatsBinnenland               |                                                                                            |
      | 1041968780 | 000000061           | verblijfplaats.datumVan                | 081310 081320                                                                              |
      | 1041968780 | 000000061           | verblijfplaats.verblijfadres           | 081310                                                                                     |
      | 1041968780 | 000000061           | verblijfplaatsBinnenland.verblijfadres |                                                                                            |
      | 1041968780 | 000000061           | verblijfplaats                         | 081310 081320 088510                                                                       |
      | 1041968780 | 000000061           | verblijfplaatsBinnenland               |                                                                                            |
