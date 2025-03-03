#language: nl

@stap-documentatie
Functionaliteit: volgorde validatie

  Als team lid
  wil ik kunnen aangeven dat een response body volgens de gespecificeerde volgorde moet worden gevalideerd

Regel: De response wordt volgens de opgegeven volgorde gevalideerd wanneer de '@valideer-volgorde' tag is toegevoegd aan een scenario/feature

  @valideer-volgorde
  Scenario: de '@valideer-volgorde' tag is opgegeven
    Gegeven de response body is gelijk aan
    """
    {
      "verblijfplaatsen": [
        {
          "adresseerbaarObjectIdentificatie": "0800010000000001"
        },
        {
          "adresseerbaarObjectIdentificatie": "0800010000000002"
        }
      ]
    }
    """
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie |
    | 0800010000000001                 |
    | 0800010000000002                 |

  Abstract Scenario: de '@valideer-volgorde' tag is niet opgegeven
    Gegeven de response body is gelijk aan
    """
    {
      "verblijfplaatsen": [
        {
          "adresseerbaarObjectIdentificatie": "0800010000000001"
        },
        {
          "adresseerbaarObjectIdentificatie": "0800010000000002"
        }
      ]
    }
    """
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie |
    | <ado id 1>                       |
    | <ado id 2>                       |

    Voorbeelden:
    | ado id 1         | ado id 2         |
    | 0800010000000001 | 0800010000000002 |
    | 0800010000000002 | 0800010000000001 |

  @valideer-volgorde
  Scenario: de '@valideer-volgorde' tag is opgegeven
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [
        {
          "adresseerbaarObjectIdentificatie": "0800010000000001",
          "bewoners": [
            {
              "burgerservicenummer": "000000024"
            },
            {
              "burgerservicenummer": "000000012"
            }
          ],
          "mogelijkeBewoners": []
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | adresseerbaarObjectIdentificatie |
    | 0800010000000001                 |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000012           |

  Abstract Scenario: de '@valideer-volgorde' tag is opgegeven
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [
        {
          "adresseerbaarObjectIdentificatie": "0800010000000001",
          "bewoners": [
            {
              "burgerservicenummer": "000000024"
            },
            {
              "burgerservicenummer": "000000012"
            }
          ],
          "mogelijkeBewoners": []
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | adresseerbaarObjectIdentificatie |
    | 0800010000000001                 |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer     |
    | <burgerservicenummer 1> |
    | <burgerservicenummer 2> |

    Voorbeelden:
    | burgerservicenummer 1 | burgerservicenummer 2 |
    | 000000024             | 000000012             |
    | 000000012             | 000000024             |