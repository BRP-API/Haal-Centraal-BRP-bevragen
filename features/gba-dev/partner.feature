# language: nl

Functionaliteit: GBA persoon: partner

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
    | plaats.omschrijving | Onbekend |

    Voorbeelden:
    | field                    |
    | partners                 |
    | partners.geboorte        |
    | partners.geboorte.plaats |

  Abstract Scenario: partner heeft 'huwelijkssluiting/aangaan geregistreerd partnerschap' veld met onbekend waarde: 'datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde   |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 00000000 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met een 'partner' met de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam              | waarde        |
    | datum.type        | DatumOnbekend |
    | datum.onbekend    | true          |
    | datum.langFormaat | onbekend      |

    Voorbeelden:
    | field                                      |
    | partners                                   |
    | partners.aangaanHuwelijkPartnerschap       |
    | partners.aangaanHuwelijkPartnerschap.datum |
