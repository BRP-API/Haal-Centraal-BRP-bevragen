# User story #7

Functionaliteit: ALS gemeente wil ik ingeschreven personen kunnen zoeken op geslachtsnaam
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Scenario: Er kan gezocht worden op geslachtsnaam, geboortedatum, voornamen, voorvoegselGeslachtsnaam, geslachtsaanduiding, geboorteplaats, gemeenteVanInschrijving
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=Groen&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent&gemeenteVanInschrijving=0014
    DAN levert dit zoekresultaten

  Scenario: Bij zoeken op geslachtsnaam zijn geslachtsnaam en gemeentevaninschrijving verplicht en zijn de overige parameters optioneel
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&gemeentevaninschrijving=0014
    DAN levert dit zoekresultaten
    # verplicht attribuut gemeentevaninschrijving ontbreekt
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen
    DAN levert dit een foutmelding
    # verplicht attribuut geslachtsnaam ontbreekt
    ALS ingeschreven personen gezocht worden met ?gemeentevaninschrijving=0014&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding
    # verplicht attribuut geslachtsnaam is leeg/heeft geen waarde
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=&gemeentevaninschrijving=0014&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding
    # verplicht attribuut gemeentevaninschrijving ontbreekt
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding
    # verplicht attribuut gemeentevaninschrijving is leeg/heeft geen waarde
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&gemeentevaninschrijving=&geboortedatum=1975-01-01&voornamen=Frank&voorvoegselGeslachtsnaam=van&geslachtsaanduiding=M&geboorteplaats=Sas%20van%20Gent
    DAN levert dit een foutmelding

  Scenario: Zoeken op geslachtsnaam kan NIET gecombineerd worden met andere zoekpaden
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&postcode=9744CZ
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&huisletter=A
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&woonplaatsnaam=Amsterdam
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen&identificatiecodenummeraanduiding=0704019876543210
    DAN levert dit een foutmelding

  Scenario: Om alleen personen die zijn ingeschreven in de eigen gemeente in het antwoord te krijgen, kan zoekparameter gemeenteVanInschrijving worden gebruikt
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&voornamen=frank*&gemeenteVanInschrijving=0518
    DAN heeft elke van de gevonden ingeschrevennatuurlijkpersonen gemeenteVanInschrijving=0518

  Scenario: Om alleen personen te vinden met een specifieke geboorteplaats kan de zoekparameter geboorteplaats gebruikt worden
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&geboorteplaats=sas%20van%20gent
    # hier zijn spaties vervangen door %20, omdat in een http url geen spaties toegestaan zijn
    DAN heeft elke van de gevonden ingeschrevennatuurlijkpersonen geboorte.geboorteplaats=Sas van Gent

  Scenario: Zoeken op tekstvelden is case-insensitive
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen
    DAN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=GROEN
    DAN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=Velzen&voorvoegselGeslachtsnaam=van
    DAN wordt de ingeschreven persoon gevonden met naam.voorvoegselGeslachtsnaam=van
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groenen&voornamen=theo%20philip%20ijsbrand
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=Theo Philip IJsbrand
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groenen&voornamen=THEO%20PHILIP%20IJSBRAND
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=Theo Philip IJsbrand
    # Het zoeken op een enumeratie is wél case-sensitive.
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=Groen&geslachtsaanduiding=m
    DAN levert dit een foutmelding

  Scenario: Wanneer een diakriet wordt opgegeven, wordt deze ook gebruikt.
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=ve*&voornamen=andré*
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=André
    EN wordt geen ingeschreven persoon gevonden met naam.voornamen=Andrea
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=velden&voornamen=Mariëlle
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=Mariëlle
    EN wordt geen ingeschreven persoon gevonden met naam.voornamen=Marielle

  Scenario: Wanneer geen diakriet wordt opgegeven, worden equivalente diakrieten ook gevonden.
    # TODO: vertalingen van ASCII letters naar equivalente diakrieten?
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groenen&voornamen=Andre
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=André
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=veld&geboorteplaats=malmo
    DAN wordt de ingeschreven persoon gevonden met geboorteplaats=Malmø
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groenen&voornamen=celik
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=Çelik

  Scenario: Voor attribuut geslachtsnaam wordt zoeken met een wildcard ondersteund
    # Wildcard karakter * Komt overeen met nul of meer (niet-spatie) karakters
    # Wildkard karakter ? Komt precies overeen met één (niet-spatie) karakter
    Gegeven de registratie ingeschreven personen kent met de geslachtsnaam "Groen", "Groenlo", "Groenink"
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*
    DAN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groen
    EN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenlo
    EN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Groenink
    EN voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.geslachtsnaam=groen*
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=ve*en
    DAN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Velzen
    EN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Veen
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=ve??en
    DAN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Velzen
    EN wordt de ingeschreven persoon gevonden met naam.geslachtsnaam=Velden
    EN wordt geen ingeschreven persoon gevonden met naam.geslachtsnaam=Veen
    EN wordt geen ingeschreven persoon gevonden met naam.geslachtsnaam=Veerlen
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=ve*&voornamen=Mari?
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=Maria
    EN wordt de ingeschreven persoon gevonden met naam.voornamen=Marie
    EN wordt geen ingeschreven persoon gevonden met naam.voornamen=Mariëlle

  Scenario: Voor attribuut voornamen wordt zoeken met een wildcard ondersteund
    # Wildcard karakter * Komt overeen met nul of meer (niet-spatie) karakters
    # Wildkard karakter ? Komt precies overeen met één (niet-spatie) karakter
    Gegeven de registratie ingeschreven personen kent met de voornamen "Frank", "Franka", "Johan Frank Robert", "Franklin", "Franky"
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&voornamen=*frank*
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=Frank
    EN wordt de ingeschreven persoon gevonden met naam.voornamen=Franka
    EN wordt de ingeschreven persoon gevonden met naam.voornamen=Johan Frank Robert
    EN wordt de ingeschreven persoon gevonden met naam.voornamen=Franklin
    EN wordt de ingeschreven persoon gevonden met naam.voornamen=Franky
    EN voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.voornamen=*frank*
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&voornamen=frank?
    DAN wordt de ingeschreven persoon gevonden met naam.voornamen=Franka
    EN wordt de ingeschreven persoon gevonden met naam.voornamen=Franky
    EN voldoet elke van de gevonden ingeschrevennatuurlijkpersonen aan de query naam.voornamen=frank?

  Scenario: Bij het zoeken op de parameters die een wildcard ondersteunen, moeten er minimaal 2 karakters exclusief de wildcard(s) worden opgegeven.
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=v
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=v*
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=*n
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=v?
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=ve
    DAN levert dit zoekresultaten
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=ve*
    DAN levert dit zoekresultaten

  Scenario: Zoeken een zoekwaarde die niet voldoet aan de parameterspecificatie levert een foutmelding
    # Invoer te lang
    # Alphanumerieke invoer op een integer
    # Voldoet niet aan pattern
    # Geen geldige enumeratiewaarde
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=Groen&geslachtsaanduiding=X
    DAN levert dit een foutmelding
    # Waarde komt niet voor in de referentietabel


  Scenario: Zoeken met onvolledige geboortedatum wordt niet ondersteund
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&geboortedatum=1975-01-00
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&geboortedatum=1975-01
    DAN levert dit een foutmelding
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&geboortedatum=1975
    DAN levert dit een foutmelding

  Scenario: Default levert een zoekvraag alleen personen op die nog in leven zijn
    Gegeven de registratie ingeschreven personen kent met de geslachtsnaam "Groenen" en de datumOverlijden "2019-01-23"
    EN de registratie ingeschreven personen kent met de geslachtsnaam "Groen", "Groenlo", "Groenink"
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*
    DAN is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&inclusiefoverledenpersonen=false
    DAN is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut overlijden.datumOverlijden niet aanwezig of null
    ALS ingeschreven personen gezocht worden met ?geslachtsnaam=groen*&inclusiefoverledenpersonen=true
    DAN wordt de ingeschreven persoon gevonden met overlijden.datumOverlijden=2019-01-23

  ## TODO: inclusiefnietingezetenen
