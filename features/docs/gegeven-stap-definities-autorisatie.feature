# language: nl
@stap-documentatie
Functionaliteit: Autorisatie gegeven stap definities

  Scenario: Gegeven de afnemer met indicatie '[indicatie]' heeft de volgende 'autorisatie' gegevens
    Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) |
      |                     10120 10210 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie   | text                                                                                                                                                                                                                               | values                 |
      |    1 | autorisatie | INSERT INTO public.lo3_autorisatie(autorisatie_id,afnemer_code,geheimhouding_ind,verstrekkings_beperking,ad_hoc_rubrieken) VALUES((SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie),$1,$2,$3,$4) RETURNING * | 000008,0,0,10120 10210 |

  Scenario: Gegeven de afnemer met indicatie '[indicatie]' is geautoriseerd voor 'adressering binnenland' gegevens
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
    Dan zijn de gegenereerde SQL statements
      | stap | categorie   | text                                                                                                                                                                                                                                                                                                                      | values                                                                                                                                      |
      |    1 | autorisatie | INSERT INTO public.lo3_autorisatie(autorisatie_id,afnemer_code,geheimhouding_ind,verstrekkings_beperking,afnemer_naam,adres_vraag_bevoegdheid,ad_hoc_medium,tabel_regel_start_datum,ad_hoc_rubrieken) VALUES((SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie),$1,$2,$3,$4,$5,$6,$7,$8) RETURNING * | 000008,0,0,Haal Centraal,1,N,20201128,10120 10240 10310 80910 81110 81120 81130 81140 81180 81190 PANM03 PANM04 PANM05 PANM06 PAVP03 PAVP04 |

  Scenario: Gegeven de afnemer met indicatie '[indicatie]' is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    Dan zijn de gegenereerde SQL statements
      | stap | categorie   | text                                                                                                                                                                                                                                                                                                                      | values                                                                                                                                |
      |    1 | autorisatie | INSERT INTO public.lo3_autorisatie(autorisatie_id,afnemer_code,geheimhouding_ind,verstrekkings_beperking,afnemer_naam,adres_vraag_bevoegdheid,ad_hoc_medium,tabel_regel_start_datum,ad_hoc_rubrieken) VALUES((SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie),$1,$2,$3,$4,$5,$6,$7,$8) RETURNING * | 000008,0,0,Haal Centraal,1,N,20201128,10120 81010 81030 80910 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510 |

  Scenario: Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
    Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      |    000008 |         0800 |
    Dan heeft de scenario context een property 'afnemerID' met waarde '000008'
    En heeft de scenario context een property 'gemeenteCode' met waarde '0800'

  @integratie
  Scenario: een nieuwe afnemer met indicatie '[afnemer code]' is geautoriseerd voor het vragen van '[fields]'
    Gegeven een nieuwe afnemer met indicatie '000008' is geautoriseerd voor het vragen van 'gezag'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft afnemer '000008' de volgende rij in tabel 'lo3_autorisatie'
      | afnemer_code | geheimhouding_ind | verstrekkings_beperking | afnemer_naam  | adres_vraag_bevoegdheid | ad_hoc_medium | tabel_regel_start_datum | ad_hoc_rubrieken   |
      |       000008 |                 0 |                       0 | Haal Centraal |                       1 | N             |                20201128 | 10120 81180 PAGZ01 |

  @integratie
  Scenario: een bestaande afnemer met indicatie '[afnemer code]' is geautoriseerd voor het vragen van '[fields]'
    Gegeven een bestaande afnemer met indicatie '000009' is geautoriseerd voor het vragen van 'gezag'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft afnemer '000009' de volgende rij in tabel 'lo3_autorisatie'
      | afnemer_code | geheimhouding_ind | verstrekkings_beperking | afnemer_naam  | adres_vraag_bevoegdheid | ad_hoc_medium | tabel_regel_start_datum | ad_hoc_rubrieken   |
      |       000009 |                 0 |                       0 | Haal Centraal |                       1 | N             |                20201128 | 10120 81180 PAGZ01 |
