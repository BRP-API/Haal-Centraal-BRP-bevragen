#language: nl

Functionaliteit: samenstellen van adresregels

  Als consumer van de BRP bevragen API
  Wil ik dat de verblijfplaats gegevens van een persoon kan worden gevraagd conform NEN 5825:2002
  Zodat ik de adresgegevens van de persoon op de correcte manier kan gebruiken 

Regel: adresregel1 wordt voor een adres met alleen straatnaam en huisnummer als volgt samengesteld: '[straatnaam][spatie][huisnummer]'

  Scenario: persoon heeft een adres met alleen een straatnaam en huisnummer als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10)       | huisnummer (11.20) |
    | 0518                 | Jonkheer van Riemsdijkln | 88                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000188                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                      |
    | adresregel1 | Jonkheer van Riemsdijkln 88 |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer en huisletter als volgt samengesteld: '[straatnaam][spatie][huisnummer][spatie][huisletter]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer en huisletter als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000206' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) |
    | 0518                 | Borgesiusstraat    | 103                | c                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000206                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                |
    | adresregel1 | Borgesiusstraat 103 c |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer en huisnummertoevoeging die begint met een letter als volgt samengesteld: [straatnaam][spatie][huisnummer][spatie][huisnummertoevoeging]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer en huisnummertoevoeging die begint met een letter als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000218' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10)    | huisnummer (11.20) | huisnummertoevoeging (11.40) |
    | 0518                 | Daniël Stalpertstraat | 35                 | III                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000218                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                       |
    | adresregel1 | Daniël Stalpertstraat 35 III |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer en huisnummertoevoeging die begint met een cijfer als volgt samengesteld: [straatnaam][spatie][huisnummer]-[huisnummertoevoeging]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer en huisnummertoevoeging die begint met een cijfer als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisnummertoevoeging (11.40) |
    | 0518                 | Atatürkstraat      | 9                  | 2                            |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000231                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde            |
    | adresregel1 | Atatürkstraat 9-2 |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisletter en huisnummertoevoeging als volgt samengesteld: [straatnaam][spatie][huisnummer][spatie][huisletter][huisnummertoevoeging]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter en huisnummertoevoeging die begint met een letter als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000243' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) |
    | 0518                 | St. Jacobsstraat   | 400                | L                  | Toe                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000243                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                    |
    | adresregel1 | St. Jacobsstraat 400 LToe |

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter en huisnummertoevoeging die begint met een cijfer als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000255' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) |
    | 0518                 | Cronus             | 555                | B                  | 73c                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000255                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde          |
    | adresregel1 | Cronus 555 B73c |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer en aanduiding bij huisnummer 'by' als volgt samengesteld: [straatnaam][spatie]bij[spatie][huisnummer]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer en aanduiding bij huisnummer 'by' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | aanduiding bij huisnummer (11.50) |
    | 0518                 | Graan voor Visch   | 15201              | by                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000267                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                     |
    | adresregel1 | Graan voor Visch bij 15201 |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer en aanduiding bij huisnummer 'to' als volgt samengesteld: [straatnaam][spatie]t/o[spatie][huisnummer]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer en aanduiding bij huisnummer 'to' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | aanduiding bij huisnummer (11.50) |
    | 0518                 | 1e Exloërmond      | 3                  | to                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000279                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde              |
    | adresregel1 | 1e Exloërmond t/o 3 |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisletter en aanduiding bij huisnummer 'by' als volgt samengesteld: [straatnaam][spatie]bij[spatie][huisnummer][spatie][huisletter]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter en aanduiding bij huisnummer 'by' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | aanduiding bij huisnummer (11.50) |
    | 0518                 | Graan voor Visch   | 15201              | B                  | by                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000267                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                       |
    | adresregel1 | Graan voor Visch bij 15201 B |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisletter en aanduiding bij huisnummer 'to' als volgt samengesteld: [straatnaam][spatie]t/o[spatie][huisnummer][spatie][huisletter]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter en aanduiding bij huisnummer 'to' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | aanduiding bij huisnummer (11.50) |
    | 0518                 | 1e Exloërmond      | 3                  | B                  | to                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000279                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                |
    | adresregel1 | 1e Exloërmond t/o 3 B |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisnummertoevoeging die begint met een letter en aanduiding bij huisnummer 'by' als volgt samengesteld: [straatnaam][spatie]bij[spatie][huisnummer][spatie][huisnummertoevoeging]

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisnummertoevoeging die begint met een letter en aanduiding bij huisnummer 'by' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 0518                 | Graan voor Visch   | 15201              | III                          | by                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000267                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                         |
    | adresregel1 | Graan voor Visch bij 15201 III |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisnummertoevoeging die begint met een cijfer en aanduiding bij huisnummer 'by' als volgt samengesteld: [straatnaam][spatie]bij[spatie][huisnummer]-[huisnummertoevoeging]

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisnummertoevoeging die begint met een cijfer en aanduiding bij huisnummer 'by' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 0518                 | Graan voor Visch   | 15201              | 2                            | by                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000267                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                       |
    | adresregel1 | Graan voor Visch bij 15201-2 |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisnummertoevoeging die begint met een letter en aanduiding bij huisnummer 'to' als volgt samengesteld: [straatnaam][spatie]t/o[spatie][huisnummer][spatie][huisnummertoevoeging]

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisnummertoevoeging die begint met een letter en aanduiding bij huisnummer 'to' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 0518                 | 1e Exloërmond      | 3                  | III                          | to                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000279                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                  |
    | adresregel1 | 1e Exloërmond t/o 3 III |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisnummertoevoeging die begint met een cijfer en aanduiding bij huisnummer 'to' als volgt samengesteld: [straatnaam][spatie]t/o[spatie][huisnummer]-[huisnummertoevoeging]

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisnummertoevoeging die begint met een cijfer en aanduiding bij huisnummer 'to' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 0518                 | 1e Exloërmond      | 3                  | 2                            | to                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000279                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                |
    | adresregel1 | 1e Exloërmond t/o 3-2 |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisletter, huisnummertoevoeging en aanduiding bij huisnummer 'by' als volgt samengesteld: [straatnaam][spatie]bij[spatie][huisnummer][spatie][huisletter][huisnummertoevoeging]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter, huisnummertoevoeging die begint met een letter en aanduiding bij huisnummer 'by' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 0518                 | Graan voor Visch   | 15201              | L                  | III                          | by                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000267                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                          |
    | adresregel1 | Graan voor Visch bij 15201 LIII |

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter, huisnummertoevoeging die begint met een cijfer en aanduiding bij huisnummer 'by' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 0518                 | Graan voor Visch   | 15201              | L                  | 2                            | by                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000267                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                        |
    | adresregel1 | Graan voor Visch bij 15201 L2 |

Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisletter, huisnummertoevoeging en aanduiding bij huisnummer 'to' als volgt samengesteld: [straatnaam][spatie]t/o[spatie][huisnummer][spatie][huisletter][huisnummertoevoeging]'

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter, huisnummertoevoeging die begint met een letter en aanduiding bij huisnummer 'to' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 0518                 | 1e Exloërmond      | 3                  | L                  | III                          | to                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000279                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                   |
    | adresregel1 | 1e Exloërmond t/o 3 LIII |

  Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter, huisnummertoevoeging die begint met een cijfer en aanduiding bij huisnummer 'to' als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) |
    | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 0518                 | 1e Exloërmond      | 3                  | L                  | 2                            | to                                |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000279                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                 |
    | adresregel1 | 1e Exloërmond t/o 3 L2 |

