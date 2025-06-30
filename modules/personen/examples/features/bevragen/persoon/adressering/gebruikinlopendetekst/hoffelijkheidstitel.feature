# language: nl

Functionaliteit: Naamgebruik in een lopende tekst voor een persoon met een partner met adellijke titel
  De gebruikInLopendeTekst bij een persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen benoemen.

  De gebruikInLopendeTekst kan worden gebruikt in bijvoorbeeld een zin in een brief als "In uw brief van 12 mei jongstleden, geeft u het overlijden van uw vader, de heer In het Veld, aan.", waarbij "de heer In het Veld" gehaald is uit attribuut gebruikInLopendeTekst.

  # In onderstaande tabellen betekenen de afkortingen:
  # GA = "mevrouw", "de heer" of de voorletters
  # VL = voorletters
  # VV = voorvoegselGeslachtsnaam
  # GN = geslachtsnaam
  # VP = voorvoegselGeslachtsnaam partner
  # GP = geslachtsnaam partner
  # AT = adelijke titel
  # PR = predicaat
  # HT = hoffelijkheidstitel of 'titre de courtoisie'

Regel: een vrouw met een (ex)partner met een adellijke titel krijgt een hoffelijkheidstitel ('titre de courtoisie') in gebruikInLopendeTekst, waarbij geldt dat:
  - gebruikInLopendeTekst wordt samengesteld uit naamcomponenten van de persoon en eventuele (ex)partner op basis van de aanduidingNaamgebruik:
    | aanduidingNaamgebruik | gebruikinlopendetekst |
    | E                     | PR AT VV GN           |
    | P                     | HT VP GP              |
    | V                     | HT VP GP-PR AT VV GN  |
    | N                     | PR AT VV GN-HT VP GP  |
  - de hoffelijkheidstitel ('titre de courtoisie') wordt bepaald op basis van de adellijke titel van de (ex)partner:
    | adellijkeTitelPredicaat partner | hoffelijkheidstitel |
    | G                               | gravin              |
    | B                               | barones             |
    | H                               | hertogin            |
    | M                               | markiezin           |
    | P                               | prinses             |
  - voor het opnemen van de eigen adellijke titel of predicaat en de overige naamcomponenten gelden dezelfde regels als wanneer ze geen partner met adellijke titel zou hebben
  - de adellijke titel van de (ex)partner alleen wordt gebruikt onder de volgende condities:
    - de (ex)partner heeft een adellijke titel (geen predicaat)
    - het geslacht van de persoon is "V"
    - de persoon gebruikt de naam van haar (ex)partner (aanduidingNaamgebruik is ongelijk aan "E")
    - de adellijke titel van de (ex)partner heeft een hoffelijkheidstitel (komt voor in bovenstaande tabel)

  Abstract Scenario: partner met adellijke titel "<adellijkeTitelPredicaat partner>"
    Gegeven de persoon met burgerservicenummer '000000243' heeft de volgende gegevens
      | naam                                 | waarde    |
      | geslachtsaanduiding (04.10)          | V         |
      | voornamen (02.10)                    | Jo        |
      | adellijke titel of predicaat (02.20) |           |
      | voorvoegsel (02.30)                  | de        |
      | geslachtsnaam (02.40)                | Boer      |
      | aanduiding naamgebruik (61.10)       | V         |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde                            |
      | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat partner> |
      | voorvoegsel (02.30)                  | van den                           |
      | geslachtsnaam (02.40)                | Aedel                             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000243                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                  | waarde                  |
      | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

      Voorbeelden:
      | adellijkeTitelPredicaat partner | omschrijving | gebruikInLopendeTekst           |
      | B                               | Baron        | barones van den Aedel-de Boer   |
      | G                               | Graaf        | gravin van den Aedel-de Boer    |
      | H                               | Hertog       | hertogin van den Aedel-de Boer  |
      | M                               | Markies      | markiezin van den Aedel-de Boer |
      | P                               | Prins        | prinses van den Aedel-de Boer   |
      | R                               | Ridder       | mevrouw Van den Aedel-de Boer   |
      | JH                              | Jonkheer     | mevrouw Van den Aedel-de Boer   |
      | BS                              | Barones      | mevrouw Van den Aedel-de Boer   |

  Abstract Scenario: persoon met geslacht "<geslacht>" en partner met adellijke titel <titel partner>
    Gegeven de persoon met burgerservicenummer '000000255' heeft de volgende gegevens
      | naam                                 | waarde     |
      | geslachtsaanduiding (04.10)          | <geslacht> |
      | voornamen (02.10)                    | Jo         |
      | adellijke titel of predicaat (02.20) |            |
      | voorvoegsel (02.30)                  | de         |
      | geslachtsnaam (02.40)                | Boer       |
      | aanduiding naamgebruik (61.10)       | P          |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde          |
      | adellijke titel of predicaat (02.20) | <titel partner> |
      | voorvoegsel (02.30)                  | van den         |
      | geslachtsnaam (02.40)                | Aedel           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000255                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                  | waarde                  |
      | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

      Voorbeelden:
      | geslacht | titel partner | gebruikInLopendeTekst |
      | V        | B             | barones van den Aedel |
      | V        | BS            | mevrouw Van den Aedel |
      | M        | B             | de heer Van den Aedel |
      | M        | BS            | de heer Van den Aedel |
      | O        | B             | J. van den Aedel      |
      | O        | BS            | J. van den Aedel      |

  Abstract Scenario: adellijke titel van partner bij aanduiding naamgebruik "<naamgebruik>"
    Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | V             |
      | voornamen (02.10)                    | Jo            |
      | adellijke titel of predicaat (02.20) |               |
      | voorvoegsel (02.30)                  | de            |
      | geslachtsnaam (02.40)                | Boer          |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde  |
      | adellijke titel of predicaat (02.20) | B       |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000267                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                  | waarde                  |
      | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

      Voorbeelden:
      | naamgebruik | gebruikInLopendeTekst                 |
      | E           | mevrouw De Boer                       |
      | P           | barones van den Aedel                 |
      | V           | barones van den Aedel-de Boer         |
      | N           | mevrouw De Boer-barones van den Aedel |

  Abstract Scenario: persoon en partner hebben beide een adellijke titel bij aanduiding naamgebruik "<naamgebruik>"
    Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04.10)          | V             |
      | voornamen (02.10)                    | Jo            |
      | adellijke titel of predicaat (02.20) | BS            |
      | voorvoegsel (02.30)                  | de            |
      | geslachtsnaam (02.40)                | Boer          |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde  |
      | geslachtsaanduiding (04.10)          | M       |
      | adellijke titel of predicaat (02.20) | G       |
      | voorvoegsel (02.30)                  | van den |
      | geslachtsnaam (02.40)                | Aedel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000279                         |
      | fields              | adressering.gebruikInLopendeTekst |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                  | waarde                  |
      | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

      Voorbeelden:
      | naamgebruik | gebruikInLopendeTekst                |
      | E           | barones de Boer                      |
      | P           | gravin van den Aedel                 |
      | V           | gravin van den Aedel-barones de Boer |
      | N           | barones de Boer-gravin van den Aedel |
