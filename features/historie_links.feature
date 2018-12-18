# language: nl

Functionaliteit: Links naar historie resources van een persoon
  Als gebruiker van de bevragingen personen API wil ik bij een persoon hyperlinks naar de historische resources van de persoon,
  zodat ik deze makkelijk kan vinden (discoverability) en gebruiken.

  In de _links van een ingeschreven persoon kunnen links worden opgenomen naar de historische resources van dezelfde persoon.

  Wanneer de API "Historie ingeschreven personen" beschikbaar is, MOET de resource ingeschrevenpersonen de volgende links bevatten naar historische resources:
  - partnerhistorie
  - verblijfsplaatsenhistorie
  - verblijfstitelshistorie

  Wanneer de API "Historie ingeschreven personen" NIET beschikbaar is, mag de resource ingeschrevenpersonen GEEN bevatten naar historische resources.

  Scenario: historie-API is beschikbaar en resource wordt geraadpleegd
    Gegeven de API "Historie ingeschreven personen" is beschikbaar
    Als ingeschreven persoon met burgerservicenummer 999999011 wordt geraadpleegd zonder fields-parameter
    Dan bevat het antwoord _links.partnerhistorie.href met een waarde
    En bevat het antwoord _links.verblijfsplaatsenhistorie.href met een waarde
    En bevat het antwoord _links.verblijfstitelshistorie.href met een waarde
    En eindigt attribuut _links.partnerhistorie.href met /api/bevragingen_ingeschreven_personen/v1/historie/ingeschrevenpersonen/999999011/partners
    En eindigt attribuut _links.verblijfsplaatsenhistorie.href met /api/bevragingen_ingeschreven_personen/v1/historie/ingeschrevenpersonen/999999011/verblijfplaatsen
    En eindigt attribuut _links.verblijfstitelshistorie.href met /api/bevragingen_ingeschreven_personen/v1/historie/ingeschrevenpersonen/999999011/verblijfstitels

  Scenario: historie-API is NIET beschikbaar en resource wordt geraadpleegd
    Gegeven de API "Historie ingeschreven personen" is niet beschikbaar
    Als ingeschreven persoon met burgerservicenummer 999999011 wordt geraadpleegd zonder fields-parameter
    Dan is geen attribuut partnerhistorie opgenomen in _links
    En is geen attribuut verblijfsplaatsenhistorie opgenomen in _links
    En is geen attribuut verblijfstitelshistorie opgenomen in _links

  Scenario: historie-API is beschikbaar en er worden personen gezocht
    Gegeven de API "Historie ingeschreven personen" is beschikbaar
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-05-26
    Dan heeft elke gevonden persoon attribuut _links.partnerhistorie.href met een waarde
    En heeft elke gevonden persoon attribuut _links.verblijfsplaatsenhistorie.href met een waarde
    En heeft elke gevonden persoon attribuut _links.verblijfstitelshistorie.href met een waarde

  Scenario: historie-API is NIET beschikbaar en er worden personen gezocht
    Gegeven de API "Historie ingeschreven personen" is beschikbaar
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen*&geboorte__datum=1983-05-26
    Dan is bij geen van de gevonden personen het attribuut partnerhistorie opgenomen in _links
    En is bij geen van de gevonden personen het attribuut verblijfsplaatsenhistorie opgenomen in _links
    En is bij geen van de gevonden personen het attribuut verblijfstitelshistorie opgenomen in _links
