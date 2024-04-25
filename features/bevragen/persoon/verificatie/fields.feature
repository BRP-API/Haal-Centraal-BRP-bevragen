#language: nl

Functionaliteit: Persoon: verificatie leveren als niet gevraagd met fields
    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
      | naam                             | waarde               |
      | datum verificatie (71.10)        | 20020701             |
      | omschrijving verificatie (71.20) | bewijs nationaliteit |

  Regel: verificatie van de persoonsgegevens wordt bij elke vraag teruggegeven

    Abstract Scenario: persoonsgegevens zijn geverifieerd en verificatie wordt niet gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam              | waarde               |
      | datum.type        | Datum                |
      | datum.datum       | 2002-07-01           |
      | datum.langFormaat | 1 juli 2002          |
      | omschrijving      | bewijs nationaliteit |

      Voorbeelden:
      | fields           |
      | naam.voorvoegsel |
      | verblijfstitel   |
      | overlijden.datum |
      | immigratie       |

    Abstract Scenario: 'datum verificatie (71.10)' van het type '<type>'
      Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'inschrijving' gegevens
      | naam                      | waarde     |
      | datum verificatie (71.10) | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000140                       |
      | fields              | overlijden                      |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam              | waarde        |
      | datum.type        | <type>        |
      | datum.datum       | <datum>       |
      | datum.jaar        | <jaar>        |
      | datum.maand       | <maand>       |
      | datum.onbekend    | <onbekend>    |
      | datum.langFormaat | <langFormaat> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |


 Regel: verificatie mag niet worden gevraagd, omdat het automatisch wordt geleverd

   @fout-case
   Abstract Scenario: veld <fields> mag niet worden gevraagd, omdat het automatisch wordt geleverd 
     Als personen wordt gezocht met de volgende parameters
     | naam                | waarde                          |
     | type                | RaadpleegMetBurgerservicenummer |
     | burgerservicenummer | 000000024                       |
     | fields              | <fields>                        |
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
