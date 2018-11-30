# Met de expand parameter aangeven dat een sub-resource direct moet worden meegeladen met de resource

# TODO: is niet klaar
Functionaliteit: direct meeladen van een sub-resource

  Scenario: Wanneer de expand-parameter niet is meegegeven, worden gerelateerden niet meegeladen
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&voornamen=frank
    Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut _embedded niet aanwezig of null

  Scenario: Gebruik van expand=true is niet toegestaan
    # Om de hoeveelheid informatie die geretourneerd wordt te beperken, is verplicht om te specificeren welke resources en zelfs welke velden van een resource teruggeven moeten worden.
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&voornamen=frank&expand=true
    Dan levert dit een foutmelding
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&voornamen=frank&expand=True
    Dan levert dit een foutmelding

  Scenario: De expand-parameter moet nested resources bevatten die embed kunnen worden
    # Als er in de expand parameter een resource wordt opgegeven die niet bestaat of niet embed mag worden, wordt een foutmelding gegeven
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groenlo&voornamen=franka&expand=ongeldig
    Dan levert dit een foutmelding

  Scenario: Er kunnen meerdere nested resources worden embed door de resources als een komma's gescheiden lijst te specificeren
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groenlo&voornamen=franka&expand=partnerschappen,kinderen
    Dan bevatten alle gevonden ingeschrevennatuurlijkpersonen alleen gevraagde embedded attributen
    En hebben alle gevonden ingeschrevennatuurlijkpersonen embedded partnerschappen
    En hebben alle gevonden ingeschrevennatuurlijkpersonen embedded kinderen

  Scenario: De dot-notatie wordt gebruikt om specifieke velden van resources te selecteren
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=groenlo&voornamen=franka&expand=partnerschappen.soortVerbintenis,partnerschappen.aangaanPartnerschap.datumHuwelijkssluiting_aangaanGeregistreerdPartnerschap
    Dan bevatten alle gevonden ingeschrevennatuurlijkpersonen alleen gevraagde embedded attributen
