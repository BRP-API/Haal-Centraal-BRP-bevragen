#language: nl

@gba
Functionaliteit: ZoekMetNummeraanduidingIdentificatie bij geblokkeerde persoonslijst

  Regel: zoeken vindt ook personen waarvan de persoonslijst is geblokkeerd

    Scenario: Persoonslijst is geblokkeerd
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
      | 0518                 | 0518200000617227                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | Datum ingang blokkering (66.20) |
      | 20230221                        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0518200000617227                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 2 personen
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |