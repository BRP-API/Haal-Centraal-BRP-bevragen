#language: nl

Functionaliteit: Persoon beperkt: Opschorting bijhouding

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | William           | de                  | Vries                 | 20040526              | M                           |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) | postcode (11.60) | huisnummer (11.20) | straatnaam (11.10)  |
    | 0530                 | 0599200000219679                           | 1628HJ           | 31                 | Haagse Reigerstraat |

Regel: personen met afgevoerde persoonslijst worden niet gevonden bij het zoeken

  Abstract Scenario: persoon opgeschort met reden "F" (fout) wordt gezocht met geslachtsnaam en geboortedatum <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Vries                               |
    | geboortedatum              | 2004-05-26                          |
    | inclusiefOverledenPersonen | <inclusief overleden personen>      |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "F" (fout) wordt gezocht met geslachtsnaam, voornamen en gemeente van inschrijving <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam              | Vries                                |
    | voornamen                  | William                              |
    | gemeenteVanInschrijving    | 0530                                 |
    | inclusiefOverledenPersonen | <inclusief overleden personen>       |
    | fields                     | burgerservicenummer                  |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "F" (fout) wordt gezocht met nummeraanduiding identificatie <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219679                     |
    | inclusiefOverledenPersonen    | <inclusief overleden personen>       |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "F" (fout) wordt gezocht met postcode en huisnummer <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                         |
    | type                       | ZoekMetPostcodeEnHuisnummer    |
    | postcode                   | 1628HJ                         |
    | huisnummer                 | 31                             |
    | inclusiefOverledenPersonen | <inclusief overleden personen> |
    | fields                     | burgerservicenummer            |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "F" (fout) wordt gezocht met straat, huisnummer en gemeente van inschrijving <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                                           |
    | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | gemeenteVanInschrijving    | 0530                                             |
    | straat                     | Haagse Reigerstraat                              |
    | huisnummer                 | 31                                               |
    | inclusiefOverledenPersonen | <inclusief overleden personen>                   |
    | fields                     | burgerservicenummer                              |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |


Regel: personen op een logisch verwijderde persoonslijst worden niet gevonden bij het zoeken

  Abstract Scenario: persoon opgeschort met reden "W" (wissen) wordt gezocht met geslachtsnaam en geboortedatum <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | W                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Vries                               |
    | geboortedatum              | 2004-05-26                          |
    | inclusiefOverledenPersonen | <inclusief overleden personen>      |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "W" (wissen) wordt gezocht met geslachtsnaam, voornamen en gemeente van inschrijving <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | W                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam              | Vries                                |
    | voornamen                  | William                              |
    | gemeenteVanInschrijving    | 0530                                 |
    | inclusiefOverledenPersonen | <inclusief overleden personen>       |
    | fields                     | burgerservicenummer                  |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "W" (wissen) wordt gezocht met nummeraanduiding identificatie <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | W                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219679                     |
    | inclusiefOverledenPersonen    | <inclusief overleden personen>       |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "W" (wissen) wordt gezocht met postcode en huisnummer <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | W                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                         |
    | type                       | ZoekMetPostcodeEnHuisnummer    |
    | postcode                   | 1628HJ                         |
    | huisnummer                 | 31                             |
    | inclusiefOverledenPersonen | <inclusief overleden personen> |
    | fields                     | burgerservicenummer            |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "W" (wissen) wordt gezocht met straat, huisnummer en gemeente van inschrijving <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | W                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                                           |
    | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | gemeenteVanInschrijving    | 0530                                             |
    | straat                     | Haagse Reigerstraat                              |
    | huisnummer                 | 31                                               |
    | inclusiefOverledenPersonen | <inclusief overleden personen>                   |
    | fields                     | burgerservicenummer                              |
    Dan heeft de response 0 personen

    Voorbeelden:
    | inclusief overleden personen | zoek overleden personen type |
    | true                         | inclusief                    |
    | false                        | exclusief                    |


