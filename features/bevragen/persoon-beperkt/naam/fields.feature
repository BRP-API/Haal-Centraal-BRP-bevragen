#language: nl

Functionaliteit: Persoon beperkt: naam velden vragen met fields

  Abstract Scenario: 'voornamen (02.10)' wordt gevraagd met field pad 'naam.voornamen'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    | voornamen (02.10)     | Peter    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.voornamen                      |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam      | waarde |
    | voornamen | Peter  |

  Abstract Scenario: 'voorvoegsel (02.30)' wordt gevraagd met field pad 'naam.voorvoegsel'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    | voorvoegsel (02.30)   | van      |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.voorvoegsel                    |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam        | waarde |
    | voorvoegsel | van    |

  Abstract Scenario: 'geslachtsnaam (02.40)' wordt gevraagd met field pad 'naam.geslachtsnaam'
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

  Abstract Scenario: 'adellijke titel of predicaat (02.20)' wordt gevraagd met field pad '<fields>'
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
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                 | waarde    |
    | adellijkeTitelPredicaat.code         | JH        |
    | adellijkeTitelPredicaat.omschrijving | jonkheer  |
    | adellijkeTitelPredicaat.soort        | predicaat |

    Voorbeelden:
    | fields                                    |
    | naam.adellijkeTitelPredicaat              |
    | naam.adellijkeTitelPredicaat.code         |
    | naam.adellijkeTitelPredicaat.omschrijving |
    | naam.adellijkeTitelPredicaat.soort        |

  Scenario: 'voorletters' wordt gevraagd met field pad 'naam.voorletters'
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

  Scenario: 'volledige naam' wordt gevraagd met field pad 'naam.volledigeNaam'
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
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | postcode (11.60)     | 2628HJ |
    | huisnummer (11.20)   | 2      |
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
    | naam                  | waarde |
    | geslachtsnaam (02.40) | .      |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | postcode (11.60)     | 2628HJ |
    | huisnummer (11.20)   | 2      |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | 2                           |
    | fields     | naam.geslachtsnaam          |
    Dan heeft de response een persoon zonder 'naam' gegevens
