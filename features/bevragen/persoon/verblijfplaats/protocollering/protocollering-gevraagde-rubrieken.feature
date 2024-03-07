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
      | fields                                             | gevraagde rubrieken                                                                 |
      | functieAdres                                       | 81010                                                                               |
      | verblijfplaats.datumVan                            | PAVP01                                                                              |
      | verblijfplaats.datumVan.type                       | PAVP01                                                                              |
      | verblijfplaats.datumVan.datum                      | PAVP01                                                                              |
      | verblijfplaats.datumVan.langFormaat                | PAVP01                                                                              |
      | verblijfplaats.datumVan.jaar                       | PAVP01                                                                              |
      | verblijfplaats.datumVan.maand                      | PAVP01                                                                              |
      | verblijfplaats.datumVan.onbekend                   | PAVP01                                                                              |
      | verblijfadres.korteStraatnaam                      | 81110                                                                               |
      | verblijfadres.officieleStraatnaam                  | 81115                                                                               |
      | verblijfadres.huisnummer                           | 81120                                                                               |
      | verblijfadres.huisletter                           | 81130                                                                               |
      | verblijfadres.huisnummertoevoeging                 | 81140                                                                               |
      | verblijfadres.aanduidingBijHuisnummer              | 81150                                                                               |
      | verblijfadres.aanduidingBijHuisnummer.code         | 81150                                                                               |
      | verblijfadres.aanduidingBijHuisnummer.omschrijving | 81150                                                                               |
      | verblijfadres.postcode                             | 81160                                                                               |
      | verblijfadres.woonplaats                           | 81170                                                                               |
      | verblijfadres.locatiebeschrijving                  | 81210                                                                               |
      | verblijfadres.land                                 | 81210                                                                               |
      | verblijfadres.land.code                            | 81210                                                                               |
      | verblijfadres.land.omschrijving                    | 81210                                                                               |
      | verblijfadres.regel1                               | 81330                                                                               |
      | verblijfadres.regel2                               | 81340                                                                               |
      | verblijfadres.regel3                               | 81350                                                                               |
      | adresseerbaarObjectIdentificatie                   | 81180                                                                               |
      | nummeraanduidingIdentificatie                      | 81190                                                                               |
      | datumIngangGeldigheid                              | 88510                                                                               |
      | datumIngangGeldigheid.type                         | 88510                                                                               |
      | datumIngangGeldigheid.datum                        | 88510                                                                               |
      | datumIngangGeldigheid.langFormaat                  | 88510                                                                               |
      | datumIngangGeldigheid.jaar                         | 88510                                                                               |
      | datumIngangGeldigheid.maand                        | 88510                                                                               |
      | datumIngangGeldigheid.onbekend                     | 88510                                                                               |
      | verblijfadres                                      | 81010 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 81330 81340 81350 |