Regel: adresregel1 wordt voor een locatie gevuld met de locatiebeschrijving

  Scenario: persoon heeft een locatie als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10)       |
    | 0518                 | Woonboot tegenover de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000309                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                            |
    | adresregel1 | Woonboot tegenover de Grote Sloot |

Regel: adresregel2 wordt voor een adres met postcode en woonplaats als volgt samengesteld: [postcode numeriek deel][spatie][postcode alfabetisch deel][2 spaties][woonplaats in hoofdletters]

  Scenario: persoon heeft een adres met postcode en woonplaats als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000310' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) |
    | 0518                 | een straat         | 1                  | 2583XL           | Scheveningen       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000310                       |
    | fields              | adressering.adresregel2         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                |
    | adresregel2 | 2583 XL  SCHEVENINGEN |

Regel: adresregel2 wordt voor een adres met postcode en zonder woonplaats als volgt samengesteld: [postcode numeriek deel][spatie][postcode alfabetisch deel][2 spaties][omschrijving gemeente van inschrijving in hoofdletters]

  Scenario: persoon heeft een adres met postcode en zonder woonplaats als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000322' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
    | 0518                 | een straat         | 1                  | 2584BZ           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000322                       |
    | fields              | adressering.adresregel2         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                 |
    | adresregel2 | 2584 BZ  'S-GRAVENHAGE |

Regel: adresregel2 wordt voor een locatie als volgt samengesteld: [omschrijving gemeente van inschrijving in hoofdletters]

  Scenario: persoon heeft een locatie als verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) | functie adres (10.10) |
    | 0518                              | W                     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10)       |
    | 0518                 | Woonboot tegenover de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000309                       |
    | fields              | adressering.adresregel2         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde        |
    | adresregel2 | 'S-GRAVENHAGE |

Regel: adresregel1 wordt voor een verblijfplaats buitenland gevuld met regel1 van de verblijfplaats

  Scenario: persoon verblijft in het buitenland
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000346                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde          |
    | adresregel1 | Rue du pomme 26 |

Regel: adresregel2 wordt voor een verblijfplaats buitenland gevuld met regel2 van de verblijfplaats

  Scenario: persoon verblijft in het buitenland
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000346                       |
    | fields              | adressering.adresregel2         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde    |
    | adresregel2 | Bruxelles |

Regel: adresregel3 wordt voor een verblijfplaats buitenland gevuld met regel3 van de verblijfplaats

  Scenario: persoon verblijft in het buitenland
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000346                       |
    | fields              | adressering.adresregel3         |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde        |
    | adresregel3 | postcode 1000 |

Regel: land wordt voor een verblijfplaats buitenland gevuld met land van de verblijfplaats

  Scenario: persoon verblijft in het buitenland
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
    | land (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000346                       |
    | fields              | adressering.land                |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam              | waarde |
    | land.code         | 5010   |
    | land.omschrijving | België |
