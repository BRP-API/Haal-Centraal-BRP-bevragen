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

  Als de eerste naam geen adellijke titel of predicaat heeft,
  Dan wordt gebruikInLopendeTekst voorafgegaan door een geslachtsaanduiding ("mevrouw", "de heer") plus de samengestelde naam op basis van aanduidingNaamgebruik en de naam van de persoon en de partner.

  Het voorvoegsel van de eerste geslachtsnaam in de samengestelde naam wordt met een hoofdletter geschreven. Het voorvoegsel van de tweede geslachtsnaam wordt met een kleine letter geschreven.

  Als er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn
  En de aanduiding aanschijving is ongelijk aan 'Eigen',
  Dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.

  Als er meerdere ontbonden huwelijken/partnerschappen zijn
  En er geen actueel (niet ontbonden) huwelijk/partnerschap is
  En de aanduiding aanschijving is ongelijk aan 'Eigen'
  Dan wordt als partnernaam de naam van de laatst ontbinden relatie gebruikt.

  Op basis van attribuut adellijkeTitel_predikaat wordt het de adelijke titel of het predikaat toegevoegd in gebruikInLopendeTekst.
  Als de betrokkene beschikt over een adellijke titel of predikaat
  Dan wordt deze geplaatst vóór het voorvoegsel van de eigen geslachtsnaam.
  Als de betrokkene beschikt over een adellijke titel of predikaat
  Dan wordt deze opgenomen zoals genoemd in kolom "Omschrijving" in GBA tabel 38 "Adellijke titel/predikaat", geschreven in kleine letters.
  Als betrokkene beschikt over een adellijke titel
  En betrokkene gebruikt de achternaam van de echtgenoot/partner in combinatie met de eigen geslachtsnaam
  Dan wordt de titel van betrokkene voor de eigen geslachtsnaam geplaatst.
  Als betrokkene een predikaat heeft (jonkvrouw of jonkheer)
  En betrokkene is getrouwd of geregistreerd partnerschap of is getrouwd geweest of heeft geregistreerd partnerschap gehad
  Dan wordt het predikaat niet gebruikt
  En de persoon wordt dan aangesproken met "mevrouw” of “de heer” gevolgd door de samengestelde naam

  Als een vrouw als partner of echtgenoot een man met adellijke titel heeft,
  En deze adellijke titel heeft een vrouwelijke vorm (zie tabel hieronder),
  Dan wordt die adellijke titel in vrouwelijke vorm opgenomen wanneer ze de naam van haar partner gebruikt.
  | Titel | Vrouwelijke vorm |
  | Graaf	| gravin           |
  | Baron	| barones          |
  | Prins	| prinses          |

  Als een man als partner of echtgenote een vrouw met adellijke titel heeft,
  Dan wordt die adellijke titel in mannelijke vorm opgenomen wanneer hij de naam van zijn partner gebruikt.
  | Titel   | Mannelijke vorm |
  | Gravin	| graaf           |
  | Barones	| baron           |
  | Prinses	| prins           |

  Als betrokkene en partner hetzelfde geslacht hebben Of de titel van de partner komt niet voor in bovenstaande tabellen (er is geen vrouwelijke vorm van de titel),
  Dan wordt de adellijke titel van de partner niet opgenomen.

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

    Voorbeelden: adelijke titels
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | geslachtsaanduiding | samenstelling gebruikInLopendeTekst | aanschrijfwijze              | gebruikInLopendeTekst                        |
      | Baron                    | Eigen                 | Man                 | AT VV GN             | H.W. baron Van den Aedel                    | baron Van den Aedel                          |
      | Barones                  | Partner na eigen      | Vrouw               | AT VV GN-VP GP       | W. barones van den Aedel-van der Veen       | barones Van den Aedel-van der Veen           |
      | Graaf                    | Partner               | Man                 | GA VP GP             | F. van der Veen                             | de heer Van der Veen                         |
      | Gravin                   | Partner voor eigen    | Vrouw               | GA VP GP-AT VV GN    | E.L. van der Veen-gravin van den Aedel      | mevrouw Van der Veen-gravin van den Aedel    |
      | Prins                    | Eigen                 | Man                 | AT VV GN             | O.B.B. prins van Roodt de Wit Blaauw        | prins Van Roodt de Wit Blaauw                |
      | Prinses                  | Eigen                 | Vrouw               | AT VV GN             | E.M.V. prinses van Roodt de Wit Blaauw      | prinses Van Roodt de Wit Blaauw              |
      | Ridder                   | Eigen                 | Man                 | T VV GN              | M. ridder van Hoogh                         | ridder Van Hoogh                             |

    Voorbeelden: predikaat
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | soortVerbintenis | Ontbinding huwelijk/geregistreerd partnerschap | aanhef                        |
      | Jonkheer                 | Eigen                 | Geen             | Geen                                           | jonkheer Van Hoogh            |
      | Jonkvrouw                | Eigen                 | Geen             | Geen                                           | jonkvrouw Van Hoogh           |
      | Jonkheer                 | Eigen                 | Huwelijk         | Niet                                           | de heer Van Hoogh             |
      | Jonkheer                 | Eigen                 | Partnerschap     | Niet                                           | de heer Van Hoogh             |
      | Jonkheer                 | Eigen                 | Huwelijk         | Ja                                             | de heer Van Hoogh             |
      | Jonkvrouw                | Eigen                 | Huwelijk         | Niet                                           | mevrouw Van Hoogh             |
      | Jonkvrouw                | Partner na eigen      | Huwelijk         | Niet                                           | mevrouw Van Hoogh-in het Veld |
      | Jonkvrouw                | Partner               | Huwelijk         | Niet                                           | mevrouw In het Veld           |
      | Jonkvrouw                | Partner voor eigen    | Huwelijk         | Niet                                           | mevrouw In het Veld-van Hoogh |

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

  Scenario: meerdere actuele relaties
    Gegeven de ingeschreven persoon de heer F.C. Groen is getrouwd in 1958 met Geel
    En de ingeschreven persoon is getrouwd in 1961 met Roodt
    En geen van beide relaties is beëindigd
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.gebruikInLopendeTekst=de heer Geel-Groen

  Scenario: meerdere ontbonden relaties
    Gegeven de ingeschreven persoon de heer J. Wit is getrouwd in 1958 met Geel
    En de ingeschreven persoon is getrouwd in 1961 met Roodt
    En het huwelijk met Geel is ontbonden in 1960
    En het huwelijk met Roodt is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanschrijfwijze=de heer Roodt-Wit

    Gegeven de ingeschreven persoon de heer J. Wit is getrouwd in 1958 met Roodt
    En de ingeschreven persoon is getrouwd in 1961 met Geel
    En het huwelijk met Geel is ontbonden in 1983
    En het huwelijk met Roodt is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanschrijfwijze=de heer Roodt-Wit
