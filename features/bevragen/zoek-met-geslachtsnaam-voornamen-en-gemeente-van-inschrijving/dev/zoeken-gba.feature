#language: nl

@gba
Functionaliteit: ZoekMetNaamEnGemeenteVanInschrijving met diakriet en wildcard en case insensitive

    Abstract Scenario: zoeken met geslachtsnaam en voornamen zoekt met of zonder diakrieten, case insensitive en met wildcard
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) | voornamen (02.10) | voornamen (diakrieten) |
      | 19830526              | Gunduz                | Gündüz                     | Zoe Zumra         | Zoë Zümra              |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                               |
      | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
      | geslachtsnaam           | <geslachtsnaam>                      |
      | voornamen               | <voornamen>                          |
      | gemeenteVanInschrijving | 0014                                 |
      | fields                  | burgerservicenummer                  |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |

      Voorbeelden:
      | geslachtsnaam | voornamen |
      | Gunduz        | Zoe Zumra |
      | Gündüz        | Zoe Zumra |
      | Gündüz        | Zoë Zümra |
      | Gunduz        | Zoë Zümra |
      | gunduz        | zoe zumra |
      | gündüz        | zoe zumra |
      | gündüz        | zoë zümra |
      | gunduz        | zoë zümra |
      | GUNDUZ        | ZOE ZUMRA |
      | GÜNDÜZ        | ZOE ZUMRA |
      | GÜNDÜZ        | ZOË ZÜMRA |
      | GUNDUZ        | ZOË ZÜMRA |
      | gundu*        | zoe zumra |
      | gündü*        | zoe zumra |
      | gündü*        | zoë zümra |
      | gundu*        | zoë zümra |
      | gunduz        | zoe*      |
      | gündüz        | zoe*      |
      | gündüz        | zoë*      |
      | gunduz        | zoë*      |
      | gundu*        | zoe*      |
      | gündü*        | zoe*      |
      | gündü*        | zoë*      |
      | gundu*        | zoë*      |
      | GUNDU*        | ZOE ZUMRA |
      | GÜNDÜ*        | ZOE ZUMRA |
      | GÜNDÜ*        | ZOË ZÜMRA |
      | GUNDU*        | ZOË ZÜMRA |
      | GUNDUZ        | ZOE*      |
      | GÜNDÜZ        | ZOE*      |
      | GÜNDÜZ        | ZOË*      |
      | GUNDUZ        | ZOË*      |
      | GUNDU*        | ZOE*      |
      | GÜNDÜ*        | ZOE*      |
      | GÜNDÜ*        | ZOË*      |
      | GUNDU*        | ZOË*      |

    Abstract Scenario: Wanneer je een diakriet gebruikt in een parameter, dan moet die ook gebruikt worden bij zoeken
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) | voornamen (02.10) | voornamen (diakrieten) |
      | 19830526              | Gundogan              | Gündoğan                   | Michel            | Michèl                 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) | voornamen (02.10) | voornamen (diakrieten) |
      | 19830526              | Gundogan              |                            | Michel            |                        |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0014                              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                               |
      | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
      | geslachtsnaam           | <geslachtsnaam>                      |
      | voornamen               | <voornamen>                          |
      | gemeenteVanInschrijving | 0014                                 |
      | fields                  | burgerservicenummer                  |
      Dan heeft de response <aantal> personen


      Voorbeelden:
      | geslachtsnaam | voornamen | aantal |
      | Gundogan      | Michel    | 2      |
      | Gündoğan      | Michel    | 1      |
      | Gundogan      | Michèl    | 1      |
