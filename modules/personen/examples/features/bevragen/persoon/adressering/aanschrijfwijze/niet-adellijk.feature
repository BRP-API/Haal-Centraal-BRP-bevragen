# language: nl

Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  Veld aanschrijfwijze.naam en aanschrijfwijze.aanspreekvorm bij een persoon worden gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven.
  
  De aanschrijfwijze wordt gebruikt als eerste regel(s) in de adressering op een envelop, of links bovenaan een brief, direct boven het adres.
  
  Veld aanschrijfwijze.aanspreekvorm wordt alleen gevuld voor personen met een adellijke titel en personen die een hoffelijkheidstitel mogen gebruiken.
  
  Bij het samenstellen van de aanschrijfwijze worden academische titels vooralsnog niet opgenomen. Academische titels zijn geen authentiek gegeven en daarom buiten scope geplaatst.
  

  Bij het samenstellen van aanschrijfwijze wordt in volgorde bepaald:
    1. Of een hoffelijkheidstitel mag worden gebruikt. Dit wordt beschreven in aanschrijfwijze/hoffelijkheidstitel.feature.
    2. Zo niet, of een adellijke titel of predicaat mag worden gebruikt. Dit wordt beschreven in aanschrijfwijze/adellijk.feature.
    3. Zo niet, dan wordt aanschrijfwijze samengesteld zonder adellijke titel of predicaat. Dit wordt beschreven in aanschrijfwijze/niet-adellijk.feature.
  
  Onderstaande regels gelden alleen wanneer GEEN adellijke titel of predicaat, dan wel hoffelijkheidstitel mag worden gebruikt.

  Regel: De naam in aanschrijfwijze wordt op basis van aanduiding naamgebruik als volgt samengesteld:
    | aanduiding naamgebruik | omschrijving                 | naam in aanschrijfwijze |
    | E                      | eigen naam                   | VL VV GN                |
    | P                      | partner naam                 | VL VP GP                |
    | V                      | partner naam voor eigen naam | VL VP GP-VV GN          |
    | N                      | partner naam na eigen naam   | VL VV GN-VP GP          |

    Betekenis afkortingen in aanschrijfwijze:
    VL = voorletters
    VV = voorvoegselGeslachtsnaam
    GN = geslachtsnaam
    VP = voorvoegselGeslachtsnaam partner
    GP = geslachtsnaam partner

    Hierbij geldt verder dat:
    - spaties aan het begin of einde van de aanschrijfwijze.naam worden verwijderd
    - dubbele spaties uit de aanschrijfwijze.naam worden verwijderd
    - een spatie vóór of na de "-" uit de aanschrijfwijze.naam worden verwijderd
    - de voorletters worden opgenomen zoals beschreven in voorletters.feature
    - de eerste naamcomponent in de aanschrijfwijze.naam begint met een hoofdletter

    Scenario: Naam zonder voorvoegsel en geen partner
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                           | waarde    |
      | voornamen (02.10)              | Anna Özil |
      | geslachtsnaam (02.40)          | Groenen   |
      | aanduiding naamgebruik (61.10) | E         |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde       |
      | aanschrijfwijze.naam | A.Ö. Groenen |

    Abstract Scenario: Naam met voorvoegsel en geen partner
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | <voornamen>   |
      | voorvoegsel (02.30)            | <voorvoegsel> |
      | geslachtsnaam (02.40)          | Groenen       |
      | aanduiding naamgebruik (61.10) | E             |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | voornamen      | voorvoegsel | naam in aanschrijfwijze |
      | Bert Philip    | van         | B.P. van Groenen        |
      | Carla Theodora | Van         | C.T. Van Groenen        |
      | Dirk-Willem    | in het      | D. in het Groenen       |
      | Elise Q        | In Den      | E.Q In Den Groenen      |

    Abstract Scenario: Persoon met partner geen voorvoegsel in naam persoon of partner
      Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | <voornamen>              |
      | geslachtsnaam (02.40)          | Groenen                  |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde  |
      | geslachtsnaam (02.40) | Groenlo |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000036                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | voornamen      | aanduiding naamgebruik | naam in aanschrijfwijze |
      | Anna Özil      | E                      | A.Ö. Groenen            |
      | Bert Philip    | P                      | B.P. Groenlo            |
      | Carla Theodora | V                      | C.T. Groenlo-Groenen    |
      | Dirk-Willem    | N                      | D. Groenen-Groenlo      |
      
    Abstract Scenario: Persoon met partner met voorvoegsel in naam persoon en geen voorvoegsel in naam partner
      Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | <voornamen>              |
      | voorvoegsel (02.30)            | van                      |
      | geslachtsnaam (02.40)          | Velzen                   |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde  |
      | geslachtsnaam (02.40) | Groenlo |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | voornamen | aanduiding naamgebruik | naam in aanschrijfwijze |
      | Elise Q   | E                      | E.Q van Velzen          |
      | Fred      | P                      | F. Groenlo              |
      | Geraldine | V                      | G. Groenlo-van Velzen   |
      | Henk      | N                      | H. van Velzen-Groenlo   |
      
    Abstract Scenario: Persoon met partner geen voorvoegsel in naam persoon en wel voorvoegsel in naam partner
      Gegeven de persoon met burgerservicenummer '000000061' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | <voornamen>              |
      | geslachtsnaam (02.40)          | <geslachtsnaam>          |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde                  |
      | voorvoegsel (02.30)   | <voorvoegsel partner>   |
      | geslachtsnaam (02.40) | <geslachtsnaam partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | voornamen | geslachtsnaam | aanduiding naamgebruik | voorvoegsel partner | geslachtsnaam partner | naam in aanschrijfwijze |
      | Iris      | Groenen       | E                      | Van Den             | Berg                  | I. Groenen              |
      | Joris     | Groenen       | P                      | Van Den             | Berg                  | J. Van Den Berg         |
      | Karin     | Groenen       | V                      | Van Den             | Berg                  | K. Van Den Berg-Groenen |
      | Leo       | Groenen       | N                      | Van Den             | Berg                  | L. Groenen-Van Den Berg |
      
    Abstract Scenario: Persoon met partner met voorvoegsel in naam persoon en voorvoegsel in naam partner
      Gegeven de persoon met burgerservicenummer '000000073' heeft de volgende gegevens
      | naam                           | waarde                   |
      | voornamen (02.10)              | <voornamen>              |
      | voorvoegsel (02.30)            | <voorvoegsel>            |
      | geslachtsnaam (02.40)          | <geslachtsnaam>          |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde                  |
      | voorvoegsel (02.30)   | <voorvoegsel partner>   |
      | geslachtsnaam (02.40) | <geslachtsnaam partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000073                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | voornamen | voorvoegsel | geslachtsnaam | aanduiding naamgebruik | voorvoegsel partner | geslachtsnaam partner | naam in aanschrijfwijze    |
      | Marion    | van         | Velzen        | E                      | Van Den             | Berg                  | M. van Velzen              |
      | Nico      | van         | Velzen        | P                      | Van Den             | Berg                  | N. Van Den Berg            |
      | Odette    | van         | Velzen        | V                      | Van Den             | Berg                  | O. Van Den Berg-van Velzen |
      | Piet      | van         | Velzen        | N                      | Van Den             | Berg                  | P. van Velzen-Van Den Berg |

    Abstract Scenario: persoon heeft een naamketen (geen voornamen)
      Gegeven de persoon met burgerservicenummer '000000085' heeft de volgende gegevens
      | naam                           | waarde           |
      | geslachtsnaam (02.40)          | Ali bin Mohammed |
      | aanduiding naamgebruik (61.10) | <naamgebruik>    |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | van    |
      | geslachtsnaam (02.40) | Velzen |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000085                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | naam in aanschrijfwijze     |
      | E           | Ali bin Mohammed            |
      | P           | Van Velzen                  |
      | V           | Van Velzen-Ali bin Mohammed |
      | N           | Ali bin Mohammed-van Velzen |
