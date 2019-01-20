# language: nl

Functionaliteit: parameters worden gevalideerd
  Wanneer een zoekparameter wordt gebruikt die niet voldoet aan de definitie die voor de parameter is gegeven, wordt een foutmelding gegeven.

  Parametereigenschappen die gevalideerd moeten worden:
  * string:
    * maximale lengte (parameterwaarde mag niet meer tekens bevatten Dan de maximale lengte)
    * pattern (parameterwaarde moet voldoen aan de reguliere expressie)
  * integer:
    * geldig geheel getal (geen andere tekens Dan 0 tot 9 en evt. -)
    * minimum (parameterwaarde mag niet lager zijn Dan de minimumwaarde)
    * maximum (parameterwaarde mag niet hoger zijn Dan de maximumwaarde)
  * enum(eratie):
    * waarde moet voorkomen in de gedefinieerde lijst mogelijke waarden
  * boolean:
    * waarde moet gelijk zijn aan true of false
  * date:
    * moet een geldige datum zijn in het ISO 8601 formaat jjjj-mm-dd (bijvoorbeeld "2018-03-09")
  * gemeentevaninschrijving: parameterwaarde moet voorkomen in kolom "Code" van tabel 33 Gemeentetabel
  * naam__voorvoegsel: parameterwaarde moet voorkomen in tabel 36 Voorvoegsels of leeg zijn

  Niet verplichte parameters mogen ook de waarde null hebben.

  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoAls beschreven in testdata.csv

  Scenario: Zoeken met een parameterwaarde langer dan toegestaan levert een foutmelding
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=9744CZ&verblijfplaats__huisnummer=5&verblijfplaats__huisletter=AA
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__huisletter

  Scenario: Zoeken met een parameterwaarde die niet voldoet aan het gedefinieerde patroon levert een foutmelding
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=XX44CZ&verblijfplaats__huisnummer=5
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__postcode

  Scenario: Zoeken met een parameterwaarde op een intedie geen geldig geheel getal is op een integer levert een foutmelding
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=9744CZ&verblijfplaats__huisnummer=A
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__huisnummer
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=9744CZ&verblijfplaats__huisnummer=12A3
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__huisnummer
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=9744CZ&verblijfplaats__huisnummer=1.2
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__huisnummer
    Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode=9744CZ&verblijfplaats__huisnummer=1,2
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__huisnummer

  Scenario: Zoeken met een parameterwaarde die niet voorkomt in de gedefinieerde enumeratielijst levert een foutmelding
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&geslachtsaanduiding=Y
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geslachtsaanduiding

  Scenario: Zoeken met een parameterwaarde die geen true of false is op een boolean parameter levert een foutmelding
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=true
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=false
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=True
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=ja
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter inclusiefoverledenpersonen

  Scenario: Zoeken met onvolledige geboortedatum wordt niet ondersteund
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-05-00
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-05
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum

  Scenario: Bij zoeken op een datum-parameter moet de parameterwaarde datum in het ISO 8601 formaat jjjj-mm-dd zijn
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-05-AA
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=19830526
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=26-05-1983
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum

  Scenario: Bij zoeken op een datum-parameter moet de parameterwaarde een geldige datum zijn
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-05-32
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-02-30
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-13-01
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter geboorte__datum

  Scenario: Bij zoeken op gemeente van inschrijving moet een gemeentecode worden gebruikt die bestaat
    Als ingeschreven personen gezocht worden met ?verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat&verblijfplaats__huisnummer=2&verblijfplaats__gemeentevaninschrijving=0503
    Dan levert dit zoekresultaten
    Als ingeschreven personen gezocht worden met ?verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat&verblijfplaats__huisnummer=2&verblijfplaats__gemeentevaninschrijving=503
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__gemeentevaninschrijving
    Als ingeschreven personen gezocht worden met ?verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat&verblijfplaats__huisnummer=2&verblijfplaats__gemeentevaninschrijving=ABCD
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__gemeentevaninschrijving
    Als ingeschreven personen gezocht worden met ?verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat&verblijfplaats__huisnummer=2&verblijfplaats__gemeentevaninschrijving=1899
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter verblijfplaats__gemeentevaninschrijving

  Scenario: Bij zoeken op voorvoegsel moet een waarde worden gebruikt die voorkomt in de betreffende GBA tabel of moet leeg zijn
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=Velzen&naam__voorvoegsel=niet
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter naam__voorvoegsel
    Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=Groenen&naam__voorvoegsel=
    Dan levert dit zoekresultaten
    En wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenen
