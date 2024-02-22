#language: nl

Functionaliteit: Gezag Persoon beperkt: leeftijd veld in onderzoek

    Abstract Scenario: '<type>' is in onderzoek en leeftijd wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | vandaag - 10 jaar     | <aanduiding in onderzoek>       | 20020701                       |
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
      | fields                           | leeftijd                                |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                | waarde      |
      | leeftijd                                            | 10          |
      | inOnderzoek.leeftijd                                | true        |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 010000                  | hele categorie persoon |
      | 010300                  | hele groep geboorte    |
      | 010310                  | geboortedatum          |

    Abstract Scenario: '<type>' is in onderzoek en leeftijd wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | vandaag - 10 jaar     | <aanduiding in onderzoek>       | 20020701                       |
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
      | fields                           | leeftijd                                |
      Dan heeft de response een persoon met de volgende gegevens
      | naam     | waarde |
      | leeftijd | 10     |

    Voorbeelden:
    | aanduiding in onderzoek | type           |
    | 010320                  | geboorteplaats |
    | 010330                  | geboorteland   |

    Abstract Scenario: '<type>' is in onderzoek en leeftijd wordt niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | vandaag - 10 jaar     | <aanduiding in onderzoek>       | 20020701                       |
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
      | fields                           | adressering.adresregel1                 |
      Dan heeft de response een persoon zonder gegevens

      Voorbeelden:
      | aanduiding in onderzoek | type                   |
      | 010000                  | hele categorie persoon |
      | 010300                  | hele groep geboorte    |
      | 010310                  | geboortedatum          |
