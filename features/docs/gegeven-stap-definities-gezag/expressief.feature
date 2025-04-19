# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Een persoon benoemen we functioneel met een naam en technisch met een burgerservicenummer
    Standaard is een persoon in Nederland geboren met een Nederlandse geboorteakte.

    @integratie
    Scenario: de persoon '{naam}' met burgerservicenummer '{bsn}'
      Gegeven de persoon 'P1' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
        |                   000000012 | P1                    |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        | P1    | P            |         0 |       0 |         000000012 | P1             |

  Regel: Een persoon benoemen we functioneel met een naam en technisch met een burgerservicenummer
    Standaard is een persoon in Nederland geboren met een Nederlandse geboorteakte.

    @integratie
    Scenario: de persoon '{naam}' met burgerservicenummer '{bsn}'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |

  Regel: Je kan de context wijzigen naar een eerder opgevoerde persoon

    @integratie
    Scenario: persoon '{naam}'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En persoon 'P1'
      * is meerderjarig
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
      En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |               6030 | 1AA0100 |
