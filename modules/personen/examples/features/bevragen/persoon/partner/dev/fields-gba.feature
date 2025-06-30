# language: nl

@gba
Functionaliteit: partner velden vragen met fields (persoon)

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
    | geslachtsnaam (02.40)           | .                         |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.naam                   |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                      | waarde                    |
    | naam.geslachtsnaam                        | .                         |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050200                  |
    | 050240                  |
    | 050310                  |
    | 050600                  |

  Scenario: burgerservicenummer is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde    |
    | aanduiding in onderzoek (83.10) | 050000    |
    | datum ingang onderzoek (83.20)  | 20020701  |
    | burgerservicenummer (01.20)     | 000000013 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.burgerservicenummer    |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                      | waarde    |
    | burgerservicenummer                       | 000000013 |
    | inOnderzoek.aanduidingGegevensInOnderzoek | 050000    |
    | inOnderzoek.datumIngangOnderzoek          | 20020701  |

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
    | naam  | waarde   |
    | datum | 00000000 |

    Voorbeelden:
    | field                                      |
    | partners                                   |
    | partners.aangaanHuwelijkPartnerschap       |
    | partners.aangaanHuwelijkPartnerschap.datum |

  Scenario: onbekend waarde in een partner voor soortVerbintenis
    Gegeven de persoon met burgerservicenummer '000000206' heeft een 'partner' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer (01.20) | 000000218 |
    | soort verbintenis (15.10)   | .         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000206                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000218 |
    | soortVerbintenis.code         | .         |
    | soortVerbintenis.omschrijving | onbekend  |

  Abstract Scenario: onbekend waarde in een <relatie> voor <groep> <veld>
    Gegeven de persoon met burgerservicenummer '000000267' heeft een 'partner' met de volgende gegevens
    | naam                        | waarde    |
    | burgerservicenummer (01.20) | 000000279 |
    | <element>                   | 0000      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000267                       |
    | fields              | partners.<groep>.<veld>         |
    Dan heeft de response een persoon met een 'partner' met de volgende gegevens
    | naam                        | waarde   |
    | <groep>.<veld>.code         | 0000     |
    | <groep>.<veld>.omschrijving | Onbekend |

    Voorbeelden:
    | groep                       | veld   | element                                                             |
    | geboorte                    | plaats | geboorteplaats (03.20)                                              |
    | geboorte                    | land   | geboorteland (03.30)                                                |
    | aangaanHuwelijkPartnerschap | plaats | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) |
    | aangaanHuwelijkPartnerschap | land   | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   |

  Scenario: volledig onbekende geboortedatum en datum aanvang huwelijk bij partner
    Gegeven de persoon met burgerservicenummer '000000395' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde    |
    | burgerservicenummer (01.20)                                        | 000000401 |
    | geboortedatum (03.10)                                              | 00000000  |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 00000000  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                              |
    | type                | RaadpleegMetBurgerservicenummer                                                                                     |
    | burgerservicenummer | 000000395                                                                                                           |
    | fields              | burgerservicenummer,partners.burgerservicenummer,partners.geboorte.datum,partners.aangaanHuwelijkPartnerschap.datum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000395 |
    En heeft de persoon een 'partner' met alleen de volgende gegevens
    | naam                              | waarde    |
    | burgerservicenummer               | 000000401 |
    | geboorte.datum                    | 00000000  |
    | aangaanHuwelijkPartnerschap.datum | 00000000  |

Regel: voornamen wordt geleverd met field pad 'naam.voorletters'

  Scenario: 'voorletters' wordt gevraagd met field pad 'naam.voorletters'
    Gegeven de persoon met burgerservicenummer '000000176' heeft een 'partner' met de volgende gegevens
    | naam                                 | waarde   |
    | voornamen (02.10)                    | Carolina |
    | adellijke titel of predicaat (02.20) | R        |
    | voorvoegsel (02.30)                  | de       |
    | geslachtsnaam (02.40)                | Groen    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000176                       |
    | fields              | partners.naam.voorletters       |
    Dan heeft de response een persoon met een 'partner' met de volgende gegevens
    | naam           | waarde   |
    | naam.voornamen | Carolina |
