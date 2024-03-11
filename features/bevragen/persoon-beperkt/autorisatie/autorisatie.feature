# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van Persoon bij zoeken

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) |
      | 19830526              | Maassen               |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | <fields>                            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                | missende autorisatie | ad hoc rubrieken                                            |
      | burgerservicenummer   | 10120                | 10110 10210 10240 10310 10410 20120 30120 50120 80910 90120 |
      | geslacht              | 10410                | 10110 10120 10210 10240 10310 20410 30410 50410 80910       |
      | geslacht.code         | 10410                | 10110 10120 10210 10240 10310 20410 30410 50410 80910       |
      | geslacht.omschrijving | 10410                | 10110 10120 10210 10240 10310 20410 30410 50410 80910       |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10240 10310 <ad hoc rubrieken>  | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) |
      | 19830526              | Maassen               |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | <fields>                            |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | fields                | ad hoc rubrieken |
      | burgerservicenummer   | 10120            |
      | geslacht              | 10410            |
      | geslacht.code         | 10410            |
      | geslacht.omschrijving | 10410            |
