# language: nl

Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers na een geslachtswijziging
  Wanneer een persoon met adellijke titel of predicaat een geslachtswijziging heeft ondergaan, maar de adellijke of het 
  predicaat is niet gewijzigd, dan worden titel of predicaat en de aanspreekvorm geleverd die horen bij het geslacht.


  Regel: De adellijke titel of het predicaat en de aanspreekvorm worden opgenomen in de vorm die hoort bij het geslacht van de persoon:
      | adellijke titel/predicaat | geslacht | titel/predicaat bij geslacht | aanspreekvorm            |
      | JH                        | M        | jonkheer                     | De hoogwelgeboren heer   |
      | JH                        | V        | jonkvrouw                    | De hoogwelgeboren vrouwe |
      | JV                        | M        | jonkheer                     | De hoogwelgeboren heer   |
      | JV                        | V        | jonkvrouw                    | De hoogwelgeboren vrouwe |
      | R                         | M        | ridder                       | De hoogwelgeboren heer   |
      | B                         | M        | baron                        | De hoogwelgeboren heer   |
      | B                         | V        | barones                      | De hoogwelgeboren vrouwe |
      | BS                        | M        | baron                        | De hoogwelgeboren heer   |
      | BS                        | V        | barones                      | De hoogwelgeboren vrouwe |
      | H                         | M        | hertog                       | De hoogwelgeboren heer   |
      | H                         | V        | hertogin                     | De hoogwelgeboren vrouwe |
      | HI                        | M        | hertog                       | De hoogwelgeboren heer   |
      | HI                        | V        | hertogin                     | De hoogwelgeboren vrouwe |
      | G                         | M        | graaf                        | De hooggeboren heer      |
      | GI                        | V        | gravin                       | De hooggeboren vrouwe    |
      | M                         | M        | markies                      | De hoogwelgeboren heer   |
      | M                         | V        | markiezin                    | De hoogwelgeboren vrouwe |
      | MI                        | M        | markies                      | De hoogwelgeboren heer   |
      | MI                        | V        | markiezin                    | De hoogwelgeboren vrouwe |
      | P                         | M        | prins                        | De hoogheid              |
      | P                         | V        | prinses                      | De hoogheid              |
      | P                         | O        |                              | De hoogheid              |
      | PS                        | M        | prins                        | De hoogheid              |
      | PS                        | V        | prinses                      | De hoogheid              |
      | PS                        | O        |                              | De hoogheid              |

    Wanneer er bij het geslacht geen juiste vorm is van titel of predicaat die hoort bij het geslacht, dan wordt de titel of predicaat niet gebruikt in de naam in aanschrijfwijze.
    Wanneer er bij het geslacht geen juiste vorm is van de aanspreekvorm die hoort bij het geslacht, dan wordt de aanspreekvorm niet opgenomen in aanschrijfwijze.

    Abstract Scenario: Adellijke titel of predicaat "<titel predicaat>" en geslacht "<geslacht>"  
      Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende gegevens
      | naam                                 | waarde            |
      | geslachtsaanduiding (04.10)          | <geslacht>        |
      | voornamen (02.10)                    | Anne              |
      | adellijke titel of predicaat (02.20) | <titel predicaat> |
      | voorvoegsel (02.30)                  | van den           |
      | geslachtsnaam (02.40)                | Aedel             |
      | aanduiding naamgebruik (61.10)       | E                 |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000115                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                    |
      | aanschrijfwijze.naam          | <naam in aanschrijfwijze> |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>           |

      Voorbeelden:
      | titel predicaat | geslacht | naam in aanschrijfwijze    | aanspreekvorm            |
      | JH              | M        | Jonkheer A. van den Aedel  | De hoogwelgeboren heer   |
      | JH              | V        | Jonkvrouw A. van den Aedel | De hoogwelgeboren vrouwe |
      | JV              | M        | Jonkheer A. van den Aedel  | De hoogwelgeboren heer   |
      | JV              | V        | Jonkvrouw A. van den Aedel | De hoogwelgeboren vrouwe |
      | R               | M        | A. ridder van den Aedel    | De hoogwelgeboren heer   |
      | G               | V        | A. gravin van den Aedel    | De hooggeboren vrouwe    |
      | GI              | M        | A. graaf van den Aedel     | De hooggeboren heer      |
      | P               | V        | A. prinses van den Aedel   | De hoogheid              |
      | PS              | M        | A. prins van den Aedel     | De hoogheid              |

    Abstract Scenario: Adellijke titel of predicaat "<titel predicaat>" en geslacht "<geslacht>" voert geen titel en geen aanspreekvorm
      Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende gegevens
      | naam                                 | waarde            |
      | geslachtsaanduiding (04.10)          | <geslacht>        |
      | voornamen (02.10)                    | Anne              |
      | adellijke titel of predicaat (02.20) | <titel predicaat> |
      | voorvoegsel (02.30)                  | van den           |
      | geslachtsnaam (02.40)                | Aedel             |
      | aanduiding naamgebruik (61.10)       | E                 |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000115                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde           |
      | aanschrijfwijze.naam | A. van den Aedel |

      Voorbeelden:
      | titel predicaat | geslacht |
      | JH              | O        |
      | JV              | O        |
      | R               | V        |
      | R               | O        |
      | B               | O        |
      | G               | O        |

    Abstract Scenario: Adellijke titel of predicaat "<titel predicaat>" en geslacht "O" voert geen titel maar wel aanspreekvorm
      Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende gegevens
      | naam                                 | waarde            |
      | geslachtsaanduiding (04.10)          | O                 |
      | voornamen (02.10)                    | Anne              |
      | adellijke titel of predicaat (02.20) | <titel predicaat> |
      | voorvoegsel (02.30)                  | van den           |
      | geslachtsnaam (02.40)                | Aedel             |
      | aanduiding naamgebruik (61.10)       | E                 |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000115                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde           |
      | aanschrijfwijze.naam          | A. van den Aedel |
      | aanschrijfwijze.aanspreekvorm | De hoogheid      |

      Voorbeelden:
      | titel predicaat |
      | P               |
      | PS              |
