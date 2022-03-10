# language: nl

Functionaliteit: LeeftijdBepaling
	Bepaal de leeftijd van de persoon of het kind

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

		Abstract Scenario: Volledig geboortedatum van een kind
			Gegeven het systeem heeft een persoon met de volgende gegevens
			| naam                | waarde    |
			| burgerservicenummer | 555550002 |
			En de persoon heeft een kind met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En het kind met burgerservicenummer '555550003' heeft de volgende 'geboorte' gegevens
			| naam  | waarde   |
			| datum | 20021014 |
			En de persoon heeft een kind met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En het kind met burgerservicenummer '555550004' heeft de volgende 'geboorte' gegevens
			| naam  | waarde   |
			| datum | 20040526 |
			Als personen op '<raadpleeg datum>' wordt gezocht met de volgende parameters
			| naam                | waarde                                         |
			| type                | RaadpleegMetBurgerservicenummer                |
			| burgerservicenummer | 555550002                                      |
			| fields              | kinderen.burgerservicenummer,kinderen.leeftijd |
			Dan heeft het kind met burgerservicenummer '555550003' alleen de volgende gegevens
      | burgerservicenummer | leeftijd    |
      | 555550003           | <leeftijd1> |
			En heeft het kind met burgerservicenummer '555550004' alleen de volgende gegevens
      | burgerservicenummer | leeftijd    |
      | 555550003           | <leeftijd2> |

			Voorbeelden:
			| raadpleeg datum  | leeftijd1 | leeftijd2 |
			| 1 januari 2022   | 19        | 17        |
			| 13 oktober 2022  | 19        | 18        |
			| 14 oktober 2022  | 20        | 18        |
			| 30 december 2022 | 20        | 18        |
			| 10 januari 2023  | 20        | 18        |

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

		Scenario: leeftijd wordt wel geleverd bij een overleden kind (omdat alleen gegevens van de persoonslijst van de gevraagde persoon worden gebruikt)
			Gegeven het systeem heeft een persoon met de volgende gegevens
			| naam                | waarde    |
			| burgerservicenummer | 555550008 |
			En de persoon heeft een kind met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550009 |
      En het kind met burgerservicenummer '555550009' heeft de volgende 'geboorte' gegevens
			| naam  | waarde   |
			| datum | 20021014 |
			En het systeem heeft een persoon met de volgende gegevens
			| naam                | waarde    |
			| burgerservicenummer | 555550009 |
      En de persoon met burgerservicenummer '555550009' heeft de volgende 'overlijden' gegevens
			| naam  | waarde   |
			| datum | 20040319 |
			Als personen op '10 januari 2023' wordt gezocht met de volgende parameters
			| naam                | waarde                                         |
			| type                | RaadpleegMetBurgerservicenummer                |
			| burgerservicenummer | 555550008                                      |
			| fields              | kinderen.burgerservicenummer,kinderen.leeftijd |
			Dan heeft het kind met burgerservicenummer '555550009' alleen de volgende gegevens
			| burgerservicenummer | leeftijd |
			| 555550009           | 20       |
