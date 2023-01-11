#language: nl

Functionaliteit: GBA verblijfplaats - vragen van velden met fields

Rule: wanneer één of meerdere adresregel velden voor een adres wordt gevraagd, dan wordt altijd de waarde van 'straatnaam (11.10)' en 'huisnummer (11.20)' geleverd

  Scenario: persoon heeft een adres met alleen een straatnaam en huisnummer als verblijfplaats en adresregel1 wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10)       | huisnummer (11.20) |
    | 0518                 | Jonkheer van Riemsdijkln | 88                 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel1             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam       | waarde                   |
    | straat     | Jonkheer van Riemsdijkln |
    | huisnummer | 88                       |

  Scenario: persoon heeft een adres met straatnaam, huisnummer en huisletter als verblijfplaats en adresregel1 wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) |
    | 0518                 | Borgesiusstraat    | 103                | c                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel1             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam       | waarde          |
    | straat     | Borgesiusstraat |
    | huisnummer | 103             |
    | huisletter | c               |

  Abstract Scenario: persoon heeft een adres met straatnaam, huisnummer en huisnummertoevoeging als verblijfplaats en adresregel1 wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10)    | huisnummer (11.20) | huisnummertoevoeging (11.40) |
    | 0518                 | Daniël Stalpertstraat | 35                 | <huisnummertoevoeging>       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel1             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                 |
    | straat               | Daniël Stalpertstraat  |
    | huisnummer           | 35                     |
    | huisnummertoevoeging | <huisnummertoevoeging> |

    Voorbeelden:
    | huisnummertoevoeging |
    | III                  |
    | 2                    |

  Abstract Scenario: persoon heeft een adres met straatnaam, huisnummer en aanduiding bij huisnummer als verblijfplaats en adresregel1 wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | aanduiding bij huisnummer (11.50) |
    | 0518                 | Graan voor Visch   | 15201              | <aanduiding bij huisnummer>       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel1             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde                                   |
    | straat                               | Graan voor Visch                         |
    | huisnummer                           | 15201                                    |
    | aanduidingBijHuisnummer.code         | <aanduiding bij huisnummer>              |
    | aanduidingBijHuisnummer.omschrijving | <omschrijving aanduiding bij huisnummer> |

    Voorbeelden:
    | aanduiding bij huisnummer | omschrijving aanduiding bij huisnummer |
    | by                        | bij                                    |
    | to                        | tegenover                              |

  Scenario: persoon heeft een adres met postcode en woonplaats als verblijfplaats en adresregel2 wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) |
    | 0518                 | een straat         | 1                  | 2583XL           | Scheveningen       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel2             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                 | waarde        |
    | gemeenteVanInschrijving.code         | 0518          |
    | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam       | waarde       |
    | straat     | een straat   |
    | huisnummer | 1            |
    | postcode   | 2583XL       |
    | woonplaats | Scheveningen |

  Scenario: persoon heeft een adres met postcode en zonder woonplaats als verblijfplaats en adresregel2 wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
    | 0518                 | een straat         | 1                  | 2584BZ           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel2             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                 | waarde        |
    | gemeenteVanInschrijving.code         | 0518          |
    | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam       | waarde     |
    | straat     | een straat |
    | huisnummer | 1          |
    | postcode   | 2584BZ     |

  Abstract Scenario: persoon heeft een adres als verblijfplaats en <veld> wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10)       | huisnummer (11.20) |
    | 0518                 | Jonkheer van Riemsdijkln | 88                 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.<veld>                  |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam       | waarde                   |
    | straat     | Jonkheer van Riemsdijkln |
    | huisnummer | 88                       |

    Voorbeelden:
    | veld        |
    | adresregel3 |
    | land        |

  Scenario: persoon heeft een adres met een lege straatnaam
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
    | 0518                 |                    | 88                 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                                                                                   |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum                                                      |
    | geslachtsnaam | Maassen                                                                                  |
    | geboortedatum | 1983-05-26                                                                               |
    | fields        | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam       | waarde |
    | huisnummer | 88     |

  Abstract Scenario: persoon heeft een adres met <omschrijving>
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
    | 0518                 | <straatnaam>       | <huisnummer>       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                                                                                   |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum                                                      |
    | geslachtsnaam | Maassen                                                                                  |
    | geboortedatum | 1983-05-26                                                                               |
    | fields        | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam       | waarde       |
    | straat     | <straatnaam> |
    | huisnummer | <huisnummer> |

    Voorbeelden:
    | straatnaam               | huisnummer | omschrijving                       |
    | .                        | 88         | een straatnaam met standaardwaarde |
    | Jonkheer van Riemsdijkln | 0          | een huisnummer met standaardwaarde |

