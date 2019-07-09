# language: nl

# Issue #334 en #337
Functionaliteit: Als gemeente wil ik de juiste en consistent naamgebruik in een lopende tekst
  Attribuut gebruikInLopendeTekst bij een ingeschreven persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen benoemen.

  Dit attribuut kan worden gebruikt in bijvoorbeeld een zin in een brief als "In uw brief van 12 mei jongstleden, geeft u het overlijden van uw vader, de heer in het Veld, aan.", waarbij "de heer in het Veld" gehaald is uit attribuut gebruikInLopendeTekst.

  Attribuut gebruikInLopendeTekst wordt samengesteld op basis van:
  - voorvoegselGeslachtsnaam
  - geslachtsnaam
  - voorvoegselGeslachtsnaam partner
  - geslachtsnaam partner
  - aanduidingAanschrijving
  - adellijkeTitel_predikaat
  - geslachtsaanduiding

  De waarde van aanduidingNaamgebruik bepaalt hoe de gebruikInLopendeTekst wordt samengesteld uit de naam van de persoon en de naam van de partner.

  Wanneer er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn en de aanschijfwijze is ongelijk aan 'E', dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.
  Wanneer er meerdere ontbonden huwelijken/partnerschappen zijn en er geen actueel (niet ontbonden) huwelijk/partnerschap is en de aanschijfwijze is ongelijk aan 'E', wordt als partnernaam de naam van de laatst ontbinden relatie gebruikt.

  Wanneer de persoon geen adellijke titel of predikaat heeft, wordt de gebruikInLopendeTekst samengesteld met een geslachtsaanduiding ("mevrouw", "de heer").

  Op basis van attribuut adellijkeTitel_predikaat wordt het de adelijke titel of het predikaat toegevoegd in gebruikInLopendeTekst.
    Als de betrokkene beschikt over een adellijke titel of predikaat, Dan wordt deze geplaatst vóór het voorvoegsel van de geslachtsnaam.
    Als de betrokkene beschikt over een adellijke titel of predikaat, Dan wordt deze opgenomen zoals genoemd in kolom "Omschrijving" in GBA tabel 38 "Adellijke titel/predikaat", geschreven in kleine letters.
    Als de echtgenoot/partner beschikt over een predikaat of adellijke titel, Dan wordt bij gebruik van de achternaam van de echtgenoot/partner het predikaat of de titel van de echtgenoot/partner niet meegenomen.
    Als betrokkene zelf beschikt over een adellijke titel, En betrokkene gebruikt de achternaam van de echtgenoot/partner gevolgd door de eigen naam (aanduidingAanschrijving="V"), Dan wordt de titel van betrokkene voor de eigen achternaam geplaatst.
    Als betrokkene de achternaam van de echtgenoot/partnergebruikt (aanduidingAanschrijving="P"), Dan wordt het predikaat niet gebruikt En wordt gebruikInLopendeTekst voorafgegaan door een geslachtsaanduiding (mevrouw of de heer).
    Als de betrokkene beschikt over een predikaat EN betrokkene gebruikt de achternaam van de echtgenoot/partner gevolgd door de eigen naam (aanduidingAanschrijving="V"), Dan wordt het predikaat niet gebruikt En wordt gebruikInLopendeTekst voorafgegaan door een geslachtsaanduiding (mevrouw of de heer).

  Abstract Scenario: De aanhef wordt samengesteld op basis van geslachtsaanduiding en naamgegevens van de persoon en de partner
    Als ingeschreven persoon wordt geraadpleegd
    Dan heeft de gevonden ingeschrevenpersoon naam.gebruikInLopendeTekst=<gebruikInLopendeTekst>

    # In onderstaande tabellen betekenen de afkortingen:
    # T = adelijke titel of predikaat, dan wel "de heer" of "mevrouw"
    # VV = voorvoegselGeslachtsnaam
    # GN = geslachtsnaam
    # VP = voorvoegselGeslachtsnaam partner
    # GP = geslachtsnaam partner
    # AT = adelijke titel
    # PK = predikaat

    Voorbeelden: geen adellijke titel of predikaat
      | aanduidingNaamgebruik | geslachtsaanduiding |samenstelling gebruikInLopendeTekst | aanschrijfwijze           | gebruikInLopendeTekst          |
      | Eigen                 | Man                 | T VV GN                            | H. in het Veld            | de heer in het Veld            |
      | Eigen                 | Man                 | T VV GN                            | F. Groenen                | de heer Groenen                |
      | Partner na eigen      | Vrouw               | T VV GN-VP GP                      | I. van Velzen-in het Veld | mevrouw van Velzen-in het Veld |
      | Partner na eigen      | Vrouw               | T VV GN-VP GP                      | F. Groenen-Groenink       | mevrouw Groenen-Groenink       |
      | Partner               | Vrouw               | T VP GP                            | S. van Velzen             | mevrouw van Velzen             |
      | Partner               | Vrouw               | T VP GP                            | J.F.R. Groenen            | mevrouw Groenen                |
      | Partner voor eigen    | Man                 | T VP GP-VV GN                      | F. in het Veld-van Velzen | de heer in het Veld-van Velzen |
      | Partner voor eigen    | Man                 | T VP GP-VV GN                      | F. Groenen-Groenlo        | de heer Groenen-Groenlo        |

    Voorbeelden: adelijke titels en predikaat
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | geslachtsaanduiding | samenstelling aanhef | aanschrijfwijze                             | gebruikInLopendeTekst                        |
      | Baron                    | Eigen                 | Man                 | T VV GN              | H.W. baron van den Aedel                    | baron van den Aedel                          |
      | Barones                  | Partner na eigen      | Vrouw               | T VV GN-VP GP        | W. barones van den Aedel-van der Veen       | barones van den Aedel-van der Veen           |
      | Graaf                    | Partner               | Man                 | T VP GP              | F. van der Veen                             | de heer van der Veen                         |
      | Gravin                   | Partner voor eigen    | Vrouw               | T VP GP-AT VV GN     | E.L. van der Veen-gravin van den Aedel      | mevrouw van der Veen-gravin van den Aedel    |
      | Hertog                   | Eigen                 | Man                 | T VV GN              | F.W. hertog van Aedel                       | hertog van den Aedel                         |
      | Hertogin                 | Partner na eigen      | Vrouw               | T VV GN-VP GP        | C.A. hertogin van den Aedel-van der Veen    | hertogin van den Aedel-van der Veen          |
      | Markies                  | Partner               | Man                 | T VP GP              | G.K.A. markies van der Veen                 | markies van der Veen                         |
      | Markiezin                | Partner voor eigen    | Vrouw               | T VP GP-AT VV GN     | Y.L.C. van der Veen-markiezin van den Aedel | mevrouw van der Veen-markiezin van den Aedel |
      | Jonkheer                 | Eigen                 | Man                 | T VV GN              | Jonkheer T. van Hoogh                       | jonkheer van Hoogh                           |
      | Jonkvrouw                | Partner na eigen      | Vrouw               | T VV GN-VP GP        | Jonkvrouw C. van Hoogh-van der Berg         | Jonkvrouw van Hoogh-van der Berg             |
      | Jonkheer                 | Partner               | Man                 | T VP GP              | B. van der Berg                             | de heer van der Berg                         |
      | Jonkvrouw                | Partner voor eigen    | Vrouw               | T VP GP-VV GN        | E. van der Berg-van Hoogh                   | mevrouw van der Berg-van Hoogh               |
      | Prins                    | Eigen                 | Man                 | T VV GN              | O.B.B. prins van Roodt de Wit Blaauw        | prins van Roodt de Wit Blaauw                |
      | Prinses                  | Eigen                 | Vrouw               | T VV GN              | E.M.V. prinses van Roodt de Wit Blaauw      | prinses van Roodt de Wit Blaauw              |
      | Ridder                   | Eigen                 | Man                 | T VV GN              | M. ridder van Hoogh                         | ridder van Hoogh                             |
