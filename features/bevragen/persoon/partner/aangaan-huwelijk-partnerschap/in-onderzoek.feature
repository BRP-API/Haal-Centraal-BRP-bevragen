# language: nl

Functionaliteit: Persoon: partner aangaan huwelijk/geregistreerd partnerschap velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle 'aangaan huwelijk/geregistreerd partnerschap' velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | datum io | plaats io | land io | type                                                           |
    | 050000                  | true     | true      | true    | hele categorie huwelijk/geregistreerd partnerschap             |
    | 050600                  | true     | true      | true    | hele groep huwelijksluiting/aangaan geregistreerd partnerschap |
    | 050610                  | true     |           |         | datum huwelijksluiting/aangaan geregistreerd partnerschap      |
    | 050620                  |          | true      |         | plaats huwelijksluiting/aangaan geregistreerd partnerschap     |
    | 050630                  |          |           | true    | land huwelijksluiting/aangaan geregistreerd partnerschap       |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | field  | type                                                           |
    | 050000                  | datum  | hele categorie huwelijk/geregistreerd partnerschap             |
    | 050600                  | datum  | hele groep huwelijksluiting/aangaan geregistreerd partnerschap |
    | 050610                  | datum  | datum huwelijksluiting/aangaan geregistreerd partnerschap      |
    | 050000                  | plaats | hele categorie huwelijk/geregistreerd partnerschap             |
    | 050600                  | plaats | hele groep huwelijksluiting/aangaan geregistreerd partnerschap |
    | 050620                  | plaats | plaats huwelijksluiting/aangaan geregistreerd partnerschap     |
    | 050000                  | land   | hele categorie huwelijk/geregistreerd partnerschap             |
    | 050600                  | land   | hele groep huwelijksluiting/aangaan geregistreerd partnerschap |
    | 050630                  | land   | land huwelijksluiting/aangaan geregistreerd partnerschap       |

  Abstract Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met een 'partner' zonder 'aangaanHuwelijkPartnerschap' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                                                       | veld naam                            | gevraagde fields                            |
    | 050610                  | datum huwelijksluiting/aangaan geregistreerd partnerschap  | datum aangaan huwelijk/partnerschap  | partners.aangaanHuwelijkPartnerschap.plaats |
    | 050620                  | plaats huwelijksluiting/aangaan geregistreerd partnerschap | plaats aangaan huwelijk/partnerschap | partners.aangaanHuwelijkPartnerschap.land   |
    | 050630                  | land huwelijksluiting/aangaan geregistreerd partnerschap   | land aangaan huwelijk/partnerschap   | partners.aangaanHuwelijkPartnerschap.datum  |
