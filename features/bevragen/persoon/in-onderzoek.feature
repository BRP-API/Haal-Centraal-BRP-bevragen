#language: nl

Functionaliteit: in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en burgerservicenummer, geslacht en leeftijd worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | geslachtsaanduiding (04.10)     | M                         |
    | geboortedatum (03.10)           | gisteren - 20 jaar        |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000152                             |
    | fields              | burgerservicenummer,geslacht,leeftijd |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                | waarde                   |
    | burgerservicenummer                                 | 000000152                |
    | leeftijd                                            | 20                       |
    | geslacht.code                                       | M                        |
    | geslacht.omschrijving                               | man                      |
    | inOnderzoek.burgerservicenummer                     | <burgerservicenummer io> |
    | inOnderzoek.geslacht                                | <geslacht io>            |
    | inOnderzoek.leeftijd                                | <leeftijd io>            |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | aanduiding in onderzoek | burgerservicenummer io | geslacht io | leeftijd io | type                   |
    | 010000                  | true                   | true        | true        | hele categorie persoon |
    | 010100                  | true                   |             |             | hele groep persoon     |
    | 010120                  | true                   |             |             | burgerservicenummer    |
    | 010300                  |                        |             | true        | hele groep geboorte    |
    | 010310                  |                        |             | true        | geboortedatum          |
    | 010400                  |                        | true        |             | hele groep geslacht    |
    | 010410                  |                        | true        |             | geslachtsaanduiding    |

  Abstract Scenario: '<type>' is in onderzoek en gemeenteVanInschrijving en datumInschrijvingInGemeente worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | datum inschrijving in de gemeente (09.20) | 20020701                  |
    | gemeente van inschrijving (09.10)         | 0518                      |
    | aanduiding in onderzoek (83.10)           | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)            | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                              |
    | type                | RaadpleegMetBurgerservicenummer                     |
    | burgerservicenummer | 000000152                                           |
    | fields              | gemeenteVanInschrijving,datumInschrijvingInGemeente |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                 | waarde                           |
    | datumInschrijvingInGemeente.type                     | Datum                            |
    | datumInschrijvingInGemeente.datum                    | 2002-07-01                       |
    | datumInschrijvingInGemeente.langFormaat              | 1 juli 2002                      |
    | gemeenteVanInschrijving.code                         | 0518                             |
    | gemeenteVanInschrijving.omschrijving                 | 's-Gravenhage                    |
    | inOnderzoek.gemeenteVanInschrijving                  | <gemeenteVanInschrijving io>     |
    | inOnderzoek.datumInschrijvingInGemeente              | <datumInschrijvingInGemeente io> |
    | inOnderzoek.datumIngangOnderzoekGemeente.type        | Datum                            |
    | inOnderzoek.datumIngangOnderzoekGemeente.datum       | 2002-07-01                       |
    | inOnderzoek.datumIngangOnderzoekGemeente.langFormaat | 1 juli 2002                      |

    Voorbeelden:
    | aanduiding in onderzoek | gemeenteVanInschrijving io | datumInschrijvingInGemeente io | type                              |
    | 080000                  | true                       | true                           | hele categorie verblijfplaats     |
    | 080900                  | true                       | true                           |                                   |
    | 080910                  | true                       |                                | gemeente van inschrijving         |
    | 080920                  |                            | true                           | datum inschrijving in de gemeente |

  Scenario: '<type>' is in onderzoek, maar 'burgerservicenummer' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | aNummer                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                |
    | 010100                  | hele groep persoon  |
    | 010120                  | burgerservicenummer |

  Abstract Scenario: '<type>' is in onderzoek, maar 'geslacht' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsaanduiding (04.10)     | M                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | aNummer                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                |
    | 010400                  | hele groep geslacht |
    | 010410                  | geslachtsaanduiding |

  Abstract Scenario: '<type>' is in onderzoek, maar 'leeftijd' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | gisteren - 20 jaar        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | aNummer                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                |
    | 010300                  | hele groep geboorte |
    | 010310                  | geboortedatum       |

  Abstract Scenario: '<type>' is in onderzoek, maar 'gemeenteVanInschrijving' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | aNummer                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                      |
    | 080900                  | hele groep gemeente       |
    | 080910                  | gemeente van inschrijving |

  Abstract Scenario: '<type>' is in onderzoek, maar 'datumInschrijvingInGemeente' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | aNummer                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                              |
    | 080900                  | hele groep gemeente               |
    | 080920                  | datum inschrijving in de gemeente |
