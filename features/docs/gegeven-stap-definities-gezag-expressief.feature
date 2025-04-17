# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Een persoon benoemen we functioneel met een naam en technisch met een burgerservicenummer
    Standaard is een persoon in Nederland geboren met een Nederlandse geboorteakte.

    Scenario: de persoon '{naam}' met burgerservicenummer '{bsn}'
      Gegeven de persoon 'P1' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
        |                   000000012 | P1                    |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |    P1 |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        |    P1 | P            |         0 |       0 |         000000012 | P1             |

    Scenario: '{naam}' is minderjarig
      Gegeven de persoon 'P2' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
        |                   000000012 | P2                    |
      Gegeven de persoon 'P1' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
        |                   000000024 | P1                    |
      En persoon 'P2'
      * is minderjarig
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |    P2 |          0 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     |
        |    P2 | P            |         0 |       0 |         000000012 | P2             | gisteren - 17 jaar |
      En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |    P1 |          0 |
      En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        |    P1 | P            |         0 |       0 |         000000024 | P1             |
