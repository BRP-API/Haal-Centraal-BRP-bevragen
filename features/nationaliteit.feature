# language: nl

@post-assert
Functionaliteit: Bepalen van de actuele nationaliteit van een persoon
  
  @gba
  Rule: In het antwoord voor personen worden alleen actuele nationaliteiten opgenomen, waarbij geldt dat:
    - in categorie 04 nationaliteit (05.10) of aanduiding bijzonder Nederlanderschap (65.10) een waarde is opgenomen
    - in categorie 04 GEEN reden beëindigen nationaliteit (64.10) is opgenomen
    - er meerdere categorieën 04 kunnen voorkomen

    @gba
    Scenario: de persoon heeft één actuele nationaliteit
      Gegeven de persoon met burgerservicenummer '000009830' heeft de volgende gegevens
      | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 1      | 4         | 0001                  | 001                   |                          |                                    |                 | 19750707                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000009830                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '000009830' een nationaliteit met de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0001     |
      | redenOpname           | 001      |
      | datumIngangGeldigheid | 19750707 |

    @gba
    Scenario: de persoon wordt behandeld als Nederlander
      Gegeven de persoon met burgerservicenummer '000009866' heeft de volgende gegevens
      | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 1      | 4         |                       | 310                   |                          | B                                  |                 | 19570115                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000009866                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '000009866' een nationaliteit met alleen de volgende gegevens
      | naam                                | waarde   |
      | aanduidingBijzonderNederlanderschap | B        |
      | redenOpname                         | 310      |
      | datumIngangGeldigheid               | 19570115 |

    @gba
    Scenario: de persoon is vastgesteld niet-Nederlander
      Gegeven de persoon met burgerservicenummer '999994748' heeft de volgende gegevens
      | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 1      | 4         |                       | 310                   |                          | V                                  |                 | 19750615                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 999994748                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '999994748' een nationaliteit met alleen de volgende gegevens
      | naam                                | waarde   |
      | aanduidingBijzonderNederlanderschap | V        |
      | redenOpname                         | 310      |
      | datumIngangGeldigheid               | 19750615 |

    @gba
    Scenario: de persoon heeft een onbekende nationaliteit
      Gegeven de persoon met burgerservicenummer '999993367' heeft de volgende gegevens
      | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 1      | 4         | 0000                  | 311                   |                          |                                    |                 | 00000000                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 999993367                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '999993367' een nationaliteit met alleen de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0000     |
      | redenOpname           | 311      |
      | datumIngangGeldigheid | 00000000 |

    @gba
    Scenario: beëindigde registratie van vreemde nationaliteit
      Gegeven de persoon met burgerservicenummer '999992557' heeft de volgende gegevens
      | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
      | 1      | 54        | 0263                  | 301                   |                          |                                    |                 | 20100801                        |
      | 2      | 4         | 0001                  | 017                   |                          |                                    |                 | 20100801                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 999992557                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '999992557' een nationaliteit met alleen de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0001     |
      | redenOpname           | 017      |
      | datumIngangGeldigheid | 20100801 |
      En heeft de persoon met burgerservicenummer '999992557' GEEN nationaliteit met de volgende gegevens
      | naam                  | waarde   |
      | datumIngangGeldigheid | 20150131 |
      En heeft de persoon met burgerservicenummer '999992557' GEEN nationaliteit met de volgende gegevens
      | naam          | waarde |
      | nationaliteit | 0263   |
      | redenOpname   | 301    |
  
    @gba
    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de persoon met burgerservicenummer '555550001' heeft de volgende gegevens
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 410                      |                                    |                 | 20190604                        |
        | 1      | 54        |                       | 310                   |                          | V                                  |                 | 20010319                        |
        | 2      | 4         | 0001                  | 017                   |                          |                                    |                 | 20190602                        |
        Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 555550001                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '555550001' een nationaliteit met alleen de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0001     |
      | redenOpname           | 017      |
      | datumIngangGeldigheid | 20190602 |
      En heeft de persoon met burgerservicenummer '555550001' GEEN nationaliteit met de volgende gegevens
      | naam                  | waarde   |
      | datumIngangGeldigheid | 20190604 |
      En heeft de persoon met burgerservicenummer '555550001' GEEN nationaliteit met de volgende gegevens
      | naam                                | waarde |
      | aanduidingBijzonderNederlanderschap | V      |
      | redenOpname                         | 310    |

    @gba
    Scenario: nationaliteit is onjuist
      Gegeven de persoon met burgerservicenummer '555550002' heeft de volgende gegevens
      | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 1      | 4         | 0263                  | 301                   |                          |                                    |                 | 20100801                        |
      | 2      | 4         |                       |                       |                          |                                    |                 | 20200727                        |
      | 2      | 54        | 0100                  | 301                   |                          |                                    | O               | 20200713                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 555550002                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '555550002' een nationaliteit met alleen de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0263     |
      | redenOpname           | 301      |
      | datumIngangGeldigheid | 20100801 |
      En heeft de persoon met burgerservicenummer '555550002' GEEN nationaliteit met de volgende gegevens
      | naam                  | waarde   |
      | datumIngangGeldigheid | 20200727 |
      En heeft de persoon met burgerservicenummer '555550002' GEEN nationaliteit met de volgende gegevens
      | naam          | waarde |
      | nationaliteit | 0100   |
      | redenOpname   | 301    |

    @gba
    Scenario: geactualiseerde ingangsdatum geldigheid
      Gegeven de persoon met burgerservicenummer '555550003' heeft de volgende gegevens
      | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 1      | 4         | 0100                  | 311                   |                          |                                    |                 | 20200727                        |
      | 1      | 54        | 0100                  | 311                   |                          |                                    | O               | 20200713                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 555550003                           |
      | fields              | burgerservicenummer,nationaliteiten |
      Dan heeft de persoon met burgerservicenummer '555550003' een nationaliteit met alleen de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0100     |
      | redenOpname           | 311      |
      | datumIngangGeldigheid | 20200727 |
      En heeft de persoon met burgerservicenummer '555550003' GEEN nationaliteit met de volgende gegevens
      | naam                  | waarde   |
      | datumIngangGeldigheid | 20200713 |

  @proxy
  Rule: de nationaliteit wordt gevuld op basis van het voorkomen van nationaliteit of aanduidingBijzonderNederlanderschap
    - wanneer nationaliteit voorkomt met een waarde ongelijk aan "0000" (onbekend), dan wordt type opgenomen met de waarde "Nationaliteit"
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0000" (onbekend), dan wordt type opgenomen met de waarde "NationaliteitOnbekend"
    - wanneer aanduidingBijzonderNederlanderschap voorkomt met een waarde gelijk aan "B", dan wordt type opgenomen met de waarde "BehandeldAlsNederlander"
    - wanneer aanduidingBijzonderNederlanderschap voorkomt met een waarde gelijk aan "V", dan wordt type opgenomen met de waarde "VastgesteldNietNederlander"

    @proxy
    Scenario: de persoon heeft de Nederlandse nationaliteit
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000009830 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0001   |
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000009830                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam               | waarde        |
      | type               | Nationaliteit |
      | nationaliteit.code | 0001          |

    @proxy
    Scenario: de persoon heeft een vreemde nationaliteit
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0263   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550002                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam               | waarde        |
      | type               | Nationaliteit |
      | nationaliteit.code | 0263          |

    @proxy
    Scenario: de persoon is staatloos
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0499   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550002                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam               | waarde        |
      | type               | Nationaliteit |
      | nationaliteit.code | 0499          |

    @proxy
    Scenario: de persoon heeft een onbekende nationaliteit
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993367 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0000   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993367                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam | waarde                |
      | type | NationaliteitOnbekend |

    @proxy
    Scenario: de persoon wordt behandeld als Nederlander
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000009866 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam                                     | waarde |
      | aanduidingBijzonderNederlanderschap.code | B      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000009866                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam | waarde                  |
      | type | BehandeldAlsNederlander |

    @proxy
    Scenario: de persoon is vastgesteld niet-Nederlander
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994748 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam                                     | waarde |
      | aanduidingBijzonderNederlanderschap.code | V      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999994748                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam | waarde                     |
      | type | VastgesteldNietNederlander |
