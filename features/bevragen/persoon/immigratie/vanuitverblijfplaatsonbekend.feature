#language: nl

Functionaliteit: vertaal waarde van land vanwaaringeschreven naar vanuitverblijfplaatsonbekend

Rule: onbekend land vanwaar ingeschreven (waarde 0000) geeft vanuitVerblijfplaatsOnbekend met de waarde true

  Abstract Scenario: vanuitVerblijfplaatsOnbekend bij land '<land>'
    Gegeven de persoon met burgerservicenummer '000000395' heeft de volgende 'verblijfplaats' gegevens 
    | naam                                 | waarde  |
    | datum vestiging in Nederland (14.20) | <datum> |
    | land vanwaar ingeschreven (14.10)    | <land>  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000395                               |
    | fields              | immigratie.vanuitVerblijfplaatsOnbekend |
    Dan heeft de response een persoon met alleen de volgende 'immigratie' gegevens
    | naam                               | waarde                               |
    | vanuitVerblijfplaatsOnbekend       | <vanuitVerblijfplaatsOnbekend>       |

    Voorbeelden:
    | datum    | land | vanuitVerblijfplaatsOnbekend |
    | 19870214 | 0000 | true                         |
    | 00000000 | 0000 | true                         |