Rule: wanneer één of meerdere adresregel velden voor een adres wordt gevraagd en de categorie verblijfplaats (08) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: persoon heeft adres als verblijfplaats, '<type>' is in onderzoek en één of meerdere adresregel velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | <aanduiding in onderzoek>       | 20020701                       |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
    | 0518                 | .                  | 0                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | straat                                    | .                         |
    | huisnummer                                | 0                         |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | aanduiding in onderzoek | type                               | fields                                                                                   |
    | 080000                  | hele categorie verblijfplaats      | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    | 080900                  | hele groep gemeente                | adressering.adresregel1                                                                  |
    | 080910                  | gemeente van inschrijving          | adressering.adresregel2                                                                  |
    | 081000                  | hele groep adreshouding            | adressering.adresregel3                                                                  |
    | 081010                  | functie adres                      | adressering.land                                                                         |
    | 081030                  | datum aanvang adreshouding         | adressering.adresregel1,adressering.adresregel2                                          |
    | 081100                  | hele groep adres                   | adressering.adresregel1,adressering.adresregel3                                          |
    | 081110                  | straatnaam                         | adressering.adresregel1,adressering.land                                                 |
    | 081115                  | naam openbare ruimte               | adressering.adresregel2,adressering.adresregel3                                          |
    | 081120                  | huisnummer                         | adressering.adresregel2,adressering.land                                                 |
    | 081130                  | huisletter                         | adressering.adresregel3,adressering.land                                                 |
    | 081140                  | huinummertoevoeging                | adressering.adresregel1                                                                  |
    | 081150                  | aanduiding bij huisnummer          | adressering.adresregel2                                                                  |
    | 081160                  | postcode                           | adressering.adresregel3                                                                  |
    | 081170                  | woonplaatsnaam                     | adressering.land                                                                         |
    | 081180                  | identificatiecode verblijfplaats   | adressering.adresregel1,adressering.adresregel2                                          |
    | 081190                  | identificatiecode nummeraanduiding | adressering.adresregel1,adressering.adresregel3                                          |
    | 088500                  | hele groep geldigheid              | adressering.adresregel1,adressering.land                                                 |
    | 088510                  | datum ingang geldigheid            | adressering.adresregel2,adressering.adresregel3                                          |

Rule: wanneer één of meerdere adresregel velden voor een locatie wordt gevraagd, dan wordt altijd de waarde van 'locatiebeschrijving (12.10)' geleverd

  Scenario: persoon heeft een locatie als verblijfplaats en adresregel1 wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10)       |
    | 0518                 | Woonboot tegenover de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel1             |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam                | waarde                            |
    | locatiebeschrijving | Woonboot tegenover de Grote Sloot |

  Scenario: persoon heeft een locatie als verblijfplaats en adresregel2 wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10)       |
    | 0518                 | Woonboot tegenover de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel2             |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                                 | waarde        |
    | gemeenteVanInschrijving.code         | 0518          |
    | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam                | waarde                            |
    | locatiebeschrijving | Woonboot tegenover de Grote Sloot |

  Abstract Scenario: persoon heeft een locatie als verblijfplaats en <veld> wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10)       |
    | 0518                 | Woonboot tegenover de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.<veld>                  |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                                 | waarde        |
    | gemeenteVanInschrijving.code         | 0518          |
    | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam                | waarde                            |
    | locatiebeschrijving | Woonboot tegenover de Grote Sloot |

    Voorbeelden:
    | veld        |
    | adresregel3 |
    | land        |

