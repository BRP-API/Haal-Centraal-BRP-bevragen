#language: nl

@proxy
Functionaliteit: Immigratie

  Rule: indicatieVestigingVanuitBuitenland wordt opgenomen met de waarde true wanneer datumVestigingInNederland een waarde heeft

    Abstract Scenario: persoon heeft datumVestigingInNederland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'immigratie' gegevens
      | naam                                 | waarde            |
      | datum vestiging in nederland (14.20) | <datum vestiging> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
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
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft de volgende 'immigratie' gegevens
      | naam                                 | waarde   |
      | land van waar ingeschreven (14.10)   | 0000     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                          |
      | type                | RaadpleegMetBurgerservicenummer                                 |
      | burgerservicenummer | 555550002                                                       |
      | fields              | vanuitVerblijfplaatsOnbekend,indicatieVestigingVanuitBuitenland |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                               | waarde |
      | indicatieVestigingVanuitBuitenland | true   |
      | vanuitVerblijfplaatsOnbekend       | true   |

    Scenario: persoon heeft land van waar ingeschreven ongelijk aan '0000'
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft de volgende 'immigratie' gegevens
      | naam                                 | waarde   |
      | land van waar ingeschreven (14.10)   | 9088     |
      | datum vestiging in nederland (14.20) | 00000000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                          |
      | type                | RaadpleegMetBurgerservicenummer                                 |
      | burgerservicenummer | 555550003                                                       |
      | fields              | vanuitVerblijfplaatsOnbekend,indicatieVestigingVanuitBuitenland |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                               | waarde |
      | indicatieVestigingVanuitBuitenland | true   |