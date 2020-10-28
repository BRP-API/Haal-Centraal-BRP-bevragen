# language: nl

# Issue #334 en #337
Functionaliteit: Als gemeente wil ik de juiste en consistente briefaanhef in communicatie naar burgers
  Attribuut aanhef bij een ingeschreven persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven.
  De briefaanhef wordt gebruikt bovenaan een brief.

  Attribuut aanhef wordt samengesteld op basis van:
  - voorvoegselGeslachtsnaam
  - geslachtsnaam
  - adellijkeTitel_predikaat
  - geslachtsaanduiding
  - aanduidingAanschrijving
  - voorvoegselGeslachtsnaam partner
  - geslachtsnaam partner
  - adellijkeTitel_predikaat partner
  - geslachtsaanduiding partner

  Voor een persoon zonder adellijke titel of predikaat begint de briefaanhef met “Geachte mevrouw” (vrouw) of “Geachte heer” (man) of "Geachte " plus de voorletters (onbekend), afhankelijk van het geslacht van de persoon. Hierop volgt de samengestelde naam.
  De waarde van aanduidingNaamgebruik bepaalt hoe de aanhef wordt samengesteld uit de naam van de persoon en de naam van de partner.

  Wanneer geslachtsaanduiding is niet leeg of "onbekend", dan wordt het voorvoegsel van de eerste geslachtsnaam in de briefaanhef met een hoofdletter geschreven.

  Als de persoon een adellijke titel of predikaat heeft, wordt de aanhef bepaald op basis van adellijkeTitel_predikaat en de geslachtsaanduiding volgens de volgende tabel:
  | adellijkeTitel_predikaat | geslachtsaanduiding | Aanhef                |
  | Baron, Barones           | man                 | Hoogwelgeboren heer   |
  | Baron, Barones           | vrouw               | Hoogwelgeboren vrouwe |
  | Graaf, Gravin            | man                 | Hooggeboren heer      |
  | Graaf, Gravin            | vrouw               | Hooggeboren vrouwe    |
  | Hertog, Hertogin         | man                 | Hoogwelgeboren heer   |
  | Hertog, Hertogin         | vrouw               | Hoogwelgeboren vrouwe |
  | Jonkheer, Jonkvrouw      | man                 | Hoogwelgeboren heer   |
  | Jonkheer, Jonkvrouw      | vrouw               | Hoogwelgeboren vrouwe |
  | Markies, Markiezin       | man                 | Hoogwelgeboren heer   |
  | Markies, Markiezin       | vrouw               | Hoogwelgeboren vrouwe |
  | Prins, Prinses           | man                 | Hoogheid              |
  | Prins, Prinses           | vrouw               | Hoogheid              |
  | Prins, Prinses           | onbekend            | Hoogheid              |
  | Ridder                   | man                 | Hoogwelgeboren heer   |
  | Ridder                   | vrouw               | Hoogwelgeboren vrouwe |

  Als de persoon een adellijke titel of predikaat heeft
  En de geslachtsaanduiding is gelijk aan "onbekend" of er is geen waarde voor geslachtsaanduiding
  En de adellijke titel is ongelijk aan "prins" of "prinses" ("Hoogheid" is gender neutraal dus kan ook bij onbekend geslacht gebruikt worden)
  Dan wordt de adellijke titel of predikaat niet gebruikt.
  En wordt de aanhef op dezelfde manier samengesteld als voor een persoon zonder adellijke titel of predikaat.

  Als de persoon de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam (aanduiding aanschrijving is "P" - "partner"),
  Dan wordt de adellijke titel of predikaat niet gebruikt.
  En wordt de aanhef op dezelfde manier samengesteld als voor een persoon zonder adellijke titel of predikaat.

  Als de persoon een predikaat heeft
  En de geslachtsaanduiding is gelijk aan "vrouw"
  En betrokkene is getrouwd of heeft een geregistreerd partnerschap
  Dan wordt het predikaat niet gebruikt
  En wordt de aanhef op dezelfde manier samengesteld als voor een persoon zonder adellijke titel of predikaat.

  Als de persoon een predikaat heeft
  En de geslachtsaanduiding is gelijk aan "vrouw"
  En de persoon is getrouwd geweest of heeft een geregistreerd partnerschap gehad
  En het huwelijk dan wel geregistreerd partnerschap is ontbonden
  En de partnernaam wordt niet (meer) gebruikt (aanduiding naamgebruik is "E" - "eigen")
  Dan wordt het predikaat gebruikt als was zij nooit getrouwd geweest

  Als de persoon een predikaat heeft
  En de geslachtsaanduiding is gelijk aan "vrouw"
  En de persoon is getrouwd geweest of heeft een geregistreerd partnerschap gehad
  En het huwelijk dan wel geregistreerd partnerschap is ontbonden
  En de (ex)partnernaam wordt nog gebruikt (aanduiding naamgebruik is "V", "N" of "P")
  Dan wordt het predikaat niet gebruikt
  En wordt de aanhef op dezelfde manier samengesteld als voor een persoon zonder adellijke titel of predikaat.

  Als de partner een adellijke titel heeft
  En de geslachtsaanduiding van de persoon is "vrouw"
  En de geslachtsaanduiding van de partner is "man"
  En de adellijke titel van de partner heeft een vrouwelijke aanhef vorm (zie tabel hieronder)
  En de persoon gebruikt de naam van haar partner (aanduiding naamgebruik ongelijk aan "E" - "eigen")
  Dan wordt de aanhef afhankelijk van de adellijke titel van de partner:
  | adellijkeTitel_predikaat partner | Aanhef                |
  | Baron                            | Hoogwelgeboren vrouwe |
  | Graaf                            | Hooggeboren vrouwe    |
  | Hertog                           | Hoogwelgeboren vrouwe |
  | Markies                          | Hoogwelgeboren vrouwe |
  | Prins                            | Hoogheid              |

  In alle andere gevallen heeft de adellijke titel of het predikaat van de partner geen invloed op de aanhef.

  Als er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn
  En de aanduidingNaamgebruik is ongelijk aan "E" - "Eigen"
  Dan wordt als partnernaam de naam van de eerste partner (oudste niet ontbonden relatie) gebruikt.

  Als er meerdere ontbonden huwelijken/partnerschappen zijn
  En er geen actueel (niet ontbonden) huwelijk/partnerschap is
  En de aanduidingNaamgebruik is ongelijk aan "E" - "Eigen"
  Dan wordt als partnernaam de naam van de laatst ontbonden relatie gebruikt.


  Abstract Scenario: De aanhef wordt samengesteld op basis van geslachtsaanduiding en naamgegevens van de persoon en de partner
    Als ingeschreven persoon wordt geraadpleegd
    Dan heeft de gevonden ingeschrevenpersoon naam.aanhef=<aanhef>

    # In onderstaande tabellen betekenen de afkortingen:
    # GA = "Geachte mevrouw", "Geachte heer", "Geachte"
    # VL = voorletters
    # VV = voorvoegselGeslachtsnaam
    # GN = geslachtsnaam
    # VP = voorvoegselGeslachtsnaam partner
    # GP = geslachtsnaam partner
    # AT = adelijke titel
    # PK = predikaat

    Voorbeelden: geen adellijke titel of predikaat
      | aanduidingNaamgebruik | geslachtsaanduiding |samenstelling aanhef | aanschrijfwijze           | aanhef                                 |
      | Eigen                 | man                 | GA VV GN            | H. in het Veld            | Geachte heer In het Veld               |
      | Eigen                 | vrouw               | GA VV GN            | F. Groenen                | Geachte mevrouw Groenen                |
      | Eigen                 | onbekend            | GA VL VV GN         | C.F.H. van Velzen         | Geachte C.F.H. van Velzen              |
      | Partner na eigen      | vrouw               | GA VV GN-VP GP      | I. van Velzen-in het Veld | Geachte mevrouw Van Velzen-in het Veld |
      | Partner na eigen      | onbekend            | GA VV GN-VP GP      | F. Groenen-Groenink       | Geachte F. Groenen-Groenink            |
      | Partner               | vrouw               | GA VP GP            | S. van Velzen             | Geachte mevrouw Van Velzen             |
      | Partner               | man                 | GA VP GP            | J.F.R. Groenen            | Geachte heer Groenen                   |
      | Partner voor eigen    | man                 | GA VP GP-VV GN      | F. in het Veld-van Velzen | Geachte heer In het Veld-van Velzen    |
      | Partner voor eigen    | vrouw               | GA VP GP-VV GN      | M. Groenen-Groenink       | Geachte mevrouw Groenen-Groenink       |
      | Partner voor eigen    | onbekend            | GA VL. VP GP-VV GN  | J.P. van Velzen-Groenen   | Geachte J.P. van Velzen-Groenen        |

    Voorbeelden: voorvoegsels met hoofdletter of kleine letter
      | aanduidingAanschrijving | geslachtsaanduiding | VV     | GN     | VP     | GP     | aanhef                                 |
      | Eigen                   | man                 | In het | Veld   | van    | Velzen | Geachte heer In het Veld               |
      | Partner na eigen        | vrouw               | van    | Velzen | In het | Veld   | Geachte mevrouw Van Velzen-In het Veld |
      | Partner                 | vrouw               | In het | Veld   | van    | Velzen | Geachte mevrouw Van Velzen             |
      | Partner voor eigen      | man                 | van    | Velzen | In het | Veld   | Geachte heer In het Veld-van Velzen    |
      | Partner voor eigen      | onbekend            | van    | Velzen | In het | Veld   | Geachte M.L. van Velzen-In het Veld    |

    Voorbeelden: adelijke titels
      | adellijkeTitel_predikaat | geslachtsaanduiding | aanduidingNaamgebruik | aanschrijfwijze                             | aanhef                    |
      | Baron                    | man                 | Eigen                 | H.W. baron van den Aedel                    | Hoogwelgeboren heer       |
      | Barones                  | vrouw               | Partner na eigen      | W. barones van den Aedel-van der Veen       | Hoogwelgeboren vrouwe     |
      | Graaf                    | man                 | Partner               | F. van der Veen                             | Geachte heer Van der Veen |
      | Gravin                   | vrouw               | Partner voor eigen    | E.L. van der Veen-gravin van den Aedel      | Hooggeboren vrouwe        |
      | Prins                    | man                 | Eigen                 | O.B.B. prins van Roodt de Wit Blaauw        | Hoogheid                  |
      | Prinses                  | vrouw               | Eigen                 | E.M.V. prinses van Roodt de Wit Blaauw      | Hoogheid                  |
      | Ridder                   | man                 | Eigen                 | M. ridder van Hoogh                         | Hoogwelgeboren heer       |
      | Graaf                    | vrouw               | Partner voor eigen    | J.G. van der Veen-gravin van den Aedel      | Hooggeboren vrouwe        |
      | Ridder                   | onbekend            | Eigen                 | P. van den Aedel                            | Geachte P. van den Aedel  |
      | Prinses                  | onbekend            | Eigen                 | J. van Roodt de Wit Blaauw                  | Hoogheid                  |

    Voorbeelden: predikaat
      | adellijkeTitel_predikaat | geslachtsaanduiding | aanduidingNaamgebruik | partner | Ontbinding huwelijk/geregistreerd partnerschap | aanhef                                 |
      | Jonkheer                 | man                 | Eigen                 | Geen    | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | man                 | Eigen                 | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | man                 | Partner na eigen      | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | man                 | Partner               | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | man                 | Partner voor eigen    | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkvrouw                | vrouw               | Eigen                 | Geen    | Geen                                           | Hoogwelgeboren vrouwe                  |
      | Jonkvrouw                | vrouw               | Eigen                 | Ja      | Geen                                           | Geachte mevrouw Van Hoogh              |
      | Jonkvrouw                | vrouw               | Partner na eigen      | Ja      | Geen                                           | Geachte mevrouw Van Hoogh-van der Veen |
      | Jonkvrouw                | vrouw               | Partner voor eigen    | Ja      | Geen                                           | Geachte mevrouw Van der Veen-van Hoogh |
      | Jonkvrouw                | vrouw               | Partner               | Ja      | Geen                                           | Geachte mevrouw Van der Veen           |
      | Jonkvrouw                | vrouw               | Eigen                 | Ja      | Ja                                             | Hoogwelgeboren vrouwe                  |
      | Jonkvrouw                | vrouw               | Partner na eigen      | Ja      | Ja                                             | Geachte mevrouw Van Hoogh-van der Veen |
      | Jonkvrouw                | vrouw               | Partner               | Ja      | Ja                                             | Geachte mevrouw Van der Veen-van Hoogh |
      | Jonkvrouw                | vrouw               | Partner voor eigen    | Ja      | Ja                                             | Geachte mevrouw Van der Veen           |
      | Jonkheer                 | vrouw               | Eigen                 | Geen    | Geen                                           | Hoogwelgeboren vrouwe                  |
      | Jonkheer                 | vrouw               | Eigen                 | Ja      | Geen                                           | Geachte mevrouw Van Hoogh              |
      | Jonkheer                 | vrouw               | Eigen                 | Ja      | Ja                                             | Hoogwelgeboren vrouwe                  |
      | Jonkheer                 | vrouw               | Partner na eigen      | Ja      | Ja                                             | Geachte mevrouw Van der Veen-van Hoogh |
      | Jonkvrouw                | man                 | Partner na eigen      | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | onbekend            | Eigen                 | Geen    | Geen                                           | Geachte F.H. van Hoogh                 |
      | Jonkvrouw                | onbekend            | Eigen                 | Geen    | Geen                                           | Geachte B.T.I. van Hoogh               |

    Voorbeelden: partner heeft adellijke titel of predikaat
      | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingNaamgebruik | aanschrijfwijze | aanhef |
      | vrouw    | man      | Baron    | Eigen                 | A.C. van der Veen                       | Geachte mevrouw Van der Veen               |
      | vrouw    | man      | Baron    | Partner na eigen      | A.C. van der Veen-barones van den Aedel | Hoogwelgeboren vrouwe                      |
      | vrouw    | man      | Baron    | Partner               | A.C. barones van den Aedel              | Hoogwelgeboren vrouwe                      |
      | vrouw    | man      | Baron    | Partner voor eigen    | A.C. barones van den Aedel-van der Veen | Hoogwelgeboren vrouwe                      |
      | onbekend | man      | Baron    | Partner voor eigen    | A.C. van den Aedel-van der Veen         | Geachte A.C. van den Aedel-van der Veen    |
      | vrouw    | onbekend | Baron    | Partner na eigen      | A.C. van der Veen-barones van den Aedel | Geachte mevrouw Van der Veen-van den Aedel |
      | man      | vrouw    | Gravin   | Eigen                 | W. van der Veen                         | Geachte heer Van der Veen                  |
      | man      | vrouw    | Gravin   | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte heer Van der Veen-van den Aedel    |
      | man      | vrouw    | Gravin   | Partner               | W. van den Aedel                        | Geachte heer Van den Aedel                 |
      | man      | vrouw    | Gravin   | Partner voor eigen    | W. van den Aedel-van der Veen           | Geachte heer Van den Aedel-van der Veen    |
      | man      | man      | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte heer Van der Veen-van den Aedel    |
      | onbekend | man      | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte W. van der Veen-van den Aedel      |
      | vrouw    | vrouw    | Barones  | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte mevrouw Van der Veen-van den Aedel |
      | vrouw    | man      | Ridder   | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte mevrouw Van der Veen-van den Aedel |
      | vrouw    | man      | Ridder   | Partner               | W. van den Aedel                        | Geachte mevrouw Van den Aedel              |
      | vrouw    | man      | Jonkheer | Eigen                 | A.C. van der Veen                       | Geachte mevrouw Van der Veen               |
      | vrouw    | man      | Jonkheer | Partner na eigen      | A.C. van der Veen-van den Aedel         | Geachte mevrouw Van der Veen-van den Aedel |
      | vrouw    | man      | Jonkheer | Partner               | A.C. van den Aedel                      | Geachte mevrouw Van den Aedel              |
      | vrouw    | man      | Jonkheer | Partner voor eigen    | A.C. van den Aedel-van der Veen         | Geachte mevrouw Van den Aedel-van der Veen |

  Scenario: meerdere actuele relaties
    Gegeven de ingeschreven persoon de heer F.C. Groen is getrouwd in 1958 met Geel
    En de ingeschreven persoon is getrouwd in 1961 met Roodt
    En geen van beide relaties is beëindigd
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=Geachte heer Geel-Groen

  Scenario: meerdere ontbonden relaties gebruikt de laatst ontbonden relatie
    Gegeven de ingeschreven persoon de heer J. Wit is getrouwd in 1958 met Geel
    En de ingeschreven persoon is getrouwd in 1961 met Roodt
    En het huwelijk met Geel is ontbonden in 1960
    En het huwelijk met Roodt is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=Geachte heer Roodt-Wit


  Scenario: meerdere ontbonden relaties en oudste relatie is het laatst ontbonden
    Gegeven de ingeschreven persoon de heer J. Wit is getrouwd in 1958 met Zwart
    En de ingeschreven persoon is getrouwd in 1961 met Blaauw
    En het huwelijk met Blaauw is ontbonden in 1983
    En het huwelijk met Zwart is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=Geachte heer Zwart-Wit
