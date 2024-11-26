#language: nl

Functionaliteit: volgorde validatie

  Als team lid
  wil ik kunnen aangeven dat een response body volgens de gespecificeerde volgorde moet worden gevalideerd

  Achtergrond:
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

Regel: De response wordt volgens de opgegeven volgorde gevalideerd wanneer de '@valideer-volgorde' tag is toegevoegd aan een scenario/feature

  @valideer-volgorde
  Scenario: de '@valideer-volgorde' tag is opgegeven
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie |
    | 0800010000000001                 |
    | 0800010000000002                 |

  Abstract Scenario: de '@valideer-volgorde' tag is niet opgegeven
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie |
    | <ado id 1>                       |
    | <ado id 2>                       |

    Voorbeelden:
    | ado id 1         | ado id 2         |
    | 0800010000000001 | 0800010000000002 |
    | 0800010000000002 | 0800010000000001 |
