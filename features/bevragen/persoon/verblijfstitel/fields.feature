#language: nl

Functionaliteit: verblijfstitel velden vragen met fields

  Abstract Scenario: 'aanduiding verblijfstitel (39.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                              | waarde |
    | aanduiding verblijfstitel (39.10) | 09     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                    | waarde                         |
    | aanduiding.code         | 09                             |
    | aanduiding.omschrijving | Art. 9 van de Vreemdelingenwet |

    Voorbeelden:
    | fields                                 |
    | verblijfstitel.aanduiding              |
    | verblijfstitel.aanduiding.code         |
    | verblijfstitel.aanduiding.omschrijving |

  Abstract Scenario: 'datum ingang verblijfstitel (39.30)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                                | waarde   |
    | aanduiding verblijfstitel (39.10)   | 09       |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                    | waarde          |
    | datumIngang.type        | Datum           |
    | datumIngang.datum       | 1998-02-01      |
    | datumIngang.langFormaat | 1 februari 1998 |

    Voorbeelden:
    | fields                                 |
    | verblijfstitel.datumIngang             |
    | verblijfstitel.datumIngang.type        |
    | verblijfstitel.datumIngang.datum       |
    | verblijfstitel.datumIngang.langFormaat |
    | verblijfstitel.datumIngang.jaar        |
    | verblijfstitel.datumIngang.maand       |
    | verblijfstitel.datumIngang.onbekend    |

  Abstract Scenario: 'datum ingang verblijfstitel (39.30)' van het type '<type>' wordt gevraagd met field pad 'verblijfstitel.datumIngang'
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                                | waarde     |
    | aanduiding verblijfstitel (39.10)   | 09         |
    | datum ingang verblijfstitel (39.30) | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.datumIngang      |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                    | waarde        |
    | datumIngang.type        | <type>        |
    | datumIngang.datum       | <datum>       |
    | datumIngang.jaar        | <jaar>        |
    | datumIngang.maand       | <maand>       |
    | datumIngang.onbekend    | <onbekend>    |
    | datumIngang.langFormaat | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
    | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
    | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
    | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

  Abstract Scenario: 'datum einde verblijfstitel (39.20)' met waarde in de toekomst wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                                | waarde   |
    | aanduiding verblijfstitel (39.10)   | 09       |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    En de 'verblijfstitel' is gewijzigd naar de volgende gegevens
    | naam                                | waarde   |
    | aanduiding verblijfstitel (39.10)   | 09       |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    | datum einde verblijfstitel (39.20)  | 20251231 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                   | waarde           |
    | datumEinde.type        | Datum            |
    | datumEinde.datum       | 2025-12-31       |
    | datumEinde.langFormaat | 31 december 2025 |

    Voorbeelden:
    | fields                                |
    | verblijfstitel.datumEinde             |
    | verblijfstitel.datumEinde.type        |
    | verblijfstitel.datumEinde.datum       |
    | verblijfstitel.datumEinde.langFormaat |
    | verblijfstitel.datumEinde.jaar        |
    | verblijfstitel.datumEinde.maand       |
    | verblijfstitel.datumEinde.onbekend    |

  Abstract Scenario: 'datum einde verblijfstitel (39.20)' met type '<type>' en waarde in de toekomst wordt gevraagd met field pad 'verblijfstitel.datumEinde'
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | naam                                | waarde   |
    | aanduiding verblijfstitel (39.10)   | 09       |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    En de 'verblijfstitel' is gewijzigd naar de volgende gegevens
    | naam                                | waarde     |
    | aanduiding verblijfstitel (39.10)   | 09         |
    | datum ingang verblijfstitel (39.30) | 19980201   |
    | datum einde verblijfstitel (39.20)  | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.datumEinde       |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                   | waarde        |
    | datumEinde.type        | <type>        |
    | datumEinde.datum       | <datum>       |
    | datumEinde.jaar        | <jaar>        |
    | datumEinde.maand       | <maand>       |
    | datumEinde.onbekend    | <onbekend>    |
    | datumEinde.langFormaat | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
    | Datum          | 20300308 | 2030-03-08 |      |       |          | 8 maart 2030 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
    | JaarDatum      | 20300000 |            | 2030 |       |          | 2030         |
    | JaarMaandDatum | 20300300 |            | 2030 | 3     |          | maart 2030   |
