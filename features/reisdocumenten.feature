# language: nl

Functionaliteit: Het reisdocument van een ingeschreven persoon kan worden geraadpleegd op basis van het reisdocumentnummer
  Met het reisdocumentnummer als sleutel kan een reisdocument van een ingeschreven persoon worden geraadpleegd.

  In de resource ingeschrevenpersonen wordt een link opgenomen naar alle geldige reisdocumenten.

  Scenario: Een reisdocument raadplegen
    Gegeven het reisdocument is een nog geldige identiteitskaart
    Als het reisdocument geraadpleegd met reisdocumentnummer 627947117
    Dan is in het antwoord reisdocumentnummer=627947117
    En is in het antwoord aanduidingInhouding_vermissing niet aanwezig of null
    En is in het antwoord soortReisdocument.nederlandsReisdocument=NI
    En is in het antwoord soortReisdocument.reisdocumentomschrijving=Nederlandse identiteitskaart
    En is in het antwoord datumUitgifte.datum=2017-11-02
    En is in het antwoord autoriteitAfgifte.autoriteitVanAfgifte=BI0518
    En is in het antwoord autoriteitAfgifte.omschrijvingAutoriteit=Minister van Binnenlandse Zaken
    En is in het antwoord geldigTotEnMet.datum=2027-11-01
    En is in het antwoord datumInhoudingOfVermissing.jaar niet aanwezig of null
    En wordt een ingeschrevenpersonen link gevonden naar /ingeschrevenpersonen/999999011


  Scenario: Een vermist reisdocument raadplegen
    Gegeven het reisdocument is vermist gemeld op 5 april 2011
    Als het reisdocument geraadpleegd met reisdocumentnummer 882936846
    Dan is in het antwoord aanduidingInhouding_vermissing=V
    En is in het antwoord datumInhoudingOfVermissing.datum=2011-04-05

  Scenario: Reisdocument ophalen vanuit links van de ingeschreven persoon
    Gegeven de te raadplegen persoon heeft één reisdocument met reisdocumentnummer 286822017
    Als de ingeschreven persoon met burgerservicenummer 999999023 wordt geraadpleegd
    En de link reisdocumenten wordt gevolgd
    Dan is in het antwoord reisdocumentnummer=286822017
    En is in het antwoord soortReisdocument.reisdocumentomschrijving=Nationaal paspoort
    En is in het antwoord autoriteitAfgifte.autoriteitVanAfgifte=B0503
    En is in het antwoord autoriteitAfgifte.omschrijvingAutoriteit=Burgemeester van gecodeerd genoemde gemeente
    En is in het antwoord datumUitgifte.datum=2018-09-11
    En is in het antwoord geldigTotEnMet.datum=2028-09-10
    Als de link ingeschrevenpersonen wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999023
    En is het aantal links naar reisdocumenten gelijk aan 1
    En wordt een reisdocumenten link gevonden naar 286822017

  Scenario: Bij een ingeschreven persoon worden alleen geldige reisdocumenten getoond
    Gegeven de te raadplegen persoon heeft twee actuele reisducmenten (928847402 en 627947117)
    En de te raadplegen persoon heeft een vermist reisdocument (882936846)
    En de te raadplegen persoon heeft een reisdocument dat niet meer geldig is (862838263)
    Als de ingeschreven persoon met burgerservicenummer 999999011 wordt geraadpleegd
    Dan is het aantal links naar reisdocumenten gelijk aan 2
    En wordt een reisdocumenten link gevonden naar 928847402
    En wordt een reisdocumenten link gevonden naar 627947117
