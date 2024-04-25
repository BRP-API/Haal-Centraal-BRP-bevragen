#language: nl

@gba
Functionaliteit: GbaPersoon: Raadplegen van afgevoerde persoonslijst

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 0123456789      | William           | de                  | Vries                 | 20040526              | M                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) | Europees kiesrecht (31.10) | einddatum uitsluiting Europees kiesrecht (31.30) |
    | 20220829                             | F                                    | 1                          | 20270101                                         |
    En de persoon heeft een ouder '1' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 000000036                   | Corry             | van                 | Zon                   | 19730428              | V                           |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 20040603                        |
    En de persoon heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | soort verbintenis (15.10) | voornamen (02.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | 234567890                   | H                         | Jan               | 20120401                                                           |
    En de persoon heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
    | 20020701                 | 0518                      | 6030                    |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) | datum aanvang adreshouding (10.30) | gemeente van inschrijving (09.10) | land vanwaar ingeschreven (14.10) | datum vestiging in Nederland (14.20) |
    | W                     | 20170423                           | 0518                              | 6014                              | 19630718                             |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
    | 0518                 | Spui               | 70                 | 1234AA           |
    En de persoon heeft een 'kind' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) |
    | 123456789                   | Daan              |
    En de persoon heeft de volgende 'verblijfstitel' gegevens
    | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) |
    | 37                                | 20210315                            |
    En de persoon heeft de volgende 'gezagsverhouding' gegevens
    | indicatie gezag minderjarige (32.10) | indicatie curateleregister (33.10) |
    | 12                                   | 1                                  |
    

Regel: bij het raadplegen van een persoon met afgevoerde persoonslijst wordt de reden en datum opschorting geleverd en indien gevraagd de aNummer en/of burgerservicenummer
  Overige gegevens op de afgevoerde persoonslijst worden niet geleverd

  Abstract Scenario: geraadpleegde persoon is opgeschort met reden "F" (fout) en er is gevraagd om <fields>
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                   |
    | type                | RaadpleegMetBurgerservicenummer                                                          |
    | burgerservicenummer | 000000024                                                                                |
    | fields              | aNummer,burgerservicenummer,naam,geboorte,geslacht,ouders,nationaliteiten,verblijfplaats |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde     |
    | aNummer             | 0123456789 |
    | burgerservicenummer | 000000024  |
    En heeft de persoon de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde   |
    | reden.code         | F        |
    | reden.omschrijving | fout     |
    | datum              | 20220829 |

    Voorbeelden:
    | fields                                                                                                    |
    | aNummer,burgerservicenummer                                                                               |
    | aNummer,burgerservicenummer,naam,geboorte,leeftijd,geslacht                                               |
    | aNummer,burgerservicenummer,ouders,nationaliteiten,partners                                               |
    | aNummer,burgerservicenummer,overlijden,datumEersteInschrijvingGBA                                         |
    | aNummer,burgerservicenummer,verblijfplaats,gemeenteVanInschrijving,datumInschrijvingInGemeente,immigratie |
    | aNummer,burgerservicenummer,kinderen,indicatieGezagMinderjarige,indicatieCurateleRegister                 |
    | aNummer,burgerservicenummer,verblijfstitel,europeesKiesrecht,uitsluitingKiesrecht                         |
    | aNummer,burgerservicenummer,adressering                                                                   |
    | aNummer,burgerservicenummer,adresseringBinnenland                                                         |
    | aNummer,burgerservicenummer,verblijfplaatsBinnenland                                                      |
    | aNummer,burgerservicenummer,verblijfplaats.datumVan.datum,verblijfplaats.verblijfadres.woonplaats         |
    | naam,aNummer,geboorte,leeftijd,burgerservicenummer,geslacht                                               |

  Scenario: geraadpleegde persoon is opgeschort met reden "F" (fout) en er is gevraagd om burgerservicenummer,naam,geboorte,geslacht,ouders,nationaliteiten,verblijfplaats
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000024                                                                        |
    | fields              | burgerservicenummer,naam,geboorte,geslacht,ouders,nationaliteiten,verblijfplaats |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000024 |
    En heeft de persoon de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde   |
    | reden.code         | F        |
    | reden.omschrijving | fout     |
    | datum              | 20220829 |

  Abstract Scenario: geraadpleegde persoon is opgeschort met reden "F" (fout) en er is gevraagd om <fields>
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde   |
    | reden.code         | F        |
    | reden.omschrijving | fout     |
    | datum              | 20220829 |

    Voorbeelden:
    | fields                                                                        |
    | naam,geboorte,leeftijd,geslacht                                               |
    | ouders,nationaliteiten,partners                                               |
    | overlijden,datumEersteInschrijvingGBA                                         |
    | verblijfplaats,gemeenteVanInschrijving,datumInschrijvingInGemeente,immigratie |
    | kinderen,indicatieGezagMinderjarige,indicatieCurateleRegister                 |
    | verblijfstitel,europeesKiesrecht,uitsluitingKiesrecht                         |
    | adressering                                                                   |
    | adresseringBinnenland                                                         |
    | verblijfplaatsBinnenland                                                      |
    | verblijfplaats.datumVan.datum,verblijfplaats.verblijfadres.woonplaats         |

  Abstract Scenario: geraadpleegde persoon is opgeschort met andere reden dan "F"
    Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
    | voornamen (02.10) |
    | William           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden>                              |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000048                       |
    | fields              | naam                            |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde         |
    | reden.code         | <reden>        |
    | reden.omschrijving | <omschrijving> |
    | datum              | 20220829       |
    En heeft de persoon de volgende 'naam' gegevens
    | naam      | waarde  |
    | voornamen | William |

    Voorbeelden:
    | reden | omschrijving              |
    | O     | overlijden                |
    | E     | emigratie                 |
    | M     | ministerieel besluit      |
    | R     | pl is aangelegd in de rni |
