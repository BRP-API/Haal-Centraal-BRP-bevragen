# language: nl

# Issue #334 en #337
Functionaliteit: Als gemeente wil ik de juiste en consistente briefaanhef in communicatie naar burgers
  Attribuut aanhef bij een ingeschreven persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven.

  Attribuut aanhef wordt samengesteld op basis van:
  - voorvoegselGeslachtsnaam
  - geslachtsnaam
  - voorvoegselGeslachtsnaam partner
  - geslachtsnaam partner
  - aanduidingAanschrijving
  - adellijkeTitel_predikaat
  - geslachtsaanduiding

  De waarde van aanduidingNaamgebruik bepaalt hoe de aanhef wordt samengesteld uit de naam van de persoon en de naam van de partner.

  Wanneer er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn en de aanschijfwijze is ongelijk aan 'E', dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.
  Wanneer er meerdere ontbonden huwelijken/partnerschappen zijn en er geen actueel (niet ontbonden) huwelijk/partnerschap is en de aanschijfwijze is ongelijk aan 'E', wordt als partnernaam de naam van de laatst ontbinden relatie gebruikt.

  Wanneer de persoon geen adellijke titel of predikaat heeft, wordt de aanhef samengesteld met "Geachte " plus een geslachtsaanduiding ("mevrouw", "heer")

  Wanneer de persoon een adellijke titel of predikaat heeft, wordt de samengestelde geslachtsnaam voorafgegaan door de aanhef volgens de volgende tabel:

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

  Als betrokkene de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam, Dan wordt de adellijke titel dan wel het predicaat niet gebruikt. De persoon wordt dan aangesproken met “Geachte mevrouw” of “Geachte heer”.

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
      | Eigen                 | Man                 | GA VV GN            | H. in het Veld            | Geachte heer in het Veld               |
      | Eigen                 | Man                 | GA VV GN            | F. Groenen                | Geachte heer Groenen                   |
      | Partner na eigen      | Vrouw               | GA VV GN-VP GP      | I. van Velzen-in het Veld | Geachte mevrouw van Velzen-in het Veld |
      | Partner na eigen      | Vrouw               | GA VV GN-VP GP      | F. Groenen-Groenink       | Geachte mevrouw Groenen-Groenink       |
      | Partner               | Vrouw               | GA VP GP            | S. van Velzen             | Geachte mevrouw van Velzen             |
      | Partner               | Vrouw               | GA VP GP            | J.F.R. Groenen            | Geachte mevrouw Groenen                |
      | Partner voor eigen    | Man                 | GA VP GP-VV GN      | F. in het Veld-van Velzen | Geachte heer in het Veld-van Velzen    |
      | Partner voor eigen    | Man                 | GA VP GP-VV GN      | F. Groenen-Groenlo        | Geachte heer Groenen-Groenlo           |

    Voorbeelden: adelijke titels en predikaat
      | adellijkeTitel_predikaat | aanduidingNaamgebruik |samenstelling aanhef | aanschrijfwijze                             | aanhef                                           |
      | Baron                    | Eigen                 | GA VV GN            | H.W. baron van den Aedel                    | Hoogwelgeboren heer van den Aedel                |
      | Barones                  | Partner na eigen      | GA VV GN-VP GP      | W. barones van den Aedel-van der Veen       | Hoogwelgeboren vrouwe van den Aedel-van der Veen |
      | Graaf                    | Partner               | GA VP GP            | F. van der Veen                             | Geachte heer van der Veen                    |
      | Gravin                   | Partner voor eigen    | GA VP GP-AT VV GN   | E.L. van der Veen-gravin van den Aedel      | Hooggeboren vrouwe van der Veen-van den Aedel    |
      | Hertog                   | Eigen                 | GA VV GN            | F.W. hertog van Aedel                       | Hoogwelgeboren heer van den Aedel                |
      | Hertogin                 | Partner na eigen      | GA VV GN-VP GP      | C.A. hertogin van den Aedel-van der Veen    | Hoogwelgeboren vrouwe van den Aedel-van der Veen |
      | Markies                  | Partner               | GA VP GP            | G.K.A. markies van der Veen                 | Geachte heer van der Veen                 |
      | Markiezin                | Partner voor eigen    | GA VP GP-AT VV GN   | Y.L.C. van der Veen-markiezin van den Aedel | Hoogwelgeboren vrouwe van der Veen-van den Aedel |
      | Jonkheer                 | Eigen                 | GA VV GN            | Jonkheer T. van Hoogh                       | Hoogwelgeboren heer van Hoogh                    |
      | Jonkvrouw                | Partner na eigen      | GA VV GN-VP GP      | Jonkvrouw C. van Hoogh-van der Berg         | Hoogwelgeboren vrouwe van Hoogh-van der Berg     |
      | Jonkheer                 | Partner               | GA VP GP            | B. van der Berg                             | Geachte heer van der Berg                 |
      | Jonkvrouw                | Partner voor eigen    | GA VP GP-VV GN      | E. van der Berg-van Hoogh                   | Hoogwelgeboren vrouwe van der Berg-van Hoogh     |
      | Prins                    | Eigen                 | GA VV GN            | O.B.B. prins van Roodt de Wit Blaauw        | Hoogheid van Roodt de Wit Blaauw                 |
      | Prinses                  | Eigen                 | GA VV GN            | E.M.V. prinses van Roodt de Wit Blaauw      | Hoogheid van Roodt de Wit Blaauw                 |
      | Ridder                   | Eigen                 | GA VV GN            | M. ridder van Hoogh                         | Hoogwelgeboren heer van Hoogh                    |
