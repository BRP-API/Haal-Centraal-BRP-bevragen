# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Achtergrond:
    Gegeven de tabel 'lo3_pl' bevat geen rijen
    En de tabel 'lo3_pl_persoon' bevat geen rijen

  Regel: Een persoon benoemen we functioneel met een naam en technisch met een burgerservicenummer
    Standaard is een persoon in Nederland geboren met een Nederlandse geboorteakte.

    @integratie
    Scenario: de persoon '{naam}' met burgerservicenummer '{bsn}'
      Gegeven de persoon 'P1' heeft de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
        |                   000000012 | P1                 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        |     1 | P            |         0 |       0 |         000000012 | P1          |

    @integratie
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
      Dan heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     |
        |     2 | P            |         0 |       0 |         000000012 | P2             | gisteren - 17 jaar |
      En heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        |     1 | P            |         0 |       0 |         000000024 | P1             |
