# language: nl
Functionaliteit: zoek personen met straatnaam, huisnummer en gemeente van inschrijving

  Als consumer
  wil ik personen vinden door het opgeven van de straatnaam, huisnummer en gemeente van het adres waar zij staan ingeschreven

  Regel: personen worden gevonden als de straatnaam, huisnummer en gemeente van het adres waar zij staan ingeschreven overeenkomen met de opgegeven straatnaam (niet hoofdlettergevoelig), huisnummer en gemeente van inschrijving

    Abstract Scenario: de straatnaam, huisnummer en gemeentecode van het adres van personen komen overeen met de opgegeven straatnaam, huisnummer en gemeente van inschrijving
      Gegeven adres 'A1' in gemeente 'Rotterdam' heeft de volgende gegevens
        | straatnaam (11.10) | huisnummer (11.20) |
        | Boterdiep          |                 32 |
      En de persoon 'Piet'
      * 'Piet' is 4 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met straatnaam '<straat>', huisnummer '32' en gemeentecode '0599'
      Dan wordt 'Piet' gevonden

      Voorbeelden:
        | straat    |
        | Boterdiep |
        | boterdiep |
        | BOTERDIEP |

    Scenario: de te vinden persoon staat ingeschreven op een adres met een straatnaam van één karakter lang
      Gegeven adres 'A1' in gemeente 'Oostburg' heeft de volgende gegevens
        | straatnaam (11.10) | huisnummer (11.20) |
        | A                  |                 14 |
      En de persoon 'Piet'
      * 'Piet' is 4 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met straatnaam 'a', huisnummer '14' en gemeentecode '0692'
      Dan wordt 'Piet' gevonden

    Scenario: de opgegeven straatnaam komt overeen met de naam openbare ruimte van een adres
      Gegeven adres 'A1' in gemeente '\'s-Gravenhage' heeft de volgende gegevens
        | straatnaam (11.10)       | naam openbare ruimte (11.15) | huisnummer (11.20) |
        | Ln Copes van Cattenburch | Laan Copes van Cattenburch   |                 39 |
      En de persoon 'Piet'
      * 'Piet' is 4 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met straatnaam 'Laan Copes van Cattenburch', huisnummer '39' en gemeentecode '0518'
      Dan wordt 'Piet' gevonden

  Regel: de optionele 'huisletter' parameter (niet hoofdlettergevoelig) kan worden gebruikt om de zoek criteria aan te scherpen

    Abstract Scenario: de straatnaam, huisnummer, huisletter en gemeentecode van het adres van personen komen overeen met de opgegeven straatnaam, huisnummer, huisletter en gemeentecode
      Gegeven adres 'A1' in gemeente '\'s-Gravenhage' heeft de volgende gegevens
        | straatnaam (11.10) | huisnummer (11.20) |
        | Leyweg             |                 62 |
      En adres 'A2' in gemeente '\'s-Gravenhage' heeft de volgende gegevens
        | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) |
        | Leyweg             |                 62 | e                  |
      En de persoon 'Piet'
      * 'Piet' is 4 jaar geleden ingeschreven op adres 'A1'
      En de persoon 'Gerda'
      * 'Gerda' is 3 jaar geleden ingeschreven op adres 'A2'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met straatnaam 'Leyweg', huisnummer '62' en gemeentecode '0518' en parameters
        | huisletter   |
        | <huisletter> |
      Dan wordt 'Gerda' gevonden

      Voorbeelden:
        | huisletter |
        | e          |
        | E          |

  Regel: de optionele 'huisnummertoevoeging' parameter (niet hoofdlettergevoelig) kan worden gebruikt om de zoek criteria aan te scherpen

    Abstract Scenario: de straatnaam, huisnummer, huisnummertoevoeging en gemeentecode van het adres van personen komen overeen met de opgegeven straatnaam, huisnummer, huisnummertoevoeging en gemeentecode
      Gegeven adres 'A1' in gemeente 'Utrecht' heeft de volgende gegevens
        | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) |
        | St. Jacobsstraat   |                401 | L                  | Toe                          |
      En adres 'A2' in gemeente 'Amsterdam' heeft de volgende gegevens
        | straatnaam (11.10) | huisnummer (11.20) | huisnummertoevoeging (11.40) |
        | Vitternkade        |                102 | II                           |
      En de persoon 'Piet'
      * 'Piet' is 4 jaar geleden ingeschreven op adres 'A1'
      En de persoon 'Gerda'
      * 'Gerda' is 3 jaar geleden ingeschreven op adres 'A2'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met straatnaam '<straat>', huisnummer '<huisnummer>' en gemeentecode '<gemeente van inschrijving>' en parameters
        | huisnummertoevoeging    |
        | <huisnummer toevoeging> |
      Dan wordt '<persoon aanduiding>' gevonden

      Voorbeelden:
        | persoon aanduiding | gemeente van inschrijving | straat           | huisnummer | huisnummer toevoeging | opmerking                            |
        | Piet               |                      0344 | St. Jacobsstraat |        401 | Toe                   | verblijfplaats heeft ook huisletter  |
        | Piet               |                      0344 | St. Jacobsstraat |        401 | TOE                   | verblijfplaats heeft ook huisletter  |
        | Gerda              |                      0363 | Vitternkade      |        102 | II                    | verblijfplaats heeft geen huisletter |
        | Gerda              |                      0363 | Vitternkade      |        102 | ii                    | verblijfplaats heeft geen huisletter |

  Regel: de optionele 'inclusiefOverledenPersonen' parameter moet worden gebruikt om overleden personen ingeschreven op een adres te kunnen vinden

    Scenario: de straatnaam, huisnummer en gemeentcode van het adres van een overleden persoon komen overeen met de opgegeven straatnaam, huisnummer en gemeentecode en de optionele 'inclusiefOverledenPersonen' parameter is niet opgegeven
      Gegeven adres 'A1' in gemeente 'Amsterdam' heeft de volgende gegevens
        | straatnaam (11.10) | huisnummer (11.20) |
        | Afrikanerplein     |                  2 |
      En de persoon 'Gerda'
      * 'Gerda' is op 5-5-2015 ingeschreven op adres 'A1'
      * 'Gerda' is op 17-10-2020 overleden
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met straatnaam 'Afrikanerplein', huisnummer '2' en gemeentecode '0363'
      Dan worden er geen personen gevonden

    Scenario: de straatnaam, huisnummer en gemeentcode van het adres van een overleden persoon komen overeen met de opgegeven straatnaam, huisnummer en gemeentecode en de optionele 'inclusiefOverledenPersonen' parameter is opgegeven
      Gegeven adres 'A1' in gemeente 'Amsterdam' heeft de volgende gegevens
        | straatnaam (11.10) | huisnummer (11.20) |
        | Afrikanerplein     |                  2 |
      En de persoon 'Gerda'
      * 'Gerda' is op 5-5-2015 ingeschreven op adres 'A1'
      * 'Gerda' is op 17-10-2020 overleden
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met straatnaam 'Afrikanerplein', huisnummer '2' en gemeentecode '0363' en parameters
        | inclusiefOverledenPersonen |
        | true                       |
      Dan wordt 'Gerda' gevonden
      En heeft 'Gerda' de volgende 'opschortingBijhouding' gegevens
        | reden.code | reden.omschrijving | datum.datum | datum.langFormaat | datum.type |
        | O          | overlijden         |  2020-10-17 |   17 oktober 2020 | Datum      |

  Regel: wildcard matching (niet hoofdlettergevoelig) kan worden toegepast voor de straat parameter
        Voor wildcard matching moet minimaal 7 letters (exclusief de wildcard teken) worden opgegeven.
        De wildcard teken (*) kan als eerste of als laatste karakter worden opgegeven.

    Abstract Scenario: de straatnaam of naam openbare ruimte van het adres waar personen staan ingeschreven komt met wildcard matching overeen met de opgegeven straatnaam
      Gegeven adres 'A1' in gemeente '\'s-Gravenhage' heeft de volgende gegevens
        | straatnaam (11.10)       | naam openbare ruimte (11.15) | huisnummer (11.20) |
        | Ln Copes van Cattenburch | Laan Copes van Cattenburch   |                 39 |
      En de persoon 'Piet' met burgerservicenummer '000000025'
      * 'Piet' is 4 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met straatnaam '<straat>', huisnummer '39' en gemeentecode '0518'
      Dan wordt 'Piet' gevonden

      Voorbeelden:
        | straat   |
        | ln cope* |
        | laan co* |
        | *burch   |
