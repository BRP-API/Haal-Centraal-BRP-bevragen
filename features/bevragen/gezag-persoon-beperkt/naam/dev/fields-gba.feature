#language: nl

@gba
Functionaliteit: naam velden vragen met fields (gezag persoon beperkt)

    Scenario: 'voorletters' wordt gevraagd met field pad 'naam.voorletters'
      Gegeven de persoon met burgerservicenummer '000000413' heeft de volgende gegevens
      | naam                  | waarde     |
      | geslachtsnaam (02.40) | Maassen    |
      | geboortedatum (03.10) | 19830526   |
      | voornamen (02.10)     | Jan Pieter |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.voorletters                        |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
      | naam      | waarde     |
      | voornamen | Jan Pieter |

    Abstract Scenario: 'volledige naam' wordt gevraagd met field pad '<fields>'
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                                 | waarde     |
      | geslachtsaanduiding (04.10)          | V          |
      | geslachtsnaam (02.40)                | Maassen    |
      | geboortedatum (03.10)                | 19830526   |
      | voorvoegsel (02.30)                  | van den    |
      | voornamen (02.10)                    | Jan Pieter |
      | adellijke titel of predicaat (02.20) | JH         |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | <fields>                                |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                  | waarde |
      | geslacht.code         | V      |
      | geslacht.omschrijving | vrouw  |
      En heeft de persoon de volgende 'naam' gegevens
      | naam                                 | waarde     |
      | geslachtsnaam                        | Maassen    |
      | voorvoegsel                          | van den    |
      | voornamen                            | Jan Pieter |
      | adellijkeTitelPredicaat.code         | JH         |
      | adellijkeTitelPredicaat.soort        | predicaat  |
      | adellijkeTitelPredicaat.omschrijving | jonkheer   |

      Voorbeelden:
      | fields             |
      | naam.volledigeNaam |
      | naam               |
