#language: nl

@gba
Functionaliteit: verificatie velden vragen met fields (persoon beperkt)

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Vries                 | 19781103              |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                             | waarde               |
    | datum verificatie (71.10)        | 20020701             |
    | omschrijving verificatie (71.20) | bewijs nationaliteit |

  Regel: verificatie van de persoonsgegevens wordt bij elke vraag teruggegeven

    Scenario: persoonsgegevens zijn geverifieerd en verificatie wordt niet gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Vries                               |
      | geboortedatum | 1978-11-03                          |
      | fields        | geslacht                            |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam         | waarde               |
      | datum        | 20020701             |
      | omschrijving | bewijs nationaliteit |

Regel: verificatie mag niet worden gevraagd, omdat het automatisch wordt geleverd

    @fout-case
    Abstract Scenario: veld <fields> mag niet worden gevraagd, omdat het automatisch wordt geleverd
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Vries                               |
      | geboortedatum | 1978-11-03                          |
      | fields        | <fields>                            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: fields[0].                   |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brp/personen                              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code   | name      | reason                                        |
      | fields | fields[0] | Parameter bevat een niet toegestane veldnaam. |

      Voorbeelden:
      | fields                        |
      | verificatie                   |
      | verificatie.datum             |
      | verificatie.datum.type        |
      | verificatie.datum.datum       |
      | verificatie.datum.jaar        |
      | verificatie.datum.maand       |
      | verificatie.datum.onbekend    |
      | verificatie.datum.langFormaat |
      | verificatie.omschrijving      |
