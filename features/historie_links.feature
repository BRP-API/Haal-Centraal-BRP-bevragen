# language: nl

Functionaliteit: Links naar historie resources van een persoon
  Als gebruiker van de bevragingen personen API wil ik bij een persoon hyperlinks naar de historische resources van de persoon,
  zodat ik deze makkelijk kan vinden (discoverability) en gebruiken.

  In de _links van een ingeschreven persoon kunnen links worden opgenomen naar de historische resources van dezelfde persoon.

  Wanneer de API "Historie ingeschreven personen" beschikbaar is, MOET de resource ingeschrevenpersonen de volgende links bevatten naar historische resources:
  - partnerhistorie
  - verblijfsplaatsenhistorie
  - verblijfstitelshistorie
  - nationaliteithistorie

  Wanneer de API "Historie ingeschreven personen" NIET beschikbaar is, mag de resource ingeschrevenpersonen GEEN links bevatten naar historische resources.

  Scenario: historie-API is beschikbaar en resource wordt geraadpleegd
    Gegeven de API "Historie ingeschreven personen" is beschikbaar
    En de te raadplegen persoon heeft een actuele partner
    Als ingeschreven persoon met burgerservicenummer 999999102 wordt geraadpleegd zonder fields-parameter
    Dan bevat het antwoord _links.partnerhistorie.href met een waarde
    En bevat het antwoord _links.verblijfplaatsenhistorie.href met een waarde
    En bevat het antwoord _links.verblijfstitelshistorie.href met een waarde
    En eindigt attribuut _links.partnerhistorie.href met /api/bevragingen_ingeschreven_personen/v1/historie/ingeschrevenpersonen/999999102/partners
    En eindigt attribuut _links.verblijfplaatsenhistorie.href met /api/bevragingen_ingeschreven_personen/v1/historie/ingeschrevenpersonen/999999102/verblijfplaatsen
    En eindigt attribuut _links.verblijfstitelshistorie.href met /api/bevragingen_ingeschreven_personen/v1/historie/ingeschrevenpersonen/999999102/verblijfstitels

  Scenario: historie-API is NIET beschikbaar en resource wordt geraadpleegd
    Gegeven de API "Historie ingeschreven personen" is niet beschikbaar
    Als ingeschreven persoon met burgerservicenummer 999999102 wordt geraadpleegd zonder fields-parameter
    Dan is in het antwoord attribuut _links.partnerhistorie null, leeg of afwezig
    En is in het antwoord attribuut _links.verblijfplaatsenhistorie null, leeg of afwezig
    En is in het antwoord attribuut _links.verblijfstitelshistorie null, leeg of afwezig

  Scenario: historie-API is beschikbaar en er worden personen gezocht
    Gegeven de API "Historie ingeschreven personen" is beschikbaar
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groenen&geboorte__datum=1983-05-26
    Dan heeft elke gevonden persoon attribuut _links.partnerhistorie.href met een waarde
    En heeft elke gevonden persoon attribuut _links.verblijfplaatsenhistorie.href met een waarde
    En heeft elke gevonden persoon attribuut _links.verblijfstitelshistorie.href met een waarde

  Scenario: historie-API is NIET beschikbaar en er worden personen gezocht
    Gegeven de API "Historie ingeschreven personen" is beschikbaar
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groenen&geboorte__datum=1983-05-26
    Dan is in elke van de gevonden ingeschrevenpersonen attribuut _links.partnerhistorie.href niet aanwezig of null
    En is in elke van de gevonden ingeschrevenpersonen attribuut _links.verblijfplaatsenhistorie.href niet aanwezig of null
    En is in elke van de gevonden ingeschrevenpersonen attribuut _links.verblijfstitelshistorie.href niet aanwezig of null
