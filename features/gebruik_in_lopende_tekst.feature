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

  Abstract Scenario: persoon met adellijke titel heeft aanduidingNaamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | V          |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde                    |
    | voornamen (02.10)                    | Jo Anne                   |
    | adellijke titel of predikaat (02.20) | BI                        |
    | voorvoegsel (02.30)                  | van den                   |
    | geslachtsnaam (02.40)                | Aedel                     |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik>             |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

    Voorbeelden:
    | naamgebruik | gebruikInLopendeTekst                 |
    | E           | barones van den Aedel                 |
    | P           | mevrouw De Boer                       |
    | V           | mevrouw De Boer-barones van den Aedel |
    | N           | barones van den Aedel-de Boer         |

  Abstract Scenario: persoon met predikaat en geslachtsaanduiding "<geslacht>" heeft een partner en aanduidingNaamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde                    |
    | voornamen (02.10)                    | Jo Anne                   |
    | adellijke titel of predikaat (02.20) | JV                        |
    | voorvoegsel (02.30)                  | van den                   |
    | geslachtsnaam (02.40)                | Aedel                     |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik>             |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde |
    | adellijke titel of predikaat (02.20) |        |
    | voorvoegsel (02.30)                  | de     |
    | geslachtsnaam (02.40)                | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

    Voorbeelden:
    | geslacht | naamgebruik | gebruikInLopendeTekst                   |
    | M        | E           | jonkheer van den Aedel                  |
    | M        | P           | de heer De Boer                         |
    | M        | V           | de heer De Boer-jonkheer van den Aedel  |
    | M        | N           | jonkheer van den Aedel-de Boer          |
    | V        | E           | mevrouw van den Aedel                   |
    | V        | P           | mevrouw De Boer                         |
    | V        | V           | mevrouw De Boer-van den Aedel           |
    | V        | N           | mevrouw Van den Aedel-de Boer           |

  Abstract Scenario: persoon met predikaat en geslachtsaanduiding "<geslacht>" heeft een ontbonden huwelijk/partnerschap en aanduidingNaamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde                    |
    | voornamen (02.10)                    | Jo Anne                   |
    | adellijke titel of predikaat (02.20) | JV                        |
    | voorvoegsel (02.30)                  | van den                   |
    | geslachtsnaam (02.40)                | Aedel                     |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik>             |
    En de persoon heeft geen actuele partner
    En de ex-partner heeft de volgende naam gegevens
    | naam                                 | waarde |
    | adellijke titel of predikaat (02.20) |        |
    | voorvoegsel (02.30)                  | de     |
    | geslachtsnaam (02.40)                | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

    Voorbeelden:
    | geslacht | naamgebruik | gebruikInLopendeTekst                   |
    | M        | E           | jonkheer van den Aedel                  |
    | M        | P           | de heer De Boer                         |
    | M        | V           | de heer De Boer-jonkheer van den Aedel  |
    | M        | N           | jonkheer van den Aedel-de Boer          |
    | V        | E           | jonkvrouw van den Aedel                 |
    | V        | P           | mevrouw De Boer                         |
    | V        | V           | mevrouw De Boer-van den Aedel           |
    | V        | N           | mevrouw Van den Aedel-de Boer           |

  Abstract Scenario: persoon met adellijkeTitelPredikaat "<adellijkeTitelPredikaat>" en geslachtsaanduiding "<geslacht>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde                    |
    | voornamen (02.10)                    | Jo Anne                   |
    | adellijke titel of predikaat (02.20) | JV                        |
    | voorvoegsel (02.30)                  | van den                   |
    | geslachtsnaam (02.40)                | Aedel                     |
    | aanduidingNaamgebruik (61.10)        | E                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

    Voorbeelden:
    | adellijkeTitelPredikaat | geslacht | gebruikInLopendeTekst   |
    | G                       | M        | graaf van den Aedel     |
    | G                       | V        | gravin van den Aedel    |
    | G                       | O        | J.A. van den Aedel      |
    | JV                      | M        | jonkheer van den Aedel  |
    | JV                      | V        | jonkvrouw van den Aedel |
    | JV                      | O        | J.A. van den Aedel      |
    | R                       | M        | ridder van den Aedel    |
    | R                       | V        | mevrouw Van den Aedel   |
    | R                       | O        | J.A. van den Aedel      |


