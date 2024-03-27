#language: nl

@input-validatie
Functionaliteit: input validatie


Regel: Er moet een valide zoek type worden opgegeven

  @fout-case
  Scenario: zoek zonder opgeven van parameters
    Als personen wordt gezocht met de volgende parameters
    | naam | waarde |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: zoek zonder opgeven van 'type' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam     | waarde |
    | postcode | 3077AW |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: zoek met lege type 
    Als personen wordt gezocht met de volgende parameters
    | naam | waarde |
    | type |        |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code  | name | reason                           |
    | value | type | Waarde is geen geldig zoek type. |

  @fout-case
  Abstract Scenario: zoek met ongeldige type waarde
    Als personen wordt gezocht met de volgende parameters
    | naam | waarde |
    | type | <type> |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code  | name | reason                           |
    | value | type | Waarde is geen geldig zoek type. |

    Voorbeelden:
    | omschrijving               | type                                |
    | ongeldig zoek type         | OnbekendZoekType                    |
    | type voldoet niet aan case | zoekmetgeslachtsnaamengeboortedatum |


Regel: als content type voor de response wordt alleen application/json en charset utf-8 ondersteund

  @fout-case
  Scenario: Gevraagde Accept content type wordt niet ondersteund
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321                       |
    | fields              | burgerservicenummer             |
    | header: Accept      | application/xml                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6 |
    | title    | Gevraagde content type wordt niet ondersteund.              |
    | detail   | Ondersteunde content type: application/json; charset=utf-8. |
    | code     | notAcceptable                                               |
    | status   | 406                                                         |
    | instance | /haalcentraal/api/brp/personen                              |

  @geen-protocollering
  Abstract Scenario: '<accept media type>' als Accept content type wordt ondersteund
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | burgerservicenummer             |
    | header: Accept      | <accept media type>             |
    Dan heeft de response 0 personen

    Voorbeelden:
    | accept media type               |
    | */*                             |
    | */*; charset=utf-8              |
    | */*;charset=utf-8               |
    | application/json                |
    | application/json; charset=utf-8 |
    | application/json;charset=utf-8  |
    | */*;charset=UTF-8               |
    | application/json;charset=Utf-8  |
    | application/json; charset=UTF-8 |


Regel: als content type voor het request wordt alleen application/json en charset utf-8 ondersteund

  @geen-protocollering
  Abstract Scenario: '<media type>' als Content-Type waarde wordt ondersteund
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                          |
    | type                 | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer  | 000000024                       |
    | fields               | burgerservicenummer             |
    | header: Content-Type | <media type>                    |
    Dan heeft de response 0 personen

    Voorbeelden:
    | media type                      |
    | application/json                |
    | application/json;charset=utf-8  |
    | application/json; charset=utf-8 |
    | application/json;charset=Utf-8  |
    | application/json; charset=UTF-8 |

  @geen-protocollering
  Abstract Scenario: '<media type>' als Content-Type waarde wordt ondersteund bij zoeken
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                              |
    | type                 | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam        | brănduş-dendyuk                     |
    | geboortedatum        | 1983-05-26                          |
    | voornamen            | Kuşan                               |
    | fields               | burgerservicenummer                 |
    | header: Content-Type | <media type>                        |
    Dan heeft de response 0 personen

    Voorbeelden:
    | media type                      |
    | application/json                |
    | application/json;charset=utf-8  |
    | application/json; charset=utf-8 |
    | application/json;charset=Utf-8  |
    | application/json; charset=UTF-8 |

  @fout-case
  Abstract Scenario: '<media type>' als Content-Type waarde wordt niet ondersteund
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                          |
    | type                 | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer  | 999999321                       |
    | fields               | burgerservicenummer             |
    | header: Content-Type | <media type>                    |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.13 |
    | title    | Media Type wordt niet ondersteund.                           |
    | detail   | Ondersteunde content type: application/json; charset=utf-8.  |
    | code     | unsupportedMediaType                                         |
    | status   | 415                                                          |
    | instance | /haalcentraal/api/brp/personen                               |

    Voorbeelden:
    | media type                       |
    | application/xml                  |
    | text/csv                         |
    | application/json; charset=cp1252 |
    | */*                              |
    | */*; charset=utf-8               |
    | */*;charset=utf-8                |


Regel: content type voor de response is default application/json en charset utf-8

  @geen-protocollering
  Scenario: Lege Accept content type wordt ondersteund
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | burgerservicenummer             |
    | header: Accept      |                                 |
    Dan heeft de response 0 personen


Regel: content type voor het request is default application/json en charset utf-8

  @geen-protocollering
  Scenario: Lege Content-Type wordt ondersteund
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                          |
    | type                 | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer  | 000000024                       |
    | fields               | burgerservicenummer             |
    | header: Content-Type |                                 |
    Dan heeft de response 0 personen

  @geen-protocollering
  Scenario: Lege Content-Type wordt ondersteund bij zoeken
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                              |
    | type                 | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam        | brănduş-dendyuk                     |
    | geboortedatum        | 1983-05-26                          |
    | voornamen            | Kuşan                               |
    | fields               | burgerservicenummer                 |
    | header: Content-Type |                                     |
    Dan heeft de response 0 personen

Regel: Om privacy en security redenen moet een bevraging van reisdocumenten worden gedaan met behulp van de POST aanroep

  @fout-case
  Abstract Scenario: '<aanroep type>' aanroep wordt niet ondersteund
    Als personen wordt gezocht met een '<aanroep type>' aanroep
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.5 |
    | title    | Gebruikte bevragingsmethode is niet toegestaan.             |
    | status   | 405                                                         |
    | code     | methodNotAllowed                                            |
    | instance | /haalcentraal/api/brp/personen                              |

    Voorbeelden:
    | aanroep type |
    | GET          |
    | PUT          |
    | PATCH        |
    | DELETE       |
  # | CONNECT      | een CONNECT aanroep wordt niet gebruikt om te bevragen
  # | HEAD         | een HEAD response bevat geen body
    | OPTIONS      |
    | TRACE        |