Regel: De optionele 'inclusiefOverledenPersonen' parameter moet worden opgegeven om een overleden persoon te kunnen vinden

  Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met geslachtsnaam en geboortedatum exclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Vries                               |
    | geboortedatum | 2004-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 0 personen

  Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met geslachtsnaam en geboortedatum inclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Vries                               |
    | geboortedatum              | 2004-05-26                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde           |
    | burgerservicenummer                      | 000000024        |
    | opschortingBijhouding.reden.code         | O                |
    | opschortingBijhouding.reden.omschrijving | overlijden       |
    | opschortingBijhouding.datum.type         | Datum            |
    | opschortingBijhouding.datum.datum        | 2022-08-29       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022 |

  Abstract Scenario: persoon opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) wordt gezocht met geslachtsnaam en geboortedatum <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Vries                               |
    | geboortedatum              | 2004-05-26                          |
    | inclusiefOverledenPersonen | <inclusief overleden personen>      |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
    | opschortingBijhouding.datum.type         | Datum                            |
    | opschortingBijhouding.datum.datum        | 2022-08-29                       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022                 |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving | inclusief overleden personen | zoek overleden personen type |
    | E                            | emigratie                      | true                         | inclusief                    |
    | M                            | ministerieel besluit           | true                         | inclusief                    |
    | R                            | pl is aangelegd in de rni      | true                         | inclusief                    |
    | .                            | onbekend                       | true                         | inclusief                    |
    | E                            | emigratie                      | false                        | exclusief                    |
    | M                            | ministerieel besluit           | false                        | exclusief                    |
    | R                            | pl is aangelegd in de rni      | false                        | exclusief                    |
    | .                            | onbekend                       | false                        | exclusief                    |

  Scenario: persoon opgeschort met reden O" (overlijden) wordt gezocht met geslachtsnaam, voornamen en gemeente van inschrijving exclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | Vries                                |
    | voornamen               | William                              |
    | gemeenteVanInschrijving | 0530                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response 0 personen

  Scenario: persoon opgeschort met reden O" (overlijden) wordt gezocht met geslachtsnaam, voornamen en gemeente van inschrijving inclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam              | Vries                                |
    | voornamen                  | William                              |
    | gemeenteVanInschrijving    | 0530                                 |
    | inclusiefOverledenPersonen | true                                 |
    | fields                     | burgerservicenummer                  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde           |
    | burgerservicenummer                      | 000000024        |
    | opschortingBijhouding.reden.code         | O                |
    | opschortingBijhouding.reden.omschrijving | overlijden       |
    | opschortingBijhouding.datum.type         | Datum            |
    | opschortingBijhouding.datum.datum        | 2022-08-29       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022 |

  Abstract Scenario: persoon opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) wordt gezocht met geslachtsnaam, voornamen en gemeente van inschrijving <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam              | Vries                                |
    | voornamen                  | William                              |
    | gemeenteVanInschrijving    | 0530                                 |
    | inclusiefOverledenPersonen | <inclusief overleden personen>       |
    | fields                     | burgerservicenummer                  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
    | opschortingBijhouding.datum.type         | Datum                            |
    | opschortingBijhouding.datum.datum        | 2022-08-29                       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022                 |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving | inclusief overleden personen | zoek overleden personen type |
    | E                            | emigratie                      | true                         | inclusief                    |
    | M                            | ministerieel besluit           | true                         | inclusief                    |
    | R                            | pl is aangelegd in de rni      | true                         | inclusief                    |
    | .                            | onbekend                       | true                         | inclusief                    |
    | E                            | emigratie                      | false                        | exclusief                    |
    | M                            | ministerieel besluit           | false                        | exclusief                    |
    | R                            | pl is aangelegd in de rni      | false                        | exclusief                    |
    | .                            | onbekend                       | false                        | exclusief                    |

  Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met nummeraanduiding identificatie exclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219679                     |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 0 personen

  Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met nummeraanduiding identificatie inclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219679                     |
    | inclusiefOverledenPersonen    | true                                 |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde           |
    | burgerservicenummer                      | 000000024        |
    | opschortingBijhouding.reden.code         | O                |
    | opschortingBijhouding.reden.omschrijving | overlijden       |
    | opschortingBijhouding.datum.type         | Datum            |
    | opschortingBijhouding.datum.datum        | 2022-08-29       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022 |

  Abstract Scenario: persoon opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) wordt gezocht met nummeraanduiding identificatie <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219679                     |
    | inclusiefOverledenPersonen    | <inclusief overleden personen>       |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
    | opschortingBijhouding.datum.type         | Datum                            |
    | opschortingBijhouding.datum.datum        | 2022-08-29                       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022                 |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving | inclusief overleden personen | zoek overleden personen type |
    | E                            | emigratie                      | true                         | inclusief                    |
    | M                            | ministerieel besluit           | true                         | inclusief                    |
    | R                            | pl is aangelegd in de rni      | true                         | inclusief                    |
    | .                            | onbekend                       | true                         | inclusief                    |
    | E                            | emigratie                      | false                        | exclusief                    |
    | M                            | ministerieel besluit           | false                        | exclusief                    |
    | R                            | pl is aangelegd in de rni      | false                        | exclusief                    |
    | .                            | onbekend                       | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met postcode en huisnummer exclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 1628HJ                      |
    | huisnummer | 31                          |
    | fields     | burgerservicenummer         |
    Dan heeft de response 0 personen

  Abstract Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met postcode en huisnummer inclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                      |
    | type                       | ZoekMetPostcodeEnHuisnummer |
    | postcode                   | 1628HJ                      |
    | huisnummer                 | 31                          |
    | inclusiefOverledenPersonen | true                        |
    | fields                     | burgerservicenummer         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde           |
    | burgerservicenummer                      | 000000024        |
    | opschortingBijhouding.reden.code         | O                |
    | opschortingBijhouding.reden.omschrijving | overlijden       |
    | opschortingBijhouding.datum.type         | Datum            |
    | opschortingBijhouding.datum.datum        | 2022-08-29       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022 |

  Abstract Scenario: persoon opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) wordt gezocht met postcode en huisnummer <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                         |
    | type                       | ZoekMetPostcodeEnHuisnummer    |
    | postcode                   | 1628HJ                         |
    | huisnummer                 | 31                             |
    | inclusiefOverledenPersonen | <inclusief overleden personen> |
    | fields                     | burgerservicenummer            |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
    | opschortingBijhouding.datum.type         | Datum                            |
    | opschortingBijhouding.datum.datum        | 2022-08-29                       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022                 |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving | inclusief overleden personen | zoek overleden personen type |
    | E                            | emigratie                      | true                         | inclusief                    |
    | M                            | ministerieel besluit           | true                         | inclusief                    |
    | R                            | pl is aangelegd in de rni      | true                         | inclusief                    |
    | .                            | onbekend                       | true                         | inclusief                    |
    | E                            | emigratie                      | false                        | exclusief                    |
    | M                            | ministerieel besluit           | false                        | exclusief                    |
    | R                            | pl is aangelegd in de rni      | false                        | exclusief                    |
    | .                            | onbekend                       | false                        | exclusief                    |

  Abstract Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met straat, huisnummer en gemeente van inschrijving exclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | gemeenteVanInschrijving | 0530                                             |
    | straat                  | Haagse Reigerstraat                              |
    | huisnummer              | 31                                               |
    | fields                  | burgerservicenummer                              |
    Dan heeft de response 0 personen

  Abstract Scenario: persoon opgeschort met reden "O" (overlijden) wordt gezocht met straat, huisnummer en gemeente van inschrijving inclusief overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | O                                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                                           |
    | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | gemeenteVanInschrijving    | 0530                                             |
    | straat                     | Haagse Reigerstraat                              |
    | huisnummer                 | 31                                               |
    | inclusiefOverledenPersonen | true                                             |
    | fields                     | burgerservicenummer                              |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde           |
    | burgerservicenummer                      | 000000024        |
    | opschortingBijhouding.reden.code         | O                |
    | opschortingBijhouding.reden.omschrijving | overlijden       |
    | opschortingBijhouding.datum.type         | Datum            |
    | opschortingBijhouding.datum.datum        | 2022-08-29       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022 |

  Abstract Scenario: persoon opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) wordt gezocht met straat, huisnummer en gemeente van inschrijving <zoek overleden personen type> overleden personen
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                                           |
    | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | gemeenteVanInschrijving    | 0530                                             |
    | straat                     | Haagse Reigerstraat                              |
    | huisnummer                 | 31                                               |
    | inclusiefOverledenPersonen | <inclusief overleden personen>                   |
    | fields                     | burgerservicenummer                              |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
    | opschortingBijhouding.datum.type         | Datum                            |
    | opschortingBijhouding.datum.datum        | 2022-08-29                       |
    | opschortingBijhouding.datum.langFormaat  | 29 augustus 2022                 |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving | inclusief overleden personen | zoek overleden personen type |
    | E                            | emigratie                      | true                         | inclusief                    |
    | M                            | ministerieel besluit           | true                         | inclusief                    |
    | R                            | pl is aangelegd in de rni      | true                         | inclusief                    |
    | .                            | onbekend                       | true                         | inclusief                    |
    | E                            | emigratie                      | false                        | exclusief                    |
    | M                            | ministerieel besluit           | false                        | exclusief                    |
    | R                            | pl is aangelegd in de rni      | false                        | exclusief                    |
    | .                            | onbekend                       | false                        | exclusief                    |
