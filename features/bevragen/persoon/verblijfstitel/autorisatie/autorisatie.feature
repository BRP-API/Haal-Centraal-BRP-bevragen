# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van verblijfstitelgegevens van Persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
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
      | fields                                 | missende autorisatie | ad hoc rubrieken |
      | verblijfstitel                         | 103910               | 103920 103930    |
      | verblijfstitel                         | 103920               | 103910 103930    |
      | verblijfstitel                         | 103930               | 103910 103920    |
      | verblijfstitel.aanduiding              | 103910               | 103920 103930    |
      | verblijfstitel.aanduiding.code         | 103910               | 103920 103930    |
      | verblijfstitel.aanduiding.omschrijving | 103910               | 103920 103930    |
      | verblijfstitel.datumEinde              | 103920               | 103910 103930    |
      | verblijfstitel.datumEinde.langFormaat  | 103920               | 103910 103930    |
      | verblijfstitel.datumEinde.type         | 103920               | 103910 103930    |
      | verblijfstitel.datumEinde.datum        | 103920               | 103910 103930    |
      | verblijfstitel.datumEinde.onbekend     | 103920               | 103910 103930    |
      | verblijfstitel.datumEinde.jaar         | 103920               | 103910 103930    |
      | verblijfstitel.datumEinde.maand        | 103920               | 103910 103930    |
      | verblijfstitel.datumIngang             | 103930               | 103910 103920    |
      | verblijfstitel.datumIngang.langFormaat | 103930               | 103910 103920    |
      | verblijfstitel.datumIngang.type        | 103930               | 103910 103920    |
      | verblijfstitel.datumIngang.datum       | 103930               | 103910 103920    |
      | verblijfstitel.datumIngang.onbekend    | 103930               | 103910 103920    |
      | verblijfstitel.datumIngang.jaar        | 103930               | 103910 103920    |
      | verblijfstitel.datumIngang.maand       | 103930               | 103910 103920    |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
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
      | fields                                 | ad hoc rubrieken     |
      | verblijfstitel                         | 103910 103920 103930 |
      | verblijfstitel.aanduiding              | 103910               |
      | verblijfstitel.aanduiding.code         | 103910               |
      | verblijfstitel.aanduiding.omschrijving | 103910               |
      | verblijfstitel.datumEinde              | 103920               |
      | verblijfstitel.datumEinde.langFormaat  | 103920               |
      | verblijfstitel.datumEinde.type         | 103920               |
      | verblijfstitel.datumEinde.datum        | 103920               |
      | verblijfstitel.datumEinde.onbekend     | 103920               |
      | verblijfstitel.datumEinde.jaar         | 103920               |
      | verblijfstitel.datumEinde.maand        | 103920               |
      | verblijfstitel.datumIngang             | 103930               |
      | verblijfstitel.datumIngang.langFormaat | 103930               |
      | verblijfstitel.datumIngang.type        | 103930               |
      | verblijfstitel.datumIngang.datum       | 103930               |
      | verblijfstitel.datumIngang.onbekend    | 103930               |
      | verblijfstitel.datumIngang.jaar        | 103930               |
      | verblijfstitel.datumIngang.maand       | 103930               |
