#language: nl

@stap-documentatie
Functionaliteit: Kind gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '4999'
    En de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft een 'kind' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values               |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,K,Jansen    |

  Scenario: de persoon heeft (nog) een 'kind' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft nog een 'kind' met de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) |
    | Walter            | Messeritz             |
    En de persoon heeft nog een 'kind' met de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) |
    | William           | Postma                |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values                      |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012        |
    |      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,K,Jansen           |
    |      | kind-2       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                            | 9999,1,0,K,Walter,Messeritz |
    |      | kind-3       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                            | 9999,2,0,K,William,Postma   |

  Scenario: het 'kind' is gewijzigd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam              | waarde          |
    | voornamen (02.10) | Celeke Lodivica |
    En het 'kind' is gewijzigd naar de volgende gegevens
    | voornamen (02.10) |
    | Vica              |
    Dan zijn de gegenereerde SQL statements
    | key          | text                                                                                                                                                  | values                     |
    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                          |
    | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012       |
    | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                              | 9999,0,1,K,Celeke Lodivica |
    |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                              | 9999,0,0,K,Vica            |

  Scenario: het 'kind' is gewijzigd naar de volgende gegevens (tweede en/of volgende kind)
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Boer   |
    En de persoon heeft nog een 'kind' met de volgende gegevens
    | geslachtsnaam (02.40) |
    | Boerin                |
    En het 'kind' is gewijzigd naar de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Vries  |
    Dan zijn de gegenereerde SQL statements
    | key          | text                                                                                                                                                  | values               |
    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,K,Boer      |
    | kind-2       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,1,1,K,Boerin    |
    |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,1,0,K,Vries     |

  Scenario: het 'kind' is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | geslachtsnaam (02.40) |
    | Boer                  |
    En het 'kind' is gecorrigeerd naar de volgende gegevens
    | geslachtsnaam (02.40) |
    | Vries                 |
    Dan zijn de gegenereerde SQL statements
    | key          | text                                                                                                                                                  | values               |
    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)                          | 9999,0,1,K,Boer,O    |
    |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,K,Vries     |

  Scenario: het 'kind' is gecorrigeerd naar de volgende gegevens (tweede en/of volgende kind)
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Boer   |
    En de persoon heeft nog een 'kind' met de volgende gegevens
    | geslachtsnaam (02.40) |
    | Boer                  |
    En het 'kind' is gecorrigeerd naar de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Vries  |
    Dan zijn de gegenereerde SQL statements
    | key          | text                                                                                                                                                  | values               |
    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,K,Boer      |
    | kind-2       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)                          | 9999,1,1,K,Boer,O    |
    |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,1,0,K,Vries     |
