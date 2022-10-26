#language: nl

Functionaliteit: Persoon beperkt: naam

  Scenario: persoon heeft 'naam' veld: 'geslachtsnaam (02.40)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.geslachtsnaam                  |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde  |
    | geslachtsnaam | Maassen |

  Abstract Scenario: persoon heeft 'naam' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    | <gba naam>            | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.<naam>                         |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam            | naam        | waarde    |
    | voornamen (02.10)   | voornamen   | voornamen |
    | voorvoegsel (02.30) | voorvoegsel | van de    |

  Abstract Scenario: persoon heeft 'naam' veld: 'adellijke titel of predicaat (02.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                                 | waarde   |
    | geslachtsnaam (02.40)                | Maassen  |
    | geboortedatum (03.10)                | 19830526 |
    | adellijke titel of predicaat (02.20) | JH       |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <field>                             |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                 | waarde    |
    | adellijkeTitelPredicaat.code         | JH        |
    | adellijkeTitelPredicaat.omschrijving | Jonkheer  |
    | adellijkeTitelPredicaat.soort        | predicaat |

    Voorbeelden:
    | field                                     |
    | naam.adellijkeTitelPredicaat              |
    | naam.adellijkeTitelPredicaat.code         |
    | naam.adellijkeTitelPredicaat.omschrijving |

  Scenario: persoon heeft 'naam' veld: 'voorletters'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde     |
    | geslachtsnaam (02.40) | Maassen    |
    | geboortedatum (03.10) | 19830526   |
    | voornamen (02.10)     | Jan Pieter |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.voorletters                    |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam        | waarde |
    | voorletters | J.P.   |

  Scenario: persoon heeft 'naam' veld: 'volledigeNaam'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde     |
    | geslachtsnaam (02.40) | Maassen    |
    | geboortedatum (03.10) | 19830526   |
    | voorvoegsel (02.30)   | van den    |
    | voornamen (02.10)     | Jan Pieter |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.volledigeNaam                  |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde                     |
    | volledigeNaam | Jan Pieter van den Maassen |

  Abstract Scenario: gevraagde veld heeft geen waarde
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | postcode (11.60)   | 2628HJ |
    | huisnummer (11.20) | 2      |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | 2                           |
    | fields     | <fields>                    |
    Dan heeft de response een persoon zonder 'naam' gegevens

    Voorbeelden:
    | fields           |
    | naam.voornamen   |
    | naam.voorvoegsel |

  Scenario: gevraagde veld heeft standaard waarde
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | . |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | postcode (11.60)   | 2628HJ |
    | huisnummer (11.20) | 2      |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | 2                           |
    | fields     | naam.geslachtsnaam          |
    Dan heeft de response een persoon zonder 'naam' gegevens
