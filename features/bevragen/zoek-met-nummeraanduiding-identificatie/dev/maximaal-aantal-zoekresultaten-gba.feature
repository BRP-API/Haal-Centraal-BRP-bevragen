#language: nl

@gba
Functionaliteit: maximaal aantal zoekresultaten ZoekMetNummeraanduidingIdentificatie

  Achtergrond:
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
      | 0599                 | 0518200000617227                           |
      En de persoon met burgerservicenummer '000000001' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000002' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000003' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000004' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000005' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000006' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000007' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000008' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000009' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000010' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000011' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | F      |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
      | 0599                 | 0518200000617228                           |
      En de persoon met burgerservicenummer '000000021' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000022' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000023' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000025' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000026' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000027' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000028' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000029' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000030' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000031' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
    

  Regel: Wanneer er meer dan 10 personen gevonden worden bij zoeken wordt een foutmelding gegeven

    @fout-case
    Scenario: Meer dan 10 personen gevonden
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0518200000617228                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                    |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1               |
      | title    | Teveel zoekresultaten.                                                    |
      | status   | 400                                                                       |
      | detail   | Meer dan maximum van 10 zoekresultaten gevonden. Verfijn de zoekopdracht. |
      | code     | tooManyResults                                                            |
      | instance | /haalcentraal/api/brp/personen                                            |

    Scenario: Zoekopdracht vindt exact 10 personen omdat overleden personen en afgevoerde persoonslijsten niet worden geleverd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0518200000617227                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 10 personen

    @fout-case
    Scenario: Meer dan 10 personen omdat ook overleden personen gezocht is
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0518200000617227                     |
      | inclusiefOverledenPersonen    | true                                 |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                    |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1               |
      | title    | Teveel zoekresultaten.                                                    |
      | status   | 400                                                                       |
      | detail   | Meer dan maximum van 10 zoekresultaten gevonden. Verfijn de zoekopdracht. |
      | code     | tooManyResults                                                            |
      | instance | /haalcentraal/api/brp/personen                                            |
