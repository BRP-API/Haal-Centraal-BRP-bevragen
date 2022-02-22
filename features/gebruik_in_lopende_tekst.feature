# language: nl

Functionaliteit: Als gemeente wil ik de juiste en consistent naamgebruik in een lopende tekst
  De gebruikInLopendeTekst bij een persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen benoemen.

  De gebruikInLopendeTekst kan worden gebruikt in bijvoorbeeld een zin in een brief als "In uw brief van 12 mei jongstleden, geeft u het overlijden van uw vader, de heer in het Veld, aan.", waarbij "de heer in het Veld" gehaald is uit attribuut gebruikInLopendeTekst.

  # In onderstaande tabellen betekenen de afkortingen:
  # GA = "mevrouw", "de heer" of de voorletters
  # VL = voorletters
  # VV = voorvoegselGeslachtsnaam
  # GN = geslachtsnaam
  # VP = voorvoegselGeslachtsnaam partner
  # GP = geslachtsnaam partner
  # AT = adelijke titel
  # PK = predikaat

Rule: gebruikInLopendeTekst voor een persoon zonder adellijke titel of predikaat wordt samengesteld afhankelijk van de geslachtsaanduiding en de waarde van aanduidingNaamgebruik, waarbij geldt dat:
  - gebruikInLopendeTekst wordt voorafgegaan door "mevrouw", "de heer" of de voorletters, afhankelijk van de geslachtsaanduiding:
    | geslachtsaanduiding | gebruikInLopendeTekst begint met (GA) |
    | M                   | de heer                               |
    | V                   | mevrouw                               |
    | O                   | VL                                    |
  - gebruikInLopendeTekst wordt samengesteld uit naamcomponenten van de persoon en eventuele (ex)partner op basis van de aanduidingNaamgebruik:
    | aanduidingNaamgebruik | gebruikinlopendetekst |
    | E                     | GA VV GN              |
    | P                     | GA VP GP              |
    | V                     | GA VP GP-VV GN        |
    | N                     | GA VV GN-VP GP        |
  - Een voorvoegsel wordt met kleine letters wordt geschreven
  - De eerste naamcomponent in gebruikInLopendeTekst anders dan "mevrouw" of "de heer" begint met een hoofdletter
  - Wanneer voorletters zijn opgenomen in de gebruikinlopendetekst, het voorvoegsel van de eerste naam in de gebruikinlopendetekst met alleen kleine letters wordt geschreven
  - Wanneer een naamcomponent geen of een lege waarde heeft, wordt de overbodige spatie niet opgenomen: niet starten met een spatie, niet eindigen met een spatie, geen dubbele spatie, geen spatie na streepje

  Abstract Scenario: gebruikInLopendeTekst bij geslachtsaanduiding <voorbeeld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde      |
    | voornamen (02.10)                    | Jo Rene     |
    | adellijke titel of predikaat (02.20) |             |
    | voorvoegsel (02.30)                  |             |
    | geslachtsnaam (02.40)                | Groenen     |
    | aanduidingNaamgebruik (61.10)        | E           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikinlopendetekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikinlopendetekst | <gebruikinlopendetekst> |

    Voorbeelden:
    | voorbeeld | geslacht | gebruikInLopendeTekst |
    | man       | M        | de heer Groenen       |
    | vrouw     | V        | mevrouw Groenen       |
    | onbekend  | O        | J.R. Groenen          |

  Scenario: gebruikInLopendeTekst van een alleenstaande persoon met aanduidingNaamgebruik "E"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    | geslachtsaanduiding | V         |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde |
    | adellijke titel of predikaat (02.20) |        |
    | voorvoegsel (02.30)                  | in het |
    | geslachtsnaam (02.40)                | Veld   |
    | aanduidingNaamgebruik (61.10)        | E      |
    En persoon heeft geen partner
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikinlopendetekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde              |
    | gebruikinlopendetekst | mevrouw In het Veld |

  Abstract Scenario: naamsamenstelling van een persoon met een partner bij aanduidingNaamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    | geslachtsaanduiding | V         |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde          |
    | adellijke titel of predikaat (02.20) |                 |
    | voorvoegsel (02.30)                  | <voorvoegsel>   |
    | geslachtsnaam (02.40)                | <geslachtsnaam> |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik>   |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde                  |
    | adellijke titel of predikaat (02.20) |                         |
    | voorvoegsel (02.30)                  | <partner voorvoegsel>   |
    | geslachtsnaam (02.40)                | <partner geslachtsnaam> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikinlopendetekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikinlopendetekst | <gebruikinlopendetekst> |

    Voorbeelden:
    | naamgebruik | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | gebruikinlopendetekst          |
    | E           | in het      | Veld          | van                 | Velzen                | mevrouw In het Veld            |
    | E           |             | Groenen       |                     | Groenink              | mevrouw Groenen                |
    | P           | in het      | Veld          | van                 | Velzen                | mevrouw Van Velzen             |
    | P           |             | Groenen       |                     | Groenink              | mevrouw Groenen                |
    | V           | in het      | Veld          | van                 | Velzen                | mevrouw Van Velzen-in het Veld |
    | V           |             | Groenen       |                     | Groenink              | mevrouw Groenen-Groenink       |
    | N           | in het      | Veld          | van                 | Velzen                | mevrouw In het Veld-van Velzen |
    | N           |             | Groenen       |                     | Groenink              | mevrouw Groenen-Groenink       |


  Abstract Scenario: hoofdlettergebruik in voorvoegsels bij aanduidingNaamgebruik "<naamgebruik>", geslachtsaanduiding "<geslacht>" en <voorbeeld>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde          |
    | voornamen (02.10)                    | <voornamen>     |
    | adellijke titel of predikaat (02.20) |                 |
    | voorvoegsel (02.30)                  | <voorvoegsel>   |
    | geslachtsnaam (02.40)                | <geslachtsnaam> |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik>   |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde                  |
    | adellijke titel of predikaat (02.20) |                         |
    | voorvoegsel (02.30)                  | <partner voorvoegsel>   |
    | geslachtsnaam (02.40)                | <partner geslachtsnaam> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikinlopendetekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikinlopendetekst | <gebruikinlopendetekst> |

    Voorbeelden:
    | voorbeeld                     | geslacht | naamgebruik | voornamen | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | gebruikinlopendetekst                |
    | voorvoegsel in kleine letters | V        | E           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | mevrouw In het Zonnetje              |
    | voorvoegsel in kleine letters | O        | E           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | J.R. in het Zonnetje                 |
    | geen voornamen                | O        | E           |           | in het      | Zonnetje      | 't                  | Wolkje                | In het Zonnetje                      |
    | voorvoegsel met hoofdletters  | V        | E           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | mevrouw Op den Berghe                |
    | voorvoegsel met hoofdletters  | O        | E           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | J.R. op den Berghe                   |
    | voorvoegsel begint met accent | V        | P           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | mevrouw 't Wolkje                    |
    | voorvoegsel met hoofdletters  | V        | P           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | mevrouw Van der Broeck               |
    | voorvoegsel met hoofdletters  | O        | P           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | J.R. van der Broeck                  |
    | voorvoegsel begint met accent | V        | V           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | mevrouw 't Wolkje-in het Zonnetje    |
    | voorvoegsel met hoofdletters  | V        | V           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | mevrouw Van der Broeck-op den Berghe |
    | voorvoegsel met hoofdletters  | O        | V           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | J.R. van der Broeck-op den Berghe    |
    | voorvoegsel in kleine letters | V        | N           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | mevrouw In het Zonnetje-'t Wolkje    |
    | voorvoegsel met hoofdletters  | V        | N           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | mevrouw Op den Berghe-van der Broeck |
    | voorvoegsel met hoofdletters  | O        | N           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | J.R. op den Berghe-van der Broeck    |

