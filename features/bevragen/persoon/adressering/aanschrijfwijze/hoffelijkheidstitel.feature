# language: nl

Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  Veld aanschrijfwijze.naam en aanschrijfwijze.aanspreekvorm bij een persoon worden gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven.
  
  De aanschrijfwijze wordt gebruikt als eerste regel(s) in de adressering op een envelop, of links bovenaan een brief, direct boven het adres.

  Een vrouw mag de adellijke titel van haar partner voeren. Dit heet een 'hoffelijkheidstitel' of 'titre de courtoisie'.

  Bij het samenstellen van aanschrijfwijze wordt in volgorde bepaald:
  1. Of een hoffelijkheidstitel mag worden gebruikt. Dit wordt beschreven in aanschrijfwijze/hoffelijkheidstitel.feature.
  2. Zo niet, of een adellijke titel of predicaat mag worden gebruikt. Dit wordt beschreven in aanschrijfwijze/adellijk.feature.
  3. Zo niet, dan wordt aanschrijfwijze samengesteld zonder adellijke titel of predicaat. Dit wordt beschreven in aanschrijfwijze/niet-adellijk.feature.

  Achtergrond:
    Gegeven landelijke tabel "Adellijke_Titel_Predicaat" heeft de volgende waarden
    | code | omschrijving | soort     |
    | B    | Baron        | titel     |
    | BS   | Barones      | titel     |
    | G    | Graaf        | titel     |
    | GI   | Gravin       | titel     |
    | H    | Hertog       | titel     |
    | HI   | Hertogin     | titel     |
    | JH   | Jonkheer     | predicaat |
    | JV   | Jonkvrouw    | predicaat |
    | M    | Markies      | titel     |
    | MI   | Markiezin    | titel     |
    | P    | Prins        | titel     |
    | PS   | Prinses      | titel     |
    | R    | Ridder       | titel     |

  Regel: Voor een vrouw zonder adellijke titel of predicaat maar met partner met adellijke titel wordt de naam in aanschrijfwijze als volgt samengesteld:
    | aanduiding naamgebruik | omschrijving                 | naam in aanschrijfwijze |
    | E                      | eigen naam                   | VL VV GN                |
    | P                      | partner naam                 | VL HT VP GP             |
    | V                      | partner naam voor eigen naam | VL HT VP GP-VV GN       |
    | N                      | partner naam na eigen naam   | VL VV GN-HT VP GP       |
    
    Betekenis afkortingen in aanschrijfwijze:
      VL = voorletters
      VV = voorvoegselGeslachtsnaam
      GN = geslachtsnaam
      VP = voorvoegselGeslachtsnaam partner
      GP = geslachtsnaam partner
      HT = hoffelijkheidstitel of 'titre de courtoisie'

    De hoffelijkheidstitel of 'titre de courtoisie' en bijbehorende aanspreekvorm is de vrouwelijke vorm voor de adellijke titel van de partner:
    | adellijke titel (ex)partner | hoffelijkheidstitel | aanspreekvorm            |
    | B                           | barones             | De hoogwelgeboren vrouwe |
    | G                           | gravin              | De hooggeboren vrouwe    |
    | H                           | hertogin            | De hoogwelgeboren vrouwe |
    | M                           | markiezin           | De hoogwelgeboren vrouwe |
    | P                           | prinses             | De hoogheid              |

    De aanschrijfwijze wordt samengesteld zonder de hoffelijkheidstitel, zoals beschreven in aanschrijfwijze/niet-adellijk.feature, wanneer:
    - de persoon de geslachtsnaam van de echtgenoot/partner niet gebruikt: aanduidingNaamgebruik is "E" (eigen naam)
    - het geslacht van de persoon is ongelijk aan "V" (vrouw), dus "M" (man) of "O" (onbekend)
    - er is geen hoffelijkheidstitel voor de adellijke titel van de partner (zie tabel hierboven)

    Hierbij geldt verder dat:
    - spaties aan het begin of einde van de aanschrijfwijze.naam worden verwijderd
    - dubbele spaties uit de aanschrijfwijze.naam worden verwijderd
    - een spatie vóór of na de "-" uit de aanschrijfwijze.naam worden verwijderd
    - de voorletters worden opgenomen zoals beschreven in voorletters.feature
    - de hoffelijkheidstitel wordt in kleine letters geschreven
    - de eerste naamcomponent in de aanschrijfwijze.naam begint met een hoofdletter
      
    Abstract Scenario: Vrouw met adellijke partner en naamgebruik "<naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000206' heeft de volgende gegevens
      | naam                           | waarde        |
      | geslachtsaanduiding (04.10)    | V             |
      | voornamen (02.10)              | Anne-Fleur    |
      | voorvoegsel (02.30)            | de            |
      | geslachtsnaam (02.40)          | Boer          |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde  |
      | adellijke titel of predicaat (02.20) | B       |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000206                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                    |
      | aanschrijfwijze.naam          | <naam in aanschrijfwijze> |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren vrouwe  |

      Voorbeelden:
      | naamgebruik | naam in aanschrijfwijze          |
      | P           | A. barones van den Aedel         |
      | V           | A. barones van den Aedel-de Boer |
      | N           | A. de Boer-barones van den Aedel |

    Scenario: Vrouw met adellijke partner en naamgebruik "E" kan geen hoffelijkheidstitel gebruiken
      Gegeven de persoon met burgerservicenummer '000000206' heeft de volgende gegevens
      | naam                           | waarde     |
      | geslachtsaanduiding (04.10)    | V          |
      | voornamen (02.10)              | Anne-Fleur |
      | voorvoegsel (02.30)            | de         |
      | geslachtsnaam (02.40)          | Boer       |
      | aanduiding naamgebruik (61.10) | E          |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde  |
      | adellijke titel of predicaat (02.20) | B       |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000206                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | A. de Boer |

    Abstract Scenario: Persoon met geslacht <geslacht> met adellijke partner kan geen hoffelijkheidstitel gebruiken
      Gegeven de persoon met burgerservicenummer '000000218' heeft de volgende gegevens
      | naam                           | waarde     |
      | geslachtsaanduiding (04.10)    | <geslacht> |
      | voornamen (02.10)              | John       |
      | voorvoegsel (02.30)            | de         |
      | geslachtsnaam (02.40)          | Boer       |
      | aanduiding naamgebruik (61.10) | P          |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde  |
      | adellijke titel of predicaat (02.20) | B       |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000218                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde           |
      | aanschrijfwijze.naam | J. van den Aedel |

      Voorbeelden:
      | geslacht |
      | M        |
      | O        |

    Abstract Scenario: Vrouw met partner met adellijke titel "<titel partner>"
      Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende gegevens
      | naam                           | waarde     |
      | geslachtsaanduiding (04.10)    | V          |
      | voornamen (02.10)              | Anne-Fleur |
      | voorvoegsel (02.30)            | de         |
      | geslachtsnaam (02.40)          | Boer       |
      | aanduiding naamgebruik (61.10) | P          |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde          |
      | adellijke titel of predicaat (02.20) | <titel partner> |
      | voorvoegsel (02.30)                  | van den         |
      | geslachtsnaam (02.40)                | Aedel           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000231                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                    |
      | aanschrijfwijze.naam          | <naam in aanschrijfwijze> |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>           |

      Voorbeelden:
      | titel partner | naam in aanschrijfwijze    | aanspreekvorm            |
      | B             | A. barones van den Aedel   | De hoogwelgeboren vrouwe |
      | G             | A. gravin van den Aedel    | De hooggeboren vrouwe    |
      | H             | A. hertogin van den Aedel  | De hoogwelgeboren vrouwe |
      | M             | A. markiezin van den Aedel | De hoogwelgeboren vrouwe |
      | P             | A. prinses van den Aedel   | De hoogheid              |

    Abstract Scenario: Vrouw met partner met adellijke titel "<titel partner>" kan geen hoffelijkheidstitel gebruiken
      Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende gegevens
      | naam                           | waarde     |
      | geslachtsaanduiding (04.10)    | V          |
      | voornamen (02.10)              | Anne-Fleur |
      | voorvoegsel (02.30)            | de         |
      | geslachtsnaam (02.40)          | Boer       |
      | aanduiding naamgebruik (61.10) | P          |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde          |
      | adellijke titel of predicaat (02.20) | <titel partner> |
      | voorvoegsel (02.30)                  | van den         |
      | geslachtsnaam (02.40)                | Aedel           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000231                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde           |
      | aanschrijfwijze.naam | A. van den Aedel |

      Voorbeelden:
      | titel partner |
      | BS            |
      | GI            |
      | HI            |
      | JH            |
      | JV            |
      | MI            |
      | PS            |
      | R             |

  Regel: Voor een vrouw met adellijke titel met partner met adellijke titel wordt de naam in aanschrijfwijze als volgt samengesteld:
    | aanduiding naamgebruik | omschrijving                 | naam in aanschrijfwijze |
    | E                      | eigen naam                   | VL AT VV GN             |
    | P                      | partner naam                 | VL HT VP GP             |
    | V                      | partner naam voor eigen naam | VL HT VP GP-AT VV GN    |
    | N                      | partner naam na eigen naam   | VL AT VV GN-HT VP GP    |
    
    Betekenis afkortingen in aanschrijfwijze:
      VL = voorletters
      VV = voorvoegselGeslachtsnaam
      GN = geslachtsnaam
      VP = voorvoegselGeslachtsnaam partner
      GP = geslachtsnaam partner
      HT = hoffelijkheidstitel of 'titre de courtoisie'

    De hoffelijkheidstitel of 'titre de courtoisie' is de vrouwelijke vorm van de adellijke titel van de partner:
    | adellijke titel (ex)partner | hoffelijkheidstitel | aanspreekvorm            |
    | B                           | barones             | De hoogwelgeboren vrouwe |
    | G                           | gravin              | De hooggeboren vrouwe    |
    | H                           | hertogin            | De hoogwelgeboren vrouwe |
    | M                           | markiezin           | De hoogwelgeboren vrouwe |
    | P                           | prinses             | De hoogheid              |

    De aanschrijfwijze wordt samengesteld zonder de hoffelijkheidstitel, zoals beschreven in aanschrijfwijze/adellijk.feature, wanneer:
    - de persoon de geslachtsnaam van de echtgenoot/partner niet gebruikt: aanduidingNaamgebruik is "E" (eigen naam)
    - het geslacht van de persoon is "M" (man)
    - er is geen vrouwelijke vorm voor de adellijke titel van de partner (zie tabel hierboven)

    Hierbij geldt verder dat:
    - spaties aan het begin of einde van de aanschrijfwijze.naam worden verwijderd
    - dubbele spaties uit de aanschrijfwijze.naam worden verwijderd
    - een spatie vóór of na de "-" uit de aanschrijfwijze.naam worden verwijderd
    - de voorletters worden opgenomen zoals beschreven in voorletters.feature
    - de hoffelijkheidstitel wordt in kleine letters geschreven
    - de adellijke titel wordt in kleine letters geschreven
    - de eerste naamcomponent in de aanschrijfwijze.naam begint met een hoofdletter

    Abstract Scenario: Vrouw met adellijke titel en partner met adellijke titel "<titel partner>"
      Gegeven de persoon met burgerservicenummer '000000243' heeft de volgende gegevens
      | naam                                 | waarde      |
      | geslachtsaanduiding (04.10)          | V           |
      | voornamen (02.10)                    | Anne-Fleur  |
      | adellijke titel of predicaat (02.20) | BS          |
      | voorvoegsel (02.30)                  | de          |
      | geslachtsnaam (02.40)                | Bonne Fooie |
      | aanduiding naamgebruik (61.10)       | N           |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde          |
      | adellijke titel of predicaat (02.20) | <titel partner> |
      | voorvoegsel (02.30)                  | van den         |
      | geslachtsnaam (02.40)                | Aedel           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000243                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                    |
      | aanschrijfwijze.naam          | <naam in aanschrijfwijze> |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>           |

      Voorbeelden:
      | titel partner | naam in aanschrijfwijze                           | aanspreekvorm            | omschrijving                          |
      | B             | A. barones de Bonne Fooie-barones van den Aedel   | De hoogwelgeboren vrouwe | aanspreekvorm uit hoffelijkheidstitel |
      | BS            | A. barones de Bonne Fooie-van den Aedel           | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |
      | G             | A. barones de Bonne Fooie-gravin van den Aedel    | De hooggeboren vrouwe    | aanspreekvorm uit hoffelijkheidstitel |
      | GI            | A. barones de Bonne Fooie-van den Aedel           | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |
      | H             | A. barones de Bonne Fooie-hertogin van den Aedel  | De hoogwelgeboren vrouwe | aanspreekvorm uit hoffelijkheidstitel |
      | HI            | A. barones de Bonne Fooie-van den Aedel           | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |
      | JH            | A. barones de Bonne Fooie-van den Aedel           | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |
      | JV            | A. barones de Bonne Fooie-van den Aedel           | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |
      | M             | A. barones de Bonne Fooie-markiezin van den Aedel | De hoogwelgeboren vrouwe | aanspreekvorm uit hoffelijkheidstitel |
      | MI            | A. barones de Bonne Fooie-van den Aedel           | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |
      | P             | A. barones de Bonne Fooie-prinses van den Aedel   | De hoogheid              | aanspreekvorm uit hoffelijkheidstitel |
      | PS            | A. barones de Bonne Fooie-van den Aedel           | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |
      | R             | A. barones de Bonne Fooie-van den Aedel           | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |

    Abstract Scenario: Vrouw met adellijke titel en partner met adellijke titel en naamgebruik "<naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000255' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | V             |
      | voornamen (02.10)                    | Anne-Fleur    |
      | adellijke titel of predicaat (02.20) | BS            |
      | voorvoegsel (02.30)                  | de            |
      | geslachtsnaam (02.40)                | Bonne Fooie   |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde  |
      | adellijke titel of predicaat (02.20) | P       |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000255                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                    |
      | aanschrijfwijze.naam          | <naam in aanschrijfwijze> |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>           |

      Voorbeelden:
      | naamgebruik | naam in aanschrijfwijze                         | aanspreekvorm            | omschrijving                          |
      | E           | A. barones de Bonne Fooie                       | De hoogwelgeboren vrouwe | aanspreekvorm uit eigen titel         |
      | P           | A. prinses van den Aedel                        | De hoogheid              | aanspreekvorm uit hoffelijkheidstitel |
      | V           | A. prinses van den Aedel-barones de Bonne Fooie | De hoogheid              | aanspreekvorm uit hoffelijkheidstitel |
      | N           | A. barones de Bonne Fooie-prinses van den Aedel | De hoogheid              | aanspreekvorm uit hoffelijkheidstitel |
