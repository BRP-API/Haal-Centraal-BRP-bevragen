#language: nl

@stap-documentatie
Functionaliteit: Reisdocument dan stap definities

  Scenario: Dan heeft de response 0 reisdocumenten
    Gegeven de response body is gelijk aan
    """
    {
      "reisdocumenten": []
    }
    """
    Dan heeft de response 0 reisdocumenten

  Scenario: Dan heeft de response 1 reisdocument
    Gegeven de response body is gelijk aan
    """
    {
      "reisdocumenten": [ {} ]
    }
    """
    Dan heeft de response 1 reisdocument

  Scenario: Dan heeft de response een reisdocument met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "reisdocumenten": [
        {
          "reisdocumentnummer": "NE3663258"
        }
      ]
    }
    """
    Dan heeft de response een reisdocument met de volgende gegevens
    | naam               | waarde    |
    | reisdocumentnummer | NE3663258 |

  Scenario: Dan heeft de response een reisdocument met de volgende gegevens (meerdere reisdocumenten)
    Gegeven de response body is gelijk aan
    """
    {
      "reisdocumenten": [
        {
          "reisdocumentnummer": "NE3663258"
        },
        {
          "reisdocumentnummer": "ID82046A7",
          "soort": {
            "code": "PN"
          }
        }
      ]
    }
    """
    Dan heeft de response een reisdocument met de volgende gegevens
    | naam               | waarde    |
    | reisdocumentnummer | NE3663258 |
    En heeft de response een reisdocument met de volgende gegevens
    | reisdocumentnummer | soort.code |
    | ID82046A7          | PN         |

  Scenario: Dan heeft de response een reisdocument zonder gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "reisdocumenten": [
        {}
      ]
    }
    """
    Dan heeft de response een reisdocument zonder gegevens

  Abstract Scenario: Dan heeft de response een reisdocument met de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "reisdocumenten": [
        {
          "soort": {
            "code": "PN"
          }
        }
      ]
    }
    """
    Dan heeft de response een reisdocument met de volgende 'soort' gegevens
    | naam | waarde |
    | code | PN     |

  Scenario: Dan heeft het reisdocument de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "reisdocumenten": [
        {
          "reisdocumentnummer": "NE3663258",
          "houder": {
            "opschortingBijhouding": {
              "reden": {
                "code": "O"
              }
            }
          }
        }
      ]
    }
    """
    Dan heeft de response een reisdocument met de volgende gegevens
    | reisdocumentnummer |
    | NE3663258          |
    En heeft het reisdocument de volgende 'houder' gegevens
    | opschortingBijhouding.reden.code |
    | O                                |
