# language: nl

@gba
Functionaliteit: Nationaliteit (persoon)

Regel: wanneer één of meerdere velden van een nationaliteit wordt gevraagd, dan wordt ook de waarde van 'nationaliteit (05.10)' geleverd

  Abstract Scenario: alle velden van een nationaliteit wordt gevraagd met field pad 'nationaliteiten'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | <code> |
    | reden opname (63.10)  | 001    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                       | waarde                                            |
    | nationaliteit.code         | <code>                                            |
    | nationaliteit.omschrijving | <omschrijving>                                    |
    | redenOpname.code           | 001                                               |
    | redenOpname.omschrijving   | Wet op het Nederlanderschap 1892, art. 1, onder a |

    Voorbeelden:
    | code | omschrijving |
    | 0000 | Onbekend     |
    | 0001 | Nederlandse  |
    | 0499 | Staatloos    |

  Abstract Scenario: één of meerdere velden van een nationaliteit wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0001     |
    | reden opname (63.10)            | 001      |
    | datum ingang geldigheid (85.10) | 20020701 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                       | waarde          |
    | nationaliteit.code         | 0001            |
    | nationaliteit.omschrijving | Nederlandse     |
    | <naam veld 1>              | <waarde veld 1> |
    | <naam veld 2>              | <waarde veld 2> |

    Voorbeelden:
    | fields                                            | naam veld 1           | waarde veld 1 | naam veld 2              | waarde veld 2                                     |
    | nationaliteiten.type                              |                       |               |                          |                                                   |
    | nationaliteiten.redenOpname                       | redenOpname.code      | 001           | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | nationaliteiten.redenOpname.code                  | redenOpname.code      | 001           | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | nationaliteiten.redenOpname.omschrijving          | redenOpname.code      | 001           | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | nationaliteiten.datumIngangGeldigheid.type        | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.datum       | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.langFormaat | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.jaar        | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.maand       | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.onbekend    | datumIngangGeldigheid | 20020701      |                          |                                                   |

Regel: wanneer 'bijzonder Nederlanderschap (65.10)' is gevuld en één of meerdere velden van nationaliteit wordt gevraagd, dan wordt ook de waarde van 'bijzonder Nederlanderschap (65.10)' geleverd

  Scenario: persoon heeft een nationaliteit waarvan 'bijzonder Nederlanderschap (65.10)' is gevuld en alle velden wordt gevraagd met field pad 'nationaliteiten'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde |
    | bijzonder Nederlanderschap (65.10) | <code> |
    | reden opname (63.10)               | 001    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                | waarde                                            |
    | aanduidingBijzonderNederlanderschap | <code>                                            |
    | redenOpname.code                    | 001                                               |
    | redenOpname.omschrijving            | Wet op het Nederlanderschap 1892, art. 1, onder a |

    Voorbeelden:
    | code |
    | B    |
    | V    |
    
  Abstract Scenario: persoon heeft een nationaliteit waarvan 'bijzonder Nederlanderschap (65.10)' is gevuld en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde   |
    | bijzonder Nederlanderschap (65.10) | <code>   |
    | reden opname (63.10)               | 001      |
    | datum ingang geldigheid (85.10)    | 20020701 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                | waarde          |
    | aanduidingBijzonderNederlanderschap | <code>          |
    | <naam veld 1>                       | <waarde veld 1> |
    | <naam veld 2>                       | <waarde veld 2> |

    Voorbeelden:
    | fields                                            | code | naam veld 1           | waarde veld 1 | naam veld 2              | waarde veld 2                                     |
    | nationaliteiten.type                              | V    |                       |               |                          |                                                   |
    | nationaliteiten.nationaliteit                     | B    |                       |               |                          |                                                   |
    | nationaliteiten.nationaliteit.code                | V    |                       |               |                          |                                                   |
    | nationaliteiten.nationaliteit.omschrijving        | B    |                       |               |                          |                                                   |
    | nationaliteiten.redenOpname                       | B    | redenOpname.code      | 001           | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | nationaliteiten.redenOpname.code                  | V    | redenOpname.code      | 001           | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | nationaliteiten.redenOpname.omschrijving          | B    | redenOpname.code      | 001           | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | nationaliteiten.datumIngangGeldigheid.type        | V    | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.datum       | B    | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.langFormaat | V    | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.jaar        | B    | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.maand       | V    | datumIngangGeldigheid | 20020701      |                          |                                                   |
    | nationaliteiten.datumIngangGeldigheid.onbekend    | B    | datumIngangGeldigheid | 20020701      |                          |                                                   |

Regel: als één of meerdere velden van een nationaliteit wordt gevraagd en de categorie nationaliteit (04) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: '<type>' van een nationaliteit is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde                    |
    | nationaliteit (05.10)           | 0001                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                                      | waarde                    |
    | nationaliteit.code                        | 0001                      |
    | nationaliteit.omschrijving                | Nederlandse               |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | aanduiding in onderzoek | fields                                                            | type                                  |
    | 040000                  | nationaliteiten                                                   | hele categorie nationaliteit          |
    | 040500                  | nationaliteiten.type                                              | hele groep nationaliteit              |
    | 040510                  | nationaliteiten.redenOpname                                       | nationaliteit                         |
    | 046300                  | nationaliteiten.redenOpname.code                                  | hele groep opnemen nationaliteit      |
    | 046310                  | nationaliteiten.redenOpname,nationaliteiten.datumIngangGeldigheid | reden opname nationaliteit            |
    | 046500                  | nationaliteiten.nationaliteit                                     | hele groep bijzonder Nederlanderschap |
    | 046510                  | nationaliteiten.nationaliteit.code                                | aanduiding bijzonder Nederlanderschap |

  Abstract Scenario: persoon heeft nationaliteit waarvan 'bijzonder Nederlanderschap (65.10)' is gevuld en '<type>' van de nationaliteit is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde                    |
    | bijzonder Nederlanderschap (65.10) | B                         |
    | aanduiding in onderzoek (83.10)    | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                                      | waarde                    |
    | aanduidingBijzonderNederlanderschap       | B                         |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | aanduiding in onderzoek | fields                                                            | type                                  |
    | 040000                  | nationaliteiten                                                   | hele categorie nationaliteit          |
    | 040500                  | nationaliteiten.type                                              | hele groep nationaliteit              |
    | 040510                  | nationaliteiten.redenOpname                                       | nationaliteit                         |
    | 046300                  | nationaliteiten.redenOpname.code                                  | hele groep opnemen nationaliteit      |
    | 046310                  | nationaliteiten.redenOpname,nationaliteiten.datumIngangGeldigheid | reden opname nationaliteit            |
    | 046500                  | nationaliteiten.datumIngangGeldigheid                             | hele groep bijzonder Nederlanderschap |
    | 046510                  | nationaliteiten.datumIngangGeldigheid.datum                       | aanduiding bijzonder Nederlanderschap |

  Scenario: onbekend waarde voor nationaliteit
    Gegeven de persoon met burgerservicenummer '000000280' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0000     |
    | reden opname (63.10)            | 311      |
    | datum ingang geldigheid (85.10) | 20030417 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000280                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000280 |
    En heeft de persoon een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde                               |
    | nationaliteit.code                | 0000                                 |
    | nationaliteit.omschrijving        | Onbekend                             |
    | redenOpname.code                  | 311                                  |
    | redenOpname.omschrijving          | Vaststelling onbekende nationaliteit |
    | datumIngangGeldigheid             | 20030417                             |

  Scenario: onbekend waarde voor reden opname nationaliteit
    Gegeven de persoon met burgerservicenummer '000000280' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0052     |
    | reden opname (63.10)            | 000      |
    | datum ingang geldigheid (85.10) | 20030417 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000280                           |
    | fields              | burgerservicenummer,nationaliteiten |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000280 |
    En heeft de persoon een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde    |
    | nationaliteit.code                | 0052      |
    | nationaliteit.omschrijving        | Belgische |
    | redenOpname.code                  | 000       |
    | redenOpname.omschrijving          | Onbekend  |
    | datumIngangGeldigheid             | 20030417  |
