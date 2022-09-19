# language: nl

@post-assert
Functionaliteit: Kinderen van een persoon raadplegen
  Van een persoon worden -indien gevraagd met de fields parameter- de kinderen geleverd.
  Dit bevat enkele identificerende eigenschappen van de kinderen.

  @gba
  Rule: de actuele gegevens van kinderen worden geleverd

    @gba
    Scenario: de naam van een kind is gecorrigeerd
      Gegeven de persoon met burgerservicenummer '999996150' heeft een 'kind' met de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | William           | de                  | Boer                  |
      En het 'kind' is gecorrigeerd naar de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | William           | de                  | Vries                 |
      En het 'kind' is gewijzigd naar de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) |
      | William           | Postma                |
      En de persoon heeft nog een 'kind' met de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | Sebastiaan        | de                  | Boer                  |
      En de persoon heeft nog een 'kind' met de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) |
      | Walter            | Messeritz             |
      En het 'kind' is gecorrigeerd naar de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
      | Walter            | de                  | Boer                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999996150                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens
      | naam          | waarde  |
      | voornamen     | William |
      | geslachtsnaam | Postma  |
      En heeft de persoon een 'kind' met de volgende 'naam' gegevens
      | naam          | waarde     |
      | voornamen     | Sebastiaan |
      | voorvoegsel   | de         |
      | geslachtsnaam | Boer       |
      En heeft de persoon een 'kind' met de volgende 'naam' gegevens
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
      | burgerservicenummer | 999996381                       |
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
    - Wanneer door de gebruikte fields parameter in het request het kind in de response geen enkel gegeven heeft met een waarde, dan wordt het kind geleverd zonder gegevens (dus als leeg object)

    @gba
    Abstract Scenario: kind volledig onbekend, veld met onbekend waarde wordt gevraagd met fields
      Gegeven de persoon met burgerservicenummer 999996150 heeft de volgende kinderen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Gemeente document (82.10) | Datum document (82.20) | Beschrijving document (82.30) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
      | 9         |                             |                   |                     | <geslachtsnaam>       | <geboortedatum>       | 1926                      | 20040105               | D27894-2004-A782              | 20031107                        | 20040112                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999996150                       |
      | fields              | kinderen.naam                   |
      Dan heeft de persoon met burgerservicenummer '999996150' een kind met de volgende 'naam' gegevens
      | naam          | waarde          |
      | geslachtsnaam | <geslachtsnaam> |

      Voorbeelden:
      | geslachtsnaam | geboortedatum |
      | .             |               |
      | .             | 00000000      |

      @gba
      Scenario: kind volledig onbekend, veld met onbekend waarde wordt niet gevraagd met fields
        Gegeven de persoon met burgerservicenummer 999996150 heeft de volgende kinderen in de registratie
        | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Gemeente document (82.10) | Datum document (82.20) | Beschrijving document (82.30) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
        | 9         |                             |                   |                     |                       | 00000000              | 1926                      | 20040105               | D27894-2004-A782              | 20031107                        | 20040112                   |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 999996150                       |
        | fields              | kinderen.naam                   |
        Dan heeft de persoon met burgerservicenummer '999996150' een kind zonder gegevens

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
      Gegeven de persoon met burgerservicenummer 999996150 heeft de volgende kinderen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen (02.10) | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Gemeente document (82.10) | Datum document (82.20) | Beschrijving document (82.30) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
      | 9         |                             | Bert              |                     | Jansen                | 20110422              | 1926                      | 20040105               | D27894-2004-A782              | 20031107                        | 20040112                   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999996150                       |
      | fields              | kinderen.burgerservicenummer    |
      Dan heeft de persoon met burgerservicenummer '999996150' een 'kind' zonder gegevens

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
  Rule: Wanneer een kind alleen "onbekend"-waardes heeft, wordt er een 'kind' zonder gegevens geleverd.
    - Wanneer geen van de met fields gevraagde kindgegevens een waarde heeft, maar andere gegevens van het kind wel wordt er ook een 'kind' zonder gegevens geleverd.

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
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 555550005                              |
      | fields              | kinderen.naam,kinderen.geboorte.plaats |
      Dan heeft de response een persoon met een leeg 'kind' object

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
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550006                       |
      | fields              | kinderen.naam.voornamen         |
      Dan heeft de response een persoon met een leeg 'kind' object
