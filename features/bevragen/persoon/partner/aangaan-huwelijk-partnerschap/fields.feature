#language: nl

Functionaliteit: Persoon: partner aangaan huwelijk/geregistreerd partnerschap velden vragen met fields

  Abstract Scenario: 'datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde   |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20180808 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam              | waarde          |
    | datum.type        | Datum           |
    | datum.datum       | 2018-08-08      |
    | datum.langFormaat | 8 augustus 2018 |

    Voorbeelden:
    | fields                                                 |
    | partners.aangaanHuwelijkPartnerschap.datum             |
    | partners.aangaanHuwelijkPartnerschap.datum.type        |
    | partners.aangaanHuwelijkPartnerschap.datum.datum       |
    | partners.aangaanHuwelijkPartnerschap.datum.langFormaat |
    | partners.aangaanHuwelijkPartnerschap.datum.jaar        |
    | partners.aangaanHuwelijkPartnerschap.datum.maand       |
    | partners.aangaanHuwelijkPartnerschap.datum.onbekend    |

  Abstract Scenario: 'datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)' van het type '<type>' wordt gevraagd met field pad 'partners.aangaanHuwelijkPartnerschap.datum'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde     |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                     |
    | type                | RaadpleegMetBurgerservicenummer            |
    | burgerservicenummer | 000000012                                  |
    | fields              | partners.aangaanHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam              | waarde        |
    | datum.type        | <type>        |
    | datum.datum       | <datum>       |
    | datum.jaar        | <jaar>        |
    | datum.maand       | <maand>       |
    | datum.onbekend    | <onbekend>    |
    | datum.langFormaat | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
    | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
    | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
    | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

  Abstract Scenario: 'plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                                | waarde |
    | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0599   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam                | waarde    |
    | plaats.code         | 0599      |
    | plaats.omschrijving | Rotterdam |

    Voorbeelden:
    | fields                                                   |
    | partners.aangaanHuwelijkPartnerschap.plaats              |
    | partners.aangaanHuwelijkPartnerschap.plaats.code         |
    | partners.aangaanHuwelijkPartnerschap.plaats.omschrijving |

  Abstract Scenario: 'plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                                | waarde |
    | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | fields                                      |
    | partners.aangaanHuwelijkPartnerschap.plaats |

  Abstract Scenario: 'land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                              | waarde |
    | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | 6014   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

    Voorbeelden:
    | fields                                                 |
    | partners.aangaanHuwelijkPartnerschap.land              |
    | partners.aangaanHuwelijkPartnerschap.land.code         |
    | partners.aangaanHuwelijkPartnerschap.land.omschrijving |

  Abstract Scenario: 'land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                              | waarde |
    | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | fields                                    |
    | partners.aangaanHuwelijkPartnerschap.land |
