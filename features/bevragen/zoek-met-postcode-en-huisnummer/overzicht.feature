#language: nl

Functionaliteit: Zoek met postcode en huisnummer

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) |
    | 0599          | 2628HJ           | 2                  |
    En de persoon met burgerservicenummer '000000025' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) | huisletter (11.30) |
    | 0599          | 2628HJ           | 2                  | A                  |
    En de persoon met burgerservicenummer '000000026' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) | huisnummertoevoeging (11.40) |
    | 0599          | 2628HJ           | 2                  | III                          |
    En de persoon met burgerservicenummer '000000027' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) | aanduiding bij huisnummer (11.50) |
    | 0599          | 2628HJ           | 2                  | to                                |
    En de persoon met burgerservicenummer '000000028' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) |
    | 0599          | 2629HJ           | 2                  |
    En de persoon heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) |
    | 20220301                 |
    En de persoon met burgerservicenummer '000000029' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0600                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) |
    | 0600          | 2630HJ           | 2                  |

Rule: Postcode (niet hoofdlettergevoelig) en huisnummer zijn verplichte parameters

  Abstract Scenario: Zoek een persoon met de postcode (<sub-titel>) en huisnummer van het adres van zijn verblijfplaats
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | <postcode>                  |
    | huisnummer | 2                           |
    | fields     | burgerservicenummer         |
    Dan heeft de response 4 personen
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000024 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000025 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000026 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000027 |

    Voorbeelden:
    | postcode | sub-titel                                                             |
    | 2628HJ   | letters zijn hoofdletters                                             |
    | 2628hj   | letters zijn kleine letters                                           |
    | 2628 HJ  | spatie tussen de cijfers en hoofdletters                              |
    | 2628 hj  | spatie tussen de cijfers en kleine letters                            |
    | 2628 Hj  | spatie tussen de cijfers en letters (zowel hoofd- als kleine letters) |

Rule: Optionele 'adres' parameters (niet hooflettergevoelig) kunnen worden toegevoegd om de zoek criteria aan te scherpen.

  Abstract Scenario: Zoek een persoon met de postcode, huisnummer en huisletter van het adres van zijn verblijfplaats
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | 2                           |
    | huisletter | <huisletter>                |
    | fields     | burgerservicenummer         |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000025 |

    Voorbeelden:
    | huisletter |
    | A          |
    | a          |

  Abstract Scenario: Zoek een persoon met de postcode, huisnummer en huisnummertoevoeging van het adres van zijn verblijfplaats
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                      |
    | type                 | ZoekMetPostcodeEnHuisnummer |
    | postcode             | 2628HJ                      |
    | huisnummer           | 2                           |
    | huisnummertoevoeging | <huisnummertoevoeging>      |
    | fields               | burgerservicenummer         |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000026 |

    Voorbeelden:
    | huisnummertoevoeging |
    | III                  |
    | iii                  |
    | Iii                  |

  Scenario: Zoek een persoon met de postcode, huisnummer en gemeenteVanInschrijving code van het adres van zijn verblijfplaats
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                      |
    | type                    | ZoekMetPostcodeEnHuisnummer |
    | postcode                | 2630HJ                      |
    | huisnummer              | 2                           |
    | gemeenteVanInschrijving | 0600                        |
    | fields                  | burgerservicenummer         |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000029 |

Rule: De optionele 'inclusiefOverledenPersonen' parameter moet worden opgegeven om een overleden persoon te kunnen vinden

  Scenario: Zoek een overleden persoon
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                      |
    | type                       | ZoekMetPostcodeEnHuisnummer |
    | postcode                   | 2629HJ                      |
    | huisnummer                 | 2                           |
    | inclusiefOverledenPersonen | true                        |
    | fields                     | burgerservicenummer         |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000028 |
    | overlijden.indicatieOverleden | true      |