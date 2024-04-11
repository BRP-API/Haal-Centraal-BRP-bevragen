# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van Europees kiesrecht van Persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                                             | missende autorisatie | ad hoc rubrieken            |
      | europeesKiesrecht                                  | 133110               | 133120 133130 133810 133820 |
      | europeesKiesrecht                                  | 133130               | 133110 133120 133810 133820 |
      | europeesKiesrecht.aanduiding                       | 133110               | 133120 133130 133810 133820 |
      | europeesKiesrecht.aanduiding.code                  | 133110               | 133120 133130 133810 133820 |
      | europeesKiesrecht.aanduiding.omschrijving          | 133110               | 133120 133130 133810 133820 |
      | europeesKiesrecht.einddatumUitsluiting             | 133130               | 133110 133120 133810 133820 |
      | europeesKiesrecht.einddatumUitsluiting.langFormaat | 133130               | 133110 133120 133810 133820 |
      | europeesKiesrecht.einddatumUitsluiting.type        | 133130               | 133110 133120 133810 133820 |
      | europeesKiesrecht.einddatumUitsluiting.datum       | 133130               | 133110 133120 133810 133820 |
      | europeesKiesrecht.einddatumUitsluiting.onbekend    | 133130               | 133110 133120 133810 133820 |
      | europeesKiesrecht.einddatumUitsluiting.jaar        | 133130               | 133110 133120 133810 133820 |
      | europeesKiesrecht.einddatumUitsluiting.maand       | 133130               | 133110 133120 133810 133820 |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | fields                                             | ad hoc rubrieken |
      | europeesKiesrecht                                  | 133110 133130    |
      | europeesKiesrecht.aanduiding                       | 133110           |
      | europeesKiesrecht.aanduiding.code                  | 133110           |
      | europeesKiesrecht.aanduiding.omschrijving          | 133110           |
      | europeesKiesrecht.einddatumUitsluiting             | 133130           |
      | europeesKiesrecht.einddatumUitsluiting.langFormaat | 133130           |
      | europeesKiesrecht.einddatumUitsluiting.type        | 133130           |
      | europeesKiesrecht.einddatumUitsluiting.datum       | 133130           |
      | europeesKiesrecht.einddatumUitsluiting.onbekend    | 133130           |
      | europeesKiesrecht.einddatumUitsluiting.jaar        | 133130           |
      | europeesKiesrecht.einddatumUitsluiting.maand       | 133130           |
