# language: nl
@stap-documentatie
Functionaliteit: Verblijfplaats gegeven stap definities
  Om scenarios voor de BRP APIs te kunnen schrijven wordt in deze feature beschreven welke sql statements worden gegenereerd/uitgevoerd voor een Gegeven stap.
  Deze sql statements staan in de tabel van de  'Dan zijn de gegenereerde SQL statements' stap. Elke rij in de tabel geeft aan
  - bij welk gegeven stap (stap kolom geeft de stap aan binnen de scenario. 1 = 1e stap, 2 = 2e stap etc) de SQL statement hoort
  - bij welke BRP categorie (categorie kolom) de SQL statement hoort
  - wat de SQL statement is (text kolom)
  - welke waarden worden meegegeven bij het uitvoeren van de SQL statement (values kolom)

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '4999'
    En de 2e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '5000'
    En de 3e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '5001'
    En de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'
    En de 3e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10001'

  @integratie
  Scenario: is ingeschreven in de BRP
    Gegeven persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    * is ingeschreven in de BRP
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      |     1 |       0 |                       0518 |

  @integratie
  Scenario: is niet ingeschreven in de BRP
    Gegeven persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    * is niet ingeschreven in de BRP
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      |     1 |       0 |                       1999 |

  @integratie
  Abstract Scenario: persoon '[persoon aanduiding]' is ingeschreven op adres '[adres aanduiding]' op [<datum type>]
    Gegeven adres 'A1'
      | gemeentecode (92.10) |
      |                 0518 |
    En persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    En <stap>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | adres_id | volg_nr | adres_functie | adreshouding_start_datum |
      |     1 |        1 |       0 | W             | <datum>                  |

    Voorbeelden:
      | stap                                                              | datum    | datum type                 |
      | persoon 'P1' is op 1 januari 2021 ingeschreven op adres 'A1'      | 20210101 | datum                      |
      | 'P1' is op 1 januari 2021 ingeschreven op adres 'A1'              | 20210101 | datum                      |
      | persoon 'P1' is in februari 2022 ingeschreven op adres 'A1'       | 20220200 | jaar maand datum           |
      | 'P1' is in februari 2022 ingeschreven op adres 'A1'               | 20220200 | jaar maand datum           |
      | persoon 'P1' is in 2023 ingeschreven op adres 'A1'                | 20230000 | jaar datum                 |
      | 'P1' is in 2023 ingeschreven op adres 'A1'                        | 20230000 | jaar datum                 |
      | persoon 'P1' is op een onbekende datum ingeschreven op adres 'A1' | 00000000 | onbekende datum            |
      | 'P1' is op een onbekende datum ingeschreven op adres 'A1'         | 00000000 | onbekende datum            |
      | persoon 'P1' is op 01-01-2021 ingeschreven op adres 'A1'          | 20210101 | datum in dd-mm-yyyy format |
      | 'P1' is op 01-01-2021 ingeschreven op adres 'A1'                  | 20210101 | datum in dd-mm-yyyy format |

  @integratie
  Abstract Scenario: personen '[persoon aanduidingen]' zijn ingeschreven op adres '[adres aanduiding]' op [<datum type>]
    Gegeven adres 'A1'
      | gemeentecode (92.10) |
      |                 0518 |
    Gegeven persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    En persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | Albers                |
    En <stap>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | adres_id | volg_nr | adres_functie | adreshouding_start_datum |
      |     1 |        1 |       0 | W             | <datum>                  |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | adres_id | volg_nr | adres_functie | adreshouding_start_datum |
      |     2 |        1 |       0 | W             | <datum>                  |

    Voorbeelden:
      | stap                                                               | datum    | datum type                 |
      | personen 'P1,P2' zijn op 1 januari 2021 ingeschreven op adres 'A1' | 20210101 | datum                      |
      | 'P1,P2' zijn op 1 januari 2021 ingeschreven op adres 'A1'          | 20210101 | datum                      |
      | personen 'P1, P2' zijn in februari 2022 ingeschreven op adres 'A1' | 20220200 | jaar maand datum           |
      | 'P1, P2' zijn in februari 2022 ingeschreven op adres 'A1'          | 20220200 | jaar maand datum           |
      | personen 'P1 en P2' zijn in 2023 ingeschreven op adres 'A1'        | 20230000 | jaar datum                 |
      | 'P1 en P2' zijn in 2023 ingeschreven op adres 'A1'                 | 20230000 | jaar datum                 |
      | 'P1 en P2' zijn op een onbekende datum ingeschreven op adres 'A1'  | 00000000 | onbekende datum            |
      | personen 'P1,P2' zijn op 01-01-2021 ingeschreven op adres 'A1'     | 20210101 | datum in dd-mm-yyyy format |
      | 'P1,P2' zijn op 01-01-2021 ingeschreven op adres 'A1'              | 20210101 | datum in dd-mm-yyyy format |

  @integratie
  Abstract Scenario: persoon '[persoon aanduiding]' is [gisteren, vandaag of morgen] [aantal] jaar geleden ingeschreven op adres '[adres aanduiding]'
    Gegeven adres 'A1'
      | gemeentecode (92.10) |
      |                 0518 |
    En persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    En <stap>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | adres_id | volg_nr | adres_functie | adreshouding_start_datum |
      |     1 |        1 |       0 | W             | <datum>                  |

    Voorbeelden:
      | stap                                                       | datum             |
      | persoon 'P1' is 2 jaar geleden ingeschreven op adres 'A1'  | vandaag - 2 jaar  |
      | 'P1' is 2 jaar geleden ingeschreven op adres 'A1'          | vandaag - 2 jaar  |
      | 'P1' is vandaag 2 jaar geleden ingeschreven op adres 'A1'  | vandaag - 2 jaar  |
      | 'P1' is gisteren 1 jaar geleden ingeschreven op adres 'A1' | gisteren - 1 jaar |
      | 'P1' is morgen 3 jaar geleden ingeschreven op adres 'A1'   | morgen - 3 jaar   |

  @integratie
  Abstract Scenario: personen '[persoon aanduidingen]' zijn [gisteren, vandaag of morgen] [aantal] jaar geleden ingeschreven op adres '[adres aanduiding]'
    Gegeven adres 'A1'
      | gemeentecode (92.10) |
      |                 0518 |
    En persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    En persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | Albers                |
    En <stap>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'P1' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | adres_id | volg_nr | adres_functie | adreshouding_start_datum |
      |     1 |        1 |       0 | W             | <datum>                  |
    En heeft de persoon 'P2' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | adres_id | volg_nr | adres_functie | adreshouding_start_datum |
      |     2 |        1 |       0 | W             | <datum>                  |

    Voorbeelden:
      | stap                                                                       | datum             |
      | personen 'P1,P2' zijn 2 jaar geleden ingeschreven op adres 'A1'            | vandaag - 2 jaar  |
      | 'P1, P2' zijn 2 jaar geleden ingeschreven op adres 'A1'                    | vandaag - 2 jaar  |
      | personen 'P1 en P2' zijn vandaag 2 jaar geleden ingeschreven op adres 'A1' | vandaag - 2 jaar  |
      | 'P1, P2' zijn gisteren 1 jaar geleden ingeschreven op adres 'A1'           | gisteren - 1 jaar |
      | 'P1 en P2' zijn morgen 3 jaar geleden ingeschreven op adres 'A1'           | morgen - 3 jaar   |

  Scenario: de persoon met burgerservicenummer '[bsn]' is ingeschreven op adres '[identificatie]' met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      |                           20230102 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep              |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,W,20230102 |

  Scenario: de persoon met burgerservicenummer '[bsn]' is ingeschreven op adres '[identificatie]' met de volgende gegevens (meerdere inschrijvingen)
    Gegeven adres 'A1' heeft de volgende gegevens
    | naam               | waarde    |
    | straatnaam (11.10) | Boterdiep |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de persoon met burgerservicenummer '000000013' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230203                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                  |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep               |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012    |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,W,20230102  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000013   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 10000,4999,0,W,20230203 |

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft adres '[identificatie]' als briefadres opgegeven met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft adres 'A1' als briefadres opgegeven met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep              |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,B,20230102 |

  Scenario: de persoon met burgerservicenummer '[bsn]' is ingeschreven op een buitenlands adres met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
    | land adres buitenland (13.10) | datum aanvang adres buitenland (13.20) |
    | 5010                          | 20230526                               |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,volg_nr,vertrek_land_code,vertrek_datum) VALUES($1,$2,$3,$4)                                           | 9999,0,5010,20230526 |

  Scenario: er zijn [aantal] personen ingeschreven op adres '[identificatie]' met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | naam               | waarde    |
    | straatnaam (11.10) | Boterdiep |
    En er zijn 3 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                  |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep               |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000001    |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,W,20230102  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000002   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 10000,4999,0,W,20230102 |
    | 4    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10001,0,0,P,000000003   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 10001,4999,0,W,20230102 |

  Scenario: de persoon is (vervolgens) ingeschreven op adres '[identificatie]' met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230601                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001       |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067002       |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,1,W,20230102 |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,5000,0,W,20230601 |

  Scenario: de persoon heeft (vervolgens) adres '[identificatie]' als briefadres opgegeven met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft adres 'A1' als briefadres opgegeven met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                      |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep                   |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,Jansen |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,B,20230102      |

  Scenario: de persoon is (vervolgens) ingeschreven op een buitenlands adres met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | land adres buitenland (13.10) | datum aanvang adres buitenland (13.20) |
    | 5010                          | 20230526                               |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001       |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,1,W,20220102 |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,volg_nr,vertrek_land_code,vertrek_datum) VALUES($1,$2,$3,$4)                                           | 9999,0,5010,20230526   |

  Scenario: samenvoeging van een adres waarop personen zijn/waren ingeschreven
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En adres 'A1' is op '2023-02-03' samengevoegd tot adres 'A2' met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                        | values                   |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067001         |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067002         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *       | 0                        |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                            | 9999,0,0,P,000000012     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                              | 9999,4999,1,W,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6) | 9999,5000,0,W,20230203,W |

  Scenario: samenvoeging van een adres dat wordt/werd gebruikt als briefadres
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' heeft adres 'A1' als briefadres opgegeven met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En adres 'A1' is op '2023-02-03' samengevoegd tot adres 'A2' met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                        | values                   |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067001         |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067002         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *       | 0                        |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                            | 9999,0,0,P,000000012     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                              | 9999,4999,1,B,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6) | 9999,5000,0,B,20230203,W |

  Scenario: samenvoeging van adressen waarop personen zijn/waren ingeschreven
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    Gegeven adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20211201                           |
    En de adressen 'A1, A2' zijn op '2023-02-03' samengevoegd tot adres 'A3' met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067003                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                        | values                    |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067001          |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067002          |
    |      | adres-A3       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067003          |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *       | 0                         |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                            | 9999,0,0,P,000000012      |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                              | 9999,4999,1,W,20220102    |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6) | 9999,5001,0,W,20230203,W  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *       | 0                         |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                            | 10000,0,0,P,000000024     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                              | 10000,5000,1,W,20211201   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6) | 10000,5001,0,W,20230203,W |

  Scenario: actualiseren van een adres waarop personen zijn/waren ingeschreven
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En adres 'A1' is op '2023-02-03' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                | values                     |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                               | Boterdiep                  |
    |      | adres-2        | INSERT INTO public.lo3_adres(adres_id,straat_naam,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | Boterdiep,0800010011067001 |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *               | 0                          |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                    | 9999,0,0,P,000000012       |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                                      | 9999,4999,1,W,20220102     |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6)         | 9999,5000,0,W,20230203,T   |

  Scenario: actualiseren van een adres dat wordt/werd gebruikt als briefadres
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft adres 'A1' als briefadres opgegeven met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En adres 'A1' is op '2023-02-03' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                | values                     |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                               | Boterdiep                  |
    |      | adres-2        | INSERT INTO public.lo3_adres(adres_id,straat_naam,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | Boterdiep,0800010011067001 |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *               | 0                          |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                    | 9999,0,0,P,000000012       |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                                      | 9999,4999,1,B,20220102     |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6)         | 9999,5000,0,B,20230203,T   |

  Scenario: infrastructureel wijzigen van een adres waarop personen zijn/waren ingeschreven
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220102                           |
    En adres 'A1' is op '2023-02-03' infrastructureel gewijzigd met de volgende gegevens
    | gemeentecode (92.10) |
    | 0530                 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                                      | values                        |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0800,0800010000000003         |
    |      | adres-2        | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0530,0800010000000003         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                     | 0                             |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                          | 9999,0,0,P,000000012          |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5,$6)                              | 9999,4999,1,W,0800,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,5000,0,W,0530,20230203,W |

  Scenario: infrastructureel wijzigen van een adres waarop personen zijn/waren ingeschreven naar een ander adres
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220102                           |
    En adres 'A1' is op '2023-02-03' infrastructureel gewijzigd naar adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) |
    | 0530                 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                                      | values                        |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0800,0800010000000003         |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0530,0800010000000003         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                     | 0                             |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                          | 9999,0,0,P,000000012          |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5,$6)                              | 9999,4999,1,W,0800,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,5000,0,W,0530,20230203,W |

  Scenario: een correctie op een inschrijving op een adres met identificatie naar een ander adres met identificatie
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230800                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                   |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep                |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                        |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)         | 9999,4999,1,W,20230102,O |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,5000,0,W,20230800   |

  Scenario: een correctie op een inschrijving op een adres met identificatie naar een opgave briefadres
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
    | functie adres (10.10) | datum aanvang adreshouding (10.30) |
    | B                     | 20230800                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                   |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep                |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                        |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)         | 9999,4999,1,W,20230102,O |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,B,20230800   |

  Scenario: de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230800                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                   |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep                |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                        |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)         | 9999,4999,1,W,20230102,O |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230800     |

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft de volgende 'verblijfplaats' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 0000   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,volg_nr,vestiging_land_code) VALUES($1,$2,$3)                                                          | 9999,0,0000          |

  Scenario: de persoon heeft de volgende 'verblijfplaats' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | gemeente van inschrijving (09.10) | 1999   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                      |
    | 1    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,Jansen |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,volg_nr,inschrijving_gemeente_code) VALUES($1,$2,$3)                                                   | 9999,0,1999                 |
