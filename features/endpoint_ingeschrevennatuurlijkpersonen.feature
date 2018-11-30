# Test van endpoint /ingeschrevennatuurlijkpersonen

Functionaliteit: endpoint /ingeschrevennatuurlijkpersonen
  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv



  Scenario: Als resultaat van de zoekvraag wordt een lijst gegeven van de gevonden ingeschreven personen
    # bevat _embedded met daarin ingeschrevennatuurlijkpersonen en daarin een lijst met 0..* objecten
    Als ingeschreven personen gezocht worden met ?geslachtsnaam=Groenen
    Dan heeft het antwoord een embedded lijst met ingeschrevennatuurlijkpersonen

# APT-11 Gelinkte resources worden expliciet en selectief mee-geladen
# Gelinkte resources worden expliciet en selectief mee-geladen als onderdeel van een resource verzoek middels de expand query-parameter.

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

  # Scenario: Embedded gaat 1 niveau diep
  # Functionaliteit van embedden is niet helemaal duidelijk, zie:
  # https://github.com/Geonovum/KP-APIs/issues/12
  # Dit scenario gebaseerd op aanname hierover
    # Als ingeschreven personen gezocht worden met ?geslachtsnaam=groenlo&voornamen=franka&expand=partnerschappen
    # Dan is in elke van de gevonden ingeschrevennatuurlijkpersonen attribuut _embedded.partnerschappen._embedded niet aanwezig of null

  # Scenario: Wanneer de nested resource een relatieklasse is, kan ook de gerelateerde worden expand
    # vraag hoe dit moet werken: https://github.com/Geonovum/KP-APIs/issues/12
    # Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&voornamen=frank&expand=partnerschappen._embedded.partners
    # Dan bevatten alle gevonden ingeschrevennatuurlijkpersonen met partnerschappen de gerelateerde partners
    # Als ingeschreven personen gezocht worden met ?geslachtsnaam=groen&voornamen=frank&expand=partnerschappen._embedded.partners.naam
    # Dan bevatten alle gevonden ingeschrevennatuurlijkpersonen met partnerschappen alleen attributen _embedded.partners.naam

  # TODO:
  # * pagineren
  # * sorteren
  # * fields
