# language: nl

@autorisatie
Functionaliteit: autorisatie verblijfplaatsgegevens Persoon

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 19860801                           |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                         | waarde          |
      | gemeentecode (92.10)         | 0800            |
      | straatnaam (11.10)           | Borgesiusstraat |
      | huisnummer (11.20)           | 103             |
      | huisletter (11.30)           | b               |
      | huisnummertoevoeging (11.40) | 2               |
      | postcode (11.60)             | 2497BV          |
      | woonplaats (11.70)           | Scheveningen    |


  Rule: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    Om een veld te mogen vragen moet de afnemer geautoriseerd zijn voor alle LO BRP rubrieken waar het veld mee gevuld of van afgeleid wordt

    @fout-case
    Abstract Scenario: Afnemer vraagt <gevraagd veld> (<missende autorisatie>), waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 000000024                                          |
      | fields              | burgerservicenummer,verblijfplaats.<gevraagd veld> |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | gevraagd veld                                   | ad hoc rubrieken                                                                                                               | missende autorisatie        |
      | functieAdres                                    | 10120 80910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81010                       |
      | datumVan                                        | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510  | PAVP01                      |
      | verblijfadres.korteStraatnaam                   | 10120 80910 81010 81030 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81110                       |
      | verblijfadres.officieleStraatnaam               | 10120 80910 81010 81030 81110 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81115                       |
      | verblijfadres.huisnummer                        | 10120 80910 81010 81030 81110 81115 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81120                       |
      | verblijfadres.huisletter                        | 10120 80910 81010 81030 81110 81115 81120 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81130                       |
      | verblijfadres.huisnummertoevoeging              | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                       |
      | verblijfadres.huisnummertoevoeging.code         | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                       |
      | verblijfadres.huisnummertoevoeging.omschrijving | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                       |
      | verblijfadres.aanduidingBijHuisnummer           | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81150                       |
      | verblijfadres.postcode                          | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81160                       |
      | verblijfadres.woonplaats                        | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81170                       |
      | verblijfadres.land                              | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                       |
      | verblijfadres.land.code                         | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                       |
      | verblijfadres.land.omschrijving                 | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                       |
      | verblijfadres.regel1                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81340 81350 88510 PAVP01 | 81330                       |
      | verblijfadres.regel2                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81350 88510 PAVP01 | 81340                       |
      | verblijfadres.regel3                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 88510 PAVP01 | 81350                       |
      | adresseerbaarObjectIdentificatie                | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81180                       |
      | nummeraanduidingIdentificatie                   | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81190                       |
      | datumIngangGeldigheid                           | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.type                      | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.datum                     | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.langFormaat               | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.jaar                      | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.maand                     | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.onbekend                  | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      
    Abstract Scenario: Afnemer vraagt <gevraagd veld>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 000000024                                          |
      | fields              | burgerservicenummer,verblijfplaats.<gevraagd veld> |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | gevraagd veld                                      | ad hoc rubrieken                                                              |
      | functieAdres                                       | 81010                                                                         |
      | verblijfplaats.datumVan                            | PAVP01                                                                        |
      | verblijfplaats.datumVan.type                       | PAVP01                                                                        |
      | verblijfplaats.datumVan.datum                      | PAVP01                                                                        |
      | verblijfplaats.datumVan.langFormaat                | PAVP01                                                                        |
      | verblijfplaats.datumVan.jaar                       | PAVP01                                                                        |
      | verblijfplaats.datumVan.maand                      | PAVP01                                                                        |
      | verblijfplaats.datumVan.onbekend                   | PAVP01                                                                        |
      | verblijfadres.korteStraatnaam                      | 81110                                                                         |
      | verblijfadres.officieleStraatnaam                  | 81115                                                                         |
      | verblijfadres.huisnummer                           | 81120                                                                         |
      | verblijfadres.huisletter                           | 81130                                                                         |
      | verblijfadres.huisnummertoevoeging                 | 81140                                                                         |
      | verblijfadres.aanduidingBijHuisnummer              | 81150                                                                         |
      | verblijfadres.aanduidingBijHuisnummer.code         | 81150                                                                         |
      | verblijfadres.aanduidingBijHuisnummer.omschrijving | 81150                                                                         |
      | verblijfadres.postcode                             | 81160                                                                         |
      | verblijfadres.woonplaats                           | 81170                                                                         |
      | verblijfadres.locatiebeschrijving                  | 81210                                                                         |
      | verblijfadres.land                                 | 81210                                                                         |
      | verblijfadres.land.code                            | 81210                                                                         |
      | verblijfadres.land.omschrijving                    | 81210                                                                         |
      | verblijfadres.regel1                               | 81330                                                                         |
      | verblijfadres.regel2                               | 81340                                                                         |
      | verblijfadres.regel3                               | 81350                                                                         |
      | adresseerbaarObjectIdentificatie                   | 81180                                                                         |
      | nummeraanduidingIdentificatie                      | 81190                                                                         |
      | datumIngangGeldigheid                              | 88510                                                                         |
      | datumIngangGeldigheid.type                         | 88510                                                                         |
      | datumIngangGeldigheid.datum                        | 88510                                                                         |
      | datumIngangGeldigheid.langFormaat                  | 88510                                                                         |
      | datumIngangGeldigheid.jaar                         | 88510                                                                         |
      | datumIngangGeldigheid.maand                        | 88510                                                                         |
      | datumIngangGeldigheid.onbekend                     | 88510                                                                         |
      | verblijfadres                                      | 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 81330 81340 81350 |

    @fout-case
    Abstract Scenario: Afnemer vraagt om groep verblijfadres en is niet geautoriseerd voor <ontbrekende autorisatie veld> (<missende autorisatie>)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                           |
      | type                | RaadpleegMetBurgerservicenummer                  |
      | burgerservicenummer | 000000024                                        |
      | fields              | burgerservicenummer,verblijfplaats.verblijfadres |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ontbrekende autorisatie veld                    | ad hoc rubrieken                                                                                                               | missende autorisatie |
      | verblijfadres.korteStraatnaam                   | 10120 80910 81010 81030 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81110                |
      | verblijfadres.officieleStraatnaam               | 10120 80910 81010 81030 81110 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81115                |
      | verblijfadres.huisnummer                        | 10120 80910 81010 81030 81110 81115 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81120                |
      | verblijfadres.huisletter                        | 10120 80910 81010 81030 81110 81115 81120 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81130                |
      | verblijfadres.huisnummertoevoeging              | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                |
      | verblijfadres.huisnummertoevoeging.code         | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                |
      | verblijfadres.huisnummertoevoeging.omschrijving | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                |
      | verblijfadres.aanduidingBijHuisnummer           | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81150                |
      | verblijfadres.postcode                          | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81160                |
      | verblijfadres.woonplaats                        | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81170                |
      | verblijfadres.land                              | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                |
      | verblijfadres.land.code                         | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                |
      | verblijfadres.land.omschrijving                 | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                |
      | verblijfadres.regel1                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81340 81350 88510 PAVP01 | 81330                |
      | verblijfadres.regel2                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81350 88510 PAVP01 | 81340                |
      | verblijfadres.regel3                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 88510 PAVP01 | 81350                |

    @fout-case
    Abstract Scenario: Afnemer vraagt om groep verblijfplaats en is niet geautoriseerd voor <ontbrekende autorisatie veld> (<missende autorisatie>)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000024                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ontbrekende autorisatie veld                    | ad hoc rubrieken                                                                                                               | missende autorisatie        |
      | functieAdres                                    | 10120 80910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81010                       |
      | datumVan                                        | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510  | PAVP01                      |
      | verblijfadres.korteStraatnaam                   | 10120 80910 81010 81030 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81110                       |
      | verblijfadres.officieleStraatnaam               | 10120 80910 81010 81030 81110 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81115                       |
      | verblijfadres.huisnummer                        | 10120 80910 81010 81030 81110 81115 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81120                       |
      | verblijfadres.huisletter                        | 10120 80910 81010 81030 81110 81115 81120 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81130                       |
      | verblijfadres.huisnummertoevoeging              | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                       |
      | verblijfadres.huisnummertoevoeging.code         | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                       |
      | verblijfadres.huisnummertoevoeging.omschrijving | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81140                       |
      | verblijfadres.aanduidingBijHuisnummer           | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81150                       |
      | verblijfadres.postcode                          | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81170 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81160                       |
      | verblijfadres.woonplaats                        | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81180 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81170                       |
      | verblijfadres.land                              | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                       |
      | verblijfadres.land.code                         | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                       |
      | verblijfadres.land.omschrijving                 | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81320 81330 81340 81350 88510 PAVP01 | 81310                       |
      | verblijfadres.regel1                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81340 81350 88510 PAVP01 | 81330                       |
      | verblijfadres.regel2                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81350 88510 PAVP01 | 81340                       |
      | verblijfadres.regel3                            | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 88510 PAVP01 | 81350                       |
      | adresseerbaarObjectIdentificatie                | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81190 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81180                       |
      | nummeraanduidingIdentificatie                   | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81210 81310 81320 81330 81340 81350 88510 PAVP01 | 81190                       |
      | datumIngangGeldigheid                           | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.type                      | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.datum                     | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.langFormaat               | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.jaar                      | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.maand                     | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |
      | datumIngangGeldigheid.onbekend                  | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 PAVP01 | 88510                       |

  Rule: Een gemeente als afnemer is geautoriseerd voor alle verblijfplaats gegevens van eigen inwoners
    Wanneer de afnemer parameter gemeenteVanInschrijving gebruikt 
     en die is gelijk aan de waarde van gemeenteCode in de 'claim', 
     dan wordt niet gekeken naar de autorisatie van de afnemer
     
    Scenario: Gemeente vraagt van een eigen inwoner om velden in verblijfplaats en er zit geen enkel verblijfplaatsgegeven in de autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                                                                                        |
      | type                    | RaadpleegMetBurgerservicenummer                                                                               |
      | burgerservicenummer     | 000000024                                                                                                     |
      | gemeenteVanInschrijving | 0800                                                                                                          |
      | fields                  | verblijfplaats.verblijfadres.korteStraatnaam,verblijfplaats.verblijfadres.huisnummer, verblijfplaats.datumVan |
      Dan heeft de response 1 persoon


  Rule: Wanneer met fields een veld van verblijfplaats wordt gevraagd en de afnemer is niet geautoriseerd voor een van de velden waarmee type verblijfplaats wordt bepaald, wordt een foutmelding gegeven
    Om een veld van verblijfplaats te mogen vragen moet de afnemer geautoriseerd zijn voor alle LO BRP rubrieken waar het verblijfplaatstype mee bepaald wordt:
    - 81110: straatnaam
    - 81210: locatiebeschrijving
    - 81310: land

    @fout-case
    Abstract Scenario: Afnemer is wel geautoriseerd voor gevraagde veld, maar niet voor <missende autorisatie> die nodig is voor verblijfplaats type
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetBurgerservicenummer                 |
      | burgerservicenummer | 000000024                                       |
      | fields              | burgerservicenummer,verblijfplaats.functieAdres |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                      | ad hoc rubrieken              | missende autorisatie        |
      | verblijfplaats.functieAdres | 10120 81010 81030 81210 81310 | straat (81110)              |
      | verblijfplaats.functieAdres | 10120 81010 81030 81110 81310 | locatiebeschrijving (81210) |
      | verblijfplaats.functieAdres | 10120 81010 81030 81110 81210 | land (81310)                |

  
  Rule: de 'verblijfplaatsBinnenland' field alias moet worden gebruikt door een consumer die niet is geautoriseerd voor het bevragen van 'verblijfplaats buitenland' velden

    Scenario: Afnemer vraagt om alleen binnengemeentelijke verblijfplaatsgegevens en is niet geautoriseerd voor verblijf buitenland
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                   | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81210 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000024                              |
      | fields              | verblijfplaatsBinnenland.verblijfadres |
      Dan heeft de response 1 persoon

    Scenario: Afnemer vraagt om alleen binnengemeentelijke datumVan en is niet geautoriseerd voor verblijf buitenland
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                                                        | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510 PAVP01 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000024                         |
      | fields              | verblijfplaatsBinnenland.datumVan |
      Dan heeft de response 1 persoon

    Scenario: Afnemer vraagt om alleen binnengemeentelijke type en is niet geautoriseerd voor verblijf buitenland
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                                                        | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510 PAVP01 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000024                         |
      | fields              | verblijfplaatsBinnenland.type     |
      Dan heeft de response 1 persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt verblijfplaatsBinnenland.<gevraagd veld> (<missende autorisatie>), waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                       |
      | type                | RaadpleegMetBurgerservicenummer                              |
      | burgerservicenummer | 000000024                                                    |
      | fields              | burgerservicenummer,verblijfplaatsBinnenland.<gevraagd veld> |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | gevraagd veld                                   | ad hoc rubrieken                                                                                                               | missende autorisatie        |
      | functieAdres                                    | 10120 80910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510 PAVP01 | 81010                       |
      | datumVan                                        | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510  | PAVP01                      |
      | verblijfadres.korteStraatnaam                   | 10120 80910 81010 81030 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510 PAVP01 | 81110                       |
      | verblijfadres.officieleStraatnaam               | 10120 80910 81010 81030 81110 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510 PAVP01 | 81115                       |
      | verblijfadres.huisnummer                        | 10120 80910 81010 81030 81110 81115 81130 81140 81150 81160 81170 81180 81190 81210 88510 PAVP01 | 81120                       |
      | verblijfadres.huisletter                        | 10120 80910 81010 81030 81110 81115 81120 81140 81150 81160 81170 81180 81190 81210 88510 PAVP01 | 81130                       |
      | verblijfadres.huisnummertoevoeging              | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 88510 PAVP01 | 81140                       |
      | verblijfadres.huisnummertoevoeging.code         | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 88510 PAVP01 | 81140                       |
      | verblijfadres.huisnummertoevoeging.omschrijving | 10120 80910 81010 81030 81110 81115 81120 81130 81150 81160 81170 81180 81190 81210 88510 PAVP01 | 81140                       |
      | verblijfadres.aanduidingBijHuisnummer           | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81160 81170 81180 81190 81210 88510 PAVP01 | 81150                       |
      | verblijfadres.postcode                          | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81170 81180 81190 81210 88510 PAVP01 | 81160                       |
      | verblijfadres.woonplaats                        | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81180 81190 81210 88510 PAVP01 | 81170                       |
      | adresseerbaarObjectIdentificatie                | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81190 81210 88510 PAVP01 | 81180                       |
      | nummeraanduidingIdentificatie                   | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81210 88510 PAVP01 | 81190                       |
      | datumIngangGeldigheid                           | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 PAVP01 | 88510                       |
      | datumIngangGeldigheid.type                      | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 PAVP01 | 88510                       |
      | datumIngangGeldigheid.datum                     | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 PAVP01 | 88510                       |
      | datumIngangGeldigheid.langFormaat               | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 PAVP01 | 88510                       |
      | datumIngangGeldigheid.jaar                      | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 PAVP01 | 88510                       |
      | datumIngangGeldigheid.maand                     | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 PAVP01 | 88510                       |
      | datumIngangGeldigheid.onbekend                  | 10120 80910 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 PAVP01 | 88510                       |
    
    Abstract Scenario: Afnemer vraagt verblijfplaatsBinnenland.<gevraagd veld>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                       |
      | type                | RaadpleegMetBurgerservicenummer                              |
      | burgerservicenummer | 000000024                                                    |
      | fields              | burgerservicenummer,verblijfplaatsBinnenland.<gevraagd veld> |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | gevraagd veld                                      | ad hoc rubrieken                                                        |
      | functieAdres                                       | 81010                                                                   |
      | verblijfplaats.datumVan                            | PAVP01                                                                  |
      | verblijfplaats.datumVan.type                       | PAVP01                                                                  |
      | verblijfplaats.datumVan.datum                      | PAVP01                                                                  |
      | verblijfplaats.datumVan.langFormaat                | PAVP01                                                                  |
      | verblijfplaats.datumVan.jaar                       | PAVP01                                                                  |
      | verblijfplaats.datumVan.maand                      | PAVP01                                                                  |
      | verblijfplaats.datumVan.onbekend                   | PAVP01                                                                  |
      | verblijfadres.korteStraatnaam                      | 81110                                                                   |
      | verblijfadres.officieleStraatnaam                  | 81115                                                                   |
      | verblijfadres.huisnummer                           | 81120                                                                   |
      | verblijfadres.huisletter                           | 81130                                                                   |
      | verblijfadres.huisnummertoevoeging                 | 81140                                                                   |
      | verblijfadres.aanduidingBijHuisnummer              | 81150                                                                   |
      | verblijfadres.aanduidingBijHuisnummer.code         | 81150                                                                   |
      | verblijfadres.aanduidingBijHuisnummer.omschrijving | 81150                                                                   |
      | verblijfadres.postcode                             | 81160                                                                   |
      | verblijfadres.woonplaats                           | 81170                                                                   |
      | verblijfadres.locatiebeschrijving                  | 81210                                                                   |
      | adresseerbaarObjectIdentificatie                   | 81180                                                                   |
      | nummeraanduidingIdentificatie                      | 81190                                                                   |
      | datumIngangGeldigheid                              | 88510                                                                   |
      | datumIngangGeldigheid.type                         | 88510                                                                   |
      | datumIngangGeldigheid.datum                        | 88510                                                                   |
      | datumIngangGeldigheid.langFormaat                  | 88510                                                                   |
      | datumIngangGeldigheid.jaar                         | 88510                                                                   |
      | datumIngangGeldigheid.maand                        | 88510                                                                   |
      | datumIngangGeldigheid.onbekend                     | 88510                                                                   |
      | verblijfadres                                      | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81170 81210 |
