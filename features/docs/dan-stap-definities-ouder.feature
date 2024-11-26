#language: nl

@stap-documentatie
Functionaliteit: Ouder dan stap definities

  Abstract Scenario: Dan heeft de response een persoon met een 'ouder' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "ouders": [
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
    | stap definitie met hetzelfde gedrag                                           |
    | heeft de response een persoon met een 'ouder' met de volgende gegevens        |
    | heeft de response een persoon met een 'ouder' met alleen de volgende gegevens |

  Abstract Scenario: Dan heeft de response een persoon met een 'ouder' met (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "ouders": [
            {
              "naam": {
                "geslachtsnaam": "Aedel"
              }
            }
          ]
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam          | waarde |
    | geslachtsnaam | Aedel  |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                                  |
    | heeft de response een persoon met een 'ouder' met de volgende 'naam' gegevens        |
    | heeft de response een persoon met een 'ouder' met alleen de volgende 'naam' gegevens |

  Scenario: Dan heeft de response een persoon zonder ouders
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "ouders": []
        }
      ]
    }
    """
    Dan heeft de response een persoon zonder ouders

  Scenario: Dan heeft de response een persoon met een 'ouder' zonder '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "ouders": [
            {
              "naam": {}
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'ouder' zonder 'naam' gegevens

  Abstract Scenario: Dan heeft de persoon een 'ouder' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "ouders": [
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
    | stap definitie met hetzelfde gedrag                          |
    | heeft de persoon een 'ouder' met de volgende gegevens        |
    | heeft de persoon een 'ouder' met alleen de volgende gegevens |

  Abstract Scenario: Dan heeft de persoon een 'ouder' met (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "ouders": [
            {
              "naam": {
                "geslachtsnaam" : "Aedel"
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
    | geslachtsnaam | Aedel  |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                 |
    | heeft de persoon een 'ouder' met de volgende 'naam' gegevens        |
    | heeft de persoon een 'ouder' met alleen de volgende 'naam' gegevens |

  Scenario: Dan heeft de persoon een 'ouder' zonder gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "ouders": [
            {}
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En heeft de persoon een 'ouder' zonder gegevens

  Scenario: Dan heeft de persoon een 'ouder' zonder '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "ouders": [
            {
              "naam": {}
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En heeft de persoon een 'ouder' zonder 'naam' gegevens

  Scenario: Dan heeft de 'ouder' geen '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "ouders": [
            {
              "burgerservicenummer": "000000012",
              "naam": {}
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En heeft de 'ouder' geen 'naam' gegevens

  Abstract Scenario: Dan heeft de 'ouder' (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "ouders": [
            {
              "burgerservicenummer": "000000012",
              "geboorte": {
                "datum": "2022-05-06"
              }
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En <stap definitie met hetzelfde gedrag>
    | naam  | waarde     |
    | datum | 2022-05-06 |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                     |
    | heeft de 'ouder' de volgende 'geboorte' gegevens        |
    | heeft de 'ouder' alleen de volgende 'geboorte' gegevens |
