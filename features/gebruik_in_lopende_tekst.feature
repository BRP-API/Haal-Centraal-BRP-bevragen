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
  En de geslachtsaanduiding is gelijk aan "vrouw" of "man"
  Dan wordt gebruikInLopendeTekst voorafgegaan door een geslachtsaanduiding ("mevrouw", "de heer"), gevolgd door de samengestelde naam op basis van aanduidingNaamgebruik en de naam van de persoon en de partner.

  Als de eerste naam geen adellijke titel of predicaat heeft,
  En de geslachtsaanduiding is gelijk aan "onbekend" of er is geen waarde voor geslachtsaanduiding
  Dan wordt gebruikInLopendeTekst voorafgegaan door de voorletters, gevolgd door de samengestelde naam op basis van aanduidingNaamgebruik en de naam van de persoon en de partner.

  Wanneer geslachtsaanduiding is "vrouw" of "man", dan wordt het voorvoegsel van de eerste geslachtsnaam in de samengestelde naam met een hoofdletter geschreven.

  Als er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn
  En de aanduiding aanschijving is ongelijk aan 'Eigen',
  Dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.

  Als er meerdere ontbonden huwelijken/partnerschappen zijn
  En er geen actueel (niet ontbonden) huwelijk/partnerschap is
  En de aanduiding aanschijving is ongelijk aan 'Eigen'
  Dan wordt als partnernaam de naam van de laatst ontbonden relatie gebruikt.

  Op basis van attribuut adellijkeTitel_predikaat wordt de adelijke titel of het predikaat toegevoegd in gebruikInLopendeTekst.
  Als de betrokkene beschikt over een adellijke titel of predikaat
  Dan wordt deze geplaatst vóór het voorvoegsel van de eigen geslachtsnaam.
  Als de betrokkene beschikt over een adellijke titel of predikaat
  Dan wordt deze opgenomen zoals genoemd in kolom "Omschrijving" in GBA tabel 38 "Adellijke titel/predikaat", geschreven in kleine letters.
  Als betrokkene beschikt over een adellijke titel of predicaat
  En betrokkene gebruikt de achternaam van de echtgenoot/partner in combinatie met de eigen geslachtsnaam
  Dan wordt de titel dan wel het predicaat van betrokkene voor de eigen geslachtsnaam geplaatst.
  Als betrokkene een adellijke titel of predicaat heeft
  En betrokkene gebruikt alleen de naam van de partner (aanduiding naamgebruik is "P")
  Dan wordt de eigen adellijke titel of het predicaat niet gebruikt.

  Als een vrouw als partner of echtgenoot een man met adellijke titel heeft,
  En deze adellijke titel heeft een vrouwelijke vorm (zie tabel hieronder),
  Dan wordt die adellijke titel in vrouwelijke vorm opgenomen wanneer ze de naam van haar partner gebruikt.
  | Titel | Vrouwelijke vorm |
  | Graaf	| gravin           |
  | Baron	| barones          |
  | Prins	| prinses          |

  Als betrokkene en partner hetzelfde geslacht hebben Of de titel van de partner komt niet voor in bovenstaande tabel (er is geen vrouwelijke vorm van de titel),
  Dan wordt de adellijke titel van de partner niet opgenomen.

  Abstract Scenario: gebruikInLopendeTekst wordt samengesteld op basis van geslachtsaanduiding en naamgegevens van de persoon en de partner
    Als ingeschreven persoon wordt geraadpleegd
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
      | Eigen                 | Man                 | GA VV GN        | H. in het Veld            | de heer In het Veld            |
      | Eigen                 | Man                 | GA VV GN        | F. Groenen                | de heer Groenen                |
      | Eigen                 | Onbekend            | VL VV GN        | P.T. Groenink             | P.T. Groenink                  |
      | Partner na eigen      | Vrouw               | GA VV GN-VP GP  | I. van Velzen-in het Veld | mevrouw Van Velzen-in het Veld |
      | Partner na eigen      | Vrouw               | GA VV GN-VP GP  | F. Groenen-Groenink       | mevrouw Groenen-Groenink       |
      | Partner               | Vrouw               | GA VP GP        | S. van Velzen             | mevrouw Van Velzen             |
      | Partner               | Vrouw               | GA VP GP        | J.F.R. Groenen            | mevrouw Groenen                |
      | Partner               | Onbekend            | VL VP GP        | I. van Velzen             | I. van Velzen                  |
      | Partner voor eigen    | Man                 | GA VP GP-VV GN  | F. in het Veld-van Velzen | de heer In het Veld-van Velzen |
      | Partner voor eigen    | Man                 | GA VP GP-VV GN  | F. Groenen-Groenink       | de heer Groenen-Groenink       |

    Voorbeelden: voorvoegsels met hoofdletter of kleine letter
      | aanduidingAanschrijving | geslachtsaanduiding | VV     | GN     | VP     | GP     | gebruikInLopendeTekst          |
      | E                       | man                 | In het | Veld   | van    | Velzen | de heer In het Veld            |
      | N                       | vrouw               | van    | Velzen | In het | Veld   | mevrouw Van Velzen-In het Veld |
      | P                       | vrouw               | In het | Veld   | van    | Velzen | mevrouw Van Velzen             |
      | V                       | man                 | van    | Velzen | In het | Veld   | de heer In het Veld-van Velzen |

    Voorbeelden: adelijke titels
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | geslachtsaanduiding | samenstelling gebruikInLopendeTekst | gebruikInLopendeTekst                        |
      | Baron                    | Eigen                 | Man                 | AT VV GN                            | baron Van den Aedel                          |
      | Baron                    | Eigen                 | Vrouw               | AT VV GN                            | baron Van den Aedel                          |
      | Baron                    | Eigen                 | Onbekend            | AT VV GN                            | baron Van den Aedel                          |
      | Barones                  | Partner na eigen      | Vrouw               | AT VV GN-VP GP                      | barones Van den Aedel-van der Veen           |
      | Graaf                    | Partner               | Man                 | GA VP GP                            | de heer Van der Veen                         |
      | Gravin                   | Partner voor eigen    | Vrouw               | GA VP GP-AT VV GN                   | mevrouw Van der Veen-gravin van den Aedel    |
      | Prins                    | Eigen                 | Man                 | AT VV GN                            | prins Van Roodt de Wit Blaauw                |
      | Prinses                  | Eigen                 | Vrouw               | AT VV GN                            | prinses Van Roodt de Wit Blaauw              |
      | Ridder                   | Eigen                 | Man                 | T VV GN                             | ridder Van Hoogh                             |

    Voorbeelden: predikaat
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | partner | aanhef                                  |
      | Jonkheer                 | Eigen                 | Geen    | jonkheer Van Hoogh                      |
      | Jonkvrouw                | Eigen                 | Geen    | jonkvrouw Van Hoogh                     |
      | Jonkheer                 | Eigen                 | Ja      | jonkheer Van Hoogh                      |
      | Jonkvrouw                | Eigen                 | Ja      | jonkvrouw Van Hoogh                     |
      | Jonkvrouw                | Partner na eigen      | Ja      | jonkvrouw Van Hoogh-in het Veld         |
      | Jonkvrouw                | Partner               | Ja      | mevrouw In het Veld                     |
      | Jonkvrouw                | Partner voor eigen    | Ja      | mevrouw In het Veld-jonkvrouw van Hoogh |

    Voorbeelden: partner heeft adelijke titel of predikaat
      | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingNaamgebruik | aanschrijfwijze | gebruikInLopendeTekst |
      | V | M | Baron    | Eigen                 | A.C. van der Veen                       | mevrouw Van der Veen                       |
      | V | M | Baron    | Partner na eigen      | A.C. van der Veen-barones van den Aedel | mevrouw Van der Veen-barones van den Aedel |
      | V | M | Baron    | Partner               | A.C. barones van den Aedel              | barones Van den Aedel                      |
      | V | M | Baron    | Partner voor eigen    | A.C. barones van den Aedel-van der Veen | barones Van den Aedel-van der Veen         |
      | M | V | Gravin   | Eigen                 | W. van der Veen                         | de heer Van der Veen                       |
      | M | V | Gravin   | Partner na eigen      | W. van der Veen-graaf van den Aedel     | de heer Van der Veen-van den Aedel         |
      | M | V | Gravin   | Partner               | W. graaf van den Aedel                  | de heer Van den Aedel                      |
      | M | V | Gravin   | Partner voor eigen    | W. graaf van den Aedel-van der Veen     | de heer Van den Aedel-van der Veen         |
      | M | M | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | de heer Van der Veen-van den Aedel         |
      | O | M | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | W. van der Veen-van den Aedel              |
      | V | V | Barones  | Partner na eigen      | W. van der Veen-van den Aedel           | mevrouw Van der Veen-van den Aedel         |
      | V | M | Ridder   | Partner na eigen      | W. van der Veen-van den Aedel           | mevrouw Van der Veen-van den Aedel         |
      | V | M | Jonkheer | Eigen                 | A.C. van der Veen                       | mevrouw Van der Veen                       |
      | V | M | Jonkheer | Partner na eigen      | A.C. van der Veen-van den Aedel         | mevrouw Van der Veen-van den Aedel         |
      | V | M | Jonkheer | Partner               | A.C. van den Aedel                      | mevrouw Van den Aedel                      |
      | V | M | Jonkheer | Partner voor eigen    | A.C. van den Aedel-van der Veen         | mevrouw Van den Aedel-van der Veen         |

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

    Gegeven de ingeschreven persoon de heer J. Wit is getrouwd in 1958 met Zwart
    En de ingeschreven persoon is getrouwd in 1961 met Blaauw
    En het huwelijk met Blaauw is ontbonden in 1983
    En het huwelijk met Zwart is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=de heer Zwart-Wit
