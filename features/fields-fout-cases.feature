#language: nl

@post-assert
Functionaliteit: Fields fout cases

Rule: De Fields parameter is verplicht.

  @fout-case
  Scenario: Fields parameter ontbreekt
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
  Scenario: Fields parameter is leeg
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
    | code    | name   | reason                                              |
    | pattern | fields | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\.,_]+$. |

Rule: De Fields parameter bevat het pad naar de op te vragen velden gescheiden door een komma
  - zie fields-mapping.csv: wanneer een in fields opgegeven veld(pad) niet voorkomt in de linker kolom, geeft dat een foutmelding
  - velden worden gescheiden door een komma, zonder spatie

  @fout-case
  Scenario: Gevraagde veld bestaat niet
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | burgerservicenummer,bestaatniet |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason                                                 |
    | fields | fields | Deel van de parameterwaarde niet correct: bestaatniet. |

  @fout-case
  Scenario: Pad van een gevraagd veld is opgegeven in onjuiste case
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 999994086                               |
    | fields              | BurgerServiceNummer,geslachtsaanduiding |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason                                                         |
    | fields | fields | Deel van de parameterwaarde niet correct: BurgerServiceNummer. |

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
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason                                           |
    | fields | fields | Deel van de parameterwaarde niet correct: <pad>. |

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
  Scenario: Fields parameter bevat spaties
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
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name   | reason                                              |
    | pattern | fields | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\.,_]+$. |

  @fout-case
  Scenario: Fields parameter bevat dubbele komma
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
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason                                       |
    | fields | fields | Deel van de parameterwaarde niet correct: ,. |

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
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason   |
    | <code> | fields | <reason> |

    Voorbeelden:
    | fields                                 | code    | reason                                                                            |
    | burgerservicenummer\naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\.,_]+$.                               |
    | burgerservicenummer;naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\.,_]+$.                               |
    | burgerservicenummer naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\.,_]+$.                               |
    | burgerservicenummer_naam.geslachtsnaam | fields  | Deel van de parameterwaarde niet correct: burgerservicenummer_naam.geslachtsnaam. |
    | burgerservicenummernaam.geslachtsnaam  | fields  | Deel van de parameterwaarde niet correct: burgerservicenummernaam.geslachtsnaam.  |
