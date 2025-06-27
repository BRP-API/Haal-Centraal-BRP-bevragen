# language: nl
@stap-documentatie
Functionaliteit: Persoon, Inschrijving, Verblijfplaats gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'
    En de 3e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10001'

  Scenario: persoon '[persoon aanduiding]' heeft de volgende gegevens
    Gegeven persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                  | values                      |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                           0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,Jansen |

  Abstract Scenario: heeft de volgende personen zonder burgerservicenummer als ouder
    Gegeven persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    * heeft de volgende persoon zonder burgerservicenummer als ouder <ouder type>
      | geslachtsnaam (02.40) |
      | Albers                |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie          | text                                                                                                                                                  | values                       |
      | persoon-P1 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                            0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    |  9999,0,0,P,000000012,Jansen |
      |            | ouder-<ouder type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,<ouder type>,Albers |

    Voorbeelden:
      | ouder type |
      |          1 |
      |          2 |

  Scenario: de persoon met burgerservicenummer '[bsn]'
    Gegeven de persoon met burgerservicenummer '000000012'
    Dan zijn de gegenereerde SQL statements
      | stap      | categorie    | text                                                                                                                                                  | values               |
      | persoon-1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |           | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |

  Scenario: de persoon met burgerservicenummer '[bsn]' (meerdere personen)
    Gegeven de persoon met burgerservicenummer '000000012'
    En de persoon met burgerservicenummer '000000024'
    Dan zijn de gegenereerde SQL statements
      | stap      | categorie    | text                                                                                                                                                  | values                |
      | persoon-1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                     0 |
      |           | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      |  9999,0,0,P,000000012 |
      | persoon-2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                     0 |
      |           | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000024 |

  Scenario: de persoon '[aanduiding]' met burgerservicenummer '[bsn]'
    Gegeven de persoon 'P1' met burgerservicenummer '000000012'
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                | values                               |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *               |                                    0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,geboorte_land_code,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8) | 9999,0,0,P,000000012,P1,6030,1AA0100 |

  Scenario: persoon '[aanduiding]' (persoon context en pl_id switch)
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En persoon 'P1'
    * is minderjarig
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                  | values                                      |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                                           0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,geboorte_datum) VALUES($1,$2,$3,$4,$5,$6,$7)  | 10000,0,0,P,000000012,P1,gisteren - 17 jaar |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                                           0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    |                     9999,0,0,P,000000024,P2 |

  Scenario: is minderjarig
    Gegeven de persoon met burgerservicenummer '000000012'
    * is minderjarig
    Dan zijn de gegenereerde SQL statements
      | stap      | categorie    | text                                                                                                                                                  | values                                  |
      | persoon-1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                                       0 |
      |           | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geboorte_datum) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,gisteren - 17 jaar |

  Abstract Scenario: <stap>
    Gegeven de persoon met burgerservicenummer '000000012'
    * <stap>
    Dan zijn de gegenereerde SQL statements
      | stap      | categorie    | text                                                                                                                                                  | values                                  |
      | persoon-1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                                       0 |
      |           | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geboorte_datum) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,gisteren - 45 jaar |

    Voorbeelden:
      | stap                                                         |
      | is meerderjarig                                              |
      | is meerderjarig, niet overleden en staat niet onder curatele |

  Scenario: is ingeschreven in de BRP
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P1                    |
    * is ingeschreven in de BRP
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie      | text                                                                                                                                                  | values                  |
      | persoon-P1 | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                       0 |
      |            | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000036,P1 |
      |            | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,volg_nr,inschrijving_gemeente_code) VALUES($1,$2,$3)                                                   |             9999,0,0518 |

  Scenario: is in Nederland geboren
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P1                    |
    * is in Nederland geboren
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                | values                               |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *               |                                    0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,geboorte_land_code,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8) | 9999,0,0,P,000000036,P1,6030,1AA0100 |

  Abstract Scenario: heeft '[aanduiding]' als ouder [1 of 2]
    Gegeven de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P2                    |
    En de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P1                    |
    * heeft 'P2' als ouder <ouder type>
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie          | text                                                                                                                                                             | values                                                 |
      | persoon-P2 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                                      0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                                9999,0,0,P,000000012,P2 |
      |            | kind-1             | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                    |                        9999,0,0,K,000000036,P1,1AA0100 |
      | persoon-P1 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                                      0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                               10000,0,0,P,000000036,P1 |
      |            | ouder-<ouder type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7) | 10000,0,0,<ouder type>,000000012,P2,gisteren - 17 jaar |

    Voorbeelden:
      | ouder type |
      |          1 |
      |          2 |

  Abstract Scenario: heeft '[aanduiding]' als ouder [1 of 2] met de volgende gegevens
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    * heeft 'P1' als ouder <ouder type> met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 10 jaar                                   |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie          | text                                                                                                                                                             | values                                               |
      | persoon-P1 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                                    0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                              9999,0,0,P,000000012,P1 |
      |            | kind-1             | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                    |                      9999,0,0,K,000000024,P2,1AA0100 |
      | persoon-P2 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                                    0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                             10000,0,0,P,000000024,P2 |
      |            | ouder-<ouder type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7) | 10000,0,0,<ouder type>,000000012,P1,morgen - 10 jaar |

    Voorbeelden:
      | ouder type |
      |          1 |
      |          2 |

  Scenario: persoon heeft meerdere kinderen
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    Gegeven de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    * heeft 'P1' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 10 jaar                                   |
    En de persoon 'P3' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P3                    |
    * heeft 'P1' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | gisteren - 8 jaar                                  |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                             | values                                     |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                          0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                    9999,0,0,P,000000012,P1 |
      |            | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                    |            9999,0,0,K,000000024,P2,1AA0100 |
      |            | kind-2       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                    |            9999,1,0,K,000000036,P3,1AA0100 |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                          0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                   10000,0,0,P,000000024,P2 |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7) |  10000,0,0,1,000000012,P1,morgen - 10 jaar |
      | persoon-P3 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                          0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                   10001,0,0,P,000000036,P3 |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7) | 10001,0,0,1,000000012,P1,gisteren - 8 jaar |

  Scenario: '[aanduiding 1]' en '[aanduiding 2]' zijn met elkaar gehuwd
    Gegeven de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P2                    |
    Gegeven de persoon 'P3' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P3                    |
    * 'P2' en 'P3' zijn met elkaar gehuwd
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                                                                               | values                                                  |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                 9999,0,0,P,000000012,P2 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) |  9999,0,0,R,000000024,P3,gisteren - 20 jaar,0518,6030,H |
      | persoon-P3 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                10000,0,0,P,000000024,P3 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) | 10000,0,0,R,000000012,P2,gisteren - 20 jaar,0518,6030,H |

  Scenario: '[aanduiding 1]' en '[aanduiding 2]' zijn met elkaar gehuwd met de volgende gegevens
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      |                                                           20100401 |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                      | values                            |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *     |                                 0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                        |           9999,0,0,P,000000012,P1 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7) |  9999,0,0,R,000000024,P2,20100401 |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *     |                                 0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                        |          10000,0,0,P,000000024,P2 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7) | 10000,0,0,R,000000012,P1,20100401 |

  Scenario: '[aanduiding 1]' en '[aanduiding 2]' zijn gescheiden
    Gegeven de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P2                    |
    En de persoon 'P3' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P3                    |
    * 'P2' en 'P3' zijn met elkaar gehuwd
    * 'P2' en 'P3' zijn gescheiden
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                                                                                                   | values                                                   |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                                                  | 0                                                        |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                                     | 9999,0,0,P,000000012,P2                                  |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)                     | 9999,0,1,R,000000024,P3,gisteren - 20 jaar,0518,6030,H   |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,verbintenis_soort,relatie_eind_datum,relatie_eind_plaats,relatie_eind_land_code,relatie_eind_reden) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) | 9999,0,0,R,000000024,P3,H,gisteren - 1 jaar,0518,6030,S  |
      | persoon-P3 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                                                  | 0                                                        |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                                     | 10000,0,0,P,000000024,P3                                 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)                     | 10000,0,1,R,000000012,P2,gisteren - 20 jaar,0518,6030,H  |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,verbintenis_soort,relatie_eind_datum,relatie_eind_plaats,relatie_eind_land_code,relatie_eind_reden) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) | 10000,0,0,R,000000012,P2,H,gisteren - 1 jaar,0518,6030,S |

  Scenario: '[aanduiding 1]' en '[aanduiding 2]' zijn gescheiden met de volgende gegevens
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
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                                                                               | values                                                  |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                 9999,0,0,P,000000012,P1 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) |  9999,0,1,R,000000024,P2,gisteren - 20 jaar,0518,6030,H |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,verbintenis_soort,relatie_eind_datum) VALUES($1,$2,$3,$4,$5,$6,$7,$8)                                                      |                      9999,0,0,R,000000024,P2,H,20101231 |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                10000,0,0,P,000000024,P2 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) | 10000,0,1,R,000000012,P1,gisteren - 20 jaar,0518,6030,H |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,verbintenis_soort,relatie_eind_datum) VALUES($1,$2,$3,$4,$5,$6,$7,$8)                                                      |                     10000,0,0,R,000000012,P1,H,20101231 |

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
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                                                                               | values                                                  |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                 9999,0,0,P,000000012,P1 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) |  9999,0,1,R,000000024,P2,gisteren - 20 jaar,0518,6030,H |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,verbintenis_soort,relatie_eind_datum) VALUES($1,$2,$3,$4,$5,$6,$7,$8)                                                      |                      9999,0,0,R,000000024,P2,H,20101231 |
      |            | partner-2    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7)                                                                          |                        9999,1,0,R,000000036,P3,20240101 |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                10000,0,0,P,000000024,P2 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) | 10000,0,1,R,000000012,P1,gisteren - 20 jaar,0518,6030,H |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,verbintenis_soort,relatie_eind_datum) VALUES($1,$2,$3,$4,$5,$6,$7,$8)                                                      |                     10000,0,0,R,000000012,P1,H,20101231 |
      | persoon-P3 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                10001,0,0,P,000000036,P3 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7)                                                                          |                       10001,0,0,R,000000012,P1,20240101 |

  Scenario: zijn van ouder [1 of 2] de volgende gegevens gewijzigd
    Gegeven de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P2                    |
    En de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P1                    |
    * heeft 'P2' als ouder 1
    * zijn van ouder 1 de volgende gegevens gewijzigd
      | datum ingang familierechtelijke betrekking (62.10) |
      |                                           20200101 |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                             | values                                      |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                           0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                     9999,0,0,P,000000012,P2 |
      |            | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                    |             9999,0,0,K,000000036,P1,1AA0100 |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *            |                                           0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                               |                    10000,0,0,P,000000036,P1 |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7) | 10000,0,1,1,000000012,P2,gisteren - 17 jaar |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7) |           10000,0,0,1,000000012,P2,20200101 |

  Scenario: zijn van ouder [1 of 2] de volgende gegevens gecorrigeerd
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    * heeft 'P1' als ouder 1
    * zijn van ouder 1 de volgende gegevens gecorrigeerd
      | datum ingang familierechtelijke betrekking (62.10) |
      |                                           20200101 |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                            | values                                        |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                           |                                             0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                              |                       9999,0,0,P,000000012,P1 |
      |            | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                                   |               9999,0,0,K,000000024,P2,1AA0100 |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                           |                                             0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                              |                      10000,0,0,P,000000024,P2 |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6,$7,$8) | 10000,0,1,1,000000012,P1,gisteren - 17 jaar,O |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7)                |             10000,0,0,1,000000012,P1,20200101 |

  Abstract Scenario: is geadopteerd door '[aanduiding]' als ouder [1 of 2]
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    * is geadopteerd door 'P1' als ouder <ouder type>
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie          | text                                                                                                                                                                        | values                                                      |
      | persoon-P1 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                           0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                                     9999,0,0,P,000000012,P1 |
      |            | kind-1             | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                               |                             9999,0,0,K,000000024,P2,1AQ0100 |
      | persoon-P2 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                           0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                                    10000,0,1,P,000000024,P2 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                               |                            10000,0,0,P,000000024,P2,1AQ0100 |
      |            | ouder-<ouder type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8) | 10000,0,0,<ouder type>,000000012,P1,10 jaar geleden,1AQ0100 |

    Voorbeelden:
      | ouder type |
      |          1 |
      |          2 |

  Scenario: is geadopteerd door '[aanduiding]' als ouder [1 of 2] met de volgende gegevens
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    * 'P2' is geadopteerd door 'P1' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aktenummer (81.20) |
      | gisteren - 5 jaar                                  |            2BR1211 |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                        | values                                             |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                  0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                            9999,0,0,P,000000012,P1 |
      |            | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                               |                    9999,0,0,K,000000024,P2,1AQ0100 |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                  0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                           10000,0,1,P,000000024,P2 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                               |                   10000,0,0,P,000000024,P2,1AQ0100 |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8) | 10000,0,0,1,000000012,P1,gisteren - 5 jaar,2BR1211 |

  Scenario: heeft gezag uitspraak
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P1                    |
    En voor 'P1' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    |                        20220701 |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie        | text                                                                                                                                                  | values                  |
      | persoon-P1 | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                       0 |
      |            | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000036,P1 |
      |            | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind,geldigheid_start_datum) VALUES($1,$2,$3,$4)                            |       9999,0,D,20220701 |

  Scenario: onder curatele
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    * 'P1' staat onder curatele
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie        | text                                                                                                                                                  | values                  |
      | persoon-P1 | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                       0 |
      |            | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,P1 |
      |            | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,curatele_register_ind) VALUES($1,$2,$3)                                                      |                9999,0,1 |

  Scenario: heeft gezag uitspraak en staat onder curatele
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P1                    |
    En voor 'P1' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    |                        20220701 |
    * 'P1' staat onder curatele
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie        | text                                                                                                                                                  | values                  |
      | persoon-P1 | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                       0 |
      |            | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000036,P1 |
      |            | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind,geldigheid_start_datum,curatele_register_ind) VALUES($1,$2,$3,$4,$5)   |     9999,0,D,20220701,1 |

  Scenario: persoon zonder partner is overleden
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    * is overleden
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                                                            | values                   |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,bijhouding_opschort_datum,bijhouding_opschort_reden) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2,$3) RETURNING * |    0,gisteren - 2 jaar,O |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                              |  9999,0,0,P,000000012,P1 |
      |            | overlijden   | INSERT INTO public.lo3_pl_overlijden(pl_id,volg_nr,overlijden_datum) VALUES($1,$2,$3)                                                                                                                           | 9999,0,gisteren - 2 jaar |

  Scenario: persoon met partner is overleden
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd
    En 'P1' is overleden
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                                                                               | values                                                  |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,bijhouding_opschort_datum,bijhouding_opschort_reden) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2,$3) RETURNING *                    |                                   0,gisteren - 2 jaar,O |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                 9999,0,0,P,000000012,P1 |
      |            | overlijden   | INSERT INTO public.lo3_pl_overlijden(pl_id,volg_nr,overlijden_datum) VALUES($1,$2,$3)                                                                                                                                              |                                9999,0,gisteren - 2 jaar |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) |  9999,0,0,R,000000024,P2,gisteren - 20 jaar,0518,6030,H |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                10000,0,0,P,000000024,P2 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) | 10000,0,1,R,000000012,P1,gisteren - 20 jaar,0518,6030,H |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_eind_datum,relatie_eind_plaats,relatie_eind_land_code,relatie_eind_reden) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)   |  10000,0,0,R,000000012,P1,gisteren - 2 jaar,0518,6030,O |

  Scenario: persoon is overleden na scheiden van partner
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    En 'P1' en 'P2' zijn met elkaar gehuwd
    En 'P1' en 'P2' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 7 jaar                                            |
    En 'P1' is overleden met de volgende gegevens
      | datum overlijden (08.10) |
      | gisteren - 2 jaar        |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                                                                               | values                                                  |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,bijhouding_opschort_datum,bijhouding_opschort_reden) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2,$3) RETURNING *                    |                                   0,gisteren - 2 jaar,O |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                 9999,0,0,P,000000012,P1 |
      |            | overlijden   | INSERT INTO public.lo3_pl_overlijden(pl_id,volg_nr,overlijden_datum) VALUES($1,$2,$3)                                                                                                                                              |                                9999,0,gisteren - 2 jaar |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) |  9999,0,1,R,000000024,P2,gisteren - 20 jaar,0518,6030,H |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,verbintenis_soort,relatie_eind_datum) VALUES($1,$2,$3,$4,$5,$6,$7,$8)                                                      |             9999,0,0,R,000000024,P2,H,gisteren - 7 jaar |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                              |                                                       0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                                                                 |                                10000,0,0,P,000000024,P2 |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,relatie_start_datum,relatie_start_plaats,relatie_start_land_code,verbintenis_soort) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) | 10000,0,1,R,000000012,P1,gisteren - 20 jaar,0518,6030,H |
      |            | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,verbintenis_soort,relatie_eind_datum) VALUES($1,$2,$3,$4,$5,$6,$7,$8)                                                      |            10000,0,0,R,000000012,P1,H,gisteren - 7 jaar |

  Scenario: bijhouding van de persoonsgegevens van '[aanduiding]' is opgeschort met de volgende gegevens
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En bijhouding van de persoonsgegevens van 'P1' is opgeschort met de volgende gegevens
      | datum opschorting bijhouding (67.10) |
      | gisteren                             |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                               | values                  |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,bijhouding_opschort_datum) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2) RETURNING * |              0,gisteren |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                 | 9999,0,0,P,000000012,P1 |
