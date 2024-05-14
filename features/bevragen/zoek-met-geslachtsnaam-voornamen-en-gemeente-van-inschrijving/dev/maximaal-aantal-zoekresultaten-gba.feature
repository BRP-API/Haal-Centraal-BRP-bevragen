#language: nl

@gba
Functionaliteit: maximaal aantal zoekresultaten ZoekMetNaamEnGemeenteVanInschrijving

  Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000001' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000002' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000003' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000004' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000005' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000006' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000007' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000008' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000009' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000010' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000011' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      En de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | F      |
      En de persoon met burgerservicenummer '000000013' heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Maassen               | Pieter            | V                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
    

  Regel: Wanneer er meer dan 10 personen gevonden worden bij zoeken wordt een foutmelding gegeven

    @fout-case
    Scenario: Meer dan 10 personen gevonden
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                               |
      | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
      | geslachtsnaam           | Maassen                              |
      | voornamen               | Pieter                               |
      | gemeenteVanInschrijving | 0014                                 |
      | fields                  | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                    |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1               |
      | title    | Teveel zoekresultaten.                                                    |
      | status   | 400                                                                       |
      | detail   | Meer dan maximum van 10 zoekresultaten gevonden. Verfijn de zoekopdracht. |
      | code     | tooManyResults                                                            |
      | instance | /haalcentraal/api/brp/personen                                            |

    Scenario: Verfijnde zoekopdracht vindt exact 10 personen omdat overleden personen en afgevoerde persoonslijsten niet worden geleverd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                               |
      | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
      | geslachtsnaam           | Maassen                              |
      | voornamen               | Pieter                               |
      | gemeenteVanInschrijving | 0014                                 |
      | geslacht                | M                                    |
      | fields                  | burgerservicenummer                  |
      Dan heeft de response 10 personen

    @fout-case
    Scenario: Meer dan 10 personen omdat ook overleden personen gezocht is
      Als gba personen wordt gezocht met de volgende parameters
      | naam                       | waarde                               |
      | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
      | geslachtsnaam              | Maassen                              |
      | voornamen                  | Pieter                               |
      | gemeenteVanInschrijving    | 0014                                 |
      | geslacht                   | M                                    |
      | inclusiefOverledenPersonen | true                                 |
      | fields                     | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                    |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1               |
      | title    | Teveel zoekresultaten.                                                    |
      | status   | 400                                                                       |
      | detail   | Meer dan maximum van 10 zoekresultaten gevonden. Verfijn de zoekopdracht. |
      | code     | tooManyResults                                                            |
      | instance | /haalcentraal/api/brp/personen                                            |
