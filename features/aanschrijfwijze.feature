# language: nl

# User story #13
Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  Attribuut aanschrijfwijze bij een ingeschreven persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven. Bij het samenstellen van de aanschrijfwijze worden academische titels voorAlsnog niet opgenomen. Academische titels zijn geen authentiek gegeven en daarom buiten scope geplaatst.
  De aanschrijfwijze wordt gebruikt als eerste regel in de adressering op een envelop, of links bovenaan een brief, direct boven het adres.
  De aanschrijfwijze kan ook worden gebruikt in lijsten met zoekresultaten, of op een website om te tonen op wie het betrekking heeft.

  Attribuut aanschrijfwijze wordt samengesteld op basis van:
  - voornamen (wordt omgezet naar voorletters)
  - adellijkeTitel_predikaat
  - voorvoegselGeslachtsnaam
  - geslachtsnaam
  - geslachtsaanduiding
  - aanduidingAanschrijving
  - voorvoegselGeslachtsnaam partner
  - geslachtsnaam partner
  - adellijkeTitel_predikaat partner
  - geslachtsaanduiding partner

  De waarde van aanduidingAanschrijving bepaalt hoe de aanschrijfwijze wordt samengesteld uit de naam van de persoon en de naam van de partner. Zie de tabel "Voorbeelden: met voorvoegsel" en "Voorbeelden: met voorvoegsel" hieronder.

  Wanneer er geen voorvoegsel is, wordt deze niet opgenomen. Er zit dan één spatie tussen de voorletters en de geslachtsnaam. Zie de tabel "Voorbeelden: met voorvoegsel" en "Voorbeelden: met voorvoegsel" hieronder.

  De voorletters worden opgenomen zoals beschreven in Voorletters.feature.

  Als er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn
  En de aanduiding aanschijving is ongelijk aan 'Eigen',
  Dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.

  Als er meerdere ontbonden huwelijken/partnerschappen zijn
  En er geen actueel (niet ontbonden) huwelijk/partnerschap is
  En de aanduiding aanschijving is ongelijk aan 'Eigen'
  Dan wordt als partnernaam de naam van de laatst ontbinden relatie gebruikt.

  Op basis van attribuut adellijkeTitel_predikaat wordt het de adelijke titel of het predikaat toegevoegd in de aanschrijfwijze. Zie ook de tabel "Voorbeelden: adelijke titels en predikaat" hieronder.
  Als de betrokkene beschikt over een predikaat
  Dan wordt deze geplaatst vóór de voorletters.
  Als de betrokkene over een adelijke titel beschikt
  Dan wordt de adelijke titel geplaatst tussen voorletters en achternaam (voorvoegsel en geslachtsnaam).
  Als de betrokkene beschikt over een predikaat of adelijke titel
  Dan wordt deze opgenomen zoals genoemd in kolom "Omschrijving" in GBA tabel 38 "Adellijke titel/predikaat", geschreven in kleine letters.
  Als betrokkene zelf beschikt over een adellijke titel
  En betrokkene gebruikt de geslachtsnaam van de echtgenoot/partner in combinatie met de eigen achternaam
  Dan wordt de titel van betrokkene voor de eigen achternaam geplaatst.
  Als betrokkene zelf beschikt over een adellijke titel
  En betrokkene de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam
  Dan wordt de adellijke titel niet gebruikt.
  Als betrokkene een predikaat heeft (jonkvrouw of jonkheer)
  En betrokkene is getrouwd of geregistreerd partnerschap of is getrouwd geweest of heeft geregistreerd partnerschap gehad
  Dan wordt het predikaat niet gebruikt.
  Als een vrouw als partner of echtgenoot een man met adellijke titel heeft
  En deze adellijke titel heeft een vrouwelijke vorm (zie tabel hieronder)
  Dan wordt die adellijke titel in vrouwelijke vorm opgenomen wanneer ze de naam van haar partner gebruikt.
  | Titel | Vrouwelijke vorm |
  | Graaf	| gravin           |
  | Baron	| barones          |
  | Prins	| prinses          |

  Als een man als partner of echtgenote een vrouw met adellijke titel heeft
  Dan wordt die adellijke titel in mannelijke vorm opgenomen wanneer hij de naam van haar partner gebruikt.
  | Titel   | Mannelijke vorm |
  | Gravin	| graaf           |
  | Barones	| baron           |
  | Prinses	| prins           |

  Als betrokkene en partner hetzelfde geslacht hebben Of de titel van de partner komt niet voor in bovenstaande tabellen (er is geen vrouwelijke vorm van de titel)
  Dan wordt de adellijke titel van de partner niet opgenomen.

  Abstract Scenario: De aanschrijfwijze wordt samengesteld op basis van aanduidingAanschrijving en naamgegevens van de persoon en de partner
    Als ingeschreven persoon wordt geraadpleegd
    Dan heeft de gevonden ingeschrevenpersoon naam.aanschrijfwijze=<aanschrijfwijze>

    # In onderstaande tabellen betekenen de afkortingen:
    # VL = voorletters
    # VV = voorvoegselGeslachtsnaam
    # GN = geslachtsnaam
    # VP = voorvoegselGeslachtsnaam partner
    # GP = geslachtsnaam partner
    # AT = adelijke titel
    # AP = adellijke titel partner (in andersgeslachtelijke vorm)
    # PK = predikaat

    Voorbeelden: met voorvoegsel
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | voorvoegsel | geslachtsnaam | voornamen | voorvoegsel partner | geslachtsnaam partner | aanschrijfwijze |
      | E | VL VV GN          | In het | Veld   | Henk    | van    | Velzen | H. In het Veld |
      | N | VL VV GN-VP GP    | van    | Velzen | Ingrid  | In het | Veld   | I. van Velzen-In het Veld |
      | P | VL VP GP          | In het | Veld   | Suzanne | van    | Velzen | S. van Velzen |
      | V | VL VP GP-VV GN    | van    | Velzen | Fred    | In het | Veld   | F. In het Veld-van Velzen |

    Voorbeelden: zonder voorvoegsel
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze |
      | E | VL GN    | Groenen  | Franklin           | F. Groenen |
      | N | VL GN-GP | Groenen  | Franka             | F. Groenen-Groenink |
      | P | VL GP    | Groenink | Johan Frank Robert | J.F.R. Groenen |
      | V | VL GP-GN | Groenlo  | Franka             | F. Groenen-Groenlo |

    Voorbeelden: betrokkene heeft een adelijke titel en partner heeft geen adellijke titel
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze |
      | E | VL AT VV GN       | Aedel | Hendrik Willem | H.W. graaf van den Aedel               |
      | N | VL AT VV GN-VP GP | Aedel | Wilhelmina     | W. gravin van den Aedel-van der Veen   |
      | P | VL VP GP          | Aedel | Frederique     | F. van der Veen                        |
      | V | VL VP GP-AT VV GN | Aedel | Emma Louise    | E.L. van der Veen-gravin van den Aedel |

    Voorbeelden: betrokkene heeft een predikaat en partner heeft geen adellijke titel
      | adellijkeTitel_predikaat | aanduidingNaamgebruik | soortVerbintenis | Ontbinding huwelijk/geregistreerd partnerschap | aanschrijfwijze          |
      | Jonkheer                 | Eigen                 | Geen             | Geen                                           | jonkheer T. van Hoogh    |
      | Jonkvrouw                | Eigen                 | Geen             | Geen                                           | jonkvrouw T. van Hoogh   |
      | Jonkheer                 | Eigen                 | Huwelijk         | Niet                                           | T. van Hoogh             |
      | Jonkheer                 | Eigen                 | Partnerschap     | Niet                                           | T. van Hoogh             |
      | Jonkheer                 | Eigen                 | Huwelijk         | Ja                                             | T. van Hoogh             |
      | Jonkvrouw                | Eigen                 | Huwelijk         | Niet                                           | T. van Hoogh             |
      | Jonkvrouw                | Partner na eigen      | Huwelijk         | Niet                                           | T. van Hoogh-in het Veld |
      | Jonkvrouw                | Partner               | Huwelijk         | Niet                                           | T. in het Veld           |
      | Jonkvrouw                | Partner voor eigen    | Huwelijk         | Niet                                           | T. in het Veld-van Hoogh |
      | Jonkvrouw                | Partner na eigen      | Huwelijk         | Ja                                             | T. van Hoogh-in het Veld |

    Voorbeelden: partner heeft een adellijke titel
      | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze |
      | V | M | Baron  | E | VL VV GN          | Veen  | Anna Cornelia  | A.C. van der Veen |
      | V | M | Baron  | N | VL VV GN-AP VP GP | Veen  | Anna Cornelia  | A.C. van der Veen-barones van den Aedel |
      | V | M | Baron  | P | VL AP VP GP       | Veen  | Anna Cornelia  | A.C. barones van den Aedel |
      | V | M | Baron  | V | VL AP VP GP-VV GN | Veen  | Anna Cornelia  | A.C. barones van den Aedel-van der Veen |
      | M | V | Gravin | E | VL VV GN          | Veen  | Johannes       | J. van der Veen |
      | M | V | Gravin | N | VL VV GN-AP VP GP | Veen  | Johannes       | J. van der Veen-graaf van den Aedel |
      | M | V | Gravin | P | VL AP VP GP       | Veen  | Johannes       | J. graaf van den Aedel |
      | M | V | Gravin | V | VL AP VP GP-VV GN | Veen  | Johannes       | J. graaf van den Aedel-van der Veen |
      | V | M | Ridder | E | VL VV GN          | Veen  | Marlies        | M. van der Veen |
      | V | M | Ridder | N | VL VV GN-VP GP    | Veen  | Marlies        | M. van der Veen-van den Aedel |
      | V | M | Ridder | P | VL VP GP          | Veen  | Marlies        | M. van den Aedel |
      | V | M | Ridder | V | VL VP GP-VV GN    | Veen  | Marlies        | M. van den Aedel-van der Veen |
      | V | V | Gravin | E | VL VV GN          | Veen  | Sarah          | S. van der Veen |
      | V | V | Gravin | N | VL VV GN-VP GP    | Veen  | Sarah          | S. van der Veen-van den Aedel |
      | V | V | Gravin | P | VL VP GP          | Veen  | Sarah          | S. van den Aedel |
      | V | V | Gravin | V | VL VP GP-VV GN    | Veen  | Sarah          | S. van den Aedel-van der Veen |

    Voorbeelden: partner heeft een predikaat
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze |
      | E | VL VV GN          | Berg  | Sjaak          | S. van der Berg |
      | N | VL VV GN-VP GP    | Berg  | Peter          | P. van der Berg-van Hoogh |
      | P | VL VP GP          | Berg  | Marlies        | M. van Hoogh |
      | V | VL VP GP-VV GN    | Berg  | Fleur          | F. van Hoogh-van der Berg |

    Voorbeelden: betrokkene heeft een adelijke titel en partner heeft een adellijke titel
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze |
      | E | VL AT VV GN          | Aedel | Hendrik Willem | H.W. graaf van den Aedel |
      | N | VL AT VV GN-AP VP GP | Aedel | Wilhelmina     | W. gravin van den Aedel-barones van Hoogh |
      | P | VL AP VP GP          | Aedel | Frederique     | F. barones van Hoogh |
      | V | VL AP VP GP-AT VV GN | Aedel | Emma Louise    | E.L. barones van Hoogh-gravin van den Aedel |

  Scenario: meerdere actuele relaties
    Gegeven de ingeschreven persoon F.C. Groen is getrouwd in 1958 met Geel
    En de ingeschreven persoon is getrouwd in 1961 met Roodt
    En geen van beide relaties is beëindigd
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanschrijfwijze=F.C. Geel-Groen

  Scenario: meerdere ontbonden relaties
    Gegeven de ingeschreven persoon J. Wit is getrouwd in 1958 met Geel
    En de ingeschreven persoon is getrouwd in 1961 met Roodt
    En het huwelijk met Geel is ontbonden in 1960
    En het huwelijk met Roodt is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanschrijfwijze=J. Roodt-Wit

    Gegeven de ingeschreven persoon de heer J. Wit is getrouwd in 1958 met Zwart
    En de ingeschreven persoon is getrouwd in 1961 met Blaauw
    En het huwelijk met Blaauw is ontbonden in 1983
    En het huwelijk met Zwart is ontbonden in 2006
    En de ingeschreven persoon heeft aanduidingAanschrijving='V'
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=J. Zwart-Wit
