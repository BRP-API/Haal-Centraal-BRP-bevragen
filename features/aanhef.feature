# language: nl

# Issue #334 en #337
Functionaliteit: Als gemeente wil ik de juiste en consistente briefaanhef in communicatie naar burgers
  De aanhef bij een persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven.
  De aanhef wordt gebruikt bovenaan een brief.

  # In onderstaande tabellen betekenen de afkortingen:
  # GA = "Geachte mevrouw", "Geachte heer", "Geachte" gevolg door voorletters
  # VL = voorletters
  # VV = voorvoegselGeslachtsnaam
  # GN = geslachtsnaam
  # VP = voorvoegselGeslachtsnaam partner
  # GP = geslachtsnaam partner
  # AT = adelijke titel
  # PK = predikaat

Rule: De aanhef voor een persoon zonder adellijke titel of predikaat wordt samengesteld afhankelijk van de geslachtsaanduiding en de waarde van aanduidingNaamgebruik, waarbij geldt dat:
  - De aanhef wordt voorafgegaan door "Geachte" gevolgd door "mevrouw", "heer" of de voorletters, afhankelijk van de geslachtsaanduiding:
    | geslachtsaanduiding | aanhef begint met (GA) |
    | M                   | Geachte heer           |
    | V                   | Geachte mevrouw        |
    | O                   | Geachte VL             |
  - De aanhef wordt samengesteld uit naamcomponenten van de persoon en eventuele (ex)partner op basis van de aanduidingNaamgebruik:
    | aanduidingNaamgebruik | aanhef         |
    | E                     | GA VV GN       |
    | P                     | GA VP GP       |
    | V                     | GA VP GP-VV GN |
    | N                     | GA VV GN-VP GP |
  - Het voorvoegsel van de eerste naam in de aanhef met een hoofdletter wordt geschreven, gevolgd door alleen kleine letters
  - Het voorvoegsel van de (eventuele) tweede naam in de aanhef met kleine letters wordt geschreven
  - Wanneer voorletters zijn opgenomen in de aanhef, het voorvoegsel van de eerste naam in de aanhef met alleen kleine letters wordt geschreven
  - Wanneer een naamcomponent geen of een lege waarde heeft, wordt de overbodige spatie niet opgenomen: niet starten met een spatie, niet eindigen met een spatie, geen dubbele spatie, geen spatie na streepje

  Abstract Scenario: opnemen geslacht na Geachte bij geslachtsaanduiding <voorbeeld>
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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
    | voorbeeld | geslacht | aanhef                  |
    | man       | M        | Geachte heer Groenen    |
    | vrouw     | V        | Geachte mevrouw Groenen |
    | onbekend  | O        | Geachte J.R. Groenen    |

  Scenario: naamsamenstelling van een alleenstaande persoon met aanduidingNaamgebruik "E"
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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde                      |
    | aanhef | Geachte mevrouw In het Veld |

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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
    | naamgebruik | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | aanhef                                 |
    | E           | in het      | Veld          | van                 | Velzen                | Geachte mevrouw In het Veld            |
    | E           |             | Groenen       |                     | Groenink              | Geachte mevrouw Groenen                |
    | P           | in het      | Veld          | van                 | Velzen                | Geachte mevrouw Van Velzen             |
    | P           |             | Groenen       |                     | Groenink              | Geachte mevrouw Groenen                |
    | V           | in het      | Veld          | van                 | Velzen                | Geachte mevrouw Van Velzen-in het Veld |
    | V           |             | Groenen       |                     | Groenink              | Geachte mevrouw Groenen-Groenink       |
    | N           | in het      | Veld          | van                 | Velzen                | Geachte mevrouw In het Veld-van Velzen |
    | N           |             | Groenen       |                     | Groenink              | Geachte mevrouw Groenen-Groenink       |

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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
    | voorbeeld                     | geslacht | naamgebruik | voornamen | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | aanhef                                       |
    | voorvoegsel in kleine letters | V        | E           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte mevrouw In het Zonnetje              |
    | voorvoegsel in kleine letters | O        | E           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte J.R. in het Zonnetje                 |
    | geen voornamen                | O        | E           |           | in het      | Zonnetje      | 't                  | Wolkje                | Geachte In het Zonnetje                      |
    | voorvoegsel met hoofdletters  | V        | E           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte mevrouw Op den Berghe                |
    | voorvoegsel met hoofdletters  | O        | E           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte J.R. op den Berghe                   |
    | voorvoegsel begint met accent | V        | P           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte mevrouw 't Wolkje                    |
    | voorvoegsel met hoofdletters  | V        | P           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte mevrouw Van der Broeck               |
    | voorvoegsel met hoofdletters  | O        | P           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte J.R. van der Broeck                  |
    | voorvoegsel begint met accent | V        | V           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte mevrouw 't Wolkje-in het Zonnetje    |
    | voorvoegsel met hoofdletters  | V        | V           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte mevrouw Van der Broeck-op den Berghe |
    | voorvoegsel met hoofdletters  | O        | V           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte J.R. van der Broeck-op den Berghe    |
    | voorvoegsel in kleine letters | V        | N           | Jo Rene   | in het      | Zonnetje      | 't                  | Wolkje                | Geachte mevrouw In het Zonnetje-'t Wolkje    |
    | voorvoegsel met hoofdletters  | V        | N           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte mevrouw Op den Berghe-van der Broeck |
    | voorvoegsel met hoofdletters  | O        | N           | Jo Rene   | Op Den      | Berghe        | Van Der             | Broeck                | Geachte J.R. op den Berghe-van der Broeck    |

