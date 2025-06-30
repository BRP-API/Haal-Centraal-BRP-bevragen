#language: nl

Functionaliteit: Persoon: partner velden vragen met fields

  Scenario: 'burgerservicenummer (01.20)' wordt gevraagd met field pad 'partners.burgerservicenummer'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer (01.20) | 123456789 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.burgerservicenummer    |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 123456789 |

  Abstract Scenario: 'geslachtsaanduiding (04.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                        | waarde |
    | geslachtsaanduiding (04.10) | O      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                  | waarde   |
    | geslacht.code         | O        |
    | geslacht.omschrijving | onbekend |

    Voorbeelden:
    | fields                         |
    | partners.geslacht              |
    | partners.geslacht.code         |
    | partners.geslacht.omschrijving |

  Abstract Scenario: 'soort verbintenis (15.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                      | waarde |
    | soort verbintenis (15.10) | P      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                          | waarde                     |
    | soortVerbintenis.code         | P                          |
    | soortVerbintenis.omschrijving | geregistreerd partnerschap |

    Voorbeelden:
    | fields                                 |
    | partners.soortVerbintenis              |
    | partners.soortVerbintenis.code         |
    | partners.soortVerbintenis.omschrijving |

  Abstract Scenario: 'soort verbintenis (15.10)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                      | waarde |
    | soort verbintenis (15.10) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | fields                    |
    | partners.soortVerbintenis |
