# language: nl

Functionaliteit: LeeftijdBepaling
  Bepaal de leeftijd van de persoon

  Rule: bij een volledig bekende geboortedatum wordt de leeftijd in jaren geleverd

    @skip-verify
    Abstract Scenario: Volledig geboortedatum
      Gegeven de persoon met burgerservicenummer '000000218' heeft de volgende gegevens
        | naam                  | waarde   |
        | geboortedatum (03.10) | 19830526 |
        Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000218                       |
        | fields              | burgerservicenummer,leeftijd    |
        Dan heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde     |
        | burgerservicenummer | 000000218  |
        | leeftijd            | <leeftijd> |

        Voorbeelden:
        | raadpleeg datum  | leeftijd |
        | 1 januari 2019   | 35       |
        | 25 mei 2019      | 35       |
        | 26 mei 2019      | 36       |
        | 30 november 2019 | 36       |
        | 10 januari 2020  | 36       |

    @skip-verify
    Abstract Scenario: Geboren op 29 februari in een schrikkeljaar
      Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende gegevens
        | naam                  | waarde   |
        | geboortedatum (03.10) | 19960229 |
        Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000231                       |
        | fields              | burgerservicenummer,leeftijd    |
        Dan heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde     |
        | burgerservicenummer | 000000231  |
        | leeftijd            | <leeftijd> |

        Voorbeelden:
        | raadpleeg datum  | leeftijd |
        | 28 februari 2016 | 19       |
        | 29 februari 2016 | 20       |
        | 28 februari 2017 | 20       |
        | 01 maart 2017    | 21       |

  Rule: bij een volledig onbekende geboortedatum wordt leeftijd niet geleverd

    Scenario: Volledig onbekend geboortedatum
      Gegeven de persoon met burgerservicenummer '000000243' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 00000000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000243                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000243 |

  Rule: bij een geboortedatum met alleen jaar bekend wordt de leeftijd niet geleverd

    Scenario: Alleen jaar van geboortedatum is bekend
    Gegeven de persoon met burgerservicenummer '000000255' heeft de volgende 'geboorte' gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 19830000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000255                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000255 |

  Rule: bij een geboortedatum met onbekende dag wordt de leeftijd niet geleverd in de geboortemaand

    @skip-verify
    Abstract Scenario: Jaar en maand van geboortedatum zijn bekend
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'geboorte' gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 19830500 |
      Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000267                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde     |
      | burgerservicenummer | 000000267  |
      | leeftijd            | <leeftijd> |

      Voorbeelden:
      | raadpleeg datum | leeftijd | omschrijving                                                                          |
      | 30 april 2019   | 35       | Voor de geboortemaand weten we zeker dat de persoon nog niet 1 jaar ouder is geworden |
      | 1 mei 2019      |          | In de geboortemaand weten we niet wanneer de persoon al 1 jaar ouder is geworden      |
      | 15 mei 2019     |          | In de geboortemaand weten we niet wanneer de persoon al 1 jaar ouder is geworden      |
      | 31 mei 2019     |          | In de geboortemaand weten we niet wanneer de persoon al 1 jaar ouder is geworden      |
      | 01 juni 2019    | 36       | Na de geboortemaand weten we zeker dat de persoon 1 jaar ouder is geworden            |

  Rule: wanneer de persoon overleden is wordt de leeftijd niet geleverd

    Scenario: Persoon is overleden
    Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'geboorte' gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 19830526 |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20040319 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000279                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000279 |
