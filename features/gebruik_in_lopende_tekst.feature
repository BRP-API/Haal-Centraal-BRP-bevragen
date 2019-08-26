# language: nl

# Issue #334 en #337
Functionaliteit: Als gemeente wil ik de juiste en consistent naamgebruik in een lopende tekst
  Attribuut gebruikInLopendeTekst bij een ingeschreven persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen benoemen.

  Dit attribuut kan worden gebruikt in bijvoorbeeld een zin in een brief als "In uw brief van 12 mei jongstleden, geeft u het overlijden van uw vader, de heer in het Veld, aan.", waarbij "de heer in het Veld" gehaald is uit attribuut gebruikInLopendeTekst.

  Attribuut gebruikInLopendeTekst wordt samengesteld op basis van:
  - voorvoegselGeslachtsnaam
  - geslachtsnaam
  - adellijkeTitel_predikaat
  - aanduidingAanschrijving
  - geslachtsaanduiding
  - voorvoegselGeslachtsnaam partner
  - geslachtsnaam partner
  - adellijkeTitel_predikaat partner
  - geslachtsaanduiding partner

  De waarde van aanduidingNaamgebruik bepaalt hoe de gebruikInLopendeTekst wordt samengesteld uit de naam van de persoon en de naam van de partner.

  Wanneer de eerste naam geen adellijke titel of predicaat heeft, wordt gebruikInLopendeTekst voorafgegaan door een geslachtsaanduiding ("mevrouw", "de heer") plus de samengestelde naam op basis van aanduidingNaamgebruik en de naam van de persoon en de partner.

  Het voorvoegsel van de eerste geslachtsnaam in de samengestelde naam wordt met een hoofdletter geschreven. Het voorvoegsel van de tweede geslachtsnaam wordt met een kleine letter geschreven.

  Op basis van attribuut adellijkeTitel_predikaat wordt het de adelijke titel of het predikaat toegevoegd in gebruikInLopendeTekst.
    Als de betrokkene beschikt over een adellijke titel of predikaat, Dan wordt deze geplaatst vóór het voorvoegsel van de eigen geslachtsnaam.
    Als de betrokkene beschikt over een adellijke titel of predikaat, Dan wordt deze opgenomen zoals genoemd in kolom "Omschrijving" in GBA tabel 38 "Adellijke titel/predikaat", geschreven in kleine letters.
    Als betrokkene zelf beschikt over een adellijke titel, En betrokkene gebruikt de achternaam van de echtgenoot/partner gevolgd door de eigen naam, Dan wordt de titel van betrokkene voor de eigen achternaam en na de achternaam van de partner geplaatst.
    Als betrokkene de achternaam van de echtgenoot/partner gebruikt, Dan wordt het predikaat niet gebruikt.

    Als de echtgenoot/partner beschikt over een predikaat of adellijke titel, Dan wordt bij gebruik van  de achternaam van de echtgenoot/partner het predikaat of de titel van de echtgenoot/partner niet meegenomen.

    Als een vrouw als partner of echtgenoot een man met adellijke titel heeft, En deze adellijke titel heeft een vrouwelijke vorm (zie tabel hieronder), Dan wordt die adellijke titel in vrouwelijke vorm opgenomen wanneer ze de naam van haar partner gebruikt.
    | Titel | Vrouwelijke vorm |
    | Graaf	| gravin           |
    | Baron	| barones          |
    | Prins	| prinses          |

    Als een man als partner of echtgenote een vrouw met adellijke titel heeft, Dan wordt die adellijke titel in mannelijke vorm opgenomen wanneer hij de naam van haar partner gebruikt.
    | Titel   | Mannelijke vorm |
    | Gravin	| graaf           |
    | Barones	| baron           |
    | Prinses	| prins           |

    Als betrokkene en partner hetzelfde geslacht hebben Of de titel van de partner komt niet voor in bovenstaande tabellen (er is geen vrouwelijke vorm van de titel), Dan wordt de adellijke titel van de partner niet opgenomen.

  Wanneer er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn en de aanschijfwijze is ongelijk aan 'Eigen', dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.
  Wanneer er meerdere ontbonden huwelijken/partnerschappen zijn en er geen actueel (niet ontbonden) huwelijk/partnerschap is en de aanschijfwijze is ongelijk aan 'Eigen', wordt als partnernaam de naam van de laatst ontbinden relatie gebruikt.

  Abstract Scenario: gebruikInLopendeTekst wordt samengesteld op basis van geslachtsaanduiding en naamgegevens van de persoon en de partner
    Als ingeschreven persoon wordt geraadpleegd
    Dan heeft de gevonden ingeschrevenpersoon naam.gebruikInLopendeTekst=<gebruikInLopendeTekst>

    # In onderstaande tabellen betekenen de afkortingen:
    # GA = "mevrouw", "de heer"
    # VV = voorvoegselGeslachtsnaam
    # GN = geslachtsnaam
    # VP = voorvoegselGeslachtsnaam partner
    # GP = geslachtsnaam partner
    # AT = adelijke titel
    # AP = adellijke titel partner (in andersgeslachtelijke vorm)
    # PK = predikaat

    Voorbeelden: geen adellijke titel of predikaat
      | aanduidingNaamgebruik | geslachtsaanduiding |samenstelling gebruikInLopendeTekst | aanschrijfwijze | gebruikInLopendeTekst |
      | Eigen                 | Man                 | GA VV GN        | H. in het Veld            | de heer In het Veld            |
      | Eigen                 | Man                 | GA VV GN        | F. Groenen                | de heer Groenen                |
      | Partner na eigen      | Vrouw               | GA VV GN-VP GP  | I. van Velzen-in het Veld | mevrouw Van Velzen-in het Veld |
      | Partner na eigen      | Vrouw               | GA VV GN-VP GP  | F. Groenen-Groenink       | mevrouw Groenen-Groenink       |
      | Partner               | Vrouw               | GA VP GP        | S. van Velzen             | mevrouw Van Velzen             |
      | Partner               | Vrouw               | GA VP GP        | J.F.R. Groenen            | mevrouw Groenen                |
      | Partner voor eigen    | Man                 | GA VP GP-VV GN  | F. in het Veld-van Velzen | de heer In het Veld-van Velzen |
      | Partner voor eigen    | Man                 | GA VP GP-VV GN  | F. Groenen-Groenink       | de heer Groenen-Groenink       |

    Voorbeelden: adelijke titels en predikaat
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | geslachtsaanduiding | samenstelling gebruikInLopendeTekst | aanschrijfwijze              | gebruikInLopendeTekst                        |
      | Baron                    | Eigen                 | Man                 | AT VV GN             | H.W. baron van den Aedel                    | baron Van den Aedel                          |
      | Barones                  | Partner na eigen      | Vrouw               | AT VV GN-VP GP       | W. barones van den Aedel-van der Veen       | barones Van den Aedel-van der Veen           |
      | Graaf                    | Partner               | Man                 | GA VP GP             | F. van der Veen                             | de heer Van der Veen                         |
      | Gravin                   | Partner voor eigen    | Vrouw               | GA VP GP-AT VV GN    | E.L. van der Veen-gravin van den Aedel      | mevrouw Van der Veen-gravin van den Aedel    |
      | Jonkvrouw                | Eigen                 | Man                 | PK VV GN             | jonkvrouw T. van Hoogh                      | jonkvrouw Van Hoogh                          |
      | Jonkvrouw                | Partner na eigen      | Vrouw               | GA VV GN-VP GP       | C. van Hoogh-van der Berg                   | mevrouw Van Hoogh-van der Berg               |
      | Jonkvrouw                | Partner               | Vrouw               | GA VP GP             | C. van der Berg                             | mevrouw Van der Berg                         |
      | Jonkvrouw                | Partner voor eigen    | Vrouw               | GA VP GP-VV GN       | C. van der Berg-van Hoogh                   | mevrouw Van der Berg-van Hoogh               |
      | Prins                    | Eigen                 | Man                 | AT VV GN             | O.B.B. prins van Roodt de Wit Blaauw        | prins Van Roodt de Wit Blaauw                |
      | Prinses                  | Eigen                 | Vrouw               | AT VV GN             | E.M.V. prinses van Roodt de Wit Blaauw      | prinses Van Roodt de Wit Blaauw              |
      | Ridder                   | Eigen                 | Man                 | T VV GN              | M. ridder van Hoogh                         | ridder Van Hoogh                             |

    Voorbeelden: partner heeft adelijke titel of predikaat
      | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingNaamgebruik | aanschrijfwijze | gebruikInLopendeTekst |
      | V | M | Baron    | Eigen                 | A.C. van der Veen                       | mevrouw Van der Veen                       |
      | V | M | Baron    | Partner na eigen      | A.C. van der Veen-barones van den Aedel | mevrouw Van der Veen-barones van den Aedel |
      | V | M | Baron    | Partner               | A.C. barones van den Aedel              | barones Van den Aedel                      |
      | V | M | Baron    | Partner voor eigen    | A.C. barones van den Aedel-van der Veen | barones Van den Aedel-van der Veen         |
      | M | V | Gravin   | Eigen                 | W. van der Veen                         | de heer Van der Veen                       |
      | M | V | Gravin   | Partner na eigen      | W. van der Veen-graaf van den Aedel     | de heer Van der Veen-graaf van den Aedel   |
      | M | V | Gravin   | Partner               | W. graaf van den Aedel                  | graaf Van den Aedel                        |
      | M | V | Gravin   | Partner voor eigen    | W. graaf van den Aedel-van der Veen     | graaf Van den Aedel-van der Veen           |
      | M | M | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | de heer Van der Veen-van den Aedel         |
      | V | M | Ridder   | Partner na eigen      | W. van der Veen-van den Aedel           | mevrouw Van der Veen-van den Aedel         |
      | V | M | Jonkheer | Eigen                 | A.C. van der Veen                       | mevrouw Van der Veen                       |
      | V | M | Jonkheer | Partner na eigen      | A.C. van der Veen-van den Aedel         | mevrouw van der Veen-van den Aedel         |
      | V | M | Jonkheer | Partner               | A.C. van den Aedel                      | mevrouw van den Aedel                      |
      | V | M | Jonkheer | Partner voor eigen    | A.C. van den Aedel-van der Veen         | mevrouw van den Aedel-van der Veen         |
