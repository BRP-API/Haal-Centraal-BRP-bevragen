# language: nl
@stap-documentatie
Functionaliteit: Persoon, Inschrijving gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'

  @integratie
  Scenario: de persoon '{aanduiding}'
    Gegeven de persoon 'P1'
    En de persoon 'P2'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P1    |          0 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam |
      | P1    |         0 |       0 | P            |         000000012 | P1             |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P2    |          0 |
    En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam |
      | P2    |         0 |       0 | P            |         000000024 | P2             |

  @integratie
  Abstract Scenario: (de) persoon '[persoon aanduiding]' heeft de volgende gegevens
    Gegeven <stap>
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P1    |          0 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam |
      | P1    |         0 |       0 | P            |         000000012 | Jansen         |

    Voorbeelden:
      | stap                                       |
      | persoon 'P1' heeft de volgende gegevens    |
      | de persoon 'P1' heeft de volgende gegevens |

  @integratie
  Scenario: (de) persoon '[persoon aanduiding]' zonder burgerservicenummer heeft de volgende gegevens
    Gegeven <stap>
      | geslachtsnaam (02.40) |
      | Jansen                |
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan zijn er geen rijen in tabel 'lo3_pl'
    En zijn er geen rijen in tabel 'lo3_pl_persoon'

    Voorbeelden:
      | stap                                                                  |
      | persoon 'P1' zonder burgerservicenummer heeft de volgende gegevens    |
      | de persoon 'P1' zonder burgerservicenummer heeft de volgende gegevens |

  @integratie
  Abstract Scenario: de {datum} geboren {geslacht type} '{persoon aanduiding}'
    Gegeven de <datum> geboren <geslacht type> 'Jansen'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl'
      | pl_id  | geheim_ind |
      | Jansen |          0 |
    En heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id  | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | geslachts_aand        | akte_nr |
      | Jansen |         0 |       0 | P            |         000000012 | Jansen         | <geboortedatum> |               6030 | <geslachtsaanduiding> | 1_A____ |

    Voorbeelden:
      | datum                  | geslacht type | geboortedatum    | geslachtsaanduiding |
      | vandaag 5 jaar geleden | man           | vandaag - 5 jaar | M                   |
      | op 21 januari 2021     | vrouw         |         20210121 | V                   |
      | op een onbekende datum |               |         00000000 |                     |
      | op 21-01-2021          | man           |         20210121 | M                   |

  @integratie
  Abstract Scenario: de {meer- of minderjarige} {geslacht type} '{persoon aanduiding}'
    Gegeven de <omschrijving persoon> 'Jansen'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl'
      | pl_id  | geheim_ind |
      | Jansen |          0 |
    En heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id  | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | geslachts_aand        | akte_nr |
      | Jansen |         0 |       0 | P            |         000000012 | Jansen         | <geboortedatum> |               6030 | <geslachtsaanduiding> | 1_A____ |

    Voorbeelden:
      | omschrijving persoon | geboortedatum      | geslachtsaanduiding |
      | minderjarige         | gisteren - 17 jaar |                     |
      | meerderjarige vrouw  | gisteren - 45 jaar | V                   |

  @integratie
  Scenario: de {datum} geboren {geslacht type} '{persoon aanduiding}'
    Gegeven de vandaag 5 jaar geleden geboren man 'Jansen'
    En de op 21 januari 2021 geboren vrouw 'Pietersen'
    En de op een onbekende datum geboren 'Maassen'
    En de in februari 2022 geboren man 'Klaassen'
    En de in 2023 geboren vrouw 'Stöcker'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl'
      | pl_id  | geheim_ind |
      | Jansen |          0 |
    En heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id  | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum   | geboorte_land_code | geslachts_aand | akte_nr |
      | Jansen |         0 |       0 | P            |         000000012 | Jansen         | vandaag - 5 jaar |               6030 | M              | 1_A____ |
    En heeft persoon 'Pietersen' de volgende rij in tabel 'lo3_pl'
      | pl_id     | geheim_ind |
      | Pietersen |          0 |
    En heeft persoon 'Pietersen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id     | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | geslachts_aand | akte_nr |
      | Pietersen |         0 |       0 | P            |         000000024 | Pietersen      |       20210121 |               6030 | V              | 1_A____ |
    En heeft persoon 'Maassen' de volgende rij in tabel 'lo3_pl'
      | pl_id   | geheim_ind |
      | Maassen |          0 |
    En heeft persoon 'Maassen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id   | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | geslachts_aand | akte_nr |
      | Maassen |         0 |       0 | P            |         000000036 | Maassen        |       00000000 |               6030 |                | 1_A____ |
    En heeft persoon 'Klaassen' de volgende rij in tabel 'lo3_pl'
      | pl_id    | geheim_ind |
      | Klaassen |          0 |
    En heeft persoon 'Klaassen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id    | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | geslachts_aand | akte_nr |
      | Klaassen |         0 |       0 | P            |         000000048 | Klaassen       |       20220200 |               6030 | M              | 1_A____ |
    En heeft persoon 'Stöcker' de volgende rij in tabel 'lo3_pl'
      | pl_id   | geheim_ind |
      | Stöcker |          0 |
    En heeft persoon 'Maassen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id   | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | geslachts_aand | akte_nr |
      | Stöcker |         0 |       0 | P            |         000000060 | Stöcker        |       20230000 |               6030 | V              | 1_A____ |

  @integratie
  Abstract Scenario: de {datum} in {land omschrijving} geboren {geslacht type} '{persoon aanduiding}' met burgerservicenummer '{bsn}'
    Gegeven de <datum> in <land omschrijving> geboren <geslacht type> 'Jansen' met burgerservicenummer '000000012'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl'
      | pl_id  | geheim_ind |
      | Jansen |          0 |
    En heeft persoon 'Jansen' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id  | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code  | geslachts_aand        | akte_nr  | doc_beschrijving        |
      | Jansen |         0 |       0 | P            |         000000012 | Jansen         | <geboortedatum> | <code geboorteland> | <geslachtsaanduiding> | <aktenr> | <document beschrijving> |

    Voorbeelden:
      | datum                  | land omschrijving                   | geslacht type | geboortedatum    | code geboorteland | geslachtsaanduiding | aktenr  | document beschrijving     |
      | vandaag 5 jaar geleden | 'Nederland'                         | man           | vandaag - 5 jaar |              6030 | M                   | 1_A____ |                           |
      | op 21 januari 2021     | de 'Verenigde Staten van Amerika'   | vrouw         |         20210121 |              6014 | V                   |         | buitenlandse geboorteakte |
      | op een onbekende datum | het 'Verenigde Arabische Republiek' | man           |         00000000 |              9047 | M                   |         | buitenlandse geboorteakte |
      | in februari 2021       | 'België'                            |               |         20210200 |              5010 |                     |         | buitenlandse geboorteakte |
      | op 21-01-2021          | 'Madeira-eilanden'                  | man           |         20210121 |              7087 | M                   |         | buitenlandse geboorteakte |

  @integratie
  Abstract Scenario: de meerderjarige {geslacht type} '{persoon aanduiding}' zonder burgerservicenummer
    Gegeven de meerderjarige <geslacht> 'Jansen' zonder burgerservicenummer
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan zijn er geen rijen in tabel 'lo3_pl'
    En zijn er geen rijen in tabel 'lo3_pl_persoon'

    Voorbeelden:
      | geslacht |
      | man      |
      | vrouw    |
      |          |

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft de volgende gegevens (meerdere personen)
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de persoon met burgerservicenummer '000000013' heeft de volgende gegevens
      | naam                  | waarde    |
      | geslachtsnaam (02.40) | Pietersen |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values                          |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                               0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    |     9999,0,0,P,000000012,Jansen |
      |    2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                               0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 10000,0,0,P,000000013,Pietersen |

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft de volgende 'inschrijving' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'inschrijving' gegevens
      | indicatie geheim (70.10) |
      |                        7 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    7 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |

  Scenario: de persoon met burgerservicenummer '[bsn]'  heeft de volgende 'kiesrecht' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'kiesrecht' gegevens
      | aanduiding uitgesloten kiesrecht (38.10) |
      | A                                        |
    Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                                                            | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,kiesrecht_uitgesl_aand) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2) RETURNING * |                  0,A |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                | 9999,0,0,P,000000012 |

  Scenario: de persoon heeft de volgende 'inschrijving' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft de volgende 'inschrijving' gegevens
      | indicatie geheim (70.10) |
      |                        7 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values                      |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                           7 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,Jansen |

  Scenario: de persoon heeft de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft de volgende gegevens
      | aanduiding in onderzoek (83.10) |
      |                          010000 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                          | values                             |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *         |                                  0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,onderzoek_gegevens_aand) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,0,0,P,000000012,Jansen,010000 |

  Scenario: de persoon is gewijzigd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de persoon is gewijzigd naar de volgende gegevens
      | naam                  | waarde    |
      | geslachtsnaam (02.40) | Pietersen |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values                      |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                           0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,1,P,000000012,Jansen |
      |      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |        9999,0,0,P,Pietersen |

  Scenario: de persoon is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de persoon is gecorrigeerd naar de volgende gegevens
      | naam                  | waarde  |
      | geslachtsnaam (02.40) | Janssen |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values                        |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                             0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6,$7)     | 9999,0,1,P,000000012,Jansen,O |
      |      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |            9999,0,0,P,Janssen |

  Scenario: de persoon heeft een niet-gegenereerd pl_id (kolom variant)
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | pl_id |
      |  9999 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                             | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES(9999,current_timestamp,$1) RETURNING *             |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5) | 9999,0,0,P,000000012 |

  Scenario: de persoon heeft een niet-gegenereerd pl_id (rij variant)
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam  | waarde |
      | pl_id |   9999 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                             | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES(9999,current_timestamp,$1) RETURNING *             |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5) | 9999,0,0,P,000000012 |

  @integratie
  Scenario: de {datum}( geboren) inwoner {aanduiding}
    Gegeven <persoon beschrijving>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | P1    |          0 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
      | P1    |         0 |       0 | P            |         000000012 | P1             | <geboortedatum> |               6030 | 1_A____ |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | P1    |       0 |                       0518 |

    Voorbeelden:
      | persoon beschrijving                           | geboortedatum      |
      | de vandaag 5 jaar geleden geboren inwoner 'P1' | vandaag - 5 jaar   |
      | de 5 jaar geleden geboren inwoner 'P1'         | vandaag - 5 jaar   |
      | de op 21 januari 2021 geboren inwoner 'P1'     |           20210121 |
      | de op 21-01-2021 geboren inwoner 'P1'          |           20210121 |
      | de op een onbekende datum geboren inwoner 'P1' |           00000000 |
      | de minderjarige inwoner 'P1'                   | gisteren - 17 jaar |
      | de meerderjarige inwoner 'P1'                  | gisteren - 45 jaar |
