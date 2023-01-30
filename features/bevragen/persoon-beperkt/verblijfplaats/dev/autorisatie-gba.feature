# language: nl

Functionaliteit: autorisatie verblijfplaatsgegevens PersoonBeperkt

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0599                              | 19860801                           | W                     |
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
    Scenario: Afnemer vraagt functieAdres, waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                         | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam       | waarde                                          |
      | type       | ZoekMetPostcodeEnHuisnummer                     |
      | postcode   | 2497BV                                          |
      | huisnummer | 103                                             |
      | fields     | burgerservicenummer,verblijfplaats.functieAdres |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

    @fout-case
    Scenario: Afnemer vraagt om groep verblijfplaats en is niet geautoriseerd voor functie adres (81010)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                         | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam       | waarde                             |
      | type       | ZoekMetPostcodeEnHuisnummer        |
      | postcode   | 2497BV                             |
      | huisnummer | 103                                |
      | fields     | burgerservicenummer,verblijfplaats |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

  Rule: Een gemeente als afnemer is geautoriseerd voor alle verblijfplaatsgegevens van eigen inwoners
    Wanneer de afnemer parameter gemeenteVanInschrijving gebruikt 
    en die is gelijk aan de waarde van gemeenteCode in de 'claim', 
    dan wordt niet gekeken naar de autorisatie van de afnemer

    Scenario: Gemeente vraagt om groep verblijfplaats van een eigen inwoner en afnemer is niet geautoriseerd voor verblijfplaats
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10240 10310 80910         | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) |
      | 19830526              | Maassen               |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) |
      | 0518                              | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde     |
      | gemeentecode (92.10) | 0800       |
      | straatnaam (11.10)   | Wilgenlaan |
      | huisnummer (11.20)   | 16         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                              |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam           | Maassen                             |
      | geboortedatum           | 1983-05-26                          |
      | gemeenteVanInschrijving | 0800                                |
      | fields                  | verblijfplaats                      |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                      | waarde     |
      | straat                    | Wilgenlaan |
      | huisnummer                | 16         |
      | functieAdres.code         | W          |
      | functieAdres.omschrijving | woonadres  |


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
      Als gba personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2497BV                      |
      | huisnummer | 103                         |
      | fields     | verblijfplaats.functieAdres |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                          | missende autorisatie        |
      | 10120 81010 81030 81120 81160 81210 81310 | straat (81110)              |
      | 10120 81010 81030 81110 81120 81160 81310 | locatiebeschrijving (81210) |
      | 10120 81010 81030 81110 81120 81160 81210 | land (81310)                |
   
  
  Rule: de 'verblijfplaatsBinnenland' field alias moet worden gebruikt door een consumer die niet is geautoriseerd voor het bevragen van 'verblijfplaats buitenland' velden

    Scenario: Afnemer vraagt om alleen binnengemeentelijke verblijfplaatsgegevens en is niet geautoriseerd voor verblijf buitenland
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                   | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81110 81115 81120 81130 81140 81150 81160 81170 81210 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam       | waarde                                       |
      | type       | ZoekMetPostcodeEnHuisnummer                  |
      | postcode   | 2497BV                                       |
      | huisnummer | 103                                          |
      | fields     | burgerservicenummer,verblijfplaatsBinnenland |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                      | waarde          |
      | straat                    | Borgesiusstraat |
      | functieAdres.code         | W               |
      | functieAdres.omschrijving | woonadres       |

