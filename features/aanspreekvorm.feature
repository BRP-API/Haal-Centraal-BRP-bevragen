#language: nl

@post-assert
Functionaliteit: aanspreekvorm

  Rule: de aanspreekvorm wordt uit de adellijke titel/predicaat en geslacht als volgt samengesteld:
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

    Abstract Scenario: persoon met geslacht "<geslacht>" en adellijke titel/predicaat "<titel of predicaat>", heeft geen (ex-)partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde               |
      | adellijke titel of predicaat (02.20) | <titel of predicaat> |
      | aanduiding naamgebruik (61.10)       | <naamgebruik>        |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | geslacht | naamgebruik | titel of predicaat | aanspreekvorm            |
      | M        | E           | JH                 | De hoogwelgeboren heer   |
      | M        | P           | JV                 | De hoogwelgeboren heer   |
      | M        | V           | R                  | De hoogwelgeboren heer   |
      | M        | N           | B                  | De hoogwelgeboren heer   |
      | M        | E           | BS                 | De hoogwelgeboren heer   |
      | M        | P           | H                  | De hoogwelgeboren heer   |
      | M        | V           | HI                 | De hoogwelgeboren heer   |
      | M        | N           | G                  | De hooggeboren heer      |
      | M        | E           | GI                 | De hooggeboren heer      |
      | M        | P           | M                  | De hoogwelgeboren heer   |
      | M        | V           | MI                 | De hoogwelgeboren heer   |
      | M        | N           | P                  | De hoogheid              |
      | M        | E           | PS                 | De hoogheid              |
      | V        | P           | JH                 | De hoogwelgeboren vrouwe |
      | V        | V           | JV                 | De hoogwelgeboren vrouwe |
      | V        | N           | R                  | De hoogwelgeboren vrouwe |
      | V        | E           | B                  | De hoogwelgeboren vrouwe |
      | V        | P           | BS                 | De hoogwelgeboren vrouwe |
      | V        | V           | H                  | De hoogwelgeboren vrouwe |
      | V        | N           | HI                 | De hoogwelgeboren vrouwe |
      | V        | E           | G                  | De hooggeboren vrouwe    |
      | V        | P           | GI                 | De hooggeboren vrouwe    |
      | V        | V           | M                  | De hoogwelgeboren vrouwe |
      | V        | N           | MI                 | De hoogwelgeboren vrouwe |
      | V        | E           | P                  | De hoogheid              |
      | V        | P           | PS                 | De hoogheid              |
      | O        | V           | P                  | De hoogheid              |
      | O        | N           | PS                 | De hoogheid              |

    Abstract Scenario: persoon met geslacht "O" en adellijke titel/predicaat "<titel of predicaat>", heeft geen (ex-)partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | O         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde               |
      | adellijke titel of predicaat (02.20) | <titel of predicaat> |
      | aanduiding naamgebruik (61.10)       | <naamgebruik>        |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met leeg 'adressering' object

      Voorbeelden:
      | naamgebruik | titel of predicaat |
      | E           | JH                 |
      | P           | JV                 |
      | V           | R                  |
      | N           | B                  |
      | E           | BS                 |
      | P           | H                  |
      | V           | HI                 |
      | N           | G                  |
      | E           | GI                 |
      | P           | M                  |
      | V           | MI                 |

    Abstract Scenario: persoon heeft geen adellijke titel/predicaat en geen (ex-)partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde                   |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | aanduiding naamgebruik |
      | E                      |
      | P                      |
      | V                      |
      | N                      |

    Abstract Scenario: persoon en partner hebben geen adellijke titel/predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde                   |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20180808 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | aanduiding naamgebruik |
      | E                      |
      | P                      |
      | V                      |
      | N                      |

    Abstract Scenario: persoon en ex-partner hebben geen adellijke titel/predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde                   |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20180808 |
      En de 'partner' heeft de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20201001 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | aanduiding naamgebruik |
      | E                      |
      | P                      |
      | V                      |
      | N                      |

  Rule: Er is geen aanspreekvorm als de persoon de naam van de (ex-)partner zonder eigen geslachtsnaam gebruikt (aanduiding naamgebruik is gelijk aan "P")

    Abstract Scenario: persoon met geslacht "<geslacht>", adellijke titel en aanduiding naamgebruik ongelijk aan "P", heeft partner met/zonder adellijke titel/predicaat 
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | adellijke titel of predicaat (02.20) | <adellijke titel> |
      | aanduiding naamgebruik (61.10)       | <naamgebruik>     |
      En de persoon heeft een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20180808 |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <titel/predicaat partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | geslacht | naamgebruik | adellijke titel | titel/predicaat partner | aanspreekvorm            |
      | M        | E           | R               |                         | De hoogwelgeboren heer   |
      | V        | V           | G               |                         | De hooggeboren vrouwe    |
      | O        | N           | P               |                         | De hoogheid              |
      | V        | N           | BS              | P                       | De hoogwelgeboren vrouwe |
      | M        | E           | G               | JV                      | De hooggeboren heer      |
      | O        | V           | PS              | BS                      | De hoogheid              |

    Abstract Scenario: persoon met geslacht "<geslacht>", adellijke titel en aanduiding naamgebruik "P", heeft partner met/zonder adellijke titel/predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde |
      | adellijke titel of predicaat (02.20) | G      |
      | aanduiding naamgebruik (61.10)       | P      |
      En de persoon heeft een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20180808 |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <titel/predicaat partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | geslacht | titel/predicaat partner |
      | M        |                         |
      | V        |                         |
      | O        |                         |
      | M        | JH                      |
      | V        | GI                      |
      | O        | P                       |

  Rule: Er is geen aanspreekvorm als de persoon een predicaat heeft, het geslacht gelijk is aan "V" en een actuele partner heeft

    Abstract Scenario: persoon met geslacht "<geslacht>" en predicaat, heeft een actuele partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde        |
      | adellijke titel of predicaat (02.20) | <predicaat>   |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                  | waarde   |
      | datum aangaan (06.10) | 19580401 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | geslacht | predicaat | naamgebruik |
      | V        | JH        | E           |
      | V        | JH        | P           |
      | O        | JH        | V           |
      | O        | JH        | N           |
      | O        | JV        | E           |
      | V        | JV        | P           |
      | O        | JV        | V           |
      | V        | JV        | N           |

    Abstract Scenario: persoon met geslacht "M" en predicaat, heeft een actuele partner
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde        |
      | adellijke titel of predicaat (02.20) | <predicaat>   |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19580401 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                 |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren heer |

      Voorbeelden:
      | predicaat | naamgebruik |
      | JH        | E           |
      | JH        | V           |
      | JH        | N           |
      | JV        | E           |
      | JV        | V           |
      | JV        | N           |

  Rule: Er is geen aanspreekvorm als de persoon een predicaat heeft, het geslacht gelijk is aan "V", een ex-partner heeft en de naam van de ex-partner (aanduiding naamgebruik is ongelijk aan "E") gebruikt

    Abstract Scenario: persoon met geslacht "V", een predicaat en aanduiding naamgebruik ongelijk aan "E", heeft een ex-partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde                   |
      | adellijke titel of predicaat (02.20) | <predicaat>              |
      | aanduiding naamgebruik (61.10)       | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20220628 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | predicaat | aanduiding naamgebruik |
      | JH        | P                      |
      | JH        | V                      |
      | JH        | N                      |
      | JV        | P                      |
      | JV        | V                      |
      | JV        | N                      |

    Abstract Scenario: persoon met geslacht "V", een predicaat en aanduiding naamgebruik "E", heeft een ex-partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde      |
      | adellijke titel of predicaat (02.20) | <predicaat> |
      | aanduiding naamgebruik (61.10)       | E           |
      En de persoon heeft een 'partner' met de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20220628 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                   |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren vrouwe |

      Voorbeelden:
      | predicaat |
      | JH        |
      | JV        |

    Abstract Scenario: persoon met geslacht "M", een predicaat en aanduiding naamgebruik "<naamgebruik>", heeft een ex-partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde        |
      | adellijke titel of predicaat (02.20) | <predicaat>   |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20220628 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde                 |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren heer |

      Voorbeelden:
      | predicaat | naamgebruik |
      | JH        | E           |
      | JV        | V           |
      | JH        | N           |

    Abstract Scenario: persoon met geslacht "M", een predicaat en aanduiding naamgebruik "P", heeft een ex-partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde      |
      | adellijke titel of predicaat (02.20) | <predicaat> |
      | aanduiding naamgebruik (61.10)       | P           |
      En de persoon heeft een 'partner' met de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20220628 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | predicaat |
      | JH        |
      | JV        |
      | JH        |

    Abstract Scenario: persoon met geslacht "O", een predicaat en aanduiding naamgebruik "<naamgebruik>", heeft een ex-partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | O         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde        |
      | adellijke titel of predicaat (02.20) | <predicaat>   |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20220628 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | predicaat | naamgebruik |
      | JH        | E           |
      | JV        | V           |
      | JH        | N           |
      | JV        | P           |

  Rule: Voor het bepalen van de aanspreekvorm wordt de hoffelijkheidstitel ('titre de courtoisie') gebruikt als:
        - het geslacht van de persoon is "V"
        - de persoon gebruikt de naam van haar (ex-)partner (aanduiding naamgebruik is ongelijk aan "E")
        - de (ex-)partner heeft een adellijke titel
        - met de adellijke titel van de (ex-)partner mag een hoffelijkheidstitel ('titre de courtoisie') worden gebruikt met bijbehorend aanspreekvorm:
          | adellijke titel | hoffelijkheidstitel | aanspreekvorm            |
          | B               | barones             | De hoogwelgeboren vrouwe |
          | G               | gravin              | De hooggeboren vrouwe    |
          | H               | hertogin            | De hoogwelgeboren vrouwe |
          | M               | markiezin           | De hoogwelgeboren vrouwe |
          | P               | prinses             | De hoogheid              |

    Abstract Scenario: persoon met geslacht "V" en aanduiding naamgebruik ongelijk aan "E", heeft partner met adellijke titel met hoffelijkheidstitel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde        |
      | aanschrijfwijze.aanspreekvorm | aanspreekvorm |

      Voorbeelden:
      | naamgebruik | adellijke titel partner | aanspreekvorm            |
      | P           | B                       | De hoogwelgeboren vrouwe |
      | V           | G                       | De hooggeboren vrouwe    |
      | N           | H                       | De hoogwelgeboren vrouwe |
      | P           | M                       | De hoogwelgeboren vrouwe |
      | V           | P                       | De hoogheid              |

    Abstract Scenario: persoon met geslacht "V" en aanduiding naamgebruik ongelijk aan "E", heeft partner met adellijke titel zonder hoffelijkheidstitel of predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <titel/predicaat partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | naamgebruik | titel/predicaat partner |
      | P           | R                       |
      | V           | JH                      |
      | N           | BS                      |
      | P           | GI                      |
      | V           | JV                      |
      | N           | MI                      |

    Abstract Scenario: persoon met geslacht ongelijk aan "V" en aanduiding naamgebruik ongelijk aan "E", heeft partner met adellijke titel met hoffelijkheidstitel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met leeg 'adressering' object

      Voorbeelden:
      | geslacht | naamgebruik | adellijke titel partner |
      | M        | P           | B                       |
      | O        | V           | G                       |
      | M        | N           | H                       |
      | O        | P           | M                       |
      | M        | V           | P                       |

    Abstract Scenario: persoon met geslacht "V" en aanduiding naamgebruik "E", heeft partner met adellijke titel met hoffelijkheidstitel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde |
      | aanduiding naamgebruik (61.10) | E      |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met leeg 'adressering' object

      Voorbeelden:
      | adellijke titel partner |
      | B                       |
      | G                       |
      | H                       |
      | M                       |
      | P                       |

  Rule: Voor het bepalen van de aanspreekvorm gaat gebruik van de adellijke titel van de partner boven de adellijke titel van de persoon als:
        - het geslacht van de persoon is "V"
        - de persoon heeft een adellijke titel of predicaat
        - de persoon gebruikt de naam van haar (ex-)partner (aanduiding naamgebruik is ongelijk aan "E")
        - het geslacht van de (ex-)partner is "M"
        - de (ex-)partner heeft een adellijke titel
        - met de adellijke titel van de (ex)partner mag een hoffelijkheidstitel ('titre de courtoisie') worden gebruikt met bijbehorende aanspreekvorm

    Abstract Scenario: persoon met geslacht "V", adellijke titel of predicaat en aanduiding naamgebruik ongelijk aan "E", heeft partner met geslacht "M" en adellijke titel met hoffelijkheidstitel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | adellijke titel of predicaat (02.20) | <titel/predicaat> |
      | aanduiding naamgebruik (61.10)       | <naamgebruik>     |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                        | waarde |
      | geslachtsaanduiding (04.10) | M      |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | titel/predicaat | adellijke titel partner | naamgebruik | aanspreekvorm            |
      | JV              | B                       | P           | De hoogwelgeboren vrouwe |
      | BS              | H                       | V           | De hoogwelgeboren vrouwe |
      | HI              | M                       | N           | De hoogwelgeboren vrouwe |
      | GI              | P                       | P           | De hoogheid              |
      | MI              | P                       | V           | De hoogheid              |
      | PS              | P                       | N           | De hoogheid              |
      | JV              | G                       | P           | De hooggeboren vrouwe    |
      | BS              | G                       | V           | De hooggeboren vrouwe    |
      | HI              | G                       | N           | De hooggeboren vrouwe    |

    Abstract Scenario: persoon met geslacht "V", adellijke titel of predicaat en aanduiding naamgebruik gelijk aan "E", heeft partner met geslacht "M" en adellijke titel met hoffelijkheidstitel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | adellijke titel of predicaat (02.20) | <titel/predicaat> |
      | aanduiding naamgebruik (61.10)       | E                 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                        | waarde |
      | geslachtsaanduiding (04.10) | M      |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | titel/predicaat | adellijke titel partner | aanspreekvorm            |
      | GI              | B                       | De hooggeboren vrouwe    |
      | BS              | P                       | De hoogwelgeboren vrouwe |
      | JV              | R                       | De hoogwelgeboren vrouwe |
      | PS              | B                       | De hoogheid              |

    Abstract Scenario: persoon met geslacht ongelijk aan "V", adellijke titel of predicaat en aanduiding naamgebruik ongelijk aan "E", heeft partner met geslacht "M" en adellijke titel met hoffelijkheidstitel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde            |
      | adellijke titel of predicaat (02.20) | <titel/predicaat> |
      | aanduiding naamgebruik (61.10)       | <naamgebruik>     |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                        | waarde |
      | geslachtsaanduiding (04.10) | M      |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | aanschrijfwijze.aanspreekvorm   |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | geslacht | naamgebruik | titel/predicaat | adellijke titel partner | aanspreekvorm          |
      | M        | P           | JH              | B                       | De hoogwelgeboren heer |
      | O        | V           | P               | G                       | De hoogheid            |
      | M        | N           | G               | H                       | De hooggeboren heer    |
