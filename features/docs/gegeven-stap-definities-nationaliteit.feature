#language: nl

@stap-documentatie
Functionaliteit: Nationaliteit gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft een 'nationaliteit' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 19750707                        |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie       | text                                                                                                                                                       | values                     |
    | 1    | inschrijving    | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *      | 0                          |
    |      | persoon         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                           | 9999,0,0,P,000000012       |
    |      | nationaliteit-1 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6) | 9999,0,0,0001,001,19750707 |

  Scenario: de persoon heeft (nog) een 'nationaliteit' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 19750707                        |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0002   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie       | text                                                                                                                                                       | values                     |
    | 1    | inschrijving    | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *      | 0                          |
    |      | persoon         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                           | 9999,0,0,P,000000012       |
    |      | nationaliteit-1 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6) | 9999,0,0,0001,001,19750707 |
    |      | nationaliteit-2 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code) VALUES($1,$2,$3,$4)                                                    | 9999,1,0,0002              |

  Scenario: de 'nationaliteit' is gewijzigd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 19750707                        |
    En de 'nationaliteit' is gewijzigd naar de volgende gegevens
    | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
    | 404                      | 20150131                        |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie       | text                                                                                                                                                       | values                     |
    | 1    | inschrijving    | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *      | 0                          |
    |      | persoon         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                           | 9999,0,0,P,000000012       |
    |      | nationaliteit-1 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6) | 9999,0,1,0001,001,19750707 |
    |      |                 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nl_nat_verlies_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,0,0,404,20150131      |

  Scenario: de 'nationaliteit' is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 19750707                        |
    En de 'nationaliteit' is gecorrigeerd naar de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 301                   | 19760101                        |
    Dan zijn de gegenereerde SQL statements
    | key             | text                                                                                                                                                                      | values                       |
    | inschrijving    | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                     | 0                            |
    | persoon         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                          | 9999,0,0,P,000000012         |
    | nationaliteit-1 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,0,1,0001,001,19750707,O |
    |                 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6)                | 9999,0,0,0001,301,19760101   |
