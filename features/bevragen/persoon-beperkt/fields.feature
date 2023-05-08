#language: nl

Functionaliteit: Persoon beperkt velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                        | waarde            |
    | geslachtsnaam (02.40)       | Maassen           |
    | geboortedatum (03.10)       | vandaag - 10 jaar |
    | geslachtsaanduiding (04.10) | V                 |

  Abstract Scenario: 'burgerservicenummer (01.20)' wordt gevraagd met '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | vandaag - 10 jaar                   |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

    Voorbeelden:
    | fields              |
    | burgerservicenummer |

  Abstract Scenario: 'geslachtsaanduiding (04.10)' wordt gevraagd met '<fields>' 
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | vandaag - 10 jaar                   |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde |
    | geslacht.code         | V      |
    | geslacht.omschrijving | vrouw  |

    Voorbeelden:
    | fields                |
    | geslacht              |
    | geslacht.code         |
    | geslacht.omschrijving |

  Scenario: 'indicatie geheim (70.10)' wordt automatisch geleverd bij waarde groter dan 0
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 1      |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | vandaag - 10 jaar                   |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000152 |
    | geheimhoudingPersoonsgegevens | true      |

  Abstract Scenario: 'leeftijd' vragen met '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | vandaag - 10 jaar                   |
    | fields        | <field>                             |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam     | waarde |
    | leeftijd | 10     |

    Voorbeelden:
    | field    |
    | leeftijd |
