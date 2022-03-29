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

Rule: De Fields parameter bevat het volledige pad naar de op te vragen velden gescheiden door een komma

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
    | code   | name   | reason                                       |
    | fields | fields | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Scenario: Pad van een gevraagde veld is opgegeven in onjuiste case
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
    | code   | name   | reason                                       |
    | fields | fields | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Scenario: Opgegeven pad is niet het volledige pad naar het gevraagde veld 
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | datumVan                        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason                                              |
    | fields | fields | Deel van de parameterwaarde niet correct: datumVan. |

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
  Scenario: Gevraagde velden worden niet gescheiden door een komma
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                 |
    | type                | RaadpleegMetBurgerservicenummer        |
    | burgerservicenummer | 999994086                              |
    | fields              | burgerservicenummer\naam.geslachtsnaam |
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