Rule: gebruikInLopendeTekst voor een persoon met adellijke titel of predikaat wordt samengesteld afhankelijk van de geslachtsaanduiding en de waarde van aanduidingNaamgebruik, waarbij geldt dat:
  - gebruikInLopendeTekst wordt samengesteld uit naamcomponenten van de persoon en eventuele (ex)partner op basis van de aanduidingNaamgebruik:
    | aanduidingNaamgebruik | gebruikinlopendetekst |
    | E                     | PK AT VV GN           |
    | P                     | GA VP GP              |
    | V                     | GA VP GP-PK AT VV GN  |
    | N                     | PK AT VV GN-VP GP     |
  - De adellijke titel of het predikaat wordt in gebruikInLopendeTekst opgenomen in de vorm die hoort bij de geslachtsaanduiding van de persoon:
    | adellijkeTitelPredikaat | vrouw     | man      | onbekend |
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
  - Wanneer de adellijke titel of het predikaat geen vorm heeft die hoort bij de geslachtsaanduiding (in bovenstaande tabel opgenomen als - teken), dan wordt deze niet opgenomen
  - Wanneer gebruikInLopendeTekst niet begint met een adellijke titel of een predikaat, wordt deze voorafgegaan door "mevrouw", "de heer" of de voorletters, afhankelijk van de geslachtsaanduiding:
    | geslachtsaanduiding | gebruikInLopendeTekst begint met (GA) |
    | M                   | de heer                               |
    | V                   | mevrouw                               |
    | O                   | VL                                    |
  - Een voorvoegsel wordt met kleine letters wordt geschreven
  - Een adellijke titel of predikaat wordt met kleine letters wordt geschreven
  - De eerste naamcomponent direct na "mevrouw" of "de heer" begint met een hoofdletter
  - Wanneer een naamcomponent geen of een lege waarde heeft, wordt de overbodige spatie niet opgenomen: niet starten met een spatie, niet eindigen met een spatie, geen dubbele spatie, geen spatie na streepje

  De gebruikInLopendeTekst wordt op dezelfde manier samengesteld als voor een persoon zonder adellijke titel of predikaat in de volgende gevallen:
  - Wanneer de combinatie van adellijkeTitelPredikaat en geslachtsaanduiding niet voorkomt in bovenstaande tabel: geslachtsaanduiding "O" of een vrouw met de titel "R" (ridder)
  - Wanneer de persoon de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam: aanduidingNaamgebruik is "P"
  - Wanneer de persoon een predikaat heeft en de geslachtsaanduiding is gelijk aan "V" (vrouw) en betrokkene heeft een partner
  - Wanneer de persoon een predikaat heeft en de geslachtsaanduiding is gelijk aan "V" (vrouw) en betrokkene gebruikt de naam van de (ex)partner (aanduidingNaamgebruik is ongelijk aan "E")

