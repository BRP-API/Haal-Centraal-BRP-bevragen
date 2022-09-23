# language: nl

@post-assert
Functionaliteit: Nationaliteit

  Scenario: persoon heeft een nationaliteit
  Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
  | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
  | 0001                  | 001                   | 19750707                        |
  Als gba personen wordt gezocht met de volgende parameters
  | naam                | waarde                          |
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000012                       |
  | fields              | nationaliteiten                 |
  Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
  | naam                       | waarde                                           |
  | nationaliteit.code         | 0001                                             |
  | nationaliteit.omschrijving | Nederlandse                                      |
  | redenopname.code           | 001                                              |
  | redenopname.omschrijving   | Wet op het Nederlanderschap 1892,art. 1, onder a |
  | datumIngangGeldigheid      | 19750707                                         |

  Scenario: persoon heeft meerdere nationaliteiten
  Gegeven de persoon met burgerservicenummer '000000024' heeft een 'nationaliteit' met de volgende gegevens
  | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
  | 0001                  | 001                   | 19750707                        |
  En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
  | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
  | 0263                  | 301                   | 19620107                        |
  Als gba personen wordt gezocht met de volgende parameters
  | naam                | waarde                          |
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000024                       |
  | fields              | nationaliteiten                 |
  Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
  | naam                       | waarde        |
  | nationaliteit.code         | 0001          |
  | nationaliteit.omschrijving | Nederlandse   |
  | redenopname.code           | 001                                              |
  | redenopname.omschrijving   | Wet op het Nederlanderschap 1892,art. 1, onder a |
  | datumIngangGeldigheid      | 19750707                                         |
  En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
  | naam                       | waarde                                   |
  | nationaliteit.code         | 0263                                     |
  | nationaliteit.omschrijving | Surinaamse                               |
  | redenOpname.code           | 301                                      |
  | redenOpname.omschrijving   | Vaststelling bezit vreemde nationaliteit |
  | datumIngangGeldigheid      | 19620107                                 |

  Scenario: persoon heeft een nationaliteit met reden opname = onbekend
  Gegeven de persoon met burgerservicenummer '000000036' heeft een 'nationaliteit' met de volgende gegevens
  | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
  | 0001                  | 000                   | 19750707                        |
  Als gba personen wordt gezocht met de volgende parameters
  | naam                | waarde                          |
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000036                       |
  | fields              | nationaliteiten                 |
  Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
  | naam                       | waarde       |
  | nationaliteit.code         | 0001         |
  | nationaliteit.omschrijving | Nederlandse  |
  | redenopname.code           | 000          |
  | redenopname.omschrijving   | Onbekend     |
  | datumIngangGeldigheid      | 19750707     |

  Scenario: de persoon is Staatloos
    Gegeven de persoon met burgerservicenummer '000000255' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0499                  | 312                   | 19750707                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000255                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde                                           |
    | nationaliteit.code                | 0499                                             |
    | nationaliteit.omschrijving        | Staatloos                                        |
    | redenOpname.code                  | 312                                              |
    | redenOpname.omschrijving          | Vaststelling staatloosheid                       |
    | datumIngangGeldigheid             | 19750707                                         |

  Scenario: de persoon wordt behandeld als Nederlander, bijzonder Nederlanderschap heeft waarde "B"
    Gegeven de persoon met burgerservicenummer '000000024' heeft een 'nationaliteit' met de volgende gegevens
    | reden opnemen (63.10) | bijzonder Nederlanderschap (65.10) | datum ingang geldigheid (85.10) |
    | 310                   | B                                  | 19570115                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000024                           |
    | fields              | nationaliteiten                     |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                                | waarde                                  |
    | aanduidingBijzonderNederlanderschap | B                                       |
    | redenOpname.code                    | 310                                     |
    | redenOpname.omschrijving            | Vaststelling bijzonder Nederlanderschap |
    | datumIngangGeldigheid               | 19570115                                |


  Scenario: de persoon wordt behandeld als Nederlander, nationaliteit heeft code 0002
    Gegeven de persoon met burgerservicenummer '000000115' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0002                  | 310                   | 19570116                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000115                           |
    | fields              | nationaliteiten                     |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde                                  |
    | nationaliteit.code                | 0002                                    |
    | nationaliteit.omschrijving        | Behandeld als Nederlander               |
    | redenOpname.code                  | 310                                     |
    | redenOpname.omschrijving          | Vaststelling bijzonder Nederlanderschap |
    | datumIngangGeldigheid             | 19570116                                |                             |

  Scenario: de persoon heeft een onbekende nationaliteit
    Gegeven de persoon met burgerservicenummer '000000048' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0000                  | 311                   | 00000000                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000048                           |
    | fields              | nationaliteiten |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde                                  |
    | nationaliteit.code                | 0000                                    |
    | nationaliteit.omschrijving        | Onbekend                                |
    | redenOpname.code                  | 311                                     |
    | redenOpname.omschrijving          | Vaststelling onbekende nationaliteit    |
    | datumIngangGeldigheid             | 00000000                                |

  Scenario: beëindigde registratie van vreemde nationaliteit
    Gegeven de persoon met burgerservicenummer '000000061' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0263                  | 301                   | 20100801                        |
    En de 'nationaliteit' is gewijzigd naar de volgende gegevens
    | reden beëindigen (64.10) |  datum ingang geldigheid (85.10) |
    | 404                      | 20150131                        |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 017                   | 20100801                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000061                           |
    | fields              | nationaliteiten                     |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde                                               |
    | nationaliteit.code                | 0001                                                 |
    | nationaliteit.omschrijving        | Nederlandse                                          |
    | redenOpname.code                  | 017                                                  |
    | redenOpname.omschrijving          | Rijkswet op het Nederlanderschap 1984, art. 3, lid 1 |
    | datumIngangGeldigheid             | 20100801                                             |

  Scenario: verlies bijzonder Nederlanderschap
    Gegeven de persoon met burgerservicenummer '000000073' heeft een 'nationaliteit' met de volgende gegevens
    | reden opnemen (63.10) | bijzonder Nederlanderschap (65.10) | datum ingang geldigheid (85.10) |
    | 310                   | V                                  | 20010319                        |
    En de 'nationaliteit' is gewijzigd naar de volgende gegevens
    | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
    | 410                      | 20190604                        |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 017                   | 20190602                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000073                           |
    | fields              | nationaliteiten                     |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde                                               |
    | nationaliteit.code                | 0001                                                 |
    | nationaliteit.omschrijving        | Nederlandse                                          |
    | redenOpname.code                  | 017                                                  |
    | redenOpname.omschrijving          | Rijkswet op het Nederlanderschap 1984, art. 3, lid 1 |
    | datumIngangGeldigheid             | 20190602                                             |

  Scenario: nationaliteit is onjuist
    Gegeven de persoon met burgerservicenummer '000000085' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0100                  | 301                   | 20200713                        |
    En de 'nationaliteit' is gecorrigeerd naar de volgende gegevens
    | onjuist (84.10) | datum ingang geldigheid (85.10) |
    | O               | 20200727                        |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0263                  | 301                   | 20100801                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000085                           |
    | fields              | nationaliteiten                     |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde                                               |
    | nationaliteit.code                | 0263                                                 |
    | nationaliteit.omschrijving        | Surinaamse                                           |
    | redenOpname.code                  | 301                                                  |
    | redenOpname.omschrijving          | Vaststelling bezit vreemde nationaliteit             |
    | datumIngangGeldigheid             | 20100801                                             |


  Scenario: geactualiseerde ingangsdatum geldigheid
    Gegeven de persoon met burgerservicenummer '000000097' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
    | 0100                  | 311                   | O               | 20200713                        |
    En de 'nationaliteit' is gewijzigd naar de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0100                  | 311                   | 20200727                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000097                           |
    | fields              | nationaliteiten |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde                                               |
    | nationaliteit.code                | 0100                                                 |
    | nationaliteit.omschrijving        | Algerijnse                                           |
    | redenOpname.code                  | 311                                                  |
    | redenOpname.omschrijving          | Vaststelling onbekende nationaliteit                 |
    | datumIngangGeldigheid             | 20200727                                             |
