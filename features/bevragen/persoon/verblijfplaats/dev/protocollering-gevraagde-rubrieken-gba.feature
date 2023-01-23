#language: nl

Functionaliteit: protocollering van de gevraagde gegevens voor verblijfplaats 

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden vastgelegd in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 8468619643 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                                    | gevraagde rubrieken                                                                                                                                    |
      | verblijfplaats.functieAdres                               | 081010, 081110, 081210, 081310                                                                                                                         |
      | verblijfplaats.adresseerbaarObjectIdentificatie           | 081110, 081180, 081210, 081310                                                                                                                         |
      | verblijfplaats.nummeraanduidingIdentificatie              | 081110, 081190, 081210, 081310                                                                                                                         |
      | verblijfplaats.datumVan                                   | 081030, 081110, 081210, 081310, 081320                                                                                                                 |
      | verblijfplaats.verblijfadres.korteNaam                    | 081110, 081210, 081310                                                                                                                                 |
      | verblijfplaats.verblijfadres.straat                       | 081110, 081115, 081210, 081310                                                                                                                         |
      | verblijfplaats.verblijfadres.huisnummer                   | 081110, 081120, 081210, 081310                                                                                                                         |
      | verblijfplaats.verblijfadres.huisletter                   | 081110, 081130, 081210, 081310                                                                                                                         |
      | verblijfplaats.verblijfadres.huisnummertoevoeging         | 081110, 081140, 081210, 081310                                                                                                                         |
      | verblijfplaats.verblijfadres.aanduidingBijHuisnummer      | 081110, 081150, 081210, 081310                                                                                                                         |
      | verblijfplaats.verblijfadres.postcode                     | 081110, 081160, 081210, 081310                                                                                                                         |
      | verblijfplaats.verblijfadres.woonplaats                   | 081110, 081170, 081210, 081310                                                                                                                         |
      | verblijfplaats.verblijfadres.locatiebeschrijving          | 081110, 081210, 081310                                                                                                                                 |
      | verblijfplaats.verblijfadres.land                         | 081110, 081210, 081310                                                                                                                                 |
      | verblijfplaats.verblijfadres.regel1                       | 081110, 081210, 081310, 081330                                                                                                                         |
      | verblijfplaats.verblijfadres.regel2                       | 081110, 081210, 081310, 081340                                                                                                                         |
      | verblijfplaats.verblijfadres.regel3                       | 081110, 081210, 081310, 081350                                                                                                                         |
      | verblijfplaats.datumIngangGeldigheid                      | 081110, 081210, 081310, 088510                                                                                                                         |
      | verblijfplaats.verblijfadres                              | 081110, 081115, 081120, 081130, 081140, 081150, 081160, 081170, 081210, 081310, 081330, 081340, 081350                                                 |
      | verblijfplaats                                            | 081010, 081030, 081110, 081115, 081120, 081130, 081140, 081150, 081160, 081170, 081180, 081190, 081210, 081310, 081320, 081330, 081340, 081350, 088510 |
      | verblijfplaatsBinnenland.datumVan                         | 081030, 081110, 081210                                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid            | 081110, 081210, 088510                                                                                                                                 |
      | verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie | 081110, 081180, 081210                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres                    | 081110, 081115, 081120, 081130, 081140, 081150, 081160, 081170, 081210                                                                                 |
      | verblijfplaatsBinnenland                                  | 081010, 081030, 081110, 081115, 081120, 081130, 081140, 081150, 081160, 081170, 081180, 081190, 081210, 088510                                         |
