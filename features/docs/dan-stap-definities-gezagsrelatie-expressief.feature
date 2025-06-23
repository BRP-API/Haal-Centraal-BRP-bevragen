# language: nl
@stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties
  Deze feature beschrijft de Dan stappen voor verschillende gezagsuitspraken.

  Achtergrond:
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    En de persoon 'Aart' met burgerservicenummer '000000024'
    En de persoon 'Bert' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      |                   000000036 | Jansen                | gisteren - 2 jaar     | M                           |
    En de persoon 'Jeanette' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | Jeanette          | Sanders               | V                           |

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
                    "geslacht": {
                      "code": "M"
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
                    "geslacht": {
                      "code": "M"
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
                    "geslacht": {
                      "code": "M"
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
                      },
                      "geslacht": {
                        "code": "V"
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
                    "geslacht": {
                      "code": "M"
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
                      },
                      "geslacht": {
                        "code": "V"
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

    @info-api
    Scenario: gezag niet te bepalen wordt verwacht met dubbele punt in toelichting
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
                      "toelichting": "dit is de reden dat het gezag niet te bepalen is. Het gaat om de volgende gegevens: geboortedatum"
                    }
                  ]
                }
              ]
            }
        """
      Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'dit is de reden dat het gezag niet te bepalen is. Het gaat om de volgende gegevens: geboortedatum'

  Regel: Dan heeft '{aanduidingMinderjarige}' geen gezaghouder

    @info-api @data-api
    Scenario: gevraagde persoon heeft geen gezagsrelaties
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
      Dan heeft 'Bert' geen gezaghouder

    @gezag-api
    Scenario: gevraagde persoon heeft geen gezagsrelaties
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "000000036",
              "gezag": []
            }
          ]
        }
        """
      Dan heeft 'Bert' geen gezaghouder

  Regel: Dan heeft '{aanduidingMeerderjarige}' geen gezag

    @info-api @data-api
    Scenario: gevraagde persoon heeft geen gezagsrelaties
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
      Dan heeft 'Bert' geen gezag

    @gezag-api
    Scenario: gevraagde persoon heeft geen gezagsrelaties
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "000000036",
              "gezag": []
            }
          ]
        }
        """
      Dan heeft 'Bert' geen gezag

  Regel: Dan heeft '{aanduidingMeerderjarige}' de volgende gezagsrelaties En het gezag over '{aanduidingMinderjarige}' is ...
    Dat kan de minderjarige zijn, maar ook een ouder of derde.

    @deprecated @gezag-api
    Scenario: het gezag van de <omschrijving> met gezamenlijk ouderlijk gezag wordt gevraagd
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "<burgerservicenummer>",
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
      Dan heeft '<naam>' de volgende gezagsrelaties
      * het gezag over 'Bert' is gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

      Voorbeelden:
        | naam  | burgerservicenummer | omschrijving |
        | Gerda |           000000012 | ouder 1      |
        | Aart  |           000000024 | ouder 2      |
        | Bert  |           000000036 | minderjarige |

    @deprecated @gezag-api
    Scenario: het gezag van de <omschrijving> met gezamenlijk gezag wordt gevraagd
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "<burgerservicenummer>",
              "gezag": [
                {
                  "type": "GezamenlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000036"
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012"
                  },
                  "derde": {
                    "type": "BekendeDerde",
                    "burgerservicenummer": "000000024"
                  }
                }
              ]
            }
          ]
        }
        """
      Dan heeft '<naam>' de volgende gezagsrelaties
      * het gezag over 'Bert' is gezamenlijk gezag met ouder 'Gerda' en derde 'Aart'

      Voorbeelden:
        | naam  | burgerservicenummer | omschrijving |
        | Gerda |           000000012 | ouder        |
        | Aart  |           000000024 | derde        |
        | Bert  |           000000036 | minderjarige |

    @deprecated @gezag-api
    Abstract Scenario: meerdere gezagsrelaties van één persoon
      Gegeven de persoon 'Ernie' met burgerservicenummer '000000048'
      En de persoon 'Ieniemienie' met burgerservicenummer '000000061'
      En de persoon 'Pino' met burgerservicenummer '000000073'
      En de persoon 'Tommy' met burgerservicenummer '000000085'
      En de persoon 'Kermit' met burgerservicenummer '000000097'
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "<burgerservicenummer>",
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
                },
                {
                  "type": "EenhoofdigOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000048"
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012"
                  }
                },
                {
                  "type": "GezamenlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000061"
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012"
                  },
                  "derde": {
                    "type": "BekendeDerde",
                    "burgerservicenummer": "000000024"
                  }
                },
                {
                  "type": "GezamenlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000073"
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012"
                  },
                  "derde": {
                    "type": "OnbekendeDerde"
                  }
                },
                {
                  "type": "Voogdij",
                  "minderjarige": {
                    "burgerservicenummer": "000000085"
                  },
                  "derden": []
                },
                {
                  "type": "Voogdij",
                  "minderjarige": {
                    "burgerservicenummer": "000000097"
                  },
                  "derden": [
                    {
                      "type": "BekendeDerde",
                      "burgerservicenummer": "000000024"
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
      Dan heeft '<naam>' de volgende gezagsrelaties
      * het gezag over 'Bert' is gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
      * het gezag over 'Ernie' is eenhoofdig ouderlijk gezag met ouder 'Gerda'
      * het gezag over 'Ieniemienie' is gezamenlijk gezag met ouder 'Gerda' en derde 'Aart'
      * het gezag over 'Pino' is gezamenlijk gezag met ouder 'Gerda' en een onbekende derde
      * het gezag over 'Tommy' is voogdij
      * het gezag over 'Kermit' is voogdij met derde 'Aart'

      Voorbeelden:
        | naam  | burgerservicenummer |
        | Gerda |           000000012 |
        | Aart  |           000000024 |

    @info-api
    Abstract Scenario: meerdere gezagsrelaties van één persoon
      Gegeven de persoon 'Ernie' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |                   000000048 | Ernie                 | gisteren - 3 jaar     |
      En de persoon 'Ieniemienie' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |                   000000061 | Ieniemienie           | gisteren - 4 jaar     |
      En de persoon 'Pino' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |                   000000073 | Pino                  | gisteren - 5 jaar     |
      En de persoon 'Tommy' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |                   000000085 | Tommy                 | gisteren - 6 jaar     |
      En de persoon 'Kermit' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |                   000000097 | Kermit                | gisteren - 7 jaar     |
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
                },
                {
                  "type": "EenhoofdigOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000048",
                    "naam": {
                      "volledigeNaam": "Ernie"
                    },
                    "leeftijd": 3
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012",
                    "naam": {
                      "volledigeNaam": "Gerda"
                    }
                  }
                },
                {
                  "type": "GezamenlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000061",
                    "naam": {
                      "volledigeNaam": "Ieniemienie"
                    },
                    "leeftijd": 4
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
                },
                {
                  "type": "GezamenlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000073",
                    "naam": {
                      "volledigeNaam": "Pino"
                    },
                    "leeftijd": 5
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
                },
                {
                  "type": "Voogdij",
                  "minderjarige": {
                    "burgerservicenummer": "000000085",
                    "naam": {
                      "volledigeNaam": "Tommy"
                    },
                    "leeftijd": 6
                  },
                  "derden": []
                },
                {
                  "type": "Voogdij",
                  "minderjarige": {
                    "burgerservicenummer": "000000097",
                    "naam": {
                      "volledigeNaam": "Kermit"
                    },
                    "leeftijd": 7
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
      Dan heeft '<naam>' de volgende gezagsrelaties
      * het gezag over 'Bert' is gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
      * het gezag over 'Ernie' is eenhoofdig ouderlijk gezag met ouder 'Gerda'
      * het gezag over 'Ieniemienie' is gezamenlijk gezag met ouder 'Gerda' en derde 'Aart'
      * het gezag over 'Pino' is gezamenlijk gezag met ouder 'Gerda' en een onbekende derde
      * het gezag over 'Tommy' is voogdij
      * het gezag over 'Kermit' is voogdij met derde 'Aart'

      Voorbeelden:
        | naam  | burgerservicenummer |
        | Gerda |           000000012 |
        | Aart  |           000000024 |

  Regel: Dan is het gezag in onderzoek

    @info-api
    Scenario: inOnderzoek wordt verwacht
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
                  ],
                  "inOnderzoek": true
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
      En is het gezag in onderzoek

    @data-api
    Scenario: inOnderzoek wordt verwacht
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
                    "geslacht": {
                      "code": "M"
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
                  ],
                  "inOnderzoek": true
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
      En is het gezag in onderzoek

    @gezag-api @nieuw
    Scenario: inOnderzoek wordt verwacht
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
                    "geslacht": {
                      "code": "M"
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
                  ],
                  "inOnderzoek": true
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
      En is het gezag in onderzoek

    @deprecated @gezag-api
    Scenario: inOnderzoek wordt verwacht
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
                  ],
                  "inOnderzoek": true
                }
              ]
            }
          ]
        }
        """
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
      En is het gezag in onderzoek

    @deprecated @gezag-api
    Scenario: vragen gezag meerderjarige en één van de gezagsrelaties verwacht inOnderzoek
      Gegeven de persoon 'Ernie' met burgerservicenummer '000000048'
      Gegeven de response body is gelijk aan
        """
        {
          "personen": [
            {
              "burgerservicenummer": "000000048",
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
                  ],
                  "inOnderzoek": true
                },
                {
                  "type": "EenhoofdigOuderlijkGezag",
                  "minderjarige": {
                    "burgerservicenummer": "000000048"
                  },
                  "ouder": {
                    "burgerservicenummer": "000000012"
                  }
                }
              ]
            }
          ]
        }
        """
      Dan heeft 'Ernie' de volgende gezagsrelaties
      * het gezag over 'Bert' is gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
      En is het gezag in onderzoek
      * het gezag over 'Ernie' is eenhoofdig ouderlijk gezag met ouder 'Gerda'