Rule: gebruikInLopendeTekst voor een vrouw met een (ex)echtgenoot met een adellijke titel mag deze adellijke titel gebruiken, waarbij geldt dat:
  - gebruikInLopendeTekst wordt samengesteld uit naamcomponenten van de persoon en eventuele (ex)partner op basis van de aanduidingNaamgebruik:
    | aanduidingNaamgebruik | gebruikinlopendetekst |
    | E                     | PK AT VV GN           |
    | P                     | AP VP GP              |
    | V                     | AP VP GP-PK AT VV GN  |
    | N                     | PK AT VV GN-AP VP GP  |
  - de adellijke titel van de (ex)partner wordt opgenomen in de vrouwelijke vorm:
    | adellijkeTitelPredikaat partner | vrouwelijke vorm |
    | G                               | gravin           |
    | GI                              | gravin           |
    | B                               | barones          |
    | BS                              | barones          |
    | H                               | hertogin         |
    | HI                              | hertogin         |
    | M                               | markiezin        |
    | MI                              | markiezin        |
    | P                               | prinses          |
    | PS                              | prinses          |
    | R                               | -                |
    | JH                              | -                |
    | JV                              | -                |
  - voor het opnemen van de eigen adellijke titel of predikaat van de persoon gelden dezelfde regels als wanneer ze geen partner met adellijke titel zou hebben
  - de adellijke titel van de (ex) partner alleen wordt gebruikt onder de volgende condities:
    - de (ex)partner heeft een adellijke titel
    - de geslachtsaanduiding van de persoon is "V"
    - de geslachtsaanduiding van de partner is "M"
    - de persoon gebruikt de naam van haar (ex)partner (aanduidingNaamgebruik is ongelijk aan "E")
    - de adellijke titel van de (ex)partner heeft een vrouwelijke vorm (in bovenstaande tabel geen - teken)
  
Rule: Bij meerdere actuele (niet ontbonden) huwelijken/partnerschappen worden de naamgegevens van de eerste partner (oudste relatie) gebruikt voor het samenstellen van de gebruikInLopendeTekst

