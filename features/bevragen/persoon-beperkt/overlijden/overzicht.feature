# language: nl

Functionaliteit: Persoon beperkt: overlijden

  Wanneer een consumer van de BRP API personen zoekt inclusief overleden personen
  Dan wil de consumer worden geattendeerd welke van de gevonden personen zijn overleden zonder expliciet om overlijden gegevens te vragen met de fields parameter

  Rule: indicatieOverleden heeft de waarde true als een gevonden persoon is overleden. Dit veld wordt altijd meegeleverd, ook als het niet met fields is gevraagd

    Abstract Scenario: <sub titel> van een niet-overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | <fields>                            |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |

      Voorbeelden:
      | sub titel                             | fields                         |
      | overlijden velden wordt gevraagd      | burgerservicenummer,overlijden |
      | overlijden velden wordt niet gevraagd | burgerservicenummer            |

    Abstract Scenario: overlijden gegevens wordt niet gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      En de persoon heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | <datum overlijden>       | 0518                      | 6030                    |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      | overlijden.indicatieOverleden | true      |

      Voorbeelden:
      | datum overlijden |
      | 20020701         |
      | 20020700         |
      | 20020000         |
      | 00000000         |

  Rule: leeftijd veld wordt niet geleverd voor overleden personen

    Scenario: leeftijd wordt gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      En de persoon heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | leeftijd                            |
      Dan heeft de response een persoon met alleen de volgende 'overlijden' gegevens
      | naam               | waarde |
      | indicatieOverleden | true   |

  Rule: indicatieOverleden is in onderzoek wanneer 'datum overlijden (08.10)' in onderzoek is

    Abstract Scenario: <type> is in onderzoek en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      En de persoon heeft de volgende 'overlijden' gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum overlijden (08.10) |
      | <aanduiding in onderzoek>       | 20020701                       | 20020701                 |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                    | waarde      |
      | burgerservicenummer                                     | 000000152   |
      | overlijden.indicatieOverleden                           | true        |
      | overlijden.inOnderzoek.indicatieOverleden               | true        |
      | overlijden.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | overlijden.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
      | overlijden.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | aanduiding in onderzoek | type                      |
      | 060000                  | hele categorie overlijden |
      | 060800                  | hele groep overlijden     |
      | 060810                  | datum overlijden          |

    Abstract Scenario: <type> is in onderzoek en overlijden velden worden niet gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      En de persoon heeft de volgende 'overlijden' gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum overlijden (08.10) |
      | <aanduiding in onderzoek>       | 20020701                       | 20020701                 |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      | overlijden.indicatieOverleden | true      |

      Voorbeelden:
      | aanduiding in onderzoek | type              |
      | 060820                  | plaats overlijden |
      | 060830                  | land overlijden   |
