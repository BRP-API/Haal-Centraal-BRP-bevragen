# language: nl
@stap-documentatie @integratie
Functionaliteit: Geboorte gegeven stap definities

  @integratie
  Abstract Scenario: is [datum formaat] geboren
    Gegeven de persoon 'Jansen' met burgerservicenummer '000000012'
    * is <datum> geboren
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl'
      | pl_id  | geheim_ind |
      | Jansen |          0 |
    En heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id  | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum     |
      | Jansen |         0 |       0 | P            |         000000012 | Jansen         | <yyyymmdd formaat> |

    Voorbeelden:
      | datum                  | yyyymmdd formaat       |
      | gisteren - 7 jaar      | gisteren - 7 jaar      |
      | vorige maand - 16 jaar | vorige maand - 16 jaar |
      | dit jaar - 5 jaar      | dit jaar - 5 jaar      |
      |         5 jaar geleden |         5 jaar geleden |
      | in 2021                |               20210000 |
      |              28-3-2021 |               20210328 |
      | op 28-3-2021           |               20210328 |
      | op onbekende datum     |               00000000 |
      | op een onbekende datum |               00000000 |

  @integratie
  Abstract Scenario: '{naam}' is {relatieve datum} als vondeling geboren
    Gegeven de persoon 'Jansen' met burgerservicenummer '000000036'
    * is <datum> als vondeling geboren
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl'
      | pl_id  | geheim_ind |
      | Jansen |          0 |
    En heeft persoon 'Jansen' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id  | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      | Jansen | P            |         0 |       0 |         000000036 | Jansen         | <yyyymmdd formaat> |                |               6030 | 1AA0100 |                            |
      | Jansen |            1 |         0 |       0 |                   | .              |                    | V              |                    | 1AA0100 | <yyyymmdd formaat>         |
      | Jansen |            2 |         0 |       0 |                   |                |                    |                |                    | 1AA0100 |                            |

    Voorbeelden:
      | datum                  | yyyymmdd formaat       |
      | gisteren - 7 jaar      | gisteren - 7 jaar      |
      | vorige maand - 16 jaar | vorige maand - 16 jaar |
      | dit jaar - 5 jaar      | dit jaar - 5 jaar      |
      |         5 jaar geleden |         5 jaar geleden |
      | in 2021                |               20210000 |
      |              28-3-2021 |               20210328 |
      | op 28-3-2021           |               20210328 |
      | op onbekende datum     |               00000000 |
      | op een onbekende datum |               00000000 |
