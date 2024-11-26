#language: nl

@stap-documentatie
Functionaliteit: Partner dan stap definities

  Abstract Scenario: Dan heeft de response een persoon met een 'partner' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "partners": [
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
    | stap definitie met hetzelfde gedrag                                             |
    | heeft de response een persoon met een 'partner' met de volgende gegevens        |
    | heeft de response een persoon met een 'partner' met alleen de volgende gegevens |


  Abstract Scenario: Dan heeft de response een persoon met een 'partner' met (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "partners": [
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
    | stap definitie met hetzelfde gedrag                                                    |
    | heeft de response een persoon met een 'partner' met de volgende 'naam' gegevens        |
    | heeft de response een persoon met een 'partner' met alleen de volgende 'naam' gegevens |


  Scenario: Dan heeft de response een persoon met een 'partner' zonder gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "partners": [
            {}
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'partner' zonder gegevens

  Scenario: Dan heeft de response een persoon met een 'partner' zonder '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "partners": [
            {
              "naam": {}
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'partner' zonder 'naam' gegevens

  Scenario: Dan heeft de response een persoon zonder partners
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "partners": []
        }
      ]
    }
    """
    Dan heeft de response een persoon zonder partners

  Abstract Scenario: Dan heeft de persoon een 'partner' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "partners": [
            {
              "burgerservicenummer": "000000013"
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En <stap definitie met hetzelfde gedrag>
    | naam                | waarde    |
    | burgerservicenummer | 000000013 |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                            |
    | heeft de persoon een 'partner' met de volgende gegevens        |
    | heeft de persoon een 'partner' met alleen de volgende gegevens |

  Abstract Scenario: Dan heeft de persoon een 'partner' met (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "partners": [
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
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En <stap definitie met hetzelfde gedrag>
    | naam          | waarde |
    | geslachtsnaam | Aedel  |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                   |
    | heeft de persoon een 'partner' met de volgende 'naam' gegevens        |
    | heeft de persoon een 'partner' met alleen de volgende 'naam' gegevens |

  Scenario: Dan heeft de persoon geen partners
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "partners": []
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En heeft de persoon geen partners

  Scenario: Dan heeft de 'partner' de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "partners": [
            {
              "burgerservicenummer": "000000013",
              "naam": {
                "voornamen": "Karel"
              }
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'partner' met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000013 |
    En heeft de 'partner' de volgende 'naam' gegevens
    | voornamen |
    | Karel     |

  Scenario: Dan heeft de 'partner' geen '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "partners": [
            {
              "burgerservicenummer": "000000012",
              "naam": {}
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'partner' met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En heeft de 'partner' geen 'naam' gegevens