Rule: De aanhef voor een persoon met adellijke titel of predikaat wordt bepaald op basis van adellijkeTitelPredikaat en de geslachtsaanduiding:
  | adellijkeTitelPredikaat | omschrijving | geslachtsaanduiding | Aanhef                |
  | B                       | Baron        | M                   | Hoogwelgeboren heer   |
  | BS                      | Barones      | M                   | Hoogwelgeboren heer   |
  | B                       | Baron        | V                   | Hoogwelgeboren vrouwe |
  | BS                      | Barones      | V                   | Hoogwelgeboren vrouwe |
  | G                       | Graaf        | M                   | Hooggeboren heer      |
  | GI                      | Gravin       | M                   | Hooggeboren heer      |
  | G                       | Graaf        | V                   | Hooggeboren vrouwe    |
  | GI                      | Gravin       | V                   | Hooggeboren vrouwe    |
  | H                       | Hertog       | M                   | Hoogwelgeboren heer   |
  | HI                      | Hertogin     | M                   | Hoogwelgeboren heer   |
  | H                       | Hertog       | V                   | Hoogwelgeboren vrouwe |
  | HI                      | Hertogin     | V                   | Hoogwelgeboren vrouwe |
  | JH                      | Jonkheer     | M                   | Hoogwelgeboren heer   |
  | JV                      | Jonkvrouw    | M                   | Hoogwelgeboren heer   |
  | JH                      | Jonkheer     | V                   | Hoogwelgeboren vrouwe |
  | JV                      | Jonkvrouw    | V                   | Hoogwelgeboren vrouwe |
  | M                       | Markies      | M                   | Hoogwelgeboren heer   |
  | MI                      | Markiezin    | M                   | Hoogwelgeboren heer   |
  | M                       | Markies      | V                   | Hoogwelgeboren vrouwe |
  | MI                      | Markiezin    | V                   | Hoogwelgeboren vrouwe |
  | P                       | Prins        | M                   | Hoogheid              |
  | PS                      | Prinses      | M                   | Hoogheid              |
  | P                       | Prins        | V                   | Hoogheid              |
  | PS                      | Prinses      | V                   | Hoogheid              |
  | P                       | Prins        | O                   | Hoogheid              |
  | PS                      | Prinses      | O                   | Hoogheid              |
  | R                       | Ridder       | M                   | Hoogwelgeboren heer   |
  | R                       | Ridder       | V                   | Hoogwelgeboren vrouwe |

  Of met algoritme:
  - bij een graaf of gravin wordt aanhef "Hooggeboren heer" of "Hooggeboren vrouwe" bij respectievelijk geslachtsaanduiding "M" (man) en "V" (vrouw)
  - bij een prins of prinses wordt aanhef "Hoogheid" bij elke geslachtsaanduiding
  - elke andere adellijke titel of predikaat wordt aanhef "Hoogwelgeboren heer" of "Hoogwelgeboren vrouwe" bij respectievelijk geslachtsaanduiding "M" (man) en "V" (vrouw)

  De aanhef wordt op dezelfde manier samengesteld als voor een persoon zonder adellijke titel of predikaat in de volgende gevallen:
  - Wanneer de combinatie van adellijkeTitelPredikaat en geslachtsaanduiding niet voorkomt in bovenstaande tabel: geslachtsaanduiding "O" en geen prins of prinses
  - Wanneer de persoon de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam: aanduidingNaamgebruik is "P"
  - Wanneer de persoon een predikaat heeft en de geslachtsaanduiding is gelijk aan "V" (vrouw) en betrokkene heeft een partner
  - Wanneer de persoon een predikaat heeft en de geslachtsaanduiding is gelijk aan "V" (vrouw) en betrokkene gebruikt de naam van de (ex)partner (aanduidingNaamgebruik is ongelijk aan "E")

  Abstract Scenario: persoon heeft adellijke titel "<adellijkeTitelPredikaat>" en geslachtsaanduiding "<geslacht>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde                    |
    | voornamen (02.10)                    | Pieter                    |
    | adellijke titel of predikaat (02.20) | <adellijkeTitelPredikaat> |
    | voorvoegsel (02.30)                  | van den                   |
    | geslachtsnaam (02.40)                | Aedel                     |
    | aanduidingNaamgebruik (61.10)        | E                         |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde |
    | adellijke titel of predikaat (02.20) |        |
    | voorvoegsel (02.30)                  | de     |
    | geslachtsnaam (02.40)                | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | adellijkeTitelPredikaat | geslacht | aanhef                    |
      | R                       | M        | Hoogwelgeboren heer       |
      | R                       | V        | Hoogwelgeboren vrouwe     |
      | R                       | O        | Geachte P. van den Aedel  |
      | B                       | M        | Hoogwelgeboren heer       |
      | B                       | V        | Hoogwelgeboren vrouwe     |
      | B                       | O        | Geachte P. van den Aedel  |
      | BS                      | V        | Hoogwelgeboren vrouwe     |
      | BS                      | V        | Hoogwelgeboren vrouwe     |
      | BS                      | O        | Geachte P. van den Aedel  |
      | G                       | M        | Hooggeboren heer          |
      | G                       | V        | Hooggeboren vrouwe        |
      | G                       | O        | Geachte P. van den Aedel  |
      | GI                      | M        | Hooggeboren heer          |
      | GI                      | V        | Hooggeboren vrouwe        |
      | P                       | M        | Hoogheid                  |
      | P                       | V        | Hoogheid                  |
      | P                       | O        | Hoogheid                  |
      | PS                      | M        | Hoogheid                  |
      | PS                      | V        | Hoogheid                  |
      | PS                      | O        | Hoogheid                  |

  Abstract Scenario: persoon heeft adellijke titel "<adellijkeTitelPredikaat>" en naamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde                    |
    | voornamen (02.10)                    | Pieter                    |
    | adellijke titel of predikaat (02.20) | <adellijkeTitelPredikaat> |
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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | adellijkeTitelPredikaat | geslacht | naamgebruik | aanhef                           |
      | BI                      | M        | E           | Hoogwelgeboren heer              |
      | BI                      | M        | V           | Hoogwelgeboren heer              |
      | BI                      | M        | N           | Hoogwelgeboren heer              |
      | BI                      | M        | P           | Geachte heer De Boer             |
      | BI                      | O        | P           | Geachte P. de Boer               |
      | G                       | M        | E           | Hooggeboren heer                 |
      | G                       | M        | V           | Hooggeboren heer                 |
      | G                       | M        | N           | Hooggeboren heer                 |
      | G                       | M        | P           | Geachte heer De Boer             |
      | G                       | O        | E           | Geachte P. van den Aedel         |
      | G                       | O        | V           | Geachte P. de Boer-van den Aedel |
      | G                       | O        | N           | Geachte P. van den Aedel-de Boer |
      | G                       | O        | P           | Geachte P. De Boer               |

  Abstract Scenario: persoon met partner heeft predikaat en geslachtsaanduiding "<geslacht>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Pieter        |
    | adellijke titel of predikaat (02.20) | JV            |
    | voorvoegsel (02.30)                  | van den       |
    | geslachtsnaam (02.40)                | Aedel         |
    | aanduidingNaamgebruik (61.10)        | E             |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde |
    | adellijke titel of predikaat (02.20) |        |
    | voorvoegsel (02.30)                  | de     |
    | geslachtsnaam (02.40)                | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | geslacht | aanhef                        |
      | M        | Hoogwelgeboren heer           |
      | V        | Geachte mevrouw Van den Aedel |
      | O        | Geachte P. van den Aedel      |

  Abstract Scenario: persoon met partner heeft predikaat en naamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | M          |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Pieter        |
    | adellijke titel of predikaat (02.20) | JH            |
    | voorvoegsel (02.30)                  | van den       |
    | geslachtsnaam (02.40)                | Aedel         |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik> |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde |
    | adellijke titel of predikaat (02.20) |        |
    | voorvoegsel (02.30)                  | de     |
    | geslachtsnaam (02.40)                | Boer   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | naamgebruik | aanhef                        |
      | E           | Hoogwelgeboren heer           |
      | P           | Geachte heer De Boer          |
      | V           | Hoogwelgeboren heer           |
      | N           | Hoogwelgeboren heer           |

  Abstract Scenario: persoon heeft predikaat en geslachtsaanduiding "<geslacht>" en naamgebruik "<naamgebruik>" heeft ontbonden huwelijk
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | <geslacht> |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Pieter        |
    | adellijke titel of predikaat (02.20) | JH            |
    | voorvoegsel (02.30)                  | van den       |
    | geslachtsnaam (02.40)                | Aedel         |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik> |
    En de persoon heeft geen actuele partner
    En de ex-partner heeft de volgende naam gegevens
    | naam                                 | waarde |
    | adellijke titel of predikaat (02.20) |        |
    | voorvoegsel (02.30)                  | de     |
    | geslachtsnaam (02.40)                | Boer   |
    En de ex-partner heeft de volgende ontbindingHuwelijkPartnerschap gegevens
    | naam                     | waarde   |
    | datum ontbinding (07.10) | 20211109 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | geslacht | naamgebruik | aanhef                                   |
      | M        | E           | Hoogwelgeboren heer                      |
      | M        | P           | Geachte heer De Boer                     |
      | M        | V           | Hoogwelgeboren heer                      |
      | M        | N           | Hoogwelgeboren heer                      |
      | V        | E           | Hoogwelgeboren vrouwe                    |
      | V        | P           | Geachte mevrouw De Boer                  |
      | V        | V           | Geachte mevrouw De Boer-van den Aedel    |
      | V        | N           | Geachte mevrouw Van den Aedel-de Boer    |
      
