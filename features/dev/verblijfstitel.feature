#language: nl

Functionaliteit: Persoon: verblijfstitel

  Abstract Scenario: persoon heeft 'verblijfstitel' veld: 'aanduiding verblijfstitel (39.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfstitel' gegevens
    | naam                              | waarde |
    | aanduiding verblijfstitel (39.10) | 09     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                    | waarde                         |
    | aanduiding.code         | 09                             |
    | aanduiding.omschrijving | Art. 9 van de Vreemdelingenwet |

    Voorbeelden:
    | field                                  |
    | verblijfstitel.aanduiding              |
    | verblijfstitel.aanduiding.code         |
    | verblijfstitel.aanduiding.omschrijving |

  Abstract Scenario: persoon heeft 'verblijfstitel' datum veld: 'datum ingang verblijfstitel (39.30)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfstitel' gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                    | waarde          |
    | datumIngang.type        | Datum           |
    | datumIngang.datum       | 1998-02-01      |
    | datumIngang.langFormaat | 1 februari 1998 |

    Voorbeelden:
    | naam        |
    | datumIngang |

  Abstract Scenario: persoon heeft 'verblijfstitel' datum veld: 'datum einde verblijfstitel (39.20)' met waarde in de toekomst
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfstitel' gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    En de persoon is gewijzigd naar de volgende 'verblijfstitel' gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    | datum einde verblijfstitel (39.20)  | 20251231 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfstitel' gegevens
    | naam                   | waarde           |
    | datumEinde.type        | Datum            |
    | datumEinde.datum       | 2025-12-31       |
    | datumEinde.langFormaat | 31 december 2025 |

    Voorbeelden:
    | naam       |
    | datumEinde |

  Abstract Scenario: persoon heeft 'verblijfstitel' datum veld: 'datum einde verblijfstitel (39.20)' met waarde gelijk aan vandaag
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfstitel' gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    En de persoon is gewijzigd naar de volgende 'verblijfstitel' gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    | datum einde verblijfstitel (39.20)  | vandaag  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.<naam>           |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | naam       |
    | datumEinde |

  Abstract Scenario: persoon heeft 'verblijfstitel' datum veld: 'datum einde verblijfstitel (39.20)' met waarde in het verleden
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfstitel' gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    En de persoon is gewijzigd naar de volgende 'verblijfstitel' gegevens
    | naam                                | waarde   |
    | datum ingang verblijfstitel (39.30) | 19980201 |
    | datum einde verblijfstitel (39.20)  | gisteren |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfstitel.<naam>           |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | naam       |
    | datumEinde |
