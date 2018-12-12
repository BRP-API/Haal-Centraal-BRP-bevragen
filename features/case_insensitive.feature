# language: nl

Functionaliteit: Zoeken op tekstvelden is case-insensitive
  Het zoeken op een tekst-parameter (gedefinieerd als string) is niet hoofdlettergevoelig (case insensitive).

  Dit geldt niet wanneer de zoekparameter gedefinieerd is als enumeratie. In dat geval moet de exacte enumeratiewaarde worden gebruikt.

  Zoeken binnen GBA tabellen is ook case-insensitive. Bijvoorbeeld zoeken op voorvoegselGeslachtsnaam "van" vindt zowel "van" als "Van". Ook zoeken op voorvoegselGeslachtsnaam "VAN" vindt zowel "van" als "Van"

  Wanneer er op de parameter een patroon (pattern) is gedefinieeerd, moet de invoer hieraan voldoen. Bijvoorbeeld voor zoeken op verblijfplaats__postcode moet een geldige postcode worden opgegeven (dus met hoofdletters).

  Scenario: Zoeken op tekstvelden is case-insensitive
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groen
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&geslachtsnaam=GROEn
    Dan wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&geslachtsnaam=Velzen&voorvoegselGeslachtsnaam=VAN
    Dan wordt de ingeschreven persoon gevonden met naam.voorvoegselGeslachtsnaam=van
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&geslachtsnaam=groenen&voornamen=theo%20philip%20ijsbrand
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Theo Philip IJsbrand
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&geslachtsnaam=groenen&voornamen=THEO%20PHILIP%20IJSBRAND
    Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Theo Philip IJsbrand
    Als ingeschreven personen gezocht worden met ?gemeentevaninschrijving=0503&verblijfplaats__naamopenbareruimte=sint%20aldegondestraat&verblijfplaats__huisnummer=2
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.naamopenbareruimte=Sint Aldegondestraat
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=2628HJ&verblijfplaats__huisnummer=2&verblijfplaats__huisletter=a
    Dan wordt de ingeschreven persoon gevonden met verblijfplaats.huisletter=A

  Scenario: Het zoeken op een enumeratie is wél case-sensitive.
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=2628HJ&verblijfplaats__huisnummer=2&geslachtsaanduiding=m
    Dan levert dit een foutmelding
