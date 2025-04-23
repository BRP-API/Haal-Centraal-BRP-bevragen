# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren adoptie

  Regel: Bij adoptie wordden ouders toegevoegd als persoon_type respectievelijk '1' en '2' aan de persoon en de persoon als persoon_type 'K' bij de ouders

    @integratie
    Abstract Scenario: overnemen van gegevens van ouder en kind: '{naam}' is op {datum} geadopteerd door '{naam}' en '{naam}'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is meerderjarig
      * is een man
      En de persoon 'P2' met burgerservicenummer '000000024'
      * is 18 jaar geleden geboren
      * is een vrouw
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * is geboren in Duitsland
      En 'P3' is <datum> geadopteerd door 'P2' en 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |               6030 | M              | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    |                | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |    18 jaar geleden |               6030 | V              | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    |                | 1AQ0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum            |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                |               6029 | 1AQ0100 |                                       |
        | P3    |            1 |         0 |       0 |         000000024 | P2             |    18 jaar geleden | V              |                    | 1AQ0100 | <datum familierechtelijke betrekking> |
        | P3    |            2 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar | M              |                    | 1AQ0100 | <datum familierechtelijke betrekking> |

      Voorbeelden:
        | datum stapdefinitie | datum              | datum familierechtelijke betrekking |
        | op {datum}          | op 30-11-2019      |                            20191130 |
        | {relatieve datum}   |     2 jaar geleden |                      2 jaar geleden |
        | {relatieve datum}   | gisteren - 10 jaar | gisteren - 10 jaar                  |

    @integratie
    Scenario: '{naam}' is geadopteerd door '{naam}'
      # logica is gelijk aan stap '{naam}' is {relatieve datum} geadopteerd door '{naam}' (voor bepalen ouder 1 of 2 en voor overnemen van gegevens)
      # default datum adoptie is '10 jaar geleden'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * is geboren in Duitsland
      * heeft 'P2' als ouder
      En 'P3' is geadopteerd door 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6029 | 1AQ0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000012 | P1             |                    | 1AQ0100 |            10 jaar geleden |

    @integratie
    Scenario: '{naam}' is geadopteerd door '{naam}' en '{naam}'
      # logica is gelijk aan stap '{naam}' is {relatieve datum} geadopteerd door '{naam}' en '{naam}' (voor overnemen van gegevens)
      # default datum adoptie is '10 jaar geleden'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      En 'P3' is geadopteerd door 'P2' en 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AQ0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1AQ0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             |                    | 1AQ0100 |            10 jaar geleden |
        | P3    |            2 |         0 |       0 |         000000012 | P1             |                    | 1AQ0100 |            10 jaar geleden |

    @integratie
    Scenario: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als er nog geen ouder 1 is dan wordt de adoptieouder ouder 1
      Gegeven de persoon 'P1' met burgerservicenummer '000000024'
      En de persoon 'P2' met burgerservicenummer '000000036'
      En 'P2' is 3 jaar geleden geadopteerd door 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000024 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1AQ0100 |                            |
        | P2    |            1 |         0 |       0 |         000000024 | P1             |                    | 1AQ0100 |             3 jaar geleden |

    @integratie
    Scenario: adoptie naast andere ouder: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als ouder 1 al bestaat en ouder 1 heeft geslachts_naam met een waarde ongelijk aan '.', dan wordt de adoptieouder ouder 2
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * heeft 'P2' als ouder
      En 'P3' is 3 jaar geleden geadopteerd door 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1AQ0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000012 | P1             |                    | 1AQ0100 |             3 jaar geleden |

    @integratie
    Scenario: adoptie vervangt puntouder: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als ouder 1 heeft geslachts_naam leeg, of als ouder 1 heeft geslachts_naam '.' dan wordt de adoptieouder ouder 1
      Gegeven de persoon 'P1' met burgerservicenummer '000000024'
      * is een vrouw
      En de persoon 'P2' met burgerservicenummer '000000036'
      * is 4 jaar geleden als vondeling geboren
      En 'P2' is 3 jaar geleden geadopteerd door 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | geslachts_aand | akte_nr |
        | P1    | P            |         0 |       0 |         000000024 | P1             |               6030 | V              | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    |                | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             | 4 jaar geleden |                |               6030 | 1AQ0100 |                            |
        | P2    |            1 |         0 |       0 |         000000024 | P1             |                | V              |                    | 1AQ0100 |             3 jaar geleden |
        | P2    |            1 |         0 |       1 |                   | .              |                | V              |                    | 1AA0100 |             4 jaar geleden |
        | P2    |            2 |         0 |       0 |                   |                |                |                |                    | 1AA0100 |                            |

    @integratie
    Scenario: adoptie vervangt puntouder: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als ouder 1 heeft geslachts_naam leeg, of als ouder 1 heeft geslachts_naam '.' dan wordt de adoptieouder ouder 1
      Gegeven de persoon 'P1' met burgerservicenummer '000000024'
      * is een vrouw
      En de persoon 'P2' met burgerservicenummer '000000036'
      * is 4 jaar geleden als vondeling geboren
      En 'P2' is 3 jaar geleden geadopteerd door 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | geslachts_aand | akte_nr |
        | P1    | P            |         0 |       0 |         000000024 | P1             |               6030 | V              | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    |                | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             | 4 jaar geleden |                |               6030 | 1AQ0100 |                            |
        | P2    |            1 |         0 |       0 |         000000024 | P1             |                | V              |                    | 1AQ0100 |             3 jaar geleden |
        | P2    |            1 |         0 |       1 |                   | .              |                | V              |                    | 1AA0100 |             4 jaar geleden |
        | P2    |            2 |         0 |       0 |                   |                |                |                |                    | 1AA0100 |                            |

    Scenario: '{naam}' is in het buitenland geadopteerd door '{naam}' en '{naam}' op {datum} met document '{document beschrijving}'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is meerderjarig
      * is een man
      En de persoon 'P2' met burgerservicenummer '000000024'
      * is meerderjarig
      * is een vrouw
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * is geboren in Duitsland
      En 'P3' is in het buitenland geadopteerd door 'P1' en 'P2' op 30-11-2019 met document 'ad akte 6029'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | doc_beschrijving |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |               6030 | M              | 1AA0100 |                  |
        | P1    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    |                |         | ad akte 6029     |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | doc_beschrijving |
        | P2    | P            |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |               6030 | V              | 1AA0100 |                  |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    |                |         | ad akte 6029     |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geslachts_aand | geboorte_land_code | doc_beschrijving | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                |               6029 | ad akte 6029     |                            |
        | P3    |            1 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar | M              |                    | ad akte 6029     |                   20191130 |
        | P3    |            2 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar | V              |                    | ad akte 6029     |                   20191130 |