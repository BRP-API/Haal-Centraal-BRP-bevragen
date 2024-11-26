#language: nl

@stap-documentatie
Functionaliteit: Reisdocument gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft een 'reisdocument' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'reisdocument' met de volgende gegevens
    | nummer reisdocument (35.20) |
    | NE3663258                   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | reisdocument-1 | INSERT INTO public.lo3_pl_reis_doc(pl_id,stapel_nr,nl_reis_doc_nr) VALUES($1,$2,$3)                                                                   | 9999,0,NE3663258     |

  Scenario: de persoon heeft een 'reisdocument' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft een 'reisdocument' met de volgende gegevens
    | nummer reisdocument (35.20) |
    | NE3663258                   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                      |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,Jansen |
    |      | reisdocument-1 | INSERT INTO public.lo3_pl_reis_doc(pl_id,stapel_nr,nl_reis_doc_nr) VALUES($1,$2,$3)                                                                   | 9999,0,NE3663258            |
