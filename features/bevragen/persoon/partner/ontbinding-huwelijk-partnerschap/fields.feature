#language: nl

Functionaliteit: Persoon: partner ontbinding huwelijk/geregistreerd partnerschap velden vragen met fields

  Abstract Scenario: 'datum ontbinding huwelijk/geregistreerd partnerschap (07.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                         | waarde   |
    | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20201001 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam              | waarde         |
    | datum.type        | Datum          |
    | datum.datum       | 2020-10-01     |
    | datum.langFormaat | 1 oktober 2020 |

    Voorbeelden:
    | fields                                             |
    | partners.ontbindingHuwelijkPartnerschap.datum      |
    | partners.ontbindingHuwelijkPartnerschap.datum.type |
