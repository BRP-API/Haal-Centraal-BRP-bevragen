#language: nl

Functionaliteit: in onderzoek

Regel: als een gevraagde veld in onderzoek is, dan wordt het bijbehorend inOnderzoek veld en datumIngangOnderzoek ook geleverd

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

  Abstract Scenario: indicatieCurateleRegister wordt gevraagd en <type> is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'gezagsverhouding' gegevens
    | indicatie curateleregister (33.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 1                                  | <aanduiding in onderzoek>       | 20101205                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | indicatieCurateleRegister       |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                              | waarde          |
    | indicatieCurateleRegister                         | true            |
    | inOnderzoek.datumIngangOnderzoekGezag.type        | Datum           |
    | inOnderzoek.datumIngangOnderzoekGezag.datum       | 2010-12-05      |
    | inOnderzoek.datumIngangOnderzoekGezag.langFormaat | 5 december 2010 |
    | inOnderzoek.indicatieCurateleRegister             | true            |

    Voorbeelden:
    | aanduiding in onderzoek | type                            |
    | 110000                  | hele categorie gezagsverhouding |
    | 113300                  | hele groep curatele             |
    | 113310                  | indicatie curateleregister      |

Regel: als één of meerdere velden van een gevraagde groep in onderzoek zijn, dan worden de bijbehorende inOnderzoek velden en datumIngangOnderzoek ook geleverd

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

Regel: als een veld in een groep in onderzoek is en er wordt een ander veld in dezelfde/andere groep gevraagd, dan wordt de inOnderzoek veld van de groep niet geleverd

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


Regel: in onderzoek wordt niet geleverd wanneer het onderzoek is beëindigd

  Scenario: 'hele categorie persoon' in onderzoek is beëindigd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
    | 010000                          | 20120920                       | 20120922                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

Regel: voor een afgeleid gegeven wordt in onderzoek geleverd wanneer tenminste één van de gegevens waaruit het wordt afgeleid in onderzoek staat

  Scenario: 'hele categorie verblijfplaats' is in onderzoek en adresregel1 word gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 080000   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | adressering.adresregel1         |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                       | waarde      |
    | inOnderzoek.adresregel1                                    | true        |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002 |

  Scenario: 'hele categorie persoon' is in onderzoek en aanhef wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | .                     | 010000                          | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | adressering.aanhef              |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                | waarde      |
    | inOnderzoek.aanhef                                  | true        |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

  Scenario: 'hele categorie partner' is in onderzoek en aanschrijfwijze wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | .                     | 050000                          | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | adressering.aanschrijfwijze     |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                | waarde      |
    | inOnderzoek.aanschrijfwijze                         | true        |
    | inOnderzoek.datumIngangOnderzoekPartner.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPartner.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPartner.langFormaat | 1 juli 2002 |
