Functionaliteit: autorisatie op parameters bij ZoekMetPostcodeEnHuisnummer

  Rule: Wanneer een parameter wordt gebruikt van een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    
    @fout-case
    Abstract Scenario: Gebruik parameter <parameter niet toegestaan> waarvoor de afnemer niet geautoriseerd is (<ontbrekende rubriek>)
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0518   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code                              | 0599             |
      | straatnaam (11.10)                         | Borgesiusstraat  |
      | huisnummer (11.20)                         | 103              |
      | huisletter (11.30)                         | b                |
      | huisnummertoevoeging (11.40)               | 2                |
      | postcode (11.60)                           | 2497BV           |
      Als personen wordt gezocht met de volgende parameters
      | naam                 | waarde                      |
      | type                 | ZoekMetPostcodeEnHuisnummer |
      | postcode             | 2497BV                      |
      | huisnummer           | 103                         |
      | huisletter           | b                           |
      | huisnummertoevoeging | 2                           |
      | fields               | burgerservicenummer         |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                                  |
      | type     | https://learn.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?view=net-7.0#system-net-httpstatuscode-forbidden |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                                               |
      | status   | 403                                                                                                                     |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): <parameter niet toegestaan>.                               |
      | code     | unauthorizedParameter                                                                                                   |
      | instance | /haalcentraal/api/brp/personen                                                                                          |
      En heeft het object de volgende 'invalidParams' gegevens
      | code         | name                        | reason                                                  |
      | unauthorized | <parameter niet toegestaan> | Niet geautoriseerd voor het gebruik van deze parameter. |

      Voorbeelden:
      | ad hoc rubrieken                                      | parameter niet toegestaan | ontbrekende rubriek |
      | 10120 80910 80810 81120 81130 81140 81150 81160 81190 | huisnummer                | 81110               |
      | 10120 80910 80810 81110 81120 81130 81140 81150 81190 | postcode                  | 81160               |
      | 10120 80910 80810 81110 81120 81140 81150 81160 81190 | huisletter                | 81130               |
      | 10120 80910 80810 81110 81120 81130 81150 81160 81190 | huisnummertoevoeging      | 81140               |

    @fout-case
    Scenario: Gebruik van meerdere parameters waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                 | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 80810 81110 81120 81150 81160 81190 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0518   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code                              | 0599             |
      | straatnaam (11.10)                         | Borgesiusstraat  |
      | huisnummer (11.20)                         | 103              |
      | huisletter (11.30)                         | b                |
      | huisnummertoevoeging (11.40)               | 2                |
      | postcode (11.60)                           | 2497BV           |
      Als personen wordt gezocht met de volgende parameters
      | naam                 | waarde                      |
      | type                 | ZoekMetPostcodeEnHuisnummer |
      | postcode             | 2497BV                      |
      | huisnummer           | 103                         |
      | huisletter           | b                           |
      | huisnummertoevoeging | 2                           |
      | fields               | burgerservicenummer         |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                                  |
      | type     | https://learn.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?view=net-7.0#system-net-httpstatuscode-forbidden |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                                               |
      | status   | 403                                                                                                                     |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): huisletter, huisnummertoevoeging.                          |
      | code     | unauthorizedParameter                                                                                                   |
      | instance | /haalcentraal/api/brp/personen                                                                                          |

  Rule: Een gemeente als afnemer is geautoriseerd voor alle zoekvragen voor haar eigen inwoners

    Scenario: Gemeente is niet geautoriseerd voor de zoekparameters en vindt alleen eigen inwoners
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
      | gemeente_code                              | 0599             |
      | straatnaam (11.10)                         | Borgesiusstraat  |
      | huisnummer (11.20)                         | 103              |
      | huisletter (11.30)                         | b                |
      | huisnummertoevoeging (11.40)               | 2                |
      | postcode (11.60)                           | 2497BV           |
      Als personen wordt gezocht met de volgende parameters
      | naam                 | waarde                      |
      | type                 | ZoekMetPostcodeEnHuisnummer |
      | postcode             | 2497BV                      |
      | huisnummer           | 103                         |
      | huisletter           | b                           |
      | huisnummertoevoeging | 2                           |
      | fields               | burgerservicenummer         |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
      