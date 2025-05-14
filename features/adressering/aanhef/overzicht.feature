# language: nl

@info-api
Functionaliteit: leveren van de aanhef van een persoon
  Als consumer
  wil ik de aanhef (introducerende zin van een brief of e-mail) van een persoon kunnen vragen
  zodat ik de persoon op de juiste en consistente manier kan aanschrijven

  De volgende afkortingen worden gebruikt in deze specificatie:
  - GA = "Geachte mevrouw", "Geachte heer" of "Geachte VL" afhankelijk van het geslacht
  - VL = voorletters
  - VV = voorvoegsel.
  - GN = geslachtsnaam
  - VP = voorvoegsel partner
  - GP = geslachtsnaam partner

  Regel: de aanhef van een persoon zonder partner wordt als volgt samengesteld: GA VV GN. Wanneer een persoon geen voorvoegsel heeft, wordt de overbodige spatie niet opgenomen

    Abstract Scenario: persoon met voornamen, geslachtsnaam en geen voorvoegsel heeft geslacht <voorbeeld>
      Gegeven de persoon 'Jo'
      * heeft de volgende gegevens
        | naam                        | waarde     |
        | geslachtsaanduiding (04.10) | <geslacht> |
        | voornamen (02.10)           | Jo Rene    |
        | geslachtsnaam (02.40)       | Groenen    |
      Als 'adressering.aanhef' wordt gevraagd van personen gezocht met burgerservicenummer van 'Jo'
      Dan heeft 'Jo' de volgende 'adressering' gegevens
        | aanhef   |
        | <aanhef> |

      Voorbeelden:
        | voorbeeld | geslacht | aanhef                  |
        | man       | M        | Geachte heer Groenen    |
        | vrouw     | V        | Geachte mevrouw Groenen |
        | onbekend  | O        | Geachte J.R. Groenen    |

  Regel: het voorvoegsel begint met een hoofdletter behalve wanneer er één of meer voorletters aan voorafgaan (geslacht O)

    Abstract Scenario: persoon met voornamen, voorvoegsel en geslachtsnaam heeft geslacht <voorbeeld>
      Gegeven de persoon 'Robin'
      * heeft de volgende gegevens
        | naam                        | waarde      |
        | geslachtsaanduiding (04.10) | <geslacht>  |
        | voornamen (02.10)           | Robin Melle |
        | voorvoegsel (02.30)         | van         |
        | geslachtsnaam (02.40)       | Puffelen    |
      Als 'adressering.aanhef' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin'
      Dan heeft 'Robin' de volgende 'adressering' gegevens
        | aanhef   |
        | <aanhef> |

      Voorbeelden:
        | voorbeeld | geslacht | aanhef                       |
        | man       | M        | Geachte heer Van Puffelen    |
        | vrouw     | V        | Geachte mevrouw Van Puffelen |
        | onbekend  | O        | Geachte R.M. van Puffelen    |

  Regel: de aanhef van een persoon met een (ex-)partner wordt op basis van zijn aanduiding naamgebruik als volgt samengesteld
    | aanduiding naamgebruik | aanhef         |
    | E                      | GA VV GN       |
    | P                      | GA VP GP       |
    | V                      | GA VP GP-VV GN |
    | N                      | GA VV GN-VP GP |

    Abstract Scenario: persoon met partner heeft aanduiding naamgebruik '<naamgebruik>'
      Gegeven de persoon 'Joan'
      En heeft de volgende gegevens
        | naam                           | waarde          |
        | geslachtsaanduiding (04.10)    | V               |
        | voorvoegsel (02.30)            | <voorvoegsel>   |
        | geslachtsnaam (02.40)          | <geslachtsnaam> |
        | aanduiding naamgebruik (61.10) | <naamgebruik>   |
      En de persoon 'Jan' met burgerservicenummer '000000143'
      En heeft de volgende gegevens
        | naam                  | waarde                  |
        | voorvoegsel (02.30)   | <partner voorvoegsel>   |
        | geslachtsnaam (02.40) | <partner geslachtsnaam> |
      En 'Joan' en 'Jan' zijn met elkaar gehuwd
      Als 'adressering.aanhef' wordt gevraagd van personen gezocht met burgerservicenummer van 'Joan'
      Dan heeft 'Joan' de volgende 'adressering' gegevens
        | aanhef   |
        | <aanhef> |

      Voorbeelden:
        | naamgebruik | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | aanhef                                 |
        | E           | in het      | Veld          | van                 | Velzen                | Geachte mevrouw In het Veld            |
        | E           |             | Groenen       |                     | Groenink              | Geachte mevrouw Groenen                |
        | P           | in het      | Veld          | van                 | Velzen                | Geachte mevrouw Van Velzen             |
        | P           |             | Groenen       |                     | Groenink              | Geachte mevrouw Groenink               |
        | V           | in het      | Veld          | van                 | Velzen                | Geachte mevrouw Van Velzen-in het Veld |
        | V           |             | Groenen       |                     | Groenink              | Geachte mevrouw Groenink-Groenen       |
        | N           | in het      | Veld          | van                 | Velzen                | Geachte mevrouw In het Veld-van Velzen |
        | N           |             | Groenen       |                     | Groenink              | Geachte mevrouw Groenen-Groenink       |
