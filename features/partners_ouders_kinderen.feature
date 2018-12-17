# language: nl

Functionaliteit: De resource ingeschrevenpersonen bevat alleen relaties naar actuele partners, ouders en kinderen
  Alleen actuele partners, ouders en kinderen worden opgenomen als relatie van een ingeschreven persoon.
  Dit heeft betrekking op:
    - de links partners, ouders en kinderen in _links van een ingeschreven persoon
    - de resources partners, ouders en kinderen in _embedded van een ingeschreven persoon
    - de resources in sub-resource /ingeschrevenpersonen/{burgerservicenummer}/partners
    - de resources in sub-resource /ingeschrevenpersonen/{burgerservicenummer}/ouders
    - de resources in sub-resource /ingeschrevenpersonen/{burgerservicenummer}/kinderen

  Dit feature heeft GEEN betrekking op endpoint /historie/ingeschrevenpersonen/{burgerservicenummer}/partners.

  Een partner is actueel wanneer Ontbinding huwelijk/geregistreerd partnerschap (05.07) leeg is en indicatie onjuist (05.84.10) leeg is.
  Wanneer Ontbinding huwelijk/geregistreerd partnerschap van de partner een waarde heeft, wordt deze niet opgenomen.
  Wanneer indicatie onjuist van de partner een waarde heeft, wordt deze niet opgenomen.

  Een ouder of kind is actueel wanneer indicatie onjuist (84.10) leeg is. Wanneer indicatie onjuist van de ouder of het kind een waarde heeft, wordt deze niet opgenomen.
  Wanneer een ouder of kind is overleden geldt deze nog steeds als actueel. Een overleden ouder of kind (met indicatie onjuist leeg) wordt dus opgenomen in het antwoord.

  Wanneer de relatie in onderzoek is, kan deze toch als actueel worden beschouwd. Aanduiding gegevens in onderzoek heeft dus geen invloed op het al dan niet actueel zijn van de relatie naar partner, ouder of kind.


  Scenario: Huwelijk/partnerschap is ontbonden
    Gegeven de geraadpleegde persoon heeft een partner met 05.07 gevuld en 05.84 leeg
    En de geraadpleegde persoon heeft geen andere partner (actueel of historisch)
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is _links.partners leeg
    Als de ingeschreven persoon wordt geraadpleegd met expand=partners
    Dan is _links.partners leeg
    En is _embedded.partners leeg
    Als de ingeschreven persoon wordt geraadpleegd met /ingeschrevenpersonen/{burgerservicenummer}/partners
    Dan bevat het antwoord geen partners

  Scenario: Huwelijk/partnerschap is nietig verklaard
    Gegeven de geraadpleegde persoon heeft een partner met 05.07 gevuld en 05.84 leeg
    En Reden ontbinding huwelijk/geregistreerd partnerschap = N (Nietigverklaring)
    En de geraadpleegde persoon heeft geen andere partner (actueel of historisch)
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is _links.partners leeg
    Als de ingeschreven persoon wordt geraadpleegd met expand=partners
    Dan is _links.partners leeg
    En is _embedded.partners leeg
    Als de ingeschreven persoon wordt geraadpleegd met /ingeschrevenpersonen/{burgerservicenummer}/partners
    Dan bevat het antwoord geen partners

  Scenario: Huwelijk/partnerschap is onjuist
    Gegeven de geraadpleegde persoon heeft een partner met 05.07 leeg en 05.84 gevuld
    En de geraadpleegde persoon heeft geen andere partner (actueel of historisch)
    Als de ingeschreven persoon wordt geraadpleegd
    Dan is _links.partners leeg
    Als de ingeschreven persoon wordt geraadpleegd met expand=partners
    Dan is _links.partners leeg
    En is _embedded.partners leeg
    Als de ingeschreven persoon wordt geraadpleegd met /ingeschrevenpersonen/{burgerservicenummer}/partners
    Dan bevat het antwoord geen partners

  Scenario: Persoon is gescheiden en daarna opnieuw getrouwd
    Gegeven de geraadpleegde persoon heeft een partner met 05.07 gevuld en 05.84 leeg
    En de geraadpleegde persoon heeft een partner met 05.07 leeg en 05.84 leeg
    En de geraadpleegde persoon heeft geen andere partner (actueel of historisch)
    Als de ingeschreven persoon wordt geraadpleegd
    Dan bevat _links.partners exact 1 voorkomen(s)
    Als de ingeschreven persoon wordt geraadpleegd met expand=partners
    Dan bevat _links.partners exact 1 voorkomen(s)
    En bevat _embedded.partners exact 1 voorkomen(s)
    En is in elk van de gevonden partners ontbindingPartnerschap niet opgenomen of null
    Als de ingeschreven persoon wordt geraadpleegd met /ingeschrevenpersonen/{burgerservicenummer}/partners
    Dan bevat het antwoord 1 partners

  Scenario: Persoon heeft twee ouders
    Gegeven de geraadpleegde persoon heeft ouder1 met 02/52.84 Onjuist leeg
    En de geraadpleegde persoon heeft ouder2 met 02/52.84 Onjuist leeg
    En de geraadpleegde persoon heeft geen andere ouder(s)
    Als de ingeschreven persoon wordt geraadpleegd
    Dan bevat _links.ouders exact 2 voorkomen(s)
    Als de ingeschreven persoon wordt geraadpleegd met expand=ouders
    Dan bevat _links.ouders exact 2 voorkomen(s)
    En bevat _embedded.ouders exact 2 voorkomen(s)
    Als de ingeschreven persoon wordt geraadpleegd met /ingeschrevenpersonen/{burgerservicenummer}/ouders
    Dan bevat het antwoord 2 ouders

  Scenario: Persoon heeft een ouder met indicatie onjuist (84) gevuld
    Gegeven de geraadpleegde persoon heeft ouder1 met 02/52.84 gevuld
    En de geraadpleegde persoon heeft ouder2 met 03/53.84 leeg
    En de geraadpleegde persoon heeft geen andere ouder(s)
    Als de ingeschreven persoon wordt geraadpleegd
    Dan bevat _links.ouders exact 1 voorkomen(s)
    Als de ingeschreven persoon wordt geraadpleegd met expand=ouders
    Dan bevat _links.ouders exact 1 voorkomen(s)
    En bevat _embedded.ouders exact 1 voorkomen(s)
    En heeft in geen van de gevonden _links.ouders attribuut ouder_aanduiding de waarde 1
    En heeft in elke van de gevonden _links.ouders attribuut ouder_aanduiding de waarde 2
    Als de ingeschreven persoon wordt geraadpleegd met /ingeschrevenpersonen/{burgerservicenummer}/ouders
    Dan bevat het antwoord 1 ouders
    En wordt de ouder gevonden met ouder_aanduiding=2

  Scenario: Persoon heeft drie kinderen
    Gegeven de geraadpleegde persoon heeft drie kinderen met 02/52.84 Onjuist leeg
    En de geraadpleegde persoon heeft geen andere kinderen
    Als de ingeschreven persoon wordt geraadpleegd
    Dan bevat _links.kinderen exact 3 voorkomen(s)
    Als de ingeschreven persoon wordt geraadpleegd met expand=kinderen
    Dan bevat _links.kinderen exact 3 voorkomen(s)
    En bevat _embedded.kinderen exact 3 voorkomen(s)
    Als de ingeschreven persoon wordt geraadpleegd met /ingeschrevenpersonen/{burgerservicenummer}/kinderen
    Dan bevat het antwoord 3 kinderen

  Scenario: Persoon heeft een kind met indicatie onjuist (84) gevuld
    Gegeven de geraadpleegde persoon heeft een kind met 02/52.84 gevuld
    En de geraadpleegde persoon heeft een kind met 03/53.84 leeg
    En de geraadpleegde persoon heeft geen andere kinderen
    Als de ingeschreven persoon wordt geraadpleegd
    Dan bevat _links.kinderen exact 1 voorkomen(s)
    Als de ingeschreven persoon wordt geraadpleegd met expand=kinderen
    Dan bevat _links.kinderen exact 1 voorkomen(s)
    En bevat _embedded.kinderen exact 1 voorkomen(s)
    Als de ingeschreven persoon wordt geraadpleegd met /ingeschrevenpersonen/{burgerservicenummer}/kinderen
    Dan bevat het antwoord 1 kinderen
