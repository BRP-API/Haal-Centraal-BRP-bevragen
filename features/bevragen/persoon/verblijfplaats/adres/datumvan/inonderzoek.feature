#language: nl

Functionaliteit: inOnderzoek booleans voor datumVan van adres binnenland vullen

  Rule: Als aanduiding in onderzoek (83.10) een waarde heeft wordt deze waarde vertaald naar de corresponderde "inOnderzoek" Booleans. 
   
    Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek
        Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
        | naam                               | waarde                    |
        | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
        | datum ingang onderzoek (83.20)     | 20020701                  |
        | datum aanvang adreshouding (10.30) | 20220128                  |
        En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | naam                 | waarde |
        | gemeentecode (92.10) | 0518   |
        | straatnaam (11.10)   | Spui   |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000152                       |
        | fields              | verblijfplaats.datumVan         |
        Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
        | naam                                         | waarde          |
        | type                                         | Adres           |
        | datumVan.type                                | Datum           |
        | datumVan.datum                               | 2022-01-28      |
        | datumVan.langFormaat                         | 28 januari 2022 |
        | inOnderzoek.datumVan                         | true            |
        | inOnderzoek.datumIngangOnderzoek.type        | Datum           |
        | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01      |
        | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002     |

        Voorbeelden:
        | gba in onderzoek waarde |
        | 080000                  |
        | 081000                  |
        | 081030                  |

        Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek, maar wordt niet gevraagd
          Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
          | naam                               | waarde                    |
          | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
          | datum ingang onderzoek (83.20)     | 20020701                  |
          | datum aanvang adreshouding (10.30) | 20220128                  |
          En de 'verblijfplaats' heeft de volgende 'adres' gegevens
          | naam                 | waarde |
          | gemeentecode (92.10) | 0518   |
          | straatnaam (11.10)   | Spui   |
          Als personen wordt gezocht met de volgende parameters
          | naam                | waarde                               |
          | type                | RaadpleegMetBurgerservicenummer      |
          | burgerservicenummer | 000000152                            |
          | fields              | verblijfplaats.datumIngangGeldigheid |
          Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
          | naam | waarde |
          | type | Adres  |

          Voorbeelden:
          | gba in onderzoek waarde |
          | 081030                  |
          | 081300                  |
          | 081320                  |