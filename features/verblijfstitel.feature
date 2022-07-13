# language: nl

Functionaliteit: Verblijfstitel

  @gba
  Rule: een verblijfstitel wordt alleen geleverd wanneer die nog geldig is
    - een verblijfstitel wordt geleverd wanneer Datum einde verblijfstitel (39.20) leeg is of een datum in de toekomst heeft
    - een verblijfstitel wordt NIET geleverd wanneer Datum einde verblijfstitel (39.20) vandaag is of een datum in het verleden heeft

    @gba
    Abstract Scenario: verblijfstitel heeft <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfstitel' gegevens
      | naam                                | waarde       |
      | Aanduiding verblijfstitel (39.10)   | 37           |
      | Datum einde verblijfstitel (39.20)  | <datumEinde> |
      | Ingangsdatum verblijfstitel (39.30) | 20210315     |
      Als personen op '5 juni 2022' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfstitel.aanduiding.code  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfstitel' gegevens
      | naam            | waarde |
      | aanduiding.code | 37     |

      Voorbeelden:
      | titel                       | datumEinde |
      | geen datum einde            |            |
      | datum einde in de toekomst  | 20350315   |
      | datum einde is morgen       | 20220606   |

    @gba
    Abstract Scenario: verblijfstitel heeft <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft de volgende 'verblijfstitel' gegevens
      | naam                                | waarde       |
      | Aanduiding verblijfstitel (39.10)   | 37           |
      | Datum einde verblijfstitel (39.20)  | <datumEinde> |
      | Ingangsdatum verblijfstitel (39.30) | 20210315     |
      Als personen op '5 juni 2022' wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 555550002                                          |
      | fields              | burgerservicenummer,verblijfstitel.aanduiding.code |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |

      Voorbeelden:
      | titel                       | datumEinde |
      | datum einde is vandaag      | 20220605   |
      | datum einde in het verleden | 20220315   |

  Rule: een verblijfstitel met aanduiding 98 "geen verblijfstitel (meer)" wordt niet opgenomen

    Scenario: vervallen verblijfstitel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft de volgende 'verblijfstitel' gegevens
      | naam                                | waarde   |
      | Aanduiding verblijfstitel (39.10)   | 98       |
      | Ingangsdatum verblijfstitel (39.30) | 20210315 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                        |
      | type                | RaadpleegMetBurgerservicenummer               |
      | burgerservicenummer | 555550003                                     |
      | fields              | burgerservicenummer,verblijfstitel.aanduiding |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
