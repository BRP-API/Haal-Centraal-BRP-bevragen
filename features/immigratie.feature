#language: nl

Functionaliteit: Immigratie

  Rule: indicatieVestigingVanuitBuitenland wordt opgenomen met de waarde true wanneer datumVestigingInNederland een waarde heeft

    Abstract Scenario: persoon heeft datumVestigingInNederland
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde            |
      | datum vestiging in Nederland (14.20) | <datum vestiging> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000152                          |
      | fields              | indicatieVestigingVanuitBuitenland |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                               | waarde |
      | indicatieVestigingVanuitBuitenland | true   |

      Voorbeelden:
      | datum vestiging |
      | 20080123        |
      | 19871100        |
      | 19560000        |
      | 00000000        |

  Rule: vanuitVerblijfplaatsOnbekend krijgt de waarde true wanneer land van waar ingeschreven de waarde '0000' (onbekend) heeft
    
    Scenario: persoon heeft land van waar ingeschreven onbekend
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde |
      | land vanwaar ingeschreven (14.10) | 0000   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                          |
      | type                | RaadpleegMetBurgerservicenummer                                 |
      | burgerservicenummer | 000000152                                                       |
      | fields              | vanuitVerblijfplaatsOnbekend,indicatieVestigingVanuitBuitenland |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                         | waarde |
      | vanuitVerblijfplaatsOnbekend | true   |

    Scenario: persoon heeft land vanwaar ingeschreven ongelijk aan '0000'
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde   |
      | land vanwaar ingeschreven (14.10)    | 9088     |
      | datum vestiging in Nederland (14.20) | 00000000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                          |
      | type                | RaadpleegMetBurgerservicenummer                                 |
      | burgerservicenummer | 000000152                                                       |
      | fields              | vanuitVerblijfplaatsOnbekend,indicatieVestigingVanuitBuitenland |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                               | waarde |
      | indicatieVestigingVanuitBuitenland | true   |