Rule: een vrouw met een (ex)partner met een adellijke titel mag deze adellijke titel gebruiken in gebruikInLopendeTekst, waarbij geldt dat:
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
  - voor het opnemen van de eigen adellijke titel of predikaat en de overige naamcomponenten van de persoon gelden dezelfde regels als wanneer ze geen partner met adellijke titel zou hebben
  - de adellijke titel van de (ex) partner alleen wordt gebruikt onder de volgende condities:
    - de (ex)partner heeft een adellijke titel (geen predikaat)
    - de geslachtsaanduiding van de persoon is "V"
    - de geslachtsaanduiding van de partner is "M"
    - de persoon gebruikt de naam van haar (ex)partner (aanduidingNaamgebruik is ongelijk aan "E")
    - de adellijke titel van de (ex)partner heeft een vrouwelijke vorm (in bovenstaande tabel geen - teken)
  
  Abstract Scenario: partner met adellijke titel "<omschrijving>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | V          |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Jo            |
    | adellijke titel of predikaat (02.20) |               |
    | voorvoegsel (02.30)                  | de            |
    | geslachtsnaam (02.40)                | Boer          |
    | aanduidingNaamgebruik (61.10)        | V             |
    En de persoon heeft een partner met de volgende gegevens
    | naam                        | waarde    |
    | geslachtsaanduiding (04.10) | M         |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde                            |
    | adellijke titel of predikaat (02.20) | <adellijkeTitelPredikaat partner> |
    | voorvoegsel (02.30)                  | van den                           |
    | geslachtsnaam (02.40)                | Aedel                             |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

    Voorbeelden:
      | adellijkeTitelPredikaat partner | omschrijving | gebruikInLopendeTekst                   |
      | B                               | Baron        | barones van den Aedel-de Boer           |
      | BS                              | Barones      | barones van den Aedel-de Boer           |
      | G                               | Graaf        | gravin barones van den Aedel-de Boer    |
      | GI                              | Gravin       | gravin barones van den Aedel-de Boer    |
      | H                               | Hertog       | hertogin barones van den Aedel-de Boer  |
      | HI                              | Hertogin     | hertogin barones van den Aedel-de Boer  |
      | M                               | Markies      | markiezin barones van den Aedel-de Boer |
      | MI                              | Markiezin    | markiezin barones van den Aedel-de Boer |
      | P                               | Prins        | prinses barones van den Aedel-de Boer   |
      | PS                              | Prinses      | prinses barones van den Aedel-de Boer   |
      | R                               | Ridder       | mevrouw Van den Aedel-de Boer           |
      | JH                              | Jonkheer     | mevrouw Van den Aedel-de Boer           |

  Abstract Scenario: persoon met geslacht "<geslacht>" en partner met geslacht "<geslacht partner>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Jo            |
    | adellijke titel of predikaat (02.20) |               |
    | voorvoegsel (02.30)                  | de            |
    | geslachtsnaam (02.40)                | Boer         |
    | aanduidingNaamgebruik (61.10)        | P             |
    En de persoon heeft een partner met de volgende gegevens
    | naam                        | waarde             |
    | geslachtsaanduiding (04.10) | <geslacht partner> |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde                            |
    | adellijke titel of predikaat (02.20) | B                                 |
    | voorvoegsel (02.30)                  | van den                           |
    | geslachtsnaam (02.40)                | Aedel                             |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

    Voorbeelden:
      | geslacht | geslacht partner | gebruikInLopendeTekst |
      | V        | M                | barones van den Aedel |
      | V        | V                | mevrouw Van den Aedel |
      | V        | O                | J. Van den Aedel      |
      | V        |                  | J. Van den Aedel      |
      | M        | V                | de heer Van den Aedel |
      | M        | M                | de heer Van den Aedel |
      | M        | O                | J. Van den Aedel      |
      | M        |                  | J. Van den Aedel      |
      | O        | M                | de heer Van den Aedel |
      | O        | V                | de heer Van den Aedel |
      | O        | O                | J. Van den Aedel      |
      | O        |                  | J. Van den Aedel      |

  Abstract Scenario: adellijke titel van partner bij aanduiding naamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | V          |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Jo            |
    | adellijke titel of predikaat (02.20) |               |
    | voorvoegsel (02.30)                  | de            |
    | geslachtsnaam (02.40)                | Boer          |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik> |
    En de persoon heeft een partner met de volgende gegevens
    | naam                        | waarde    |
    | geslachtsaanduiding (04.10) | M         |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde                            |
    | adellijke titel of predikaat (02.20) | B                                 |
    | voorvoegsel (02.30)                  | van den                           |
    | geslachtsnaam (02.40)                | Aedel                             |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

    Voorbeelden:
      | naamgebruik | gebruikInLopendeTekst                 |
      | E           | mevrouw De Boer                       |
      | P           | barones van den Aedel                 |
      | V           | barones van den Aedel-de Boer         |
      | N           | mevrouw De Boer-barones van den Aedel |

  Abstract Scenario: persoon en partner hebben beide een adellijke titel bij aanduiding naamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | V          |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Jo            |
    | adellijke titel of predikaat (02.20) | BS            |
    | voorvoegsel (02.30)                  | de            |
    | geslachtsnaam (02.40)                | Boer          |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik> |
    En de persoon heeft een partner met de volgende gegevens
    | naam                        | waarde    |
    | geslachtsaanduiding (04.10) | M         |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde  |
    | adellijke titel of predikaat (02.20) | G       |
    | voorvoegsel (02.30)                  | van den |
    | geslachtsnaam (02.40)                | Aedel   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde                  |
    | gebruikInLopendeTekst | <gebruikInLopendeTekst> |

    Voorbeelden:
      | naamgebruik | gebruikInLopendeTekst                |
      | E           | barones de Boer                      |
      | P           | gravin van den Aedel                 |
      | V           | gravin van den Aedel-barones de Boer |
      | N           | barones de Boer-gravin van den Aedel |

