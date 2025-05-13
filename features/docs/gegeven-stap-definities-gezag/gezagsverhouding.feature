# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Gezag toegewezen in een gerechtelijke uitspraak vult minderjarige_gezag_ind en geldigheid_start_datum in

    @integratie
    Scenario: {relatievedatum} is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende in stapdefinitie>
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de morgen 40 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      En <relatieve datum> is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1_A____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1_A____ |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1_A____ |                            |
        | P3    |            1 |         0 |       0 |         000000012 | P1             |                    | 1_A____ | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |                    | 1_A____ | gisteren - 17 jaar         |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_gezagsverhouding'
        | pl_id | volg_nr | minderjarig_gezag_ind | geldigheid_start_datum |
        | P3    |       0 | <indicatie gezag>     | <relatieve datum>      |

      Voorbeelden:
        | relatieve datum   | gezaghebbende         | indicatie gezag | gezaghebbende in stapdefinitie |
        |    6 jaar geleden | 'P1'                  |               1 | '{naam}'                       |
        | vorige maand      | 'P2'                  |               2 | '{naam}'                       |
        | gisteren - 5 jaar | een voogdijinstelling | D               | een voogdijinstelling          |
        | gisteren - 4 jaar | een derde             | D               | een derde                      |
        |    2 jaar geleden | beide ouders          |              12 | beide ouders                   |
        |    2 jaar geleden | 'P1' en een derde     |              1D | '{naam}' en een derde          |
        |    2 jaar geleden | 'P2' en een derde     |              2D | '{naam}' en een derde          |

  Regel: Curatele wordt vastgelegd in de gezagsverhouding

    @integratie
    Scenario: '{naam}' staat onder curatele
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' staat onder curatele
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1_A____ |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_gezagsverhouding'
        | pl_id | volg_nr | curatele_register_ind |
        | P1    |       0 |                     1 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1_A____ |
