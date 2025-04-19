# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Geslachtsaanduiding wordt toegevoegd aan de persoon

    @integratie
    Scenario: is een <geslacht>
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is een <geslacht>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | geslachts_aand        |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 | <geslacht aanduiding> |

      Voorbeelden:
        | geslacht | geslacht aanduiding |
        | vrouw    | V                   |
        | man      | M                   |
