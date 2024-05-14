# language: nl

Functionaliteit: Leveren van lege waarden

  Regel: Een boolean veld met waarde false wordt niet geleverd

    Scenario: persoon heeft veld: 'indicatie geheim (70.10)'
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'inschrijving' gegevens
      | naam                     | waarde    |
      | indicatie geheim (70.10) | 0         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                            |
      | type                | RaadpleegMetBurgerservicenummer                   |
      | burgerservicenummer | 000000139                                         |
      | fields              | burgerservicenummer |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000139 |

  Regel: Een string (tekst) veld met lege waarde wordt niet geleverd
      - Dit geldt ook voor een standaard/onbekendwaarde: zie onbekend_waardes.feature

    Scenario: voorvoegsel naam is leeg
      Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende gegevens
      | naam                           | waarde |
      | voornamen (02.10)              | Jan    |
      | voorvoegsel (02.30)            |        |
      | geslachtsnaam (02.40)          | Boer   |
      | aanduiding naamgebruik (61.10) | E      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 000000176                                          |
      | fields              | naam.voornamen,naam.voorvoegsel,naam.geslachtsnaam |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
      | naam          | waarde |
      | voornamen     | Jan    |
      | geslachtsnaam | Boer   |

    Scenario: geslachtsnaam heeft standaardwaarde
      Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende gegevens
      | naam                           | waarde |
      | voornamen (02.10)              | Jan    |
      | voorvoegsel (02.30)            |        |
      | geslachtsnaam (02.40)          | .      |
      | aanduiding naamgebruik (61.10) | E      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 000000176                                          |
      | fields              | naam.voornamen,naam.voorvoegsel,naam.geslachtsnaam |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Jan    |

  Regel: Een object (groep) wordt niet geleverd wanneer de onderliggende categorie niet bestaat of niet geleverd moet worden

    Scenario: persoon is niet overleden en heeft geen verblijfstitel
      Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende gegevens
      | naam                           | waarde |
      | voornamen (02.10)              | Jan    |
      En de persoon heeft geen 'overlijden' gegevens
      En de persoon heeft geen 'verblijfstitel' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                        |
      | type                | RaadpleegMetBurgerservicenummer               |
      | burgerservicenummer | 000000176                                     |
      | fields              | burgerservicenummer,overlijden,verblijfstitel |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000176 |

  Regel: een array (list, collectie) veld wordt geleverd als lege array wanneer het geen enkel item bevat

    Scenario: persoon heeft geen partner en geen kinderen
      Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende gegevens
      | naam                           | waarde |
      | voornamen (02.10)              | Jan    |
      En de persoon heeft geen 'partners' gegevens
      En de persoon heeft geen 'kinderen' gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetBurgerservicenummer       |
      | burgerservicenummer | 000000176                             |
      | fields              | burgerservicenummer,partners,kinderen |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000176 |
      En heeft de persoon geen 'partner' gegevens
      En heeft de persoon geen 'kind' gegevens

    Scenario: ZoekMetGeslachtsnaamEnGeboortedatum vindt geen enkele persoon
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Bestaat                             |
      | voorvoegsel   | het                                 |
      | voornamen     | Niet                                |
      | geboortedatum | 1887-09-14                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de response 0 personen

    Scenario: RaadpleegMetBurgerservicenummer vindt geen enkele persoon (bsn voldoet niet aan 11-proef)
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999999999                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response 0 personen

  Regel: Een object (groep) wordt geleverd als leeg object wanneer er ten minste één gegeven in die groep bestaat, maar geen enkel veld in die groep geleverd moet worden
    - Hierbij geldt ook een veld dat niet met fields is gevraagd voor het bestaan van de groep
    - hierbij geldt ook een veld met een standaardwaarde, leegwaarde of boolean false voor het bestaan van de groep

    Scenario: Kind naam is onbekend geeft naam als leeg object
      Gegeven de persoon met burgerservicenummer '000000310' heeft een 'kind' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | .      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000310                       |
      | fields              | kinderen.naam                   |
      Dan heeft de response een persoon met een 'kind' met een leeg 'naam' object

    Scenario: Kind heeft geen voorvoegsel en alleen vragen om voorvoegsel geeft naam als leeg object
      Gegeven de persoon met burgerservicenummer '000000310' heeft een 'kind' met de volgende gegevens
      | naam                  | waarde  |
      | voornamen (02.10)     | William |
      | geslachtsnaam (02.40) | Postma  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000310                       |
      | fields              | kinderen.naam.voorvoegsel       |
      Dan heeft de response een persoon met een 'kind' met een leeg 'naam' object

    Scenario: Kind met geboorteplaats onbekend geeft geboorte als leeg object zonder plaats veld
      Gegeven de persoon met burgerservicenummer '000000322' heeft een 'kind' met de volgende gegevens
      | naam                   | waarde   |
      | geboortedatum (03.10)  | 20070421 |
      | geboorteplaats (03.20) | 0000     |
      | geboorteland (03.30)   | 0000     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000322                       |
      | fields              | kinderen.geboorte.plaats        |
      Dan heeft de response een persoon met een 'kind' met een leeg 'geboorte' object


