#language: nl

@protocollering
Functionaliteit: Protocollering zoekrubrieken ZoekMetNaamEnGemeenteVanInschrijving

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                        | waarde     |
      | anummer (01.10)             | 2683754153 |
      | voornamen (02.10)           | Pieter     |
      | voorvoegsel (02.30)         | van        |
      | geslachtsnaam (02.40)       | Maassen    |
      | geslachtsaanduiding (04.10) | M          |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |

  Regel: Gebruikte parameters worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met alleen de verplichte parameters
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                               |
      | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
      | gemeenteVanInschrijving | 0599                                 |
      | geslachtsnaam           | Maassen                              |
      | voornamen               | Pieter                               |
      | fields                  | burgerservicenummer                  |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010210, 010240, 080910 |

    Abstract Scenario: Zoek persoon met parameter <optionele parameter>
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                               |
      | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
      | gemeenteVanInschrijving | 0599                                 |
      | geslachtsnaam           | Maassen                              |
      | voornamen               | Pieter                               |
      | <optionele parameter>   | <waarde>                             |
      | fields                  | burgerservicenummer                  |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | <zoek_rubrieken>       |

      Voorbeelden:
      | optionele parameter | waarde | zoek_rubrieken                 |
      | voorvoegsel         | van    | 010210, 010230, 010240, 080910 |
      | geslacht            | M      | 010210, 010240, 010410, 080910 |

  Regel: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met inclusiefOverledenPersonen
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                               |
      | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
      | gemeenteVanInschrijving    | 0599                                 |
      | geslachtsnaam              | Maassen                              |
      | voornamen                  | Pieter                               |
      | fields                     | burgerservicenummer                  |
      | inclusiefOverledenPersonen | true                                 |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010210, 010240, 080910 |
