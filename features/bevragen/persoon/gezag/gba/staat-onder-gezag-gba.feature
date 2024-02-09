#language: nl

@gba
Functionaliteit: gezagsrelaties van de minderjarige persoon met gezaghebbenden

  Rule: voor een minderjarige met twee ouders met gezag wordt de gezagsrelatie naar beide ouders geleverd

    Scenario: beide ouders hebben gezag over de minderjarige
      Gegeven voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000024        |
      | 000000012       | OG2        | 000000048        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                     | waarde                    |
      | type                     | StaatOnderGezag           |
      | kind.burgerservicenummer | 000000012                 |
      | gezagRelatie.type        | TweehoofdigOuderlijkGezag |
      En heeft 'gezagRelatie' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
      En heeft 'gezagRelatie' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |


  Rule: voor een meerderjarige wordt er geen gezagsrelatie naar de ouders geleverd

    Scenario: gezag wordt gevraagd van een meerderjarige
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 20040730 |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon met burgerservicenummer '000000012' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gegevens


  Rule: wanneer het gezag voor een minderjarige niet bepaald kan worden, wordt dit in gezag aangegeven

    Scenario: gezag over minderjarige kan niet worden bepaald
      Gegeven voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | N          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam | waarde             |
      | type | GezagNietTeBepalen |
