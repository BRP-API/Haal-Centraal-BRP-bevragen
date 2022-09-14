# language: nl

Functionaliteit: RNI-deelnemer voor geleverde gegevens


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
      | 101  | Belastingdienst (inzake heffingen en toeslagen)   |
      | 201  | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |


    Scenario: RNI-deelnemer op geleverd gegeven
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                            | waarde                                      |
      | burgerservicenummer             | 000000012                                   |
      | RNI-deelnemer (01.88.10)        | 101                                         |
      | Omschrijving verdrag (01.88.20) | Belastingverdrag tussen België en Nederland |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde |
      | voornamen (02.10)     | Peter  |
      | geslachtsnaam (02.40) | Jansen |
      Als personen wordt gezocht met de volgende parameters
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
      | deelnemer.code         | 101                                             |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Persoon                                         |

    Scenario: RNI-deelnemers op geleverde gegevens uit meerdere categorieën
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                            | waarde                                      |
      | burgerservicenummer             | 000000024                                   |
      | RNI-deelnemer (01.88.10)        | 101                                         |
      | Omschrijving verdrag (01.88.20) | Belastingverdrag tussen België en Nederland |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde |
      | voornamen (02.10)     | Peter  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde                               |
      | land (13.10)                    | 5010                                 |
      | RNI-deelnemer (08.88.10)        | 201                                  |
      | Omschrijving verdrag (08.88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
      Als personen wordt gezocht met de volgende parameters
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
      | deelnemer.code         | 101                                             |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Persoon                                         |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                            |
      | deelnemer.code         | 201                                               |
      | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
      | omschrijvingVerdrag    | Artikel 45 EU-Werkingsverdrag (VWEU)              |
      | categorie              | Verblijfplaats                                    |

    Scenario: niet leveren RNI-deelnemer uit een categorie waar geen gegevens uit gevraagd zijn
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                            | waarde                                      |
      | burgerservicenummer             | 000000036                                   |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde |
      | voornamen (02.10)     | Peter  |
      | geslachtsnaam (02.40) | Jansen |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde                               |
      | land (13.10)                    | 5010                                 |
      | RNI-deelnemer (08.88.10)        | 201                                  |
      | Omschrijving verdrag (08.88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000036                       |
      | fields              | naam.voornamen                  |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Peter  |
      En heeft de persoon geen 'rni' gegevens

    Scenario: niet leveren RNI-deelnemer voor een categorie waar geen gegeven uit geleverd is
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                            | waarde                                      |
      | burgerservicenummer             | 000000036                                   |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                  | waarde |
      | voornamen (02.10)     | Peter  |
      | geslachtsnaam (02.40) | Jansen |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde                               |
      | land (13.10)                    | 5010                                 |
      | RNI-deelnemer (08.88.10)        | 201                                  |
      | Omschrijving verdrag (08.88.20) | Artikel 45 EU-Werkingsverdrag (VWEU) |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                               |
      | type                | RaadpleegMetBurgerservicenummer                      |
      | burgerservicenummer | 000000036                                            |
      | fields              | naam.voornamen,verblijfplaats.verblijfadres.postcode |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Peter  |
      En heeft de persoon GEEN 'rni'

    Scenario: niet leveren RNI-deelnemer categorie 7 wanneer er geen opschorting en geen geheimhouding is
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                            | waarde                                      |
      | burgerservicenummer             | 000000048                                   |
      | indicatie geheim (70.10)        | 0                                           |
      | RNI-deelnemer (07.88.10)        | 101                                         |
      | Omschrijving verdrag (07.88.20) | Belastingverdrag tussen België en Nederland |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |

    Scenario: wel leveren RNI-deelnemer categorie 7 wanneer er geheimhouding is
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                            | waarde                                      |
      | burgerservicenummer             | 000000061                                   |
      | indicatie geheim (70.10)        | 7                                           |
      | RNI-deelnemer (07.88.10)        | 101                                         |
      | Omschrijving verdrag (07.88.20) | Belastingverdrag tussen België en Nederland |
      Als personen wordt gezocht met de volgende parameters
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
      | deelnemer.code         | 101                                             |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Inschrijving                                         |

    Scenario: wel leveren RNI-deelnemer categorie 7 wanneer er opschorting bijhouding is
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                            | waarde                                      |
      | burgerservicenummer             | 000000073                                   |
      | indicatie geheim (70.10)        | 0                                           |
      | RNI-deelnemer (07.88.10)        | 101                                         |
      | Omschrijving verdrag (07.88.20) | Belastingverdrag tussen België en Nederland |
      En de persoon heeft de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000073                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000073 |
      En heeft de persoon alleen de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde     |
      | reden.code         | O          |
      | reden.omschrijving | overlijden |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                          |
      | deelnemer.code         | 101                                             |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Inschrijving                                    |
