## Deze feature moet nog verder uitgewerkt worden. Onderstaande scenario's stonden in de fields_extensie.feature
## Daar zijn ze verwijderd en in deze feature geborgd. 

## Het inregelen van de autorisatie is toch iets dat de gemeente zelf doet ?
## Dit hoor dat toch niet thuis in de fields feature ?  Vooralsnog overgenomen uit de oude fields-feature, maar moet volgens mij weg.

    Scenario: Fields vraagt om een groep attributen en de gebruiker is niet geautoriseerd voor één van deze attributen
      Gegeven de gebruiker is niet geautoriseerd voor geboortedatum
      En de gebruiker is geautoriseerd voor geboorteplaats en geboorteland
      En het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende naam gegevens
      | naam                      |
      | voornamen                 | Johannnes Geurt |
      | geslachtsnaam             | Janssen         |
      | aanduidingNaamgebruik     | E               |
      En de persoon heeft de volgende geboorte gegevens
      | naam                                      | waarde   |
      | datum.type                                | Datum    |
      | datum.datum (01.03.10)                    | 19860401 |
      | land.code                                 | 6030     |
      | plaats.code                               | 0518     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 999994086                               |
      | fields              | burgerservicenummer,geboorte            |
      Dan bevat de response de volgende gegevens
      | naam                 | waarde       |
      | burgerservicenummer  | 999994086    |
      | geboorte.plaats.code | 0518         |
      | geboorte.land.code   | 6030         |
      En bevat de response geen andere properties

## Het inregelen van de autorisatie is toch iets dat de gemeente zelf doet ?
## Dit hoor dat toch niet thuis in de fields feature ?  Vooralsnog overgenomen uit de oude fields-feature, maar moet volgens mij weg.

    Scenario: Fields vraagt specifiek om een gegeven waarvoor deze niet geautoriseerd is
      Gegeven de gebruiker is niet geautoriseerd voor geboortedatum
      En de gebruiker is geautoriseerd voor geboorteplaats en geboorteland
      En het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende naam gegevens
      | naam                      |
      | voornamen                 | Johannnes Geurt |
      | geslachtsnaam             | Janssen         |
      | aanduidingNaamgebruik     | E               |
      En de persoon heeft de volgende geboorte gegevens
      | naam                                      | waarde   |
      | datum.type                                | Datum    |
      | datum.datum (01.03.10)                    | 19860401 |
      | land.code                                 | 6030     |
      | plaats.code                               | 0518     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 999994086                                          |
      | fields              | burgerservicenummer,geboorte.datum,geboorte.plaats |
      Dan bevat de response de volgende gegevens
      | naam                 | waarde       |
      | burgerservicenummer  | 999994086    |
      | geboorte.plaats.code | 0518         |
      En bevat de response geen andere properties
