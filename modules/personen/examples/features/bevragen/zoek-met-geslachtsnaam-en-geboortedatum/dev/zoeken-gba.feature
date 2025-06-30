#language: nl

@gba
Functionaliteit: ZoekMetGeslachtsnaamEnGeboortedatum met diakriet en wildcard en case insensitive

    Abstract Scenario: zoeken met geslachtsnaam en voornamen zoekt met of zonder diakrieten, case insensitive en met wildcard
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) | voornamen (02.10) | voornamen (diakrieten) |
      | 19830526              | Gundogan              | Gündoğan                   | Zoe Zumra         | Zoë Zümra              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | <geslachtsnaam>                     |
      | voornamen     | <voornamen>                         |
      | geboortedatum | 1983-05-26                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |

      Voorbeelden:
      | geslachtsnaam | voornamen |
      | Gundogan      | Zoe Zumra |
      | Gündoğan      | Zoe Zumra |
      | Gündoğan      | Zoë Zümra |
      | Gundogan      | Zoë Zümra |
      | gundogan      | zoe zumra |
      | gündoğan      | zoe zumra |
      | gündoğan      | zoë zümra |
      | gundogan      | zoë zümra |
      | GUNDOGAN      | ZOE ZUMRA |
      | GÜNDOĞAN      | ZOE ZUMRA |
      | GÜNDOĞAN      | ZOË ZÜMRA |
      | GUNDOGAN      | ZOË ZÜMRA |
      | gundo*        | zoe zumra |
      | gündo*        | zoe zumra |
      | gündo*        | zoë zümra |
      | gundo*        | zoë zümra |
      | gundogan      | zoe*      |
      | gündoğan      | zoe*      |
      | gündoğan      | zoë*      |
      | gundogan      | zoë*      |
      | gundo*        | zoe*      |
      | gündo*        | zoe*      |
      | gündo*        | zoë*      |
      | gundo*        | zoë*      |
      | GUNDO*        | ZOE ZUMRA |
      | GÜNDO*        | ZOE ZUMRA |
      | GÜNDO*        | ZOË ZÜMRA |
      | GUNDO*        | ZOË ZÜMRA |
      | GUNDOGAN      | ZOE*      |
      | GÜNDOĞAN      | ZOE*      |
      | GÜNDOĞAN      | ZOË*      |
      | GUNDOGAN      | ZOË*      |
      | GUNDO*        | ZOE*      |
      | GÜNDO*        | ZOE*      |
      | GÜNDO*        | ZOË*      |
      | GUNDO*        | ZOË*      |

    Abstract Scenario: Wanneer je een diakriet gebruikt in een parameter, dan moet die ook gebruikt worden bij zoeken
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) | voornamen (02.10) | voornamen (diakrieten) |
      | 19830526              | Gundogan              | Gündoğan                   | Michel            | Michèl                 |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) | voornamen (02.10) | voornamen (diakrieten) |
      | 19830526              | Gundogan              |                            | Michel            |                        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | <geslachtsnaam>                     |
      | voornamen     | <voornamen>                         |
      | geboortedatum | 1983-05-26                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de response <aantal> personen

      Voorbeelden:
      | geslachtsnaam | voornamen | aantal |
      | Gundogan      | Michel    | 2      |
      | Gündoğan      | Michel    | 1      |
      | Gundogan      | Michèl    | 1      |
