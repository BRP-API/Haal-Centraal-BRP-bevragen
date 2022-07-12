#language: nl

Functionaliteit: Aanschrijfwijze voor persoon zonder (ex-)partner, zonder adellijke titel/predicaat

  Rule: Voor een persoon zonder (ex-)partner met adellijke titel of predicaat, wordt de naam in aanschrijfwijze als volgt samengesteld: PK VL AT VV GN
        - de adellijke titel en het predicaat wordt opgenomen in de vorm die hoort bij het geslacht van de persoon:
          | adellijke titel/predicaat | vrouw     | man      | onbekend |
          | JH                        | jonkvrouw | jonkheer |          |
          | JV                        | jonkvrouw | jonkheer |          |
          | R                         |           | ridder   |          |
          | B                         | barones   | baron    |          |
          | BS                        | barones   | baron    |          |
          | H                         | hertogin  | hertog   |          |
          | HI                        | hertogin  | hertog   |          |
          | G                         | gravin    | graaf    |          |
          | GI                        | gravin    | graaf    |          |
          | M                         | markiezin | markies  |          |
          | MI                        | markiezin | markies  |          |
          | P                         | prinses   | prins    |          |
          | PS                        | prinses   | prins    |          |
        - De aanspreekvorm wordt op basis van adellijke titel/predicaat en geslacht als volgt samengesteld:
          | adellijke titel/predicaat | vrouw                    | man                    | onbekend    |
          | JH                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | JV                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | R                         | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | B                         | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | BS                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | H                         | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | HI                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | G                         | De hooggeboren vrouwe    | De hooggeboren heer    |             |
          | GI                        | De hooggeboren vrouwe    | De hooggeboren heer    |             |
          | M                         | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | MI                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
          | P                         | De hoogheid              | De hoogheid            | De hoogheid |
          | PS                        | De hoogheid              | De hoogheid            | De hoogheid |

    Abstract Scenario: persoon zonder voorvoegsel, heeft geslacht "<geslacht>" en een adellijke titel die hoort bij het geslacht
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | geslachtsnaam (02.40)                | Groenen           |
      | voornamen (02.10)                    | <voornamen>       |
      | adellijke titel of predicaat (02.20) | <adellijke titel> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                          |
      | aanschrijfwijze.naam          | F. <titel omschrijving> Groenen |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>                 |

      Voorbeelden:
      | geslacht | voornamen | adellijke titel | titel omschrijving | aanspreekvorm            |
      | M        | Franklin  | R               | ridder             | De hoogwelgeboren heer   |
      | M        | Franklin  | B               | baron              | De hoogwelgeboren heer   |
      | V        | Francisca | BS              | barones            | De hoogwelgeboren vrouwe |
      | M        | Franklin  | H               | hertog             | De hoogwelgeboren heer   |
      | V        | Francisca | HI              | hertogin           | De hoogwelgeboren vrouwe |
      | M        | Franklin  | G               | graaf              | De hooggeboren heer      |
      | V        | Francisca | GI              | gravin             | De hooggeboren vrouwe    |
      | M        | Franklin  | M               | markies            | De hoogwelgeboren heer   |
      | V        | Francisca | MI              | markiezin          | De hoogwelgeboren heer   |
      | M        | Franklin  | P               | prins              | De hoogheid              |
      | V        | Francisca | PS              | prinses            | De hoogheid              |

    Abstract Scenario: persoon zonder voorvoegsel, heeft geslacht "<geslacht>" en een predicaat die hoort bij het geslacht
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde      |
      | geslachtsnaam (02.40)                | Groenen     |
      | voornamen (02.10)                    | <voornamen> |
      | adellijke titel of predicaat (02.20) | <predicaat> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                              |
      | aanschrijfwijze.naam          | <predicaat omschrijving> F. Groenen |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>                     |

      Voorbeelden:
      | geslacht | voornamen | predicaat | predicaat omschrijving | aanspreekvorm            |
      | M        | Franklin  | JH        | Jonkheer               | De hoogwelgeboren heer   |
      | V        | Francisca | JV        | Jonkvrouw              | De hoogwelgeboren vrouwe |

    Abstract Scenario: persoon zonder voorvoegsel, heeft geslacht "<geslacht>" en een adellijke titel die niet hoort bij het geslacht
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | geslachtsnaam (02.40)                | Groenen           |
      | voornamen (02.10)                    | <voornamen>       |
      | adellijke titel of predicaat (02.20) | <adellijke titel> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                          |
      | aanschrijfwijze.naam          | F. <titel omschrijving> Groenen |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>                 |

      Voorbeelden:
      | geslacht | voornamen | adellijke titel | titel omschrijving | aanspreekvorm            |
      | M        | Franklin  | BS              | baron              | De hoogwelgeboren heer   |
      | V        | Francisca | B               | barones            | De hoogwelgeboren vrouwe |
      | M        | Franklin  | HI              | hertog             | De hoogwelgeboren heer   |
      | V        | Francisca | H               | hertogin           | De hoogwelgeboren vrouwe |
      | M        | Franklin  | GI              | graaf              | De hooggeboren heer      |
      | V        | Francisca | G               | gravin             | De hooggeboren vrouwe    |
      | M        | Franklin  | MI              | markies            | De hoogwelgeboren heer   |
      | V        | Francisca | M               | markiezin          | De hoogwelgeboren vrouwe |
      | M        | Franklin  | PS              | prins              | De hoogheid              |
      | V        | Francisca | P               | prinses            | De hoogheid              |

    Abstract Scenario: persoon zonder voorvoegsel, heeft geslacht "<geslacht>" en een predicaat die niet hoort bij het geslacht
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde      |
      | geslachtsnaam (02.40)                | Groenen     |
      | voornamen (02.10)                    | <voornamen> |
      | adellijke titel of predicaat (02.20) | <predicaat> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                              |
      | aanschrijfwijze.naam          | <predicaat omschrijving> F. Groenen |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>                     |

      Voorbeelden:
      | geslacht | voornamen | predicaat | predicaat omschrijving | aanspreekvorm            |
      | M        | Franklin  | JV        | Jonkheer               | De hoogwelgeboren heer   |
      | V        | Francisca | JH        | Jonkvrouw              | De hoogwelgeboren vrouwe |

    Abstract Scenario: persoon zonder voorvoegsel, heeft geslacht "O" en een adellijke titel ongelijk aan "P" of "PS"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | O         |
      En die persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | geslachtsnaam (02.40)                | Groenen           |
      | voornamen (02.10)                    | <voornamen>       |
      | adellijke titel of predicaat (02.20) | <adellijke titel> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |

      Voorbeelden:
      | voornamen | adellijke titel |
      | Franklin  | B               |
      | Francisca | GI              |

    Abstract Scenario: persoon zonder voorvoegsel, heeft geslacht "O" en een predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | O         |
      En die persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde      |
      | geslachtsnaam (02.40)                | Groenen     |
      | voornamen (02.10)                    | <voornamen> |
      | adellijke titel of predicaat (02.20) | <predicaat> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |

      Voorbeelden:
      | voornamen | adellijke titel |
      | Franklin  | JH              |
      | Francisca | JV              |

    Abstract Scenario: persoon zonder voorvoegsel, heeft geslacht "O" en adellijke titel gelijk aan "P" of "PS"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | O         |
      En die persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | geslachtsnaam (02.40)                | Groenen           |
      | voornamen (02.10)                    | <voornamen>       |
      | adellijke titel of predicaat (02.20) | <adellijke titel> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde      |
      | aanschrijfwijze.naam          | F. Groenen  |
      | aanschrijfwijze.aanspreekvorm | De hoogheid |

      Voorbeelden:
      | voornamen | adellijke titel |
      | Franklin  | P               |
      | Francisca | PS              |

    Scenario: persoon met geslacht "V", heeft adellijke titel "R"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde    |
      | geslachtsnaam (02.40)                | Groenen   |
      | voornamen (02.10)                    | Francisca |
      | adellijke titel of predicaat (02.20) | R         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                   |
      | aanschrijfwijze.naam          | F. Groenen               |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren vrouwe |

  Rule: voorvoegsel wordt gebruikt zoals het is geregistreerd

    Abstract Scenario: persoon met voorvoegsel, heeft geslacht "<geslacht>" en een adellijke titel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | voorvoegsel (02.30)                  | <voorvoegsel>     |
      | geslachtsnaam (02.40)                | Aedel             |
      | voornamen (02.10)                    | <voornamen>       |
      | adellijke titel of predicaat (02.20) | <adellijke titel> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                                      |
      | aanschrijfwijze.naam          | F. <titel omschrijving> <voorvoegsel> Aedel |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>                             |

      Voorbeelden:
      | geslacht | voornamen | voorvoegsel | adellijke titel | titel omschrijving | aanspreekvorm            |
      | M        | Franklin  | Van Den     | R               | ridder             | De hoogwelgeboren heer   |
      | M        | Franklin  | van den     | B               | baron              | De hoogwelgeboren heer   |
      | M        | Franklin  | van         | GI              | graaf              | De hooggeboren heer      |
      | V        | Francisca | Van         | B               | barones            | De hoogwelgeboren vrouwe |
      | M        | Franklin  | van den     | P               | prins              | De hoogheid              |
      | V        | Francisca | van den     | PS              | prinses            | De hoogheid              |

  Rule: de eerste naamcomponent in de naam in aanschrijfwijze begint met een hoofdletter

    Abstract Scenario: persoon heeft een naamketen (alleen geslachtsnaam) en een adellijke titel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En die persoon heeft alleen de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | geslachtsnaam (02.40)                | Ali bin Mohammed  |
      | adellijke titel of predicaat (02.20) | <adellijke titel> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                                |
      | aanschrijfwijze.naam          | <titel omschrijving> Ali bin Mohammed |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>                       |

      Voorbeelden:
      | geslacht | adellijke titel | titel omschrijving | aanspreekvorm            |
      | M        | B               | Baron              | De hoogwelgeboren heer   |
      | V        | HI              | Hertogin           | De hoogwelgeboren vrouwe |
      | M        | GI              | Graaf              | De hooggeboren heer      |
      | V        | P               | Prinses            | De hoogheid              |

    Abstract Scenario: persoon zonder voornamen heeft een adellijke titel of predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | M         |
      En die persoon heeft alleen de volgende 'naam' gegevens
      | naam                                 | waarde               |
      | voorvoegsel (02.30)                  | van den              |
      | geslachtsnaam (02.40)                | Aedel                |
      | adellijke titel of predicaat (02.20) | <titel of predicaat> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                                          |
      | aanschrijfwijze.naam          | <titel of predicaat omschrijving> van den Aedel |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren heer                          |

      Voorbeelden:
      | titel of predicaat | titel of predicaat omschrijving |
      | M                  | Markies                         |
      | JH                 | Jonkheer                        |

  Rule: er is geen naam in aanschrijfwijze als de geslachtsnaam van de persoon gelijk is aan de standaardwaarde

    Scenario: persoon met adellijke titel of predicaat heeft een geslachtsnaam met standaardwaarde
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde               |
      | voornamen (02.10)                    | <voornamen>          |
      | geslachtsnaam (02.40)                | .                    |
      | adellijke titel of predicaat (02.20) | <titel of predicaat> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | geslacht | voornamen | titel of predicaat | aanspreekvorm            |
      | M        | Franklin  | G                  | De hooggeboren heer      |
      | V        | Francisca | BI                 | De hoogwelgeboren vrouwe |
