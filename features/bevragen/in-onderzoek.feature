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

Rule: als een inOnderzoek veld wordt gevraagd en het bijbehorend veld is in onderzoek, dan wordt het inOnderzoek veld en bijbehorend datumIngangOnderzoek geleverd

  Abstract Scenario: inOnderzoek.burgerservicenummer wordt gevraagd en <type> is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | <aanduiding in onderzoek>       | 20120920                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | inOnderzoek.burgerservicenummer |
    Dan heeft de response een persoon met de volgende 'inOnderzoek' gegevens
    | naam                                    | waarde            |
    | burgerservicenummer                     | true              |
    | datumIngangOnderzoekPersoon.type        | Datum             |
    | datumIngangOnderzoekPersoon.datum       | 2012-09-20        |
    | datumIngangOnderzoekPersoon.langFormaat | 20 september 2012 |

    Voorbeelden:
    | aanduiding in onderzoek | type                        |
    | 010000                  | hele categorie persoon      |
    | 010100                  | hele groep persoon          |
    | 010120                  | burgerservicenummer element |

Rule: als een inOnderzoek groep wordt gevraagd en minimaal één van de bijbehorende velden zijn in onderzoek, dan wordt de inOnderzoek groep en bijbehorend datumIngangOnderzoek geleverd

  Abstract Scenario: alle velden van de groep 'naam.inOnderzoek' wordt gevraagd en <type> is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                            | waarde                    |
    | geslachtsnaam (02.40)           | Groen                     |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20120920                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | naam.inOnderzoek                |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde               |
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
    | 010200                  | hele groep             | true         | true               | true           | true             |                | true           | true              |
    | 010240                  | geslachtsnaam element  |              |                    |                | true             |                |                | true              |

Rule: als alleen de datumIngangOnderzoek van een inOnderzoek groep wordt gevraagd, dan wordt dit behandeld als het vragen van de gehele inOnderzoek groep horende bij de datumIngangOnderzoek veld

  Abstract Scenario: naam.inOnderzoek.datumIngangOnderzoek wordt gevraagd en <type> is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                            | waarde                    |
    | geslachtsnaam (02.40)           | Groen                     |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20120920                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000097                             |
    | fields              | naam.inOnderzoek.datumIngangOnderzoek |
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam                                         | waarde               |
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
    | 010200                  | hele groep             | true         | true               | true           | true             |                | true           | true              |
    | 010240                  | geslachtsnaam element  |              |                    |                | true             |                |                | true              |

Rule: als één inOnderzoek veld wordt gevraagd en de bijbehorende veld is niet in onderzoek, dan wordt de inOnderzoek groep horende bij het gevraagde veld niet geleverd

  Scenario: burgerservicenummer is niet in onderzoek, en inOnderzoek.burgerservicenummer wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 010400                          | 20120920                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | inOnderzoek.burgerservicenummer |
    Dan heeft de response een persoon zonder gegevens

  Scenario: burgerservicenummer is niet in onderzoek, en burgerservicenummer en inOnderzoek.burgerservicenummer wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 010400                          | 20120920                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                              |
    | type                | RaadpleegMetBurgerservicenummer                     |
    | burgerservicenummer | 000000097                                           |
    | fields              | burgerservicenummer,inOnderzoek.burgerservicenummer |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000097 |

Rule: als een inOnderzoek groep wordt gevraagd en geen van de velden in de bijbehorende groep zijn in onderzoek, dan wordt de gevraagde inOnderzoek groep niet geleverd

  Scenario: alle velden van de groep 'naam' zijn niet in onderzoek, en naam.inOnderzoek wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Jansen                | 010300                          | 20120920                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | naam.inOnderzoek                |
    Dan heeft de response een persoon zonder 'naam' gegevens