# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Meerderjarigheid, minderjarigheid en geboorte worden toegevoegd aan de persoon

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
      Dan heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     |
        | P2    | P            |         0 |       0 |         000000012 | P2             | gisteren - 17 jaar |
      En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        | P1    | P            |         0 |       0 |         000000024 | P1             |

    @integratie
    Scenario: is meerderjarig
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is meerderjarig
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |               6030 | 1AA0100 |

    @integratie
    Scenario: is minderjarig
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is minderjarig
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 17 jaar |               6030 | 1AA0100 |

    @integratie
    Scenario: '{naam}' is minderjarig
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' is minderjarig
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 17 jaar |               6030 | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |

    @integratie
    Scenario: '{naam}' is {relatievedatum} geboren
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' is <relatieve datum> geboren
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum    | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | <relatieve datum> |               6030 | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |

      Voorbeelden:
        | relatieve datum |
        | gisteren        |
        |  2 jaar geleden |
        | vorige maand    |

    @integratie
    Scenario: '{naam}' is geboren op {datum}
      # datum heeft formaat d-m-j, met d en m heeft 1 of 2 cijfers, j heeft 4 cijfers
      # met de (optionele) naam wijzigt de context naar deze persoon
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' is geboren op <datum>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | <geboortedatum> |               6030 | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |

      Voorbeelden:
        | datum      | geboortedatum |
        | 31-12-2022 |      20221231 |
        |   1-1-2023 |      20230101 |

    @integratie
    Scenario: is geboren op {datum}
      # datum heeft formaat d-m-j, met d en m heeft 1 of 2 cijfers, j heeft 4 cijfers
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * 'P1' is geboren op <datum>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | <geboortedatum> |               6030 | 1AA0100 |

      Voorbeelden:
        | datum      | geboortedatum |
        | 31-12-2022 |      20221231 |
        |   1-1-2023 |      20230101 |

    @integratie
    Abstract Scenario: is geboren in {land}
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is geboren in <land>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code |
        | P1    | P            |         0 |       0 |         000000012 | P1             | <landcode>         |

      Voorbeelden:
        | land        | landcode |
        | België      |     5010 |
        | Spanje      |     6037 |
        | Duitsland   |     6029 |
        | Afghanistan |     6023 |
