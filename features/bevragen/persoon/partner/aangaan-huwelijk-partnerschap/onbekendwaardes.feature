#language: nl

Functionaliteit: Persoon: partner aangaan huwelijk/geregistreerd partnerschap velden met standaardwaarde vragen met fields

  Abstract Scenario: 'datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde   |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 00000000 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

    Voorbeelden:
    | fields                                     |
    | partners.aangaanHuwelijkPartnerschap.datum |

  Abstract Scenario: 'plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                                | waarde |
    | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | fields                                      |
    | partners.aangaanHuwelijkPartnerschap.plaats |

  Abstract Scenario: 'land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                              | waarde |
    | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | fields                                    |
    | partners.aangaanHuwelijkPartnerschap.land |
