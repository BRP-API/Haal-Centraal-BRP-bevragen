#language: nl

Functionaliteit: Persoon beperkt

  Scenario: persoon heeft veld: 'burgerservicenummer (01.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

  Abstract Scenario: persoon heeft veld: 'geslachtsaanduiding (04.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                        | waarde   |
    | geslachtsnaam (02.40)       | Maassen  |
    | geboortedatum (03.10)       | 19830526 |
    | geslachtsaanduiding (04.10) | V        |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <field>                             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde |
    | geslacht.code         | V      |
    | geslacht.omschrijving | vrouw  |

    Voorbeelden:
    | field                 |
    | geslacht              |
    | geslacht.code         |
    | geslacht.omschrijving |

  Abstract Scenario: persoon heeft veld: 'indicatie geheim (70.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde       |
    | indicatie geheim (70.10) | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | geheimhoudingPersoonsgegevens       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde |
    | geheimhoudingPersoonsgegevens | true   |

    Voorbeelden:
    | gba waarde |
    | 1          |
    | 2          |
    | 3          |
    | 4          |
    | 5          |
    | 6          |
    | 7          |

  Scenario: persoon heeft veld: 'indicatie geheim (70.10)' met waarde 0
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 0      |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | geheimhoudingPersoonsgegevens       |
    Dan heeft de response een persoon zonder gegevens

  Abstract Scenario: geboortedatum is een volledig datum
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    | geboortedatum (03.10) | <datum> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | <datum>                             |
    | fields        | leeftijd                            |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam     | waarde     |
    | leeftijd | <leeftijd> |

    Voorbeelden:
    | datum              | leeftijd |
    | vandaag - 10 jaar  | 10       |
    | gisteren - 15 jaar | 15       |
    | morgen - 20 jaar   | 19       |

  Abstract Scenario: gevraagde veld heeft geen waarde
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    | geboortedatum (03.10) | 20020202 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 2002-02-02                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | fields                        |
    | geheimhoudingPersoonsgegevens |
    | geslacht                      |
    | geslacht.code                 |
    | geslacht.omschrijving         |
