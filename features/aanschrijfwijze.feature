# language: nl

# User story #13
Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  Attribuut aanschrijfwijze bij een persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven. Bij het samenstellen van de aanschrijfwijze worden academische titels vooralsnog niet opgenomen. Academische titels zijn geen authentiek gegeven en daarom buiten scope geplaatst.
  De aanschrijfwijze wordt gebruikt als eerste regel in de adressering op een envelop, of links bovenaan een brief, direct boven het adres.
  Bij personen met een adellijke titel of predikaat wordt ook regelVoorafgaandAanAanschrijfwijze gevuld. Deze wordt in de adressering in de regel boven aanschrijfwijze geplaatst om een correcte aanschrijving van een adellijke persoon samen te stellen.
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

  Op basis van attribuut adellijkeTitel_predikaat en de geslachtsaanduiding wordt de adelijke titel of het predikaat toegevoegd in de aanschrijfwijze.
  De adellijke titel of het predikaat wordt in aanschrijfwijze opgenomen in de vorm die hoort bij de geslachtsaanduiding:
  | adellijkeTitel_predikaat | vrouw     | man      | onbekend |
  | Graaf	                   | gravin    | graaf    | -   |
  | Gravin                   | gravin    | graaf    | -   |
  | Baron	                   | barones   | baron    | -   |
  | Barones                  | barones   | baron    | -   |
  | Hertog                   | hertogin  | hertog   | -   |
  | Hertogin                 | hertogin  | hertog   | -   |
  | Markies                  | markiezin | markies  | -   |
  | Markiezin                | markiezin | markies  | -   |
  | Prins	                   | prinses   | prins    | -   |
  | Prinses                  | prinses   | prins    | -   |
  | Ridder                   | -         | ridder   | -   |
  | Jonkheer                 | jonkvrouw | jonkheer | -   |
  | Jonkvrouw                | jonkvrouw | jonkheer | -   |

  Als de adellijke titel geen vorm heeft die hoort bij de geslachtsaanduiding (in bovenstaande tabel opgenomen als - teken)
  Dan wordt de adellijke titel niet opgenomen in de aanschrijfwijze.

  Als de geslachtsaanduiding is "onbekend" (O) of er is geen waarde voor geslachtsaanduiding
  Dan wordt de (eventuele) adellijke titel of het predikaat niet opgenomen in de aanschrijfwijze.

  Als de persoon beschikt over een predikaat
  En de aanduiding aanschrijving is gelijk aan "E" (eigen) of "N" (partner na eigen geslachtsnaam)
  Dan wordt deze geplaatst vóór de voorletters
  En begin het predikaat in de aanschrijfwijze met een hoofdletter (J).

  Als de persoon beschikt over een predikaat
  En de aanduiding aanschrijving is gelijk aan "V" (partner voor eigen geslachtsnaam)
  Dan wordt deze geplaatst vóór het eigen voorvoegsel en geslachtsnaam
  En begin het predikaat in de aanschrijfwijze met een kleine letter (j).

  Als de persoon beschikt over een predikaat
  En de aanduiding aanschrijving is gelijk aan "P" (partner)
  Dan wordt het predikaat niet gebruikt.

  Als de persoon over een adelijke titel beschikt
  Dan wordt de adelijke titel geplaatst tussen voorletters en achternaam (voorvoegsel en geslachtsnaam).

  Als de persoon zelf beschikt over een adellijke titel
  En de persoon gebruikt de geslachtsnaam van de echtgenoot/partner in combinatie met de eigen achternaam
  Dan wordt de titel van betrokkene voor de eigen achternaam geplaatst.

  Als de persoon zelf beschikt over een adellijke titel
  En de persoon de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam (aanduiding aanschrijving is "P" - "partner")
  Dan wordt de adellijke titel niet gebruikt.

  Als de partner een adellijke titel heeft
  En de geslachtsaanduiding van de persoon is "vrouw"
  En de geslachtsaanduiding van de partner is "man"
  En de adellijke titel van de partner heeft een vrouwelijke vorm (zie tabel hieronder)
  En de persoon gebruikt de naam van haar partner (aanduidingNaamgebruik ongelijk aan "E" - "eigen")
  Dan wordt de adellijke titel van de partner in vrouwelijke vorm opgenomen voor het voorvoegsel van de naam van de partner
  | Titel | Vrouwelijke vorm |
  | Graaf	| gravin           |
  | Baron	| barones          |
  | Prins	| prinses          |

  Als de persoon een adellijke titel of predikaat heeft, wordt de regelVoorafgaandAanAanschrijfwijze bepaald op basis van adellijkeTitel_predikaat en de geslachtsaanduiding volgens de volgende tabel:
  | adellijkeTitel_predikaat | geslachtsaanduiding | regelVoorafgaandAanAanschrijfwijze |
  | Baron, Barones           | man                 | De hoogwelgeboren heer   |
  | Baron, Barones           | vrouw               | De hoogwelgeboren vrouwe |
  | Graaf, Gravin            | man                 | De hooggeboren heer      |
  | Graaf, Gravin            | vrouw               | De hooggeboren vrouwe    |
  | Hertog, Hertogin         | man                 | De hoogwelgeboren heer   |
  | Hertog, Hertogin         | vrouw               | De hoogwelgeboren vrouwe |
  | Jonkheer, Jonkvrouw      | man                 | De hoogwelgeboren heer   |
  | Jonkheer, Jonkvrouw      | vrouw               | De hoogwelgeboren vrouwe |
  | Markies, Markiezin       | man                 | De hoogwelgeboren heer   |
  | Markies, Markiezin       | vrouw               | De hoogwelgeboren vrouwe |
  | Prins, Prinses           | man                 | De hoogheid              |
  | Prins, Prinses           | vrouw               | De hoogheid              |
  | Prins, Prinses           | onbekend            | De hoogheid              |
  | Ridder                   | man                 | De hoogwelgeboren heer   |
  | Ridder                   | vrouw               | De hoogwelgeboren vrouwe |

  Als de persoon een predikaat heeft
  En de geslachtsaanduiding is gelijk aan "vrouw"
  En betrokkene is getrouwd of heeft een geregistreerd partnerschap
  En het huwelijk dan wel geregistreerd partnerschap is niet beëindigd of ontbonden
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  Als de persoon een predikaat heeft
  En de geslachtsaanduiding is gelijk aan "vrouw"
  En de persoon is getrouwd geweest of heeft een geregistreerd partnerschap gehad
  En het huwelijk dan wel geregistreerd partnerschap is beëindigd of ontbonden
  En de (ex)partnernaam wordt nog gebruikt (aanduiding naamgebruik is "V", "N" of "P")
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  Als de persoon een adellijke titel of predikaat heeft
  En de geslachtsaanduiding is gelijk aan "onbekend" of er is geen waarde voor geslachtsaanduiding
  En de adellijke titel is ongelijk aan "prins" of "prinses" ("De hoogheid" is gender neutraal dus kan ook bij onbekend geslacht gebruikt worden)
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  Als de persoon geen adellijke titel of predikaat heeft
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  Als de persoon een adellijke titel of predikaat heeft
  En betrokkene de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam (aanduiding aanschrijving is "P" - "partner")
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.


  Abstract Scenario: De aanschrijfwijze wordt samengesteld op basis van aanduidingAanschrijving en naamgegevens van de persoon en de partner
    Als persoon wordt geraadpleegd
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
      | geslachtsaanduiding | aanduidingAanschrijving | samenstelling aanschrijfwijze | adellijkeTitel_predikaat | geslachtsnaam | voornamen | aanschrijfwijze | regelVoorafgaandAanAanschrijfwijze |
      | man      | E | VL AT VV GN       | Baron   | Aedel | Hendrik Willem | H.W. baron van den Aedel               | De hoogwelgeboren heer   |
      | vrouw    | N | VL AT VV GN-VP GP | Gravin  | Aedel | Wilhelmina     | W. gravin van den Aedel-van der Veen   | De hooggeboren vrouwe    |
      | vrouw    | P | VL VP GP          | Barones | Aedel | Frederique     | F. van der Veen                        | -                        |
      | vrouw    | V | VL VP GP-AT VV GN | Gravin  | Aedel | Emma Louise    | E.L. van der Veen-gravin van den Aedel | De hooggeboren vrouwe    |
      | man      | E | VL AT VV GN       | Barones | Aedel | Johan          | J. baron van den Aedel                 | De hoogwelgeboren heer   |
      | vrouw    | N | VL AT VV GN-VP GP | Graaf   | Aedel | Wilhelmina     | W. gravin van den Aedel-van der Veen   | De hooggeboren vrouwe    |
      | vrouw    | P | VL VP GP          | Barones | Aedel | Frederique     | F. van der Veen                        | -                        |
      | vrouw    | V | VL VP GP-AT VV GN | Baron   | Aedel | Erica          | E. van der Veen-barones van den Aedel  | De hoogwelgeboren vrouwe |
      | vrouw    | E | VL AT VV GN       | Ridder  | Aedel | Michael        | M. van den Aedel                       | -                        |
      | onbekend | E | VL VV GN          | Barones | Aedel | Johanna        | J. van den Aedel                       | -                        |
      | onbekend | V | VL VP GP-AT VV GN | Ridder  | Aedel | Simon          | S. van der Veen-van den Aedel          | -                        |

    Voorbeelden: betrokkene heeft een predikaat en partner heeft geen adellijke titel
      | geslacht | adellijkeTitel_predikaat | aanduidingNaamgebruik | partner | Ontbinding huwelijk/geregistreerd partnerschap | aanschrijfwijze | regelVoorafgaandAanAanschrijfwijze |
      | man      | Jonkheer                 | Eigen                 | Geen    | Geen | Jonkheer T. van Hoogh              | De hoogwelgeboren heer   |
      | man      | Jonkheer                 | Eigen                 | Ja      | Geen | Jonkheer T. van Hoogh              | De hoogwelgeboren heer   |
      | vrouw    | Jonkvrouw                | Eigen                 | Geen    | Geen | Jonkvrouw T. van Hoogh             | De hoogwelgeboren vrouwe |
      | vrouw    | Jonkvrouw                | Eigen                 | Ja      | Geen | Jonkvrouw T. van Hoogh             | -                        |
      | vrouw    | Jonkvrouw                | Eigen                 | Ja      | Ja   | Jonkvrouw T. van Hoogh             | De hoogwelgeboren vrouwe |
      | vrouw    | Jonkheer                 | Eigen                 | Geen    | Geen | Jonkvrouw T. van Hoogh             | De hoogwelgeboren vrouwe |
      | vrouw    | Jonkheer                 | Eigen                 | Ja      | Geen | Jonkvrouw T. van Hoogh             | -                        |
      | onbekend | Jonkvrouw                | Eigen                 | Geen    | Geen | T. van Hoogh                       | -                        |
      | vrouw    | Jonkvrouw                | Partner na eigen      | Ja      | Geen | Jonkvrouw T. van Hoogh-in het Veld | -                        |
      | vrouw    | Jonkvrouw                | Partner na eigen      | Ja      | Ja   | Jonkvrouw T. van Hoogh-in het Veld | -                        |
      | man      | Jonkheer                 | Partner na eigen      | Ja      | Geen | Jonkheer T. van Hoogh-in het Veld  | De hoogwelgeboren heer   |
      | vrouw    | Jonkvrouw                | Partner               | Ja      | Geen | T. in het Veld                     | -                        |
      | vrouw    | Jonkvrouw                | Partner               | Ja      | Ja   | T. in het Veld                     | -                        |
      | man      | Jonkheer                 | Partner               | Geen    | Geen | T. in het Veld                     | -                        |
      | vrouw    | Jonkvrouw                | Partner voor eigen    | Ja      | Geen | T. in het Veld-jonkvrouw van Hoogh | -                        |
      | vrouw    | Jonkheer                 | Partner voor eigen    | Ja      | Geen | T. in het Veld-jonkvrouw van Hoogh | -                        |
      | man      | Jonkvrouw                | Partner voor eigen    | Ja      | Geen | T. in het Veld-jonkheer van Hoogh  | De hoogwelgeboren heer   |
      | onbekend | Jonkvrouw                | Partner voor eigen    | Ja      | Geen | T. in het Veld-van Hoogh           | -                        |

    Voorbeelden: partner heeft een adellijke titel
      | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze | regelVoorafgaandAanAanschrijfwijze |
      | vrouw | man   | Baron  | E | VL VV GN          | Veen  | Anna Cornelia  | A.C. van der Veen                       | - |
      | vrouw | man   | Baron  | N | VL VV GN-AP VP GP | Veen  | Anna Cornelia  | A.C. van der Veen-barones van den Aedel | - |
      | vrouw | man   | Baron  | P | VL AP VP GP       | Veen  | Anna Cornelia  | A.C. barones van den Aedel              | - |
      | vrouw | man   | Baron  | P | VL AP VP GP       | Veen  | Anna Cornelia  | A.C. barones van den Aedel              | - |
      | vrouw | man   | Baron  | V | VL AP VP GP-VV GN | Veen  | Anna Cornelia  | A.C. barones van den Aedel-van der Veen | - |
      | vrouw | man   | Prins  | E | VL VV GN          | Veen  | Anna Cornelia  | A.C. van der Veen                       | - |
      | vrouw | man   | Prins  | N | VL VV GN-AP VP GP | Veen  | Anna Cornelia  | A.C. van der Veen-prinses van den Aedel | - |
      | vrouw | man   | Prins  | P | VL AP VP GP       | Veen  | Anna Cornelia  | A.C. prinses van den Aedel              | - |
      | vrouw | man   | Prins  | V | VL AP VP GP-VV GN | Veen  | Anna Cornelia  | A.C. prinses van den Aedel-van der Veen | - |
      | man   | vrouw | Gravin | E | VL VV GN          | Veen  | Johannes       | J. van der Veen                         | - |
      | man   | vrouw | Gravin | N | VL VV GN-VP GP    | Veen  | Johannes       | J. van der Veen-van den Aedel           | - |
      | man   | vrouw | Gravin | P | VL VP GP          | Veen  | Johannes       | J. van den Aedel                        | - |
      | man   | vrouw | Gravin | V | VL VP GP-VV GN    | Veen  | Johannes       | J. van den Aedel-van der Veen           | - |
      | vrouw | man   | Ridder | E | VL VV GN          | Veen  | Marlies        | M. van der Veen                         | - |
      | vrouw | man   | Ridder | N | VL VV GN-VP GP    | Veen  | Marlies        | M. van der Veen-van den Aedel           | - |
      | vrouw | man   | Ridder | P | VL VP GP          | Veen  | Marlies        | M. van den Aedel                        | - |
      | vrouw | man   | Ridder | V | VL VP GP-VV GN    | Veen  | Marlies        | M. van den Aedel-van der Veen           | - |
      | vrouw | vrouw | Gravin | E | VL VV GN          | Veen  | Sarah          | S. van der Veen                         | - |
      | vrouw | vrouw | Gravin | N | VL VV GN-VP GP    | Veen  | Sarah          | S. van der Veen-van den Aedel           | - |
      | vrouw | vrouw | Gravin | V | VL VP GP-VV GN    | Veen  | Sarah          | S. van den Aedel-van der Veen           | - |
      | man   | man   | Baron  | E | VL VV GN          | Veen  | Willem         | W. van der Veen                         | - |
      | man   | man   | Baron  | N | VL VV GN-VP GP    | Veen  | Willem         | W. van der Veen-van den Aedel           | - |
      | man   | man   | Baron  | P | VL VP GP          | Veen  | Willem         | W. van den Aedel                        | - |
      | man   | man   | Baron  | V | VL VP GP-VV GN    | Veen  | Willem         | W. van den Aedel-van der Veen           | - |
      | onbekend | man   | Baron  | P | VL AP VP GP    | Veen  | Anna Cornelia  | A.C. van den Aedel                      | - |
      | vrouw | onbekend | Baron  | P | VL AP VP GP    | Veen  | Anna Cornelia  | A.C. van den Aedel                      | - |

    Voorbeelden: partner heeft een predikaat
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze | regelVoorafgaandAanAanschrijfwijze |
      | E | VL VV GN          | Berg  | Sjaak          | S. van der Berg | - |
      | N | VL VV GN-VP GP    | Berg  | Peter          | P. van der Berg-van Hoogh | - |
      | P | VL VP GP          | Berg  | Marlies        | M. van Hoogh | - |
      | V | VL VP GP-VV GN    | Berg  | Fleur          | F. van Hoogh-van der Berg | - |

    Voorbeelden: betrokkene heeft een adelijke titel en partner heeft een adellijke titel
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze | regelVoorafgaandAanAanschrijfwijze |
      | E | VL AT VV GN          | Aedel | Hendrik Willem | H.W. graaf van den Aedel                    | De hooggeboren heer        |
      | N | VL AT VV GN-AP VP GP | Aedel | Wilhelmina     | W. gravin van den Aedel-barones van Hoogh   | De hooggeboren vrouwe      |
      | P | VL AP VP GP          | Aedel | Frederique     | F. barones van Hoogh                        | -                          |
      | V | VL AP VP GP-AT VV GN | Aedel | Emma Louise    | E.L. barones van Hoogh-gravin van den Aedel | De hooggeboren vrouwe      |

  Scenario: meerdere actuele relaties
    Gegeven de persoon F.C. Groen is getrouwd in 1958 met Geel
    En de persoon is getrouwd in 1961 met Roodt
    En geen van beide relaties is beëindigd
    En de persoon heeft aanduidingAanschrijving='V'
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanschrijfwijze=F.C. Geel-Groen

  Scenario: meerdere ontbonden relaties gebruikt de laatst ontbonden relatie
    Gegeven de persoon J. Wit is getrouwd in 1958 met Geel
    En de persoon is getrouwd in 1961 met Roodt
    En het huwelijk met Geel is ontbonden in 1960
    En het huwelijk met Roodt is ontbonden in 2006
    En de persoon heeft aanduidingAanschrijving='V'
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanschrijfwijze=J. Roodt-Wit

  Scenario: meerdere ontbonden relaties en oudste relatie is het laatst ontbonden
    Gegeven de persoon de heer J. Wit is getrouwd in 1958 met Zwart
    En de persoon is getrouwd in 1961 met Blaauw
    En het huwelijk met Blaauw is ontbonden in 1983
    En het huwelijk met Zwart is ontbonden in 2006
    En de persoon heeft aanduidingAanschrijving='V'
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord naam.aanhef=J. Zwart-Wit
