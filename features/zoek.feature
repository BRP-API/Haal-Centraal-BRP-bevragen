#language: nl

@post-assert
Functionaliteit: Zoeken

Rule: Er moet een valide zoek type worden opgegeven

  @fout-case
  Scenario: zoek zonder opgeven van type
    Als personen wordt gezocht met de volgende parameters
    | naam | waarde |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                                                   |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                                                                        |
    | code     | paramsCombination                                                                                           |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: zoek met lege type
    Als personen wordt gezocht met de volgende parameters
    | naam | waarde |
    | type |        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                                                   |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                                                                        |
    | code     | paramsCombination                                                                                           |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: zoek met ongeldige type waarde
    Als personen wordt gezocht met de volgende parameters
    | naam | waarde           |
    | type | OnbekendZoekType |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                                                                        |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name | reason                           |
    | value | type | Waarde is geen geldig zoek type. |