Rule: Bij meerdere huwelijken/partnerschappen die allen ontbonden zijn, worden de naamgegevens van de laatst ontbonden partner gebruikt voor het samenstellen van de gebruikInLopendeTekst







  Abstract Scenario: gebruikInLopendeTekst wordt samengesteld op basis van geslachtsaanduiding en naamgegevens van de persoon en de partner
    Als persoon wordt geraadpleegd
    Dan heeft de gevonden ingeschrevenpersoon naam.gebruikInLopendeTekst=<gebruikInLopendeTekst>

    # In onderstaande tabellen betekenen de afkortingen:
    # GA = "mevrouw", "de heer"
    # VL = voorletters
    # VV = voorvoegselGeslachtsnaam
    # GN = geslachtsnaam
    # VP = voorvoegselGeslachtsnaam partner
    # GP = geslachtsnaam partner
    # AT = adelijke titel
    # AP = adellijke titel partner (in andersgeslachtelijke vorm)
    # PK = predikaat

    Voorbeelden: geen adellijke titel of predikaat
      | aanduidingNaamgebruik | geslachtsaanduiding |samenstelling gebruikInLopendeTekst | aanschrijfwijze | gebruikInLopendeTekst |
      | Eigen                 | man                 | GA VV GN        | H. in het Veld            | de heer In het Veld            |
      | Eigen                 | man                 | GA VV GN        | F. Groenen                | de heer Groenen                |
      | Eigen                 | Onbekend            | VL VV GN        | P.T. Groenink             | P.T. Groenink                  |
      | Partner na eigen      | vrouw               | GA VV GN-VP GP  | I. van Velzen-in het Veld | mevrouw Van Velzen-in het Veld |
      | Partner na eigen      | vrouw               | GA VV GN-VP GP  | F. Groenen-Groenink       | mevrouw Groenen-Groenink       |
      | Partner               | vrouw               | GA VP GP        | S. van Velzen             | mevrouw Van Velzen             |
      | Partner               | vrouw               | GA VP GP        | J.F.R. Groenen            | mevrouw Groenen                |
      | Partner               | Onbekend            | VL VP GP        | I. van Velzen             | I. van Velzen                  |
      | Partner voor eigen    | man                 | GA VP GP-VV GN  | F. in het Veld-van Velzen | de heer In het Veld-van Velzen |
      | Partner voor eigen    | man                 | GA VP GP-VV GN  | F. Groenen-Groenink       | de heer Groenen-Groenink       |

    Voorbeelden: voorvoegsels met hoofdletter of kleine letter
      | aanduidingAanschrijving | geslachtsaanduiding | VV     | GN     | VP     | GP     | gebruikInLopendeTekst          |
      | E                       | man                 | In het | Veld   | van    | Velzen | de heer In het Veld            |
      | N                       | vrouw               | van    | Velzen | In het | Veld   | mevrouw Van Velzen-In het Veld |
      | P                       | vrouw               | In het | Veld   | van    | Velzen | mevrouw Van Velzen             |
      | V                       | man                 | van    | Velzen | In het | Veld   | de heer In het Veld-van Velzen |
      | E                       | onbekend            | In het | Veld   |        |        | P. In het Veld                 |
      | E                       | onbekend            | van    | Velzen |        |        | K. van Velzen                  |

    Voorbeelden: adelijke titels
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | geslachtsaanduiding | samenstelling gebruikInLopendeTekst | gebruikInLopendeTekst                        |
      | Baron                    | Eigen                 | man                 | AT VV GN                            | baron Van den Aedel                          |
      | Baron                    | Eigen                 | vrouw               | AT VV GN                            | barones Van den Aedel                        |
      | Baron                    | Eigen                 | Onbekend            | AT VV GN                            | A.C. van den Aedel                           |
      | Barones                  | Partner na eigen      | vrouw               | AT VV GN-VP GP                      | barones Van den Aedel-van der Veen           |
      | Graaf                    | Partner               | man                 | GA VP GP                            | de heer Van der Veen                         |
      | Gravin                   | Partner voor eigen    | vrouw               | GA VP GP-AT VV GN                   | mevrouw Van der Veen-gravin van den Aedel    |
      | Prins                    | Eigen                 | man                 | AT VV GN                            | prins Van Roodt de Wit Blaauw                |
      | Prinses                  | Eigen                 | vrouw               | AT VV GN                            | prinses Van Roodt de Wit Blaauw              |
      | Ridder                   | Eigen                 | man                 | T VV GN                             | ridder Van Hoogh                             |
      | Ridder                   | Eigen                 | vrouw               | T VV GN                             | P.K. van Hoogh                             |

    Voorbeelden: predikaat
      | adellijkeTitel_predikaat | geslachtsaanduiding | aanduidingNaamgebruik | partner | gebruikinlopendetekst                                  |
      | Jonkheer                 | man                 | Eigen                 | Geen    | jonkheer Van Hoogh                      |
      | Jonkheer                 | vrouw               | Eigen                 | Geen    | jonkvrouw Van Hoogh                     |
      | Jonkvrouw                | man                 | Eigen                 | Geen    | jonkheer Van Hoogh                      |
      | Jonkvrouw                | vrouw               | Eigen                 | Geen    | jonkvrouw Van Hoogh                     |
      | Jonkheer                 | onbekend            | Eigen                 | Geen    | L.C. van Hoogh                          |
      | Jonkheer                 | man                 | Eigen                 | Ja      | jonkheer Van Hoogh                      |
      | Jonkvrouw                | vrouw               | Eigen                 | Ja      | jonkvrouw Van Hoogh                     |
      | Jonkvrouw                | vrouw               | Partner na eigen      | Ja      | jonkvrouw Van Hoogh-in het Veld         |
      | Jonkvrouw                | vrouw               | Partner               | Ja      | mevrouw In het Veld                     |
      | Jonkvrouw                | vrouw               | Partner voor eigen    | Ja      | mevrouw In het Veld-jonkvrouw van Hoogh |

    Voorbeelden: partner heeft adelijke titel of predikaat
      | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingNaamgebruik | aanschrijfwijze | gebruikInLopendeTekst |
      | vrouw    | man      | Baron    | Eigen                 | A.C. van der Veen                       | mevrouw Van der Veen                       |
      | vrouw    | man      | Baron    | Partner na eigen      | A.C. van der Veen-barones van den Aedel | mevrouw Van der Veen-barones van den Aedel |
      | vrouw    | man      | Baron    | Partner               | A.C. barones van den Aedel              | barones Van den Aedel                      |
      | vrouw    | man      | Baron    | Partner voor eigen    | A.C. barones van den Aedel-van der Veen | barones Van den Aedel-van der Veen         |
      | man      | vrouw    | Gravin   | Eigen                 | W. van der Veen                         | de heer Van der Veen                       |
      | man      | vrouw    | Gravin   | Partner na eigen      | W. van der Veen-graaf van den Aedel     | de heer Van der Veen-van den Aedel         |
      | man      | vrouw    | Gravin   | Partner               | W. graaf van den Aedel                  | de heer Van den Aedel                      |
      | man      | vrouw    | Gravin   | Partner voor eigen    | W. graaf van den Aedel-van der Veen     | de heer Van den Aedel-van der Veen         |
      | man      | man      | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | de heer Van der Veen-van den Aedel         |
      | onbekend | man      | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | W. van der Veen-van den Aedel              |
      | vrouw    | onbekend | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | mevrouw Van der Veen-van den Aedel            |
      | vrouw    | vrouw    | Barones  | Partner na eigen      | W. van der Veen-van den Aedel           | mevrouw Van der Veen-van den Aedel         |
      | vrouw    | man      | Ridder   | Partner na eigen      | W. van der Veen-van den Aedel           | mevrouw Van der Veen-van den Aedel         |
      | vrouw    | man      | Jonkheer | Eigen                 | A.C. van der Veen                       | mevrouw Van der Veen                       |
      | vrouw    | man      | Jonkheer | Partner na eigen      | A.C. van der Veen-van den Aedel         | mevrouw Van der Veen-van den Aedel         |
      | vrouw    | man      | Jonkheer | Partner               | A.C. van den Aedel                      | mevrouw Van den Aedel                      |
      | vrouw    | man      | Jonkheer | Partner voor eigen    | A.C. van den Aedel-van der Veen         | mevrouw Van den Aedel-van der Veen         |

  Scenario: meerdere actuele relaties
    Gegeven de persoon de heer F.C. Groen is getrouwd in 1958 met Geel
    En de persoon is getrouwd in 1961 met Roodt
    En geen van beide relaties is beëindigd
    En de persoon heeft aanduidingAanschrijving='V'
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord naam.gebruikInLopendeTekst=de heer Geel-Groen

  Scenario: meerdere ontbonden relaties
    Gegeven de persoon de heer J. Wit is getrouwd in 1958 met Geel
    En de persoon is getrouwd in 1961 met Roodt
    En het huwelijk met Geel is ontbonden in 1960
    En het huwelijk met Roodt is ontbonden in 2006
    En de persoon heeft aanduidingAanschrijving='V'
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanschrijfwijze=de heer Roodt-Wit

    Gegeven de persoon de heer J. Wit is getrouwd in 1958 met Zwart
    En de persoon is getrouwd in 1961 met Blaauw
    En het huwelijk met Blaauw is ontbonden in 1983
    En het huwelijk met Zwart is ontbonden in 2006
    En de persoon heeft aanduidingAanschrijving='V'
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord naam.gebruikinlopendetekst=de heer Zwart-Wit
