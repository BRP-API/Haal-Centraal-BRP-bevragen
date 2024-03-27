#language: nl

@stap-documentatie
Functionaliteit: Overlijden gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'

  Scenario: de persoon heeft de volgende 'overlijden' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) |
    | 20020701                 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values                      |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,Jansen |
    |      | overlijden   | INSERT INTO public.lo3_pl_overlijden(pl_id,volg_nr,overlijden_datum) VALUES($1,$2,$3)                                                                 | 9999,0,20020701             |

  Scenario: het 'overlijden' is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
    | 20020701                 | 0344                      | 5018                    |
    En het 'overlijden' is gecorrigeerd naar de volgende gegevens
    | gemeente document (82.10) |
    | 0518                      |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values                      |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012        |
    |      | overlijden   | INSERT INTO public.lo3_pl_overlijden(pl_id,volg_nr,overlijden_datum,overlijden_plaats,overlijden_land_code,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)     | 9999,1,20020701,0344,5018,O |
    |      |              | INSERT INTO public.lo3_pl_overlijden(pl_id,volg_nr,doc_gemeente_code) VALUES($1,$2,$3)                                                                | 9999,0,0518                 |
