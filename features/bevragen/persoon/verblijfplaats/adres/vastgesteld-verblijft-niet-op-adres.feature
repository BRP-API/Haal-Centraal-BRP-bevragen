#language: nl

Functionaliteit: leveren 'indicatie vastgesteld verblijft niet op adres' veld bij het vragen van verblijfplaats gegevens

  Als afnemer
  Wil ik een indicatie krijgen bij het vragen van verblijfplaats gegevens van een persoon als is vastgesteld dat de gevraagde persoon niet meer verblijft op het geregistreerde adres
  Zodat ik dit niet zelf hoef af te leiden uit de aanduiding in onderzoek waarde

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 089999                          | 20020701                       |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | identificatiecode verblijfplaats (11.80) |
      | 0519                 | Spui               | 123                | 0599010000208579                         |

  Rule: aanduiding in onderzoek waarde '089999' wordt geleverd als indicatieVastgesteldVerblijftNietOpAdres verblijfplaats veld en alle geleverde verblijfplaats velden zijn in onderzoek

    Scenario: gevraagde persoon verblijft niet meer op het geregistreerde adres en één of meerdere verblijfplaats velden wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetBurgerservicenummer                 |
      | burgerservicenummer | 000000152                                       |
      | fields              | verblijfplaats.adresseerbaarObjectIdentificatie |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                         | waarde           |
      | type                                         | Adres            |
      | indicatieVastgesteldVerblijftNietOpAdres     | true             |
      | adresseerbaarObjectIdentificatie             | 0599010000208579 |
      | inOnderzoek.type                             | true             |
      | inOnderzoek.adresseerbaarObjectIdentificatie | true             |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum            |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01       |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002      |

    Scenario: gevraagde persoon verblijft niet meer op het geregistreerde adres en één of meerdere verblijfadres velden wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                           |
      | type                | RaadpleegMetBurgerservicenummer                  |
      | burgerservicenummer | 000000152                                        |
      | fields              | verblijfplaats.verblijfadres.officieleStraatnaam |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                         | waarde      |
      | type                                         | Adres       |
      | indicatieVastgesteldVerblijftNietOpAdres     | true        |
      | inOnderzoek.type                             | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |
      En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | officieleStraatnaam                          | Spui        |
      | inOnderzoek.officieleStraatnaam              | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Scenario: gevraagde persoon verblijft niet meer op het geregistreerde adres en er wordt geen verblijfplaats velden gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |
