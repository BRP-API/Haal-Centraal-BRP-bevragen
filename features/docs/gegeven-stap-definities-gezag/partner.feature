# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Huwelijk en geregistreerd partnerschap wordt toegevoegd als persoon_type 'R' voor beide betrokken personen
    # To Do: welke gegevens van een persoon worden meegenomen - want zijn relevant - in de relatie?
    # geboortedatum, geboorteland, ...?

    @integratie
    Scenario: '{naam1}' en '{naam2}' zijn met elkaar gehuwd
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn met elkaar gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                   |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 | H                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                   |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 | H                 |

    @integratie
    Abstract Scenario: '{naam1}' en '{naam2}' zijn {relatievedatum} gehuwd
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn <relatieve datum> gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                   |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         | <relatieve datum>   |                 0518 |                    6030 | H                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                   |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         | <relatieve datum>   |                 0518 |                    6030 | H                 |

      Voorbeelden:
        | relatieve datum   |
        |    2 jaar geleden |
        | gisteren - 5 jaar |

    @integratie
    Scenario: '{naam1}' en '{naam2}' zijn een geregistreerd partnerschap aangegaan op {datum}
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn een geregistreerd partnerschap aangegaan op 1-3-2010
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                   |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |            20100301 |                 0518 |                    6030 | P                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                   |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |            20100301 |                 0518 |                    6030 | P                 |

    @integratie
    Scenario: '{naam1}' en '{naam2}' zijn {relatieve datum} een geregistreerd partnerschap aangegaan
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                   |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                   |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |

    @integratie
    Abstract Scenario: '{naam1}' en '{naam2}' zijn {relatievedatum} gescheiden
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn met elkaar gehuwd
      En 'P1' en 'P2' zijn <relatieve datum> gescheiden
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P1    | R            |         0 |       1 |         000000024 | P2             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |                     |                      |                         | <relatieve datum>  |                0518 |                   6030 | H                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P2    | R            |         0 |       1 |         000000012 | P1             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |                     |                      |                         | <relatieve datum>  |                0518 |                   6030 | H                 |

      Voorbeelden:
        | relatieve datum   |
        |    2 jaar geleden |
        | gisteren - 5 jaar |

    Scenario: '{naam1}' en '{naam2}' zijn op {dd-mm-yyyy datum} gescheiden
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn met elkaar gehuwd
      En 'P1' en 'P2' zijn 3-7-2023 gescheiden
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P1    | R            |         0 |       1 |         000000024 | P2             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |                     |                      |                         |           20230703 |                0518 |                   6030 | H                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P2    | R            |         0 |       1 |         000000012 | P1             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |                     |                      |                         |           20230703 |                0518 |                   6030 | H                 |

    @integratie
    Abstract Scenario: volgende relatie: '{naam1}' en '{naam2}' zijn {relatievedatum} gehuwd
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn met elkaar gehuwd
      En 'P1' en 'P2' zijn 5 jaar geleden gescheiden
      En 'P1' en 'P2' zijn <relatieve datum> gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P1    | R            |         0 |       1 |         000000024 | P2             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |                     |                      |                         |     5 jaar geleden |                0518 |                   6030 | H                 |
        | P1    | R            |         1 |       0 |         000000024 | P2             |                    |         | <relatieve datum>   |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P2    | R            |         0 |       1 |         000000012 | P1             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |                     |                      |                         |     5 jaar geleden |                0518 |                   6030 | H                 |
        | P2    | R            |         1 |       0 |         000000012 | P1             |                    |         | <relatieve datum>   |                 0518 |                    6030 |                    |                     |                        | H                 |

      Voorbeelden:
        | relatieve datum   |
        |    2 jaar geleden |
        | gisteren - 3 jaar |
        | vorige maand      |

    @integratie
    Scenario: '{naam1}' en '{naam2}' zijn {relatievedatum1} gehuwd en {relatievedatum2} gescheiden
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn 6 jaar geleden gehuwd
      En 'P1' en 'P2' zijn 2 jaar geleden gescheiden
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P1    | R            |         0 |       1 |         000000024 | P2             |                    |         |      6 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |                     |                      |                         |     2 jaar geleden |                0518 |                   6030 | H                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P2    | R            |         0 |       1 |         000000012 | P1             |                    |         |      6 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |                     |                      |                         |     2 jaar geleden |                0518 |                   6030 | H                 |

    @integratie
    Scenario: personen zijn gehuwd, gescheiden en daarna gehuwd met een ander
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      En de persoon 'P4' met burgerservicenummer '000000048'
      En 'P1' en 'P2' zijn 10 jaar geleden gehuwd
      En 'P1' en 'P2' zijn 7 jaar geleden gescheiden
      En 'P1' en 'P4' zijn 5 jaar geleden gehuwd
      En 'P2' en 'P3' zijn 3 jaar geleden gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P1    | R            |         0 |       1 |         000000024 | P2             |                    |         |     10 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |                     |                      |                         |     7 jaar geleden |                0518 |                   6030 | H                 |
        | P1    | R            |         1 |       0 |         000000048 | P4             |                    |         |      5 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P2    | R            |         0 |       1 |         000000012 | P1             |                    |         |     10 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |                     |                      |                         |     7 jaar geleden |                0518 |                   6030 | H                 |
        | P2    | R            |         1 |       0 |         000000036 | P3             |                    |         |      3 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P3    | R            |         0 |       0 |         000000024 | P2             |                    |         |      3 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft persoon 'P4' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P4    |          0 |
      En heeft persoon 'P4' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P4    | P            |         0 |       0 |         000000048 | P4             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P4    | R            |         0 |       0 |         000000012 | P1             |                    |         |      5 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |

    @integratie
    Scenario: personen zijn gehuwd, gescheiden en opnieuw gehuwd
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn 10 jaar geleden gehuwd
      En 'P1' en 'P2' zijn 7 jaar geleden gescheiden
      En 'P1' en 'P2' zijn 5 jaar geleden opnieuw gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P1    | R            |         0 |       1 |         000000024 | P2             |                    |         |     10 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |                     |                      |                         |     7 jaar geleden |                0518 |                   6030 | H                 |
        | P1    | R            |         1 |       0 |         000000024 | P2             |                    |         |      5 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P2    | R            |         0 |       1 |         000000012 | P1             |                    |         |     10 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |                     |                      |                         |     7 jaar geleden |                0518 |                   6030 | H                 |
        | P2    | R            |         1 |       0 |         000000012 | P1             |                    |         |      5 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |

    Abstract Scenario: het geregistreerd partnerschap van '{naam1} en {naam2}' is {relatieve datum} ontbonden
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' en 'P2' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
      En het geregistreerd partnerschap van 'P1' en 'P2' is <datum> ontbonden
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P1    | R            |         0 |       1 |         000000024 | P2             |                    |         |      7 jaar geleden |                 0518 |                    6030 |                    |                     |                        | P                 |
        | P1    | R            |         0 |       0 |         000000024 | P2             |                    |         |                     |                      |                         | <yyyymmdd formaat> |                0518 |                   6030 | P                 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        | P2    | R            |         0 |       1 |         000000012 | P1             |                    |         |      7 jaar geleden |                 0518 |                    6030 |                    |                     |                        | P                 |
        | P2    | R            |         0 |       0 |         000000012 | P1             |                    |         |                     |                      |                         | <yyyymmdd formaat> |                0518 |                   6030 | P                 |

      Voorbeelden:
        | datum                  | yyyymmdd formaat       |
        | gisteren - 7 jaar      | gisteren - 7 jaar      |
        | vorige maand - 16 jaar | vorige maand - 16 jaar |
        | dit jaar - 5 jaar      | dit jaar - 5 jaar      |
        |         5 jaar geleden |         5 jaar geleden |
        | in 2021                |               20210000 |
        |              28-3-2021 |               20210328 |
        | op 28-3-2021           |               20210328 |
