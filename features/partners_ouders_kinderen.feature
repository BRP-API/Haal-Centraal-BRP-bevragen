# language: nl

Functionaliteit: De resource ingeschrevenpersonen bevat alleen relaties naar actuele partners, ouders en kinderen
  Alleen actuele partners, ouders en kinderen worden opgenomen als relatie van een persoon.
  Dit heeft betrekking op:
    - de links partners, ouders en kinderen in _links van een persoon
    - de resources partners, ouders en kinderen in _embedded van een persoon
    - de resources in sub-resource /ingeschrevenpersonen/{burgerservicenummer}/partners
    - de resources in sub-resource /ingeschrevenpersonen/{burgerservicenummer}/ouders
    - de resources in sub-resource /ingeschrevenpersonen/{burgerservicenummer}/kinderen

  Dit feature heeft GEEN betrekking op endpoint /historie/ingeschrevenpersonen/{burgerservicenummer}/partners.

  Een partner is actueel wanneer Ontbinding huwelijk/geregistreerd partnerschap (05/55.07) leeg is en indicatie onjuist (05/55.84.10) leeg is.
  Wanneer Ontbinding huwelijk/geregistreerd partnerschap van de partner een waarde heeft, wordt deze niet opgenomen.
  Wanneer indicatie onjuist van de partner een waarde heeft, wordt deze niet opgenomen.

  Een ouder of kind is actueel wanneer indicatie onjuist (84.10) leeg is. Wanneer indicatie onjuist van de ouder of het kind een waarde heeft, wordt deze niet opgenomen.
  Wanneer een ouder of kind is overleden geldt deze nog steeds als actueel. Een overleden ouder of kind (met indicatie onjuist leeg) wordt dus opgenomen in het antwoord.

  Wanneer de relatie in onderzoek is, kan deze toch als actueel worden beschouwd. Aanduiding gegevens in onderzoek heeft dus geen invloed op het al dan niet actueel zijn van de relatie naar partner, ouder of kind.


  Scenario: Huwelijk/partnerschap is ontbonden
    Gegeven de geraadpleegde persoon heeft een partner met 05.07 gevuld en 05.84 leeg
    En de geraadpleegde persoon heeft geen andere partner (actueel of historisch)
    Als de persoon met burgerservicenummer 999999321 wordt geraadpleegd
    Dan is _links.partners leeg
    Als persoon met burgerservicenummer 999999321 wordt geraadpleegd met expand=partners
    Dan is _links.partners leeg
    En is _embedded.partners leeg
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999321
    Dan is het aantal gevonden partners 0

  Scenario: Huwelijk/partnerschap is nietig verklaard
    Gegeven de geraadpleegde persoon heeft een partner met 05.07 gevuld en 05.84 leeg
    En Reden ontbinding huwelijk/geregistreerd partnerschap = N (Nietigverklaring)
    En de geraadpleegde persoon heeft geen andere partner (actueel of historisch)
    Als de persoon met burgerservicenummer 999999254 wordt geraadpleegd
    Dan is het aantal links naar partners gelijk aan 0
    Als persoon met burgerservicenummer 999999254 wordt geraadpleegd met expand=partners
    Dan is het aantal links naar partners gelijk aan 0
    En is het aantal embedded partners gelijk aan 0
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999254
    Dan is het aantal gevonden partners 0

  Scenario: Huwelijk/partnerschap is onjuist
    Gegeven de geraadpleegde persoon heeft een partner met 05.07 leeg en 05.84 gevuld
    En de geraadpleegde persoon heeft geen andere partner (actueel of historisch)
    Als de persoon met burgerservicenummer 999999345 wordt geraadpleegd
    Dan is _links.partners leeg
    Als persoon met burgerservicenummer 999999345 wordt geraadpleegd met expand=partners
    Dan is het aantal links naar partners gelijk aan 0
    En is het aantal embedded partners gelijk aan 0
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999345
    Dan is het aantal gevonden partners 0

  Scenario: Persoon is gescheiden en daarna opnieuw getrouwd
    Gegeven de geraadpleegde persoon heeft een partner met 05.07 gevuld en 05.84 leeg
    En de geraadpleegde persoon heeft twee partners met 05.07 leeg en 05.84 leeg
    Als de persoon met burgerservicenummer 999999291 wordt geraadpleegd
    Dan is het aantal links naar partners gelijk aan 2
    Als persoon met burgerservicenummer 999999291 wordt geraadpleegd met expand=partners
    Dan is het aantal links naar partners gelijk aan 2
    En is het aantal embedded partners gelijk aan 2
    En is in elke van de gevonden partners attribuut ontbindingPartnerschap niet aanwezig of null
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden partners 2

  Scenario: Persoon heeft twee ouders
    Gegeven de geraadpleegde persoon heeft ouder1 met 02/52.84 Onjuist leeg
    En de geraadpleegde persoon heeft ouder2 met 02/52.84 Onjuist leeg
    En de geraadpleegde persoon heeft geen andere ouder(s)
    Als de persoon met burgerservicenummer 999999011 wordt geraadpleegd
    Dan is het aantal links naar ouders gelijk aan 2
    Als persoon met burgerservicenummer 999999011 wordt geraadpleegd met expand=ouders
    Dan is het aantal links naar ouders gelijk aan 2
    En is het aantal embedded ouders gelijk aan 2
    Als de ouders worden geraadpleegd van de persoon met burgerservicenummer 999999011
    Dan is het aantal gevonden ouders 2
    En wordt de ouder gevonden met ouder_aanduiding=1
    En wordt de ouder gevonden met ouder_aanduiding=2

  Scenario: Persoon heeft een ouder met indicatie onjuist (84) gevuld
    Gegeven de geraadpleegde persoon heeft ouder1 met 02/52.84 leeg
    En de geraadpleegde persoon heeft ouder2 met 03/53.84 gevuld
    En de geraadpleegde persoon heeft geen andere ouder(s)
    Als de persoon met burgerservicenummer 999999023 wordt geraadpleegd
    Dan is het aantal links naar ouders gelijk aan 1
    Als persoon met burgerservicenummer 999999023 wordt geraadpleegd met expand=ouders
    Dan is het aantal links naar ouders gelijk aan 1
    En is het aantal embedded ouders gelijk aan 1
    En heeft elke van de gevonden ouders ouder_aanduiding=1
    En heeft geen van de gevonden ouders ouder_aanduiding=2
    Als de ouders worden geraadpleegd van de persoon met burgerservicenummer 999999023
    Dan is het aantal gevonden ouders 1
    En wordt de ouder gevonden met ouder_aanduiding=1

  Scenario: Persoon heeft drie kinderen
    Gegeven de geraadpleegde persoon heeft drie kinderen met 02/52.84 Onjuist leeg
    En de geraadpleegde persoon heeft geen andere kinderen
    Als de persoon met burgerservicenummer 999999291 wordt geraadpleegd
    Dan is het aantal links naar kinderen gelijk aan 3
    Als persoon met burgerservicenummer 999999291 wordt geraadpleegd met expand=kinderen
    Dan is het aantal links naar kinderen gelijk aan 3
    En is het aantal embedded kinderen gelijk aan 3
    Als de kinderen worden geraadpleegd van de persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden kinderen 3

  Scenario: Persoon heeft een kind met indicatie onjuist (84) gevuld
    Gegeven de geraadpleegde persoon heeft een kind met 02/52.84 gevuld (Franka)
    En de geraadpleegde persoon heeft een kind met 03/53.84 leeg (Frank)
    En de geraadpleegde persoon heeft geen andere kinderen
    Als de persoon met burgerservicenummer 999999370 wordt geraadpleegd
    Dan is het aantal links naar kinderen gelijk aan 1
    Als persoon met burgerservicenummer 999999370 wordt geraadpleegd met expand=kinderen
    Dan is het aantal links naar kinderen gelijk aan 1
    En is het aantal embedded kinderen gelijk aan 1
    En wordt het kind gevonden met naam.voornamen=Frank
    En heeft geen van de gevonden kinderen naam.voornamen=Franka
    Als de kinderen worden geraadpleegd van de persoon met burgerservicenummer 999999370
    Dan is het aantal gevonden kinderen 1
    En wordt het kind gevonden met naam.voornamen=Frank
    En heeft geen van de gevonden kinderen naam.voornamen=Franka
