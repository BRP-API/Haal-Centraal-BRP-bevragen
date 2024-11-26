#language: nl

@stap-documentatie
Functionaliteit: Gemeente gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '4999'
    En de 2e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '5000'
    En de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'

  Scenario: gemeente '[identificatie]' heeft de volgende gegevens
    Gegeven gemeente 'G1' heeft de volgende gegevens
    | gemeentecode (92.10) | gemeentenaam (92.11) |
    | 9999                 | Ons Dorp             |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie   | text                                                                       | values        |
    | 1    | gemeente-G1 | INSERT INTO public.lo3_gemeente(gemeente_code,gemeente_naam) VALUES($1,$2) | 9999,Ons Dorp |

  Scenario: gemeente '[identificatie]' is samengevoegd met de volgende gegevens
    Gegeven gemeente 'G1' heeft de volgende gegevens
    | gemeentecode (92.10) | gemeentenaam (92.11) |
    | 9999                 | Ons Dorp             |
    En gemeente 'G1' is samengevoegd met de volgende gegevens
    | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
    | 0800                        | 20230526                  |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie   | text                                                                                                                         | values                      |
    | 1    | gemeente-G1 | INSERT INTO public.lo3_gemeente(gemeente_code,gemeente_naam,nieuwe_gemeente_code,tabel_regel_eind_datum) VALUES($1,$2,$3,$4) | 9999,Ons Dorp,0800,20230526 |

  Scenario: een gemeente met een adres is samengevoegd
    Gegeven gemeente 'G1' heeft de volgende gegevens
    | gemeentecode (92.10) | gemeentenaam (92.11) |
    | 9999                 | Ons Dorp             |
    En adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 9999                 | 9999010000000003                         |
    En gemeente 'G1' is samengevoegd met de volgende gegevens
    | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
    | 0800                        | 20230526                  |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie   | text                                                                                                                                                                  | values                      |
    | 1    | gemeente-G1 | INSERT INTO public.lo3_gemeente(gemeente_code,gemeente_naam,nieuwe_gemeente_code,tabel_regel_eind_datum) VALUES($1,$2,$3,$4)                                          | 9999,Ons Dorp,0800,20230526 |
    | 2    | adres-A1    | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | 9999,9999010000000003       |
    |      | adres-2     | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | 0800,9999010000000003       |

  Scenario: een gemeente met verblijfplaats is samengevoegd
    Gegeven gemeente 'G1' heeft de volgende gegevens
    | gemeentecode (92.10) | gemeentenaam (92.11) |
    | 9000                 | Ons Dorp             |
    En adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 9000                 | 9999010000000003                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 9000                              | 20220102                           |
    En gemeente 'G1' is samengevoegd met de volgende gegevens
    | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
    | 0800                        | 20230526                  |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                                      | values                        |
    | 1    | gemeente-G1    | INSERT INTO public.lo3_gemeente(gemeente_code,gemeente_naam,nieuwe_gemeente_code,tabel_regel_eind_datum) VALUES($1,$2,$3,$4)                                                              | 9000,Ons Dorp,0800,20230526   |
    | 2    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 9000,9999010000000003         |
    |      | adres-2        | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0800,9999010000000003         |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                     | 0                             |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                          | 9999,0,0,P,000000012          |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5,$6)                              | 9999,4999,1,W,9000,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,5000,0,W,0800,20230526,W |
