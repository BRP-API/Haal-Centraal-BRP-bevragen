#language: nl

Functionaliteit: Persoon velden vragen met fields

  Abstract Scenario: 'anummer (01.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam            | waarde     |
    | anummer (01.10) | 1234567890 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam    | waarde     |
    | aNummer | 1234567890 |

    Voorbeelden:
    | fields  |
    | aNummer |

  Abstract Scenario: 'burgerservicenummer (01.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam            | waarde     |
    | anummer (01.10) | 1234567890 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

    Voorbeelden:
    | fields              |
    | burgerservicenummer |

  Abstract Scenario: 'datum eerste inschrijving GBA (68.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                  | waarde   |
    | datum eerste inschrijving GBA (68.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                   | waarde      |
    | datumEersteInschrijvingGBA.type        | Datum       |
    | datumEersteInschrijvingGBA.datum       | 2002-07-01  |
    | datumEersteInschrijvingGBA.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | fields                                 |
    | datumEersteInschrijvingGBA             |
    | datumEersteInschrijvingGBA.type        |
    | datumEersteInschrijvingGBA.datum       |
    | datumEersteInschrijvingGBA.langFormaat |

  Abstract Scenario: 'datum inschrijving in de gemeente (09.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde   |
    | datum inschrijving in de gemeente (09.20) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                    | waarde      |
    | datumInschrijvingInGemeente.type        | Datum       |
    | datumInschrijvingInGemeente.datum       | 2002-07-01  |
    | datumInschrijvingInGemeente.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | fields                                  |
    | datumInschrijvingInGemeente             |
    | datumInschrijvingInGemeente.type        |
    | datumInschrijvingInGemeente.datum       |
    | datumInschrijvingInGemeente.langFormaat |

  Scenario: 'indicatie geheim (70.10)' wordt gevraagd met field pad(en) '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 1      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000152 |
    | geheimhoudingPersoonsgegevens | true      |

    Voorbeelden:
    | fields                                            |
    | burgerservicenummer                               |
    | burgerservicenummer,geheimhoudingPersoonsgegevens |

  Abstract Scenario: 'gemeente van inschrijving (09.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | gemeente van inschrijving (09.10) | 0518   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                 | waarde        |
    | gemeenteVanInschrijving.code         | 0518          |
    | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |

    Voorbeelden:
    | fields                               |
    | gemeenteVanInschrijving              |
    | gemeenteVanInschrijving.code         |
    | gemeenteVanInschrijving.omschrijving |

  Abstract Scenario: 'geslachtsaanduiding (04.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                        | waarde |
    | geslachtsaanduiding (04.10) | M      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde |
    | geslacht.code         | M      |
    | geslacht.omschrijving | man    |

    Voorbeelden:
    | fields                |
    | geslacht              |
    | geslacht.code         |
    | geslacht.omschrijving |

  Scenario: 'leeftijd' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde             |
    | geboortedatum (03.10) | gisteren - 20 jaar |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam     | waarde |
    | leeftijd | 20     |

    Voorbeelden:
    | fields   |
    | leeftijd |
