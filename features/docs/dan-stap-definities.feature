#language: nl

Functionaliteit: Dan stap definities

  Rule: Dan heeft de response een object met de volgende gegevens

    Scenario: Dan heeft de response een object met de volgende gegevens
      Gegeven de response body is gelijk aan
      """
      {
        "titel": "dit is de titel"
      }
      """
      Dan heeft de response een object met de volgende gegevens
      | naam  | waarde          |
      | titel | dit is de titel |

  Rule: En heeft het object de volgende '<gegevensgroep>' gegevens

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
      Dan heeft de response een object met de volgende gegevens
      | naam   | waarde |
      | status | 400    |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     |
      | required |

  Rule: Dan heeft de response een leeg persoon object
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
      Dan <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag           |
      | heeft de response een leeg persoon object     |
      | heeft de response een persoon zonder gegevens |

  Rule: Dan heeft de response (nog) een persoon met (alleen) de volgende gegevens

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
      Dan <stap definitie met hetzelfde gedrag>
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                               |
      | heeft de response een persoon met de volgende gegevens            |
      | heeft de response een persoon met alleen de volgende gegevens     |
      | heeft de response nog een persoon met de volgende gegevens        |
      | heeft de response nog een persoon met alleen de volgende gegevens |

  Rule: Dan heeft de response een persoon met (alleen) de volgende '<gegevensgroep>' gegevens

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
      Dan <stap definitie met hetzelfde gedrag>
      | naam          | waarde |
      | geslachtsnaam | Jansen |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                  |
      | heeft de response een persoon met de volgende 'naam' gegevens        |
      | heeft de response een persoon met alleen de volgende 'naam' gegevens |

  Rule: Dan heeft de response een persoon met een '<collectie gegevensgroep>' met (alleen) de volgende gegevens

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
      Dan <stap definitie met hetzelfde gedrag>
      | naam                | waarde    |
      | burgerservicenummer | 000000013 |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                          |
      | heeft de response een persoon met een 'kind' met de volgende gegevens        |
      | heeft de response een persoon met een 'kind' met alleen de volgende gegevens |

  Rule: Dan heeft de response een persoon met een '<collectie gegevensgroep>' met (alleen) de volgende '<gegevensgroep>' gegevens

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
      Dan <stap definitie met hetzelfde gedrag>
      | naam          | waarde    |
      | geslachtsnaam | Pietersen |

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                                 |
      | heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens        |
      | heeft de response een persoon met een 'kind' met alleen de volgende 'naam' gegevens |

  Rule: Dan heeft de response een persoon met een '<collectie gegevensgroep>' zonder gegevens
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
      Dan <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                          |
      | heeft de response een persoon met een 'kind' zonder gegevens |
      | heeft de response een persoon met een leeg 'kind' object     |

  Rule: Dan heeft de response een persoon met een '<collectie gegevensgroep>' met een leeg '<gegevensgroep>' object
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
      Dan <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag                                     |
      | heeft de response een persoon met een 'kind' met een leeg 'naam' object |
      | heeft de response een persoon met een 'kind' zonder 'naam' gegevens     |

  Rule: En heeft de persoon (alleen) de volgende '<gegevensgroep>' gegevens

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

  Rule: En heeft de persoon een '<collectie gegevensgroep>' met (alleen) de volgende '<gegevensgroep>' gegevens

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

  Rule: En heeft de persoon een '<collectie gegevensgroep>' met (alleen) de volgende gegevens

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

  Rule: En heeft (de|het) '<collectie gegevensgroep>' (alleen) de volgende '<gegevensgroep>' gegevens

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

  Rule: En heeft de persoon een leeg '<gegevensgroep>' object

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
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
      | naam  | waarde     |
      | datum | 2022-05-06 |
      En heeft de persoon een leeg 'naam' object

  Rule: En heeft de persoon een '<collectie gegevensgroep>' zonder gegevens 

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
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En heeft de persoon een 'ouder' zonder gegevens

  Rule: En heeft de persoon een '<collectie gegevensgroep>' zonder '<gegevensgroep>' gegevens

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
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En heeft de persoon een 'ouder' zonder 'naam' gegevens

  Rule: En heeft (de|het) '<collectie gegevensgroep>' een leeg '<gegevensgroep>' object
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
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En <stap definitie met hetzelfde gedrag>

      Voorbeelden:
      | stap definitie met hetzelfde gedrag       |
      | heeft de 'partner' een leeg 'naam' object |
      | heeft de 'partner' geen 'naam' gegevens   |

  Rule: Dan heeft de response <aantal> perso(o)n(en)

    Scenario: Dan heeft de response 0 personen
      Gegeven de response body is gelijk aan
      """
      {
        "personen": []
      }
      """
      Dan heeft de response 0 personen

    Scenario: Dan heeft de response 1 persoon
      Gegeven de response body is gelijk aan
      """
      {
        "personen": [ {} ]
      }
      """
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
      Dan heeft de response 2 personen
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000012 |
      En heeft de response nog een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000013 |