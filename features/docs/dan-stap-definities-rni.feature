#language: nl

@stap-documentatie
Functionaliteit: RNI dan stap definities

  Abstract Scenario: Dan heeft de response een persoon met een 'rni' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "rni": [
            {
              "deelnemer": {
                "code": "0201"
              }
            }
          ]
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam           | waarde |
    | deelnemer.code | 0201   |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                         |
    | heeft de response een persoon met een 'rni' met de volgende gegevens        |
    | heeft de response een persoon met een 'rni' met alleen de volgende gegevens |

  Abstract Scenario: Dan heeft de persoon een 'rni' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "rni": [
            {
              "omschrijvingVerdrag": "Belastingverdrag tussen België en Nederland"
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    En <stap definitie met hetzelfde gedrag>
    | naam                | waarde                                      |
    | omschrijvingVerdrag | Belastingverdrag tussen België en Nederland |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                        |
    | heeft de persoon een 'rni' met de volgende gegevens        |
    | heeft de persoon een 'rni' met alleen de volgende gegevens |
