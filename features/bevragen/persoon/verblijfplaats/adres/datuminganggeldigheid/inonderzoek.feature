#language: nl

Functionaliteit: inOnderzoek booleans voor datumIngangGeldigheid voor adres binnenland vullen

  Rule: Als aanduiding in onderzoek (83.10) een waarde heeft wordt deze waarde vertaald naar de corresponderde ïnOnderzoek" Booleans. 
   
    Abstract Scenario: 'datum ingang geldigheid (85.10)' is in onderzoek
        Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
        | naam                            | waarde                    |
        | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
        | datum ingang onderzoek (83.20)  | 20020701                  |
        | datum ingang geldigheid (85.10) | 20220222                  |
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
        | naam                                         | waarde           |
        | type                                         | Adres            |
        | datumIngangGeldigheid.type                   | Datum            |
        | datumIngangGeldigheid.datum                  | 2022-02-22       |
        | datumIngangGeldigheid.langFormaat            | 22 februari 2022 |
        | inOnderzoek.datumIngangGeldigheid            | true             |
        | inOnderzoek.datumIngangOnderzoek.type        | Datum            |
        | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01       |
        | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002      |

        Voorbeelden:
        | gba in onderzoek waarde |
        | 080000                  |
        | 088500                  |
        | 088510                  |

    Abstract Scenario: 'datum ingang geldigheid (85.10)' is in onderzoek, maar wordt niet gevraagd
        Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
        | naam                            | waarde                    |
        | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
        | datum ingang onderzoek (83.20)  | 20020701                  |
        | datum ingang geldigheid (85.10) | 20220222                  |
        En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | naam                 | waarde |
        | gemeentecode (92.10) | 0518   |
        | straatnaam (11.10)   | Spui   |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                                       |
        | type                | RaadpleegMetBurgerservicenummer              |
        | burgerservicenummer | 000000152                                    |
        | fields              | verblijfplaats.nummeraanduidingIdentificatie |
        Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
        | naam | waarde |
        | type | Adres  |

        Voorbeelden:
        | gba in onderzoek waarde |
        | 088500                  |
        | 088510                  |