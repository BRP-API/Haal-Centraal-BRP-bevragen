#language: nl

@gba
Functionaliteit: persoon: in onderzoek

  Abstract Scenario: gemeente van inschrijving is in onderzoek en wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                    |
    | gemeente van inschrijving (09.10) | 0518                      |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                 | waarde        |
    | gemeenteVanInschrijving.code         | 0518          |
    | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde | field                                |
    | 080000                  | gemeenteVanInschrijving              |
    | 080900                  | gemeenteVanInschrijving.code         |
    | 080910                  | gemeenteVanInschrijving.omschrijving |

  Abstract Scenario: datum inschrijving in de gemeente is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | datum inschrijving in de gemeente (09.20) | 20020101                  |
    | aanduiding in onderzoek (83.10)           | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)            | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | datumInschrijvingInGemeente     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                        | waarde   |
    | datumInschrijvingInGemeente | 20020101 |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 080900                  |
    | 080920                  |

Regel: in onderzoek wordt niet opgenomen wanneer het onderzoek beëindigd is
  - Datum einde onderzoek (83.30) heeft een waarde

  Scenario: onderzoek is beëindigd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | voornamen (02.10) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | 
    | Arnitta           | 19231213              | 010000                          | 20120920                       | 20120922                      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 000000152                                         |
    | fields              | burgerservicenummer,naam.voornamen,geboorte.datum |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |
    | naam.voornamen      | Arnitta   |
    | geboorte.datum      | 19231213  |
