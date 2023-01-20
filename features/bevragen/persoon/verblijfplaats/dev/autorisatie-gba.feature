# language: nl

Functionaliteit: autorisatie verblijfplaatsgegevens Persoon

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0599                              | 19860801                           |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                         | waarde          |
      | gemeentecode (92.10)         | 0599            |
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
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 000000024                                          |
      | fields              | burgerservicenummer,verblijfplaats.<gevraagd veld> |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | gevraagd veld                         | ad hoc rubrieken                                                              | missende autorisatie |
      | functieAdres                          | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310       | 81010                |
      | verblijfadres.korteStraatnaam         | 10120 80910 81010 81115 81120 81130 81140 81150 81160 81170 81210 81310       | 81110                |
      | verblijfadres.officieleStraatnaam     | 10120 80910 81010 81110 81120 81130 81140 81150 81160 81170 81210 81310       | 81115                |
      | verblijfadres.huisnummer              | 10120 80910 81010 81110 81115 81130 81140 81150 81160 81170 81210 81310       | 81120                |
      | verblijfadres.huisletter              | 10120 80910 81010 81110 81115 81120 81140 81150 81160 81170 81210 81310       | 81130                |
      | verblijfadres.huisnummertoevoeging    | 10120 80910 81010 81110 81115 81120 81130 81150 81160 81170 81210 81310       | 81140                |
      | verblijfadres.aanduidingBijHuisnummer | 10120 80910 81010 81110 81115 81120 81130 81140 81160 81170 81210 81310       | 81150                |
      | verblijfadres.postcode                | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81170 81210 81310       | 81160                |
      | verblijfadres.woonplaats              | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81210 81310       | 81170                |
      | verblijfadres.regel1                  | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81340 81350             | 81330                |
      | verblijfadres.regel2                  | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81330 81350             | 81340                |
      | verblijfadres.regel3                  | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81330 81340             | 81350                |
      | adresseerbaarObjectIdentificatie      | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81190             | 81180                |
      | nummeraanduidingIdentificatie         | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81180             | 81190                |
      | datumIngangGeldigheid                 | 10120 80910 81010 81030 81110 81150 81160 81210 81310 81320 81330 81340 81350 | 88510                |

    @fout-case
    Abstract Scenario: Afnemer vraagt om groep verblijfadres en is niet geautoriseerd voor <ontbrekende autorisatie veld> (<missende autorisatie>)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                           |
      | type                | RaadpleegMetBurgerservicenummer                  |
      | burgerservicenummer | 000000024                                        |
      | fields              | burgerservicenummer,verblijfplaats.verblijfadres |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ontbrekende autorisatie veld | ad hoc rubrieken                                                        | missende autorisatie |
      | korteStraatnaam              | 10120 80910 81010 81115 81120 81130 81140 81150 81160 81170 81210 81310 | 81110                |
      | officieleStraatnaam          | 10120 80910 81010 81110 81120 81130 81140 81150 81160 81170 81210 81310 | 81115                |
      | huisnummer                   | 10120 80910 81010 81110 81115 81130 81140 81150 81160 81170 81210 81310 | 81120                |
      | huisletter                   | 10120 80910 81010 81110 81115 81120 81140 81150 81160 81170 81210 81310 | 81130                |
      | huisnummertoevoeging         | 10120 80910 81010 81110 81115 81120 81130 81150 81160 81170 81210 81310 | 81140                |
      | aanduidingBijHuisnummer      | 10120 80910 81010 81110 81115 81120 81130 81140 81160 81170 81210 81310 | 81150                |
      | postcode                     | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81170 81210 81310 | 81160                |
      | woonplaats                   | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81210 81310 | 81170                |
      | regel1                       | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81340 81350       | 81330                |
      | regel2                       | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81330 81350       | 81340                |
      | regel3                       | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81330 81340       | 81350                |

    @fout-case
    Abstract Scenario: Afnemer vraagt om groep verblijfplaats en is niet geautoriseerd voor <ontbrekende autorisatie veld> (<missende autorisatie>)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000024                          |
      | fields              | burgerservicenummer,verblijfplaats |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ontbrekende autorisatie veld     | ad hoc rubrieken                                                              | missende autorisatie |
      | functieAdres                     | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310       | 81010                |
      | korteStraatnaam                  | 10120 80910 81010 81115 81120 81130 81140 81150 81160 81170 81210 81310       | 81110                |
      | officieleStraatnaam              | 10120 80910 81010 81110 81120 81130 81140 81150 81160 81170 81210 81310       | 81115                |
      | huisnummer                       | 10120 80910 81010 81110 81115 81130 81140 81150 81160 81170 81210 81310       | 81120                |
      | huisletter                       | 10120 80910 81010 81110 81115 81120 81140 81150 81160 81170 81210 81310       | 81130                |
      | huisnummertoevoeging             | 10120 80910 81010 81110 81115 81120 81130 81150 81160 81170 81210 81310       | 81140                |
      | aanduidingBijHuisnummer          | 10120 80910 81010 81110 81115 81120 81130 81140 81160 81170 81210 81310       | 81150                |
      | postcode                         | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81170 81210 81310       | 81160                |
      | woonplaats                       | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81210 81310       | 81170                |
      | regel1                           | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81340 81350             | 81330                |
      | regel2                           | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81330 81350             | 81340                |
      | regel3                           | 10120 80910 81010 81110 81150 81160 81210 81310 81320 81330 81340             | 81350                |
      | adresseerbaarObjectIdentificatie | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81190             | 81180                |
      | nummeraanduidingIdentificatie    | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81180             | 81190                |
      | datumIngangGeldigheid            | 10120 80910 81010 81030 81110 81150 81160 81210 81310 81320 81330 81340 81350 | 88510                |


  Rule: Een gemeente als afnemer is geautoriseerd voor alle verblijfplaatsgegevens van eigen inwoners

    Scenario: Gemeente vraagt van een eigen inwoner om velden in verblijfplaats en er zit geen enkel verblijfplaatsgegeven in de autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0599   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                               |
      | type                | RaadpleegMetBurgerservicenummer                                                      |
      | burgerservicenummer | 000000024                                                                            |
      | fields              | verblijfplaats.verblijfadres.korteStraatnaam,verblijfplaats.verblijfadres.huisnummer |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam       | waarde          |
      | straat     | Borgesiusstraat |
      | huisnummer | 103             |


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
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetBurgerservicenummer                 |
      | burgerservicenummer | 000000024                                       |
      | fields              | burgerservicenummer,verblijfplaats.functieAdres |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                      | ad hoc rubrieken              | missende autorisatie        |
      | verblijfplaats.functieAdres | 10120 81010 81030 81210 81310 | straat (81110)              |
      | verblijfplaats.functieAdres | 10120 81010 81030 81110 81310 | locatiebeschrijving (81210) |
      | verblijfplaats.functieAdres | 10120 81010 81030 81110 81210 | land (81310)                |    
   
  
  Rule: Wanneer met fields gevraagd is voor datumVan en afnemer is niet geautoriseerd voor datumAanvangAdreshouding én datumAanvangAdresBuitenland, wordt een foutmelding gegeven
    # de foutmelding toont het met fields gevraagde veld, in dit geval datumVan, niet het onderliggende veld waaruit deze gevuld wordt

    Scenario: Afnemer vraagt om datumVan en is geautoriseerd voor datum aanvang adreshouding (81030) én datum aanvang adres buitenland (81320)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)           | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81010 81030 81110 81210 81310 81320 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                     | waarde          |
      | straat                   | Borgesiusstraat |
      | datumAanvangAdreshouding | 19860801        |

    @fout-case
    Abstract Scenario: Afnemer vraagt om datumVan en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                      |
      | type                | RaadpleegMetBurgerservicenummer             |
      | burgerservicenummer | 000000024                                   |
      | fields              | burgerservicenummer,verblijfplaats.datumVan |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                    | missende autorisatie                |
      | 10120 81010 81110 81210 81310 81320 | datumAanvangAdreshouding (81030)    |
      | 10120 81010 81030 81110 81210 81310 | datumAanvangAdresBuitenland (81320) |

    Scenario: Gemeente vraagt om datumVan van eigen inwoner en is niet geautoriseerd voor datumVan voor buitengemeentelijke personen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)     | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81010 81030 81110 81210 81310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0599   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                     | waarde          |
      | straat                   | Borgesiusstraat |
      | datumAanvangAdreshouding | 19860801        |


  Rule: de 'verblijfplaatsBinnenland' field alias moet worden gebruikt door een consumer die niet is geautoriseerd voor het bevragen van 'verblijfplaats buitenland' velden

    Scenario: Afnemer vraagt om alleen binnengemeentelijke verblijfplaatsgegevens en is niet geautoriseerd voor verblijf buitenland
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                   | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81210 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000024                              |
      | fields              | verblijfplaatsBinnenland.verblijfadres |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                 | waarde          |
      | straat               | Borgesiusstraat |
      | huisnummer           | 103             |
      | huisletter           | b               |
      | huisnummertoevoeging | 2               |
      | postcode             | 2497BV          |
      | woonplaats           | Scheveningen    |

    Scenario: Afnemer vraagt om alleen binnengemeentelijke datumVan en is niet geautoriseerd voor verblijf buitenland
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81010 81030 81110 81210   | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000024                         |
      | fields              | verblijfplaatsBinnenland.datumVan |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                     | waarde          |
      | straat                   | Borgesiusstraat |
      | datumAanvangAdreshouding | 19860801        |
