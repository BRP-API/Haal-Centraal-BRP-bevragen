#language: nl

@stap-documentatie
Functionaliteit: Kind dan stap definities

  Abstract Scenario: Dan heeft de response een persoon met een 'kind' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "kinderen": [
            {
              "burgerservicenummer": "000000013"
            }
          ]
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam                | waarde    |
    | burgerservicenummer | 000000013 |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                          |
    | heeft de response een persoon met een 'kind' met de volgende gegevens        |
    | heeft de response een persoon met een 'kind' met alleen de volgende gegevens |

  Abstract Scenario: Dan heeft de response een persoon met een 'kind' met (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "kinderen": [
            {
              "naam": {
                "geslachtsnaam": "Pietersen"
              }
            }
          ]
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam          | waarde    |
    | geslachtsnaam | Pietersen |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                                 |
    | heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens        |
    | heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens |

  Scenario: Dan heeft de response een persoon zonder kinderen
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "kinderen": []
        }
      ]
    }
    """
    Dan heeft de response een persoon zonder kinderen

  Scenario: Dan heeft de response een persoon met een 'kind' zonder gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "kinderen": [
            {}
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'kind' zonder gegevens

  Scenario: Dan heeft de response een persoon met een 'kind' zonder '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "kinderen": [
            {
              "naam": {}
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

  Abstract Scenario: Dan heeft de persoon een 'kind' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "kinderen": [
            {
              "burgerservicenummer": "000000013"
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    Dan <stap definitie met hetzelfde gedrag>
    | naam                | waarde    |
    | burgerservicenummer | 000000013 |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                         |
    | heeft de persoon een 'kind' met de volgende gegevens        |
    | heeft de persoon een 'kind' met alleen de volgende gegevens |

  Scenario: Dan heeft de persoon een 'kind' met (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "kinderen": [
            {
              "naam": {
                "geslachtsnaam": "Jansen"
              }
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    Dan <stap definitie met hetzelfde gedrag>
    | naam          | waarde |
    | geslachtsnaam | Jansen |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                |
    | heeft de persoon een 'kind' met de volgende 'naam' gegevens        |
    | heeft de persoon een 'kind' met alleen de volgende 'naam' gegevens |

  Scenario: Dan heeft de persoon geen kinderen
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "kinderen": []
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En heeft de persoon geen kinderen

  Scenario: Dan heeft het 'kind' geen '[gegevensgroep]' gegevens
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
            "kinderen": [
              {
                "naam": {},
                "geboorte": {}
              }
            ]
          }
        ]
      }
      """
      Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens
      En heeft het 'kind' geen 'geboorte' gegevens
