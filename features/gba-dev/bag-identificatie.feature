#language: nl

Functionaliteit: BAG-identificatie met waarde die niet voldoet aan de specificatie moet niet geleverd worden
  BAG-identificaties identificatiecode verblijfplaats (11.80) en identificatiecode nummeraanduiding (11.90) moeten bestaan uit exact 16 cijfers

  Het kan nu nog voorkomen dat deze identificaties zijn opgeslagen als getal, waardoor de voorloopnul(len) zijn weggevallen.
  In de BRP-V bron wordt dit dan opgeslagen door de waarde aan te vullen met spaties tot het 16 tekens lang is.

    Abstract Scenario: BAG-identificaties bestaan uit <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | datum aanvang adreshouding (10.30) | 20150808 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                |
      | gemeente_code                              | <gemeente code>       |
      | straatnaam (11.10)                         | Kromme dijk           |
      | huisnummer (11.20)                         | 15                    |
      | postcode (11.60)                           | 1001XX                |
      | woonplaats (11.70)                         | Testdorp              |
      | identificatiecode verblijfplaats (11.80)   | <verblijfplaats id>   |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduiding id> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                  |
      | type                | RaadpleegMetBurgerservicenummer                                         |
      | burgerservicenummer | 000000024                                                               |
      | fields              | verblijfplaats.verblijfadres.postcode,verblijfplaats.nummeraanduidingIdentificatie,verblijfplaats.adresseerbaarObjectIdentificatie |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam     | waarde      |
      | postcode | 1001XX      |
      | straat   | Kromme dijk |

      Voorbeelden:
      | omschrijving                 | gemeente code | verblijfplaats id | nummeraanduiding id |
      | 14 cijfers plus twee spaties | 0024          | 24010000123456    | 24200000123456      |
      | 15 cijfers plus een spatie   | 0363          | 363010000123456   | 363200000123456     |
      | cijfers en een letter        | 0363          | 03630V0000123456  | 0363NA0000123456    |

    Scenario: BAG-identificaties bestaan uit 16 cijfers
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | datum aanvang adreshouding (10.30) | 20150808 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde           |
      | gemeente_code                              | 0363             |
      | straatnaam (11.10)                         | Kromme dijk      |
      | huisnummer (11.20)                         | 15               |
      | postcode (11.60)                           | 1001XX           |
      | woonplaats (11.70)                         | Testdorp         |
      | identificatiecode verblijfplaats (11.80)   | 0363010000123456 |
      | identificatiecode nummeraanduiding (11.90) | 0363200000123456 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                  |
      | type                | RaadpleegMetBurgerservicenummer                                         |
      | burgerservicenummer | 000000024                                                               |
      | fields              | verblijfplaats.verblijfadres.postcode,verblijfplaats.nummeraanduidingIdentificatie,verblijfplaats.adresseerbaarObjectIdentificatie |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde           |
      | postcode                         | 1001XX           |
      | straat                           | Kromme dijk      |
      | adresseerbaarObjectIdentificatie | 0363010000123456 |
      | nummeraanduidingIdentificatie    | 0363200000123456 |
