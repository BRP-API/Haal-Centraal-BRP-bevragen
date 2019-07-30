# language: nl

# User story #13
Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  Attribuut aanschrijfwijze bij een ingeschreven persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven. Bij het samenstellen van de aanschrijfwijze worden academische titels voorAlsnog niet opgenomen. Academische titels zijn geen authentiek gegeven en daarom buiten scope geplaatst.

  Attribuut aanschrijfwijze wordt samengesteld op basis van:
  - voornamen (wordt omgezet naar voorletters)
  - voorvoegselGeslachtsnaam
  - geslachtsnaam
  - voorvoegselGeslachtsnaam partner
  - geslachtsnaam partner
  - aanduidingAanschrijving
  - adellijkeTitel_predikaat

  De waarde van aanduidingAanschrijving bepaalt hoe de aanschrijfwijze wordt samengesteld uit de naam van de persoon en de naam van de partner. Zie de tabel "Voorbeelden: met tussenvoegsel" en "Voorbeelden: met tussenvoegsel" hieronder.

  Wanneer er geen tussenvoegsel is, wordt deze niet opgenomen. Er zit dan één spatie tussen de voorletters en de geslachtsnaam. Zie de tabel "Voorbeelden: met tussenvoegsel" en "Voorbeelden: met tussenvoegsel" hieronder.

  Wanneer er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn en de aanschijfwijze is ongelijk aan 'E', dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.

  Wanneer er meerdere ontbonden huwelijken/partnerschappen zijn en er geen actueel (niet ontbonden) huwelijk/partnerschap is en de aanschijfwijze is ongelijk aan 'E', wordt als partnernaam de naam van de laatst ontbinden relatie gebruikt.

  De voorletters worden opgenomen zoals beschreven in Voorletters.feature.

  Op basis van attribuut adellijkeTitel_predikaat wordt het de adelijke titel of het predikaat toegevoegd in de aanschrijfwijze. Zie ook de tabel "Voorbeelden: adelijke titels en predikaat" hieronder.
    Als de betrokkene beschikt over een predikaat, Dan wordt deze geplaatst vóór de voorletters.
    Als de betrokkene over een adelijke titel beschikt, Dan wordt de adelijke titel geplaatst tussen voorletters en achternaam (tussenvoegsel en geslachtsnaam).
    Als de betrokkene beschikt over een predikaat, Dan wordt deze opgenomen zoals genoemd in kolom "Omschrijving" in GBA tabel 38 "Adellijke titel/predikaat".
    Als de betrokkene beschikt over een adelijke titel, Dan wordt deze opgenomen zoals genoemd in kolom "Omschrijving" in GBA tabel 38 "Adellijke titel/predikaat", geschreven in kleine letters.
    Als de echtgenoot/partner beschikt over een predikaat of adellijke titel, Dan wordt bij gebruik van de achternaam van de echtgenoot/partner het predikaat of de titel van de echtgenoot/partner niet meegenomen.
    Als betrokkene zelf beschikt over een adellijke titel, EN betrokkene gebruikt de achternaam van de echtgenoot/partner gevolgd door de eigen naam (aanduidingAanschrijving="V"), Dan wordt de titel van betrokkene voor de eigen achternaam geplaatst.
    Als betrokkene de achternaam van de echtgenoot/partnergebruikt (aanduidingAanschrijving="P"), Dan wordt het predikaat niet gebruikt.
    Als de betrokkene beschikt over een predikaat EN betrokkene gebruikt de achternaam van de echtgenoot/partner gevolgd door de eigen naam (aanduidingAanschrijving="V"), Dan wordt het predikaat niet gebruikt.

  # Om de onderstaande scenario's te kunnen gebruiken in een geautomatiseerde test van de API, moeten bij de API bepaalde personen bekend zijn. Dit staat beschreven in "testdata.csv".
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Abstract Scenario: De aanschrijfwijze wordt samengesteld op basis van aanduidingAanschrijving en naamgegevens van de persoon en de partner
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=<geslachtsnaam>&naam__voornamen=<voornamen>&geboorte__datum=1983-05-26
    Dan heeft elke van de gevonden ingeschrevenpersonen naam.aanschrijfwijze=<aanschrijfwijze>

    # In onderstaande tabellen betekenen de afkortingen:
    # VL = voorletters
    # VV = voorvoegselGeslachtsnaam
    # GN = geslachtsnaam
    # VP = voorvoegselGeslachtsnaam partner
    # GP = geslachtsnaam partner
    # AT = adelijke titel
    # PK = predikaat

    Voorbeelden: met tussenvoegsel
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze |
      | E | VL VV GN          | Veld   | Henk    | H. in het Veld |
      | N | VL VV GN-VP GP    | Velzen | Ingrid  | I. van Velzen-in het Veld |
      | P | VL VP GP          | Veld   | Suzanne | S. van Velzen |
      | V | VL VP GP-VV GN    | Velzen | Fred    | F. in het Veld-van Velzen |

    Voorbeelden: zonder tussenvoegsel
      | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze |
      | E | VL GN    | Groenen  | Franklin           | F. Groenen |
      | N | VL GN-GP | Groenen  | Franka             | F. Groenen-Groenink |
      | P | VL GP    | Groenink | Johan Frank Robert | J.F.R. Groenen |
      | V | VL GP-GN | Groenlo  | Franka             | F. Groenen-Groenlo |

    Voorbeelden: adelijke titels en predikaat
      | adellijkeTitel_predikaat | adellijkeTitel_predikaat partner | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze |
      | -  | AT | E | VL VV GN          | Veen  | Johannes       | J. van der Veen |
      | -  | AT | N | VL VV GN-VP GP    | Veen  | Anna Cornelia  | A.C. van der Veen-van den Aedel |
      | -  | AT | P | VL VP GP          | Veen  | Ruud           | R. van den Aedel |
      | -  | AT | V | VL VP GP-VV GN    | Veen  | Maria          | M. van den Aedel-van der Veen |
      | -  | PK | E | VL VV GN          | Berg  | Sjaak          | S. van der Berg |
      | -  | PK | N | VL VV GN-VP GP    | Berg  | Peter          | P. van der Berg-van Hoogh |
      | -  | PK | P | VL VP GP          | Berg  | Marlies        | M. van Hoogh |
      | -  | PK | V | VL VP GP-VV GN    | Berg  | Fleur          | F. van Hoogh-van der Berg |
      | AT | -  | E | VL AT VV GN       | Aedel | Hendrik Willem | H.W. graaf van den Aedel |
      | AT | -  | N | VL AT VV GN-VP GP | Aedel | Wilhelmina     | W. gravin van den Aedel-van der Veen |
      | AT | -  | P | VL VP GP          | Aedel | Frederique     | F. van der Veen |
      | AT | -  | V | VL VP GP-AT VV GN | Aedel | Emma Louise    | E.L. van der Veen-hertogin van den Aedel |
      | PK | -  | E | PK VL VV GN       | Hoogh | Tim            | Jonkheer T. van Hoogh |
      | PK | -  | N | PK VL VV GN-VP GP | Hoogh | Charlotte      | Jonkvrouw C. van Hoogh-van der Berg |
      | PK | -  | P | VL VP GP          | Hoogh | Belle          | B. van der Berg |
      | PK | -  | V | VL VP GP-VV GN    | Hoogh | Erik           | E. van der Berg-van Hoogh |
      | AT | AT | N | VL AT VV GN-VP GP | Aedel | Constantijn    | C. baron van den Aedel-van Stand |
      | AT | AT | P | VL VP GP          | Stand | Elisabeth      | E. van den Aedel |
      | AT | AT | V | VL VP GP-AT VV GN | Aedel | Irene          | I. van Stand-markiezin van den Aedel |

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
