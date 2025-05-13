# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Ouders worden toegevoegd als persoon_type respectievelijk '1' en '2' aan de persoon en de persoon als persoon_type 'K' bij de ouders

    @integratie
    Scenario: heeft '{naam}' als ouder
      # als er nog geen geboortedatum van de persoon bekend is, wordt 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1_A____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1_A____ |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             |                    | 1_A____ | gisteren - 17 jaar         |

    @integratie
    Abstract Scenario: neem geboortedatum van de minderjarige over: heeft '{naam}' als ouder
      # geboortedatumm wordt overgenomen naar de kind-relatie op de PL van de ouder
      # en familie_betrek_start_datum wordt gevuld met de geboortedatum
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de <geboortedatum> in 'Nederland' geboren 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                |               6030 | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | P2             | <datum>        |                    | 1_A____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             | <datum>            |               6030 | 1_A____ |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | 1_A____ | <datum>                    |

      Voorbeelden:
        | eigenschap kind        | geboortedatum            | datum              |
        | is meerderjarig        | gisteren 45 jaar geleden | gisteren - 45 jaar |
        | is minderjarig         | gisteren 17 jaar geleden | gisteren - 17 jaar |
        | is geboren op 5-8-1998 | op 5 augustus 1998       |           19980805 |

    @integratie
    Scenario: neem geboortedatum van de ouder over: heeft '{naam}' als ouder
      Gegeven de <geboortedatum> in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | <datum>        |               6030 | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                |                    | 1_A____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |                |               6030 | 1_A____ |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             | <datum>        |                    | 1_A____ | gisteren - 17 jaar         |

      Voorbeelden:
        | eigenschap ouder       | geboortedatum            | datum              |
        | is meerderjarig        | gisteren 45 jaar geleden | gisteren - 45 jaar |
        | is minderjarig         | gisteren 17 jaar geleden | gisteren - 17 jaar |
        | is geboren op 5-8-1998 | op 5 augustus 1998       |           19980805 |

    @integratie
    Scenario: neem geslacht van de ouder over: heeft '{naam}' als ouder
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren <geslacht> 'P1' met burgerservicenummer '000000012'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | geslachts_aand        |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1_A____ | <geslachtsaanduiding> |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1_A____ |                       |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum | geslachts_aand        |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1_A____ |                            |                       |
        | P2    |            1 |         0 |       0 |         000000012 | P1             |                    | 1_A____ | gisteren - 17 jaar         | <geslachtsaanduiding> |

      Voorbeelden:
        | eigenschap ouder | geslacht | geslachtsaanduiding |
        | is een vrouw     | vrouw    | V                   |
        | is een man       | man      | M                   |

    @integratie
    Scenario: heeft '{naam1}' en '{naam2}' als ouders
      # als er nog geen geboortedatum van de persoon bekend is, wordt default 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de morgen 40 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
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

    @integratie
    Scenario: overnemen gegevens van ouders en kind: heeft '{naam1}' en '{naam2}' als ouders
      # geboortedatumm van het kind wordt overgenomen naar de kind-relatie op de PL van de ouder en familie_betrek_start_datum wordt gevuld met de geboortedatum
      # geboortedatum en geslacht van de ouder worden overgenomen naar de ouder-relatie op de PL van de persoon
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren man 'P1' met burgerservicenummer '000000012'
      En de op 05 augustus 1988 in 'Nederland' geboren vrouw 'P2' met burgerservicenummer '000000024'
      En de 2 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |               6030 | M              | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | P3             |     2 jaar geleden |                    |                | 1_A____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | geslachts_aand | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |       19880805 |               6030 | V              | 1_A____ |
        | P2    | K            |         0 |       0 |         000000036 | P3             | 2 jaar geleden |                    |                | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |     2 jaar geleden |               6030 |                | 1_A____ |                            |
        | P3    |            1 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | M              | 1_A____ |             2 jaar geleden |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |           19880805 |                    | V              | 1_A____ |             2 jaar geleden |

    @integratie
    Scenario: heeft '{naam}' als ouder die niet met burgerservicenummer is ingeschreven in de BRP
      # geboortedatum van de niet-ingezeten ouder wordt standaard gevuld als meerderjarig (gisteren - 45 jaar)
      # mogelijk gaan we later andere varianten toevoegen (minderjarige ouder) of extra gegevens toevoegen (voornamen, geboorteplaats, geboorteland, ...?)
      # als er nog geen geboortedatum van de persoon bekend is, wordt 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren man 'P1' met burgerservicenummer '000000012'
      En de meerderjarige vrouw 'P3' zonder burgerservicenummer
      En de gisteren 17 jaar geleden in 'Nederland' geboren man 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P3' als ouders
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1_A____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |                    |               6030 | 1_A____ |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | 1_A____ | gisteren - 17 jaar         |
        | P2    |            2 |         0 |       0 |                   | P3             | gisteren - 45 jaar |                    | 1_A____ | gisteren - 17 jaar         |

    @integratie
    Scenario: '{naam}' is erkend door '{naam}' op {datum}
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren man 'P1' met burgerservicenummer '000000012'
      En de gisteren 45 jaar geleden in 'Nederland' geboren vrouw 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P2' als ouder
      En 'P3' is erkend door 'P1' op 16-5-2021
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | gisteren - 45 jaar | P1             |               6030 | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | P3             |                    | 1_C____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | gisteren - 45 jaar | P2             |               6030 | 1_A____ |
        | P2    | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | P3             |                    | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1_C____ |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |                    | 1_A____ | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | 1_C____ |                   20210516 |

    @integratie
    Scenario: overnemen gegevens van ouder en kind: '{naam}' is erkend door '{naam}' op {datum}
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren man 'P1' met burgerservicenummer '000000012'
      En de gisteren 45 jaar geleden in 'Nederland' geboren vrouw 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P2' als ouder
      En 'P3' is erkend door 'P1' op 16-5-2021
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | geslachts_aand | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | gisteren - 45 jaar | P1             |               6030 | M              | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | P3             |                    |                | 1_C____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 |                    | P2             |               6030 | 1_A____ |
        | P2    | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | P3             |                    | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 |                | 1_C____ |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |                    |                | 1_A____ | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | M              | 1_C____ |                   20210516 |

  Regel: Een gerechtelijke uitspraak wordt vastgelegd in de gezagsverhouding

    @integratie
    Scenario: <stapdefinitie>
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de morgen 40 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      En in een gerechtelijke uitspraak is <gezag uitspraak>
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
        | P3    |       0 | <indicatie gezag>     | gisteren - 1 jaar      |

      Voorbeelden:
        | gezag uitspraak                            | indicatie gezag | stapdefinitie                                                                    |
        | het gezag toegewezen aan 'P1'              |               1 | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}'              |
        | het gezag toegewezen aan 'P2'              |               2 | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}'              |
        | het gezag toegewezen aan beide ouders      |              12 | in een gerechtelijke uitspraak is het gezag toegewezen aan beide ouders          |
        | een voogdijinstelling tot voogd benoemd    | D               | in een gerechtelijke uitspraak is een voogdijinstelling tot voogd benoemd        |
        | een derde tot voogd benoemd                | D               | in een gerechtelijke uitspraak is een derde tot voogd benoemd                    |
        | het gezag toegewezen aan 'P1' en een derde |              1D | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}' en een derde |
        | het gezag toegewezen aan 'P2' en een derde |              2D | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}' en een derde |

    @integratie
    Scenario: {relatieve datum} heeft '{naam}' het ouderschap ontkend
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de gisteren 45 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      En 4 jaar geleden heeft 'P1' het ouderschap ontkend
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                    |               6030 | 1_A____ |
        | P1    | K            |         0 |       1 |         000000036 | P3             | gisteren - 17 jaar |                    | 1_A____ |
        | P1    | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |                    |               6030 | 1_A____ |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum | geldigheid_start_datum | onjuist_ind |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1_A____ |                            |                        |             |
        | P3    |            1 |         0 |       1 |         000000012 | P1             | gisteren - 45 jaar |                    | 1_A____ | gisteren - 17 jaar         |                        | O           |
        | P3    |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            |         4 jaar geleden |             |
        | P3    |            2 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |                    | 1_A____ | gisteren - 17 jaar         |                        |             |

    @integratie
    Scenario: '{naam}' heeft ontkend vader te zijn van '{naam}'
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de gisteren 45 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      En 'P1' heeft ontkend vader te zijn van 'P3'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                    |               6030 | 1_A____ |
        | P1    | K            |         0 |       1 |         000000036 | P3             | gisteren - 17 jaar |                    | 1_A____ |
        | P1    | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |                    |               6030 | 1_A____ |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum | geldigheid_start_datum | onjuist_ind |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1_A____ |                            |                        |             |
        | P3    |            1 |         0 |       1 |         000000012 | P1             | gisteren - 45 jaar |                    | 1_A____ | gisteren - 17 jaar         |                        | O           |
        | P3    |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            | gisteren - 17 jaar     |             |
        | P3    |            2 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |                    | 1_A____ | gisteren - 17 jaar         |                        |             |

    @integratie
    Scenario: heeft '{naam}' als ouder vanaf de geboortedatum
      # deze stap is volledig identiek aan stap "heeft '{naam}' als ouder"
      # toevoeging is alleen bedoeld om aan lezer te benadrukken dat de ouder op de geboorteakte staat en familierechtelijke betrekking gelijk is aan geboortedatum
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder vanaf de geboortedatum
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1_A____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1_A____ |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             |                    | 1_A____ | gisteren - 17 jaar         |

    @integratie
    Scenario: heeft '{naam1}' en '{naam2}' als ouders vanaf de geboortedatum
      # deze stap is volledig identiek aan stap "heeft '{naam1}' en '{naam2}' als ouders"
      # toevoeging is alleen bedoeld om aan lezer te benadrukken dat de ouder op de geboorteakte staat en familierechtelijke betrekking gelijk is aan geboortedatum
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de morgen 40 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P3' als ouders vanaf de geboortedatum
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1_A____ |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P3    | P            |         0 |       0 |         000000024 | P3             |               6030 | 1_A____ |
        | P3    | K            |         0 |       0 |         000000036 | P2             |                    | 1_A____ |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1_A____ |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             |                    | 1_A____ | gisteren - 17 jaar         |
        | P2    |            2 |         0 |       0 |         000000024 | P3             |                    | 1_A____ | gisteren - 17 jaar         |

    @integratie
    Scenario: '{naam}' heeft ontkend vader te zijn van '{naam}'
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de morgen 40 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      En 'P1' heeft ontkend vader te zijn van 'P3'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                    |               6030 | 1_A____ |
        | P1    | K            |         0 |       1 |         000000036 | P3             | gisteren - 17 jaar |                    | 1_A____ |
        | P1    | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |                    |               6030 | 1_A____ |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1_A____ |                            |
        | P3    |            1 |         0 |       1 |         000000012 | P1             |                    |                    | 1_A____ | gisteren - 17 jaar         |
        | P3    |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |                    |                    | 1_A____ | gisteren - 17 jaar         |

    @integratie
    Scenario: {relatieve datum} heeft '{naam}' het ouderschap ontkend
      Gegeven de gisteren 45 jaar geleden in 'Nederland' geboren 'P1' met burgerservicenummer '000000012'
      En de morgen 40 jaar geleden in 'Nederland' geboren 'P2' met burgerservicenummer '000000024'
      En de gisteren 17 jaar geleden in 'Nederland' geboren 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      En 4 jaar geleden heeft 'P1' het ouderschap ontkend
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                    |               6030 | 1_A____ |
        | P1    | K            |         0 |       1 |         000000036 | P3             | gisteren - 17 jaar |                    | 1_A____ |
        | P1    | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |                    |               6030 | 1_A____ |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    | 1_A____ |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum | geldigheid_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1_A____ |                            |                        |
        | P3    |            1 |         0 |       1 |         000000012 | P1             |                    |                    | 1_A____ | gisteren - 17 jaar         |                        |
        | P3    |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            |         4 jaar geleden |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |                    |                    | 1_A____ | gisteren - 17 jaar         |                        |

    @integratie
    Abstract Scenario: {relatievedatum} is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende in stapdefinitie>
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
