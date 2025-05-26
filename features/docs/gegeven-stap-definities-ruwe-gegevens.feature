# language: nl
@stap-documentatie @integratie
Functionaliteit: gegevens opgeven met waardentabel

  Regel: heeft {object soort} met de volgende gegevens

    Abstract Scenario: heeft <relatie> met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een <relatie> met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Helena    |
        | geslachtsnaam (02.40)       | Hanssen   |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type   | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam |
        | P1    | P              |         0 |       0 |         000000012 |           | P1             |
        | P1    | <persoon type> |         0 |       0 |         000000024 | Helena    | Hanssen        |

      Voorbeelden:
        | relatie | persoon type |
        | ouder 1 |            1 |
        | ouder 2 |            2 |

    Abstract Scenario: heeft <relatie> met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een <relatie> 'P2' met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Helena    |
        | geslachtsnaam (02.40)       | Hanssen   |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type   | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam |
        | P1    | P              |         0 |       0 |         000000012 |           | P1             |
        | P1    | <persoon type> |         0 |       0 |         000000024 | Helena    | Hanssen        |

      Voorbeelden:
        | relatie | persoon type |
        | partner | R            |
        | kind    | K            |

    Abstract Scenario: meerdere van zelfde object soort: heeft <relatie> met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een <relatie> 'P2' met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Helena    |
        | geslachtsnaam (02.40)       | Hanssen   |
      * heeft een <relatie> 'P3' met de volgende gegevens
        | naam                  | waarde  |
        | voornamen (02.10)     | Herman  |
        | geslachtsnaam (02.40) | Hanssen |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type   | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam |
        | P1    | P              |         0 |       0 |         000000012 |           | P1             |
        | P1    | <persoon type> |         0 |       0 |         000000024 | Helena    | Hanssen        |
        | P1    | <persoon type> |         1 |       0 |                   | Herman    | Hanssen        |

      Voorbeelden:
        | relatie | persoon type |
        | partner | R            |
        | kind    | K            |

    Abstract Scenario: meerdere van verschillende object soort: heeft <relatie> met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een ouder 1 met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Helena    |
        | geslachtsnaam (02.40)       | Hanssen   |
      * heeft een partner 'P3' met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000036 |
        | voornamen (02.10)           | Herman    |
        | geslachtsnaam (02.40)       | Hapert    |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam |
        | P1    | P            |         0 |       0 |         000000012 |           | P1             |
        | P1    |            1 |         0 |       0 |         000000024 | Helena    | Hanssen        |
        | P1    | R            |         0 |       0 |         000000036 | Herman    | Hapert         |

    Scenario: heeft gezagsverhouding met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft de volgende gezagsverhouding gegevens
        | naam                                 | waarde   |
        | indicatie gezag minderjarige (32.10) |        2 |
        | ingangsdatum geldigheid (85.10)      | 20211001 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rij in tabel 'lo3_pl_gezagsverhouding'
        | pl_id | volg_nr | minderjarig_gezag_ind | geldigheid_start_datum |
        | P1    |       0 |                     2 |               20211001 |

  Regel: {object soort} is {gewijzigd of gecorrigeerd} naar de volgende gegevens

    Abstract Scenario: ouder <ouder type> is <soort wijziging> naar de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een ouder <ouder type> met de volgende gegevens
        | naam                  | waarde  |
        | voornamen (02.10)     | Helena  |
        | geslachtsnaam (02.40) | Hanssen |
      En ouder <ouder type> is <soort wijziging> naar de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Herman    |
        | geslachtsnaam (02.40)       | Hanssen   |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam | onjuist_ind |
        | P1    | P            |         0 |       0 |         000000012 |           | P1             |             |
        | P1    | <ouder type> |         0 |       1 |                   | Helena    | Hanssen        | <onjuist>   |
        | P1    | <ouder type> |         0 |       0 |         000000024 | Herman    | Hanssen        |             |

      Voorbeelden:
        | ouder type | soort wijziging | onjuist |
        |          1 | gewijzigd       |         |
        |          1 | gecorrigeerd    | O       |
        |          2 | gewijzigd       |         |
        |          2 | gecorrigeerd    | O       |

    Abstract Scenario: <object soort wijziging> is <soort wijziging> naar de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een <relatie soort> 'P2' met de volgende gegevens
        | naam                  | waarde  |
        | voornamen (02.10)     | Helena  |
        | geslachtsnaam (02.40) | Hanssen |
      En <relatie soort> 'P2' is <soort wijziging> naar de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Herman    |
        | geslachtsnaam (02.40)       | Hanssen   |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type   | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam | onjuist_ind |
        | P1    | P              |         0 |       0 |         000000012 |           | P1             |             |
        | P1    | <persoon type> |         0 |       1 |                   | Helena    | Hanssen        | <onjuist>   |
        | P1    | <persoon type> |         0 |       0 |         000000024 | Herman    | Hanssen        |             |

      Voorbeelden:
        | relatie soort | persoon type | soort wijziging | onjuist |
        | partner       | R            | gewijzigd       |         |
        | partner       | R            | gecorrigeerd    | O       |
        | kind          | K            | gewijzigd       |         |
        | kind          | K            | gecorrigeerd    | O       |

    Scenario: meerdere kinderen en gegevens van het verschillende kinderen worden gecorrigeerd
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een kind 'P2' met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Helena    |
        | geslachtsnaam (02.40)       | Hanssen   |
      * heeft een kind 'P3' met de volgende gegevens
        | naam                  | waarde  |
        | voornamen (02.10)     | Herman  |
        | voorvoegsel (02.30)   | van     |
        | geslachtsnaam (02.40) | Hanssen |
      En kind 'P3' is gecorrigeerd naar de volgende gegevens
        | naam                        | waarde        |
        | burgerservicenummer (01.20) |     000000036 |
        | voornamen (02.10)           | Herman Pieter |
        | geslachtsnaam (02.40)       | Hanssen       |
      * heeft een kind 'P4' met de volgende gegevens
        | naam                  | waarde  |
        | voornamen (02.10)     | Hanna   |
        | geslachtsnaam (02.40) | Hanssen |
      En kind 'P4' is gecorrigeerd naar de volgende gegevens
        | naam                  | waarde       |
        | voornamen (02.10)     | Hanna Hellen |
        | geslachtsnaam (02.40) | Hanssen      |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | voor_naam     | geslachts_naam_voorvoegsel | geslachts_naam | onjuist_ind |
        | P1    | P            |         0 |       0 |         000000012 |               |                            | P1             |             |
        | P1    | K            |         0 |       0 |         000000024 | Helena        |                            | Hanssen        |             |
        | P1    | K            |         1 |       1 |                   | Herman        | van                        | Hanssen        | O           |
        | P1    | K            |         1 |       0 |         000000036 | Herman Pieter |                            | Hanssen        |             |
        | P1    | K            |         2 |       1 |                   | Hanna         |                            | Hanssen        | O           |
        | P1    | K            |         2 |       0 |                   | Hanna Hellen  |                            | Hanssen        |             |

    Scenario: meerdere partners met gewijzigde en gecorrigeerde gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een partner 'P2' met de volgende gegevens
        | naam                                                               | waarde    |
        | burgerservicenummer (01.20)                                        | 000000024 |
        | voornamen (02.10)                                                  | Helena    |
        | geslachtsnaam (02.40)                                              | Hanssen   |
        | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |  20150316 |
      En partner 'P2' is gewijzigd naar de volgende gegevens
        | naam                                                         | waarde    |
        | burgerservicenummer (01.20)                                  | 000000024 |
        | voornamen (02.10)                                            | Helena    |
        | geslachtsnaam (02.40)                                        | Hanssen   |
        | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |  20201103 |
      * heeft een partner 'P3' met de volgende gegevens
        | naam                                                               | waarde   |
        | voornamen (02.10)                                                  | Herman   |
        | geslachtsnaam (02.40)                                              | Hapert   |
        | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20210604 |
      En partner 'P3' is gecorrigeerd naar de volgende gegevens
        | naam                                                               | waarde        |
        | burgerservicenummer (01.20)                                        |     000000036 |
        | voornamen (02.10)                                                  | Herman Pieter |
        | geslachtsnaam (02.40)                                              | Hapert        |
        | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |      20210604 |
      En partner 'P3' is gewijzigd naar de volgende gegevens
        | naam                                                         | waarde        |
        | burgerservicenummer (01.20)                                  |     000000036 |
        | voornamen (02.10)                                            | Herman Pieter |
        | geslachtsnaam (02.40)                                        | Hapert        |
        | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |      20240117 |
      * heeft een partner 'P4' met de volgende gegevens
        | naam                                                               | waarde    |
        | voornamen (02.10)                                                  | Hadewich  |
        | geslachtsnaam (02.40)                                              | Heijliger |
        | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |  20250429 |
      En partner 'P4' is gecorrigeerd naar de volgende gegevens
        | naam                                                               | waarde    |
        | burgerservicenummer (01.20)                                        | 000000048 |
        | voornamen (02.10)                                                  | Hadewich  |
        | geslachtsnaam (02.40)                                              | Heijliger |
        | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |  20250429 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | voor_naam     | geslachts_naam | onjuist_ind | relatie_start_datum | relatie_eind_datum |
        | P1    | P            |         0 |       0 |         000000012 |               | P1             |             |                     |                    |
        | P1    | R            |         0 |       1 |         000000024 | Helena        | Hanssen        |             |            20150316 |                    |
        | P1    | R            |         0 |       0 |         000000024 | Helena        | Hanssen        |             |                     |           20201103 |
        | P1    | R            |         1 |       2 |                   | Herman        | Hapert         | O           |            20210604 |                    |
        | P1    | R            |         1 |       1 |         000000036 | Herman Pieter | Hapert         |             |            20210604 |                    |
        | P1    | R            |         1 |       0 |         000000036 | Herman Pieter | Hapert         |             |                     |           20240117 |
        | P1    | R            |         2 |       1 |                   | Hadewich      | Heijliger      | O           |            20250429 |                    |
        | P1    | R            |         2 |       0 |         000000048 | Hadewich      | Heijliger      |             |            20250429 |                    |

  Regel: is ingeschreven op adres {string} met de volgende gegevens

    Scenario: is ingeschreven op adres {string} met de volgende gegevens
      Gegeven adres 'A1'
        | gemeentecode (92.10) | straatnaam (11.10) |
        |                 0518 | Boterdiep          |
      En de persoon 'P1' met burgerservicenummer '000000012'
      En is ingeschreven op adres 'A1' met de volgende gegevens
        | naam                               | waarde   |
        | functie adres (10.10)              | B        |
        | datum aanvang adreshouding (10.30) | 20111101 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | adres_id | volg_nr | adres_functie | adreshouding_start_datum |
        | P1    | A1       |       0 | B             |                 20111101 |

  Regel: is ingeschreven op een buitenlands adres met de volgende gegevens

    Scenario: is ingeschreven op een buitenlands adres met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En is ingeschreven op een buitenlands adres met de volgende gegevens
        | naam                                   | waarde   |
        | land (13.10)                           |     6039 |
        | datum aanvang adres buitenland (13.20) | 20111101 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | adres_id | volg_nr | vertrek_land_code | vertrek_datum |
        | P1    |          |       0 |              6039 |      20111101 |

  Regel: is overleden met de volgende gegevens

    Scenario: is overleden met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is overleden met de volgende gegevens
        | naam                      | waarde   |
        | datum overlijden (08.10)  | 20230924 |
        | plaats overlijden (08.20) |     0518 |
        | land overlijden (08.30)   |     6030 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_overlijden'
        | pl_id | volg_nr | overlijden_datum | overlijden_plaats | overlijden_land_code |
        | P1    |       0 |         20230924 |              0518 |                 6030 |

  Regel: is ingeschreven met de volgende gegevens

    Scenario: is ingeschreven met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is ingeschreven met de volgende gegevens
        | naam                                 | waarde   |
        | datum opschorting bijhouding (67.10) | 20181201 |
        | reden opschorting bijhouding (67.20) | E        |
        | indicatie geheim (70.10)             |        7 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | bijhouding_opschort_datum | bijhouding_opschort_reden | geheim_ind |
        | P1    |                  20181201 | E                         |          7 |
