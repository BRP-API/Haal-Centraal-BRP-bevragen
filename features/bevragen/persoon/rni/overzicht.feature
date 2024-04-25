# language: nl

Functionaliteit: RNI-deelnemer gegevens leveren

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

Regel: RNI-deelnemer gegevens die horen bij categorie 01 (Persoon), 04 (Nationaliteit), 06 (Overlijden) en/of 08 (Verblijfplaats) worden geleverd wanneer één of meerdere velden uit die categoriën wordt gevraagd

  Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 01 (Persoon) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | geslachtsnaam (02.40)        | Jansen                                      |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | naam                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde |
    | geslachtsnaam | Jansen |
    | volledigeNaam | Jansen |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                          |
    | deelnemer.code         | 0101                                            |
    | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
    | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
    | categorie              | Persoon                                         |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 04 (Nationaliteit) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                         | waarde                                      |
    | nationaliteit (05.10)        | <nationaliteit code>                        |
    | rni-deelnemer (88.10)        | <rni-deelnemer code>                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                       | waarde                       |
    | type                       | Nationaliteit                |
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

  Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 06 (Overlijden) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) | rni-deelnemer (88.10) |
    | 20020701                 | 0518                      | 6030                    | 0401                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | overlijden.datum                |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 2002-07-01  |
    | datum.langFormaat | 1 juli 2002 |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                         |
    | deelnemer.code         | 0401                           |
    | deelnemer.omschrijving | CAK (inzake zorgverzekeringen) |
    | categorie              | Overlijden                     |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 (verblijfplaats buitenland) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000036                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                   |
    | type                            | VerblijfplaatsBuitenland |
    | verblijfadres.land.code         | 5010                     |
    | verblijfadres.land.omschrijving | België                   |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
    | categorie              | Verblijfplaats                                    |

    Voorbeelden:
    | fields                                         |
    | verblijfplaats                                 |
    | verblijfplaats.verblijfadres                   |
    | verblijfplaats.verblijfadres.land              |
    | verblijfplaats.verblijfadres.land.code         |
    | verblijfplaats.verblijfadres.land.omschrijving |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 (verblijfplaats onbekend) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 0000                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000036                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                 |
    | type | VerblijfplaatsOnbekend |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
    | categorie              | Verblijfplaats                                    |

    Voorbeelden:
    | fields                                |
    | verblijfplaats.verblijfadres.postcode |
    | verblijfplaats.verblijfadres.land     |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 (verblijfplaats buitenland) en één of meerdere adressering velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als personen wordt gezocht met de volgende parameters
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
    En heeft de persoon geen 'adressering' gegevens

    Voorbeelden:
    | fields                        |
    | adressering                   |
    | adressering.adresregel1       |
    | adressering.land              |
    | adressering.land.omschrijving |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 (adres/locatie) en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde   |
    | gemeentecode (92.10) | 0518     |
    | <naam gba veld>      | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000036                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                |
    | type | <verblijfplaats type> |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
    | categorie              | Verblijfplaats                                    |

    Voorbeelden:
    | verblijfplaats type | naam gba veld               | waarde   | fields                                           |
    | Locatie             | locatiebeschrijving (12.10) | woonboot | verblijfplaats.verblijfadres.land                |
    | Adres               | straatnaam (11.10)          | Spui     | verblijfplaats.verblijfadres.locatiebeschrijving |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor categorie 08 en <fields> wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) |
    | 0518                 | Spui               |
    Als personen wordt gezocht met de volgende parameters
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

  Scenario: persoon heeft RNI-deelnemer gegevens voor meerdere categoriën waarvoor RNI-deelnemer gegevens moet worden geleverd en één of meerdere velden uit al die categoriën wordt gevraagd
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
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | naam,verblijfplaats             |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde |
    | voornamen     | Peter  |
    | voorletters   | P.     |
    | volledigeNaam | Peter  |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
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

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor een categorie en een veld uit een andere categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | voornamen (02.10)            | Peter                                       |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam         | waarde |
    | land (13.10) | 5010   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam              | waarde |
    | land.code         | 5010   |
    | land.omschrijving | België |

    Voorbeelden:
    | fields                                 |
    | verblijfplaats                         |
    | verblijfplaats.verblijfadres           |
    | verblijfplaats.verblijfadres.land      |
    | verblijfplaats.verblijfadres.land.code |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor een categorie en een veld uit een andere categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | naam                         | waarde                                      |
    | voornamen (02.10)            | Peter                                       |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam         | waarde |
    | land (13.10) | 5010   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon zonder 'adressering' gegevens

    Voorbeelden:
    | fields                                 |
    | adressering.adresregel1                |
    | adressering.land                       |

  Scenario: persoon heeft meerdere nationaliteiten aangeleverd door RNI deelnemer
    Gegeven de persoon met burgerservicenummer '000000140' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
    | 0263                  | 301                   | 19620107                        | 201                   |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
    | 0052                  | 301                   | 19830326                        | 501                   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000140                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                              | waarde                                   |
    | type                              | Nationaliteit                            |
    | nationaliteit.code                | 0263                                     |
    | nationaliteit.omschrijving        | Surinaamse                               |
    | redenOpname.code                  | 301                                      |
    | redenOpname.omschrijving          | Vaststelling bezit vreemde nationaliteit |
    | datumIngangGeldigheid.type        | Datum                                    |
    | datumIngangGeldigheid.datum       | 1962-01-07                               |
    | datumIngangGeldigheid.langFormaat | 7 januari 1962                           |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam                              | waarde                                   |
    | type                              | Nationaliteit                            |
    | nationaliteit.code                | 0052                                     |
    | nationaliteit.omschrijving        | Belgische                                |
    | redenOpname.code                  | 301                                      |
    | redenOpname.omschrijving          | Vaststelling bezit vreemde nationaliteit |
    | datumIngangGeldigheid.type        | Datum                                    |
    | datumIngangGeldigheid.datum       | 1983-03-26                               |
    | datumIngangGeldigheid.langFormaat | 26 maart 1983                            |
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

  Scenario: persoon heeft een actuele en een beëindigde nationaliteit aangeleverd door RNI deelnemer
    Gegeven de persoon met burgerservicenummer '000000140' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
    | 0263                  | 301                   | 19620107                        | 201                   |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
    | 0052                  | 301                   | 19830326                        | 501                   |
    En de 'nationaliteit' is gewijzigd naar de volgende gegevens
    | reden beëindigen (64.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
    | 403                      | 19970715                        | 501                   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000140                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                              | waarde                                   |
    | type                              | Nationaliteit                            |
    | nationaliteit.code                | 0263                                     |
    | nationaliteit.omschrijving        | Surinaamse                               |
    | redenOpname.code                  | 301                                      |
    | redenOpname.omschrijving          | Vaststelling bezit vreemde nationaliteit |
    | datumIngangGeldigheid.type        | Datum                                    |
    | datumIngangGeldigheid.datum       | 1962-01-07                               |
    | datumIngangGeldigheid.langFormaat | 7 januari 1962                           |
    En heeft de persoon een 'rni' met de volgende gegevens
    | naam                   | waarde                                            |
    | deelnemer.code         | 0201                                              |
    | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
    | categorie              | Nationaliteit                                     |
    
  Scenario: persoon heeft RNI-deelnemer gegevens voor verblijfplaats, maar er worden geen verblijfplaats velden gevraagd
    Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
    | naam                  | waarde |
    | voornamen (02.10)     | Peter  |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde                               |
    | land (13.10)                 | 5010                                 |
    | rni-deelnemer (88.10)        | 0201                                 |
    | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000036                       |
    | fields              | naam                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde       |
    | voornamen     | Peter        |
    | geslachtsnaam | Jansen       |
    | voorletters   | P.           |
    | volledigeNaam | Peter Jansen |

  Abstract Scenario: persoon heeft RNI-deelnemer gegevens voor inschrijving en één of meerdere velden uit die categorie wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende 'inschrijving' gegevens
    | naam                         | waarde                                      |
    | rni-deelnemer (88.10)        | 0101                                        |
    | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
    | <naam gba veld>              | <waarde gba veld>                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000048                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde          |
    | burgerservicenummer | 000000048       |
    | <naam veld 1>       | <waarde veld 1> |
    | <naam veld 2>       | <waarde veld 2> |

    Voorbeelden:
    | naam gba veld                        | waarde gba veld | naam veld 1                      | waarde veld 1 | naam veld 2                              | waarde veld 2 |
    | indicatie geheim (70.10)             | 0               |                                  |               |                                          |               |
    | indicatie geheim (70.10)             | 1               | geheimhoudingPersoonsgegevens    | true          |                                          |               |
    | reden opschorting bijhouding (67.20) | O               | opschortingBijhouding.reden.code | O             | opschortingBijhouding.reden.omschrijving | overlijden    |


Regel: rni mag niet worden gevraagd, omdat het automatisch wordt geleverd

   @fout-case
   Abstract Scenario: rni in <fields> mag niet worden gevraagd, omdat het automatisch wordt geleverd
     Als personen wordt gezocht met de volgende parameters
     | naam                | waarde                          |
     | type                | RaadpleegMetBurgerservicenummer |
     | burgerservicenummer | 000000024                       |
     | fields              | <fields>                        |
     Dan heeft de response een object met de volgende gegevens
     | naam     | waarde                                                      |
     | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
     | title    | Een of meerdere parameters zijn niet correct.               |
     | status   | 400                                                         |
     | detail   | De foutieve parameter(s) zijn: fields[<index>].             |
     | code     | paramsValidation                                            |
     | instance | /haalcentraal/api/brp/personen                              |
     En heeft het object de volgende 'invalidParams' gegevens
     | code   | name            | reason                                        |
     | fields | fields[<index>] | Parameter bevat een niet toegestane veldnaam. |

    Voorbeelden:
    | fields                                      | index |
    | rni                                         | 0     |
    | rni.deelnemer                               | 0     |
    | rni.deelnemer.code                          | 0     |
    | rni.deelnemer.omschrijving                  | 0     |
    | rni.omschrijvingVerdrag                     | 0     |
    | rni.categorie                               | 0     |
    | rni.omschrijvingVerdrag,burgerservicenummer | 0     |
    | naam.voorvoegsel,rni,europeesKiesrecht      | 1     |
    | verblijfstitel,overlijden,rni.deelnemer     | 2     |
