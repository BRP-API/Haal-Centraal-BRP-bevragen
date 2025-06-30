#language: nl

Functionaliteit: leveren 'indicatie vastgesteld verblijft niet op adres' veld bij het vragen van verblijfplaats gegevens

  Als afnemer
  Wil ik een indicatie krijgen bij het vragen van verblijfplaats gegevens van een persoon als is vastgesteld dat de gevraagde persoon niet meer verblijft op de geregistreerde locatie
  Zodat ik dit niet zelf hoef af te leiden uit de aanduiding in onderzoek waarde

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) | datum ingang geldigheid (85.10) |
      | 089999                          | 20020701                       | 20000423                           | 20220222                        |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10)  |
      | 0518                 | Woonboot in de Grotere Sloot |

  Regel: aanduiding in onderzoek waarde '089999' wordt geleverd als indicatieVastgesteldVerblijftNietOpAdres verblijfplaats veld en alle geleverde verblijfplaats velden zijn in onderzoek

    Abstract Scenario: gevraagde persoon verblijft niet meer op de geregistreerde locatie en één of meerdere verblijfplaats velden wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | verblijfplaats.<veld>           |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                         | waarde         |
      | type                                         | Locatie        |
      | indicatieVastgesteldVerblijftNietOpAdres     | true           |
      | <veld>.type                                  | Datum          |
      | <veld>.datum                                 | <datum>        |
      | <veld>.langFormaat                           | <lang formaat> |
      | inOnderzoek.type                             | true           |
      | inOnderzoek.<veld>                           | true           |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

      Voorbeelden:
      | veld                  | datum      | lang formaat     |
      | datumVan              | 2000-04-23 | 23 april 2000    |
      | datumIngangGeldigheid | 2022-02-22 | 22 februari 2022 |

    Abstract Scenario: gevraagde persoon verblijft niet meer op de geregistreerde locatie en één of meerdere verblijfadres velden wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000152                           |
      | fields              | verblijfplaats.verblijfadres.<veld> |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                         | waarde      |
      | type                                         | Locatie     |
      | indicatieVastgesteldVerblijftNietOpAdres     | true        |
      | inOnderzoek.type                             | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |
      En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | <veld>                                       | <waarde>    |
      | inOnderzoek.<veld>                           | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | veld                | waarde                       |
      | locatiebeschrijving | Woonboot in de Grotere Sloot |

    Scenario: gevraagde persoon verblijft niet meer op de geregistreerde locatie en er wordt geen verblijfplaats velden gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |
