#language: nl

@stap-documentatie
Functionaliteit: Gezagsverhouding gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft de volgende 'gezagsverhouding' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'gezagsverhouding' gegevens
    | indicatie gezag minderjarige (32.10) |
    | 12                                   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie        | text                                                                                                                                                  | values               |
    | 1    | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind) VALUES($1,$2,$3)                                                      | 9999,0,12            |

  Scenario: de persoon heeft de volgende 'gezagsverhouding' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'inschrijving' gegevens
    | indicatie geheim (70.10) | aanduiding uitgesloten kiesrecht (38.10) |
    | 7                        | A                                        |
    En de persoon heeft de volgende 'gezagsverhouding' gegevens
    | indicatie gezag minderjarige (32.10) |
    | 12                                   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie        | text                                                                                                                                                                            | values               |
    | 1    | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,kiesrecht_uitgesl_aand) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2) RETURNING * | 7,A                  |
    |      | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                | 9999,0,0,P,000000012 |
    |      | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind) VALUES($1,$2,$3)                                                                                | 9999,0,12            |

  Scenario: Gegeven de 'gezagsverhouding' is gewijzigd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'gezagsverhouding' gegevens
    | indicatie gezag minderjarige (32.10) |
    | 12                                   |
    En de 'gezagsverhouding' is gewijzigd naar de volgende gegevens
    | indicatie gezag minderjarige (32.10) |
    | 1D                                   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie        | text                                                                                                                                                  | values               |
    | 1    | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind) VALUES($1,$2,$3)                                                      | 9999,1,12            |
    |      |                  | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind) VALUES($1,$2,$3)                                                      | 9999,0,1D            |

  Scenario: de 'gezagsverhouding' is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'gezagsverhouding' gegevens
    | indicatie gezag minderjarige (32.10) |
    | 12                                   |
    En de 'gezagsverhouding' is gecorrigeerd naar de volgende gegevens
    | indicatie gezag minderjarige (32.10) |
    | 1D                                   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie        | text                                                                                                                                                  | values               |
    | 1    | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind,onjuist_ind) VALUES($1,$2,$3,$4)                                       | 9999,1,12,O          |
    |      |                  | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind) VALUES($1,$2,$3)                                                      | 9999,0,1D            |
