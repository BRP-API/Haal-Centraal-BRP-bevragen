#language: nl

@stap-documentatie
Functionaliteit: Nationaliteit dan stap definities

  Abstract Scenario: Dan heeft de response een persoon met een 'nationaliteit' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "nationaliteiten": [
            {
              "aanduidingBijzonderNederlanderschap": "V"
            }
          ]
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam                                | waarde |
    | aanduidingBijzonderNederlanderschap | V      |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                                   |
    | heeft de response een persoon met een 'nationaliteit' met de volgende gegevens        |
    | heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens |

  Scenario: Dan heeft de response een persoon zonder nationaliteiten
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "nationaliteiten": []
        }
      ]
    }
    """
    Dan heeft de response een persoon zonder nationaliteiten

  Scenario: Dan heeft de persoon een 'nationaliteit' met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "nationaliteiten": [
            {
              "aanduidingBijzonderNederlanderschap": "V"
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
    | naam                                | waarde |
    | aanduidingBijzonderNederlanderschap | V      |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                  |
    | heeft de persoon een 'nationaliteit' met de volgende gegevens        |
    | heeft de persoon een 'nationaliteit' met alleen de volgende gegevens |

  Scenario: Dan heeft de persoon geen nationaliteiten
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "nationaliteiten": []
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |
    En heeft de persoon geen nationaliteiten
