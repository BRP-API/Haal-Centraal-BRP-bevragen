# language: nl

Functionaliteit: Persoon: partner ontbinding huwelijk/geregistreerd partnerschap velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'ontbinding huwelijk/geregistreerd partnerschap' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000012                               |
    | fields              | partners.ontbindingHuwelijkPartnerschap |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datum                            | <datum io>  |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | datum io | type |
    | 050000                  | true     |      |
    | 050700                  | true     |      |
    | 050710                  | true     |      |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                          |
    | type                | RaadpleegMetBurgerservicenummer                 |
    | burgerservicenummer | 000000012                                       |
    | fields              | partners.ontbindingHuwelijkPartnerschap.<field> |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datum                            | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde | field | type |
    | 050000                  | datum |      |
    | 050700                  | datum |      |
    | 050710                  | datum |      |

  Abstract Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type | veld naam                              | gevraagde fields             |
    | 050710                  |      | datum ontbinding huwelijk/partnerschap | partners.burgerservicenummer |
