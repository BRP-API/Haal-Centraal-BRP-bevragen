# language: nl

Functionaliteit: Verblijfstitel

  @gba
  Rule: een verblijfstitel wordt alleen geleverd wanneer die nog geldig is
    - een verblijfstitel wordt geleverd wanneer Datum einde verblijfstitel (39.20) leeg is of een datum in de toekomst heeft
    - een verblijfstitel wordt NIET geleverd wanneer Datum einde verblijfstitel (39.20) vandaag is of een datum in het verleden heeft

    @gba
    Scenario: verblijfstitel heeft geen datum einde
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'verblijfstitel' gegevens
      | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) |
      | 37                                | 20210315                            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | verblijfstitel.aanduiding.code  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfstitel' gegevens
      | naam            | waarde |
      | aanduiding.code | 37     |

    @gba
    Abstract Scenario: verblijfstitel heeft <titel>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfstitel' gegevens
      | aanduiding verblijfstitel (39.10) | datum einde verblijfstitel (39.20) | datum ingang verblijfstitel (39.30) |
      | 37                                | <datumEinde>                       | 20210315                            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfstitel.aanduiding.code  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfstitel' gegevens
      | naam            | waarde |
      | aanduiding.code | 37     |

      Voorbeelden:
      | titel                      | datumEinde |
      | datum einde in de toekomst | 20350315   |
      | datum einde is morgen      | 20220606   |

    @gba
    Abstract Scenario: verblijfstitel heeft <titel>
      Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfstitel' gegevens
      | aanduiding verblijfstitel (39.10)   | datum einde verblijfstitel (39.20)  | datum ingang verblijfstitel (39.30) |
      | 37                                  | <datumEinde>                        | 20210315                            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 000000036                                          |
      | fields              | burgerservicenummer,verblijfstitel.aanduiding.code |
      Dan heeft de response een persoon met alleen de volgende 'persoon' gegevens
      | naam                | waarde    |
      | burgerservicenummer | 0000036 |

      Voorbeelden:
      | titel                       | datumEinde |
      | datum einde is vandaag      | 20220605   |
      | datum einde in het verleden | 20220315   |

  Rule: een verblijfstitel met aanduiding 98 "geen verblijfstitel (meer)" wordt niet opgenomen

    Scenario: vervallen verblijfstitel
      Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende 'verblijfstitel' gegevens
      | aanduiding verblijfstitel (39.10)| datum ingang verblijfstitel (39.30) |
      | 98                               | 20210315                            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                        |
      | type                | RaadpleegMetBurgerservicenummer               |
      | burgerservicenummer | 555550003                                     |
      | fields              | burgerservicenummer,verblijfstitel.aanduiding |
      Dan heeft de response een persoon met alleen de volgende 'persoon' gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |

  Rule: Een verblijfstitel met onbekende aanduiding wordt wel geleverd

    Scenario: persoon heeft verblijfstitel maar het is nog onbekend welke
      Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende 'verblijfstitel' gegevens
      | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) |
      | 00                                | 20210714                            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | verblijfstitel                  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfstitel' gegevens
      | naam                    | waarde       |
      | aanduiding.code         | 00           |
      | datumIngang.type        | Datum        |
      | datumIngang.datum       | 2021-07-14   |
      | datumIngang.langFormaat | 14 juli 2021 |
