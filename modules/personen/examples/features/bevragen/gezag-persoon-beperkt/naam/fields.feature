#language: nl

Functionaliteit: Gezag Persoon beperkt: naam velden vragen met fields

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                                 | waarde     |
      | voornamen (02.10)                    | Jan Pieter |
      | adellijke titel of predicaat (02.20) | JH         |
      | voorvoegsel (02.30)                  | van        |
      | geslachtsnaam (02.40)                | Maassen    |
      | geslachtsaanduiding (04.10)          | M          |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |

    Scenario: 'voornamen (02.10)' wordt gevraagd met field pad 'naam.voornamen'
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.voornamen                          |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde     |
      | voornamen | Jan Pieter |

    Scenario: 'voorvoegsel (02.30)' wordt gevraagd met field pad 'naam.voorvoegsel'
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.voorvoegsel                        |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam        | waarde |
      | voorvoegsel | van    |

    Scenario: 'geslachtsnaam (02.40)' wordt gevraagd met field pad 'naam.geslachtsnaam'
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.geslachtsnaam                      |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam          | waarde  |
      | geslachtsnaam | Maassen |

    Scenario: 'adellijke titel of predicaat (02.20)' wordt gevraagd met field pad '<fields>'
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | <fields>                                |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | adellijkeTitelPredicaat.code         | JH        |
      | adellijkeTitelPredicaat.omschrijving | jonkheer  |
      | adellijkeTitelPredicaat.soort        | predicaat |

      Voorbeelden:
      | fields                                    |
      | naam.adellijkeTitelPredicaat              |
      | naam.adellijkeTitelPredicaat.code         |
      | naam.adellijkeTitelPredicaat.omschrijving |
      | naam.adellijkeTitelPredicaat.soort        |

    Scenario: 'voorletters' wordt gevraagd met field pad 'naam.voorletters'
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.voorletters                        |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam        | waarde |
      | voorletters | J.P.   |

    Scenario: 'volledige naam' wordt gevraagd met field pad 'naam.volledigeNaam'
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | naam.volledigeNaam                      |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam          | waarde                          |
      | volledigeNaam | jonkheer Jan Pieter van Maassen |

    Abstract Scenario: gevraagde veld heeft geen waarde
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Vos    |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001503                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001503                        |
      | fields                           | <fields>                                |
      Dan heeft de response een persoon zonder 'naam' gegevens

      Voorbeelden:
      | fields           |
      | naam.voornamen   |
      | naam.voorvoegsel |

    Scenario: gevraagde veld heeft standaard waarde
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | .      |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001503                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001503                        |
      | fields                           | naam.geslachtsnaam                      |
      Dan heeft de response een persoon zonder 'naam' gegevens
