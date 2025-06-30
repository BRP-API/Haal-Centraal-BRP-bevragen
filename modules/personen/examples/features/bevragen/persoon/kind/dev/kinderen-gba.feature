# language: nl

@gba
Functionaliteit: kinderen raadplegen
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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' met de volgende gegevens
      | naam               | waarde  |
      | naam.voornamen     | William |
      | naam.voorvoegsel   | de      |
      | naam.geslachtsnaam | Vries   |

    Scenario: naamswijziging kind
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | voornamen (02.10) |
      | Celeke Lodivica   |
      En het 'kind' is gewijzigd naar de volgende gegevens
      | voornamen (02.10) |
      | Vica              |
      Als gba personen wordt gezocht met de volgende parameters
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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000036                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | .      |
	  
    Scenario: bestaan kind bekend, veld met onbekend waarde wordt niet gevraagd met fields
      Gegeven de persoon met burgerservicenummer '000000048' heeft een 'kind' met de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) | 
      | .                     | 00000000              |
      Als gba personen wordt gezocht met de volgende parameters
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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | kinderen                        |
      Dan heeft de response een persoon zonder 'kind' gegevens

    Scenario: persoon heeft geen kind
      Gegeven de persoon met burgerservicenummer '000000061' heeft de volgende gegevens
      | naam                            | waarde          |
      | voornamen (02.10)               | Daan            |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | kinderen                        |
      Dan heeft de response een persoon zonder 'kind' gegevens

    Scenario: met fields vragen om een gegeven zonder waarde
      Gegeven de persoon met burgerservicenummer '000000073' heeft een 'kind' met de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) |
      | Bert              | Jansen                |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000073                       |
      | fields              | kinderen.burgerservicenummer    |
      Dan heeft de response een persoon met een 'kind' zonder gegevens

    Scenario: Geen kind, maar dat wordt wel onderzocht
      Gegeven de persoon met burgerservicenummer '000000061' heeft een 'kind' met de volgende gegevens
      | naam                            | waarde           |
      | gemeente document (82.10)       | 0518             |
      | datum document (82.20)          | 20040105         |
      | aanduiding in onderzoek (83.10) | 090000           |
      | datum ingang onderzoek (83.20)  | 20230114         |
      | beschrijving document (82.30)   | D27894-2004-A782 |
      | ingangsdatum geldigheid (85.10) | 20031107         |
      | datum van opneming (86.10)      | 20040112         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | kinderen                        |
      Dan heeft de response een persoon zonder 'kind' gegevens


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
#      De e2e automation code ondersteund nog niet het opvoeren van meer dan 1 PL record, de volgende Gegeven stappen zijn vooralsnog dan ook uitbecommentarieerd.
#      En de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
#      | voornamen (02.10) | geslachtsaanduiding (04.10) |
#      | Karel             | M                           |
#      En de persoon is gewijzigd naar de volgende gegevens
#      | voornamen (02.10) | geslachtsaanduiding (04.10) |
#      | Charlotte         | V                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 000000085                                            |
      | fields              | kinderen.burgerservicenummer,kinderen.naam.voornamen |
      Dan heeft de response een persoon met een 'kind' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000097 |
      | naam.voornamen      | Karel     |

  Regel: een levenloos geboren kind wordt niet geleverd.
    Dit is het geval wanneer Registratie betrekking (89.10) een waarde heeft.

    # Leveren van een levenloos geboren kind mag alleen wanneer de afnemer daarvoor geautoriseerd is (autorisatie rubriek 35.95.14).
    # Op dit moment heeft de API nog geen veld waarin kan worden aangegeven dat een kind levenloos geboren is.
    # Voorlopig zijn er geen afnemers voor de API die geautoriseerd zijn voor een levenloos kind.
    # Tot er een afnemer is met autorisatie voor 35.95.14, die autorisatie is gebouwd en er een indicatie levenloos geboren is toegevoegd, mag een levenloos geboren kind niet worden geleverd. 
    # Zie #855.
    
    Scenario: de persoon heeft een levenloos geboren kind en een levend kind
      Gegeven de persoon met burgerservicenummer '000000073' heeft een 'kind' met de volgende gegevens
      | voornamen (02.10) |
      | Bert              |
      En de persoon heeft nog een 'kind' met de volgende gegevens
      | voornamen (02.10) | registratie betrekking (89.10) |
      | Ernie             | L                              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000073                       |
      | fields              | kinderen.naam.voornamen         |
      Dan heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Bert   |
