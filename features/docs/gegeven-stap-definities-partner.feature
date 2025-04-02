# language: nl

@integratie @stap-documentatie
Functionaliteit: Partner gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de tabel 'lo3_pl_persoon' bevat geen rijen

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft een 'partner' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |    9999,0,0,R,Jansen |

  Scenario: de persoon heeft (nog) een 'partner' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft nog een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) |
      | Aedel                 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |    9999,0,0,R,Jansen |
      |      | partner-2    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |     9999,1,0,R,Aedel |

  Scenario: de 'partner' is gewijzigd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de 'partner' is gewijzigd naar de volgende gegevens
      | geslachtsnaam (02.40) |
      | Aedel                 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |    9999,0,1,R,Jansen |
      |      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |     9999,0,0,R,Aedel |

  Scenario: de 'partner' is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de 'partner' is gecorrigeerd naar de volgende gegevens
      | geslachtsnaam (02.40) |
      | Aedel                 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)                          |  9999,0,1,R,Jansen,O |
      |      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |     9999,0,0,R,Aedel |

  @integratie
  Scenario: personen zijn met elkaar gehuwd
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_start_datum | relatie_start_plaats | relatie_start_land_code |
      |     1 | R            |         0 |       0 |         000000024 | P2             | gisteren - 20 jaar  |                 0518 |                    6030 |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_start_datum | relatie_start_plaats | relatie_start_land_code |
      |     2 | R            |         0 |       0 |         000000012 | P1             | gisteren - 20 jaar  |                 0518 |                    6030 |

  @integratie
  Scenario: personen zijn met elkaar gehuwd met de volgende gegevens
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      |                                                           20100401 |
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_start_datum |
      |     1 | R            |         0 |       0 |         000000024 | P2             |            20100401 |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_start_datum |
      |     2 | R            |         0 |       0 |         000000012 | P1             |            20100401 |

  @integratie
  Scenario: personen zijn gescheiden
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd
    En 'P1' en 'P2' zijn gescheiden
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_start_datum | relatie_start_plaats | relatie_start_land_code |
      |     1 | R            |         0 |       1 |         000000024 | P2             | gisteren - 20 jaar  |                 0518 |                    6030 |
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code |
      |     1 | R            |         0 |       0 |         000000024 | P2             | gisteren - 1 jaar  |                0518 |                   6030 |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_start_datum | relatie_start_plaats | relatie_start_land_code |
      |     2 | R            |         0 |       1 |         000000012 | P1             | gisteren - 20 jaar  |                 0518 |                    6030 |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code |
      |     2 | R            |         0 |       0 |         000000012 | P1             | gisteren - 1 jaar  |                0518 |                   6030 |

  @integratie
  Scenario: personen zijn gescheiden met de volgende gegevens
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd
    En 'P1' en 'P2' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      |                                                     20101231 |
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_eind_datum |
      |     1 | R            |         0 |       0 |         000000024 | P2             |           20101231 |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_eind_datum |
      |     2 | R            |         0 |       0 |         000000012 | P1             |           20101231 |

  @integratie
  Scenario: persoon heeft partner en ex-partner
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd
    En 'P1' en 'P2' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      |                                                     20101231 |
    En de persoon 'P3' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P3                    |
    En 'P1' en 'P3' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      |                                                           20240101 |
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_eind_datum | relatie_start_datum |
      |     1 | R            |         0 |       0 |         000000024 | P2             |           20101231 |                     |
      |     1 | R            |         1 |       0 |         000000036 | P3             |                    |            20240101 |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_eind_datum |
      |     2 | R            |         0 |       0 |         000000012 | P1             |           20101231 |
    En heeft de persoon 'P3' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | relatie_start_datum |
      |     3 | R            |         0 |       0 |         000000012 | P1             |            20240101 |

  @integratie
  Scenario: personen zijn op een relatieve datum een geregistreerd partnerschap aangegaan
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
      |     1 | R            |         0 |       0 |         000000024 | P2             |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
      |     2 | R            |         0 |       0 |         000000012 | P1             |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |

  @integratie
  Scenario: huwelijk gecorrigeerd als nietig
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd
    En is het huwelijk van 'P1' en 'P2' gecorrigeerd met de volgende gegevens
      | naam                                                                | waarde         |
      | burgerservicenummer (01.20)                                         |                |
      | geslachtsnaam (02.40)                                               |                |
      | geboortedatum (03.10)                                               |                |
      | geslachtsaanduiding (04.10)                                         |                |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  |                |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) |                |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   |                |
      | datum ingang geldigheid (85.10)                                     | 2 jaar geleden |
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | onjuist_ind | geldigheid_start_datum |
      |     1 | R            |         0 |       1 |         000000024 | P2             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 | O           |                        |
      |     1 | R            |         0 |       0 |                   |                |                    |         |                     |                      |                         |             |         2 jaar geleden |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | onjuist_ind | geldigheid_start_datum |
      |     2 | R            |         0 |       1 |         000000012 | P1             |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 | O           |                        |
      |     2 | R            |         0 |       0 |                   |                |                    |         |                     |                      |                         |             |         2 jaar geleden |
       