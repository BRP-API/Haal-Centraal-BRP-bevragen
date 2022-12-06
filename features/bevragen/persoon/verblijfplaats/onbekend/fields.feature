#language: nl

Functionaliteit: verblijfplaats onbekend velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | land adres buitenland (13.10)      | 0000     |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | datum ingang geldigheid (85.10)    | 20220222 |
    | functie adres (10.10)              | W        |
    En de persoon met burgerservicenummer '000000153' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | land adres buitenland (13.10)          | 0000     |
    | datum aanvang adres buitenland (13.20) | 20160808 |
    | datum ingang geldigheid (85.10)        | 20200222 |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                 |
    | type                 | VerblijfplaatsOnbekend |
    | datumVan.type        | Datum                  |
    | datumVan.datum       | 2015-08-08             |
    | datumVan.langFormaat | 8 augustus 2015        |

    Voorbeelden:
    | fields                  |
    | verblijfplaats.datumVan |

  Abstract Scenario: 'datum aanvang adres buitenland (13.20)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000153                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                 |
    | type                 | VerblijfplaatsOnbekend |
    | datumVan.type        | Datum                  |
    | datumVan.datum       | 2016-08-08             |
    | datumVan.langFormaat | 8 augustus 2016        |

    Voorbeelden:
    | fields                  |
    | verblijfplaats.datumVan |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                 |
    | type                              | VerblijfplaatsOnbekend |
    | datumIngangGeldigheid.type        | Datum                  |
    | datumIngangGeldigheid.datum       | 2022-02-22             |
    | datumIngangGeldigheid.langFormaat | 22 februari 2022       |

    Voorbeelden:
    | fields                               |
    | verblijfplaats.datumIngangGeldigheid |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000153                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                 |
    | type                              | VerblijfplaatsOnbekend |
    | datumIngangGeldigheid.type        | Datum                  |
    | datumIngangGeldigheid.datum       | 2020-02-22             |
    | datumIngangGeldigheid.langFormaat | 22 februari 2020       |

    Voorbeelden:
    | fields                               |
    | verblijfplaats.datumIngangGeldigheid |

  Abstract Scenario: 'functie adres (10.10)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde                 |
    | type                      | VerblijfplaatsOnbekend |
    | functieAdres.code         | W                      |
    | functieAdres.omschrijving | woonadres              |

    Voorbeelden:
    | fields                                   |
    | verblijfplaats.functieAdres              |
    | verblijfplaats.functieAdres.code         |
    | verblijfplaats.functieAdres.omschrijving |
