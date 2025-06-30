# language: nl

Functionaliteit: Naamgebruik in een lopende tekst voor een persoon zonder adellijke titel
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

  Regel: gebruikInLopendeTekst voor een persoon zonder adellijke titel of predicaat wordt samengesteld afhankelijk van het geslacht en de waarde van aanduidingNaamgebruik, waarbij geldt dat:
    - gebruikInLopendeTekst wordt voorafgegaan door "mevrouw", "de heer" of de voorletters, afhankelijk van het geslacht:
      | geslacht | gebruikInLopendeTekst begint met (GA) |
      | M        | de heer                               |
      | V        | mevrouw                               |
      | O        | VL                                    |
    - gebruikInLopendeTekst wordt samengesteld uit naamcomponenten van de persoon en eventuele (ex)partner op basis van de aanduidingNaamgebruik:
      | aanduidingNaamgebruik | gebruikinlopendetekst |
      | E                     | GA VV GN              |
      | P                     | GA VP GP              |
      | V                     | GA VP GP-VV GN        |
      | N                     | GA VV GN-VP GP        |
    - Als de eerste naamcomponent direct na "mevrouw" of "de heer" begint met een letter, dan wordt die als hoofdletter weergegeven
    - Wanneer een naamcomponent geen of een lege waarde heeft, wordt de overbodige spatie niet opgenomen: niet starten met een spatie, niet eindigen met een spatie, geen dubbele spatie, geen spatie na streepje
    - Aanduiding naamgebruik "E" (eigen naam) wordt gehanteerd voor een persoon die geen actuele en geen ontbonden huwelijken/partnerschappen heeft gehad

    Abstract Scenario: gebruikInLopendeTekst bij geslacht <voorbeeld>
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens
        | naam                                 | waarde     |
        | geslachtsaanduiding (04.10)          | <geslacht> |
        | voornamen (02.10)                    | Jo Rene    |
        | adellijke titel of predicaat (02.20) |            |
        | voorvoegsel (02.30)                  |            |
        | geslachtsnaam (02.40)                | Groenen    |
        | aanduiding naamgebruik (61.10)       | E          |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000139                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde                  |
        | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

        Voorbeelden:
        | voorbeeld | geslacht | gebruikInLopendeTekst |
        | man       | M        | de heer Groenen       |
        | vrouw     | V        | mevrouw Groenen       |
        | onbekend  | O        | J.R. Groenen          |

    Abstract Scenario: gebruikInLopendeTekst van een persoon die nooit huwelijk of partnerschap heeft gehad met aanduidingNaamgebruik "<aanduidingNaamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende gegevens
        | naam                                 | waarde                  |
        | geslachtsaanduiding (04.10)          | V                       |
        | adellijke titel of predicaat (02.20) |                         |
        | voorvoegsel (02.30)                  | in het                  |
        | geslachtsnaam (02.40)                | Veld                    |
        | aanduiding naamgebruik (61.10)       | <aanduidingNaamgebruik> |
        En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000140                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde              |
        | gebruikInLopendeTekst | mevrouw In het Veld |

        Voorbeelden:
        | aanduidingNaamgebruik |
        | E                     |
        | P                     |
        | V                     |
        | N                     |

    Abstract Scenario: naamsamenstelling van een persoon met een partner bij aanduidingNaamgebruik "<naamgebruik>"
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
        | naam                                 | waarde          |
        | geslachtsaanduiding (04.10)          | V               |
        | adellijke titel of predicaat (02.20) |                 |
        | voorvoegsel (02.30)                  | <voorvoegsel>   |
        | geslachtsnaam (02.40)                | <geslachtsnaam> |
        | aanduiding naamgebruik (61.10)       | <naamgebruik>   |
        En de persoon heeft een 'partner' met de volgende gegevens
        | naam                                 | waarde                  |
        | adellijke titel of predicaat (02.20) |                         |
        | voorvoegsel (02.30)                  | <partner voorvoegsel>   |
        | geslachtsnaam (02.40)                | <partner geslachtsnaam> |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000152                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde                  |
        | gebruikInLopendeTekst | <gebruikinlopendetekst> |

        Voorbeelden:
        | naamgebruik | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | gebruikinlopendetekst          |
        | E           | in het      | Veld          | van                 | Velzen                | mevrouw In het Veld            |
        | E           |             | Groenen       |                     | Groenink              | mevrouw Groenen                |
        | P           | in het      | Veld          | van                 | Velzen                | mevrouw Van Velzen             |
        | P           |             | Groenen       |                     | Groenink              | mevrouw Groenink               |
        | V           | in het      | Veld          | van                 | Velzen                | mevrouw Van Velzen-in het Veld |
        | V           |             | Groenen       |                     | Groenink              | mevrouw Groenink-Groenen       |
        | N           |             | Groenen       |                     | Groenink              | mevrouw Groenen-Groenink       |
        | N           | in het      | Veld          | van                 | Velzen                | mevrouw In het Veld-van Velzen |

    Abstract Scenario: hoofdlettergebruik in voorvoegsels bij aanduidingNaamgebruik "<naamgebruik>", geslacht "<geslacht>" en <voorbeeld>
      Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende gegevens
        | naam                                 | waarde          |
        | geslachtsaanduiding (04.10)          | <geslacht>      |
        | voornamen (02.10)                    | <voornamen>     |
        | adellijke titel of predicaat (02.20) |                 |
        | voorvoegsel (02.30)                  | <voorvoegsel>   |
        | geslachtsnaam (02.40)                | <geslachtsnaam> |
        | aanduiding naamgebruik (61.10)       | <naamgebruik>   |
        En de persoon heeft een 'partner' met de volgende gegevens
        | naam                                 | waarde                  |
        | adellijke titel of predicaat (02.20) |                         |
        | voorvoegsel (02.30)                  | <partner voorvoegsel>   |
        | geslachtsnaam (02.40)                | <partner geslachtsnaam> |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer | 000000164                         |
        | fields              | adressering.gebruikInLopendeTekst |
        Dan heeft de response een persoon met de volgende 'adressering' gegevens
        | naam                  | waarde                  |
        | gebruikInLopendeTekst | <gebruikinlopendetekst> |

        Voorbeelden:
        | voorbeeld                     | geslacht | naamgebruik | voornamen | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | gebruikinlopendetekst                |
        | voorvoegsel in kleine letters | V        | E           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | mevrouw In het Zonnetje              |
        | voorvoegsel in kleine letters | O        | E           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | J.R. in het Zonnetje                 |
        | geen voornamen                | O        | E           |           | in het      | Zonnetje      | 't                  | Wolkje                | In het Zonnetje                      |
        | voorvoegsel met hoofdletters  | V        | E           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | mevrouw Op Den Berghe                |
        | voorvoegsel met hoofdletters  | O        | E           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | J.R. Op Den Berghe                   |
        | voorvoegsel begint met accent | V        | P           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | mevrouw 't Wolkje                    |
        | voorvoegsel met hoofdletters  | V        | P           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | mevrouw Van Der Broeck               |
        | voorvoegsel met hoofdletters  | O        | P           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | J.R. Van Der Broeck                  |
        | voorvoegsel begint met accent | V        | V           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | mevrouw 't Wolkje-in het Zonnetje    |
        | voorvoegsel met hoofdletters  | V        | V           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | mevrouw Van Der Broeck-Op Den Berghe |
        | voorvoegsel met hoofdletters  | O        | V           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | J.R. Van Der Broeck-Op Den Berghe    |
        | voorvoegsel in kleine letters | V        | N           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | mevrouw In het Zonnetje-'t Wolkje    |
        | voorvoegsel met hoofdletters  | M        | N           | Rene Jan  | Op Den      | Berghe        | Van Der             | Broeck                | de heer Op Den Berghe-Van Der Broeck |
        | voorvoegsel met hoofdletters  | O        | N           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | J.R. Op Den Berghe-Van Der Broeck    |
