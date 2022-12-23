# language: nl

Functionaliteit: Persoon: partner aangaan huwelijk/geregistreerd partnerschap velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'aangaan huwelijk/geregistreerd partnerschap' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000012                            |
    | fields              | partners.aangaanHuwelijkPartnerschap |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datum                            | <datum io>  |
    | inOnderzoek.plaats                           | <plaats io> |
    | inOnderzoek.land                             | <land io>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | datum io | plaats io | land io | type |
    | 050000                  | true     | true      | true    |      |
    | 050600                  | true     | true      | true    |      |
    | 050610                  | true     |           |         |      |
    | 050620                  |          | true      |         |      |
    | 050630                  |          |           | true    |      |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000012                                    |
    | fields              | partners.aangaanHuwelijkPartnerschap.<field> |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | field  | type |
    | 050000                  | datum  |      |
    | 050600                  | datum  |      |
    | 050610                  | datum  |      |
    | 050000                  | plaats |      |
    | 050600                  | plaats |      |
    | 050620                  | plaats |      |
    | 050000                  | land   |      |
    | 050600                  | land   |      |
    | 050630                  | land   |      |

  Abstract Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | gba in onderzoek waarde | type | veld naam                            | gevraagde fields                            |
    | 050610                  |      | datum aangaan huwelijk/partnerschap  | partners.aangaanHuwelijkPartnerschap.plaats |
    | 050620                  |      | plaats aangaan huwelijk/partnerschap | partners.aangaanHuwelijkPartnerschap.land   |
    | 050630                  |      | land aangaan huwelijk/partnerschap   | partners.aangaanHuwelijkPartnerschap.datum  |
