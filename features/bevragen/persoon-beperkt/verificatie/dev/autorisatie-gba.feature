#language: nl

Functionaliteit: autorisatie verificatie Persoon Beperkt

  Rule: Vragen met fields om verificatie vereist geen autorisatie voor dat veld

    Abstract Scenario: Afnemer vraagt om <fields> en heeft geen verificatie in de autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120                          | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Vries                 | 19781103              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                             | waarde               |
      | datum verificatie (71.10)        | 20020701             |
      | omschrijving verificatie (71.20) | bewijs nationaliteit |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Vries                               |
      | geboortedatum | 1978-11-03                          |
      | fields        | <fields>                            |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam         | waarde               |
      | datum        | 20020701             |
      | omschrijving | bewijs nationaliteit |

      Voorbeelden:
      | fields                        |
      | verificatie                   |
      | verificatie.omschrijving      |
      | verificatie.datum             |
      | verificatie.datum.type        |
      | verificatie.datum.datum       |
      | verificatie.datum.langFormaat |
      | verificatie.datum.jaar        |
      | verificatie.datum.maand       |
      | verificatie.datum.onbekend    |