Rule: De aanhef voor een persoon wordt bepaald door het adellijkeTitelPredikaat van de (ex)partner onder de volgende condities:
  - de (ex)partner heeft een adellijke titel
  - de geslachtsaanduiding van de persoon is "V"
  - de geslachtsaanduiding van de partner is "M"
  - de persoon gebruikt de naam van haar (ex)partner (aanduidingNaamgebruik is ongelijk aan "E")
  - met de adellijke titel van de (ex)partner mag een hoffelijkheidstitel ('titre de courtoisie') worden gebruikt met bijbehorende aanhef:
      | adellijkeTitelPredikaat partner | hoffelijkheidstitel | aanhef                |
      | B                               | barones             | Hoogwelgeboren vrouwe |
      | G                               | gravin              | Hooggeboren vrouwe    |
      | H                               | hertogin            | Hoogwelgeboren vrouwe |
      | M                               | markiezin           | Hoogwelgeboren vrouwe |
      | P                               | Prins               | Hoogheid              |

  Abstract Scenario: partner heeft adellijke titel "<adellijkeTitelPredikaat partner>"
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
    | aanduidingNaamgebruik (61.10)        | N             |
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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | adellijkeTitelPredikaat partner | aanhef                                |
      | B                               | Hoogwelgeboren vrouwe                 |
      | G                               | Hooggeboren vrouwe                    |
      | H                               | Hoogwelgeboren vrouwe                 |
      | M                               | Hoogwelgeboren vrouwe                 |
      | P                               | Hoogheid                              |
      | R                               | Geachte mevrouw Van den Aedel-de Boer |
      | JH                              | Geachte mevrouw Van den Aedel-de Boer |

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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | geslacht | geslacht partner | aanhef                                |
      | V        | M                | Hoogwelgeboren vrouwe                 |
      | V        | V                | Geachte mevrouw Van den Aedel         |
      | V        | O                | Geachte mevrouw Van den Aedel         |
      | V        |                  | Geachte mevrouw Van den Aedel         |
      | M        | V                | Geachte heer Van den Aedel            |
      | M        | M                | Geachte heer Van den Aedel            |
      | M        | O                | Geachte heer Van den Aedel            |
      | M        |                  | Geachte heer Van den Aedel            |
      | O        | M                | Geachte J. van den Aedel              |
      | O        | V                | Geachte J. van den Aedel              |
      | O        | O                | Geachte J. van den Aedel              |
      | O        |                  | Geachte J. van den Aedel              |

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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | naamgebruik | aanhef                                |
      | E           | Geachte mevrouw De Boer               |
      | P           | Hoogwelgeboren vrouwe                 |
      | V           | Hoogwelgeboren vrouwe                 |
      | N           | Hoogwelgeboren vrouwe                 |

