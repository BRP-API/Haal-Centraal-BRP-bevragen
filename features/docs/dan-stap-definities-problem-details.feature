#language: nl

@stap-documentatie
Functionaliteit: Problem Details dan stap definities

  Als consumer van een BRP api
  wil ik dat client en server fouten wordt geleverd conform 'RFC 9457 Problem Details for HTTP APIs'
  zodat mijn consumer applicaties op een consistente manier fouten van de BRP API kan verwerken

  @fout-case
  Scenario: Dan heeft de response de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: type.",
      "code": "paramsValidation",
      "instance": "/api/brp/personen"
    }
    """
    En de response headers is gelijk aan
    | naam         | waarde                   |
    | content-type | application/problem+json |
    En de response status is gelijk aan 400
    Dan heeft de response een foutmelding
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /api/brp/personen                                           |

  Scenario: Dan de volgende invalidParams foutmeldingen
    Gegeven de response body is gelijk aan
    """
    {
      "invalidParams": [
        {
          "code": "required",
          "name": "geboortedatum",
          "reason": "Parameter is verplicht."
        },
        {
          "code": "required",
          "name": "geslachtsnaam",
          "reason": "Parameter is verplicht."
        }
      ]
    }
    """
    Dan parameter foutmeldingen
    | code     | name          | reason                  |
    | required | geboortedatum | Parameter is verplicht. |
    | required | geslachtsnaam | Parameter is verplicht. |

  @fout-case
  Scenario: Dan heeft de response de volgende gegevens en heeft de response invalidParams met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: type.",
      "code": "paramsValidation",
      "instance": "/api/brp/personen",
      "invalidParams": [
        {
          "code": "required",
          "name": "geboortedatum",
          "reason": "Parameter is verplicht."
        },
        {
          "code": "required",
          "name": "geslachtsnaam",
          "reason": "Parameter is verplicht."
        }
      ]
    }
    """
    En de response headers is gelijk aan
    | naam         | waarde                   |
    | content-type | application/problem+json |
    En de response status is gelijk aan 400
    Dan heeft de response een foutmelding
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /api/brp/personen                                           |
    En parameter foutmeldingen
    | code     | name          | reason                  |
    | required | geboortedatum | Parameter is verplicht. |
    | required | geslachtsnaam | Parameter is verplicht. |
