# language: nl

Functionaliteit: Persoon: partner ontbinding huwelijk/geregistreerd partnerschap velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'ontbinding huwelijk/geregistreerd partnerschap' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | datum io | type                                                      |
    | 050000                  | true     | hele categorie huwelijk/geregistreerd partnerschap        |
    | 050700                  | true     | hele groep ontbinding huwelijk/geregistreerd partnerschap |
    | 050710                  | true     | datum ontbinding huwelijk/geregistreerd partnerschap      |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | field | type                                                      |
    | 050000                  | datum | hele categorie huwelijk/geregistreerd partnerschap        |
    | 050700                  | datum | hele groep ontbinding huwelijk/geregistreerd partnerschap |
    | 050710                  | datum | datum ontbinding huwelijk/geregistreerd partnerschap      |

  Abstract Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                                                 | veld naam                              | gevraagde fields             |
    | 050710                  | datum ontbinding huwelijk/geregistreerd partnerschap | datum ontbinding huwelijk/partnerschap | partners.burgerservicenummer |
