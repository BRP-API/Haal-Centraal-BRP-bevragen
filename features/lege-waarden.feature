# language: nl

@post-assert
Functionaliteit: Leveren van lege waarden

  Rule: Een boolean veld met waarde false wordt niet geleverd

    @gba
    Scenario: persoon heeft veld: 'indicatie geheim (70.10)'
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                     | waarde    |
      | burgerservicenummer      | 555550001 |
      | indicatie geheim (70.10) | 0         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                            |
      | type                | RaadpleegMetBurgerservicenummer                   |
      | burgerservicenummer | 555550001                                         |
      | fields              | burgerservicenummer,geheimhoudingPersoonsgegevens |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 555550001 |
      | geheimhoudingPersoonsgegevens | 0         |

    Scenario: persoon heeft veld: 'indicatie geheim (70.10)'
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                     | waarde    |
      | burgerservicenummer      | 555550001 |
      | indicatie geheim (70.10) | 0         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                            |
      | type                | RaadpleegMetBurgerservicenummer                   |
      | burgerservicenummer | 555550001                                         |
      | fields              | burgerservicenummer,geheimhoudingPersoonsgegevens |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |

  Rule: Een string (tekst) veld met lege waarde wordt niet geleverd
    Dit geldt ook voor een standaard/onbekendwaarde: zie onbekend_waardes.feature

    Scenario: voorvoegsel naam is leeg
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde |
      | voornamen (02.10)              | Jan    |
      | voorvoegsel (02.30)            |        |
      | geslachtsnaam (02.40)          | Boer   |
      | aanduiding naamgebruik (61.10) | E      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 555550001                                          |
      | fields              | naam.voornamen,naam.voorvoegsel,naam.geslachtsnaam |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
      | naam          | waarde |
      | voornamen     | Jan    |
      | geslachtsnaam | Boer   |
  
    @gba
    Scenario: geslachtsnaam heeft standaardwaarde
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde |
      | voornamen (02.10)              | Jan    |
      | voorvoegsel (02.30)            |        |
      | geslachtsnaam (02.40)          | .      |
      | aanduiding naamgebruik (61.10) | E      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 555550002                                          |
      | fields              | naam.voornamen,naam.voorvoegsel,naam.geslachtsnaam |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
      | naam          | waarde |
      | voornamen     | Jan    |
      | geslachtsnaam | .      |

    Scenario: geslachtsnaam heeft standaardwaarde
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde |
      | voornamen (02.10)              | Jan    |
      | voorvoegsel (02.30)            |        |
      | geslachtsnaam (02.40)          | .      |
      | aanduiding naamgebruik (61.10) | E      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 555550002                                          |
      | fields              | naam.voornamen,naam.voorvoegsel,naam.geslachtsnaam |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Jan    |

  Rule: Een object (groep) wordt niet geleverd wanneer de onderliggende categorie niet bestaat of niet geleverd moet worden

    Scenario: persoon is niet overleden en heeft geen verblijfstitel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft geen 'overlijden' gegevens
      En de persoon heeft geen 'verblijfstitel' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                        |
      | type                | RaadpleegMetBurgerservicenummer               |
      | burgerservicenummer | 555550001                                     |
      | fields              | burgerservicenummer,overlijden,verblijfstitel |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |

  Rule: een array (list, collectie) veld wordt geleverd als lege array wanneer het geen enkel item bevat

    Abstract Scenario: persoon heeft geen <naam relatie> gegevens
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft geen '<naam relatie>' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetBurgerservicenummer       |
      | burgerservicenummer | 555550001                             |
      | fields              | burgerservicenummer,<naam array veld> |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En heeft de persoon een leeg '<naam array veld>' array

      Voorbeelden:
      | naam relatie  | naam array veld |
      | partner       | partners        |
      | kind          | kinderen        |
      | ouder         | ouders          |
      | nationaliteit | nationaliteiten |
      # "personen": [ { "burgerservicenummer": "555550001", "partners": [] } ]

    Scenario: ZoekMetGeslachtsnaamEnGeboortedatum vindt geen enkele persoon
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Bestaat                             |
      | voorvoegsel   | het                                 |
      | voornamen     | Niet                                |
      | geboortedatum | 1887-09-14                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de response een leeg personen array

      # "personen": [ ]

      Scenario: RaadpleegMetBurgerservicenummer vindt geen enkele persoon (bsn voldoet niet aan 11-proef)
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999999999                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een leeg personen array
      
      # "personen": [ ]
  
  Rule: Een object (groep) wordt geleverd als leeg object wanneer er ten minste één gegeven in die groep bestaat, maar geen enkel veld in die groep geleverd moet worden
    - Hierbij geldt ook een veld dat niet met fields is gevraagd voor het bestaan van de groep
    - hierbij geldt ook een veld met een standaardwaarde, leegwaarde of boolean false voor het bestaan van de groep

    @gba
    Scenario: naam velden van kind is onbekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft een 'kind' met alleen de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | .      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' met de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | .      |

    Scenario: naam velden van kind is onbekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft een 'kind' met alleen de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | .      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' met een leeg 'naam' object
      # "kinderen": [{ "naam": {} }]

    Scenario: Kind heeft geen voorvoegsel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft een 'kind' met alleen de volgende 'naam' gegevens
      | naam          | waarde  |
      | voornamen     | William |
      | geslachtsnaam | Postma  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | kinderen.naam.voorvoegsel       |
      Dan heeft de response een persoon met een 'kind' met een leeg 'naam' object
      # "kinderen": [{ "naam": {} }]

    @gba
    Scenario: Kind heeft onbekend geboorteplaats en onbekend geboorteland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft een 'kind' met alleen de volgende 'geboorte' gegevens
      | naam                   | waarde   |
      | datum                  | 20070421 |
      | geboorteplaats (03.20) | 0000     |
      | geboorteland (03.30)   | 0000     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | kinderen.geboorte.plaats        |
      Dan heeft de response een persoon met een 'kind' met de volgende 'geboorte' gegevens
      | naam        | waarde |
      | plaats.code | 0000   |
      | land.code   | 0000   |

    Scenario: Kind heeft onbekend geboorteplaats en onbekend geboorteland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft een 'kind' met alleen de volgende 'geboorte' gegevens
      | naam                   | waarde   |
      | datum                  | 20070421 |
      | geboorteplaats (03.20) | 0000     |
      | geboorteland (03.30)   | 0000     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | kinderen.geboorte.plaats        |
      Dan heeft de response een persoon met een 'kind' met een leeg 'geboorte' object
      # "kinderen": [{ "geboorte": {} }]

    Scenario: Kind heeft wel geboorteplaats omschrijving en geen geboorteplaats code
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft een 'kind' met alleen de volgende 'geboorte' gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 20070421 |
      | plaats.omschrijving   | Berlijn  |
      | geboorteland (03.30)  | 0000     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | kinderen.geboorte.plaats.code   |
      Dan heeft de response een persoon met een 'kind' met een 'geboorte' met een leeg 'plaats' object
      # "kinderen": [{ "geboorte": { "plaats": {} } }]
      