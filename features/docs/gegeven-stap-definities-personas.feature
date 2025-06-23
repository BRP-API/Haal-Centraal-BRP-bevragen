# language: nl
@stap-documentatie @integratie
Functionaliteit: persona stap definities

  Scenario: de {leeftijd omschrijving} persoon {kind} met twee ouders {moeder} en {vader} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
    Gegeven de <leeftijd omschrijving> persoon 'Jan' met twee ouders 'Petra' en 'Piet' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Jan   |         0 |       0 |            1 | <geboortedatum>            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Jan   |         0 |       0 |            2 | <geboortedatum>            |         000000102 | Piet           | morgen - 37 jaar | M              | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Piet  |          0 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Piet  |         0 |       0 | P            |         000000102 | Piet           | morgen - 37 jaar | M              | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Piet  |         0 |       0 | K            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |

    Voorbeelden:
      | leeftijd omschrijving          | geboortedatum      |
      | minderjarige                   | gisteren - 17 jaar |
      | meerderjarige                  | gisteren - 45 jaar |
      |         7 jaar geleden geboren |     7 jaar geleden |
      |             03-11-2024 geboren |           20241103 |
      | op 03-11-2024 geboren          |           20241103 |
      | op 3 november 2024 geboren     |           20241103 |
      | op een onbekende datum geboren |           00000000 |
      | gisteren geboren               | gisteren           |
      | vorige maand geboren           | vorige maand       |

  Scenario: de {leeftijd omschrijving} persoon {kind} met twee ongehuwde ouders {moeder} en {vader}
    Gegeven de <leeftijd omschrijving> persoon 'Jan' met twee ongehuwde ouders 'Petra' en 'Piet'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Jan   |         0 |       0 |            1 | <geboortedatum>            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Jan   |         0 |       0 |            2 | <geboortedatum>            |         000000102 | Piet           | morgen - 37 jaar | M              | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Piet  |          0 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Piet  |         0 |       0 | P            |         000000102 | Piet           | morgen - 37 jaar | M              | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Piet  |         0 |       0 | K            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |

    Voorbeelden:
      | leeftijd omschrijving          | geboortedatum      |
      | minderjarige                   | gisteren - 17 jaar |
      | meerderjarige                  | gisteren - 45 jaar |
      |         7 jaar geleden geboren |     7 jaar geleden |
      |             03-11-2024 geboren |           20241103 |
      | op 03-11-2024 geboren          |           20241103 |
      | op 3 november 2024 geboren     |           20241103 |
      | op een onbekende datum geboren |           00000000 |
      | gisteren geboren               | gisteren           |
      | vorige maand geboren           | vorige maand       |

  Scenario: de {leeftijd omschrijving} persoon {kind} met twee ouders {moeder} en {vader} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren - ouders waren al gedefinieerd
    Gegeven de op 14-10-2002 geboren vrouw 'Paula'
    En de minderjarige persoon 'Jan' met twee ouders 'Petra' en 'Paula' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Jan   |         0 |       0 |            1 | gisteren - 17 jaar         |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | akte_nr |
      | Jan   |         0 |       0 |            2 | gisteren - 17 jaar         |         000000012 | Paula          |       20021014 | V              | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_A____ |
    En heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Paula |          0 |
    En heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | akte_nr |
      | Paula |         0 |       0 | P            |         000000012 | Paula          |       20021014 | V              | 1_A____ |
    En heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Paula |         0 |       0 | K            |         000000103 | Jan            | gisteren - 17 jaar |               6030 | 1_A____ |

  Scenario: de {leeftijd omschrijving} persoon {kind} met twee gehuwde ouders {moeder} en {vader}
    Gegeven de <leeftijd omschrijving> persoon 'Jan' met twee gehuwde ouders 'Petra' en 'Piet'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            1 | <geboortedatum>            | 1_A____ |         000000101 | Petra          | morgen - 37 jaar | V              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            2 | <geboortedatum>            | 1_A____ |         000000102 | Piet           | morgen - 37 jaar | M              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort | akte_nr |
      | Petra |         0 |       0 | R            |         000000102 | Piet           | morgen - 37 jaar | M              | gisteren - 20 jaar  |                 0518 |                    6030 | H                 | 3XA1224 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Piet  |          0 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Piet  |         0 |       0 | P            |         000000102 | Piet           | morgen - 37 jaar | M              | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Piet  |         0 |       0 | K            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort | akte_nr |
      | Piet  |         0 |       0 | R            |         000000101 | Petra          | morgen - 37 jaar | V              | gisteren - 20 jaar  |                 0518 |                    6030 | H                 | 3XA1224 |

    Voorbeelden:
      | leeftijd omschrijving          | geboortedatum      |
      | minderjarige                   | gisteren - 17 jaar |
      | meerderjarige                  | gisteren - 45 jaar |
      |         7 jaar geleden geboren |     7 jaar geleden |
      |             03-11-2024 geboren |           20241103 |
      | op 03-11-2024 geboren          |           20241103 |
      | op 3 november 2024 geboren     |           20241103 |
      | op een onbekende datum geboren |           00000000 |
      | gisteren geboren               | gisteren           |
      | vorige maand geboren           | vorige maand       |

  Abstract Scenario: de {datum omschrijving} persoon {kind} met één ouder {ouder}
    Gegeven de <leeftijd omschrijving> persoon 'Jan' met één ouder 'Petra'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            1 | <geboortedatum>            | 1_A____ |         000000101 | Petra          | morgen - 37 jaar | V              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | akte_nr | geldigheid_start_datum |
      | Jan   |         0 |       0 |            2 | 1_A____ | <geboortedatum>        |

    Voorbeelden:
      | leeftijd omschrijving          | geboortedatum      |
      | minderjarige                   | gisteren - 17 jaar |
      | meerderjarige                  | gisteren - 45 jaar |
      |         7 jaar geleden geboren |     7 jaar geleden |
      |             03-11-2024 geboren |           20241103 |
      | op 03-11-2024 geboren          |           20241103 |
      | op 3 november 2024 geboren     |           20241103 |
      | op een onbekende datum geboren |           00000000 |
      | gisteren geboren               | gisteren           |
      | vorige maand geboren           | vorige maand       |

  Scenario: de minderjarige persoon {kind} met één ouder {ouder} die gehuwd is met {partner}
    Gegeven de minderjarige persoon 'Jan' met één ouder 'Petra' die gehuwd is met 'Paula'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | gisteren - 16 jaar |               6030 | 1_A____ |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort | akte_nr |
      | Petra |         0 |       0 | R            |         000000102 | Paula          | morgen - 37 jaar | V              | gisteren - 20 jaar  |                 0518 |                    6030 | H                 | 3XA1224 |
    En heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Paula |          0 |
    En heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | akte_nr |
      | Paula |         0 |       0 | P            |         000000102 | Paula          | morgen - 37 jaar | V              | 1_A____ |
    En heeft persoon 'Paula' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort | akte_nr |
      | Paula |         0 |       0 | R            |         000000101 | Petra          | morgen - 37 jaar | V              | gisteren - 20 jaar  |                 0518 |                    6030 | H                 | 3XA1224 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 16 jaar |               6030 | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            1 | gisteren - 16 jaar         | 1_A____ |         000000101 | Petra          | morgen - 37 jaar | V              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | akte_nr | geldigheid_start_datum |
      | Jan   |         0 |       0 |            2 | 1_A____ | gisteren - 16 jaar     |

  Scenario: de minderjarige persoon {kind} geboren in het buitenland met twee gehuwde ouders {moeder} en {vader}
    Gegeven de minderjarige persoon 'Jan' geboren in het buitenland met twee gehuwde ouders 'Petra' en 'Piet'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | doc_beschrijving |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | paspoort         |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | doc_beschrijving          |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | buitenlandse geboorteakte |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort | doc_beschrijving            |
      | Petra |         0 |       0 | R            |         000000102 | Piet           | morgen - 37 jaar | M              | gisteren - 20 jaar  | Teststadt            |                    6029 | H                 | buitenlandse huwelijkseakte |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Piet  |          0 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | doc_beschrijving    |
      | Piet  |         0 |       0 | P            |         000000102 | Piet           | morgen - 37 jaar | M              | beëdigde verklaring |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | doc_beschrijving          |
      | Piet  |         0 |       0 | K            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | buitenlandse geboorteakte |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort | doc_beschrijving            |
      | Piet  |         0 |       0 | R            |         000000101 | Petra          | morgen - 37 jaar | V              | gisteren - 20 jaar  | Teststadt            |                    6029 | H                 | buitenlandse huwelijkseakte |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | doc_beschrijving          |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | buitenlandse geboorteakte |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code | vestiging_land_code | vestiging_datum   |
      | Jan   |       0 |                       0518 |                6029 | gisteren - 5 jaar |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | doc_beschrijving          | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            1 | gisteren - 16 jaar         | buitenlandse geboorteakte |         000000101 | Petra          | morgen - 37 jaar | V              |
      | Jan   |         0 |       0 |            2 | gisteren - 16 jaar         | buitenlandse geboorteakte |         000000102 | Piet           | morgen - 37 jaar | M              |

  Scenario: de minderjarige persoon {kind} geboren in het buitenland met één ouder {ouder}
    Gegeven de minderjarige persoon 'Jan' geboren in het buitenland met één ouder 'Petra'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | doc_beschrijving |
      | Petra |         0 |       0 | P            |         000000101 | Petra          | morgen - 37 jaar | V              | paspoort         |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | doc_beschrijving          |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | buitenlandse geboorteakte |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | doc_beschrijving          |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | buitenlandse geboorteakte |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code | vestiging_land_code | vestiging_datum   |
      | Jan   |       0 |                       0518 |                6029 | gisteren - 5 jaar |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | doc_beschrijving          | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            1 | gisteren - 16 jaar         | buitenlandse geboorteakte |         000000101 | Petra          | morgen - 37 jaar | V              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | doc_beschrijving          | geldigheid_start_datum |
      | Jan   |         0 |       0 |            2 | buitenlandse geboorteakte | gisteren - 16 jaar     |

  Scenario: de minderjarige persoon {kind} geboren in het buitenland geadopteerd door één ouder {ouder}
    Gegeven de minderjarige persoon 'Jan' geboren in het buitenland geadopteerd door één ouder 'Petra'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand | doc_beschrijving |
      | Petra |         0 |       0 | P            |         000000104 | Petra          | morgen - 37 jaar | V              | paspoort         |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | 1_Q____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | 1_Q____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code | vestiging_land_code | vestiging_datum   |
      | Jan   |       0 |                       0518 |                6029 | gisteren - 5 jaar |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            1 | gisteren - 15 jaar         | 1_Q____ |         000000104 | Petra          | morgen - 37 jaar | V              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | doc_beschrijving          | geldigheid_start_datum |
      | Jan   |         0 |       0 |            2 | buitenlandse geboorteakte | gisteren - 16 jaar     |

  Scenario: de minderjarige persoon {kind} geboren in het buitenland met niet-ingezeten ouders {moeder} en {vader}
    Gegeven de minderjarige persoon 'Jan' geboren in het buitenland met niet-ingezeten ouders 'Petra' en 'Piet'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | doc_beschrijving          |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | buitenlandse geboorteakte |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code | vestiging_land_code | vestiging_datum   |
      | Jan   |       0 |                       0518 |                6029 | gisteren - 5 jaar |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | doc_beschrijving          | voor_naam | geslachts_naam | geboorte_datum   | geslachts_aand |
      | Jan   |         0 |       0 |            1 | gisteren - 16 jaar         | buitenlandse geboorteakte | Jane      | Petra          | morgen - 37 jaar | V              |
      | Jan   |         0 |       0 |            2 | gisteren - 16 jaar         | buitenlandse geboorteakte | John      | Piet           | morgen - 37 jaar | M              |

  Scenario: de minderjarige persoon {string} die nooit ingezetene is geweest
    Gegeven de minderjarige persoon 'Jan' die nooit ingezetene is geweest
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind | bijhouding_opschort_datum | bijhouding_opschort_reden |
      | Jan   |          0 | gisteren - 1 jaar         | R                         |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | doc_beschrijving          | rni_deelnemer |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | gisteren - 16 jaar |               6029 | buitenlandse geboorteakte |           201 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code | rni_deelnemer |
      | Jan   |       0 |                       1999 |           201 |

  Scenario: de {datum omschrijving} persoon {kind} die als vondeling geboren is
    Gegeven de <leeftijd omschrijving> persoon 'Jan' die als vondeling geboren is
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Petra' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | familie_betrek_start_datum | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            | <geboortedatum> |               6030 |                            | 1_A____ |
      | Jan   |         0 |       0 |            1 |                   | .              |                 |                    | <geboortedatum>            | 1_A____ |
      | Jan   |         0 |       0 |            2 |                   |                |                 |                    |                            | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |

    Voorbeelden:
      | leeftijd omschrijving          | geboortedatum      |
      | minderjarige                   | gisteren - 17 jaar |
      | meerderjarige                  | gisteren - 45 jaar |
      |         7 jaar geleden geboren |     7 jaar geleden |
      |             03-11-2024 geboren |           20241103 |
      | op 03-11-2024 geboren          |           20241103 |
      | op 3 november 2024 geboren     |           20241103 |
      | op een onbekende datum geboren |           00000000 |

  Scenario: de meerderjarige persoon {persoon}
    Gegeven de meerderjarige persoon 'Jan'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000106 | Jan            | morgen - 37 jaar |               6030 | 1_A____ |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
