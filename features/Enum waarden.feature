#language: nl

Functionaliteit: Genereerbare en leesbare enum waarden

Abstract Scenario: Indicatie gezag minderjarige
    Gegeven element 'Indicatie gezag minderjarige' van een ingeschreven persoon bevat de waarde <gba waarde>
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is indicatieGezagMinderjarige van de ingeschreven persoon gelijk aan <enum waarde>

    Voorbeelden:
    | gba waarde | enum waarde      |
    | 1          | ouder1           |
    | 2          | ouder2           |
    | D          | derden           |
    | 1D         | ouder1_en_derde  |
    | 2D         | ouder2_en_derde  |
    | 12         | ouder1_en_ouder2 |