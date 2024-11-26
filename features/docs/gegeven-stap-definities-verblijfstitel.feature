#language: nl

@stap-documentatie
Functionaliteit: Verblijfstitel gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | aanduiding verblijfstitel (39.10) |
    | 37                                |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | verblijfstitel | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                                          | 9999,0,37            |

  Scenario: de persoon heeft een 'verblijfstitel' verkregen met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | geslachtsnaam (02.40) |
    | Jansen                |
    En de persoon heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | aanduiding verblijfstitel (39.10) |
    | 37                                |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                      |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,Jansen |
    |      | verblijfstitel | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                                          | 9999,0,37                   |

  Scenario: de 'verblijfstitel' is gewijzigd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | aanduiding verblijfstitel (39.10) |
    | 37                                |
    En de 'verblijfstitel' is gewijzigd naar de volgende gegevens
    | aanduiding verblijfstitel (39.10) |
    | 38                                |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | verblijfstitel | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                                          | 9999,1,37            |
    |      |                | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                                          | 9999,0,38            |


  Scenario: Gegeven het 'verblijfstitel' is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'verblijfstitel' verkregen met de volgende gegevens
    | aanduiding verblijfstitel (39.10) |
    | 37                                |
    En het 'verblijfstitel' is gecorrigeerd naar de volgende gegevens
    | ingangsdatum geldigheid (85.10) |
    | 20031107                        |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | verblijfstitel | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand,onjuist_ind) VALUES($1,$2,$3,$4)                                           | 9999,1,37,O          |
    |      |                | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,geldigheid_start_datum) VALUES($1,$2,$3)                                                       | 9999,0,20031107      |
