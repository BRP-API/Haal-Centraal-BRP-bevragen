# language: nl

Functionaliteit: geheimhouding: niet verstrekken van gegevens van een persoon aan derden

  Wanneer een consumer van de BRP API gegevens bevraagd van een persoon die geen toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden
  Dan wil de consumer hiervan worden geattendeerd middels een indicatie bij de gevraagde gegevens

  Abstract Scenario: persoon die toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden, wordt geraadpleegd met burgerservicenummer en <sub titel> 
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 0      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

    Voorbeelden:
    | sub titel                                              | fields                                            |
    | geheimhoudingPersoonsgegevens veld wordt gevraagd      | burgerservicenummer,geheimhoudingPersoonsgegevens |
    | geheimhoudingPersoonsgegevens veld wordt niet gevraagd | burgerservicenummer                               |

  Abstract Scenario: persoon die geen toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden, wordt geraadpleegd met burgerservicenummer en <sub titel>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde   |
    | indicatie geheim (70.10) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000152 |
    | geheimhoudingPersoonsgegevens | true      |

    Voorbeelden:
    | sub titel                                              | waarde | fields                                            |
    | geheimhoudingPersoonsgegevens veld wordt gevraagd      | 1      | burgerservicenummer,geheimhoudingPersoonsgegevens |
    | geheimhoudingPersoonsgegevens veld wordt niet gevraagd | 7      | burgerservicenummer                               |

  Abstract Scenario: persoon die geen toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden, wordt gezocht met geslachtsnaam en geboortedatum en <sub titel>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | Jansen                | 19630405              |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde   |
    | indicatie geheim (70.10) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1963-04-05                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000152 |
    | geheimhoudingPersoonsgegevens | true      |

    Voorbeelden:
    | sub titel                                              | waarde | fields                                            |
    | geheimhoudingPersoonsgegevens veld wordt gevraagd      | 2      | burgerservicenummer,geheimhoudingPersoonsgegevens |
    | geheimhoudingPersoonsgegevens veld wordt niet gevraagd | 6      | burgerservicenummer                               |

  Abstract Scenario: persoon die geen toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden, wordt gezocht met postcode en huisnummer en <sub titel>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adreshouding (10.30) |
    | 20150808                           |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeente_code | postcode (11.60) | huisnummer (11.20) |
    | 0518          | 1234AA           | 123                |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde   |
    | indicatie geheim (70.10) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 1234AA                      |
    | huisnummer | 123                         |
    | fields     | <fields>                    |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000152 |
    | geheimhoudingPersoonsgegevens | true      |

    Voorbeelden:
    | sub titel                                              | waarde | fields                                            |
    | geheimhoudingPersoonsgegevens veld wordt gevraagd      | 3      | burgerservicenummer,geheimhoudingPersoonsgegevens |
    | geheimhoudingPersoonsgegevens veld wordt niet gevraagd | 4      | burgerservicenummer                               |
