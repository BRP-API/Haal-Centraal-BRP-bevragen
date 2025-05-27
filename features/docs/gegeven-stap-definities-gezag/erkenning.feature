# language: nl
@integratie @stap-documentatie
Functionaliteit: Erkenning

  Scenario: {kind} is erkend door {ouder} op {datum}
    Gegeven de gisteren 45 jaar geleden geboren vrouw 'P1'
    En de morgen 17 jaar geleden geboren 'P2'
    En 'P2' is erkend door 'P1' op 1-2-2023
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P1    |          0 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum     | burger_service_nr | geslachts_aand | geboorte_land_code | akte_nr |
      | P1    |         0 |       0 | P            | P1             | gisteren - 45 jaar |         000000012 | V              |               6030 | 1_A____ |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | akte_nr | geboorte_datum   |
      | P1    |         0 |       0 | K            |         000000024 | P2             | 1_C____ | morgen - 17 jaar |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P2    |          0 |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum   | burger_service_nr | geboorte_land_code | akte_nr |
      | P2    |         0 |       1 | P            | P2             | morgen - 17 jaar |         000000024 |               6030 | 1_A____ |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum   | burger_service_nr | geboorte_land_code | akte_nr |
      | P2    |         0 |       0 | P            | P2             | morgen - 17 jaar |         000000024 |               6030 | 1_C____ |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | akte_nr | familie_betrek_start_datum | geslachts_aand | geboorte_datum     |
      | P2    |         0 |       0 |            1 |         000000012 | P1             | 1_C____ |                   20230201 | V              | gisteren - 45 jaar |

  Scenario: {kind} is erkend door {ouder} bij geboorteaangifte
    Gegeven de gisteren 45 jaar geleden geboren vrouw 'P1'
    En de morgen 17 jaar geleden geboren 'P2'
    En 'P2' is erkend door 'P1' bij geboorteaangifte
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P1    |          0 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum     | burger_service_nr | geslachts_aand | geboorte_land_code | akte_nr |
      | P1    |         0 |       0 | P            | P1             | gisteren - 45 jaar |         000000012 | V              |               6030 | 1_A____ |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | akte_nr | geboorte_datum   |
      | P1    |         0 |       0 | K            |         000000024 | P2             | 1_B____ | morgen - 17 jaar |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P2    |          0 |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum   | burger_service_nr | geboorte_land_code | akte_nr |
      | P2    |         0 |       1 | P            | P2             | morgen - 17 jaar |         000000024 |               6030 | 1_A____ |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum   | burger_service_nr | geboorte_land_code | akte_nr |
      | P2    |         0 |       0 | P            | P2             | morgen - 17 jaar |         000000024 |               6030 | 1_B____ |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | akte_nr | familie_betrek_start_datum |
      | P2    |         0 |       0 |            1 |         000000012 | P1             | 1_B____ | morgen - 17 jaar           |

  Abstract Scenario: {kind} is erkend door {ouder} {na geboorteaangifte|bij notariële akte|met gerechtelijke vaststelling ouderschap} op {datum}
    Gegeven de gisteren 45 jaar geleden geboren vrouw 'P1'
    En de morgen 17 jaar geleden geboren 'P2'
    En 'P2' is erkend door 'P1' <soort erkenning> op 1-2-2023
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P1    |          0 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum     | burger_service_nr | geslachts_aand | geboorte_land_code | akte_nr |
      | P1    |         0 |       0 | P            | P1             | gisteren - 45 jaar |         000000012 | V              |               6030 | 1_A____ |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | akte_nr       | geboorte_datum   |
      | P1    |         0 |       0 | K            |         000000024 | P2             | <akte nummer> | morgen - 17 jaar |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P2    |          0 |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum   | burger_service_nr | geboorte_land_code | akte_nr |
      | P2    |         0 |       1 | P            | P2             | morgen - 17 jaar |         000000024 |               6030 | 1_A____ |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geboorte_datum   | burger_service_nr | geboorte_land_code | akte_nr       |
      | P2    |         0 |       0 | P            | P2             | morgen - 17 jaar |         000000024 |               6030 | <akte nummer> |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | akte_nr       | familie_betrek_start_datum |
      | P2    |         0 |       0 |            1 |         000000012 | P1             | <akte nummer> |                   20230201 |

    Voorbeelden:
      | soort erkenning                           | akte nummer |
      | na geboorteaangifte                       |     1_C____ |
      | bij notariële akte                        |     1_J____ |
      | met gerechtelijke vaststelling ouderschap |     1_V____ |

  Scenario: er is al een lege categorie ouder 2 en {aanduidingMinderjarige} is erkend door {aanduidingErkenner} na geboorteaangifte op {datum}
    Gegeven de minderjarige persoon 'P1' met één ouder 'P2'
    En de gisteren 35 jaar geleden geboren man 'P3'
    En 'P1' is erkend door 'P3' na geboorteaangifte op 13-05-2024
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P1    |          0 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | akte_nr |
      | P1    |         0 |       1 | P            | P1             | 1_A____ |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | akte_nr |
      | P1    |         0 |       0 | P            | P1             | 1_C____ |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam | geslachts_aand | familie_betrek_start_datum | akte_nr |
      | P1    |         0 |       0 |            1 | P2             | V              | gisteren - 17 jaar         | 1_A____ |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | akte_nr | geldigheid_start_datum | geslachts_naam | familie_betrek_start_datum |
      | P1    |         0 |       1 |            2 | 1_A____ | gisteren - 17 jaar     |                |                            |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | akte_nr | geslachts_naam | geboorte_datum     | geslachts_aand | familie_betrek_start_datum |
      | P1    |         0 |       0 |            2 | 1_C____ | P3             | gisteren - 35 jaar | M              |                   20240513 |
