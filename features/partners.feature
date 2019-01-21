# language: nl

Functionaliteit: Huwelijken en geregistreerd partnerschappen van een ingeschreven persoon raadplegen
  Van een inschreven persoon kan het/kunnen de huwelijk(en) of geregistreerd partnerschap(pen) worden opgevraagd als sub-resource van de ingeschreven persoon. De sub-resource partners bevat de gegevens over de relatie (huwelijk of partnerschap) inclusief enkele eigenschappen van de persoon waarmee het huwelijk of partnerschap is aangegaan.

  Alleen een actueel huwelijk of geregistreerd partnerschap wordt teruggegeven.

  N.B. Wanneer de gebruiker niet-actuele huwelijken of partnerschappen wil raadplegen, kan hiervoor de historie-API worden gebruikt.

  Wanneer de partner een ingeschreven persoon is, levert de sub-resource partners de actuele gegevens van de partner zoals die op de PL van de partner staan (dus NIET zoals ze in categorie 05/55 Huwelijk/geregistreerd partnerschap staan).

  Scenario: er is geen partner
    Gegeven de te raadplegen persoon heeft geen (actuele) partner
    Als de partners worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999011
    Dan is het aantal gevonden partners 0

  Scenario: de partner is ingeschreven persoon
    Gegeven de te raadplegen persoon heeft een partner die zelf ingeschreven persoon is
    En de partner van de ingeschreven persoon heeft in de registratie burgerservicenummer 999999047, voornaam Franklin en geslachtsnaam Groenen
    Als de partners worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999023
    Dan is het aantal gevonden partners 1
    En wordt de partner gevonden met burgerservicenummer=999999047
    En heeft deze partner naam.voornamen=Franklin
    En heeft deze partner naam.geslachtsnaam=Groenen
    En heeft de gevonden partner link ingeschrevenpersonen met /ingeschrevenpersonen/999999047

  Scenario: de partner is geen ingeschreven persoon
    Gegeven de te raadplegen persoon heeft een partner die zelf geen ingeschreven persoon is
    En de partner van de ingeschreven persoon heeft volgens categorie 05/55 naam Dieter von Weit, geboren in Würzburg en geboortedatum 19 juni 1989
    Als de partners worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999436
    Dan is het aantal gevonden partners 1
    En wordt de partner gevonden met burgerservicenummer=null
    En heeft deze partner naam.voornamen=Dieter
    En heeft deze partner naam.voorvoegsel=von
    En heeft deze partner naam.geslachtsnaam=Weit
    En heeft de gevonden partner een lege link ingeschrevenpersonen

  Scenario: de ingeschreven persoon heeft meerdere partners
    Gegeven de te raadplegen persoon heeft meerdere (twee) actuele partners (Ali en Iskander)
    Als de partners worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden partners 2
    En wordt de partner gevonden met naam.voornamen=Ali
    En wordt de partner gevonden met naam.voornamen=Iskander

  Scenario: de ingeschreven persoon heeft een beëindigde relatie
    Gegeven de te raadplegen persoon heeft een beëindigde relatie
    En de te raadplegen persoon heeft geen andere of nieuwe relatie
    Als de partners worden geraadpleegd van de ingeschreven persoon met burgerservicenummer 999999321
    Dan is het aantal gevonden partners 0

  Scenario: partner ophalen vanuit links van ingeschreven persoon via sub-resource partners
    Gegeven de te raadplegen persoon heeft een partner die zelf ingeschreven persoon is
    En de partner van de ingeschreven persoon heeft in de registratie burgerservicenummer 999999047, voornaam Franklin en geslachtsnaam Groenen
    Als de ingeschreven persoon met burgerservicenummer 999999023 wordt geraadpleegd
    En de link partners wordt gevolgd
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
