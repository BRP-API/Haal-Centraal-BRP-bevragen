#language: nl

@post-assert
Functionaliteit: Fields
  Als consumer van de BRP API
  Wil ik kunnen aangeven welke gegevens van de gevonden personen ik terug wil krijgen
  Zodat ik alleen de gegevens terug krijg waarvoor ik doelbinding heb

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | anummer (01.10) | geslachtsaanduiding (04.10) | voornamen (02.10) | geslachtsnaam (02.40) | aanduiding naamgebruik (61.10) |
    | 5875306514      | V                           | Yvonne Johanna    | Kierkegaard           | V                              |
    En de persoon heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
    | 999992971                   | Robert            | Bronwaßer             | M                           |

      En de persoon heeft de volgende 'kiesrecht' gegevens
      | naam                              | waarde |
      | uitgesloten van kiesrecht (38.10) | true   |
      En het systeem heeft personen met de volgende gegevens
      | burgerservicenummer | indicatie geheim (70.10) |
      | 999992351           | 0                        |
      | 999992806           | 0                        |
      | 999994220           | 0                        |
      | 999994608           | 7                        |
      | 999995492           | 6                        |
      | 999995480           | 5                        |
      | 555550001           | 4                        |
      | 999993872           | 3                        |
      | 999992715           | 2                        |
      | 999991802           | 1                        |
      | 999993653           | 0                        |
      | 000009921           | 0                        |
      | 999995121           | 0                        |
      | 999993586           | 0                        |
      En het systeem heeft personen met de volgende 'geboorte' gegevens
      | burgerservicenummer | geboortedatum (03.10) | geboorteplaats (03.20) | plaats.omschrijving |
      | 999991929           | 19561115              | 0518                   | 's-Gravenhage       |
      | 999992351           | 19780300              |                        |                     |
      | 999992806           | 19680000              |                        |                     |
      | 999994220           | 00000000              |                        |                     |
      En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
      | burgerservicenummer | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) | locatiebeschrijving (12.10) | land adres buitenland (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) |
      | 999993653           | Boterdiep          | 31                 | 3077AW           |                             |                               |                                  |                                  |
      | 000009921           |                    |                    |                  | Woonboot in de Grote Sloot  |                               |                                  |                                  |
      | 999995121           |                    |                    |                  |                             | 5002                          | 14 Rue Camulogene                | 75015 Parijs                     |
      | 999993586           |                    |                    |                  |                             |                               |                                  |                                  |

  Rule: De API levert alleen velden die gevraagd zijn met de fields parameter
    - gebruik van de fields parameter is verplicht
    - een veld wordt gevraagd door het pad van het veld op te nemen in fields
    - vraag meerdere velden door de veld paden op te nemen in fields
    - veld paden zijn case sensitive
    - een veld in een groep of collectie kan worden gevraagd door het pad met punt gescheiden op te geven
    - alle velden van een groep kunnen worden gevraagd door het pad van de groep in fields op te nemen
    - de volgorde van veld paden in fields heeft geen invloed op de volgorde van velden in de response
    - wanneer een gevraagd veld geen waarde heeft voor de persoon, wordt het veld niet opgenomen in de response

    Abstract Scenario: Gevraagd veld heeft geen waarde voor de persoon
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999991929                       |
      | fields              | burgerservicenummer,<veld>      |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999991929 |

      Voorbeelden:
      | veld                          | opmerking                                                       |
      | inOnderzoek.geslacht          |                                                                 |
      | geheimhoudingPersoonsgegevens | geheimhoudingPersoonsgegevens wordt niet opgenomen bij waarde 0 |

  Rule: optioneel mag je (het begin van) het pad weglaten wanneer dit uniek verwijst naar 1 veld in de resource
    - wanneer het opgegeven pad exact verwijst naar een veld en tegelijkertijd als deel van een pad verwijst naar een ander veld, wordt alleen het veld met het exacte pad opgenomen in de response
    - wanneer het opgegeven pad niet exact verwijst naar een veld en tegelijkertijd als deel van een pad verwijst naar meerdere ander velden, wordt een foutmelding gegeven
    - wanneer het opgegeven pad verwijst naar een veld en tegelijkertijd naar het gelijknamige veld in inOnderzoek, worden beide velden opgenomen in de response wanneer ze een waarde hebben

    # zie fields-Persoon.csv (raadpleeg op burgerservicenummer) en fields-PersoonBeperkt.csv (zoeken) voor een overzicht van het fields pad voor elk van de personen velden:
    # de eerste kolom, "fields pad", geeft de waarde voor het unieke pad dat gebruikt kan worden in de fields parameter
    # de tweede kolom, "volledig pad" is het volledig pad naar het veld in de resource dat daarmee gevraagd wordt

    # in fields-Persoon.csv en fields-PersoonBeperkt.csv zijn niet alle mogelijke manieren om een veld te vragen opgenomen, alleen per veld het kortste unieke pad
    # ook zijn in fields-Persoon.csv en fields-PersoonBeperkt.csv geen velden opgenomen die automatisch worden meegeleverd, zie daarvoor rules hieronder

    # zie fields-mapping-Persoon.csv (raadpleeg op burgerservicenummer) en fields-mapping-PersoonBeperkt.csv (zoeken) voor een overzicht van alle mogelijke gehele of gedeeltelijke paden voor het aanwijzen van de personen velden:
    # een fields veld(pad) in de eerste kolom, "fields pad", wordt vertaald naar het volledige pad in de tweede kolom, "volledig pad"
    # wanneer een in fields opgegeven veld(pad) niet voorkomt in de linker kolom, geeft dat een foutmelding

  Rule: Wanneer velden van polymorfe gegevensgroep wordt gevraagd, wordt altijd het 'type' veld van de gegevensgroep terug gegeven
    - wanneer het gegeven geen waarde heeft (ook niet onbekend) wordt de gegevensgroep niet geleverd en dus ook 'type' niet teruggegeven

    Abstract Scenario: Gevraagd veld zit in een polymorfe gegevensgroep
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | <burgerservicenummer>               |
      | fields              | verblijfplaats.verblijfadres.regel3 |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam | waarde |
      | type | <type> |

      Voorbeelden:
      | burgerservicenummer | type                     |
      | 999993653           | Adres                    |
      | 000009921           | Locatie                  |
      | 999995121           | VerblijfplaatsBuitenland |
      | 999993586           | VerblijfplaatsOnbekend   |

  Rule: Wanneer een persoon geheimhouding heeft, wordt dit bij elke vraag terug gegeven
    - wanneer geheimhoudingPersoonsgegevens de waarde true heeft (indicatie geheim 07.70.10 heeft een waarde groter dan 0), wordt deze geleverd ook wanneer daar niet om gevraagd is
    - wanneer geheimhoudingPersoonsgegevens de waarde false heeft (indicatie geheim 07.70.10 heeft een waarde gelijk aan 0), wordt deze niet geleverd, ook niet wanneer er specifiek om gevraagd is

    Abstract Scenario: Persoon heeft <titel>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                          | waarde                |
      | burgerservicenummer           | <burgerservicenummer> |
      | geheimhoudingPersoonsgegevens | <geheimhouding>       |

      Voorbeelden:
      | burgerservicenummer | titel              | geheimhouding |
      | 999994608           | wel geheimhouding  | true          |
      | 999995492           | wel geheimhouding  | true          |
      | 999995480           | wel geheimhouding  | true          |
      | 555550001           | wel geheimhouding  | true          |
      | 999993872           | wel geheimhouding  | true          |
      | 999992715           | wel geheimhouding  | true          |
      | 999991802           | wel geheimhouding  | true          |
      | 999991929           | geen geheimhouding |               |

  Rule: Wanneer de bijhouding van een persoon is opgeschort en de reden hiervan is bekend, dan wordt dit bij elke vraag terug gegeven
    - wanneer er een reden opschorting bijhouding is, wordt deze reden geleverd, ook wanneer hier niet om gevraagd is
    - de datum opschorting bijhouding wordt alleen geleverd wanneer daarom gevraagd is met fields

    Scenario: persoon heeft opschorting bijhouding
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992077 |
      En de persoon heeft de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |
      | datum              | 20151001   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992077                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992077 |
      En heeft de persoon alleen de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |

  Rule: Wanneer een specifiek veld van een datum wordt gevraagd, dan worden velden die bij dat datumtype required zijn ook geleverd

    Scenario: vragen om geen enkel veld van een datum levert niet de required velden van die datum
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999991929                       |
      | fields              | geboorte.plaats                 |
      Dan heeft de response een persoon met alleen de volgende 'geboorte' gegevens
      | naam                | waarde        |
      | plaats.code         | 0518          |
      | plaats.omschrijving | 's-Gravenhage |