Rule: Voor het bepalen van de aanhef gaat gebruik van de adellijke titel van de partner boven de adellijke titel van de persoon:
  - de persoon heeft een adellijke titel of predikaat
  - de (ex)partner heeft een adellijke titel
  - de geslachtsaanduiding van de persoon is "V" (vrouw)
  - de geslachtsaanduiding van de (ex)partner is "M" (man)
  - de persoon gebruikt de naam van de partner: aanduidingNaamgebruik is ongelijk aan "E"
  - met de adellijke titel van de (ex)partner mag een hoffelijkheidstitel ('titre de courtoisie') worden gebruikt met bijbehorende aanhef

  Wanneer aan al deze condities wordt voldaan, wordt de aanhef samengesteld voor de hoffelijkheidstitel op basis van de adellijke titel van de (ex)partner

  Abstract Scenario: vrouw heeft adellijke titel <adellijkeTitelPredikaat> en haar partner heeft adellijke titel "<adellijkeTitelPredikaat partner>" bij aanduidingNaamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | V          |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Jo            |
    | adellijke titel of predikaat (02.20) |               |
    | voorvoegsel (02.30)                  | van den       |
    | geslachtsnaam (02.40)                | Aedel         |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik> |
    En de persoon heeft een partner met de volgende gegevens
    | naam                        | waarde    |
    | geslachtsaanduiding (04.10) | M         |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde                            |
    | adellijke titel of predikaat (02.20) | <adellijkeTitelPredikaat partner> |
    | voorvoegsel (02.30)                  | de                                |
    | geslachtsnaam (02.40)                | Boer                             |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | adellijkeTitelPredikaat | adellijkeTitelPredikaat partner | naamgebruik | aanhef                                |
      | GI                      | B                               | E           | Hooggeboren vrouwe                    |
      | GI                      | B                               | P           | Hoogwelgeboren vrouwe                 |
      | GI                      | B                               | V           | Hoogwelgeboren vrouwe                 |
      | GI                      | B                               | N           | Hoogwelgeboren vrouwe                 |
      | BS                      | P                               | E           | Hoogwelgeboren vrouwe                 |
      | BS                      | P                               | P           | Hoogheid                              |
      | BS                      | P                               | V           | Hoogheid                              |
      | BS                      | P                               | N           | Hoogheid                              |
      | GI                      | R                               | E           | Hooggeboren vrouwe                    |
      | GI                      | R                               | P           | Geachte mevrouw De Boer               |
      | GI                      | R                               | V           | Hooggeboren vrouwe                    |
      | GI                      | R                               | P           | Hooggeboren vrouwe                    |
      | PS                      | B                               | E           | Hoogheid                              |
      | PS                      | B                               | P           | Hoogwelgeboren vrouwe                 |
      | PS                      | B                               | V           | Hoogwelgeboren vrouwe                 |
      | PS                      | B                               | N           | Hoogwelgeboren vrouwe                 |

  Abstract Scenario: man heeft adellijke titel <adellijkeTitelPredikaat> en zijn partner heeft adellijke titel "<adellijkeTitelPredikaat partner>" bij aanduidingNaamgebruik "<naamgebruik>"
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde     |
    | burgerservicenummer | 999992934  |
    | geslachtsaanduiding | M          |
    En de persoon heeft de volgende naam gegevens
    | naam                                 | waarde        |
    | voornamen (02.10)                    | Jo            |
    | adellijke titel of predikaat (02.20) |               |
    | voorvoegsel (02.30)                  | van den       |
    | geslachtsnaam (02.40)                | Aedel         |
    | aanduidingNaamgebruik (61.10)        | <naamgebruik> |
    En de persoon heeft een partner met de volgende gegevens
    | naam                        | waarde    |
    | geslachtsaanduiding (04.10) | V         |
    En de partner heeft de volgende naam gegevens
    | naam                                 | waarde                            |
    | adellijke titel of predikaat (02.20) | <adellijkeTitelPredikaat partner> |
    | voorvoegsel (02.30)                  | de                                |
    | geslachtsnaam (02.40)                | Boer                             |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde   |
    | aanhef | <aanhef> |

    Voorbeelden:
      | adellijkeTitelPredikaat | adellijkeTitelPredikaat partner | naamgebruik | aanhef               |
      | G                       | BS                              | E           | Hooggeboren heer     |
      | G                       | BS                              | P           | Geachte heer De Boer |
      | G                       | BS                              | V           | Hooggeboren heer     |
      | G                       | BS                              | N           | Hooggeboren heer     |
      | B                       | PS                              | E           | Hoogwelgeboren heer  |
      | B                       | PS                              | P           | Geachte heer De Boer |
      | B                       | PS                              | V           | Hoogwelgeboren heer  |
      | B                       | PS                              | N           | Hoogwelgeboren heer  |

Rule: Bij meerdere actuele (niet ontbonden) huwelijken/partnerschappen worden de naamgegevens van de eerste partner (oudste relatie) gebruikt voor het samenstellen van de aanhef

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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde                     |
    | aanhef | Geachte mevrouw Geel-Groen |

Rule: Bij meerdere huwelijken/partnerschappen die allen ontbonden zijn, worden de naamgegevens van de laatst ontbonden partner gebruikt voor het samenstellen van de aanhef

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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde                    |
    | aanhef | Geachte mevrouw Roodt-Wit |

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
    | fields              | naam.aanhef                     |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
    | naam   | waarde                    |
    | aanhef | Geachte mevrouw Zwart-Wit |
