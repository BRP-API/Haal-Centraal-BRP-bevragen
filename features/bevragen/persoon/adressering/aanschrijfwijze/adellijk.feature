# language: nl

Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  Veld aanschrijfwijze.naam en aanschrijfwijze.aanspreekvorm bij een persoon worden gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven.
  
  De aanschrijfwijze wordt gebruikt als eerste regel(s) in de adressering op een envelop, of links bovenaan een brief, direct boven het adres.

  Bij het samenstellen van aanschrijfwijze wordt de adellijke titel of het predicaat van de persoon gebruikt.

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

  Regel: Voor een persoon met adellijke titel wordt de naam in aanschrijfwijze als volgt samengesteld:
    | aanduiding naamgebruik | omschrijving                 | naam in aanschrijfwijze |
    | E                      | eigen naam                   | VL AT VV GN             |
    | P                      | partner naam                 | VL VP GP                |
    | V                      | partner naam voor eigen naam | VL VP GP-AT VV GN       |
    | N                      | partner naam na eigen naam   | VL AT VV GN-VP GP       |
    
    Betekenis afkortingen in aanschrijfwijze:
      VL = voorletters
      VV = voorvoegselGeslachtsnaam
      GN = geslachtsnaam
      VP = voorvoegselGeslachtsnaam partner
      GP = geslachtsnaam partner
      AT = adelijke titel

    De aanspreekvorm in aanschrijfwijze wordt gevuld op basis van de adellijke titel:
    | adellijke titel/predicaat | aanspreekvorm in aanschrijfwijze |
    | R                         | De hoogwelgeboren heer           |
    | B                         | De hoogwelgeboren heer           |
    | BS                        | De hoogwelgeboren vrouwe         |
    | H                         | De hoogwelgeboren heer           |
    | HI                        | De hoogwelgeboren vrouwe         |
    | G                         | De hooggeboren heer              |
    | GI                        | De hooggeboren vrouwe            |
    | M                         | De hoogwelgeboren heer           |
    | MI                        | De hoogwelgeboren vrouwe         |
    | P                         | De hoogheid                      |
    | PS                        | De hoogheid                      |

    De aanschrijfwijze wordt samengesteld zonder de adellijke titel, zoals beschreven in aanschrijfwijze/niet-adellijk.feature, wanneer:
    - de persoon de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam: aanduidingNaamgebruik is "P"

    Hierbij geldt verder dat:
    - spaties aan het begin of einde van de aanschrijfwijze.naam worden verwijderd
    - dubbele spaties uit de aanschrijfwijze.naam worden verwijderd
    - een spatie vóór of na de "-" uit de aanschrijfwijze.naam worden verwijderd
    - de voorletters worden opgenomen zoals beschreven in voorletters.feature
    - de adellijke titel wordt in kleine letters geschreven
    - de eerste naamcomponent in de aanschrijfwijze.naam begint met een hoofdletter

    Abstract Scenario: Naam zonder voorvoegsel en geen partner
      Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende gegevens
      | naam                                 | waarde      |
      | geslachtsaanduiding (04.10)          | <geslacht>  |
      | voornamen (02.10)                    | <voornamen> |
      | adellijke titel of predicaat (02.20) | <titel>     |
      | geslachtsnaam (02.40)                | Aedel       |
      | aanduiding naamgebruik (61.10)       | E           |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000103                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                    |
      | aanschrijfwijze.naam          | <naam in aanschrijfwijze> |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm>           |

      Voorbeelden:
      | titel | voornamen            | geslacht | naam in aanschrijfwijze | aanspreekvorm            |
      | BS    | Albertine Philippine | V        | A.P. barones Aedel      | De hoogwelgeboren vrouwe |
      | G     | Bølle Ólafur         | M        | B.Ó. graaf Aedel        | De hooggeboren heer      |


    Abstract Scenario: Naam met voorvoegsel en geen partner  
      Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | <geslacht>    |
      | voornamen (02.10)                    | <voornamen>   |
      | adellijke titel of predicaat (02.20) | <titel>       |
      | voorvoegsel (02.30)                  | <voorvoegsel> |
      | geslachtsnaam (02.40)                | Aedel         |
      | aanduiding naamgebruik (61.10)       | E             |
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
      | titel | voornamen     | voorvoegsel | geslacht | naam in aanschrijfwijze | aanspreekvorm          |
      | B     | Arent Binnert | van         | M        | A.B. baron van Aedel    | De hoogwelgeboren heer |
      | GI    | Christina     | In Den      | V        | C. gravin In Den Aedel  | De hooggeboren vrouwe  |
      | H     | Diederik      | 'S          | M        | D. hertog 'S Aedel      | De hoogwelgeboren heer |

    Scenario: persoon met adellijke titel en aanduidingNaamgebruik "P" voert geen titel en geen aanspreekvorm
      Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende gegevens
      | naam                                 | waarde  |
      | geslachtsaanduiding (04.10)          | V       |
      | voornamen (02.10)                    | Jo Anne |
      | adellijke titel of predicaat (02.20) | BS      |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      | aanduiding naamgebruik (61.10)       | P       |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000127                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde       |
      | aanschrijfwijze.naam | J.A. de Boer |

    Abstract Scenario: persoon met adellijke titel heeft aanduidingNaamgebruik "<naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | V             |
      | voornamen (02.10)                    | Jo Anne       |
      | adellijke titel of predicaat (02.20) | BS            |
      | voorvoegsel (02.30)                  | van den       |
      | geslachtsnaam (02.40)                | Aedel         |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000127                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                    |
      | aanschrijfwijze.naam          | <naam in aanschrijfwijze> |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren vrouwe  |

      Voorbeelden:
      | naamgebruik | naam in aanschrijfwijze            |
      | E           | J.A. barones van den Aedel         |
      | V           | J.A. de Boer-barones van den Aedel |
      | N           | J.A. barones van den Aedel-de Boer |


  Regel: Voor een persoon met adellijk predicaat wordt de naam in aanschrijfwijze als volgt samengesteld:
    | aanduiding naamgebruik | omschrijving                 | naam in aanschrijfwijze |
    | E                      | eigen naam                   | PK VL VV GN             |
    | P                      | partner naam                 | VL VP GP                |
    | V                      | partner naam voor eigen naam | VL VP GP-PK VV GN       |
    | N                      | partner naam na eigen naam   | PK VL VV GN-VP GP       |
    
    Betekenis afkortingen in aanschrijfwijze:
      VL = voorletters
      VV = voorvoegselGeslachtsnaam
      GN = geslachtsnaam
      VP = voorvoegselGeslachtsnaam partner
      GP = geslachtsnaam partner
      PK = predicaat

    De aanschrijfwijze wordt samengesteld zonder het predicaat, zoals beschreven in aanschrijfwijze/niet-adellijk.feature, wanneer:
    - de persoon de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam: aanduidingNaamgebruik is "P"
    - de persoon is vrouw (geslacht "V") en heeft een partner (huwelijk of partnerschap is niet beëindigd)
    - de persoon is vrouw (geslacht "V") en gebruikt de naam van de (ex)partner (naamgebruik ongelijk aan "E")

    Hierbij geldt verder dat:
    - spaties aan het begin of einde van de aanschrijfwijze.naam worden verwijderd
    - dubbele spaties uit de aanschrijfwijze.naam worden verwijderd
    - een spatie vóór of na de "-" uit de aanschrijfwijze.naam worden verwijderd
    - de voorletters worden opgenomen zoals beschreven in voorletters.feature
    - het adellijke predicaat wordt in kleine letters geschreven
    - de eerste naamcomponent in de aanschrijfwijze.naam begint met een hoofdletter

    De aanspreekvorm in aanschrijfwijze wordt gevuld op basis van het predicaat:
    | adellijke titel/predicaat | aanspreekvorm in aanschrijfwijze |
    | JH                        | De hoogwelgeboren heer           |
    | JV                        | De hoogwelgeboren vrouwe         |

    Abstract Scenario: Jonkheer met naamgebruik "<aanduiding naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | M             |
      | voornamen (02.10)                    | James Antoine |
      | adellijke titel of predicaat (02.20) | JH            |
      | voorvoegsel (02.30)                  | van den       |
      | geslachtsnaam (02.40)                | Aedel         |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000139                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                    |
      | aanschrijfwijze.naam          | <naam in aanschrijfwijze> |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren heer    |

      Voorbeelden:
      | naamgebruik | naam in aanschrijfwijze             |
      | E           | Jonkheer J.A. van den Aedel         |
      | V           | J.A. de Boer-jonkheer van den Aedel |
      | N           | Jonkheer J.A. van den Aedel-de Boer |

    Scenario: Jonkheer en naamgebruik "P" voert geen predicaat en geen aanspreekvorm
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | M             |
      | voornamen (02.10)                    | James Antoine |
      | adellijke titel of predicaat (02.20) | JH            |
      | voorvoegsel (02.30)                  | van den       |
      | geslachtsnaam (02.40)                | Aedel         |
      | aanduiding naamgebruik (61.10)       | P             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000139                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde       |
      | aanschrijfwijze.naam | J.A. de Boer |

    Abstract Scenario: Jonkvrouw met partner en naamgebruik "<aanduiding naamgebruik>" voert geen predicaat en geen aanspreekvorm
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | V             |
      | voornamen (02.10)                    | Jeanne Anne   |
      | adellijke titel of predicaat (02.20) | JV            |
      | voorvoegsel (02.30)                  | van den       |
      | geslachtsnaam (02.40)                | Aedel         |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000139                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | naam in aanschrijfwijze    |
      | E           | J.A. van den Aedel         |
      | P           | J.A. de Boer               |
      | V           | J.A. de Boer-van den Aedel |
      | N           | J.A. van den Aedel-de Boer |

    Abstract Scenario: Jonkvrouw met ex-partner en naamgebruik "<aanduiding naamgebruik>" voert geen predicaat en geen aanspreekvorm
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | V             |
      | voornamen (02.10)                    | Jeanne Anne   |
      | adellijke titel of predicaat (02.20) | JV            |
      | voorvoegsel (02.30)                  | van den       |
      | geslachtsnaam (02.40)                | Aedel         |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                         | waarde   |
      | voorvoegsel (02.30)                                          | de       |
      | geslachtsnaam (02.40)                                        | Boer     |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20211109 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000139                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | naam in aanschrijfwijze    |
      | P           | J.A. de Boer               |
      | V           | J.A. de Boer-van den Aedel |
      | N           | J.A. van den Aedel-de Boer |

    Scenario: Jonkvrouw met ex-partner en naamgebruik "E" voert weer haar predicaat en aanspreekvorm
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
      | naam                                 | waarde      |
      | geslachtsaanduiding (04.10)          | V           |
      | voornamen (02.10)                    | Jeanne Anne |
      | adellijke titel of predicaat (02.20) | JV          |
      | voorvoegsel (02.30)                  | van den     |
      | geslachtsnaam (02.40)                | Aedel       |
      | aanduiding naamgebruik (61.10)       | E           |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | de     |
      | geslachtsnaam (02.40) | Boer   |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                         | waarde   |
      | voorvoegsel (02.30)                                          | de       |
      | geslachtsnaam (02.40)                                        | Boer     |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20211109 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000139                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                          | waarde                       |
      | aanschrijfwijze.naam          | Jonkvrouw J.A. van den Aedel |
      | aanschrijfwijze.aanspreekvorm | De hoogwelgeboren vrouwe     |
