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
    | fields                                                    |
    | partners.ontbindingHuwelijkPartnerschap.datum             |
    | partners.ontbindingHuwelijkPartnerschap.datum.type        |
    | partners.ontbindingHuwelijkPartnerschap.datum.datum       |
    | partners.ontbindingHuwelijkPartnerschap.datum.langFormaat |
    | partners.ontbindingHuwelijkPartnerschap.datum.jaar        |
    | partners.ontbindingHuwelijkPartnerschap.datum.maand       |
    | partners.ontbindingHuwelijkPartnerschap.datum.onbekend    |

  Abstract Scenario: 'datum ontbinding huwelijk/geregistreerd partnerschap (07.10)' van het type '<type>' wordt gevraagd met field pad 'partners.ontbindingHuwelijkPartnerschap.datum'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                                                         | waarde     |
    | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 000000012                                     |
    | fields              | partners.ontbindingHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende 'ontbindingHuwelijkPartnerschap' gegevens
    | naam              | waarde        |
    | datum.type        | <type>        |
    | datum.datum       | <datum>       |
    | datum.jaar        | <jaar>        |
    | datum.maand       | <maand>       |
    | datum.onbekend    | <onbekend>    |
    | datum.langFormaat | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
    | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
    | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
    | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
