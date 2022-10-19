# language: nl

Functionaliteit: Partner

  Abstract Scenario: partner heeft 'ontbindingHuwelijkPartnerschap' datum veld: 'datum ontbinding huwelijk/geregistreerd partnerschap (07.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                         | waarde   |
    | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20201001 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 000000012                                     |
    | fields              | partners.ontbindingHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam  | waarde   |
    | datum | 20201001 |

  Scenario: naam veld(en) van partner is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam.inOnderzoek       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |

  Abstract Scenario: burgerservicenummer is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde    |
    | aanduiding in onderzoek (83.10) | 050000    |
    | datum ingang onderzoek (83.20)  | 20020701  |
    | burgerservicenummer (01.20)     | 000000013 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                      | waarde    |
    | burgerservicenummer                       | 000000013 |
    | inOnderzoek.aanduidingGegevensInOnderzoek | 050000    |
    | inOnderzoek.datumIngangOnderzoek          | 20020701  |

    Voorbeelden:
    | field                                             |
    | partners.burgerservicenummer                      |
    | partners.burgerservicenummer,partners.inOnderzoek |

  Abstract Scenario: alleen geboorteplaats is gevuld en bevat standaardwaarde
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                   | waarde |
    | geboorteplaats (03.20) | 0000   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' met de volgende 'geboorte' gegevens
    | naam                | waarde   |
    | plaats.code         | 0000     |
    | plaats.omschrijving | onbekend |

    Voorbeelden:
    | field                    |
    | partners                 |
    | partners.geboorte        |
    | partners.geboorte.plaats |