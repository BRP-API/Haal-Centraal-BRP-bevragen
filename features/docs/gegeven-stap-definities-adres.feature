# language: nl
@integratie @stap-documentatie
Functionaliteit: Adres gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '4999'
    Gegeven de 2e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '5000'
    Gegeven de 3e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '5001'

  @integratie
  Abstract Scenario: adres '[adres aanduiding]'
    Gegeven adres 'A1'
      | gemeentecode (92.10) |
      |                 0518 |
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de adres 'A1' de volgende rij in tabel 'lo3_adres'
      | adres_id | gemeente_code |
      |        1 |          0518 |

  @integratie
  Scenario: adres '[adres aanduiding]' (meerdere adressen)
    Gegeven adres 'A1'
      | gemeentecode (92.10) |
      |                 0518 |
    Gegeven adres 'A2'
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      |                 0800 |                         0800010011067001 |
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de adres 'A1' de volgende rij in tabel 'lo3_adres'
      | adres_id | gemeente_code |
      |        1 |          0518 |
    En heeft de adres 'A2' de volgende rij in tabel 'lo3_adres'
      | adres_id | gemeente_code | verblijf_plaats_ident_code |
      |        2 |          0800 |           0800010011067001 |

  Scenario: adres '[identificatie]' heeft de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                  | values    |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | Boterdiep |

  Scenario: adres '[identificatie]' heeft de volgende gegevens (meerdere adressen)
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                 | values           |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                | Boterdiep        |
    |      | adres-A2  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067001 |

  Scenario: adres '[identificatie]' is op '[datum]' geactualiseerd met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En adres 'A1' is op '2023-02-03' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                                | values                     |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                               | Boterdiep                  |
    |      | adres-2   | INSERT INTO public.lo3_adres(adres_id,straat_naam,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | Boterdiep,0800010011067001 |

  Scenario: adres '[identificatie]' is op '[datum]' samengevoegd tot adres '[identificatie]' met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En adres 'A1' is op '2023-02-03' samengevoegd tot adres 'A2' met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                 | values           |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067001 |
    |      | adres-A2  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067002 |

  Scenario: de adressen '[identificaties]' zijn op '[datum]' samengevoegd tot adres '[identificatie]' met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Gegeven adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    En de adressen 'A1,A2' zijn op '2023-02-03' samengevoegd tot adres 'A3' met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067003                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                 | values           |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067001 |
    |      | adres-A2  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067002 |
    |      | adres-A3  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067003 |

  Scenario: adres '[identificatie]' is gesplitst in adressen met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | identificatiecode verblijfplaats (11.80) |
    | A2    | 0800010011067002                         |
    | A3    | 0800010011067003                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                 | values           |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067001 |
    |      | adres-A2  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067002 |
    |      | adres-A3  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067003 |

  Scenario: adres '[identificatie]' is op '[datum]' infrastructureel gewijzigd met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En adres 'A1' is op '2023-02-03' infrastructureel gewijzigd met de volgende gegevens
    | gemeentecode (92.10) |
    | 0530                 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                                  | values                |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | 0800,0800010000000003 |
    |      | adres-2   | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | 0530,0800010000000003 |

  Scenario: adres '[identificatie]' is op '[datum]' infrastructureel gewijzigd naar adres '[identificatie]' met de volgende gegevens
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En adres 'A1' is op '2023-02-03' infrastructureel gewijzigd naar adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) |
    | 0530                 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                                  | values                |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | 0800,0800010000000003 |
    |      | adres-A2  | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | 0530,0800010000000003 |
