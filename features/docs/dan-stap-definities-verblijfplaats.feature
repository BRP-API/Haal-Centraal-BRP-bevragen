#language: nl

@stap-documentatie
Functionaliteit: Verblijfplaats dan stap definities

  Scenario: Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "verblijfplaats": {
            "type": "VerblijfplaatsBuitenland"
          }
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | type                     |
    | VerblijfplaatsBuitenland |

  Scenario: Dan heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "verblijfplaats": {
            "type": "VerblijfplaatsBuitenland",
            "verblijfadres": {
              "land": {
                "code": "5010",
                "omschrijving": "België"
              }
            }
          }
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | type                     |
    | VerblijfplaatsBuitenland |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam              | waarde |
    | land.code         | 5010   |
    | land.omschrijving | België |

  Scenario: Dan heeft de 'verblijfplaats' geen 'verblijfadres' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "verblijfplaats": {
            "type": "VerblijfplaatsBuitenland",
            "verblijfadres": {}
          }
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | type                     |
    | VerblijfplaatsBuitenland |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens
