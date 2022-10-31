# language: nl

Functionaliteit: GBA : RNI-deelnemer voor geleverde gegevens


  Rule: de RNI-deelnemer gegevens worden geleverd voor elke categorie waarvan ten minste één gegeven gevraagd is
    - RNI-deelnemer gegevens worden ook geleverd wanneer hier niet naar gevraagd is met de fields parameter
    - categorie wordt gevuld met de naam van de categorie waarop de RNI-deelnemer gegevens heeft aangeleverd
      | categorie | naam           |
      | 01        | Persoon        |
      | 04        | Nationaliteit  |
      | 06        | Overlijden     |
      | 07        | Inschrijving   |
      | 08        | Verblijfplaats |


    Achtergrond:
      Gegeven landelijke tabel "RNI-deelnemerstabel" heeft de volgende waarden
      | code | omschrijving                                      |
      | 0101 | Belastingdienst (inzake heffingen en toeslagen)   |
      | 0201 | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |


    Scenario: RNI-deelnemer op geleverd gegeven
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                         | waarde                                      |
      | voornamen (02.10)            | Peter                                       |
      | geslachtsnaam (02.40)        | Jansen                                      |
      | rni-deelnemer (88.10)        | 101                                         |
      | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000012                         |
      | fields              | naam.voornamen,naam.geslachtsnaam |
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

    Scenario: RNI-deelnemers op geleverde gegevens uit meerdere categorieën
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
      | naam                | waarde                                                |
      | type                | RaadpleegMetBurgerservicenummer                       |
      | burgerservicenummer | 000000024                                             |
      | fields              | naam.voornamen,verblijfplaats.verblijfadres.land.code |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Peter  |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam                    | waarde                   |
      | type                    | VerblijfplaatsBuitenland |
      | verblijfadres.land.code | 5010                     |
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

    Scenario: niet leveren RNI-deelnemer uit een categorie waar geen gegevens uit gevraagd zijn
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
      | fields              | naam.voornamen                  |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Peter  |
      En heeft de persoon GEEN 'rni'

    Scenario: niet leveren RNI-deelnemer voor een categorie waar geen gegeven uit geleverd is
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
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 000000036                                            |
      | fields              | naam.voornamen,verblijfplaats.verblijfadres.postcode |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Peter  |
      En heeft de persoon GEEN 'rni'

    Scenario: niet leveren RNI-deelnemer categorie 7 wanneer er geen opschorting en geen geheimhouding is en geen inschrijving gegevens gevraagd
      Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende 'inschrijving' gegevens
      | naam                         | waarde                                      |
      | indicatie geheim (70.10)     | 0                                           |
      | rni-deelnemer (88.10)        | 0101                                        |
      | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |

    Scenario: wel leveren RNI-deelnemer categorie 7 wanneer er geheimhouding is
      Gegeven de persoon met burgerservicenummer '000000061' heeft de volgende 'inschrijving' gegevens
      | naam                         | waarde                                      |
      | indicatie geheim (70.10)     | 7                                           |
      | rni-deelnemer (88.10)        | 0101                                        |
      | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000061 |
      | geheimhoudingPersoonsgegevens | true      |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                          |
      | deelnemer.code         | 0101                                            |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Inschrijving                                    |

    Scenario: wel leveren RNI-deelnemer categorie 7 wanneer er opschorting bijhouding is
      Gegeven de persoon met burgerservicenummer '000000073' heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde                                      |
      | reden opschorting bijhouding (67.20) | O                                           |
      | indicatie geheim (70.10)             | 0                                           |
      | rni-deelnemer (88.10)                | 0101                                        |
      | omschrijving verdrag (88.20)         | Belastingverdrag tussen België en Nederland |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000073                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000073 |
      En heeft de persoon alleen de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                          |
      | deelnemer.code         | 0101                                            |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Inschrijving                                    |

    Scenario: wel leveren RNI-deelnemer categorie 7 wanneer er om inschrijvinggegevens gevraagd is
      Gegeven de persoon met burgerservicenummer '000000085' heeft de volgende 'inschrijving' gegevens
      | naam                         | waarde                                      |
      | indicatie geheim (70.10)     | 0                                           |
      | rni-deelnemer (88.10)        | 0101                                        |
      | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                    |
      | type                | RaadpleegMetBurgerservicenummer           |
      | burgerservicenummer | 000000085                                 |
      | fields              | burgerservicenummer,opschortingBijhouding |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000085 |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                          |
      | deelnemer.code         | 0101                                            |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Inschrijving                                    |

    Scenario: alle categoriën RNI-deelnemer leveren als er met fields = rni wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende gegevens
      | naam                         | waarde                                      |
      | voornamen (02.10)            | Peter                                       |
      | geslachtsnaam (02.40)        | Jansen                                      |
      | rni-deelnemer (88.10)        | 0101                                        |
      | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                         | waarde                                      |
      | indicatie geheim (70.10)     | 0                                           |
      | rni-deelnemer (88.10)        | 0101                                        |
      | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                         | waarde                               |
      | land (13.10)                 | 5010                                 |
      | rni-deelnemer (88.10)        | 0201                                 |
      | omschrijving verdrag (88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                    |
      | type                | RaadpleegMetBurgerservicenummer           |
      | burgerservicenummer | 000000231                                 |
      | fields              | burgerservicenummer,rni                   |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000231 |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                          |
      | deelnemer.code         | 0101                                            |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Inschrijving                                    |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                          |
      | deelnemer.code         | 0101                                            |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Persoon                                         |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                          |
      | deelnemer.code         | 0101                                            |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Verblijfplaats                                  |
