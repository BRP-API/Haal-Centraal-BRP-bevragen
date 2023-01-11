#language: nl

Functionaliteit: Persoon: adresregel velden in onderzoek

  Abstract Scenario: persoon heeft adres als verblijfplaats, '<type>' is in onderzoek en alle adresregel velden worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
    | 0518                 | .                  | 0                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                   |
    | type                | RaadpleegMetBurgerservicenummer                                                          |
    | burgerservicenummer | 000000152                                                                                |
    | fields              | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                       | waarde           |
    | inOnderzoek.adresregel1                                    | <adresregel1 io> |
    | inOnderzoek.adresregel2                                    | <adresregel2 io> |
    | inOnderzoek.adresregel3                                    | <adresregel3 io> |
    | inOnderzoek.land                                           | <land io>        |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum            |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01       |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002      |

    Voorbeelden:
    | aanduiding in onderzoek | adresregel1 io | adresregel2 io | adresregel3 io | land io | type                               |
    | 080000                  | true           | true           | true           | true    | hele categorie verblijfplaats      |
    | 080900                  |                | true           |                |         | hele groep gemeente                |
    | 080910                  |                | true           |                |         | gemeente van inschrijving          |
    | 081000                  |                |                |                |         | hele groep adreshouding            |
    | 081010                  |                |                |                |         | functie adres                      |
    | 081030                  |                |                |                |         | datum aanvang adreshouding         |
    | 081100                  | true           | true           |                |         | hele groep adres                   |
    | 081110                  | true           |                |                |         | straatnaam                         |
    | 081115                  |                |                |                |         | naam openbare ruimte               |
    | 081120                  | true           |                |                |         | huisnummer                         |
    | 081130                  | true           |                |                |         | huisletter                         |
    | 081140                  | true           |                |                |         | huinummertoevoeging                |
    | 081150                  | true           |                |                |         | aanduiding bij huisnummer          |
    | 081160                  |                | true           |                |         | postcode                           |
    | 081170                  |                | true           |                |         | woonplaatsnaam                     |
    | 081180                  |                |                |                |         | identificatiecode verblijfplaats   |
    | 081190                  |                |                |                |         | identificatiecode nummeraanduiding |
    | 088500                  |                |                |                |         | hele groep geldigheid              |
    | 088510                  |                |                |                |         | datum ingang geldigheid            |

  Abstract Scenario: persoon heeft locatie als verblijfplaats, '<type>' is in onderzoek en alle adresregel velden worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10)       |
    | 0518                 | Woonboot tegenover de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                   |
    | type                | RaadpleegMetBurgerservicenummer                                                          |
    | burgerservicenummer | 000000152                                                                                |
    | fields              | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                       | waarde                            |
    | adresregel1                                                | Woonboot tegenover de Grote Sloot |
    | inOnderzoek.adresregel1                                    | <adresregel1 io>                  |
    | inOnderzoek.adresregel2                                    | <adresregel2 io>                  |
    | inOnderzoek.adresregel3                                    | <adresregel3 io>                  |
    | inOnderzoek.land                                           | <land io>                         |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum                             |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01                        |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002                       |

    Voorbeelden:
    | aanduiding in onderzoek | adresregel1 io | adresregel2 io | adresregel3 io | land io | type                          |
    | 080000                  | true           | true           | true           | true    | hele categorie verblijfplaats |
    | 080900                  |                | true           |                |         | hele groep gemeente           |
    | 080910                  |                | true           |                |         | gemeente van inschrijving     |
    | 081000                  |                |                |                |         | hele groep adreshouding       |
    | 081010                  |                |                |                |         | functie adres                 |
    | 081030                  |                |                |                |         | datum aanvang adreshouding    |
    | 081200                  | true           |                |                |         | hele groep locatie            |
    | 081210                  | true           |                |                |         | locatiebeschrijving           |
    | 088500                  |                |                |                |         | hele groep geldigheid         |
    | 088510                  |                |                |                |         | datum ingang geldigheid       |

  Abstract Scenario: persoon heeft een verblijfplaats buitenland, '<type>' is in onderzoek en alle adresregel velden worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0000         | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                   |
    | type                | RaadpleegMetBurgerservicenummer                                                          |
    | burgerservicenummer | 000000346                                                                                |
    | fields              | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                       | waarde           |
    | inOnderzoek.adresregel1                                    | <adresregel1 io> |
    | inOnderzoek.adresregel2                                    | <adresregel2 io> |
    | inOnderzoek.adresregel3                                    | <adresregel3 io> |
    | inOnderzoek.land                                           | <land io>        |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum            |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01       |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002      |

    Voorbeelden:
    | aanduiding in onderzoek | adresregel1 io | adresregel2 io | adresregel3 io | land io | type                           |
    | 080000                  | true           | true           | true           | true    | hele categorie verblijfplaats  |
    | 081300                  | true           | true           | true           | true    | hele groep adres buitenland    |
    | 081310                  |                |                |                | true    | land adres buitenland          |
    | 081320                  |                |                |                |         | datum aanvang adres buitenland |
    | 081330                  | true           |                |                |         | regel 1 adres buitenland       |
    | 081340                  |                | true           |                |         | regel 2 adres buitenland       |
    | 081350                  |                |                | true           |         | regel 3 adres buitenland       |
    | 088500                  |                |                |                |         | hele groep geldigheid          |
    | 088510                  |                |                |                |         | datum ingang geldigheid        |
