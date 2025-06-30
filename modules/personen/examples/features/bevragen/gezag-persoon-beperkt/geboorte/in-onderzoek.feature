#language: nl

Functionaliteit: Gezag Persoon beperkt: geboorte velden in onderzoek

    Abstract Scenario: '<type>' is in onderzoek en geboorte wordt gevraagd
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0599010051001502                         |
      En de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | geboortedatum (03.10)           | 19830526                  |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      En de persoon is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | geboorte                                |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
      | naam                                         | waarde      |
      | datum.type                                   | Datum       |
      | datum.datum                                  | 1983-05-26  |
      | datum.langFormaat                            | 26 mei 1983 |
      | inOnderzoek.datum                            | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 010000                  | hele categorie persoon |
      | 010300                  | hele groep geboorte    |
      | 010310                  | geboortedatum          |

    Abstract Scenario: '<type>' is in onderzoek en geboortedatum wordt gevraagd
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0599010051001502                         |
      En de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | geboortedatum (03.10)           | 19830526                  |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      En de persoon is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | geboorte.datum                          |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
      | naam                                         | waarde      |
      | datum.type                                   | Datum       |
      | datum.datum                                  | 1983-05-26  |
      | datum.langFormaat                            | 26 mei 1983 |
      | inOnderzoek.datum                            | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 010000                  | hele categorie persoon |
      | 010300                  | hele groep geboorte    |
      | 010310                  | geboortedatum          |
