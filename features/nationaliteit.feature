# language: nl

@post-assert
Functionaliteit: Bepalen van de actuele nationaliteit van een persoon

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
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000061                           |
      | fields              | nationaliteiten                     |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                              | waarde                                               |
      | type                              | Nationaliteit                                        |
      | nationaliteit.code                | 0001                                                 |
      | nationaliteit.omschrijving        | Nederlandse                                          |
      | redenOpname.code                  | 017                                                  |
      | redenOpname.omschrijving          | Rijkswet op het Nederlanderschap 1984, art. 3, lid 1 |
      | datumIngangGeldigheid.type        | Datum                                                |
      | datumIngangGeldigheid.datum       | 2010-08-01                                           |
      | datumIngangGeldigheid.langFormaat | 1 augustus 2010                                      |

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
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000073                           |
      | fields              | nationaliteiten                     |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                              | waarde                                               |
      | type                              | Nationaliteit                                        |
      | nationaliteit.code                | 0001                                                 |
      | nationaliteit.omschrijving        | Nederlandse                                          |
      | redenOpname.code                  | 017                                                  |
      | redenOpname.omschrijving          | Rijkswet op het Nederlanderschap 1984, art. 3, lid 1 |
      | datumIngangGeldigheid.type        | Datum                                                |
      | datumIngangGeldigheid.datum       | 2019-06-02                                           |
      | datumIngangGeldigheid.langFormaat | 2 juni 2019                                          |

    Scenario: geactualiseerde ingangsdatum geldigheid
      Gegeven de persoon met burgerservicenummer '000000097' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 311                   | 20200713                        |
      En de 'nationaliteit' is gecorrigeerd naar de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 311                   | 20200727                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000097                           |
      | fields              | nationaliteiten |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                              | waarde                                               |
      | type                              | Nationaliteit                                        |
      | nationaliteit.code                | 0100                                                 |
      | nationaliteit.omschrijving        | Algerijnse                                           |
      | redenOpname.code                  | 311                                                  |
      | redenOpname.omschrijving          | Vaststelling onbekende nationaliteit                 |
      | datumIngangGeldigheid.type        | Datum                                                |
      | datumIngangGeldigheid.datum       | 2020-07-27                                           |
      | datumIngangGeldigheid.langFormaat | 27 juli 2020                                         |
