#language: nl

Functionaliteit: Opschorting bijhouding

Rule: bij raadplegen van een persoon op burgerservicenummer van een afgevoerde persoonslijst wordt maximaal burgerservicenummer en opschorting bijhouding geleverd
  - wanneer reden opschorting bijhouding (07.67.20) is opgenomen met de waarde "F" (fout), wordt 
      - ten minste opschortingBijhouding.reden geleverd
      - en indien gevraagd in fields ook aNummer, burgerservicenummer en opschortingBijhouding.datum

  Scenario: Raadpleeg persoon op afgevoerde persoonslijst levert alleen gevraagde aNummer, burgerservicenummer en opschorting
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 0123456789      | William           | de                  | Vries                 | 20040526              | M                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft een ouder '1' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 000000036                   | Corry             | van                 | Zon                   | 19730428              | V                           |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 20040603                        |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) | datum aanvang adreshouding (10.30) | gemeente van inschrijving (09.10) |
    | W                     | 20170423                           | 0518                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
    | 0518          | Spui               | 70                 | 1234AA           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                          |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                 |
    | burgerservicenummer | 000000024                                                                                                                                       |
    | fields              | aNummer,burgerservicenummer,naam,geboorte,leeftijd,geslacht,ouders,nationaliteiten,verblijfplaats,gemeenteVanInschrijving,opschortingBijhouding |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde           |
    | aNummer                                  | 0123456789       |
    | burgerservicenummer                      | 000000024        |
    | opschortingBijhouding.reden.code         | F                |
    | opschortingBijhouding.reden.omschrijving | fout             |
    | opschortingBijhouding.datum.type         | Datum            |
    | opschortingBijhouding.datum.datum        | 2022-08-29       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022 |

  Scenario: Raadpleeg persoon op afgevoerde persoonslijst levert alleen opschorting reden
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 0123456789      | William           | de                  | Vries                 | 20040526              | M                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft een ouder '1' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 000000036                   | Corry             | van                 | Zon                   | 19730428              | V                           |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 20040603                        |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) | datum aanvang adreshouding (10.30) | gemeente van inschrijving (09.10) |
    | W                     | 20170423                           | 0518                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
    | 0518          | Spui               | 70                 | 1234AA           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                        |
    | type                | RaadpleegMetBurgerservicenummer                                                               |
    | burgerservicenummer | 000000024                                                                                     |
    | fields              | naam,geboorte,leeftijd,geslacht,ouders,nationaliteiten,verblijfplaats,gemeenteVanInschrijving |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde |
    | opschortingBijhouding.reden.code         | F      |
    | opschortingBijhouding.reden.omschrijving | fout   |

