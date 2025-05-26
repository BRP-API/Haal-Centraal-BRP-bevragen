# language: nl
Functionaliteit: zoek personen met postcode en huisnummer

  Als consumer
  wil ik personen vinden door het opgeven van de postcode en huisnummer van het adres waar zij staan ingeschreven

  Achtergrond:
    Gegeven adres 'A1'
      | postcode (11.60) | huisnummer (11.20) |
      |           2628HJ |                  2 |
    En adres 'A2'
      | postcode (11.60) | huisnummer (11.20) | huisletter (11.30) |
      |           2628HJ |                  2 | A                  |
    En adres 'A3'
      | postcode (11.60) | huisnummer (11.20) | huisnummertoevoeging (11.40) |
      |           2628HJ |                  2 | III                          |
    En adres 'A4'
      | postcode (11.60) | huisnummer (11.20) | aanduiding bij huisnummer (11.50) |
      |           2628HJ |                  2 | to                                |
    En de persoon 'Jan'
    * 'Jan' is 5 jaar geleden ingeschreven op adres 'A1'
    En de persoon 'Piet'
    * 'Piet' is 4 jaar geleden ingeschreven op adres 'A2'
    En de persoon 'Kees'
    * 'Kees' is 3 jaar geleden ingeschreven op adres 'A3'
    En de persoon 'Gerda'
    * 'Gerda' is 2 jaar geleden ingeschreven op adres 'A4'

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
