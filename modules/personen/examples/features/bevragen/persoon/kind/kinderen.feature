# language: nl

Functionaliteit: Kinderen van een persoon raadplegen
  Van een persoon worden -indien gevraagd met de fields parameter- de kinderen geleverd.
  Dit bevat enkele identificerende eigenschappen van de kinderen.

  Regel: de actuele gegevens van kinderen worden geleverd

    Scenario: de naam van een kind is gecorrigeerd
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | William           | de                  | Boer                  |
      En het 'kind' is gecorrigeerd naar de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | William           | de                  | Vries                 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' met de volgende gegevens
      | naam               | waarde  |
      | naam.voornamen     | William |
      | naam.voorvoegsel   | de      |
      | naam.geslachtsnaam | Vries   |
      | naam.voorletters   | W.      |

    Scenario: naamswijziging kind
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | voornamen (02.10) |
      | Celeke Lodivica   |
      En het 'kind' is gewijzigd naar de volgende gegevens
      | voornamen (02.10) |
      | Vica              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | kinderen.naam.voornamen         |
      Dan heeft de response een persoon met een 'kind' met de volgende gegevens
      | naam           | waarde |
      | naam.voornamen | Vica   |

  Regel: Een kind wordt alleen teruggegeven als minimaal één gegeven in de identificatienummers (groep 01), naam (groep 02) of geboorte (groep 03) van het kind een waarde heeft.
    - Wanneer in een categorie kind alleen gegevens zijn opgenomen in groep 81 of 82, 85 en 86, wordt dit kind niet opgenomen in het antwoord
    - Wanneer een gegeven een standaardwaarde heeft (dit betekent dat de waarde onbekend is), zoals "." (punt) bij geslachtsnaam of "00000000" bij geboortedatum, geldt dat hier als het bestaan van een waarde en wordt het kind wel geleverd.
    - Wanneer door de gebruikte fields parameter in het request het kind in de response geen enkel gegeven heeft met een waarde, dan wordt het kind geleverd zonder gegevens (dus als leeg object)

    Scenario: bestaan kind bekend, veld met onbekend waarde wordt gevraagd met fields
      Gegeven de persoon met burgerservicenummer '000000036' heeft een 'kind' met de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) | 
      | .                     | 00000000              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000036                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens

    Scenario: bestaan kind bekend, veld met onbekend waarde wordt niet gevraagd met fields
      Gegeven de persoon met burgerservicenummer '000000048' heeft een 'kind' met de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) | 
      | .                     | 00000000              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | kinderen.burgerservicenummer    |
      Dan heeft de response een persoon met een 'kind' zonder gegevens

    Scenario: ontkenning ouderschap, herroeping van adoptie en nietig verklaren erkenning
      Gegeven de persoon met burgerservicenummer '000000061' heeft een 'kind' met de volgende gegevens
      | naam                            | waarde          |
      | voornamen (02.10)               | Daan            |
      | voorvoegsel (02.30)             | de              |
      | geslachtsnaam (02.40)           | Vries           |
      | geboortedatum (03.10)           | 20031107        | 
      | gemeente document (82.10)       | 0518            | 
      | datum document (82.20)          | 20031109        | 
      | beschrijving document (82.30)   | PL gerelateerde | 
      | ingangsdatum geldigheid (85.10) | 20031107        | 
      | datum van opneming (86.10)      | 20031109        |
      En het 'kind' is gecorrigeerd naar de volgende gegevens
      | naam                            | waarde           |
      | gemeente document (82.10)       | 0518             |
      | datum document (82.20)          | 20040105         | 
      | beschrijving document (82.30)   | D27894-2004-A782 | 
      | ingangsdatum geldigheid (85.10) | 20031107         | 
      | datum van opneming (86.10)      | 20040112         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | kinderen                        |
      Dan heeft de response een persoon zonder 'kind' gegevens

    Scenario: met fields vragen om een gegeven zonder waarde
      Gegeven de persoon met burgerservicenummer '000000073' heeft een 'kind' met de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) |
      | Bert              | Jansen                |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000073                       |
      | fields              | kinderen.burgerservicenummer    |
      Dan heeft de response een persoon met een 'kind' zonder gegevens

  Regel: de geleverde kindgegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
    Bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van het kind

    Scenario: Het kind heeft geslachtswijziging en naamswijziging ondergaan, maar de gevraagde persoon erkent dit niet
      Gegeven de persoon met burgerservicenummer '000000085' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 000000097                   | Karel             | M                           |
      En het 'kind' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 000000097                   | Charlotte         | V                           |
      En het 'kind' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 000000097                   | Karel             | M                           |
      En de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Karel             | M                           |
      En de persoon is gewijzigd naar de volgende gegevens
      | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | Charlotte         | V                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 000000085                                            |
      | fields              | kinderen.burgerservicenummer,kinderen.naam.voornamen |
      Dan heeft de response een persoon met een 'kind' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000097 |
      | naam.voornamen      | Karel     |

  Regel: Wanneer een kind alleen "onbekend"-waardes heeft, wordt er een 'kind' zonder gegevens geleverd.
    - Wanneer geen van de met fields gevraagde kindgegevens een waarde heeft, maar andere gegevens van het kind wel wordt er ook een 'kind' zonder gegevens geleverd.

    Scenario: Kind is volledig onbekend
      Gegeven de persoon met burgerservicenummer '000000176' heeft een 'kind' met de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) | geboorteplaats (03.20) | geboorteland (03.30) |
      | .                     | 00000000              | 0000                   | 0000                 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000176                              |
      | fields              | kinderen.naam,kinderen.geboorte.plaats |
      Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens
      En heeft het 'kind' geen 'geboorte' gegevens

    Scenario: Met fields zijn alleen velden zonder waarde gevraagd
      Gegeven de persoon met burgerservicenummer '000000176' heeft een 'kind' met de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) | 
      | Ali bin Mohammed      | 19750730              | 
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000176                       |
      | fields              | kinderen.naam.voornamen         |
      Dan heeft de response een persoon met een 'kind' zonder 'naam' gegevens