Rule: een afgevoerde persoonslijst moet niet worden gevonden
  - wanneer reden opschorting bijhouding (07.67.20) is opgenomen met de waarde "F" (fout), moet deze persoon(slijst) niet worden gevonden bij zoeken

  Scenario: Zoek met geslachtsnaam en geboortedatum van persoon op afgevoerde persoonslijst
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Isnietgoed            | 19781103              |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Isnietgoed                          |
    | geboortedatum              | 1978-11-03                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response 0 personen

  Abstract Scenario: Zoek met geslachtsnaam en geboortedatum van persoon op opgeschorte persoonslijst wegens "<reden opschorting omschrijving>"
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Iswelgoed             | 19781103              |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Iswelgoed                           |
    | geboortedatum              | 1978-11-03                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving       |
    | O                            | overlijden                           |
    | E                            | emigratie                            |
    | M                            | ministerieel besluit                 |
    | R                            | persoonslijst is aangelegd in de rni |
    | .                            | onbekend                             |

  Scenario: Zoek met voornaam, geslachtsnaam en gemeente van inschrijving van persoon op afgevoerde persoonslijst
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) |
    | Jan Peter         | Isnietgoed            |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam              | Isnietgoed                           |
    | voornamen                  | Jan Peter                            |
    | gemeenteVanInschrijving    | 0530                                 |
    | inclusiefOverledenPersonen | true                                 |
    | fields                     | burgerservicenummer                  |
    Dan heeft de response 0 personen

  Abstract Scenario: Zoek met voornaam, geslachtsnaam en gemeente van inschrijving van persoon op opgeschorte persoonslijst wegens "<reden opschorting omschrijving>"
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) |
    | Jan Peter         | Iswelgoed             |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam              | Iswelgoed                            |
    | voornamen                  | Jan Peter                            |
    | gemeenteVanInschrijving    | <gemeente van inschrijving>          |
    | inclusiefOverledenPersonen | true                                 |
    | fields                     | burgerservicenummer                  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

    Voorbeelden:
    | gemeente van inschrijving | reden opschorting bijhouding | reden opschorting omschrijving       |
    | 0530                      | O                            | overlijden                           |
    | 0530                      | E                            | emigratie                            |
    | 0530                      | M                            | ministerieel besluit                 |
    | 0530                      | R                            | persoonslijst is aangelegd in de rni |
    | 0530                      | .                            | onbekend                             |

  Scenario: Zoek met nummeraanduidingIdentificatie van persoon op afgevoerde persoonslijst
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | identificatiecode nummeraanduiding (11.90) |
    | 0530          | 0599200000219679                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219679                     |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 0 personen

  Abstract Scenario: Zoek met nummeraanduidingIdentificatie van persoon op opgeschorte persoonslijst wegens "<reden opschorting omschrijving>"
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | identificatiecode nummeraanduiding (11.90) |
    | 0530          | 0599200000219679                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219679                     |
    | inclusiefOverledenPersonen    | true                                 |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving |
    | O                            | overlijden                     |
    | E                            | emigratie                      |
    | M                            | ministerieel besluit           |
    | .                            | onbekend                       |

  Scenario: Zoek met postcode en huisnummer van persoon op afgevoerde persoonslijst
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) |
    | 0530          | 1628HJ           | 31                 |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 1628HJ                      |
    | huisnummer | 31                          |
    | fields     | burgerservicenummer         |
    Dan heeft de response 0 personen

  Abstract Scenario: Zoek met postcode en huisnummer van persoon op opgeschorte persoonslijst wegens "<reden opschorting omschrijving>"
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) |
    | 0530          | 1628HJ           | 31                 |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                      |
    | type                       | ZoekMetPostcodeEnHuisnummer |
    | postcode                   | 1628HJ                      |
    | huisnummer                 | 31                          |
    | inclusiefOverledenPersonen | true                        |
    | fields                     | burgerservicenummer         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving |
    | O                            | overlijden                     |
    | E                            | emigratie                      |
    | M                            | ministerieel besluit           |
    | .                            | onbekend                       |

  Scenario: Zoek met straatnaam, huisnummer en gemeente van inschrijving van persoon op afgevoerde persoonslijst
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0518                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | straatnaam (11.10)  | huisnummer (11.20) |
    | 0518          | Haagse Reigerstraat | 31                 |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                                           |
    | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | gemeenteVanInschrijving    | 0518                                             |
    | straat                     | Haagse Reigerstraat                              |
    | huisnummer                 | 31                                               |
    | inclusiefOverledenPersonen | true                                             |
    | fields                     | burgerservicenummer                              |
    Dan heeft de response 0 personen

  Abstract Scenario: Zoek met postcode en huisnummer van persoon op opgeschorte persoonslijst wegens "<reden opschorting omschrijving>"
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0518                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | straatnaam (11.10)  | huisnummer (11.20) |
    | 0518          | Haagse Reigerstraat | 31                 |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                                           |
    | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | gemeenteVanInschrijving    | 0518                                             |
    | straat                     | Haagse Reigerstraat                              |
    | huisnummer                 | 31                                               |
    | inclusiefOverledenPersonen | true                                             |
    | fields                     | burgerservicenummer                              |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving |
    | O                            | overlijden                     |
    | E                            | emigratie                      |
    | M                            | ministerieel besluit           |
    | .                            | onbekend                       |
