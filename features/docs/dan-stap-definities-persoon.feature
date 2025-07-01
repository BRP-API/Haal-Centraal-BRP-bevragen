# language: nl
@stap-documentatie
Functionaliteit: Persoon dan stap definities

  Abstract Scenario: Dan heeft de response [0/geen] personen
    Gegeven de response body is gelijk aan
    """
    {
      "personen": []
    }
    """
    Dan heeft de response <aantal> personen

    Voorbeelden:
    | aantal |
    | geen   |
    | 0      |

  Scenario: Dan heeft de response 1 persoon
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [ {} ]
    }
    """
    Dan heeft de response 1 persoon

  Scenario: Dan heeft de response 2 personen
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [ {}, {} ]
    }
    """
    Dan heeft de response 2 personen

  Abstract Scenario: Dan heeft de response (nog) een persoon met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012"
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                               |
    | heeft de response een persoon met de volgende gegevens            |
    | heeft de response een persoon met alleen de volgende gegevens     |
    | heeft de response nog een persoon met de volgende gegevens        |
    | heeft de response nog een persoon met alleen de volgende gegevens |

  Abstract Scenario: Dan wordt '[aanduiding]' gevonden
    Gegeven de persoon 'P1' met burgerservicenummer '000000012'
    En de response body is gelijk aan
      """
      {
        "personen": [
          {
            "burgerservicenummer": "000000012"
          }
        ]
      }
      """
    Dan <stap definitie met hetzelfde gedrag>

    Voorbeelden:
      | stap definitie met hetzelfde gedrag |
      | wordt 'P1' gevonden                 |
      | wordt alleen 'P1' gevonden          |

  Scenario: Dan heeft de response een persoon met de volgende gegevens (meerdere personen)
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012"
        },
        {
          "burgerservicenummer": "000000013"
        }
      ]
    }
    """
    Dan heeft de response 2 personen
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En heeft de response nog een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000013 |

  Abstract Scenario: Dan wordt '[aanduiding] en [aanduiding]' gevonden
    Gegeven de persoon 'P1' met burgerservicenummer '000000012'
    En de persoon 'P2' met burgerservicenummer '000000013'
    En de response body is gelijk aan
      """
      {
        "personen": [
          {
            "burgerservicenummer": "000000012"
          },
          {
            "burgerservicenummer": "000000013"
          }
        ]
      }
      """
    Dan <stap definitie met hetzelfde gedrag>

    Voorbeelden:
      | stap definitie met hetzelfde gedrag |
      | worden 'P1, P2' gevonden            |
      | worden 'P1 en P2' gevonden          |
      | worden alleen 'P1 en P2' gevonden   |

  Scenario: Dan wordt '[aanduiding], [aanduiding] en [aanduiding]' gevonden
    Gegeven de persoon 'P1' met burgerservicenummer '000000012'
    En de persoon 'P2' met burgerservicenummer '000000013'
    En de persoon 'P3' met burgerservicenummer '000000014'
    En de response body is gelijk aan
      """
      {
        "personen": [
          {
            "burgerservicenummer": "000000012"
          },
          {
            "burgerservicenummer": "000000013"
          },
          {
            "burgerservicenummer": "000000014"
          }
        ]
      }
      """
    Dan <stap definitie met hetzelfde gedrag>

    Voorbeelden:
      | stap definitie met hetzelfde gedrag   |
      | worden 'P1, P2, P3' gevonden          |
      | worden 'P1, P2 en P3' gevonden        |
      | worden alleen 'P1, P2 en P3' gevonden |

  Abstract Scenario: Dan heeft de response een persoon met (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "naam": {
            "geslachtsnaam": "Jansen"
          }
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam          | waarde |
    | geslachtsnaam | Jansen |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                  |
    | heeft de response een persoon met de volgende 'naam' gegevens        |
    | heeft de response een persoon met alleen de volgende 'naam' gegevens |

  Scenario: Dan heeft de response een persoon zonder gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {}
      ]
    }
    """
    Dan heeft de response een persoon zonder gegevens

  Scenario: Dan heeft de response een persoon zonder '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "naam": {}
        }
      ]
    }
    """
    Dan heeft de response een persoon zonder 'naam' gegevens

  Abstract Scenario: Dan heeft de persoon (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "geboorte": {
            "datum": "2022-05-06"
          }
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    En <stap definitie met hetzelfde gedrag>
    | naam  | waarde     |
    | datum | 2022-05-06 |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                     |
    | heeft de persoon de volgende 'geboorte' gegevens        |
    | heeft de persoon alleen de volgende 'geboorte' gegevens |

  Scenario: Dan heeft de persoon geen '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "naam": {
            "geslachtsnaam": "Jansen"
          },
          "geboorte": {}
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde |
    | geslachtsnaam | Jansen |
    En heeft de persoon geen 'geboorte' gegevens

  Scenario: Dan heeft '[persoon aanduiding]' '[gegevensgroep collectie]' met de volgende gegevens
    Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
            "<gegevensgroep collectie>": [
              {
                "naam": {
                  "geslachtsnaam": "Jansen"
                }
              },
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
    Dan heeft 'Jan' '<gegevensgroep collectie>' met de volgende gegevens
      | naam.geslachtsnaam |
      | Jansen             |
      | Pietersen          |

    Voorbeelden:
      | gegevensgroep collectie |
      | kinderen                |
      | ouders                  |
      | partners                |