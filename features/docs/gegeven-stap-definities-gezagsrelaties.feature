# language: nl
@stap-documentatie @data-api @info-api 
Functionaliteit: Gegeven gezagsrelatie stap definities

  Achtergrond:
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      |                   000000013 | Pietersen             |              20000201 |
    Gegeven de persoon 'P3' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000014 | Maassen               |

  Regel: de gezag api mock moet altijd gezag voor de data api leveren ongeacht of een scenario in info-api of data-api context wordt uitgevoerd.

  @deprecated
  Scenario: de persoon heeft een eenhoofdig ouderlijk gezagsrelatie
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * eenhoofdig ouderlijk gezag over 'P2' met ouder 'P1'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "EenhoofdigOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "ouder": {
                "burgerservicenummer": "000000012"
              }
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: de persoon heeft een eenhoofdig ouderlijk gezagsrelatie
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * eenhoofdig ouderlijk gezag over 'P2' met ouder 'P1'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "EenhoofdigOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "ouder": {
                "burgerservicenummer": "000000012",
                "naam": {
                  "geslachtsnaam": "Jansen"
                }
              }
            }
          ]
        }
      ]
      """

  @deprecated
  Scenario: de persoon heeft een gezamenlijk ouderlijk gezagsrelatie
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * gezamenlijk ouderlijk gezag over 'P2' met ouder 'P1' en ouder 'P3'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "TweehoofdigOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "ouders": [
                {
                  "burgerservicenummer": "000000012"
                },
                {
                  "burgerservicenummer": "000000014"
                }
              ]
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: de persoon heeft een gezamenlijk ouderlijk gezagsrelatie
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * gezamenlijk ouderlijk gezag over 'P2' met ouder 'P1' en ouder 'P3'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "GezamenlijkOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "ouders": [
                {
                  "burgerservicenummer": "000000012",
                  "naam": {
                    "geslachtsnaam": "Jansen"
                  }
                },
                {
                  "burgerservicenummer": "000000014",
                  "naam": {
                    "geslachtsnaam": "Maassen"
                  }
                }
              ]
            }
          ]
        }
      ]
      """

  @deprecated
  Scenario: de persoon heeft een gezamenlijk gezagsrelatie
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * gezamenlijk gezag over 'P2' met ouder 'P1' en derde 'P3'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "GezamenlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "ouder": {
                "burgerservicenummer": "000000012"
              },
              "derde": {
                "type": "BekendeDerde",
                "burgerservicenummer": "000000014"
              }
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: de persoon heeft een gezamenlijk gezagsrelatie
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * gezamenlijk gezag over 'P2' met ouder 'P1' en derde 'P3'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "GezamenlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "ouder": {
                "burgerservicenummer": "000000012",
                "naam": {
                  "geslachtsnaam": "Jansen"
                }
              },
              "derde": {
                "type": "BekendeDerde",
                "burgerservicenummer": "000000014",
                "naam": {
                  "geslachtsnaam": "Maassen"
                }
              }
            }
          ]
        }
      ]
      """

  @deprecated
  Scenario: de persoon heeft een gezamenlijk gezagsrelatie met een onbekende derde
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * gezamenlijk gezag over 'P2' met ouder 'P1' en een onbekende derde
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "GezamenlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "ouder": {
                "burgerservicenummer": "000000012"
              },
              "derde": {
                "type": "OnbekendeDerde"
              }
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: de persoon heeft een gezamenlijk gezagsrelatie met een onbekende derde
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * gezamenlijk gezag over 'P2' met ouder 'P1' en een onbekende derde
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "GezamenlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "ouder": {
                "burgerservicenummer": "000000012",
                "naam": {
                  "geslachtsnaam": "Jansen"
                }
              },
              "derde": {
                "type": "OnbekendeDerde"
              }
            }
          ]
        }
      ]
      """

  @deprecated
  Scenario: de persoon heeft een voogdij gezagsrelatie
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * voogdij over 'P2'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "Voogdij",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "derden": []
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: de persoon heeft een voogdij gezagsrelatie
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * voogdij over 'P2'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "Voogdij",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "derden": []
            }
          ]
        }
      ]
      """

  @deprecated
  Scenario: de persoon heeft een voogdij gezagsrelatie met een bekende derde
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * voogdij over 'P2' met derde 'P1'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "Voogdij",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "derden": [
                {
                  "type": "BekendeDerde",
                  "burgerservicenummer": "000000012"
                }
              ]
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: de persoon heeft een voogdij gezagsrelatie met bekende derde
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * voogdij over 'P2' met derde 'P1'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "Voogdij",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "derden": [
                {
                  "type": "BekendeDerde",
                  "burgerservicenummer": "000000012",
                  "naam": {
                    "geslachtsnaam": "Jansen"
                  }
                }
              ]
            }
          ]
        }
      ]
      """

  @deprecated
  Scenario: de persoon heeft tijdelijk geen gezag
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * tijdelijk geen gezag over 'P2' met de toelichting 'tijdelijk geen gezag'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "TijdelijkGeenGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "toelichting": "tijdelijk geen gezag"
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: de persoon heeft tijdelijk geen gezag
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * tijdelijk geen gezag over 'P2' met de toelichting 'tijdelijk geen gezag'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "TijdelijkGeenGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "toelichting": "tijdelijk geen gezag"
            }
          ]
        }
      ]
      """

  @deprecated
  Scenario: gezag over de persoon is niet te bepalen
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * gezag over 'P2' is niet te bepalen met de toelichting 'gezag is niet te bepalen'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "GezagNietTeBepalen",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "toelichting": "gezag is niet te bepalen"
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: gezag over de persoon is niet te bepalen
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * gezag over 'P2' is niet te bepalen met de toelichting 'gezag is niet te bepalen'
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "GezagNietTeBepalen",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "toelichting": "gezag is niet te bepalen"
            }
          ]
        }
      ]
      """

  Scenario: de persoon heeft geen gezaghouder
    Gegeven 'P1' heeft geen gezaghouder
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": []
        }
      ]
      """

  @deprecated
  Scenario: gezag over de persoon is in onderzoek
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * eenhoofdig ouderlijk gezag over 'P2' met ouder 'P1'
    * het gezag is in onderzoek
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "EenhoofdigOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013"
              },
              "ouder": {
                "burgerservicenummer": "000000012"
              },
              "inOnderzoek": true
            }
          ]
        }
      ]
      """

  @nieuw
  Scenario: gezag over de persoon is in onderzoek
    Gegeven 'P1' heeft de volgende gezagsrelaties
    * eenhoofdig ouderlijk gezag over 'P2' met ouder 'P1'
    * het gezag is in onderzoek
    Dan is de gezag response body gelijk aan
      """
      [
        {
          "burgerservicenummer": "000000012",
          "gezag": [
            {
              "type": "EenhoofdigOuderlijkGezag",
              "minderjarige": {
                "burgerservicenummer": "000000013",
                "geboorte": {
                  "datum": "20000201"
                },
                "naam": {
                  "geslachtsnaam": "Pietersen"
                }
              },
              "ouder": {
                "burgerservicenummer": "000000012",
                "naam": {
                  "geslachtsnaam": "Jansen"
                }
              },
              "inOnderzoek": true
            }
          ]
        }
      ]
      """

