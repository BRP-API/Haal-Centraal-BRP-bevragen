#language: nl

Functionaliteit: GBA Persoon: naam velden vragen met fields

  Abstract Scenario: voorvoegsel naam is leeg
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde |
    | voornamen (02.10)     | Jan    |
    | voorvoegsel (02.30)   |        |
    | geslachtsnaam (02.40) | Boer   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam          | waarde |
    | voornamen     | Jan    |
    | geslachtsnaam | Boer   |

    Voorbeelden:
    | fields                                             |
    | naam                                               |
    | naam.voornamen,naam.geslachtsnaam                  |
    | naam.voornamen,naam.voorvoegsel,naam.geslachtsnaam |

  Abstract Scenario: filteren van 'adellijke titel of predicaat (02.20)' met fields=<field> geeft altijd alle velden 
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                                 | waarde |
    | adellijke titel of predicaat (02.20) | JH     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                 | waarde    |
    | adellijkeTitelPredicaat.code         | JH        |
    | adellijkeTitelPredicaat.omschrijving | jonkheer  |
    | adellijkeTitelPredicaat.soort        | predicaat |

    Voorbeelden:
    | field                                     |
    | naam.adellijkeTitelPredicaat              |
    | naam.adellijkeTitelPredicaat.code         |
    | naam.adellijkeTitelPredicaat.omschrijving |
    | naam.adellijkeTitelPredicaat.soort        |

  Scenario: 'volledige naam' wordt gevraagd met field pad 'naam.volledigeNaam'
    Gegeven de persoon met burgerservicenummer '000000619' heeft de volgende gegevens
    | geslachtsaanduiding (04.10) | voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
    | V                           | Carolina          | BS                                   | Van                 | Naersen               |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000619                       |
    | fields              | naam.volledigeNaam              |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde |
    | geslacht.code         | V      |
    | geslacht.omschrijving | vrouw  |
    En heeft de persoon de volgende 'naam' gegevens
    | naam                                 | waarde   |
    | voornamen                            | Carolina |
    | adellijkeTitelPredicaat.code         | BS       |
    | adellijkeTitelPredicaat.soort        | titel    |
    | adellijkeTitelPredicaat.omschrijving | barones  |
    | voorvoegsel                          | Van      |
    | geslachtsnaam                        | Naersen  |
