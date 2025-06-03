# language: nl
@stap-documentatie @integratie
Functionaliteit: persona wijzigingen stap definities

  Scenario: is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door Nederlandse adoptieouder {string} met een Nederlandse adoptieakte
    Gegeven de minderjarige persoon 'Jan' met één ouder 'Petra'
    * is 1 jaar geleden geadopteerd door Nederlandse adoptieouder 'Piet' met een Nederlandse adoptieakte
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar  | V              | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Piet  |          0 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Piet  |         0 |       0 | P            |         000000104 | Piet           | morgen - 37 jaar | M              | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Piet  |         0 |       0 | K            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_Q____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Jan   |         0 |       1 | P            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_A____ |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_Q____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            1 | gisteren - 17 jaar         | 1_A____ |         000000101 | Petra          | morgen - 37 jaar | V              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | akte_nr | geldigheid_start_datum |
      | Jan   |         0 |       1 |            2 | 1_A____ | gisteren - 17 jaar     |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | familie_betrek_start_datum | akte_nr |
      | Jan   |         0 |       0 |            2 |         000000104 | Piet           | morgen - 37 jaar | M              | vandaag - 1 jaar           | 1_Q____ |

  Scenario: is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door twee Nederlandse adoptieouders {moeder} en {vader} met een Nederlandse adoptieakte
    Gegeven de minderjarige persoon 'Jan' met één ouder 'Petra'
    * is 1 jaar geleden geadopteerd door twee Nederlandse adoptieouders 'Paula' en 'Piet' met een Nederlandse adoptieakte
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_A____ |
    Dan heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Paula |          0 |
    En heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Paula |         0 |       0 | P            |         000000104 | Paula          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Paula |         0 |       0 | K            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_Q____ |
    Dan heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Piet  |          0 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Piet  |         0 |       0 | P            |         000000105 | Piet           | morgen - 37 jaar | M              | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Piet  |         0 |       0 | K            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_Q____ |
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Jan   |         0 |       1 | P            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_A____ |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_Q____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       1 |            1 | gisteren - 17 jaar         | 1_A____ |         000000101 | Petra          | morgen - 37 jaar | V              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | familie_betrek_start_datum | akte_nr |
      | Jan   |         0 |       0 |            1 |         000000104 | Paula          | morgen - 37 jaar | V              | vandaag - 1 jaar           | 1_Q____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | akte_nr | geldigheid_start_datum |
      | Jan   |         0 |       1 |            2 | 1_A____ | gisteren - 17 jaar     |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | familie_betrek_start_datum | akte_nr |
      | Jan   |         0 |       0 |            2 |         000000105 | Piet           | morgen - 37 jaar | M              | vandaag - 1 jaar           | 1_Q____ |
