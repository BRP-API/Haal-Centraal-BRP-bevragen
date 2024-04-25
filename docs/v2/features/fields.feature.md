---
layout: page-with-side-nav
title: persoon/persoon beperkt velden vragen met fields
---
#language: nl  


# Functionaliteit: persoon/persoon beperkt velden vragen met fields


* __Als__ afnemer van de BRP API
Wil ik kunnen aangeven welke velden van de gevraagde persoon/personen moet worden geleverd  
Zodat ik alleen de velden krijg waarvoor ik doelbinding heb en tegelijk bijdraag data minimalisatie  

### Achtergrond:

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft de volgende gegevens

  | anummer (01.10) | voornamen (02.10) | geslachtsnaam (02.40) | aanduiding naamgebruik (61.10) | geslachtsaanduiding (04.10) | geboortedatum (03.10) |
  |-----------------|-------------------|-----------------------|--------------------------------|-----------------------------|-----------------------|
  | 1234567890      | Yvonne Johanna    | Kierkegaarde          | E                              | V                           | 19561115              |
* __En__ de persoon heeft een 'partner' met de volgende gegevens

  | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
  |-----------------------------|-------------------|-----------------------|
  | 999992971                   | Robert            | Bronwaßer             |
* __En__ de persoon met burgerservicenummer '000000153' heeft de volgende gegevens

  | geboortedatum (03.10) |
  |-----------------------|
  | 19780300              |
* __En__ de persoon met burgerservicenummer '000000154' heeft de volgende gegevens

  | geboortedatum (03.10) |
  |-----------------------|
  | 19680000              |
* __En__ de persoon met burgerservicenummer '000000155' heeft de volgende gegevens

  | geboortedatum (03.10) |
  |-----------------------|
  | 00000000              |

## Regel: Alleen met fields gevraagde velden worden geleverd


### Scenario: de 'root' veld van een persoon wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | aNummer                         |
* __Dan__ heeft de response een persoon met alleen de volgende gegevens

  | naam    | waarde     |
  |---------|------------|
  | aNummer | 1234567890 |

### Scenario: de 'root' veld van een 'persoon beperkt' wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam          | waarde                              |
  |---------------|-------------------------------------|
  | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
  | geslachtsnaam | Kierkegaarde                        |
  | geboortedatum | 1956-11-15                          |
  | fields        | burgerservicenummer                 |
* __Dan__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000152 |

### Scenario: meerdere 'root' velden van een persoon wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | aNummer,burgerservicenummer     |
* __Dan__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde     |
  |---------------------|------------|
  | aNummer             | 1234567890 |
  | burgerservicenummer | 000000152  |

### Scenario: alle velden van een 'gegevensgroep' veld van een persoon wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | naam                            |
* __Dan__ heeft de response een persoon met alleen de volgende 'naam' gegevens

  | naam                               | waarde                      |
  |------------------------------------|-----------------------------|
  | voornamen                          | Yvonne Johanna              |
  | geslachtsnaam                      | Kierkegaarde                |
  | voorletters                        | Y.J.                        |
  | volledigeNaam                      | Yvonne Johanna Kierkegaarde |
  | aanduidingNaamgebruik.code         | E                           |
  | aanduidingNaamgebruik.omschrijving | eigen geslachtsnaam         |

### Scenario: alle velden van een 'gegevensgroep' veld van een 'persoon beperkt' wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam          | waarde                              |
  |---------------|-------------------------------------|
  | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
  | geslachtsnaam | Kierkegaarde                        |
  | geboortedatum | 1956-11-15                          |
  | fields        | naam                                |
* __Dan__ heeft de response een persoon met alleen de volgende 'naam' gegevens

  | naam          | waarde                      |
  |---------------|-----------------------------|
  | voornamen     | Yvonne Johanna              |
  | geslachtsnaam | Kierkegaarde                |
  | voorletters   | Y.J.                        |
  | volledigeNaam | Yvonne Johanna Kierkegaarde |

## Regel: Het volledige pad van een veld is de samenvoeging van de naam van het veld en de namen van zijn 'ouder' velden met een '.' karakter tussen de veld namen 


### Scenario: een veld van een 'gegevensgroep' veld van een persoon wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | naam.geslachtsnaam              |
* __Dan__ heeft de response een persoon met alleen de volgende 'naam' gegevens

  | naam          | waarde       |
  |---------------|--------------|
  | geslachtsnaam | Kierkegaarde |

### Scenario: meerdere velden van een 'gegevensgroep' veld van een persoon wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                            |
  |---------------------|-----------------------------------|
  | type                | RaadpleegMetBurgerservicenummer   |
  | burgerservicenummer | 000000152                         |
  | fields              | naam.geslachtsnaam,naam.voornamen |
* __Dan__ heeft de response een persoon met alleen de volgende 'naam' gegevens

  | naam          | waarde         |
  |---------------|----------------|
  | geslachtsnaam | Kierkegaarde   |
  | voornamen     | Yvonne Johanna |

### Scenario: velden van meerdere 'gegevensgroepen' van een persoon wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                            |
  |---------------------|-----------------------------------|
  | type                | RaadpleegMetBurgerservicenummer   |
  | burgerservicenummer | 000000152                         |
  | fields              | naam.geslachtsnaam,geboorte.datum |
* __Dan__ heeft de response een persoon met alleen de volgende 'naam' gegevens

  | naam          | waarde       |
  |---------------|--------------|
  | geslachtsnaam | Kierkegaarde |
