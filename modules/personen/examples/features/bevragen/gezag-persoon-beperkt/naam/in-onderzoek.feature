#language: nl

Functionaliteit: Gezag Persoon beperkt: naam velden in onderzoek

    Abstract Scenario: '<type>' is in onderzoek en alle naam velden wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | geslachtsnaam (02.40)           | Maassen                   |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam                                    |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde               |
      | geslachtsnaam                                | Maassen              |
      | volledigeNaam                                | Maassen              |
      | inOnderzoek.voornamen                        | <voornamen io>       |
      | inOnderzoek.adellijkeTitelPredicaat          | <titel/predicaat io> |
      | inOnderzoek.voorvoegsel                      | <voorvoegsel io>     |
      | inOnderzoek.geslachtsnaam                    | <geslachtsnaam io>   |
      | inOnderzoek.voorletters                      | <voorletters io>     |
      | inOnderzoek.volledigeNaam                    | <volledige naam io>  |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01           |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002          |

      Voorbeelden:
      | aanduiding in onderzoek | voornamen io | titel/predicaat io | voorvoegsel io | geslachtsnaam io | voorletters io | volledige naam io | type                      |
      | 010000                  | true         | true               | true           | true             | true           | true              | hele categorie persoon    |
      | 010200                  | true         | true               | true           | true             | true           | true              | hele groep naam           |
      | 010210                  | true         |                    |                |                  | true           | true              | voornamen                 |
      | 010220                  |              | true               |                |                  |                | true              | adellijke titel/predicaat |
      | 010230                  |              |                    | true           |                  |                | true              | voorvoegsel               |
      | 010240                  |              |                    |                | true             |                | true              | geslachtsnaam             |
      | 010400                  |              |                    |                |                  |                | true              | hele groep geslacht       |
      | 010410                  |              |                    |                |                  |                | true              | geslachtsaanduiding       |

    Abstract Scenario: '<type>' is in onderzoek en alle naam velden wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | geslachtsnaam (02.40)           | Maassen                   |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam                                    |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam          | waarde  |
      | geslachtsnaam | Maassen |
      | volledigeNaam | Maassen |

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 016100                  | hele groep naamgebruik |
      | 016110                  | aanduiding naamgebruik |

    Abstract Scenario: '<type>' is in onderzoek en voornamen wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | geslachtsnaam (02.40)           | Maassen                   |
      | voornamen (02.10)               | Jan                       |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.voornamen                          |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde      |
      | voornamen                                    | Jan         |
      | inOnderzoek.voornamen                        | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 010000                  | hele categorie persoon |
      | 010200                  | hele groep naam        |
      | 010210                  | voornamen              |

    Abstract Scenario: '<type>' is in onderzoek en voorvoegsel wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | geslachtsnaam (02.40)           | Maassen                   |
      | voorvoegsel (02.30)             | van de                    |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.voorvoegsel                        |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde      |
      | voorvoegsel                                  | van de      |
      | inOnderzoek.voorvoegsel                      | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 010000                  | hele categorie persoon |
      | 010200                  | hele groep naam        |
      | 010230                  | voorvoegsel            |

    Abstract Scenario: '<type>' is in onderzoek en geslachtsnaam wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | geslachtsnaam (02.40)           | Maassen                   |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.geslachtsnaam                      |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde      |
      | geslachtsnaam                                | Maassen     |
      | inOnderzoek.geslachtsnaam                    | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 010000                  | hele categorie persoon |
      | 010200                  | hele groep naam        |
      | 010240                  | geslachtsnaam          |

    Abstract Scenario: '<type>' is in onderzoek en adellijkeTitelPredicaat wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                                 | waarde                    |
      | aanduiding in onderzoek (83.10)      | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)       | 20020701                  |
      | geslachtsnaam (02.40)                | Maassen                   |
      | geboortedatum (03.10)                | 19830526                  |
      | adellijke titel of predicaat (02.20) | JH                        |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.adellijkeTitelPredicaat            |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde      |
      | adellijkeTitelPredicaat.code                 | JH          |
      | adellijkeTitelPredicaat.omschrijving         | jonkheer    |
      | adellijkeTitelPredicaat.soort                | predicaat   |
      | inOnderzoek.adellijkeTitelPredicaat          | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                      |
      | 010000                  | hele categorie persoon    |
      | 010200                  | hele groep naam           |
      | 010220                  | adellijke titel/predicaat |

    Abstract Scenario: '<type>' is in onderzoek en voorletters wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | geslachtsnaam (02.40)           | Maassen                   |
      | voornamen (02.10)               | Jan                       |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.voorletters                        |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde      |
      | voorletters                                  | J.          |
      | inOnderzoek.voorletters                      | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 010000                  | hele categorie persoon |
      | 010200                  | hele groep naam        |
      | 010210                  | voornamen              |

    Abstract Scenario: '<type>' is in onderzoek en volledigeNaam wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | voornamen (02.10)               | Jan                       |
      | geslachtsnaam (02.40)           | Maassen                   |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.volledigeNaam                      |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                         | waarde      |
      | volledigeNaam                                | Jan Maassen |
      | inOnderzoek.volledigeNaam                    | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                      |
      | 010000                  | hele categorie persoon    |
      | 010200                  | hele groep naam           |
      | 010210                  | voornamen                 |
      | 010220                  | adellijke titel/predicaat |
      | 010230                  | voorvoegsel               |
      | 010240                  | geslachtsnaam             |
      | 010400                  | hele groep geslacht       |
      | 010410                  | geslachtsaanduiding       |

    Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | geslachtsnaam (02.40)           | Maassen                   |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.<field>                            |
      Dan heeft de response een persoon zonder 'naam' gegevens

      Voorbeelden:
      | aanduiding in onderzoek | field                   | type                      |
      | 010210                  | adellijkeTitelPredicaat | voornamen                 |
      | 010220                  | voorvoegsel             | adellijke titel/predicaat |
      | 010230                  | voorletters             | voorvoegsel               |
      | 010240                  | voorvoegsel             | geslachtsnaam             |
      | 016100                  | adellijkeTitelPredicaat | hele groep naamgebruik    |
      | 016110                  | voornamen               | aanduiding naamgebruik    |