Rule: Bij meerdere actuele (niet ontbonden) huwelijken/partnerschappen worden de naamgegevens van de eerste partner (oudste relatie) gebruikt voor het samenstellen van de gebruikInLopendeTekst

  Scenario: meerdere actuele relaties
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    | geslachtsaanduiding | V         |
    En de persoon heeft de volgende naam gegevens
    | naam                           | waarde             |
    | voorvoegsel (02.30)            |                    |
    | geslachtsnaam (02.40)          | Groen              |
    | voornamen (02.10)              | Ferdinand Cornelis |
    | aanduiding naamgebruik (61.10) | V                  |
    En de persoon heeft een partner met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992935 |
    En de partner heeft de volgende naam gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   |        |
    | geslachtsnaam (02.40) | Geel   |
    En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
    | naam                  | waarde   |
    | datum aangaan (06.10) | 19580401 |
    En de persoon heeft een partner met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992936 |
    En de partner heeft de volgende naam gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   |        |
    | geslachtsnaam (02.40) | Roodt  |
    En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
    | naam                  | waarde   |
    | datum aangaan (06.10) | 19610808 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde             |
    | gebruikInLopendeTekst | mevrouw Geel-Groen |

Rule: Bij meerdere huwelijken/partnerschappen die allen ontbonden zijn, worden de naamgegevens van de laatst ontbonden partner gebruikt voor het samenstellen van de gebruikInLopendeTekst

  Scenario: meerdere ontbonden relaties gebruikt de laatst ontbonden relatie
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    | geslachtsaanduiding | V         |
    En de persoon heeft de volgende naam gegevens
    | naam                           | waarde |
    | voorvoegsel (02.30)            |        |
    | geslachtsnaam (02.40)          | Wit    |
    | voornamen (02.10)              | Jan    |
    | aanduiding naamgebruik (61.10) | V      |
    En de persoon heeft een partner met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992935 |
    En de partner heeft de volgende naam gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   |        |
    | geslachtsnaam (02.40) | Geel   |
    En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
    | naam                     | waarde   |
    | datum aangaan (06.10)    | 19580401 |
    | datum ontbinding (07.10) | 19601001 |
    En de persoon heeft een partner met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992936 |
    En de partner heeft de volgende naam gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   |        |
    | geslachtsnaam (02.40) | Roodt  |
    En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
    | naam                     | waarde   |
    | datum aangaan (06.10)    | 19610422 |
    | datum ontbinding (07.10) | 20061014 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde            |
    | gebruikInLopendeTekst | mevrouw Roodt-Wit |

  Scenario: meerdere ontbonden relaties en oudste relatie is het laatst ontbonden
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    | geslachtsaanduiding | V         |
    En de persoon heeft de volgende naam gegevens
    | naam                           | waarde |
    | voorvoegsel (02.30)            |        |
    | geslachtsnaam (02.40)          | Wit    |
    | voornamen (02.10)              | Jan    |
    | aanduiding naamgebruik (61.10) | V      |
    En de persoon heeft een partner met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992935 |
    En de partner heeft de volgende naam gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   |        |
    | geslachtsnaam (02.40) | Zwart  |
    En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
    | naam                     | waarde   |
    | datum aangaan (06.10)    | 19580401 |
    | datum ontbinding (07.10) | 20061001 |
    En de persoon heeft een partner met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992936 |
    En de partner heeft de volgende naam gegevens
    | naam                  | waarde |
    | voorvoegsel (02.30)   |        |
    | geslachtsnaam (02.40) | Blaauw |
    En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
    | naam                     | waarde   |
    | datum aangaan (06.10)    | 19610422 |
    | datum ontbinding (07.10) | 19831014 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.gebruikInLopendeTekst      |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam                  | waarde            |
    | gebruikInLopendeTekst | mevrouw Zwart-Wit |




