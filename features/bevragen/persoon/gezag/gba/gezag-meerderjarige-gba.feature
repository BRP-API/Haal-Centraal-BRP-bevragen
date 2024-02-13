#language: nl

@gba
Functionaliteit: gezagsrelaties van een meerderjarige


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
      | 000000012       | GG         | 000000024        |
      | 000000012       | GG         | 000000048        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde           |
      | type                             | GezamenlijkGezag |
      | minderjarige.burgerservicenummer | 000000012        |
      | ouder.burgerservicenummer        | 000000024        |
      | derde.burgerservicenummer        | 000000048        |


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
      Dan heeft de response een persoon zonder 'gezag' gegevens


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
      Dan heeft de response een persoon zonder 'gezag' gegevens

  Rule: wanneer over een minderjarig kind van een persoon tijdelijk niemand gezag heeft, wordt gezag over dit kind niet geleverd

    Scenario: tijdelijk heeft niemand gezag over een minderjarig kind
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon met burgerservicenummer '000000024' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 20190516 |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | G          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder 'gezag' gegevens