* __En__ heeft de persoon de volgende 'geboorte' gegevens

  | naam              | waarde           |
  |-------------------|------------------|
  | datum.type        | Datum            |
  | datum.datum       | 1956-11-15       |
  | datum.langFormaat | 15 november 1956 |

### Scenario: een veld van een 'gegevensgroep collectie' veld van een persoon wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | partners.burgerservicenummer    |
* __Dan__ heeft de response een persoon met een 'partner' met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 999992971 |

## Regel: Een veld waarvan het volledig pad deels overeenkomt met een opgegeven veld pad wordt niet geleverd


### Scenario: het opgegeven pad is het volledig pad van het voornamen veld én een deel van het volledig pad van het voornamen veld van de partner/ouder/kind velden van de persoon

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | naam.voornamen                  |
* __Dan__ heeft de response een persoon met alleen de volgende 'naam' gegevens

  | naam      | waarde         |
  |-----------|----------------|
  | voornamen | Yvonne Johanna |

## Regel: Het vragen van één of meerdere velden van een 'waardetabel' veld levert alle velden van de 'waardetabel' veld


### Abstract Scenario: 'geslachtsaanduiding (04.10)' wordt gevraagd met field pad '\<fields\>'

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | \<fields\>                        |
* __Dan__ heeft de response een persoon met de volgende gegevens

  | naam                  | waarde |
  |-----------------------|--------|
  | geslacht.code         | V      |
  | geslacht.omschrijving | vrouw  |

#### Voorbeelden:


  | fields                |
  |-----------------------|
  | geslacht              |
  | geslacht.code         |
  | geslacht.omschrijving |

## Regel: Het vragen van één of meerdere velden van een 'datum' veld levert alle velden van de 'datum' veld


### Abstract Scenario: een 'VolledigeDatum' veld wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | \<fields\>                        |
* __Dan__ heeft de response een persoon met de volgende 'geboorte' gegevens

  | naam              | waarde           |
  |-------------------|------------------|
  | datum.type        | Datum            |
  | datum.datum       | 1956-11-15       |
  | datum.langFormaat | 15 november 1956 |

#### Voorbeelden:


  | fields                                   |
  |------------------------------------------|
  | geboorte.datum                           |
  | geboorte.datum.type                      |
  | geboorte.datum.datum                     |
  | geboorte.datum.langFormaat               |
  | geboorte.datum.jaar                      |
  | geboorte.datum.maand                     |
  | geboorte.datum.onbekend                  |
  | geboorte.datum.jaar,geboorte.datum.maand |

### Abstract Scenario: een 'JaarMaandDatum' veld wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000153                       |
  | fields              | \<fields\>                        |
* __Dan__ heeft de response een persoon met de volgende 'geboorte' gegevens

  | naam              | waarde         |
  |-------------------|----------------|
  | datum.type        | JaarMaandDatum |
  | datum.jaar        | 1978           |
  | datum.maand       | 3              |
  | datum.langFormaat | maart 1978     |

#### Voorbeelden:


  | fields                                   |
  |------------------------------------------|
  | geboorte.datum                           |
  | geboorte.datum.type                      |
  | geboorte.datum.datum                     |
  | geboorte.datum.langFormaat               |
  | geboorte.datum.jaar                      |
  | geboorte.datum.maand                     |
  | geboorte.datum.onbekend                  |
  | geboorte.datum.jaar,geboorte.datum.maand |

### Abstract Scenario: een 'JaarDatum' veld wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000154                       |
  | fields              | \<fields\>                        |
* __Dan__ heeft de response een persoon met de volgende 'geboorte' gegevens

  | naam              | waarde    |
  |-------------------|-----------|
  | datum.type        | JaarDatum |
  | datum.jaar        | 1968      |
  | datum.langFormaat | 1968      |

#### Voorbeelden:


  | fields                                   |
  |------------------------------------------|
  | geboorte.datum                           |
  | geboorte.datum.type                      |
  | geboorte.datum.datum                     |
  | geboorte.datum.langFormaat               |
  | geboorte.datum.jaar                      |
  | geboorte.datum.maand                     |
  | geboorte.datum.onbekend                  |
  | geboorte.datum.jaar,geboorte.datum.maand |

### Abstract Scenario: een 'DatumOnbekend' veld wordt gevraagd

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000155                       |
  | fields              | \<fields\>                        |
* __Dan__ heeft de response een persoon met de volgende 'geboorte' gegevens

  | naam              | waarde        |
  |-------------------|---------------|
  | datum.type        | DatumOnbekend |
  | datum.onbekend    | true          |
  | datum.langFormaat | onbekend      |

#### Voorbeelden:


  | fields                                   |
  |------------------------------------------|
  | geboorte.datum                           |
  | geboorte.datum.type                      |
  | geboorte.datum.datum                     |
  | geboorte.datum.langFormaat               |
  | geboorte.datum.jaar                      |
  | geboorte.datum.maand                     |
  | geboorte.datum.onbekend                  |
  | geboorte.datum.jaar,geboorte.datum.maand |

## Regel: Een gevraagd veld zonder waarde wordt niet geleverd


### Scenario: het gevraagde veld heeft geen waarde

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000152                       |
  | fields              | naam.adellijkeTitelPredicaat    |
* __Dan__ heeft de response een persoon zonder 'naam' gegevens

