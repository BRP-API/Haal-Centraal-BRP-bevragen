# language: nl

Functionaliteit: GBA persoon : leveren van RNI-deelnemer gegevens

  RNI-deelnemer gegevens die horen bij de volgende categoriën worden geleverd wanneer ten minste één gegeven van die categoriën wordt gevraagd
  | categorie | naam           |
  | 01        | Persoon        |
  | 04        | Nationaliteit  |
  | 06        | Overlijden     |
  | 08        | Verblijfplaats |

  Achtergrond:
    Gegeven landelijke tabel "RNI-deelnemerstabel" heeft de volgende waarden
    | code | omschrijving                                                       |
    | 0101 | Belastingdienst (inzake heffingen en toeslagen)                    |
    | 0201 | Sociale Verzekeringsbank (inzake AOW, Anw en AKW)                  |
    | 0501 | Immigratie- en naturalisatiedienst (inzake nationaliteitsgegevens) |

Rule: RNI-deelnemer gegevens die horen bij categorie 01 (Persoon), 04 (Nationaliteit), 06 (Overlijden) en/of 08 (Verblijfplaats) worden geleverd wanneer één of meerdere velden uit die categoriën wordt gevraagd

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 01 (Persoon) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | voornamen (02.10)            | Peter                                       |
    | geslachtsnaam (02.40)        | Jansen                                      |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
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
    | fields   |
    | naam     |
    | naam,rni |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 04 (Nationaliteit) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                         | waarde                                      |
    | nationaliteit (05.10)        | <nationaliteit code>                        |
    | rni-deelnemer (88.10)        | <rni-deelnemer code>                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                       | waarde                       |
    | nationaliteit.code         | <nationaliteit code>         |
    | nationaliteit.omschrijving | <nationaliteit omschrijving> |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                      |
    | deelnemer.code         | <rni-deelnemer code>                        |
    | deelnemer.omschrijving | <rni-deelnemer omschrijving>                |
    | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland |
    | categorie              | Nationaliteit                               |

    Voorbeelden:
    | nationaliteit code | nationaliteit omschrijving | rni-deelnemer code | rni-deelnemer omschrijving                                         | fields                        |
    | 0052               | Belgische                  | 0201               | Sociale Verzekeringsbank (inzake AOW, Anw en AKW)                  | nationaliteiten               |
    | 0263               | Surinaamse                 | 0501               | Immigratie- en naturalisatiedienst (inzake nationaliteitsgegevens) | nationaliteiten.nationaliteit |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 06 (Overlijden) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) | rni-deelnemer (88.10) |
    | 20020701                 | 0518                      | 6030                    | 0401                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam  | waarde   |
    | datum | 20020701 |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                         |
    | deelnemer.code         | 0401                           |
    | deelnemer.omschrijving | CAK (inzake zorgverzekeringen) |
    | categorie              | Overlijden                     |

    Voorbeelden:
    | fields               |
    | overlijden.datum     |
    | overlijden.datum,rni |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 (<verblijfplaats type>) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | <waarde>                             |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000036                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam              | waarde         |
    | land.code         | <waarde>       |
    | land.omschrijving | <omschrijving> |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
    | categorie              | Verblijfplaats                                    |

    Voorbeelden:
    | verblijfplaats type       | waarde | omschrijving | fields                                    |
    | verblijfplaats buitenland | 5010   | België       | verblijfplaats                            |
    | verblijfplaats onbekend   | 0000   | Onbekend     | verblijfplaats.verblijfadres.postcode     |
    | verblijfplaats buitenland | 5010   | België       | verblijfplaats.verblijfadres,rni          |
    | verblijfplaats buitenland | 5010   | België       | adressering                               |
    | verblijfplaats buitenland | 5010   | België       | adressering.adresregel1                   |
    | verblijfplaats buitenland | 5010   | België       | adressering.land                          |
    | verblijfplaats buitenland | 5010   | België       | adressering.land.omschrijving             |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 (<verblijfplaats type>) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde   |
    | gemeentecode (92.10) | 0518     |
    | <naam gba veld>      | <waarde> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000036                       |
    | fields              | <fields>                        |
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
    | verblijfplaats type | naam gba veld               | waarde   | naam veld           | fields                                           |
    | locatie             | locatiebeschrijving (12.10) | woonboot | locatiebeschrijving | verblijfplaats.verblijfadres.land                |
    | adres               | straatnaam (11.10)          | Spui     | straat              | verblijfplaats.verblijfadres.locatiebeschrijving |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 en <fields> wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) |
    | 0518                 | Spui               |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000036                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
    | categorie              | Verblijfplaats                                    |

    Voorbeelden:
    | fields                                                  |
    | gemeenteVanInschrijving                                 |
    | datumInschrijvingInGemeente                             |
    | datumInschrijvingInGemeente.type                        |
    | datumInschrijvingInGemeente.datum                       |
    | datumInschrijvingInGemeente.langFormaat                 |
    | immigratie                                              |
    | immigratie.datumVestigingInNederland                    |
    | immigratie.datumVestigingInNederland.type               |
    | immigratie.vanuitVerblijfplaatsOnbekend                 |
    | immigratie.inOnderzoek                                  |
    | immigratie.inOnderzoek.datumIngangOnderzoek.langFormaat |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor meerdere categoriën waarvoor RNI-deelnemer gegevens moet worden geleverd en één of meerdere velden uit al die categoriën wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | voornamen (02.10)            | Peter                                       |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam      | waarde |
    | voornamen | Peter  |
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
    | fields                  |
    | naam,verblijfplaats     |
    | naam,verblijfplaats,rni |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor een categorie en een veld uit een andere categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | voornamen (02.10)            | Peter                                       |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam              | waarde |
    | land.code         | 5010   |
    | land.omschrijving | België |

    Voorbeelden:
    | fields                                 |
    | verblijfplaats                         |
    | verblijfplaats.verblijfadres           |
    | verblijfplaats.verblijfadres.land      |
    | verblijfplaats.verblijfadres.land.code |
    | verblijfplaats.verblijfadres.regel1    |
    | adressering.adresregel1                |
    | adressering.land                       |

  Abstract Scenario: persoon heeft meerdere nationaliteiten aangeleverd door RNI deelnemer
    Gegeven de persoon met burgerservicenummer '000000140' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
    | 0263                  | 301                   | 19620107                        | 201                   |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
    | 0052                  | 301                   | 19830326                        | 501                   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000140                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                       | waarde                                   |
    | nationaliteit.code         | 0263                                     |
    | nationaliteit.omschrijving | Surinaamse                               |
    | redenOpname.code           | 301                                      |
    | redenOpname.omschrijving   | Vaststelling bezit vreemde nationaliteit |
    | datumIngangGeldigheid      | 19620107                                 |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam                       | waarde                                   |
    | nationaliteit.code         | 0052                                     |
    | nationaliteit.omschrijving | Belgische                                |
    | redenOpname.code           | 301                                      |
    | redenOpname.omschrijving   | Vaststelling bezit vreemde nationaliteit |
    | datumIngangGeldigheid      | 19830326                                 |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | categorie              | Nationaliteit                                     |
    En heeft de persoon nog een 'rni' met de volgende gegevens
    | naam                   | waarde                                                             |
    | deelnemer.code         | 0501                                                               |
    | deelnemer.omschrijving | Immigratie- en naturalisatiedienst (inzake nationaliteitsgegevens) |
    | categorie              | Nationaliteit                                                      |

    Voorbeelden:
    | fields              |
    | nationaliteiten     |
    | nationaliteiten,rni |
    
  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor verblijfplaats, maar er worden geen verblijfplaats velden gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
    | naam                  | waarde |
    | voornamen (02.10)     | Peter  |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000036                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde |
    | voornamen     | Peter  |
    | geslachtsnaam | Jansen |

    Voorbeelden:
    | fields   |
    | naam     |
    | naam,rni |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor inschrijving en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende 'inschrijving' gegevens
    | naam                         | waarde                                      |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    | <naam gba veld>              | <waarde gba veld>                           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000048                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde          |
    | burgerservicenummer | 000000048       |
    | <naam veld 1>       | <waarde veld 1> |
    | <naam veld 2>       | <waarde veld 2> |

    Voorbeelden:
    | naam gba veld                        | waarde gba veld | naam veld 1                      | waarde veld 1 | naam veld 2                              | waarde veld 2 | fields                  |
    | indicatie geheim (70.10)             | 0               |                                  |               |                                          |               | burgerservicenummer     |
    | indicatie geheim (70.10)             | 1               | geheimhoudingPersoonsgegevens    | 1             |                                          |               | burgerservicenummer,rni |
    | reden opschorting bijhouding (67.20) | O               | opschortingBijhouding.reden.code | O             | opschortingBijhouding.reden.omschrijving | overlijden    | burgerservicenummer     |

Rule: vragen van een rni gegevensgroep veld of één of meerdere velden van een rni gegevensgroep veld met de fields parameter worden genegeerd

  Abstract Scenario: <sub titel> wordt gevraagd en hele categorie persoon is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | voornamen (02.10)            | Peter                                       |
    | geslachtsnaam (02.40)        | Jansen                                      |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon zonder 'rni' gegevens

    Voorbeelden:
    | fields                      | sub titel              |
    | rni.deelnemer               | Eén rni veld           |
    | rni.deelnemer,rni.categorie | Meerdere rni velden    |
    | rni                         | rni gegevensgroep veld |
