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

  Voor een persoon zonder adellijke titel of predicaat begint de briefaanhef met “Geachte mevrouw” of “Geachte heer”, afhankelijk van het geslacht van de persoon. Hierop volgt de samengestelde naam.
  De waarde van aanduidingNaamgebruik bepaalt hoe de aanhef wordt samengesteld uit de naam van de persoon en de naam van de partner.

  Het voorvoegsel van de eerste geslachtsnaam in de briefaanhef wordt met een hoofdletter geschreven.

  Wanneer de persoon een adellijke titel of predikaat heeft, wordt de aanhef volgens de volgende tabel:
  | adellijkeTitel_predikaat | Aanhef                |
  | Baron                    | Hoogwelgeboren heer   |
  | Barones                  | Hoogwelgeboren vrouwe |
  | Graaf                    | Hooggeboren heer      |
  | Gravin                   | Hooggeboren vrouwe    |
  | Hertog                   | Hoogwelgeboren heer   |
  | Hertogin                 | Hoogwelgeboren vrouwe |
  | Jonkheer                 | Hoogwelgeboren heer   |
  | Jonkvrouw                | Hoogwelgeboren vrouwe |
  | Markies                  | Hoogwelgeboren heer   |
  | Markiezin                | Hoogwelgeboren vrouwe |
  | Prins                    | Hoogheid              |
  | Prinses                  | Hoogheid              |
  | Ridder                   | Hoogwelgeboren heer   |

  Als betrokkene de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam,
  Dan wordt de adellijke titel dan wel het predicaat niet gebruikt,
  En de persoon wordt dan aangesproken met “Geachte mevrouw” of “Geachte heer” gevolgd door voorvoegsel en geslachtsnaam van de partner.

  Als betrokkene het predikaat jonkvrouw heeft
  En betrokkene is getrouwd of heeft een geregistreerd partnerschap
  Dan wordt het predikaat niet gebruikt
  En de persoon wordt dan aangesproken met “Geachte mevrouw” gevolgd door de samengestelde naam

  Als betrokkene het predikaat jonkvrouw heeft
  En betrokkene is getrouwd geweest of heeft een geregistreerd partnerschap gehad
  En het huwelijk dan wel geregistreerd partnerschap is ontbonden
  En de partnernaam wordt niet (meer) gebruikt (aanduiding naamgebruik is "E")
  Dan wordt het predikaat gebruikt als was zij nooit getrouwd geweest

  Als betrokkene het predikaat jonkvrouw heeft
  En betrokkene is getrouwd geweest of heeft een geregistreerd partnerschap gehad
  En het huwelijk dan wel geregistreerd partnerschap is ontbonden
  En de (ex)partnernaam wordt nog gebruikt (aanduiding naamgebruik is "V", "N" of "P")
  Dan wordt het predikaat niet gebruikt
  En de persoon wordt dan aangesproken met “Geachte mevrouw” gevolgd door de samengestelde naam

  Als een vrouw als partner of echtgenoot een man met adellijke titel heeft
  En deze adellijke titel heeft een vrouwelijke vorm (zie tabel hieronder)
  En betrokkene gebruikt de naam van de partner
  Dan wordt de aanhef afhankelijk van de adellijke titel van de partner:
  | adellijkeTitel_predikaat partner | Aanhef                |
  | Baron                            | Hoogwelgeboren vrouwe |
  | Graaf                            | Hooggeboren vrouwe    |
  | Hertog                           | Hoogwelgeboren vrouwe |
  | Markies                          | Hoogwelgeboren vrouwe |
  | Prins                            | Hoogheid              |

  In alle andere gevallen heeft de adellijke titel of het predicaat van de partner geen invloed op de aanhef.

  Als er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn
  En de aanschijfwijze is ongelijk aan 'Eigen'
  Dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.

  Als er meerdere ontbonden huwelijken/partnerschappen zijn
  En er geen actueel (niet ontbonden) huwelijk/partnerschap is
  En de aanschijfwijze is ongelijk aan 'Eigen'
  Dan wordt als partnernaam de naam van de laatst ontbonden relatie gebruikt.


  Abstract Scenario: De aanhef wordt samengesteld op basis van geslachtsaanduiding en naamgegevens van de persoon en de partner
    Als ingeschreven persoon wordt geraadpleegd
    Dan heeft de gevonden ingeschrevenpersoon naam.aanhef=<aanhef>

    # In onderstaande tabellen betekenen de afkortingen:
    # GA = "Geachte mevrouw", "Geachte heer", "Hooggeboren heer", "Hooggeboren vrouwe", "Hoogwelgeboren heer", "Hoogwelgeboren vrouwe", "Hoogheid"
    # VV = voorvoegselGeslachtsnaam
    # GN = geslachtsnaam
    # VP = voorvoegselGeslachtsnaam partner
    # GP = geslachtsnaam partner
    # AT = adelijke titel
    # PK = predikaat

    Voorbeelden: geen adellijke titel of predikaat
      | aanduidingNaamgebruik | geslachtsaanduiding |samenstelling aanhef | aanschrijfwijze           | aanhef                                 |
      | Eigen                 | Man                 | GA VV GN            | H. in het Veld            | Geachte heer In het Veld               |
      | Eigen                 | Man                 | GA VV GN            | F. Groenen                | Geachte heer Groenen                   |
      | Partner na eigen      | Vrouw               | GA VV GN-VP GP      | I. van Velzen-in het Veld | Geachte mevrouw Van Velzen-in het Veld |
      | Partner na eigen      | Vrouw               | GA VV GN-VP GP      | F. Groenen-Groenink       | Geachte mevrouw Groenen-Groenink       |
      | Partner               | Vrouw               | GA VP GP            | S. van Velzen             | Geachte mevrouw Van Velzen             |
      | Partner               | Vrouw               | GA VP GP            | J.F.R. Groenen            | Geachte mevrouw Groenen                |
      | Partner voor eigen    | Man                 | GA VP GP-VV GN      | F. in het Veld-van Velzen | Geachte heer In het Veld-van Velzen    |
      | Partner voor eigen    | Man                 | GA VP GP-VV GN      | F. Groenen-Groenink       | Geachte heer Groenen-Groenink          |

    Voorbeelden: adelijke titels
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | aanschrijfwijze                             | aanhef                    |
      | Baron                    | Eigen                 | H.W. baron van den Aedel                    | Hoogwelgeboren heer       |
      | Barones                  | Partner na eigen      | W. barones van den Aedel-van der Veen       | Hoogwelgeboren vrouwe     |
      | Graaf                    | Partner               | F. van der Veen                             | Geachte heer Van der Veen |
      | Gravin                   | Partner voor eigen    | E.L. van der Veen-gravin van den Aedel      | Hooggeboren vrouwe        |
      | Prins                    | Eigen                 | O.B.B. prins van Roodt de Wit Blaauw        | Hoogheid                  |
      | Prinses                  | Eigen                 | E.M.V. prinses van Roodt de Wit Blaauw      | Hoogheid                  |
      | Ridder                   | Eigen                 | M. ridder van Hoogh                         | Hoogwelgeboren heer       |

    Voorbeelden: predikaat
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | partner | Ontbinding huwelijk/geregistreerd partnerschap | aanhef                                 |
      | Jonkheer                 | Eigen                 | Geen    | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | Eigen                 | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | Partner na eigen      | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | Partner               | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkheer                 | Partner voor eigen    | Ja      | Geen                                           | Hoogwelgeboren heer                    |
      | Jonkvrouw                | Eigen                 | Geen    | Geen                                           | Hoogwelgeboren vrouwe                  |
      | Jonkvrouw                | Eigen                 | Ja      | Geen                                           | Geachte mevrouw Van Hoogh              |
      | Jonkvrouw                | Partner na eigen      | Ja      | Geen                                           | Geachte mevrouw Van Hoogh-van der Veen |
      | Jonkvrouw                | Partner               | Ja      | Geen                                           | Geachte mevrouw Van der Veen-van Hoogh |
      | Jonkvrouw                | Partner voor eigen    | Ja      | Geen                                           | Geachte mevrouw Van der Veen           |
      | Jonkvrouw                | Eigen                 | Ja      | Ja                                             | Hoogwelgeboren vrouwe                  |
      | Jonkvrouw                | Partner na eigen      | Ja      | Ja                                             | Geachte mevrouw Van Hoogh-van der Veen |
      | Jonkvrouw                | Partner               | Ja      | Ja                                             | Geachte mevrouw Van der Veen-van Hoogh |
      | Jonkvrouw                | Partner voor eigen    | Ja      | Ja                                             | Geachte mevrouw Van der Veen           |

    Voorbeelden: partner heeft adellijke titel of predikaat
      | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingNaamgebruik | aanschrijfwijze | aanhef |
      | V | M | Baron    | Eigen                 | A.C. van der Veen                       | Geachte mevrouw Van der Veen               |
      | V | M | Baron    | Partner na eigen      | A.C. van der Veen-barones van den Aedel | Hoogwelgeboren vrouwe                      |
      | V | M | Baron    | Partner               | A.C. barones van den Aedel              | Hoogwelgeboren vrouwe                      |
      | V | M | Baron    | Partner voor eigen    | A.C. barones van den Aedel-van der Veen | Hoogwelgeboren vrouwe                      |
      | M | V | Gravin   | Eigen                 | W. van der Veen                         | Geachte heer Van der Veen                  |
      | M | V | Gravin   | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte heer Van der Veen-van den Aedel    |
      | M | V | Gravin   | Partner               | W. van den Aedel                        | Geachte heer Van den Aedel                 |
      | M | V | Gravin   | Partner voor eigen    | W. van den Aedel-van der Veen           | Geachte heer Van den Aedel-van der Veen    |
      | M | M | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte heer Van der Veen-van den Aedel    |
      | V | V | Barones  | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte mevrouw Van der Veen-van den Aedel |
      | V | M | Ridder   | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte mevrouw Van der Veen-van den Aedel |
      | V | M | Ridder   | Partner               | W. van den Aedel                        | Geachte mevrouw Van den Aedel              |
      | V | M | Jonkheer | Eigen                 | A.C. van der Veen                       | Geachte mevrouw Van der Veen               |
      | V | M | Jonkheer | Partner na eigen      | A.C. van der Veen-van den Aedel         | Geachte mevrouw Van der Veen-van den Aedel |
      | V | M | Jonkheer | Partner               | A.C. van den Aedel                      | Geachte mevrouw Van den Aedel              |
      | V | M | Jonkheer | Partner voor eigen    | A.C. van den Aedel-van der Veen         | Geachte mevrouw Van den Aedel-van der Veen |

  Scenario: meerdere actuele relaties
    Gegeven de ingeschreven persoon de heer F.C. Groen is getrouwd in 1958 met Geel
    En de ingeschreven persoon is getrouwd in 1961 met Roodt
    En geen van beide relaties is beëindigd
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=Geachte heer Geel-Groen

  Scenario: meerdere ontbonden relaties
    Gegeven de ingeschreven persoon de heer J. Wit is getrouwd in 1958 met Geel
    En de ingeschreven persoon is getrouwd in 1961 met Roodt
    En het huwelijk met Geel is ontbonden in 1960
    En het huwelijk met Roodt is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=Geachte heer Roodt-Wit

    Gegeven de ingeschreven persoon de heer J. Wit is getrouwd in 1958 met Zwart
    En de ingeschreven persoon is getrouwd in 1961 met Blaauw
    En het huwelijk met Blaauw is ontbonden in 1983
    En het huwelijk met Zwart is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=Geachte heer Zwart-Wit
