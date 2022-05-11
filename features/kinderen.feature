# language: nl

@post-assert
Functionaliteit: Kinderen van een persoon raadplegen
  Van een persoon worden -indien gevraagd met de fields parameter- de kinderen geleverd.
  Dit bevat enkele identificerende eigenschappen van de kinderen.

  @gba
  Rule: de actuele gegevens van kinderen worden geleverd

    @gba
    Scenario: de naam van een kind is gecorrigeerd
      Gegeven de persoon met burgerservicenummer 999996150 heeft de volgende kinderen in de registratie
      | Categorie | Voornamen (02.10) | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Onjuist (84.10) |
      | 9         | William           |                     | Postma                |                 |
      | 59        | William           | de                  | Vries                 |                 |
      | 59        | William           | de                  | Boer                  | O               |
      | 9         | Sebastiaan        | de                  | Boer                  |                 |
      | 9         | Walter            | de                  | Boer                  |                 |
      | 59        | Walter            |                     | Messeritz             | O               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999996150                       |
      | fields              | kinderen.naam                   |
      Dan heeft de persoon met burgerservicenummer '999996150' een kind met de volgende 'naam' gegevens
      | naam          | waarde  |
      | voornamen     | William |
      | geslachtsnaam | Postma  |
      En heeft de persoon met burgerservicenummer '999996150' een kind met de volgende 'naam' gegevens
      | naam          | waarde     |
      | voornamen     | Sebastiaan |
      | voorvoegsel   | de         |
      | geslachtsnaam | Boer       |
      En heeft de persoon met burgerservicenummer '999996150' een kind met de volgende 'naam' gegevens
      | naam          | waarde |
      | voornamen     | Walter |
      | voorvoegsel   | de     |
      | geslachtsnaam | Boer   |

    @gba
    Scenario: naamswijziging kind
      Gegeven de persoon met burgerservicenummer 999996381 heeft de volgende kinderen in de registratie
      | Categorie | Voornamen (02.10) |
      | 9         | Vica              |
      | 59        | Celeke Lodivica   |
      | 9         | Bella             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999996150                       |
      | fields              | kinderen.naam.voornamen         |
      Dan heeft de persoon met burgerservicenummer '999996381' een kind met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Vica   |
      En heeft de persoon met burgerservicenummer '999996381' een kind met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Bella  |
      En heeft de persoon met burgerservicenummer '999996381' GEEN kind met de volgende 'naam' gegevens
      | naam      | waarde          |
      | voornamen | Celeke Lodivica |

  @gba
  Rule: Een kind wordt alleen teruggegeven als minimaal één gegeven in de identificatienummers (groep 01), naam (groep 02) of geboorte (groep 03) van het kind een waarde heeft.
    - Wanneer in een categorie kind alleen gegevens zijn opgenomen in groep 81 of 82, 85 en 86, wordt dit kind niet opgenomen in het antwoord
    - Wanneer een gegeven een standaardwaarde heeft, zoals "." (punt) bij geslachtsnaam of "00000000" bij geboortedatum, geldt dat hier als het bestaan van een waarde en wordt het kind wel geleverd
    - Wanneer door de gebruikte fields parameter in het request het kind in de response geen enkel gegeven heeft met een waarde, dan wordt het kind niet geleverd

    @gba
    Abstract Scenario: kind volledig onbekend
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende kinderen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Gemeente document (82.10) | Datum document (82.20) | Beschrijving document (82.30) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
      | 9         |                             |                   |                     | <geslachtsnaam>       | <geboortedatum>       | 1926                      | 20040105               | D27894-2004-A782              | 20031107                        | 20040112                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999996150                       |
      | fields              | kinderen.naam                   |
      Dan heeft de persoon met burgerservicenummer '555550001' een kind met de volgende 'naam' gegevens
      | naam          | waarde          |
      | geslachtsnaam | <geslachtsnaam> |

      Voorbeelden:
      | geslachtsnaam | geboortedatum |
      | .             |               |
      |               | 00000000      |
      | .             | 00000000      |

    @gba
    Scenario: ontkenning ouderschap
      Gegeven de persoon met burgerservicenummer 555550002 heeft de volgende kinderen in de registratie
      | Categorie | Voornamen (02.10) | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Gemeente document (82.10) | Datum document (82.20) | Beschrijving document (82.30) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
      | 9         |                   |                     |                       |                       | 1926                      | 20040105               | D27894-2004-A782              | 20031107                        | 20040112                   |
      | 59        | Daan              | de                  | Vries                 | 20031107              | 0518                      | 20031109               | PL gerelateerde               | 20031107                        | 20031109                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550002                       |
      | fields              | kinderen                        |
      Dan bevat het antwoord GEEN kinderen

    @gba
    Scenario: met fields vragen om een gegeven zonder waarde
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende kinderen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Gemeente document (82.10) | Datum document (82.20) | Beschrijving document (82.30) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
      | 9         |                             | Bert              |                     | Jansen                | 20110422              | 1926                      | 20040105               | D27894-2004-A782              | 20031107                        | 20040112                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999996150                       |
      | fields              | kinderen.burgerservicenummer    |
      Dan heeft de persoon met burgerservicenummer '555550001' GEEN kinderen

  @gba
  Rule: de geleverde kindgegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
    Bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van het kind

    @gba
    Scenario: Het kind heeft geslachtswijziging en naamswijziging ondergaan, maar de gevraagde persoon erkent dit niet
      Gegeven de persoon met burgerservicenummer 555550003 heeft de volgende kinderen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) |
      | 9         | 555550004                   | Karel             |
      | 59        | 555550004                   | Charlotte         |
      | 59        | 555550004                   | Karel             |
      En het kind met burgerservicenummer 555550004 heeft haar geslacht en voornamen gewijzigd zodat de volgende persoonsgegevens in de registratie op haar persoonslijst staan:
      | Categorie | Voornamen | Geslachtsaanduiding (04.10) |
      | 1         | Charlotte | V                           |
      | 51        | Karel     | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 555550003                                            |
      | fields              | kinderen.burgerservicenummer,kinderen.naam.voornamen |
      Dan heeft het kind met burgerservicenummer '555550004' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |

  @proxy
  Rule: Wanneer de geslachtsnaam van het kind onbekend is, wordt het geleverd met type "OnbekendKind".
    - Dit is het geval wanneer geslachtsnaam dan de standaardwaarde "." heeft
    - Wanneer geen van de met fields gevraagde kindgegevens een waarde heeft, maar andere gegevens van het kind wel, dan is het type "Kind".

    # Onderliggende aanname is dat wanneer de geslachtsnaam van het kind onbekend is, ook andere kindgegevens niet bekend zijn of niet relevant.

    @proxy
    Scenario: Kind is volledig onbekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En de persoon heeft een 'kind' met alleen de volgende gegevens
      | naam                | waarde |
      | burgerservicenummer |        |
      | geslacht            |        |
      En het 'kind' heeft alleen de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | .      |
      En het 'kind' heeft alleen de volgende 'geboorte' gegevens
      | naam        | waarde   |
      | datum       | 00000000 |
      | plaats.code | 0000     |
      | land.code   | 0000     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550005                       |
      | fields              | burgerservicenummer,kinderen    |
      Dan heeft de persoon met burgerservicenummer '555550005' een 'kind' met alleen de volgende gegevens
      | naam              | waarde       |
      | type              | OnbekendKind   |


    @proxy
    Scenario: Met fields zijn alleen velden zonder waarde gevraagd
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550006 |
      En de persoon heeft een 'kind' met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550007 |
      En het 'kind' heeft alleen de volgende 'naam' gegevens
      | naam          | waarde           |
      | voornamen     |                  |
      | geslachtsnaam | Ali bin Mohammed |
      En het 'kind' heeft alleen de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 19750730 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                      |
      | type                | RaadpleegMetBurgerservicenummer             |
      | burgerservicenummer | 555550006                                   |
      | fields              | burgerservicenummer,kinderen.naam.voornamen |
      Dan heeft de persoon met burgerservicenummer '555550006' een 'kind' met alleen de volgende gegevens
      | naam | waarde |
      | type | Kind   |
