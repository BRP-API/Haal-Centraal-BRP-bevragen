#language: nl

Functionaliteit: Persoon: leeftijd

  Abstract Scenario: geboortedatum is een volledig datum
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde  |
    | geboortedatum (03.10) | <datum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam     | waarde     |
    | leeftijd | <leeftijd> |

    Voorbeelden:
    | datum              | leeftijd |
    | vandaag - 10 jaar  | 10       |
    | gisteren - 15 jaar | 15       |
    | morgen - 20 jaar   | 19       |

  Scenario: geboortedatum is een onbekend datum
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon zonder gegevens

  Scenario: maand en dag van geboortedatum is onbekend
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 20000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon zonder gegevens

  Abstract Scenario: dag van geboortedatum is onbekend en geboorte maand is niet deze maand
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde          |
    | geboortedatum (03.10) | <geboortedatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam     | waarde     |
    | leeftijd | <leeftijd> |

    Voorbeelden:
    | geboortedatum            | leeftijd |
    | volgende maand - 10 jaar | 9        |
    | vorige maand - 10 jaar   | 10       |

  Abstract Scenario: dag van geboortedatum is onbekend en geboorte maand is deze maand
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde               |
    | geboortedatum (03.10) | deze maand - 10 jaar |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon zonder gegevens

  Scenario: persoon is overleden
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20040319 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon zonder gegevens

  Abstract Scenario: geboortedatum is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | geboortedatum (03.10)           | vandaag - 10 jaar         |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | leeftijd                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                | waarde      |
    | leeftijd                                            | 10          |
    | inOnderzoek.leeftijd                                | true        |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 010000                  |
    | 010300                  |
    | 010310                  |
