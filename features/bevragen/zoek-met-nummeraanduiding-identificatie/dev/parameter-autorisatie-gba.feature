Functionaliteit: autorisatie op parameters bij ZoekMetNummeraanduidingIdentificatie

  Rule: Wanneer een parameter wordt gebruikt van een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven

    @fout-case
    Scenario: Gebruik van parameter nummeraanduidingIdentificatie waarvoor de afnemer niet geautoriseerd is (81190)
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                       | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81010 81110 81120 81130 81140 81150 81160 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0518   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | identificatiecode nummeraanduiding (11.90) |
      | 0599          | 0599200000219679                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200000219679                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                                 |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                   |
      | status   | 403                                                                                         |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): nummeraanduidingIdentificatie. |
      | code     | unauthorizedParameter                                                                       |
      | instance | /haalcentraal/api/brp/personen                                                              |

    @fout-case
    Scenario: Gebruik van parameter gemeenteVanInschrijving waarvoor de afnemer niet geautoriseerd is (80910)
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                       | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81010 81110 81120 81130 81140 81150 81160 81190 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0518   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | identificatiecode nummeraanduiding (11.90) |
      | 0599          | 0599200000219679                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200000219679                     |
      | gemeenteVanInschrijving       | 0599                                 |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                           |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                             |
      | status   | 403                                                                                   |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): gemeenteVanInschrijving. |
      | code     | unauthorizedParameter                                                                 |
      | instance | /haalcentraal/api/brp/personen                                                        |

  Rule: Een gemeente als afnemer is geautoriseerd voor alle zoekvragen voor haar eigen inwoners

    Scenario: Gemeente is niet geautoriseerd voor verblijfplaats en vindt alleen eigen inwoners met zoeken op postcode en huisnummer
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0599   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | identificatiecode nummeraanduiding (11.90) |
      | 0599          | 0599200000219679                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200000219679                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
     