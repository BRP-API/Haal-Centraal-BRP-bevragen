# language: nl
Functionaliteit: zoek personen met postcode en huisnummer

  Als consumer
  wil ik personen vinden door het opgeven van de postcode en huisnummer van het adres waar zij staan ingeschreven

  Achtergrond:
    Gegeven adres 'A1'
      | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) |
      |                 0599 |           2628HJ |                  2 |
    En adres 'A2'
      | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) | huisletter (11.30) |
      |                 0599 |           2628HJ |                  2 | A                  |
    En adres 'A3'
      | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) | huisnummertoevoeging (11.40) |
      |                 0599 |           2628HJ |                  2 | III                          |
    En adres 'A4'
      | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) | aanduiding bij huisnummer (11.50) |
      |                 0599 |           2628HJ |                  2 | to                                |
    En adres 'A5'
      | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) |
      |                 0599 |           2629HJ |                  2 |
    En adres 'A6'
      | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) |
      |                 0600 |           2630HJ |                  2 |
    En de persoon 'Jan' met burgerservicenummer '000000024'
    * 'Jan' is 5 jaar geleden ingeschreven op adres 'A1'
    En de persoon 'Piet' met burgerservicenummer '000000025'
    * 'Piet' is 4 jaar geleden ingeschreven op adres 'A2'
    En de persoon 'Kees' met burgerservicenummer '000000026'
    * 'Kees' is 3 jaar geleden ingeschreven op adres 'A3'
    En de persoon 'Gerda' met burgerservicenummer '000000027'
    * 'Gerda' is 2 jaar geleden ingeschreven op adres 'A4'
    En de persoon 'Saskia' met burgerservicenummer '000000028'
    * 'Saskia' is op 17-10-2020 ingeschreven op adres 'A5'
    * 'Saskia' is op 05-04-2023 overleden
    En de persoon 'Henk' met burgerservicenummer '000000029'
    * 'Henk' is 1 jaar geleden ingeschreven op adres 'A6'

  Regel: personen worden gevonden als de postcode en huisnummer van het adres waar zij staan ingeschreven overeenkomen met de opgegeven postcode (niet hoofdlettergevoelig) en huisnummer

    Abstract Scenario: de postcode en huisnummer van het adres van personen komen overeen met de opgegeven postcode (<sub-titel>) en huisnummer
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met postcode '<postcode>' en huisnummer '2'
      Dan worden 'Jan, Piet, Kees en Gerda' gevonden

      Voorbeelden:
        | postcode | sub-titel                                                             |
        |   2628HJ | letters zijn hoofdletters                                             |
        |   2628hj | letters zijn kleine letters                                           |
        |  2628 HJ | spatie tussen de cijfers en hoofdletters                              |
        |  2628 hj | spatie tussen de cijfers en kleine letters                            |
        |  2628 Hj | spatie tussen de cijfers en letters (zowel hoofd- als kleine letters) |

  Regel: de optionele 'huisletter' parameter (niet hoofdlettergevoelig) kan worden gebruikt om de zoek criteria aan te scherpen

    Abstract Scenario: de postcode, huisnummer en huisletter van het adres van personen komen overeen met de opgegeven postcode, huisnummer en huisletter
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met postcode '2628HJ' en huisnummer '2' en parameters
        | huisletter   |
        | <huisletter> |
      Dan wordt 'Piet' gevonden

      Voorbeelden:
        | huisletter |
        | A          |
        | a          |

  Regel: de optionele 'huisnummertoevoeging' parameter (niet hoofdlettergevoelig) kan worden gebruikt om de zoek criteria aan te scherpen

    Abstract Scenario: de postcode, huisnummer en huisnummertoevoeging van het adres van personen komen overeen met de opgegeven postcode, huisnummer en huisnummertoevoeging
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met postcode '2628HJ' en huisnummer '2' en parameters
        | huisnummertoevoeging   |
        | <huisnummertoevoeging> |
      Dan wordt 'Kees' gevonden

      Voorbeelden:
        | huisnummertoevoeging |
        | III                  |
        | iii                  |
        | Iii                  |

  Regel: de optionele 'gemeenteVanInschrijving' parameter kan worden gebruikt om de zoek criteria aan te scherpen

    Abstract Scenario: de postcode, huisnummer en gemeente van inschrijving van het adres van personen komen overeen met de opgegeven postcode, huisnummer en gemeente van inschrijving
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met postcode '2630HJ' en huisnummer '2' en parameters
        | gemeenteVanInschrijving |
        |                    0600 |
      Dan wordt 'Henk' gevonden

  Regel: de optionele 'inclusiefOverledenPersonen' parameter moet worden gebruikt om overleden personen ingeschreven op een adres te kunnen vinden

    Scenario: de postcode en huisnummer van het adres van een overleden persoon komen overeen met de opgegeven postcode en huisnummer en de optionele 'inclusiefOverledenPersonen' parameter is niet opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met postcode '2629HJ' en huisnummer '2'
      Dan worden er geen personen gevonden

    @info-api
    Scenario: de postcode en huisnummer van het adres van een overleden persoon komen overeen met de opgegeven postcode en huisnummer en de optionele 'inclusiefOverledenPersonen' parameter is opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met postcode '2629HJ' en huisnummer '2' en parameters
        | inclusiefOverledenPersonen |
        | true                       |
      Dan wordt 'Saskia' gevonden
      En heeft 'Saskia' de volgende 'opschortingBijhouding' gegevens
        | reden.code | reden.omschrijving | datum.datum | datum.langFormaat | datum.type |
        | O          | overlijden         |  2023-04-05 |      5 april 2023 | Datum      |
