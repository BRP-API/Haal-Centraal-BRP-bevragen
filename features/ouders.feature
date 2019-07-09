# language: nl

Functionaliteit: Ouders van een ingeschreven persoon raadplegen
  Van een inschreven persoon kunnen ouders worden opgevraagd als sub-resource van de ingeschreven persoon. De sub-resource ouders bevat de gegevens over de kind-ouderrelatie inclusief enkele eigenschappen van de betreffende ouder.

  Wanneer de ouder een ingeschreven persoon is, levert de sub-resource ouders de actuele gegevens van de ouder(s) zoals die op de PL van de betreffende ouder staan (dus NIET zoals ze in categorie 02/52 Ouder1 of 03/53 Ouder2 staan).

  Scenario: er is geen ouder
    Gegeven de te raadplegen persoon heeft geen geregistreerde ouders
    Als de ouders worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden ouders 0

  Abstract Scenario: een ouder is onjuist of onbekend
    Gegeven de PL van een ouder van een ingeschreven persoon is leeg met uitzondering van de <bij onjuist of onbekend ingevulde kenmerken> kenmerken
    Als de ouders worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden ouders 0
    En zijn er geen links naar de onbekende ouders

    Voorbeelden:
    | bij onjuist of onbekend ingevulde kenmerken |
    | registergemeenteAkte (81.10), aktenummer (81.20), datumIngangGeldigheid (85.10), datumVanOpneming (86.10) |
    | gemeenteDocument (82.10), datumDocument (82.20), beschrijvingDocument (82.30), datumIngangGeldigheid (85.10), datumVanOpneming (86.10) |
  
  Scenario: de ouders zijn ingeschreven personen
    Gegeven de te raadplegen persoon heeft een ouder die zelf ingeschreven persoon is
    En de Ouder1 van de ingeschreven persoon heeft in de registratie burgerservicenummer 999999382, naam Jonkheer Franciscus Theodorus in 't Groen
    En de Ouder2 van de ingeschreven persoon heeft in de registratie burgerservicenummer 999999394, naam Philomena Blaauw
    Als de ouders worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999047
    Dan wordt de ouder gevonden met ouder_aanduiding=1
    En heeft deze ouder burgerservicenummer=999999382
    En heeft deze ouder geslachtsaanduiding=M
    En heeft deze ouder naam.voornamen=Franciscus Theodorus
    En heeft deze ouder naam.voorvoegsel=in 't
    En heeft deze ouder naam.geslachtsnaam=Groen
    En heeft deze ouder naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=Jonkheer
    En heeft deze gevonden ouder de ingeschrevenpersonen link met /ingeschrevenpersonen/999999382
    En wordt de ouder gevonden met ouder_aanduiding=2
    En heeft deze ouder burgerservicenummer=999999394
    En heeft deze ouder geslachtsaanduiding=V
    En heeft deze ouder naam.voornamen=Philomena
    En heeft deze ouder naam.voorvoegsel=null
    En heeft deze ouder naam.geslachtsnaam=Blaauw
    En heeft deze ouder naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En heeft deze gevonden ouder de ingeschrevenpersonen link met /ingeschrevenpersonen/999999394

  Scenario: de ouder is geen ingeschreven persoon
    Gegeven de te raadplegen persoon heeft een ouder die zelf geen ingeschreven persoon is
    En de Ouder2 van de ingeschreven persoon heeft volgens categorie 05/55 naam Markiezin Marie du Partenaire, geboren in Saintt-Quentin-en-Tourmont en geboortedatum 2 november 1979
    Als de ouders worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999011
    Dan wordt de ouder gevonden met ouder_aanduiding=2
    En heeft deze ouder burgerservicenummer=null
    En heeft deze ouder naam.voornamen=Marie
    En heeft deze ouder naam.voorvoegsel=du
    En heeft deze ouder naam.geslachtsnaam=Partenaire
    En heeft deze ouder naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=Markiezin
    En heeft deze ouder geboorte.datum.datum=1972-08-31
    En heeft deze ouder geboorte.datum.dag=31
    En heeft deze ouder geboorte.datum.maand=08
    En heeft deze ouder geboorte.plaats=Saintt-Quentin-en-Tourmont
    En heeft deze ouder geboorte.land.landnaam=Frankrijk
    En heeft deze gevonden ouder een lege link ingeschrevenpersonen

  Scenario: de ingeschreven persoon twee ouders
    Gegeven de te raadplegen persoon heeft meerdere (twee) ouders (Marie en Cornelis Petrus Johannus)
    Als de ouders worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999011
    Dan is het aantal gevonden ouders 2
    En wordt de ouder gevonden met naam.voornamen=Marie
    En wordt de ouder gevonden met naam.voornamen=Cornelis Petrus Johannus

  Scenario: de ingeschreven persoon heeft drie ouders
    Gegeven de te raadplegen persoon heeft drie ouders
    Als de ouders worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999448
    Dan is het aantal gevonden ouders 3

  Scenario: ouder ophalen vanuit links van ingeschreven persoon via sub-resource ouders
    Gegeven de te raadplegen persoon heeft één ouder dat zelf ingeschreven persoon is
    En de ouder van de ingeschreven persoon heeft in de registratie burgerservicenummer 999999291, naam Çelik	Groenen, geboren in januari 1975 (geboortedag is onbekend)
    Als de ingeschreven persoon met burgerservicenummer 999999424 wordt geraadpleegd
    En de link ouders wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999291
    En is in het antwoord naam.voornamen=Çelik
    En is in het antwoord naam.voorvoegsel=null
    En is in het antwoord naam.geslachtsnaam=Groenen
    En is in het antwoord naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En is in het antwoord geboorte.datum.datum=null
    En is in het antwoord geboorte.datum.jaar=1975
    En is in het antwoord geboorte.datum.maand=01
    En is in het antwoord geboorte.datum.dag niet aanwezig of null
    En is in het antwoord geslachtsaanduiding=V
    Als de link ingeschrevenpersonen wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999291
    En is in het antwoord naam.voornamen=Çelik
    En is in het antwoord geslachtsaanduiding=V
    En is in het antwoord datumVestigingInNederland=2002-08-12
