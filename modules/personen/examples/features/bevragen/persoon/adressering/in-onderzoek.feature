#language: nl

Functionaliteit: Persoon: adressering - aanhef, aanschrijfwijze en/of gebruikInLopendeTekst zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | .                     | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                | waarde      |
    | inOnderzoek.aanhef                                  | true        |
    | inOnderzoek.aanschrijfwijze                         | true        |
    | inOnderzoek.gebruikInLopendeTekst                   | true        |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                         |
    | 010000                  | hele categorie persoon       |
    | 010200                  | hele groep naam              |
    | 010210                  | voornamen                    |
    | 010220                  | adellijke titel of predicaat |
    | 010230                  | voorvoegsel geslachtsnaam    |
    | 010240                  | geslachtsnaam                |
    | 010400                  | hele groep geslacht          |
    | 010410                  | geslachtsaanduiding          |
    | 016100                  | hele groep naamgebruik       |
    | 016110                  | aanduiding naamgebruik       |

  Abstract Scenario: voor gevraagde veld '<fields>' zijn één of meerdere adressering benodigde velden van persoon in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | .                     | 010000                          | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | adressering.<fields>            |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                | waarde      |
    | inOnderzoek.<onderzoek>                             | true        |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | fields                        | onderzoek             |
    | aanschrijfwijze               | aanschrijfwijze       |
    | aanschrijfwijze.naam          | aanschrijfwijze       |
    | aanschrijfwijze.aanspreekvorm | aanschrijfwijze       |
    | aanhef                        | aanhef                |
    | gebruikInLopendeTekst         | gebruikInLopendeTekst |

  Abstract Scenario: '<type>' is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsnaam (02.40)           | .                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met een leeg 'adressering' object

    Voorbeelden:
    | aanduiding in onderzoek | type                            |
    | 010100                  | hele groep identificatienummers |
    | 010120                  | burgerservicenummer             |
    | 010300                  | hele groep geboorte             |
    | 010310                  | geboortedatum                   |
    | 010320                  | geboorteplaats                  |
    | 010330                  | geboorteland                    |

  Abstract Scenario: '<type>' is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | .                     | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                | waarde      |
    | inOnderzoek.aanhef                                  | true        |
    | inOnderzoek.aanschrijfwijze                         | true        |
    | inOnderzoek.gebruikInLopendeTekst                   | true        |
    | inOnderzoek.datumIngangOnderzoekPartner.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPartner.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPartner.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                                 |
    | 050000                  | hele categorie partner               |
    | 050200                  | hele groep naam partner              |
    | 050220                  | adellijke titel of predicaat partner |
    | 050230                  | voorvoegsel geslachtsnaam partner    |
    | 050240                  | geslachtsnaam partner                |

  Abstract Scenario: '<type>' is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | .                     | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met een leeg 'adressering' object

    Voorbeelden:
    | aanduiding in onderzoek | type                                                            |
    | 050100                  | hele groep identificatienummers partner                         |
    | 050120                  | burgerservicenummer partner                                     |
    | 050210                  | voornamen partner                                               |
    | 050300                  | hele groep geboorte partner                                     |
    | 050310                  | geboortedatum partner                                           |
    | 050320                  | geboorteplaats partner                                          |
    | 050330                  | geboorteland partner                                            |
    | 050400                  | hele groep geslacht                                             |
    | 050410                  | geslachtsaanduiding partner                                     |
    | 050600                  | hele groep huwelijkssluiting/aangaan geregistreerd partnerschap |
    | 050610                  | datum huwelijkssluiting/aangaan geregistreerd partnerschap      |
    | 050620                  | plaats huwelijkssluiting/aangaan geregistreerd partnerschap     |
    | 050630                  | land huwelijkssluiting/aangaan geregistreerd partnerschap       |
    | 050700                  | hele groep ontbinding huwelijk/geregistreerd partnerschap       |
    | 050710                  | datum ontbinding huwelijk/geregistreerd partnerschap            |
    | 051500                  | hele groep soort verbintenis                                    |
    | 051510                  | soort verbintenis                                               |

  Abstract Scenario: '<type>' van eerste partner (oudste relatie) is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | Aedel                 | 19650401                                                           |
    En de persoon heeft nog een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Maassen               | 19630405                                                           | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                | waarde      |
    | inOnderzoek.aanhef                                  | true        |
    | inOnderzoek.aanschrijfwijze                         | true        |
    | inOnderzoek.gebruikInLopendeTekst                   | true        |
    | inOnderzoek.datumIngangOnderzoekPartner.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPartner.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPartner.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                                 |
    | 050000                  | hele categorie partner               |
    | 050200                  | hele groep naam partner              |
    | 050220                  | adellijke titel of predicaat partner |
    | 050230                  | voorvoegsel geslachtsnaam partner    |
    | 050240                  | geslachtsnaam partner                |

  Abstract Scenario: '<type>' van eerste partner (oudste relatie) is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | Aedel                 | 19650401                                                           |
    En de persoon heeft nog een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Maassen               | 19630405                                                           | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met een leeg 'adressering' object

    Voorbeelden:
    | aanduiding in onderzoek | type                                                            |
    | 050100                  | hele groep identificatienummers partner                         |
    | 050120                  | burgerservicenummer partner                                     |
    | 050210                  | voornamen partner                                               |
    | 050300                  | hele groep geboorte partner                                     |
    | 050310                  | geboortedatum partner                                           |
    | 050320                  | geboorteplaats partner                                          |
    | 050330                  | geboorteland partner                                            |
    | 050400                  | hele groep geslacht                                             |
    | 050410                  | geslachtsaanduiding partner                                     |
    | 050600                  | hele groep huwelijkssluiting/aangaan geregistreerd partnerschap |
    | 050610                  | datum huwelijkssluiting/aangaan geregistreerd partnerschap      |
    | 050620                  | plaats huwelijkssluiting/aangaan geregistreerd partnerschap     |
    | 050630                  | land huwelijkssluiting/aangaan geregistreerd partnerschap       |
    | 050700                  | hele groep ontbinding huwelijk/geregistreerd partnerschap       |
    | 050710                  | datum ontbinding huwelijk/geregistreerd partnerschap            |
    | 051500                  | hele groep soort verbintenis                                    |
    | 051510                  | soort verbintenis                                               |

  Scenario: eerste partner (oudste relatie) is niet in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Aedel                 | 19650401                                                           | 050000                          | 20020701                       |
    En de persoon heeft nog een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | Maassen               | 19630405                                                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met een leeg 'adressering' object

  Abstract Scenario: '<type>' van ontbonden partner is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | Aedel                 | 19650401                                                           |
    En de 'partner' is gewijzigd naar de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | <aanduiding in onderzoek>       | 20020701                       | 19850707                                                     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam                                                | waarde      |
    | inOnderzoek.aanhef                                  | true        |
    | inOnderzoek.aanschrijfwijze                         | true        |
    | inOnderzoek.gebruikInLopendeTekst                   | true        |
    | inOnderzoek.datumIngangOnderzoekPartner.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPartner.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPartner.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type                                 |
    | 050000                  | hele categorie partner               |
    | 050200                  | hele groep naam partner              |
    | 050220                  | adellijke titel of predicaat partner |
    | 050230                  | voorvoegsel geslachtsnaam partner    |
    | 050240                  | geslachtsnaam partner                |
