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

  Het voorvoegsel van de eerste geslachtsnaam in de briefaanhef wordt met een hoofdletter geschreven. Het voorvoegsel van de tweede geslachtsnaam wordt met een kleine letter geschreven.

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

  Als betrokkene een predikaat heeft (jonkvrouw of jonkheer)
  En betrokkene is getrouwd of geregistreerd partnerschap of is getrouwd geweest of heeft geregistreerd partnerschap gehad
  Dan wordt de adellijke titel dan wel het predicaat niet gebruikt
  En de persoon wordt dan aangesproken met “Geachte mevrouw” of “Geachte heer” gevolgd door de samengestelde naam

  Als betrokkene geen adellijke titel of predicaat heeft
  En de echtgenoot/partner wel een adellijke titel heeft
  En de adellijke titel van de partner heeft een equivalent voor het geslacht van de partner
  En de echtgenoot/partner heeft niet hetzelfde geslacht als betrokkene
  En betrokkene gebruikt de naam van de partner
  Dan wordt de briefaanhef van de partner gebruikt in de vorm voor het geslacht van betrokkene:
  | adellijkeTitel_predikaat partner | Aanhef                |
  | Baron                            | Hoogwelgeboren vrouwe |
  | Barones                          | Hoogwelgeboren heer   |
  | Graaf                            | Hooggeboren vrouwe    |
  | Gravin                           | Hooggeboren heer      |
  | Hertog                           | Hoogwelgeboren vrouwe |
  | Hertogin                         | Hoogwelgeboren heer   |
  | Markies                          | Hoogwelgeboren vrouwe |
  | Markiezin                        | Hoogwelgeboren heer   |
  | Prins                            | Hoogheid              |
  | Prinses                          | Hoogheid              |

  In alle andere gevallen heeft de adellijke titel of het predicaat van de partner van de persoon geen invloed op de aanhef.

  Als er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn
  En de aanschijfwijze is ongelijk aan 'Eigen'
  Dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.

  Als er meerdere ontbonden huwelijken/partnerschappen zijn
  En er geen actueel (niet ontbonden) huwelijk/partnerschap is
  En de aanschijfwijze is ongelijk aan 'Eigen'
  Dan wordt als partnernaam de naam van de laatst ontbinden relatie gebruikt.


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
      | adellijkeTitel_predikaat | soortVerbintenis | Ontbinding huwelijk/geregistreerd partnerschap | aanhef                    |
      | Jonkheer                 | Geen             | Geen                                           | Hoogwelgeboren heer       |
      | Jonkvrouw                | Geen             | Geen                                           | Hoogwelgeboren vrouwe     |
      | Jonkheer                 | Huwelijk         | Niet                                           | Geachte heer In het Veld  |
      | Jonkheer                 | Partnerschap     | Niet                                           | Geachte heer In het Veld  |
      | Jonkheer                 | Huwelijk         | Ja                                             | Geachte heer In het Veld  |
      | Jonkheer                 | Huwelijk         | Niet                                           | Geachte heer In het Veld  |

    Voorbeelden: partner heeft adellijke titel of predikaat
      | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingNaamgebruik | aanschrijfwijze | aanhef |
      | V | M | Baron    | Eigen                 | A.C. van der Veen                       | Geachte mevrouw Van der Veen               |
      | V | M | Baron    | Partner na eigen      | A.C. van der Veen-barones van den Aedel | Hoogwelgeboren vrouwe                      |
      | V | M | Baron    | Partner               | A.C. barones van den Aedel              | Hoogwelgeboren vrouwe                      |
      | V | M | Baron    | Partner voor eigen    | A.C. barones van den Aedel-van der Veen | Hoogwelgeboren vrouwe                      |
      | M | V | Gravin   | Eigen                 | W. van der Veen                         | Geachte heer Van der Veen                  |
      | M | V | Gravin   | Partner na eigen      | W. van der Veen-graaf van den Aedel     | Hooggeboren heer                           |
      | M | V | Gravin   | Partner               | W. graaf van den Aedel                  | Hooggeboren heer                           |
      | M | V | Gravin   | Partner voor eigen    | W. graaf van den Aedel-van der Veen     | Hooggeboren heer                           |
      | M | M | Baron    | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte heer Van der Veen-van den Aedel    |
      | V | M | Ridder   | Partner na eigen      | W. van der Veen-van den Aedel           | Geachte mevrouw Van der Veen-van den Aedel |
      | V | M | Ridder   | Partner               | W. van den Aedel                        | Geachte mevrouw Van den Aedel              |
      | V | M | Jonkheer | Eigen                 | A.C. van der Veen                       | Geachte mevrouw Van der Veen               |
      | V | M | Jonkheer | Partner na eigen      | A.C. van der Veen-van den Aedel         | Geachte mevrouw Van der Veen-van den Aedel |
      | V | M | Jonkheer | Partner               | A.C. van den Aedel                      | Geachte mevrouw Van den Aedel              |
      | V | M | Jonkheer | Partner voor eigen    | A.C. van den Aedel-van der Veen         | Geachte mevrouw Van den Aedel-van der Veen |
