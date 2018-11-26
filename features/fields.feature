# Fields gebruiken om de terug te geven attributen te beperken

Functionaliteit: Filteren van antwoord inhoud met fields parameter
  Scenario: enkel attribuut

  Scenario: meerdere attributen

  Scenario: groepsattribuut
    gegeven er een persoon de Vries
    naam
    DAN krijg ik naam.geslachtsnaam, naam.voornamen, naam.aanschrijfwijze, ...

  Scenario: attributen binnen een groep
    naam.geslachtsnaam

  Scenario: relatie (links)
    ouders
    partners
    kinderen

  Scenario: altijd self link