Rule: wanneer één of meerdere adresregel velden voor een locatie wordt gevraagd en de categorie verblijfplaats (08) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: persoon heeft locatie als verblijfplaats, '<type>' is in onderzoek en één of meerdere adresregel velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | <aanduiding in onderzoek>       | 20020701                       |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10)       |
    | 0518                 | Woonboot tegenover de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                            |
    | locatiebeschrijving                       | Woonboot tegenover de Grote Sloot |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek>         |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                          |

    Voorbeelden:
    | aanduiding in onderzoek | type                          | fields                                                                                   |
    | 080000                  | hele categorie verblijfplaats | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    | 080900                  | hele groep gemeente           | adressering.adresregel1                                                                  |
    | 080910                  | gemeente van inschrijving     | adressering.adresregel2                                                                  |
    | 081000                  | hele groep adreshouding       | adressering.adresregel3                                                                  |
    | 081010                  | functie adres                 | adressering.land                                                                         |
    | 081030                  | datum aanvang adreshouding    | adressering.adresregel1,adressering.adresregel2                                          |
    | 081200                  | hele groep locatie            | adressering.adresregel1,adressering.adresregel3                                          |
    | 081210                  | locatiebeschrijving           | adressering.adresregel1,adressering.land                                                 |
    | 088500                  | hele groep geldigheid         | adressering.adresregel2,adressering.adresregel3                                          |
    | 088510                  | datum ingang geldigheid       | adressering.adresregel2,adressering.land                                                 |

Rule: wanneer één of meerdere adresregel velden voor een verblijfplaats buitenland wordt gevraagd, dan wordt altijd alle verblijfplaats buitenland velden geleverd

  Abstract Scenario: persoon heeft een verblijfplaats buitenland
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.<veld>                  |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam              | waarde          |
    | land.code         | 5010            |
    | land.omschrijving | België          |
    | regel1            | Rue du pomme 26 |
    | regel2            | Bruxelles       |
    | regel3            | postcode 1000   |

    Voorbeelden:
    | veld        |
    | adresregel1 |
    | adresregel2 |
    | adresregel3 |
    | land        |

  Abstract Scenario: persoon heeft een verblijfplaats buitenland en 'land (13.10)' heeft de standaardwaarde
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 0000         | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.<veld>                  |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam              | waarde          |
    | land.code         | 0000            |
    | land.omschrijving | Onbekend        |
    | regel1            | Rue du pomme 26 |
    | regel2            | Bruxelles       |
    | regel3            | postcode 1000   |

    Voorbeelden:
    | veld        |
    | adresregel1 |
    | adresregel2 |
    | adresregel3 |
    | land        |

  Scenario: persoon heeft een verblijfplaats buitenland en 'regel 1 adres buitenland (13.30)', 'regel 2 adres buitenland (13.40)' en 'regel 3 adres buitenland (13.50)' hebben de standaardwaarde
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         |                                  |                                  |                                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.<veld>                  |
    Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
    | naam              | waarde |
    | land.code         | 5010   |
    | land.omschrijving | België |

    Voorbeelden:
    | veld        |
    | adresregel1 |
    | adresregel2 |
    | adresregel3 |
    | land        |

Rule: wanneer één of meerdere adresregel velden voor een verblijfplaats buitenland wordt gevraagd en de categorie verblijfplaats (08) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: persoon heeft een verblijfplaats buitenland, '<type>' is in onderzoek en één of meerdere adresregel velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Maassen               | 19830526              |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0000         | <aanduiding in onderzoek>       | 20020701                       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | land.code                                 | 0000                      |
    | land.omschrijving                         | Onbekend                  |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | aanduiding in onderzoek | type                           | fields                                                                                   |
    | 080000                  | hele categorie verblijfplaats  | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    | 081300                  | hele groep adres buitenland    | adressering.adresregel1                                                                  |
    | 081310                  | land adres buitenland          | adressering.adresregel2                                                                  |
    | 081320                  | datum aanvang adres buitenland | adressering.adresregel3                                                                  |
    | 081330                  | regel 1 adres buitenland       | adressering.land                                                                         |
    | 081340                  | regel 2 adres buitenland       | adressering.adresregel1,adressering.adresregel2                                          |
    | 081350                  | regel 3 adres buitenland       | adressering.adresregel1,adressering.adresregel3                                          |
    | 088500                  | hele groep geldigheid          | adressering.adresregel1,adressering.land                                                 |
    | 088510                  | datum ingang geldigheid        | adressering.adresregel1,adressering.adresregel2                                          |
