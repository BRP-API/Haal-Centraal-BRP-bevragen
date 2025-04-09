# language: nl
@stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties
  Deze feature beschrijft de Dan stappen voor verschillende gezagsuitspraken.

  Achtergrond:
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    En de persoon 'Aart' met burgerservicenummer '000000024'
    En de persoon 'Bert' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      |                   000000036 | Jansen                | gisteren - 2 jaar     |
    En de persoon 'Jeanette' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) |
      | Jeanette          | Sanders               |

  Regel: Dan is het gezag over '{aanduiding minderjarige}' gezamenlijk ouderlijk gezag met ouder '{aanduiding ouder}' en ouder '{aanduiding ouder}'
    De volgorde waarin ouders genoemd worden is willekeurig en niet relevant

    @info-api
    Scenario: gezamenlijk gezag van twee ouders wordt verwacht
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "GezamenlijkOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "ouders": [
                    {
                      "burgerservicenummer": "000000012",
                      "naam": {
                        "volledigeNaam": "Gerda"
                      }
                    },
                    {
                      "burgerservicenummer": "000000024",
                      "naam": {
                        "volledigeNaam": "Aart"
                      }
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    @data-api
    Scenario: gezamenlijk gezag van twee ouders wordt verwacht
      Gegeven de persoon 'Bert' heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              20221201 |
      En de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "GezamenlijkOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "geslachtsnaam": "Jansen"
                    },
                    "geboorte": {
                      "datum": "20221201"
                    }
                  },
                  "ouders": [
                    {
                      "burgerservicenummer": "000000012",
                      "naam": {
                        "geslachtsnaam": "Gerda"
                      }
                    },
                    {
                      "burgerservicenummer": "000000024",
                      "naam": {
                        "geslachtsnaam": "Aart"
                      }
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    @gezag-api @nieuw
    Scenario: gezamenlijk gezag van twee ouders wordt verwacht
      Gegeven de persoon 'Bert' heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              20221201 |
      En de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "000000036",
              "gezag": [
                {
                  "type": "GezamenlijkOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "geslachtsnaam": "Jansen"
                    },
                    "geboorte": {
                      "datum": "20221201"
                    }
                  },
                  "ouders": [
                    {
                      "burgerservicenummer": "000000012",
                      "naam": {
                        "geslachtsnaam": "Gerda"
                      }
                    },
                    {
                      "burgerservicenummer": "000000024",
                      "naam": {
                        "geslachtsnaam": "Aart"
                      }
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    @deprecated @gezag-api
    Scenario: tweehoofdig ouderlijk gezag van twee ouders wordt verwacht
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "000000036",
              "gezag": [
                {
                  "type": "TweehoofdigOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036"
                  },
                  "ouders": [
                    {
                      "burgerservicenummer": "000000012"
                    },
                    {
                      "burgerservicenummer": "000000024"
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    @info-api
    Scenario: gezamenlijk gezag van twee ouders wordt verwacht en opgegeven ouders in andere volgorde dan geleverde ouders
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "GezamenlijkOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "ouders": [
                    {
                      "burgerservicenummer": "000000024",
                      "naam": {
                        "volledigeNaam": "Aart"
                      }
                    },
                    {
                      "burgerservicenummer": "000000012",
                      "naam": {
                        "volledigeNaam": "Gerda"
                      }
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    @data-api
    Scenario: ouder zonder bsn
      Gegeven de persoon 'Bert' heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              20221201 |
      En de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "GezamenlijkOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "geslachtsnaam": "Jansen"
                    },
                    "geboorte": {
                      "datum": "20221201"
                    }
                  },
                  "ouders": [
                    {
                      "burgerservicenummer": "000000024",
                      "naam": {
                        "geslachtsnaam": "Aart"
                      }
                    },
                    {
                      "naam": {
                        "voornamen": "Jeanette",
                        "geslachtsnaam": "Sanders"
                      }
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Jeanette' en ouder 'Aart'

    @gezag-api @nieuw
    Scenario: ouder zonder bsn
      Gegeven de persoon 'Bert' heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              20221201 |
      En de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "000000036",
              "gezag": [
                {
                  "type": "GezamenlijkOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "geslachtsnaam": "Jansen"
                    },
                    "geboorte": {
                      "datum": "20221201"
                    }
                  },
                  "ouders": [
                    {
                      "burgerservicenummer": "000000024",
                      "naam": {
                        "geslachtsnaam": "Aart"
                      }
                    },
                    {
                      "naam": {
                        "voornamen": "Jeanette",
                        "geslachtsnaam": "Sanders"
                      }
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Jeanette' en ouder 'Aart'

  Regel: Dan is het gezag over '{aanduiding minderjarige}' eenhoofdig ouderlijk gezag met ouder '{aanduiding ouder}'

    @info-api
    Scenario: eenhoofdig ouderlijk gezag wordt verwacht
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "EenhoofdigOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012",
                    "naam": {
                      "volledigeNaam": "Gerda"
                    }
                  }
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

  Regel: Dan is het gezag over '{aanduiding minderjarige}' gezamenlijk gezag met ouder '{aanduiding ouder}' en derde '{aanduiding derde}'

    @info-api
    Scenario: gezamenlijk gezag wordt verwacht met een ouder en een derde
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "GezamenlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012",
                    "naam": {
                      "volledigeNaam": "Gerda"
                    }
                  },
                  "derde": {
                    "type": "BekendeDerde",
                    "burgerservicenummer": "000000024",
                    "naam": {
                      "volledigeNaam": "Aart"
                    }
                  }
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en derde 'Aart'

  Regel: Dan is het gezag over '{aanduiding minderjarige}' gezamenlijk gezag met ouder '{aanduiding ouder}' en een onbekende derde

    @info-api
    Scenario: gezamenlijk gezag wordt verwacht met een ouder en een onbekende derde
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "GezamenlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012",
                    "naam": {
                      "volledigeNaam": "Gerda"
                    }
                  },
                  "derde": {
                    "type": "OnbekendeDerde"
                  }
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en een onbekende derde

  Regel: Dan is het gezag over '{aanduiding minderjarige}' voogdij

    @info-api
    Scenario: voogdij wordt verwacht
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "Voogdij",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "derden": []
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' voogdij

  Regel: Dan is het gezag over '{aanduiding minderjarige}' voogdij met derde '{aanduiding derde}'

    @info-api
    Scenario: voogdij met een bekende derde wordt verwacht
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "Voogdij",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "derden": [
                    {
                      "type": "BekendeDerde",
                      "burgerservicenummer": "000000024",
                      "naam": {
                        "volledigeNaam": "Aart"
                      }
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' voogdij met derde 'Aart'

  Regel: Dan is het gezag over '{aanduiding minderjarige}' tijdelijk geen gezag met de toelichting '{toelichting}'

    @info-api
    Scenario: tijdelijk geen gezag wordt verwacht
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "TijdelijkGeenGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "toelichting": "dit is de reden dat er tijdelijk geen gezag is."
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' tijdelijk geen gezag met de toelichting 'dit is de reden dat er tijdelijk geen gezag is.'

  Regel: Dan is het gezag over '{aanduiding minderjarige}' niet te bepalen met de toelichting '{toelichting}'

    @info-api
    Scenario: gezag niet te bepalen wordt verwacht
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "gezag": [
                {
                  "type": "GezagNietTeBepalen",
                  "minderjarige": {
                    "burgerservicenummer": "000000036",
                    "naam": {
                      "volledigeNaam": "Jansen"
                    },
                    "leeftijd": 2
                  },
                  "toelichting": "dit is de reden dat het gezag niet te bepalen is."
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'dit is de reden dat het gezag niet te bepalen is.'
