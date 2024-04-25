# language: nl

Functionaliteit: Persoon beperkt: overlijden

  Wanneer een consumer van de BRP API personen zoekt inclusief overleden personen
  Dan wil de consumer worden geattendeerd welke van de gevonden personen zijn overleden zonder expliciet om overlijden gegevens te vragen met de fields parameter

  Regel: opschorting bijhouding met reden "O" wordt altijd geleverd bij een gevonden overleden persoon is overleden. Ook als het niet met fields is gevraagd

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
      | sub titel                                         | fields              |
      | opschorting bijhouding velden wordt niet gevraagd | burgerservicenummer |

    Scenario: opschorting bijhouding gegevens wordt niet gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |
      En heeft de persoon de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |

  Regel: leeftijd veld wordt niet geleverd voor overleden personen

    Scenario: leeftijd wordt gevraagd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jansen                | 19630405              |
      En de persoon heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
      | 20020701                 | 0518                      | 6030                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Jansen                              |
      | geboortedatum              | 1963-04-05                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | leeftijd                            |
      Dan heeft de response een persoon met alleen de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |
