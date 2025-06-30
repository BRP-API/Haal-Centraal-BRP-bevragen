#language: nl

Functionaliteit: nationaliteit velden vragen met fields

Regel: een nationaliteit heeft de type 'Nationaliteit' wanneer de waarde van 'nationaliteit (05.10)' ongelijk is aan 0000, 0002, 0499, 0500

  Abstract Scenario: waarde van 'nationaliteit (05.10)' is gelijk aan '<code>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                       | waarde         |
    | type                       | Nationaliteit  |
    | nationaliteit.code         | <code>         |
    | nationaliteit.omschrijving | <omschrijving> |

    Voorbeelden:
    | code | omschrijving |
    | 0001 | Nederlandse  |
    | 0263 | Surinaamse   |

Regel: een nationaliteit heeft de type 'Staatloos' wanneer de waarde van 'nationaliteit (05.10)' gelijk is aan 0499

  Scenario: waarde van 'nationaliteit (05.10)' is gelijk aan '0499'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0499   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde    |
    | type | Staatloos |

Regel: een nationaliteit heeft de type 'BehandeldAlsNederlander' wanneer de waarde van 'nationaliteit (05.10)' gelijk is aan 0002 of als de waarde van 'bijzonder Nederlanderschap (65.10)' gelijk is aan 'B'

  Abstract Scenario: waarde van '<element>' is gelijk aan '<code>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam      | waarde |
    | <element> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                  |
    | type | BehandeldAlsNederlander |

    Voorbeelden:
    | element                            | code |
    | bijzonder Nederlanderschap (65.10) | B    |
    | nationaliteit (05.10)              | 0002 |

Regel: een nationaliteit heeft de type 'VastgesteldNietNederlander' wanneer de waarde van 'nationaliteit (05.10)' gelijk is aan 0500 of als de waarde van 'bijzonder Nederlanderschap (65.10)' gelijk is aan 'V'

  Abstract Scenario: waarde van '<element>' is gelijk aan '<code>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam      | waarde |
    | <element> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                     |
    | type | VastgesteldNietNederlander |

    Voorbeelden:
    | element                            | code |
    | bijzonder Nederlanderschap (65.10) | V    |
    | nationaliteit (05.10)              | 0500 |

Regel: een nationaliteit heeft de type 'Onbekend' wanneer de waarde van 'nationaliteit (05.10)' gelijk is aan 0000

  Scenario: waarde van 'nationaliteit (05.10)' is gelijk aan '0000'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                |
    | type | NationaliteitOnbekend |

Regel: een persoon kan meerdere actuele nationaliteiten hebben

  Scenario: persoon heeft meerdere nationaliteiten
   Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0263   |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0455   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                       | waarde        |
    | type                       | Nationaliteit |
    | nationaliteit.code         | 0263          |
    | nationaliteit.omschrijving | Surinaamse    |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam                       | waarde         |
    | type                       | Nationaliteit  |
    | nationaliteit.code         | 0455           |
    | nationaliteit.omschrijving | Montenegrijnse |

Regel: een beëindigde nationaliteit wordt niet geleverd

  Scenario: persoon heeft alleen een beëindigde nationaliteit
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    En de 'nationaliteit' is gewijzigd naar de volgende gegevens
    | naam                            | waarde |
    | reden beëindigen (64.10)        | 410    |
    | datum ingang geldigheid (85.10) | morgen |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon zonder 'nationaliteit' gegevens
