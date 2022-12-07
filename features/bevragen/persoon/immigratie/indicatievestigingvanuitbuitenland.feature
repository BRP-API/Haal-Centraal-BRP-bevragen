#language: nl

Functionaliteit: vertaal waarde van datumVestigingInNederland naar indicatieVestigingVanuitBuitenland

Rule: vertalen waarden naar indicatieVestigingVanuitBuitenland
  - elke waarde voor datumVestigingInNederland (incl. 00000000) geeft indicatieVestigingVanuitBuitenland met de waarde true
 

  Abstract Scenario: indicatieVestigingVanuitBuitenland bij datum vestiging '<datum>' uit land '<land>'
    Gegeven de persoon met burgerservicenummer '000000395' heeft de volgende 'verblijfplaats' gegevens 
    | naam                                 | waarde  |
    | datum vestiging in Nederland (14.20) | <datum> |
    | land vanwaar ingeschreven (14.10)    | <land>  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 000000395                                     |
    | fields              | immigratie.indicatieVestigingVanuitBuitenland |
    Dan heeft de response een persoon met alleen de volgende 'immigratie' gegevens
    | naam                               | waarde                               |
    | indicatieVestigingVanuitBuitenland | <indicatieVestigingVanuitBuitenland> |

    Voorbeelden:
    | datum    | land | indicatieVestigingVanuitBuitenland |
    | 19870214 | 6023 | true                               | 
    | 19490000 | 6024 | true                               | 
    | 19931100 | 6065 | true                               |
    | 00000000 | 6029 | true                               |