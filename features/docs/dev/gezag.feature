# language: nl
@integratie @stap-documentatie @skip-verify
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Achtergrond:
    Gegeven de tabel 'lo3_pl' bevat geen rijen
    En de tabel 'lo3_pl_persoon' bevat geen rijen

    Scenario: '{naam}' is {relatieve datum} als vondeling geboren
      Gegeven de persoon 'Theo' met burgerservicenummer '000000036'
      * is minderjarig
      En 'Theo' is 3 jaar geleden als vondeling geboren
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        |     1 | P            |         0 |       0 |         000000036 | Theo           | 3 jaar geleden |                |               6030 | 1AA0100 |                            |
        |     1 |            1 |         0 |       0 |                   | .              |                | V              |                    | 1AA0100 |             3 jaar geleden |
        |     1 |            2 |         0 |       0 |                   |                |                |                |                    | 1AA0100 |                            |

  Scenario: is ingeschreven met een tijdelijke verblijfplaats in Nederland
    Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
    * is ingeschreven met een tijdelijke verblijfplaats in Nederland
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Tosca          |               6030 | 1AA0100 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_tijdelijke_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code | inschrijving_datum |
      |     1 |       0 |                       0518 | gisteren - 1 jaar  |

  Scenario: het geregistreerd partnerschap van '{naam1}' en '{naam2}' is {relatieve datum} ontbonden
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    En 'Arjan' en 'Tosca' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
    En het geregistreerd partnerschap van 'Arjan' en 'Tosca' is 2 jaar geleden ontbonden
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
      |     1 | R            |         0 |       1 |         000000024 | Tosca          |                    |         |      7 jaar geleden |                  518 |                    6030 |                    |                     |                        | P                 |
      |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |                     |                      |                         |     2 jaar geleden |                 518 |                   6030 | P                 |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
      |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
      |     2 | R            |         0 |       1 |         000000012 | Arjan          |                    |         |      7 jaar geleden |                  518 |                    6030 |                    |                     |                        | P                 |
      |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |                     |                      |                         |     2 jaar geleden |                 518 |                   6030 | P                 |

  Scenario: heeft '{naam}' als ouder vanaf de geboortedatum
      # deze stap is volledig identiek aan stap "heeft '{naam}' als ouder"
      # toevoeging is alleen bedoeld om aan lezer te benadrukken dat de ouder op de geboorteakte staat en familierechtelijke betrekking gelijk is aan geboortedatum
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * heeft 'Arjan' als ouder vanaf de geboortedatum
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     2 | P            |         0 |       0 |         000000036 | Theo           |               6030 | 1AA0100 |                            |
      |     2 |            1 |         0 |       0 |         000000012 | Arjan          |                    | 1AA0100 | gisteren - 17 jaar         |

  Scenario: heeft '{naam1}' en '{naam2}' als ouders vanaf de geboortedatum
      # deze stap is volledig identiek aan stap "heeft '{naam1}' en '{naam2}' als ouders"
      # toevoeging is alleen bedoeld om aan lezer te benadrukken dat de ouder op de geboorteakte staat en familierechtelijke betrekking gelijk is aan geboortedatum
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * heeft 'Arjan' en 'Tosca' als ouders vanaf de geboortedatum
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |
      |     2 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     3 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     3 | P            |         0 |       0 |         000000036 | Theo           |               6030 | 1AA0100 |                            |
      |     3 |            1 |         0 |       0 |         000000012 | Arjan          |                    | 1AA0100 | gisteren - 17 jaar         |
      |     3 |            2 |         0 |       0 |         000000024 | Tosca          |                    | 1AA0100 | gisteren - 17 jaar         |

  Scenario: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als er nog geen ouder 1 is dan wordt de adoptieouder ouder 1
    Gegeven de persoon 'Tosca' met burgerservicenummer '000000024'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    En 'Theo' is 3 jaar geleden geadopteerd door 'Tosca'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AQ0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     2 | P            |         0 |       0 |         000000036 | Theo           |               6029 | 1AQ0100 |                            |
      |     2 |            1 |         0 |       0 |         000000024 | Tosca          |                    | 1AQ0100 |             3 jaar geleden |

  Scenario: adoptie naast andere ouder: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als ouder 1 al bestaat en ouder 1 heeft geslachts_naam met een waarde ongelijk aan '.', dan wordt de adoptieouder ouder 2
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * heeft 'Tosca' als ouder
    En 'Theo' is 3 jaar geleden geadopteerd door 'Arjan'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AQ0100 |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |
      |     2 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     3 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     3 | P            |         0 |       0 |         000000036 | Theo           | 4 jaar geleden |                |               6030 | 1AQ0100 |                            |
      |     3 |            1 |         0 |       0 |         000000024 | Tosca          |                |                |                    | 1AA0100 | gisteren - 17 jaar         |
      |     3 |            2 |         0 |       0 |         000000012 | Arjan          |                |                |                    | 1AQ0100 |             3 jaar geleden |

  Scenario: adoptie vervangt puntouder: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als ouder 1 heeft geslachts_naam leeg, of als ouder 1 heeft geslachts_naam '.' dan wordt de adoptieouder ouder 1
    Gegeven de persoon 'Tosca' met burgerservicenummer '000000024'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    En 'Theo' is 4 jaar geleden als vondeling geboren
    En 'Theo' is 3 jaar geleden geadopteerd door 'Tosca'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | geslachts_aand | akte_nr |
      |     1 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | V              | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |                    |                | 1AQ0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     2 | P            |         0 |       0 |         000000036 | Theo           | 4 jaar geleden |                |               6030 | 1AQ0100 |                            |
      |     2 |            1 |         0 |       0 |         000000024 | Tosca          |                |                |                    | 1AQ0100 |             3 jaar geleden |
      |     2 |            1 |         0 |       1 |                   | .              |                | V              |                    | 1AA0100 |             4 jaar geleden |
      |     2 |            2 |         0 |       0 |                   |                |                |                |                    | 1AA0100 |                            |

  Scenario: overnemen van gegevens van ouder en kind: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
    Gegeven de persoon 'Tosca' met burgerservicenummer '000000024'
    * is meerderjarig
    * is een vrouw
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * is 5 jaar geleden geboren
    En 'Theo' is 3 jaar geleden geadopteerd door 'Tosca'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
      |     1 | P            |         0 |       0 |         000000024 | Tosca          | gisteren - 45 jaar |               6030 | V              | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |     5 jaar geleden |                    |                | 1AQ0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     2 | P            |         0 |       0 |         000000036 | Theo           |     5 jaar geleden |                |               6029 | 1AQ0100 |                            |
      |     2 |            1 |         0 |       0 |         000000024 | Tosca          | gisteren - 45 jaar | V              |                    | 1AQ0100 |             3 jaar geleden |

  Abstract Scenario: '{naam}' is <datum stapdefinitie> geadopteerd door '{naam}' en '{naam}'
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    * is een man
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    * is een vrouw
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * is minderjarig
    * is geboren in Duitsland
    En 'Theo' is <datum in stap> geadopteerd door 'Tosca' en 'Arjan'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | geslachts_aand | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | M              | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |                    |                | 1AQ0100 |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | geslachts_aand | akte_nr |
      |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | V              | 1AA0100 |
      |     2 | K            |         0 |       0 |         000000036 | Theo           |                    |                | 1AQ0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     3 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum            |
      |     3 | P            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |                |               6029 | 1AQ0100 |                                       |
      |     3 |            1 |         0 |       0 |         000000024 | Tosca          |                    | V              |                    | 1AQ0100 | <datum familierechtelijke betrekking> |
      |     3 |            2 |         0 |       0 |         000000012 | Arjan          |                    | M              |                    | 1AQ0100 | <datum familierechtelijke betrekking> |

    Voorbeelden:
      | datum stapdefinitie | datum in stap      | datum familierechtelijke betrekking |
      | op {datum}          | op 30-11-2019      |                            20191130 |
      | {relatieve datum}   |     2 jaar geleden |                      2 jaar geleden |
      | {relatieve datum}   | gisteren - 10 jaar | gisteren - 10 jaar                  |

  Scenario: '{naam}' is in het buitenland geadopteerd door '{naam}' en '{naam}' op {datum} met document '{document beschrijving}'
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    * is meerderjarig
    * is een man
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    * is meerderjarig
    * is een vrouw
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * is minderjarig
    * is geboren in Duitsland
    En 'Theo' is in het buitenland geadopteerd door 'Tosca' en 'Arjan' op 30-11-2019 met document 'ad akte 6029'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | doc_beschrijving |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar |               6030 | M              | 1AA0100 |                  |
      |     1 | K            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |                    |                |         | ad akte 6029     |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | doc_beschrijving |
      |     2 | P            |         0 |       0 |         000000024 | Arjan          | gisteren - 45 jaar |               6030 | V              | 1AA0100 |                  |
      |     2 | K            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |                    |                |         | ad akte 6029     |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     3 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geslachts_aand | geboorte_land_code | doc_beschrijving | familie_betrek_start_datum |
      |     3 | P            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |                |               6029 | ad akte 6029     |                            |
      |     3 |            1 |         0 |       0 |         000000024 | Tosca          | gisteren - 45 jaar | V              |                    | ad akte 6029     |                   20191130 |
      |     3 |            2 |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar | M              |                    | ad akte 6029     |                   20191130 |

  Scenario: '{naam}' heeft ontkend vader te zijn van '{naam}'
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * is minderjarig
    * heeft 'Arjan' en 'Tosca' als ouders
    En 'Arjan' heeft ontkend vader te zijn van 'Theo'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |                    |               6030 | 1AA0100 |
      |     1 | K            |         0 |       1 |         000000036 | Theo           | gisteren - 17 jaar |                    | 1AA0100 |
      |     1 | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      |     2 | P            |         0 |       0 |         000000024 | Tosca          |                    |               6030 | 1AA0100 |
      |     2 | K            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |                    | 1AA0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     3 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     3 | P            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |               6030 | 1AA0100 |                            |
      |     3 |            1 |         0 |       1 |         000000012 | Arjan          |                    |                    | 1AA0100 | gisteren - 17 jaar         |
      |     3 |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            |
      |     3 |            2 |         0 |       0 |         000000024 | Tosca          |                    |                    | 1AA0100 | gisteren - 17 jaar         |

  Scenario: {relatieve datum} heeft '{naam}' het ouderschap ontkend
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * is minderjarig
    * heeft 'Arjan' en 'Tosca' als ouders
    En 4 jaar geleden heeft 'Arjan' het ouderschap ontkend
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |                    |               6030 | 1AA0100 |
      |     1 | K            |         0 |       1 |         000000036 | Theo           | gisteren - 17 jaar |                    | 1AA0100 |
      |     1 | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000024 | Tosca          |                    |               6030 | 1AA0100 |
      |     1 | K            |         0 |       1 |         000000036 | Theo           | gisteren - 17 jaar |                    | 1AA0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     3 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum | geldigheid_start_datum |
      |     3 | P            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |               6030 | 1AA0100 |                            |                        |
      |     3 |            1 |         0 |       1 |         000000012 | Arjan          |                    |                    | 1AA0100 | gisteren - 17 jaar         |                        |
      |     3 |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            |         4 jaar geleden |
      |     3 |            2 |         0 |       0 |         000000024 | Tosca          |                    |                    | 1AA0100 | gisteren - 17 jaar         |                        |

  Scenario: {relatievedatum} is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende in stapdefinitie>
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * heeft 'Arjan' en 'Tosca' als ouders
    En <relatieve datum> is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |
      |     2 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     3 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     3 | P            |         0 |       0 |         000000036 | Theo           |               6030 | 1AA0100 |                            |
      |     3 |            1 |         0 |       0 |         000000012 | Arjan          |                    | 1AA0100 | gisteren - 17 jaar         |
      |     3 |            2 |         0 |       0 |         000000024 | Tosca          |                    | 1AA0100 | gisteren - 17 jaar         |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_gezagsverhouding'
      | pl_id | volg_nr | minderjarig_gezag_ind | geldigheid_start_datum |
      |     3 |       0 | <indicatie gezag>     | <relatieve datum>      |

    Voorbeelden:
      | relatieve datum   | gezaghebbende         | indicatie gezag | gezaghebbende in stapdefinitie |
      |    6 jaar geleden | 'Arjan'               |               1 | '{naam}'                       |
      | vorige maand      | 'Tosca'               |               2 | '{naam}'                       |
      | gisteren - 5 jaar | een voogdijinstelling | D               | een voogdijinstelling          |
      | gisteren - 4 jaar | een derde             | D               | een derde                      |
      |    2 jaar geleden | beide ouders          |              12 | beide ouders                   |
      |    2 jaar geleden | 'Arjan' en een derde  |              1D | '{naam}' en een derde          |
      |    2 jaar geleden | 'Tosca' en een derde  |              2D | '{naam}' en een derde          |
