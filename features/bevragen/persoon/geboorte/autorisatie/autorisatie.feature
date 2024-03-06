# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van geboortegegevens van Persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
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
      | fields                       | missende autorisatie | ad hoc rubrieken                                                              |
      | geboorte                     | 10310 10320 10330    | 10120 10210 20310 20320 20330 30310 30320 30330 50310 50320 50330             |
      | geboorte                     | 10310                | 10120 10210 10320 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte                     | 10320                | 10120 10210 10310 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte                     | 10330                | 10120 10210 10310 10320 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.datum               | 10310                | 10120 10210 10320 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.datum.langFormaat   | 10310                | 10120 10210 10320 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.datum.type          | 10310                | 10120 10210 10320 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.datum.datum         | 10310                | 10120 10210 10320 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.datum.onbekend      | 10310                | 10120 10210 10320 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.datum.jaar          | 10310                | 10120 10210 10320 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.datum.maand         | 10310                | 10120 10210 10320 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.land                | 10330                | 10120 10210 10310 10320 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.land.code           | 10330                | 10120 10210 10310 10320 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.land.omschrijving   | 10330                | 10120 10210 10310 10320 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.plaats              | 10320                | 10120 10210 10310 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.plaats.code         | 10320                | 10120 10210 10310 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |
      | geboorte.plaats.omschrijving | 10320                | 10120 10210 10310 10330 20310 20320 20330 30310 30320 30330 50310 50320 50330 |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
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
      | fields                       | ad hoc rubrieken                                                              |
      | geboorte                     | 10310 10320 10330    |
      | geboorte.datum               | 10310                |
      | geboorte.datum.langFormaat   | 10310                |
      | geboorte.datum.type          | 10310                |
      | geboorte.datum.datum         | 10310                |
      | geboorte.datum.onbekend      | 10310                |
      | geboorte.datum.jaar          | 10310                |
      | geboorte.datum.maand         | 10310                |
      | geboorte.land                | 10330                |
      | geboorte.land.code           | 10330                |
      | geboorte.land.omschrijving   | 10330                |
      | geboorte.plaats              | 10320                |
      | geboorte.plaats.code         | 10320                |
      | geboorte.plaats.omschrijving | 10320                |
