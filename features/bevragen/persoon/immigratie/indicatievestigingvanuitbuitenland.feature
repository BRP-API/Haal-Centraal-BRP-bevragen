#language: nl

Functionaliteit: Persoon: immigratie veld 'indicatieVestigingVanuitBuitenland' vragen met fields

Regel: indicatieVestigingVanuitBuitenland wordt geleverd met de waarde true wanneer datumVestigingInNederland een waarde heeft

  Abstract Scenario: 'datum vestiging in Nederland (14.20)' wordt gevraagd met field pad 'immigratie.indicatieVestigingVanuitBuitenland'
    Gegeven de persoon met burgerservicenummer '000000395' heeft de volgende 'verblijfplaats' gegevens 
    | naam                                 | waarde  |
    | datum vestiging in Nederland (14.20) | <datum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 000000395                                     |
    | fields              | immigratie.indicatieVestigingVanuitBuitenland |
    Dan heeft de response een persoon met alleen de volgende 'immigratie' gegevens
    | naam                               | waarde                               |
    | indicatieVestigingVanuitBuitenland | true |

    Voorbeelden:
    | datum    |
    | 19870214 |
    | 19490000 | 
    | 19931100 |
    | 00000000 |