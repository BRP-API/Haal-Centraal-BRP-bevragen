# language: nl

Functionaliteit: Naamgebruik in een lopende tekst voor een persoon met adellijke titel
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

  Regel: gebruikInLopendeTekst voor een persoon met adellijke titel of predicaat wordt samengesteld afhankelijk van het geslacht en de waarde van aanduidingNaamgebruik, waarbij geldt dat:
    - gebruikInLopendeTekst wordt samengesteld uit naamcomponenten van de persoon en eventuele (ex)partner op basis van de aanduidingNaamgebruik:
      | aanduidingNaamgebruik | gebruikinlopendetekst |
      | E                     | PR AT VV GN           |
      | P                     | GA VP GP              |
      | V                     | GA VP GP-PR AT VV GN  |
      | N                     | PR AT VV GN-VP GP     |
    - De adellijke titel of het predicaat wordt in gebruikInLopendeTekst opgenomen in de vorm die hoort bij het geslacht van de persoon:
      | adellijkeTitelPredicaat | vrouw     | man      | onbekend |
      | G                       | gravin    | graaf    | -        |
      | GI                      | gravin    | graaf    | -        |
      | B                       | barones   | baron    | -        |
      | BS                      | barones   | baron    | -        |
      | H                       | hertogin  | hertog   | -        |
      | HI                      | hertogin  | hertog   | -        |
      | M                       | markiezin | markies  | -        |
      | MI                      | markiezin | markies  | -        |
      | P                       | prinses   | prins    | -        |
      | PS                      | prinses   | prins    | -        |
      | R                       | -         | ridder   | -        |
      | JH                      | jonkvrouw | jonkheer | -        |
      | JV                      | jonkvrouw | jonkheer | -        |
    - Wanneer de adellijke titel of het predicaat geen vorm heeft die hoort bij het geslacht (in bovenstaande tabel opgenomen als - teken), dan wordt deze niet opgenomen
    - Wanneer gebruikInLopendeTekst niet begint met een adellijke titel of een predicaat, wordt deze voorafgegaan door "mevrouw", "de heer" of de voorletters, afhankelijk van het geslacht:
      | geslacht | gebruikInLopendeTekst begint met (GA) |
      | M        | de heer                               |
      | V        | mevrouw                               |
      | O        | VL                                    |
    - Een adellijke titel of predicaat wordt met kleine letters geschreven
    - De eerste naamcomponent direct na "mevrouw" of "de heer" begint met een hoofdletter
    - Wanneer een naamcomponent geen of een lege waarde heeft, wordt de overbodige spatie niet opgenomen: niet starten met een spatie, niet eindigen met een spatie, geen dubbele spatie, geen spatie na streepje

    De gebruikInLopendeTekst wordt op dezelfde manier samengesteld als voor een persoon zonder adellijke titel of predicaat in de volgende gevallen:
    - Wanneer de combinatie van adellijkeTitelPredicaat en geslacht niet voorkomt in bovenstaande tabel: geslacht "O" of een vrouw met de titel "R" (ridder)
    - Wanneer de persoon de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam: aanduidingNaamgebruik is "P"
    - Wanneer de persoon een predicaat heeft en het geslacht is gelijk aan "V" (vrouw) en betrokkene heeft een partner
    - Wanneer de persoon een predicaat heeft en het geslacht is gelijk aan "V" (vrouw) en betrokkene gebruikt de naam van de (ex)partner (aanduidingNaamgebruik is ongelijk aan "E")

    Abstract Scenario: persoon met adellijke titel heeft aanduidingNaamgebruik "<naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende gegevens
        | naam                                 | waarde        |
        | geslachtsaanduiding (04.10)          | V             |
        | voornamen (02.10)                    | Jo Anne       |
        | adellijke titel of predicaat (02.20) | BS            |
        | voorvoegsel (02.30)                  | van den       |
        | geslachtsnaam (02.40)                | Aedel         |
        | aanduiding naamgebruik (61.10)       | <naamgebruik> |
        En de persoon heeft een 'partner' met de volgende gegevens
        | naam                                 | waarde |
        | adellijke titel of predicaat (02.20) |        |
        | voorvoegsel (02.30)                  | de     |
        | geslachtsnaam (02.40)                | Boer   |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000176                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde                  |
        | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

        Voorbeelden:
        | naamgebruik | gebruikInLopendeTekst                 |
        | E           | barones van den Aedel                 |
        | P           | mevrouw De Boer                       |
        | V           | mevrouw De Boer-barones van den Aedel |
        | N           | barones van den Aedel-de Boer         |

    Abstract Scenario: persoon met predicaat en geslacht "<geslacht>" en aanduidingNaamgebruik "<naamgebruik>" heeft een partner
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende gegevens
        | naam                                 | waarde        |
        | geslachtsaanduiding (04.10)          | <geslacht>    |
        | voornamen (02.10)                    | Jo Anne       |
        | adellijke titel of predicaat (02.20) | JV            |
        | voorvoegsel (02.30)                  | van den       |
        | geslachtsnaam (02.40)                | Aedel         |
        | aanduiding naamgebruik (61.10)       | <naamgebruik> |
        En de persoon heeft een 'partner' met de volgende gegevens
        | naam                                 | waarde    |
        | burgerservicenummer (01.20)          | 000000218 |
        | adellijke titel of predicaat (02.20) |           |
        | voorvoegsel (02.30)                  | de        |
        | geslachtsnaam (02.40)                | Boer      |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000188                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde                  |
        | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

        Voorbeelden:
        | geslacht | naamgebruik | gebruikInLopendeTekst                  |
        | M        | E           | jonkheer van den Aedel                 |
        | M        | P           | de heer De Boer                        |
        | M        | V           | de heer De Boer-jonkheer van den Aedel |
        | M        | N           | jonkheer van den Aedel-de Boer         |
        | V        | E           | mevrouw Van den Aedel                  |
        | V        | P           | mevrouw De Boer                        |
        | V        | V           | mevrouw De Boer-van den Aedel          |
        | V        | N           | mevrouw Van den Aedel-de Boer          |

    Abstract Scenario: persoon met predicaat en geslacht "<geslacht>" heeft een ontbonden huwelijk/partnerschap en aanduidingNaamgebruik "<naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000206' heeft de volgende gegevens
        | naam                                 | waarde        |
        | geslachtsaanduiding (04.10)          | <geslacht>    |
        | voornamen (02.10)                    | Jo Anne       |
        | adellijke titel of predicaat (02.20) | JV            |
        | voorvoegsel (02.30)                  | van den       |
        | geslachtsnaam (02.40)                | Aedel         |
        | aanduiding naamgebruik (61.10)       | <naamgebruik> |
        En de persoon heeft geen actuele partner
        En de persoon heeft een 'ex-partner' met de volgende gegevens
        | naam                                                         | waarde    |
        | burgerservicenummer (01.20)                                  | 000000218 |
        | adellijke titel of predicaat (02.20)                         |           |
        | voorvoegsel (02.30)                                          | de        |
        | geslachtsnaam (02.40)                                        | Boer      |
        | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20211109  |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000206                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde                  |
        | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

        Voorbeelden:
        | geslacht | naamgebruik | gebruikInLopendeTekst                  |
        | M        | E           | jonkheer van den Aedel                 |
        | M        | P           | de heer De Boer                        |
        | M        | V           | de heer De Boer-jonkheer van den Aedel |
        | M        | N           | jonkheer van den Aedel-de Boer         |
        | V        | E           | jonkvrouw van den Aedel                |
        | V        | P           | mevrouw De Boer                        |
        | V        | V           | mevrouw De Boer-van den Aedel          |
        | V        | N           | mevrouw Van den Aedel-de Boer          |

    Abstract Scenario: persoon met adellijkeTitelPredicaat "<adellijkeTitelPredicaat>" en geslacht "<geslacht>"
      Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende gegevens
        | naam                                 | waarde                    |
        | geslachtsaanduiding (04.10)          | <geslacht>                |
        | voornamen (02.10)                    | Jo Anne                   |
        | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat> |
        | voorvoegsel (02.30)                  | van den                   |
        | geslachtsnaam (02.40)                | Aedel                     |
        | aanduiding naamgebruik (61.10)       | E                         |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000231                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde                  |
        | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

        Voorbeelden:
        | adellijkeTitelPredicaat | geslacht | gebruikInLopendeTekst   |
        | G                       | M        | graaf van den Aedel     |
        | G                       | V        | gravin van den Aedel    |
        | G                       | O        | J.A. van den Aedel      |
        | JV                      | M        | jonkheer van den Aedel  |
        | JV                      | V        | jonkvrouw van den Aedel |
        | JV                      | O        | J.A. van den Aedel      |
        | R                       | M        | ridder van den Aedel    |
        | R                       | V        | mevrouw Van den Aedel   |
        | R                       | O        | J.A. van den Aedel      |
