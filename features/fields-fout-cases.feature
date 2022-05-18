#language: nl

@post-assert
Functionaliteit: Fields fout cases

Rule: De Fields parameter is verplicht.

  @fout-case
  Scenario: Raadpleeg met burgerservicenummer: Fields parameter ontbreekt
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                                                   |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsCombination                                                                                           |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                  |
    | required | fields | Parameter is verplicht. |

  @fout-case
  Scenario: Zoek met geslachtsnaam en geboortedatum: Fields parameter ontbreekt
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                                                   |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsCombination                                                                                           |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                  |
    | required | fields | Parameter is verplicht. |

  @fout-case
  Scenario: Raadpleeg met burgerservicenummer: Fields parameter is leeg
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              |                                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                          |
    | minItems | fields | Array bevat minder dan 1 items. |

  @fout-case
  Scenario: Zoek met geslachtsnaam en geboortedatum: Fields parameter is leeg
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        |                                     |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                          |
    | minItems | fields | Array bevat minder dan 1 items. |

Rule: De Fields parameter mag maximaal 130 veld paden bevatten

  Scenario: Raadpleeg met burgerservicenummer: Fields parameter bevat meer dan 130 veld paden
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | (131 maal aNummer)              |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                          |
    | maxItems | fields | Array bevat meer dan 130 items. |

  Scenario: Zoek met geslachtsnaam en geboortedatum: Fields parameter bevat meer dan 130 veld paden
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | (131 maal aNummer)                  |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                          |
    | maxItems | fields | Array bevat meer dan 130 items. |

Rule: De Fields parameter bevat het pad naar de op te vragen velden
  - zie fields-mapping.csv: wanneer een in fields opgegeven veld(pad) niet voorkomt in de linker kolom, geeft dat een foutmelding
  - velden worden gescheiden door een komma, zonder spatie

  @fout-case
  Abstract Scenario: Raadpleeg met burgerservicenummer: gevraagde veld bestaat niet
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | <fields>                        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                                                                   |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason   |
    | <code> | fields[0] | <reason> |

    Voorbeelden:
    | code    | reason                                                   | fields                                                                                                                                                                                                   |
    | fields  | Parameter bevat een niet bestaande veldnaam.             | bestaatniet                                                                                                                                                                                              |
    | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. | bestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbest |

  @fout-case
  Abstract Scenario: Zoek met geslachtsnaam en geboortedatum: gevraagde veld bestaat niet
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | <fields>                            |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                                                                   |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason   |
    | <code> | fields[0] | <reason> |

    Voorbeelden:
    | code    | reason                                                   | fields                                                                                                                                                                                                   |
    | fields  | Parameter bevat een niet bestaande veldnaam.             | bestaatniet                                                                                                                                                                                              |
    | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. | bestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbest |

  @fout-case
  Scenario: Raadpleeg met burgerservicenummer: meerdere gevraagde velden bestaan niet
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                         |
    | type                | RaadpleegMetBurgerservicenummer                |
    | burgerservicenummer | 999994086                                      |
    | fields              | burgerservicenummer,bestaatniet,bestaatookniet |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1], fields[2].                                                        |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[1] | Parameter bevat een niet bestaande veldnaam. |
    | fields | fields[2] | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Scenario: Pad van een gevraagd veld is opgegeven in onjuiste case
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | BurgerServiceNummer,geslacht    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                                                                   |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Abstract Scenario: opgegeven pad leidt tot meer dan één veld
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999995078                       |
    | fields              | burgerservicenummer,<pad>       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                                                                   |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[1] | Parameter bevat een niet bestaande veldnaam. |

    Voorbeelden:
    | pad                                  |
    | voorletters                          |
    | voornamen                            |
    | adellijkeTitelPredicaat              |
    | adellijkeTitelPredicaat.code         |
    | adellijkeTitelPredicaat.omschrijving |
    | adellijkeTitelPredicaat.soort        |
    | voorvoegsel                          |
    | geslachtsnaam                        |
    | datum                                |
    | plaats                               |
    | land                                 |
    | type                                 |
    | code                                 |
    | plaats.code                          |
    | land.code                            |
    | omschrijving                         |
    | plaats.omschrijving                  |
    | land.omschrijving                    |
    | soort                                |
    | datumIngangGeldigheid                |
    | indicatieOnbekend                    |

  @fout-case
  Scenario: Veld pad bevat spaties
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | burgerservicenummer, naam       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                                                                   |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name      | reason                                                   |
    | pattern | fields[1] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |

  @fout-case
  Scenario: Veld pad is een lege string
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | burgerservicenummer,,naam       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                                                                   |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name      | reason                                                   |
    | pattern | fields[1] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |

  @fout-case
  Abstract Scenario: Gevraagde velden worden niet gescheiden door een komma
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | <fields>                        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                                                                   |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason   |
    | <code> | fields[0] | <reason> |

    Voorbeelden:
    | fields                                 | code    | reason                                                   |
    | burgerservicenummer\naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |
    | burgerservicenummer;naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |
    | burgerservicenummer naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |
    | burgerservicenummer_naam.geslachtsnaam | fields  | Parameter bevat een niet bestaande veldnaam.             |
    | burgerservicenummernaam.geslachtsnaam  | fields  | Parameter bevat een niet bestaande veldnaam.             |

  @fout-case
  Scenario: Zoek met geslachtsnaam en geboortedatum: gevraagde veld is geen PersoonBeperkt veld
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | burgerservicenummer,aNummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                                                                   |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[1] | Parameter bevat een niet bestaande veldnaam. |
