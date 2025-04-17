#language: nl

@stap-documentatie
Functionaliteit: Ouder gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '4999'
    En de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'

  @integratie
  Abstract Scenario: heeft '[aanduiding]' als ouder [1 of 2]
    Gegeven de persoon 'P2' zonder burgerservicenummer
    En de persoon 'P1' met burgerservicenummer '000000036'
    * heeft 'P2' als ouder <ouder type>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |    P1 |          0 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam |
      |    P1 |         0 |       0 |            P |         000000036 |             P1 |
    En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | geslachts_naam |
      |    P1 |         0 |       0 | <ouder type> |             P2 |

    Voorbeelden:
      | ouder type |
      |          1 |
      |          2 |

  Abstract Scenario: de persoon met burgerservicenummer '[bsn]' heeft een ouder '[ouder-type]' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder-type>' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie            | text                                                                                                                                                  | values                       |
    | 1    | inschrijving         | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                            |
    |      | persoon              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012         |
    |      | ouder-<ouder-type>-1 | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,<ouder-type>,Jansen |

    Voorbeelden:
    | ouder-type |
    | 1          |
    | 2          |

  Scenario: de persoon heeft een ouder '[ouder-type]' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | naam                  | waarde    |
    | geslachtsnaam (02.40) | Pietersen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values               |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | ouder-1-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,1,Jansen    |
    |      | ouder-2-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,2,Pietersen |

  Scenario: de ouder '[ouder-type]' is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam              | waarde     |
    | voornamen (02.10) | Christiaan |
    En de ouder '1' is gecorrigeerd naar de volgende gegevens
    | naam              | waarde |
    | voornamen (02.10) | Mark   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values                  |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012    |
    |      | ouder-1-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)                               | 9999,0,1,1,Christiaan,O |
    |      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                              | 9999,0,0,1,Mark         |

  Scenario: de ouder '[ouder-type]' is gewijzigd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '2' met de volgende gegevens
    | naam              | waarde     |
    | voornamen (02.10) | Christiaan |
    En de ouder '2' is gewijzigd naar de volgende gegevens
    | naam              | waarde |
    | voornamen (02.10) | Mark   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values                |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012  |
    |      | ouder-2-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                              | 9999,0,1,2,Christiaan |
    |      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                              | 9999,0,0,2,Mark       |
