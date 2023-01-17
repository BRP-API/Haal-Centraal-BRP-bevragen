#language: nl

Functionaliteit: Persoon: partner ontbinding huwelijk/geregistreerd partnerschap velden met standaardwaarde vragen met fields

  Abstract Scenario: 'datum ontbinding huwelijkssluiting/geregistreerd partnerschap (07.10)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                         | waarde   |
    | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

    Voorbeelden:
    | fields                                        |
    | partners.ontbindingHuwelijkPartnerschap.datum |
