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
