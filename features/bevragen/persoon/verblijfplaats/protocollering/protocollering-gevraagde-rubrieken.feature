#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor verblijfplaats 

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden vastgelegd in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 8016043787 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | gemeente van inschrijving (09.10)  | 0518     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde           |
      | gemeente_code                              | 0518             |
      | straatnaam (11.10)                         | Borgesiusstraat  |
      | huisnummer (11.20)                         | 103              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                                                      | gevraagde rubrieken                                                                                                                                    |
      | verblijfplaats.type                                                         | PAVP02                                                                                                                                                 |
      | verblijfplaats.functieAdres                                                 | 081010                                                                                                                                                 |
      | verblijfplaats.datumVan                                                     | PAVP01                                                                                                                                                 |
      | verblijfplaats.datumVan.type                                                | PAVP01                                                                                                                                                 |
      | verblijfplaats.datumVan.datum                                               | PAVP01                                                                                                                                                 |
      | verblijfplaats.datumVan.langFormaat                                         | PAVP01                                                                                                                                                 |
      | verblijfplaats.datumVan.jaar                                                | PAVP01                                                                                                                                                 |
      | verblijfplaats.datumVan.maand                                               | PAVP01                                                                                                                                                 |
      | verblijfplaats.datumVan.onbekend                                            | PAVP01                                                                                                                                                 |
      | verblijfplaats.verblijfadres.korteStraatnaam                                | 081110                                                                                                                                                 |
      | verblijfplaats.verblijfadres.officieleStraatnaam                            | 081115                                                                                                                                                 |
      | verblijfplaats.verblijfadres.huisnummer                                     | 081120                                                                                                                                                 |
      | verblijfplaats.verblijfadres.huisletter                                     | 081130                                                                                                                                                 |
      | verblijfplaats.verblijfadres.huisnummertoevoeging                           | 081140                                                                                                                                                 |
      | verblijfplaats.verblijfadres.aanduidingBijHuisnummer                        | 081150                                                                                                                                                 |
      | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.code                   | 081150                                                                                                                                                 |
      | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.omschrijving           | 081150                                                                                                                                                 |
      | verblijfplaats.verblijfadres.postcode                                       | 081160                                                                                                                                                 |
      | verblijfplaats.verblijfadres.woonplaats                                     | 081170                                                                                                                                                 |
      | verblijfplaats.verblijfadres.locatiebeschrijving                            | 081210                                                                                                                                                 |
      | verblijfplaats.verblijfadres.land                                           | 081310                                                                                                                                                 |
      | verblijfplaats.verblijfadres.land.code                                      | 081310                                                                                                                                                 |
      | verblijfplaats.verblijfadres.land.omschrijving                              | 081310                                                                                                                                                 |
      | verblijfplaats.verblijfadres.regel1                                         | 081330                                                                                                                                                 |
      | verblijfplaats.verblijfadres.regel2                                         | 081340                                                                                                                                                 |
      | verblijfplaats.verblijfadres.regel3                                         | 081350                                                                                                                                                 |
      | verblijfplaats.adresseerbaarObjectIdentificatie                             | 081180                                                                                                                                                 |
      | verblijfplaats.nummeraanduidingIdentificatie                                | 081190                                                                                                                                                 |
      | verblijfplaats.datumIngangGeldigheid                                        | 088510                                                                                                                                                 |
      | verblijfplaats.datumIngangGeldigheid.type                                   | 088510                                                                                                                                                 |
      | verblijfplaats.datumIngangGeldigheid.datum                                  | 088510                                                                                                                                                 |
      | verblijfplaats.datumIngangGeldigheid.langFormaat                            | 088510                                                                                                                                                 |
      | verblijfplaats.datumIngangGeldigheid.jaar                                   | 088510                                                                                                                                                 |
      | verblijfplaats.datumIngangGeldigheid.maand                                  | 088510                                                                                                                                                 |
      | verblijfplaats.datumIngangGeldigheid.onbekend                               | 088510                                                                                                                                                 |
      | verblijfplaats.verblijfadres                                                | 081110, 081115, 081120, 081130, 081140, 081150, 081160, 081170, 081210, 081310, 081330, 081340, 081350                                                 |
      | verblijfplaats                                                              | 081010, 081110, 081115, 081120, 081130, 081140, 081150, 081160, 081170, 081180, 081190, 081210, 081310, 081330, 081340, 081350, 088510, PAVP01, PAVP02 |
      | verblijfplaatsBinnenland.type                                               | PAVP02                                                                                                                                                 |
      | verblijfplaatsBinnenland.functieAdres                                       | 081010                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumVan                                           | PAVP01                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumVan.type                                      | PAVP01                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumVan.datum                                     | PAVP01                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumVan.langFormaat                               | PAVP01                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumVan.jaar                                      | PAVP01                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumVan.maand                                     | PAVP01                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumVan.onbekend                                  | PAVP01                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.korteStraatnaam                      | 081110                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.officieleStraatnaam                  | 081115                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.huisnummer                           | 081120                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.huisletter                           | 081130                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.huisnummertoevoeging                 | 081140                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer              | 081150                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.code         | 081150                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.omschrijving | 081150                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.postcode                             | 081160                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.woonplaats                           | 081170                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving                  | 081210                                                                                                                                                 |
      | verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie                   | 081180                                                                                                                                                 |
      | verblijfplaatsBinnenland.nummeraanduidingIdentificatie                      | 081190                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid                              | 088510                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid.type                         | 088510                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid.datum                        | 088510                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid.langFormaat                  | 088510                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid.jaar                         | 088510                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid.maand                        | 088510                                                                                                                                                 |
      | verblijfplaatsBinnenland.datumIngangGeldigheid.onbekend                     | 088510                                                                                                                                                 |
      | verblijfplaatsBinnenland.verblijfadres                                      | 081110, 081115, 081120, 081130, 081140, 081150, 081160, 081170, 081210                                                                                 |
      | verblijfplaatsBinnenland                                                    | 081010, 081110, 081115, 081120, 081130, 081140, 081150, 081160, 081170, 081180, 081190, 081210, 088510, PAVP01, PAVP02                                 |
