# language: nl

Functionaliteit: GBA persoon : leveren van RNI-deelnemer gegevens

  RNI-deelnemer gegevens die horen bij de volgende categoriën worden geleverd wanneer ten minste één gegeven van die categoriën wordt gevraagd
  | categorie | naam           |
  | 01        | Persoon        |
  | 08        | Verblijfplaats |

  Achtergrond:
    Gegeven landelijke tabel "RNI-deelnemerstabel" heeft de volgende waarden
    | code | omschrijving                                                       |
    | 0101 | Belastingdienst (inzake heffingen en toeslagen)                    |
    | 0201 | Sociale Verzekeringsbank (inzake AOW, Anw en AKW)                  |
    | 0501 | Immigratie- en naturalisatiedienst (inzake nationaliteitsgegevens) |

Rule: RNI-deelnemer gegevens die horen bij categorie 01 (Persoon) en/of 08 (Verblijfplaats) worden geleverd wanneer één of meerdere velden uit die categoriën wordt gevraagd

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 01 (Persoon) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | voornamen (02.10)            | Peter                                       |
    | geslachtsnaam (02.40)        | Jansen                                      |
    | geboortedatum (03.10)        | 19830526                                    |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Jansen                              |
    | geboortedatum              | 1983-05-26                          |
    | fields                     | <fields>                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde |
    | voornamen     | Peter  |
    | geslachtsnaam | Jansen |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                          |
    | deelnemer.code         | 0101                                            |
    | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
    | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
    | categorie              | Persoon                                         |

    Voorbeelden:
    | fields                            |
    | naam                              |
    | naam,rni                          |
    | naam.voornamen,naam.geslachtsnaam |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 (verblijf buitenland) en er wordt gevraagd om <fields>
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | geslachtsnaam (02.40)        | Jansen                                      |
    | geboortedatum (03.10)        | 19830526                                    |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Jansen                              |
    | geboortedatum              | 1983-05-26                          |
    | fields                     | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam              | waarde |
    | land.code         | 5010   |
    | land.omschrijving | België |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
    | categorie              | Verblijfplaats                                    |

    Voorbeelden:
    | fields                                                                                   |
    | adressering.adresregel1                                                                  |
    | adressering.adresregel2                                                                  |
    | adressering.adresregel3                                                                  |
    | adressering.land                                                                         |
    | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 (<verblijfplaats type>) en er wordt gevraagd om <fields>
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | geslachtsnaam (02.40)        | Jansen                                      |
    | geboortedatum (03.10)        | 19830526                                    |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde   |
    | gemeentecode (92.10) | 0518     |
    | <naam gba veld>      | <waarde> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam        | waarde   |
    | <naam veld> | <waarde> |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
    | categorie              | Verblijfplaats                                    |

    Voorbeelden:
    | verblijfplaats type | naam gba veld               | waarde   | naam veld           | fields                  |
    | locatie             | locatiebeschrijving (12.10) | woonboot | locatiebeschrijving | adressering.adresregel1 |
    | locatie             | locatiebeschrijving (12.10) | woonboot | locatiebeschrijving | adressering.adresregel2 |
    | adres               | straatnaam (11.10)          | Spui     | straat              | adressering.adresregel1 |
    | adres               | straatnaam (11.10)          | Spui     | straat              | adressering.adresregel2 |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor meerdere categoriën waarvoor RNI-deelnemer gegevens moet worden geleverd en één of meerdere velden uit al die categoriën wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | voornamen (02.10)            | Peter                                       |
    | geslachtsnaam (02.40)        | Jansen                                      |
    | geboortedatum (03.10)        | 19830526                                    |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde |
    | voornamen     | Peter  |
    | geslachtsnaam | Jansen |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam              | waarde |
    | land.code         | 5010   |
    | land.omschrijving | België |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                          |
    | deelnemer.code         | 0101                                            |
    | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
    | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
    | categorie              | Persoon                                         |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
    | categorie              | Verblijfplaats                                    |

    Voorbeelden:
    | fields                                                                                            |
    | adressering                                                                                       |
    | naam,adressering.adresregel1                                                                      |
    | naam.voornamen,naam.geslachtsnaam,adressering.land.omschrijving                                   |
    | adressering.aanhef,adressering.adresregel2                                                        |
    | adressering.aanschrijfwijze.naam,adressering.adresregel1,adressering.adresregel2,adressering.land |
    
  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor verblijfplaats, maar er worden geen verblijfplaats velden gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
    | naam                  | waarde   |
    | voornamen (02.10)     | Peter    |
    | geslachtsnaam (02.40) | Jansen   |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde |
    | voornamen     | Peter  |
    | geslachtsnaam | Jansen |

    Voorbeelden:
    | fields   |
    | naam     |
    | naam,rni |

Rule: vragen van een rni gegevensgroep veld of één of meerdere velden van een rni gegevensgroep veld met de fields parameter worden genegeerd

  Abstract Scenario: <sub titel> wordt gevraagd en een RNI-deelnemer heeft de persoonsgegevens aangeleverd
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | geslachtsnaam (02.40)        | Jansen                                      |
    | geboortedatum (03.10)        | 19830526                                    |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | fields                      | sub titel               |
    | rni.deelnemer               | RNI veld deelnemer      |
    | rni.deelnemer.code          | RNI veld deelnemer.code |
    | rni.deelnemer,rni.categorie | Meerdere RNI velden     |
    | rni                         | RNI gegevensgroep veld  |
