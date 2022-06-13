# language: nl

Functionaliteit: Leveren van lege waarden

  Rule: Een boolean veld met waarde false wordt niet geleverd

    Abstract Scenario: persoon heeft veld: 'indicatie geheim (70.10)'
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
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
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

    Scenario: persoon heeft geen partner en geen kinderen
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      En de persoon heeft geen 'partners' gegevens
      En de persoon heeft geen 'kinderen' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetBurgerservicenummer       |
      | burgerservicenummer | 555550001                             |
      | fields              | burgerservicenummer,partners,kinderen |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En heeft de response een persoon met 'partners' met een lege array
      En heeft de response een persoon met 'kinderen' met een lege array

      # "personen": [ { "burgerservicenummer": "555550001", "partners": [], "kinderen": [] } ]

    Scenario: persoon heeft alleen verlopen reisdocument
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                                   | waarde    |
      | Soort Nederlands reisdocument (35.10)                  | NI        |
      | Nummer Nederlands reisdocument (35.20)                 | NiK26q9aH |
      | Datum uitgifte Nederlands reisdocument (35.30)         | 20190314  |
      | Autoriteit van afgifte Nederlands reisdocument (35.40) | B0518     |
      | Datum einde geldigheid Nederlands reisdocument (35.50) | 20220314  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 555550002                               |
      | fields              | burgerservicenummer,reisdocumentnummers |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En heeft de response een persoon met 'reisdocumentnummers' met een lege array

      # "personen": [ { "burgerservicenummer": "555550002", "reisdocumentnummers": [] } ]

    Scenario: ZoekMetGeslachtsnaamEnGeboortedatum vindt geen enkele persoon
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Bestaat                             |
      | voorvoegsel   | het                                 |
      | voornamen     | Niet                                |
      | geboortedatum | 1887-09-14                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de response personen met een lege array

      # "personen": [ ]

      Scenario: RaadpleegMetBurgerservicenummer vindt geen enkele persoon (bsn voldoet niet aan 11-proef)
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999999999                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response personen met een lege array
      
      # "personen": [ ]
  
  Rule: Een object (groep) wordt geleverd als leeg object wanneer er ten minste één gegeven in die groep bestaat, maar geen enkel veld in die groep geleverd moet worden
    - Hierbij geldt ook een veld dat niet met fields is gevraagd voor het bestaan van de groep
    - hierbij geldt ook een veld met een standaardwaarde, leegwaarde of boolean false voor het bestaan van de groep
 
    Scenario: Kind naam is onbekend geeft naam als leeg object
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

    Scenario: Kind heeft geen voorvoegsel en alleen vragen om voorvoegsel geeft naam als leeg object
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

    Scenario: Kind met geboorteplaats onbekend geeft geboorte als leeg object zonder plaats veld
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

    Scenario: Kind met geboorteplaats alleen omschrijving en vragen om code geeft geboorteplaats als leeg object
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft een 'kind' met alleen de volgende 'geboorte' gegevens
      | naam   | waarde   |
      | datum  | 20070421 |
      | plaats | Berlijn  |
      | land   | 0000     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550003                       |
      | fields              | kinderen.geboorte.plaats.code   |
      Dan heeft de response een persoon met een 'kind' met een 'geboorte' met een leeg 'plaats' object
      # "kinderen": [{ "geboorte": { "plaats": {} } }]
      