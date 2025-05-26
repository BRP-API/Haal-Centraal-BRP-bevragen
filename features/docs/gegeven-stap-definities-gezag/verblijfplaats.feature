# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Inschrijving, immigratie en emigratie wordt vastgelegd in de verblijfplaats

    @integratie
    Scenario: is ingeschreven in een Nederlandse gemeente
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is ingeschreven in een Nederlandse gemeente
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code |
        | P1    |       0 |                       0518 |

    @integratie
    Scenario: is ingeschreven als niet-ingezetene met een verblijfplaats in België
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is ingeschreven als niet-ingezetene met een verblijfplaats in België
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_land_code |
        | P1    |       0 |                       1999 |              5010 |

    @integratie
    Scenario: is ingeschreven als niet-ingezetene met een volledig onbekende verblijfplaats
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is ingeschreven als niet-ingezetene met een volledig onbekende verblijfplaats
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_land_code |
        | P1    |       0 |                       1999 |              0000 |

    @integratie
    Scenario: de gemeente heeft vastgesteld dat de minderjarige niet op het adres verblijft
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is ingeschreven in een Nederlandse gemeente
      * de gemeente heeft vastgesteld dat de minderjarige niet op het adres verblijft
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | onderzoek_gegevens_aand |
        | P1    |       0 |                       0518 |                  089999 |

    @integratie
    Scenario: is op {datum} geïmmigreerd
      # datum heeft formaat d-m-j, met d en m heeft 1 of 2 cijfers, j heeft 4 cijfers
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is geboren in België
      En is op <immigratiedatum> geïmmigreerd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               5010 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vestiging_datum   |
        | P1    |       0 |                       0518 | <vestiging datum> |

      Voorbeelden:
        | immigratiedatum | vestiging datum |
        |       15-5-2022 |        20220515 |
        |       3-11-2023 |        20231103 |

    @integratie
    Scenario: '{naam}' is {relatievedatum} geïmmigreerd naar Nederland
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En 'P1' is <relatieve datum> geïmmigreerd naar Nederland
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        | P1    | P            |         0 |       0 |         000000012 | P1             |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vestiging_datum   |
        | P1    |       0 |                       0518 | <relatieve datum> |

      Voorbeelden:
        | relatieve datum |
        | gisteren        |
        |  2 jaar geleden |
        | vorige maand    |

    @integratie
    Scenario: '{naam}' is {relatievedatum} geëmigreerd naar {landnaam}
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En 'P1' is <relatieve datum> geëmigreerd naar <land naam>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        | P1    | P            |         0 |       0 |         000000012 | P1             |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_datum     | vertrek_land_code |
        | P1    |       0 |                       1999 | <relatieve datum> | <land code>       |

      Voorbeelden:
        | relatieve datum | land naam   | land code |
        | vorige maand    | België      |      5010 |
        |  2 jaar geleden | Spanje      |      6037 |
        |  2 jaar geleden | Duitsland   |      6029 |
        |  2 jaar geleden | Afghanistan |      6023 |

    @integratie
    Scenario: neem land mee van vorige verblijfplaats: '{naam}' is {relatievedatum} geïmmigreerd naar Nederland
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En 'P1' is 2 jaar geleden geëmigreerd naar <land naam>
      En 'P1' is 1 jaar geleden geïmmigreerd naar Nederland
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        | P1    | P            |         0 |       0 |         000000012 | P1             |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_datum  | vertrek_land_code | vestiging_datum | vestiging_land_code |
        | P1    |       0 |                       0518 |                |                   |  1 jaar geleden | <land code>         |
        | P1    |       1 |                       1999 | 2 jaar geleden | <land code>       |                 |                     |

      Voorbeelden:
        | land naam   | land code |
        | België      |      5010 |
        | Spanje      |      6037 |
        | Duitsland   |      6029 |
        | Afghanistan |      6023 |

    @integratie
    Scenario: {vandaag, gisteren of morgen x jaar geleden} is geconstateerd dat {aanduiding} behoort tot de categorie NAVO-militair
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En 2 jaar geleden is geconstateerd dat 'P1' behoort tot de categorie NAVO-militair
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind | bijhouding_opschort_datum | bijhouding_opschort_reden |
        | P1    |          0 |            2 jaar geleden | M                         |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        | P1    | P            |         0 |       0 |         000000012 | P1             |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_datum  | vertrek_land_code | aangifte_adreshouding_oms |
        | P1    |       0 |                       0518 | 2 jaar geleden |              0000 | B                         |
