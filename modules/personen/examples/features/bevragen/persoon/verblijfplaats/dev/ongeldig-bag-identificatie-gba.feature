#language: nl

@gba
Functionaliteit: BAG-identificatie met waarde die niet voldoet aan de specificatie moet niet geleverd worden
  BAG-identificaties identificatiecode verblijfplaats (11.80) en identificatiecode nummeraanduiding (11.90) moeten bestaan uit exact 16 cijfers

  Het kan nu nog voorkomen dat deze identificaties zijn opgeslagen als getal, waardoor de voorloopnul(len) zijn weggevallen.
  In de BRP-V bron wordt dit dan opgeslagen door de waarde aan te vullen met spaties tot het 16 tekens lang is.

    Abstract Scenario: '<naam veld>' bestaat uit <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | datum aanvang adreshouding (10.30) | 20150808 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde          |
      | gemeentecode (92.10) | <gemeente code> |
      | straatnaam (11.10)   | Kromme dijk     |
      | <naam veld>          | <waarde veld>   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfplaats.<field>          |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam   | waarde      |
      | straat | Kromme dijk |

      Voorbeelden:
      | naam veld                                  | omschrijving                 | gemeente code | waarde veld      | field                            |
      | identificatiecode verblijfplaats (11.80)   | 14 cijfers plus twee spaties | 0024          | 24010000123456   | adresseerbaarObjectIdentificatie |
      | identificatiecode verblijfplaats (11.80)   | 15 cijfers plus een spatie   | 0363          | 363010000123456  | adresseerbaarObjectIdentificatie |
      | identificatiecode verblijfplaats (11.80)   | cijfers en een letter        | 0363          | 03630V0000123456 | adresseerbaarObjectIdentificatie |
      | identificatiecode nummeraanduiding (11.90) | 14 cijfers plus twee spaties | 0024          | 24200000123456   | nummeraanduidingIdentificatie    |
      | identificatiecode nummeraanduiding (11.90) | 15 cijfers plus een spatie   | 0363          | 363200000123456  | nummeraanduidingIdentificatie    |
      | identificatiecode nummeraanduiding (11.90) | cijfers en een letter        | 0363          | 0363NA0000123456 | nummeraanduidingIdentificatie    |

    Abstract Scenario: '<naam veld>' bestaat uit 16 cijfers
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | datum aanvang adreshouding (10.30) | 20150808 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde        |
      | gemeentecode (92.10) | 0363          |
      | straatnaam (11.10)   | Kromme dijk   |
      | <naam veld>          | <waarde veld> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfplaats.<field>          |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam    | waarde        |
      | straat  | Kromme dijk   |
      | <field> | <waarde veld> |

      Voorbeelden:
      | naam veld                                  | waarde veld      | field                            |
      | identificatiecode verblijfplaats (11.80)   | 0363010000123456 | adresseerbaarObjectIdentificatie |
      | identificatiecode nummeraanduiding (11.90) | 0363200000123456 | nummeraanduidingIdentificatie    |
