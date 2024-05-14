#language: nl

Functionaliteit: Stap definities

  De titel van rule komt overeen met de naam van een ondersteunde 'gegeven' stap definitie
  De scenario's beschrijven de SQL statements die worden gegenereerd voor de 'gegeven' stap definitie

  Achtergrond:
    Gegeven de 1e 'SELECT MAX(pl_id)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 1e 'SELECT MAX(adres_id)+1 FROM public.lo3_adres' statement heeft als resultaat '4999'
    En de 2e 'SELECT MAX(pl_id)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'
    En de 3e 'SELECT MAX(pl_id)+1 FROM public.lo3_pl' statement heeft als resultaat '10001'

  Regel: Gegeven de persoon met burgerservicenummer '<bsn>' heeft de volgende gegevens

    Scenario: Persoon
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values                      |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)       | 9999,0,0,P,000000012,Jansen |

    Scenario: Persoon
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      Gegeven de persoon met burgerservicenummer '000000013' heeft de volgende gegevens
      | naam                  | waarde    |
      | geslachtsnaam (02.40) | Pietersen |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values                      |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)       | 9999,0,0,P,000000012,Jansen |

  Regel: En de persoon is gewijzigd naar de volgende gegevens

    Scenario: Gewijzigd persoon
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      En de persoon is gewijzigd naar de volgende gegevens
      | naam                  | waarde    |
      | geslachtsnaam (02.40) | Pietersen |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values                      |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)       | 9999,0,1,P,000000012,Jansen |
      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,P,Pietersen        |

  Regel: En de persoon is gecorrigeerd naar de volgende gegevens

    Scenario: Gecorrigeerd persoon
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      En de persoon is gecorrigeerd naar de volgende gegevens
      | naam                  | waarde  |
      | geslachtsnaam (02.40) | Janssen |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                              | values                        |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *          | 0                             |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,0,1,P,000000012,Jansen,O |
      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                     | 9999,0,0,P,Janssen            |

  Regel: Gegeven de persoon met burgerservicenummer '<bsn>' heeft de volgende '<naam-pl-tabel>' gegevens

    Scenario: Persoon heeft 'inschrijving' gegevens
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'inschrijving' gegevens
      | aanduiding uitgesloten kiesrecht (38.10) |
      | A                                        |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                                 | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,kiesrecht_uitgesl_aand) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | A                    |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                     | 9999,0,0,P,000000012 |

    Scenario: Persoon heeft 'kiesrecht' gegevens
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'kiesrecht' gegevens
      | aanduiding uitgesloten kiesrecht (38.10) |
      | A                                        |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                                               | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,kiesrecht_uitgesl_aand) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2) RETURNING * | 0,A                  |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                   | 9999,0,0,P,000000012 |

  Regel: En de persoon heeft de volgende '<naam-pl-tabel>' gegevens

    Scenario: Persoon heeft ook gezagsverhouding gegevens
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      En de persoon heeft de volgende 'gezagsverhouding' gegevens
      | indicatie curateleregister (33.10) |
      | 1                                  |
      Dan zijn de gegenereerde SQL statements
      | key              | text                                                                                                                                     | values                      |
      | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
      | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)       | 9999,0,0,P,000000012,Jansen |
      | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,curatele_register_ind) VALUES($1,$2,$3)                                         | 9999,0,1                    |

  Regel: En de/het '<naam-pl-tabel>' is gewijzigd naar de volgende gegevens

    Scenario: Persoon heeft gewijzigde 'verblijfstitel' gegevens
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'verblijfstitel' gegevens
      | aanduiding verblijfstitel (39.10) |
      | 37                                |
      En de 'verblijfstitel' is gewijzigd naar de volgende gegevens
      | aanduiding verblijfstitel (39.10) |
      | 38                                |
      Dan zijn de gegenereerde SQL statements
      | key            | text                                                                                                                                     | values               |
      | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | verblijfstitel | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                             | 9999,1,37            |
      |                | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                             | 9999,0,38            |

  Regel: En de/het '<naam-pl-tabel>' is gecorrigeerd naar de volgende gegevens

    Scenario: Persoon heeft gecorrigeerde 'gezagsverhouding' gegevens
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'gezagsverhouding' gegevens
      | indicatie gezag minderjarige (32.10) |
      | 12                                   |
      En de 'gezagsverhouding' is gecorrigeerd naar de volgende gegevens
      | indicatie gezag minderjarige (32.10) |
      | 1D                                   |
      Dan zijn de gegenereerde SQL statements
      | key              | text                                                                                                                                     | values               |
      | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind,onjuist_ind) VALUES($1,$2,$3,$4)                          | 9999,1,12,O          |
      |                  | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind) VALUES($1,$2,$3)                                         | 9999,0,1D            |

  Regel: Gegeven de persoon met burgerservicenummer '<bsn>' heeft een 'verblijfstitel' verkregen met de volgende gegevens

    Scenario: Persoon heeft 'verblijfstitel' gegevens
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'verblijfstitel' verkregen met de volgende gegevens
      | aanduiding verblijfstitel (39.10) |
      | 37                                |
      Dan zijn de gegenereerde SQL statements
      | key            | text                                                                                                                                     | values               |
      | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | verblijfstitel | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                             | 9999,0,37            |

  Regel: En de persoon heeft een 'verblijfstitel' verkregen met de volgende gegevens

    Scenario: Persoon heeft meerdere 'verblijfstitel' gegevens
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'verblijfstitel' verkregen met de volgende gegevens
      | aanduiding verblijfstitel (39.10) |
      | 37                                |
      En de persoon heeft een 'verblijfstitel' verkregen met de volgende gegevens
      | aanduiding verblijfstitel (39.10) |
      | 38                                |
      Dan zijn de gegenereerde SQL statements
      | key            | text                                                                                                                                     | values               |
      | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | verblijfstitel | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                             | 9999,1,37            |
      |                | INSERT INTO public.lo3_pl_verblijfstitel(pl_id,volg_nr,verblijfstitel_aand) VALUES($1,$2,$3)                                             | 9999,0,38            |

  Regel: Gegeven de persoon met burgerservicenummer '<bsn>' heeft een '<kind/partner/nationaliteit>' met de volgende gegevens

    Scenario: Persoon heeft een kind
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,K,Jansen    |

    Scenario: Persoon heeft een partner
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,R,Jansen    |

    Scenario: Persoon heeft een nationaliteit
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      Dan zijn de gegenereerde SQL statements
      | key             | text                                                                                                                                                       | values                     |
      | inschrijving    | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                   | 0                          |
      | persoon         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                           | 9999,0,0,P,000000012       |
      | nationaliteit-1 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6) | 9999,0,0,0001,001,19750707 |

  Regel: En de persoon heeft nog een '<kind/partner/nationaliteit>' met de volgende gegevens

    Scenario: Persoon heeft meerdere kinderen
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
      | key          | text                                                                                                                                     | values                      |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012        |
      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,K,Jansen           |
      | kind-2       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)               | 9999,1,0,K,Walter,Messeritz |
      | kind-3       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)               | 9999,2,0,K,William,Postma   |

    Scenario: Persoon heeft meerdere partners
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      En de persoon heeft nog een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) |
      | Aedel                 |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,R,Jansen    |
      | partner-2    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,1,0,R,Aedel     |

    Scenario: Persoon heeft meerdere nationaliteiten
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
      | naam                  | waarde |
      | nationaliteit (05.10) | 0002   |
      Dan zijn de gegenereerde SQL statements
      | key             | text                                                                                                                                                       | values                     |
      | inschrijving    | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                   | 0                          |
      | persoon         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                           | 9999,0,0,P,000000012       |
      | nationaliteit-1 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6) | 9999,0,0,0001,001,19750707 |
      | nationaliteit-2 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code) VALUES($1,$2,$3,$4)                                                    | 9999,1,0,0002              |

  Regel: En de/het '<kind/partner/nationaliteit>' is gewijzigd naar de volgende gegevens 

    Scenario: Persoon heeft gewijzigd kind
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
      | naam              | waarde          |
      | voornamen (02.10) | Celeke Lodivica |
      En het 'kind' is gewijzigd naar de volgende gegevens
      | voornamen (02.10) |
      | Vica              |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values                     |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                          |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012       |
      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                 | 9999,0,1,K,Celeke Lodivica |
      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                 | 9999,0,0,K,Vica            |

    Scenario: Persoon heeft wijziging bij tweede en/of volgende kind
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
      | key          | text                                                                                                                                     | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,K,Boer      |
      | kind-2       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,1,1,K,Boerin      |
      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,1,0,K,Vries     |

    Scenario: Persoon heeft een gewijzigd nationaliteit
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 404                      | 20150131                        |
      Dan zijn de gegenereerde SQL statements
      | key             | text                                                                                                                                                       | values                     |
      | inschrijving    | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                   | 0                          |
      | persoon         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                           | 9999,0,0,P,000000012       |
      | nationaliteit-1 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6) | 9999,0,1,0001,001,19750707 |
      |                 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nl_nat_verlies_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,0,0,404,20150131      |

  Regel: En de/het '<kind/partner/nationaliteit>' is gecorrigeerd naar de volgende gegevens 

    Scenario: Persoon heeft gecorrigeerd kind
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
      | geslachtsnaam (02.40) |
      | Boer                  |
      En het 'kind' is gecorrigeerd naar de volgende gegevens
      | geslachtsnaam (02.40) |
      | Vries                 |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)             | 9999,0,1,K,Boer,O    |
      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,K,Vries     |

    Scenario: Persoon heeft correctie bij tweede en/of volgende kind
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
      | key          | text                                                                                                                                     | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,K,Boer      |
      | kind-2       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)             | 9999,1,1,K,Boer,O    |
      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,1,0,K,Vries     |

    Scenario: Persoon heeft een gecorrigeerd nationaliteit
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      En de 'nationaliteit' is gecorrigeerd naar de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 301                   | 19760101                        |
      Dan zijn de gegenereerde SQL statements
      | key             | text                                                                                                                                                                      | values                       |
      | inschrijving    | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                  | 0                            |
      | persoon         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                          | 9999,0,0,P,000000012         |
      | nationaliteit-1 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,0,1,0001,001,19750707,O |
      |                 | INSERT INTO public.lo3_pl_nationaliteit(pl_id,stapel_nr,volg_nr,nationaliteit_code,nl_nat_verkrijg_reden,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6)                | 9999,0,0,0001,301,19760101   |

  Regel: Gegeven de persoon met burgerservicenummer '<bsn>' heeft een ouder '<1/2>' met de volgende gegevens

    Abstract Scenario: Persoon heeft een ouder
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder-type>' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      Dan zijn de gegenereerde SQL statements
      | key                | text                                                                                                                                     | values                       |
      | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                            |
      | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012         |
      | ouder-<ouder-type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,<ouder-type>,Jansen |

      Voorbeelden:
      | ouder-type |
      | 1          |
      | 2          |

  Regel: En de persoon heeft een ouder '<1/2>' met de volgende gegevens

    Scenario: Persoon heeft een 'ouder 1' en een 'ouder 2'
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | geslachtsnaam (02.40) |
      | Aedel                 |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values               |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,1,Jansen    |
      | ouder-2      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                            | 9999,0,0,2,Aedel     |

  Regel: En de ouder '<1/2>' is gecorrigeerd naar de volgende gegevens

    Scenario: Persoon heeft gecorrigeerd ouder
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | naam              | waarde     |
      | voornamen (02.10) | Christiaan |
      En de ouder '1' is gecorrigeerd naar de volgende gegevens
      | naam              | waarde |
      | voornamen (02.10) | Mark   |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values                  |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012    |
      | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)                  | 9999,0,1,1,Christiaan,O |
      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                 | 9999,0,0,1,Mark         |

  Regel: En de ouder '<1/2>' is gewijzigd naar de volgende gegevens

    Scenario: Persoon heeft gewijzigd ouder
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '2' met de volgende gegevens
      | naam              | waarde     |
      | voornamen (02.10) | Christiaan |
      En de ouder '2' is gewijzigd naar de volgende gegevens
      | naam              | waarde |
      | voornamen (02.10) | Mark   |
      Dan zijn de gegenereerde SQL statements
      | key          | text                                                                                                                                     | values                |
      | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012  |
      | ouder-2      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                 | 9999,0,1,2,Christiaan |
      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,voor_naam) VALUES($1,$2,$3,$4,$5)                                 | 9999,0,0,2,Mark       |

  Regel: En de 'verblijfplaats' heeft de volgende 'adres' gegevens

    Scenario: Persoon heeft een verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'verblijfplaats' gegevens
        | naam                               | waarde   |
        | datum aanvang adreshouding (10.30) | 20150808 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | naam               | waarde    |
        | straatnaam (11.10) | Boterdiep |
      Dan zijn de gegenereerde SQL statements
      | key            | text                                                                                                                                     | values               |
      | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 9999,0,0,P,000000012 |
      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                            | 9999,4999,0,20150808 |
      | adres          | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep            |

  Regel: Gegeven een adres heeft de volgende gegevens

    Scenario: Een adres
      Gegeven een adres heeft de volgende gegevens
      | naam               | waarde    |
      | straatnaam (11.10) | Boterdiep |
      Dan zijn de gegenereerde SQL statements
      | key   | text                                                                                                                     | values    |
      | adres | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | Boterdiep |

  Regel: En de persoon met burgerservicenummer '<bsn>' is ingeschreven op het adres met de volgende gegevens

    Scenario: een inschrijving op een adres
      Gegeven een adres heeft de volgende gegevens
      | naam               | waarde    |
      | straatnaam (11.10) | Boterdiep |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      Dan zijn de gegenereerde SQL statements
      | index | key            | text                                                                                                                                     | values                |
      | 1     | adres          | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep             |
      | 2     | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
      |       | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 10000,0,0,P,000000012 |
      |       | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,inschrijving_gemeente_code) VALUES($1,$2,$3,$4)                          | 10000,4999,0,0518     |

    Scenario: meerdere inschrijvingen op een adres
      Gegeven een adres heeft de volgende gegevens
      | naam               | waarde    |
      | straatnaam (11.10) | Boterdiep |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de persoon met burgerservicenummer '000000013' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      Dan zijn de gegenereerde SQL statements
      | index | key            | text                                                                                                                                     | values                |
      | 1     | adres          | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep             |
      | 2     | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
      |       | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 10000,0,0,P,000000012 |
      |       | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,inschrijving_gemeente_code) VALUES($1,$2,$3,$4)                          | 10000,4999,0,0518     |
      | 3     | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
      |       | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                         | 10001,0,0,P,000000013 |
      |       | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,inschrijving_gemeente_code) VALUES($1,$2,$3,$4)                          | 10001,4999,0,0599     |
