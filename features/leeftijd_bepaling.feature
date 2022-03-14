# language: nl

Functionaliteit: LeeftijdBepaling
  Bepaal de leeftijd van de persoon

  Rule: bij een volledig bekende geboortedatum wordt de leeftijd in jaren geleverd
    
    Abstract Scenario: Volledig geboortedatum
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 19830526 |
      Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de persoon met burgerservicenummer '555550001' alleen de volgende gegevens
      | burgerservicenummer | leeftijd   |
      | 555550001           | <leeftijd> |

      Voorbeelden:
      | raadpleeg datum  | leeftijd |
      | 1 januari 2019   | 35       |
      | 25 mei 2019      | 35       |
      | 26 mei 2019      | 36       |
      | 30 november 2019 | 36       |
      | 10 januari 2020  | 36       |

    Abstract Scenario: Geboren op 29 februari in een schrikkeljaar
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550010 |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 19960229 |
      Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550010                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de persoon met burgerservicenummer '555550010' alleen de volgende gegevens
      | burgerservicenummer | leeftijd   |
      | 555550010           | <leeftijd> |

      Voorbeelden:
      | raadpleeg datum  | leeftijd |
      | 28 februari 2016 | 19       |
      | 29 februari 2016 | 20       |
      | 28 februari 2017 | 20       |
      | 01 maart 2017    | 21       |

  Rule: bij een volledig onbekende geboortedatum wordt leeftijd niet geleverd

    Scenario: Volledig onbekend geboortedatum
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 00000000 |
      Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550004                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de persoon met burgerservicenummer '555550004' alleen de volgende gegevens
      | burgerservicenummer |
      | 555550004           |

  Rule: bij een geboortedatum met alleen jaar bekend wordt de leeftijd niet geleverd

    Scenario: Alleen jaar van geboortedatum is bekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 19830000 |
      Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550005                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de persoon met burgerservicenummer '555550005' alleen de volgende gegevens
      | burgerservicenummer |
      | 555550005           |

  Rule: bij een geboortedatum met onbekende dag wordt de leeftijd niet geleverd in de geboortemaand

    Abstract Scenario: Jaar en maand van geboortedatum zijn bekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550006 |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 19830500 |
      Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550006                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de persoon met burgerservicenummer '555550006' alleen de volgende gegevens
      | burgerservicenummer | leeftijd   |
      | 555550003           | <leeftijd> |

      Voorbeelden:
      | raadpleeg datum | leeftijd | omschrijving                                                                          |
      | 30 april 2019   | 35       | Voor de geboortemaand weten we zeker dat de persoon nog niet 1 jaar ouder is geworden |
      | 1 mei 2019      |          | In de geboortemaand weten we niet wanneer de persoon al 1 jaar ouder is geworden      |
      | 15 mei 2019     |          | In de geboortemaand weten we niet wanneer de persoon al 1 jaar ouder is geworden      |
      | 31 mei 2019     |          | In de geboortemaand weten we niet wanneer de persoon al 1 jaar ouder is geworden      |
      | 01 juni 2019    | 36       | Na de geboortemaand weten we zeker dat de persoon 1 jaar ouder is geworden            |

  Rule: wanneer de persoon overleden is wordt de leeftijd niet geleverd

    Scenario: Persoon is overleden
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550007 |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 19830526 |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam  | waarde   |
      | datum | 20040319 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550007                       |
      | fields              | burgerservicenummer,leeftijd    |
      Dan heeft de persoon met burgerservicenummer '555550007' alleen de volgende gegevens
      | burgerservicenummer |
      | 555550007           |
