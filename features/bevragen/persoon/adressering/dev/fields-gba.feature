#language: nl

@gba
Functionaliteit: adressering aanhef, aanschrijfwijze en/of gebruikInLopendeTekst velden vragen met fields

Regel: als de aanhef, aanschrijfwijze en/of gebruikInLopendeTekst velden van adressering van een persoon wordt gevraagd en de categorie persoon (01) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: '<type>' is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | .                     | <aanduiding in onderzoek>       | 20020701                       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                             | waarde                    |
    | persoonInOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | persoonInOnderzoek.datumIngangOnderzoek          | 20020701                  |
    | naam.geslachtsnaam                               | .                         |
    En heeft de persoon geen 'partner' gegevens

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

Regel: als de aanhef, aanschrijfwijze en/of gebruikInLopendeTekst velden van adressering van een persoon wordt gevraagd en de categorie partner (05) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: '<type>' is in onderzoek en aanhef, aanschrijfwijze en gebruikInLopendeTekst velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'partner' met de volgende gegevens
    | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | .                     | <aanduiding in onderzoek>       | 20020701                       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000152                                                                        |
    | fields              | adressering.aanhef,adressering.aanschrijfwijze,adressering.gebruikInLopendeTekst |
    Dan heeft de response een persoon met een 'partner' met de volgende gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |
    | naam.geslachtsnaam                        | .                         |

    Voorbeelden:
    | aanduiding in onderzoek | type                                                            |
    | 050000                  | hele categorie partner                                          |
    | 050100                  | hele groep identificatinummers partner                          |
    | 050120                  | burgerservicenummer partner                                     |
    | 050200                  | hele groep naam partner                                         |
    | 050210                  | voornamen partner                                               |
    | 050220                  | adellijke titel of predicaat partner                            |
    | 050230                  | voorvoegsel geslachtsnaam partner                               |
    | 050240                  | geslachtsnaam partner                                           |
    | 050300                  | hele groep geboorte partner                                     |
    | 050310                  | geboortedatum partner                                           |
    | 050320                  | geboorteplaats partner                                          |
    | 050330                  | geboorteland partner                                            |
    | 050400                  | hele groep geslacht partner                                     |
    | 050410                  | geslachtsaanduiding partner                                     |
    | 051500                  | hele groep soort verbintenis                                    |
    | 051510                  | soort verbintenis                                               |
    | 050600                  | hele groep huwelijkssluiting/aangaan geregistreerd partnerschap |
    | 050610                  | datum huwelijkssluiting/aangaan geregistreerd partnerschap      |
    | 050620                  | plaats huwelijkssluiting/aangaan geregistreerd partnerschap     |
    | 050630                  | land huwelijkssluiting/aangaan geregistreerd partnerschap       |
    | 050700                  | hele groep ontbinding huwelijk/geregistreerd partnerschap       |
    | 050710                  | datum ontbinding huwelijk/geregistreerd partnerschap            |
