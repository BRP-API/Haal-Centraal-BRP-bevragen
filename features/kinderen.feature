# language: nl

Functionaliteit: Kinderen van een ingeschreven persoon raadplegen
  Van een inschreven persoon kunnen kinderen worden opgevraagd als sub-resource van de ingeschreven persoon. De sub-resource kinderen bevat de gegevens over de ouder-kindrelatie inclusief enkele eigenschappen van het betreffende kind.

  Wanneer het kind een ingeschreven persoon is, levert de sub-resource kinderen de actuele gegevens van het kind zoals die op de PL van het betreffende kind staan (dus NIET zoals ze in categorie 09/59 Kind staan).

  Scenario: de ingeschreven persoon heeft geen kind
    Gegeven de te raadplegen persoon heeft geen (geregistreerde) kinderen
    Als de kinderen worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999011
    Dan is het aantal gevonden kinderen 0

  Scenario: het kind is een ingeschreven personen
    Gegeven de te raadplegen persoon heeft een kind dat zelf ingeschreven persoon is
    En het kind van de ingeschreven persoon heeft in de registratie burgerservicenummer 999999047, naam Franklin	Groenen, geboren op 26 mei 1983
    Als de kinderen worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999382
    Dan is het aantal gevonden kinderen 1
    En wordt het kind gevonden met burgerservicenummer=999999047
    En heeft dit kind naam.voornamen=Franklin
    En heeft dit kind naam.voorvoegsel=null
    En heeft dit kind naam.geslachtsnaam=Groenen
    En heeft dit kind naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En heeft dit kind geboorte.datum.datum=1983-05-26
    En heeft dit gevonden kind de ingeschrevenpersonen link met /ingeschrevenpersonen/999999047

  Scenario: het kind is geen ingeschreven persoon
    Gegeven de te raadplegen persoon heeft een kind die zelf geen ingeschreven persoon is
    En het kind van de ingeschreven persoon heeft volgens categorie 09/59 naam Chantal Groenen, geboren in Istanbul en geboortedatum 2 januari 2002
    Als de kinderen worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999291
    Dan wordt het kind gevonden met naam.voornamen=Chantal
    En heeft dit kind burgerservicenummer=null
    En heeft dit kind naam.voorvoegsel=null
    En heeft dit kind naam.geslachtsnaam=Groenen
    En heeft dit kind naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En heeft dit kind geboorte.datum.datum=2002-01-02
    En heeft dit kind geboorte.datum.dag=02
    En heeft dit kind geboorte.datum.maand=01
    En heeft dit kind geboorte.plaats=Istanbul
    En heeft dit kind geboorte.land.landnaam=Turkije
    En heeft dit gevonden kind een lege link ingeschrevenpersonen

  Scenario: de ingeschreven persoon twee kinderen
    Gegeven de te raadplegen persoon heeft meerdere (twee) kinderen (Lisa en Daan)
    Als de kinderen worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999047
    Dan is het aantal gevonden kinderen 2
    En wordt het kind gevonden met naam.voornamen=Lisa
    En wordt het kind gevonden met naam.voornamen=Daan

  Scenario: de ingeschreven persoon heeft drie kinderen
    Gegeven de te raadplegen persoon heeft drie kinderen (Jip, Chantal en Jesse)
    Als de kinderen worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden kinderen 3
    En wordt het kind gevonden met naam.voornamen=Jip
    En wordt het kind gevonden met naam.voornamen=Chantal
    En wordt het kind gevonden met naam.voornamen=Jesse

  Scenario: kind ophalen vanuit links van ingeschreven persoon via sub-resource kinderen
    Gegeven de te raadplegen persoon heeft een kind dat zelf ingeschreven persoon is
    En het kind van de ingeschreven persoon heeft in de registratie burgerservicenummer 999999047, naam Franklin	Groenen, geboren op 26 mei 1983
    Als de ingeschreven persoon met burgerservicenummer 999999382 wordt geraadpleegd
    En de link kinderen wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999047
    En is in het antwoord naam.voornamen=Franklin
    En is in het antwoord naam.voorvoegsel=null
    En is in het antwoord naam.geslachtsnaam=Groenen
    En is in het antwoord naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En is in het antwoord geboorte.datum.datum=1983-05-26
    Als de link ingeschrevenpersonen wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999047
    En is in het antwoord naam.voornamen=Franklin
    En is in het antwoord geslachtsaanduiding=M
