# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland (adres) - verblijfadres velden vragen met fields 

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                              | waarde        |
    | gemeentecode (92.10)              | 0518          |
    | straatnaam (11.10)                | Spui          |
    | naam openbare ruimte (11.15)      | Spui          |
    | huisnummer (11.20)                | 123           |
    | huisletter (11.30)                | a             |
    | huisnummertoevoeging (11.40)      | 2             |
    | aanduiding bij huisnummer (11.50) | to            |
    | postcode (11.60)                  | 1234AA        |
    | woonplaats (11.70)                | 's-Gravenhage |

  Abstract Scenario: 'aanduiding bij huisnummer (11.50)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                               | waarde    |
    | type                                               | Adres     |
    | verblijfadres.aanduidingBijHuisnummer.code         | to        |
    | verblijfadres.aanduidingBijHuisnummer.omschrijving | tegenover |

    Voorbeelden:
    | fields                                                            |
    | verblijfplaats.verblijfadres.aanduidingBijHuisnummer              |
    | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.code         |
    | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.omschrijving |

  Scenario: 'huisletter (11.30)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.huisletter'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.huisletter |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde |
    | type                     | Adres  |
    | verblijfadres.huisletter | a      |

  Scenario: 'huisnummer (11.20)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.huisnummer'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.huisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde |
    | type                     | Adres  |
    | verblijfadres.huisnummer | 123    |

  Scenario: 'huisnummertoevoeging (11.40)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.huisnummertoevoeging'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 000000152                                         |
    | fields              | verblijfplaats.verblijfadres.huisnummertoevoeging |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                               | waarde |
    | type                               | Adres  |
    | verblijfadres.huisnummertoevoeging | 2      |

  Scenario: 'naam openbare ruimte (11.15)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.officieleStraatnaam'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.officieleStraatnaam |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | type                              | Adres  |
    | verblijfadres.officieleStraatnaam | Spui   |

  Scenario: 'postcode (11.60)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.postcode'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000152                             |
    | fields              | verblijfplaats.verblijfadres.postcode |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                   | waarde |
    | type                   | Adres  |
    | verblijfadres.postcode | 1234AA |

  Scenario: 'straatnaam (11.10)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.korteStraatnaam'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                 |
    | type                | RaadpleegMetBurgerservicenummer        |
    | burgerservicenummer | 000000152                              |
    | fields              | verblijfplaats.verblijfadres.korteStraatnaam |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | type                          | Adres  |
    | verblijfadres.korteStraatnaam | Spui   |

  Scenario: 'woonplaats (11.70)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.woonplaats'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.woonplaats |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde        |
    | type                     | Adres         |
    | verblijfadres.woonplaats | 's-Gravenhage |

  Scenario: alle verblijfadres velden wordt gevraagd met field pad 'verblijfplaats.verblijfadres'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.verblijfadres    |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                               | waarde        |
    | type                                               | Adres         |
    | verblijfadres.aanduidingBijHuisnummer.code         | to            |
    | verblijfadres.aanduidingBijHuisnummer.omschrijving | tegenover     |
    | verblijfadres.huisletter                           | a             |
    | verblijfadres.huisnummer                           | 123           |
    | verblijfadres.huisnummertoevoeging                 | 2             |
    | verblijfadres.officieleStraatnaam                  | Spui          |
    | verblijfadres.korteStraatnaam                      | Spui          |
    | verblijfadres.postcode                             | 1234AA        |
    | verblijfadres.woonplaats                           | 's-Gravenhage |
