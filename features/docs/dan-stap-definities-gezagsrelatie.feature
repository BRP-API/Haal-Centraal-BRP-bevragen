#language: nl

@stap-documentatie
Functionaliteit: Gezagsrelatie dan stap definities

  Scenario: Dan heeft de response een persoon met een 'gezag' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "gezag": [
            {
              "type": "TweehoofdigOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000012"
              }
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
    | type                      | minderjarige.burgerservicenummer |
    | TweehoofdigOuderlijkGezag | 000000012                        |

  Scenario: Dan heeft de persoon een 'gezag' met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "gezag": [
            {
              "type": "TweehoofdigOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000012"
              }
            },
            {
              "type": "GezamenlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              }
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
    | type                      | minderjarige.burgerservicenummer |
    | TweehoofdigOuderlijkGezag | 000000012                        |
    En heeft de persoon een 'gezag' met de volgende gegevens
    | type             | minderjarige.burgerservicenummer |
    | GezamenlijkGezag | 000000013                        |

  Scenario: Dan heeft (het) 'gezag' (nog) een 'ouder' met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "gezag": [
            {
              "type": "TweehoofdigOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000012"
              },
              "ouders": [
                {
                  "burgerservicenummer": "000000024"
                },
                {
                  "burgerservicenummer": "000000048"
                }
              ]
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
    | type                      | minderjarige.burgerservicenummer |
    | TweehoofdigOuderlijkGezag | 000000012                        |
    En heeft 'gezag' een 'ouder' met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft het 'gezag' nog een 'ouder' met de volgende gegevens
    | burgerservicenummer |
    | 000000048           |

  Scenario: Dan heeft (het) 'gezag' een 'derde' met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "gezag": [
            {
              "type": "Voogdij",
              "minderjarige": {
                "burgerservicenummer": "000000012"
              },
              "derden": [
                {
                  "burgerservicenummer": "000000024"
                },
                {
                  "burgerservicenummer": "000000048"
                }
              ]
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
    | type    | minderjarige.burgerservicenummer |
    | Voogdij | 000000012                        |
    En heeft 'gezag' een 'derde' met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft 'gezag' een 'derde' met de volgende gegevens
    | burgerservicenummer |
    | 000000048           |

  Scenario: Dan heeft de response een persoon zonder 'gezag' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "gezag": []
        }
      ]
    }
    """
    Dan heeft de response een persoon zonder gezag

  Scenario: Dan heeft de persoon geen gezag
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000061",
          "gezag": []
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | burgerservicenummer|
    | 000000061 |
    En heeft de persoon geen gezag

  Scenario: Dan heeft (het) 'gezag' geen derden
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "gezag": [
            {
              "type": "Voogdij",
              "minderjarige": {
                "burgerservicenummer": "000000012"
              },
              "derden": []
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
    | type    | minderjarige.burgerservicenummer |
    | Voogdij | 000000012                        |
    En heeft het 'gezag' geen derden
