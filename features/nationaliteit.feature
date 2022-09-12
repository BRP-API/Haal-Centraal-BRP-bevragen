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
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                              | waarde      |
      | nationaliteit.code                | 0001        |
      | redenOpname.code                  | 001         |
      | datumIngangGeldigheid.type        | Datum       |
      | datumIngangGeldigheid.datum       | 1975-07-07  |
      | datumIngangGeldigheid.langFormaat | 7 juli 1975 |

    @gba
    Scenario: de persoon wordt behandeld als Nederlander
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'nationaliteit' met de volgende gegevens
      | reden opnemen (63.10) | bijzonder Nederlanderschap (65.10) | datum ingang geldigheid (85.10) |
      | 310                   | B                                  | 19570115                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000024                           |
      | fields              | nationaliteiten |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                                | waarde   |
      | aanduidingBijzonderNederlanderschap | B        |
      | redenOpname                         | 310      |
      | datumIngangGeldigheid               | 19570115 |

    @gba
    Scenario: de persoon is vastgesteld niet-Nederlander
    Gegeven de persoon met burgerservicenummer '000000036' heeft een 'nationaliteit' met de volgende gegevens
      | reden opnemen (63.10) | bijzonder Nederlanderschap (65.10) | datum ingang geldigheid (85.10) |
      | 310                   | V                                  | 19750615                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000036                           |
      | fields              | nationaliteiten |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                                | waarde   |
      | aanduidingBijzonderNederlanderschap | V        |
      | redenOpname                         | 310      |
      | datumIngangGeldigheid               | 19750615 |

    @gba
    Scenario: de persoon heeft een onbekende nationaliteit
      Gegeven de persoon met burgerservicenummer '000000048' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0000                  | 311                   | 00000000                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000048                           |
      | fields              | nationaliteiten |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0000     |
      | redenOpname           | 311      |
      | datumIngangGeldigheid | 00000000 |

    @gba
    Scenario: beëindigde registratie van vreemde nationaliteit
      Gegeven de persoon met burgerservicenummer '000000061' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0263                  | 301                   | 20100801                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) |  datum ingang geldigheid (85.10) |
      | 404                      | 20150131                        |
      En de persoon heeft (nog) een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 017                   | 20100801                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000061                           |
      | fields              | nationaliteiten |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0001     |
      | redenOpname           | 017      |
      | datumIngangGeldigheid | 20100801 |


    @gba
    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de persoon met burgerservicenummer '000000073' heeft een 'nationaliteit' met de volgende gegevens
      | reden opnemen (63.10) | bijzonder Nederlanderschap (65.10) | datum ingang geldigheid (85.10) |
      | 310                   | V                                  | 20010319                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 410                      | 20190604                        |
      En de persoon heeft (nog) een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 017                   | 20190602                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000073                           |
      | fields              | nationaliteiten |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0001     |
      | redenOpname           | 017      |
      | datumIngangGeldigheid | 20190602 |

    @gba
    Scenario: nationaliteit is onjuist
      Gegeven de persoon met burgerservicenummer '000000085' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 301                   | O               | 20200713                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | datum ingang geldigheid (85.10) |
      | 20200727                        |
      En de persoon heeft (nog) een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0263                  | 301                   | 20100801                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000085                           |
      | fields              | nationaliteiten |
      Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0263     |
      | redenOpname           | 301      |
      | datumIngangGeldigheid | 20100801 |


    @gba
    Scenario: geactualiseerde ingangsdatum geldigheid
      Gegeven de persoon met burgerservicenummer '000000097' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 311                   | O               | 20200713                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 311                   | 20200727                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000097                           |
      | fields              | nationaliteiten |
      Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
      | naam                  | waarde   |
      | nationaliteit         | 0100     |
      | redenOpname           | 311      |
      | datumIngangGeldigheid | 20200727 |

  @proxy
  Rule: de nationaliteit wordt gevuld op basis van het voorkomen van nationaliteit of aanduidingBijzonderNederlanderschap
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0000" (onbekend), dan wordt type opgenomen met de waarde "NationaliteitOnbekend"
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0002", dan wordt type opgenomen met de waarde "BehandeldAlsNederlander"
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0499", dan wordt type opgenomen met de waarde "Staatloos"
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0500", dan wordt type opgenomen met de waarde "VastgesteldNietNederlander"
    - wanneer nationaliteit voorkomt met een waarde ongelijk aan "0000", "0002", "0499" of "0500", dan wordt type opgenomen met de waarde "Nationaliteit"
    - wanneer aanduidingBijzonderNederlanderschap voorkomt met een waarde gelijk aan "B", dan wordt type opgenomen met de waarde "BehandeldAlsNederlander"
    - wanneer aanduidingBijzonderNederlanderschap voorkomt met een waarde gelijk aan "V", dan wordt type opgenomen met de waarde "VastgesteldNietNederlander"
    - het veld "nationaliteit" wordt alleen opgenomen bij type "Nationaliteit"

    @proxy
    Scenario: de persoon heeft de Nederlandse nationaliteit
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000009830 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0001   |
      Als personen wordt gezocht met de volgende parameters
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
      | burgerservicenummer | 999993045 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0263   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993045                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam               | waarde        |
      | type               | Nationaliteit |
      | nationaliteit.code | 0263          |

    @proxy
    Scenario: de persoon is staatloos
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999991188 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0499   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999991188                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam | waarde    |
      | type | Staatloos |

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
      | naam                               | waarde |
      | bijzonder Nederlanderschap (65.10) | B      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000009866                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam | waarde                  |
      | type | BehandeldAlsNederlander |

    @proxy
    Scenario: de persoon wordt behandeld als Nederlander, nationaliteit heeft code 0002
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0002   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
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
      | naam                               | waarde |
      | bijzonder Nederlanderschap (65.10) | V      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999994748                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam | waarde                     |
      | type | VastgesteldNietNederlander |

    @proxy
    Scenario: de persoon is vastgesteld niet-Nederlander, nationaliteit heeft code 0500
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam               | waarde |
      | nationaliteit.code | 0500   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550002                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam | waarde                     |
      | type | VastgesteldNietNederlander |
