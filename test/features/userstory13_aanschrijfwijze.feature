# User story #13
# Test het algoritme voor het samenstellen van attribuut aanschrijfwijze
# Zie de [specificatie van het algotitme](https://github.com/VLG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/Aanschijfwijze%20opstellen.md).

# In onderstaande tabellen betekenen de afkortingen:
# VL = voorletters
# VV = voorvoegselGeslachtsnaam
# GN = geslachtsnaam
# VP = voorvoegselGeslachtsnaam partner
# GP = geslachtsnaam partner
# AT = adelijke titel
# PK = predikaat

Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Abstract Scenario: De aanschrijfwijze wordt samengesteld op basis van aanduidingAanschrijving en naamgegevens van de persoon en de partner
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=<geslachtsnaam>&voornamen=<voornamen>
    Dan heeft elke van de gevonden ingeschrevennatuurlijkpersonen naamgebruik.aanschrijfwijze=<aanschrijfwijze>

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

    Voorbeelden: voornamen naar voorletters
      | testsituatie | geslachtsnaam | voornamen | aanschrijfwijze |
      | Voornaam met twee-letter klank        | Groenen  | Theo Philip IJsbrand | T.P.I. Groenen |
      | Dubbele voornaam met verbindingsteken | Groenen  | Anne-Fleur Belle     | A.B. Groenen |

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
      | AT | AT | P | VL VP GP          | Stand | Elisabeth      | E . van den Aedel |
      | AT | AT | V | VL VP GP-AT VV GN | Aedel | Irene          | I. van Stand-markiezin van den Aedel |
