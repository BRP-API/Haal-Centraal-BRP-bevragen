#language: nl

@gba
Functionaliteit: gezagsrelaties van de minderjarige(n) waar een de meerderjarig persoon gezag over heeft


  Rule: voor een minderjarige met gezamenlijk gezag wordt de gezagsrelatie naar de ouder en de andere gezaghebbende geleverd

    Scenario: de ouder en diens partner hebben gezag over het kind
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000024        |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG        | 000000024        |
      | 000000012       | GG        | 000000048        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                            | waarde           |
      | type                            | HeeftGezagOver   |
      | gezaghouder.burgerservicenummer | 000000024        |
      | gezagRelaties.type              | GezamenlijkGezag |
      En heeft 'gezagRelatie' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
      En heeft 'gezagRelatie' een 'derde' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |


  Rule: voor een meerderjarige wordt er geen gezagsrelatie naar de ouders geleverd

    Scenario: gezag wordt gevraagd van ouder met meerderjarig kind
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 20040730 |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon met burgerservicenummer '000000012' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon met burgerservicenummer '000000024' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gegevens


  Rule: wanneer het gezag voor een minderjarig kind niet bepaald kan worden, wordt gezag over dit kind niet geleverd

    Scenario: gezag over minderjarige kan niet worden bepaald
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon met burgerservicenummer '000000024' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | N          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gegevens