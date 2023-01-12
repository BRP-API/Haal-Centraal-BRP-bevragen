#language: nl

Functionaliteit: in onderzoek

Rule: als een gevraagde veld in onderzoek is, dan wordt het bijbehorend inOnderzoek veld en datumIngangOnderzoek ook geleverd

  Abstract Scenario: burgerservicenummer wordt gevraagd en <type> is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | <aanduiding in onderzoek>       | 20120920                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000097 |
    En heeft de persoon de volgende 'inOnderzoek' gegevens
    | naam                                    | waarde            |
    | burgerservicenummer                     | true              |
    | datumIngangOnderzoekPersoon.type        | Datum             |
    | datumIngangOnderzoekPersoon.datum       | 2012-09-20        |
    | datumIngangOnderzoekPersoon.langFormaat | 20 september 2012 |

    Voorbeelden:
    | aanduiding in onderzoek | type                     |
    | 010000                  | hele categorie persoon   |
    | 010100                  | hele groep persoon       |
    | 010120                  | burgerservicenummer veld |
    
Rule: als één of meerdere velden van een gevraagde groep in onderzoek zijn, dan worden de bijbehorende inOnderzoek velden en datumIngangOnderzoek ook geleverd

  Scenario: alle velden van de groep 'naam' wordt gevraagd en <type> is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                            | waarde                    |
    | voornamen (02.10)               | Arnitta                   |
    | geslachtsnaam (02.40)           | Jansen                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20120920                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | naam                            |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde               |
    | geslachtsnaam                                | Jansen               |
    | voornamen                                    | Arnitta              |
    | volledigeNaam                                | Arnitta Jansen       |
    | voorletters                                  | A.                   |
    | inOnderzoek.voornamen                        | <voornamen io>       |
    | inOnderzoek.adellijkeTitelPredicaat          | <titel/predicaat io> |
    | inOnderzoek.voorvoegsel                      | <voorvoegsel io>     |
    | inOnderzoek.geslachtsnaam                    | <geslachtsnaam io>   |
    | inOnderzoek.aanduidingNaamgebruik            | <naamgebruik io>     |
    | inOnderzoek.voorletters                      | <voorletters io>     |
    | inOnderzoek.volledigeNaam                    | <volledige naam io>  |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2012-09-20           |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 20 september 2012    |

    Voorbeelden:
    | aanduiding in onderzoek | type                   | voornamen io | titel/predicaat io | voorvoegsel io | geslachtsnaam io | naamgebruik io | voorletters io | volledige naam io |
    | 010000                  | hele categorie persoon | true         | true               | true           | true             | true           | true           | true              |
    | 010200                  | hele groep naam        | true         | true               | true           | true             |                | true           | true              |
    | 010240                  | geslachtsnaam veld     |              |                    |                | true             |                |                | true              |

Rule: als een veld in een groep in onderzoek is en er wordt een ander veld in dezelfde/andere groep gevraagd, dan wordt de inOnderzoek veld van de groep niet geleverd

  Scenario: burgerservicenummer is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | geslachtsaanduiding (04.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | M                           | 010120                          | 20120920                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | geslacht                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde |
    | geslacht.code         | M      |
    | geslacht.omschrijving | man    |

Rule: vragen van een inOnderzoek gegevensgroep veld of één of meerdere velden van een inOnderzoek gegevensgroep veld met de fields parameter worden genegeerd

  Abstract Scenario: <sub titel> wordt gevraagd en hele categorie persoon is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                            | waarde   |
    | geslachtsnaam (02.40)           | Groen    |
    | aanduiding in onderzoek (83.10) | 010000   |
    | datum ingang onderzoek (83.20)  | 20120920 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | fields                                                         | sub titel                          |
    | naam.inOnderzoek.datumIngangOnderzoek                          | Eén inOnderzoek veld               |
    | naam.inOnderzoek.geslachtsnaam,inOnderzoek.burgerservicenummer | Meerdere inOndezoek velden         |
    | naam.inOnderzoek                                               | Een inOnderzoek gegevensgroep veld |

  Scenario: een veld en niet bijbehorend inOnderzoek veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 010000                          | 20120920                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 000000097                                |
    | fields              | burgerservicenummer,inOnderzoek.geslacht |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000097 |
    En heeft de persoon de volgende 'inOnderzoek' gegevens
    | naam                                    | waarde            |
    | burgerservicenummer                     | true              |
    | datumIngangOnderzoekPersoon.type        | Datum             |
    | datumIngangOnderzoekPersoon.datum       | 2012-09-20        |
    | datumIngangOnderzoekPersoon.langFormaat | 20 september 2012 |
