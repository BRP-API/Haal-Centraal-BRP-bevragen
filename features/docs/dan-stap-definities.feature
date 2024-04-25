#language: nl

Functionaliteit: Dan stap definities

  Regel: En heeft het object de volgende '<gegevensgroep>' gegevens

    @fout-case
    Scenario: En heeft het object de volgende 'invalidParams' gegevens
      Gegeven de response body is gelijk aan
      """
      {
        "status": 400,
        "invalidParams": [
          {
            "code": "required"
          }
        ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde                   |
      | content-type | application/problem+json |
      En de response status is gelijk aan 400
      Dan heeft de response een object met de volgende gegevens
      | naam   | waarde |
      | status | 400    |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     |
      | required |

  Regel: Dan heeft de response een leeg persoon object
        Dan heeft de response een persoon zonder gegevens  

    Abstract Scenario: Dan <stap definitie met hetzelfde gedrag>
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
          }
        ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag           |
      | heeft de response een leeg persoon object     |
      | heeft de response een persoon zonder gegevens |

  Regel: Dan heeft de response (nog) een persoon met (alleen) de volgende gegevens

    Abstract Scenario: Dan <stap definitie met hetzelfde gedrag>
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan <stap definitie met hetzelfde gedrag>
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                               |
      | heeft de response een persoon met de volgende gegevens            |
      | heeft de response een persoon met alleen de volgende gegevens     |
      | heeft de response nog een persoon met de volgende gegevens        |
      | heeft de response nog een persoon met alleen de volgende gegevens |

  Regel: Dan heeft de response een persoon met (alleen) de volgende '<gegevensgroep>' gegevens

    Abstract Scenario: Dan <stap definitie met hetzelfde gedrag>
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan <stap definitie met hetzelfde gedrag>
      | naam          | waarde |
      | geslachtsnaam | Jansen |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                  |
      | heeft de response een persoon met de volgende 'naam' gegevens        |
      | heeft de response een persoon met alleen de volgende 'naam' gegevens |

  Regel: Dan heeft de response een persoon met een '<collectie gegevensgroep>' met (alleen) de volgende gegevens

    Abstract Scenario: Dan <stap definitie met hetzelfde gedrag>
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan <stap definitie met hetzelfde gedrag>
      | naam                | waarde    |
      | burgerservicenummer | 000000013 |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                          |
      | heeft de response een persoon met een 'kind' met de volgende gegevens        |
      | heeft de response een persoon met een 'kind' met alleen de volgende gegevens |

  Regel: Dan heeft de response een persoon met een '<collectie gegevensgroep>' met (alleen) de volgende '<gegevensgroep>' gegevens

    Abstract Scenario: Dan <stap definitie met hetzelfde gedrag>
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan <stap definitie met hetzelfde gedrag>
      | naam          | waarde    |
      | geslachtsnaam | Pietersen |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                                 |
      | heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens        |
      | heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens |

  Regel: Dan heeft de response een persoon zonder '<collectie gegevensgroep>' gegevens

    Scenario: Dan heeft de response een persoon zonder 'kind' gegevens
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon zonder 'kind' gegevens

  Regel: Dan heeft de response een persoon zonder '<gegevensgroep>' gegevens
        Dan heeft de response een persoon met een leeg '<gegevensgroep>' object

    Abstract Scenario: Dan <stap definitie met hetzelfde gedrag>
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
            "verblijfplaats": {}
          }
        ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                |
      | heeft de response een persoon zonder 'verblijfplaats' gegevens     |
      | heeft de response een persoon met een leeg 'verblijfplaats' object |

  Regel: Dan heeft de response een persoon met een '<collectie gegevensgroep>' zonder gegevens
        Dan heeft de response een persoon met een leeg '<collectie gegevensgroep' object

    Abstract Scenario: Dan <stap definitie met hetzelfde gedrag>
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
            "kinderen": [
              {
              }
            ]
          }
        ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                          |
      | heeft de response een persoon met een 'kind' zonder gegevens |
      | heeft de response een persoon met een leeg 'kind' object     |

  Regel: Dan heeft de response een persoon met een '<collectie gegevensgroep>' met een leeg '<gegevensgroep>' object
        Dan heeft de response een persoon met een '<collectie gegevensgroep>' zonder '<gegevensgroep>' gegevens

    Abstract Scenario: Dan <stap definitie met hetzelfde gedrag>
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                     |
      | heeft de response een persoon met een 'kind' met een leeg 'naam' object |
      | heeft de response een persoon met een 'kind' zonder 'naam' gegevens     |

  Regel: En heeft de persoon (alleen) de volgende '<gegevensgroep>' gegevens

    Abstract Scenario: En <stap definitie met hetzelfde gedrag>
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
            "naam": {
              "geslachtsnaam": "Jansen"
            },
            "geboorte": {
              "datum": "2022-05-06"
            }
          }
        ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | Jansen |
      En <stap definitie met hetzelfde gedrag>
      | naam  | waarde     |
      | datum | 2022-05-06 |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                     |
      | heeft de persoon de volgende 'geboorte' gegevens        |
      | heeft de persoon alleen de volgende 'geboorte' gegevens |

  Regel: En heeft de persoon een '<collectie gegevensgroep>' met (alleen) de volgende '<gegevensgroep>' gegevens

    Abstract Scenario: En <stap definitie met hetzelfde gedrag>
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
            "burgerservicenummer": "000000012",
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En <stap definitie met hetzelfde gedrag>
      | naam          | waarde |
      | geslachtsnaam | Aedel  |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                 |
      | heeft de persoon een 'ouder' met de volgende 'naam' gegevens        |
      | heeft de persoon een 'ouder' met alleen de volgende 'naam' gegevens |

  Regel: En heeft de persoon een '<collectie gegevensgroep>' met (alleen) de volgende gegevens

    Abstract Scenario: En <stap definitie met hetzelfde gedrag>
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
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

  Regel: En heeft (de|het) '<collectie gegevensgroep>' (alleen) de volgende '<gegevensgroep>' gegevens

    Abstract Scenario: En <stap definitie met hetzelfde gedrag>
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
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

  Regel: En heeft de persoon een leeg '<gegevensgroep>' object

    Scenario: En heeft de persoon een leeg 'naam' object
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
            "naam": {},
            "geboorte": {
              "datum": "2022-05-06"
            }
          }
        ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
      | naam  | waarde     |
      | datum | 2022-05-06 |
      En heeft de persoon een leeg 'naam' object

  Regel: En heeft de persoon geen '<collectie gegevensgroep>' gegevens

    Scenario: En heeft de persoon geen 'kind' gegevens
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En heeft de persoon geen 'kind' gegevens

  Regel: En heeft de persoon geen '<gegevensgroep>' gegevens

    Scenario: En heeft de persoon geen 'verblijfplaats' gegevens
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [
          {
            "burgerservicenummer": "000000012",
            "verblijfplaats": {}
          }
        ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En heeft de persoon geen 'verblijfplaats' gegevens

  Regel: En heeft de persoon een '<collectie gegevensgroep>' zonder gegevens 

    Scenario: En heeft de persoon een 'ouder' zonder gegevens
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En heeft de persoon een 'ouder' zonder gegevens

  Regel: En heeft de persoon een '<collectie gegevensgroep>' zonder '<gegevensgroep>' gegevens

    Scenario: En heeft de persoon een 'ouder' zonder 'naam' gegevens
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En heeft de persoon een 'ouder' zonder 'naam' gegevens

  Regel: En heeft (de|het) '<collectie gegevensgroep>' een leeg '<gegevensgroep>' object
        En heeft (de|het) '<collectie gegevensgroep>' geen '<gegevensgroep>' gegevens

    Abstract Scenario: En <stap definitie met hetzelfde gedrag>
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag       |
      | heeft de 'partner' een leeg 'naam' object |
      | heeft de 'partner' geen 'naam' gegevens   |

  Regel: Dan heeft de response <aantal> perso(o)n(en)

    Scenario: Dan heeft de response 0 personen
      Gegeven de response body is gelijk aan
      """
      {
        "personen": []
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response 0 personen

    Scenario: Dan heeft de response 1 persoon
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [ {} ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response 1 persoon

    Scenario: Dan heeft de response 1 persoon en persoon heeft geen gegevens
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [ {} ]
      }
      """
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response 1 persoon
      En heeft de response een persoon zonder gegevens

    Scenario: Dan heeft de response meerdere personen
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
      En de response headers is gelijk aan
      | naam         | waarde           |
      | content-type | application/json |
      En de response status is gelijk aan 200
      Dan heeft de response 2 personen
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En heeft de response nog een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000013 |

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
    En de response headers is gelijk aan
    | naam         | waarde           |
    | content-type | application/json |
    En de response status is gelijk aan 200
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
    En de response headers is gelijk aan
    | naam         | waarde           |
    | content-type | application/json |
    En de response status is gelijk aan 200
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
    En de response headers is gelijk aan
    | naam         | waarde           |
    | content-type | application/json |
    En de response status is gelijk aan 200
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
    En de response headers is gelijk aan
    | naam         | waarde           |
    | content-type | application/json |
    En de response status is gelijk aan 200
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
    En de response headers is gelijk aan
    | naam         | waarde           |
    | content-type | application/json |
    En de response status is gelijk aan 200
    Dan heeft de response een persoon zonder gezag

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
    En de response headers is gelijk aan
    | naam         | waarde           |
    | content-type | application/json |
    En de response status is gelijk aan 200
    Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
    | type    | minderjarige.burgerservicenummer |
    | Voogdij | 000000012                        |
    En heeft het 'gezag' geen derden
