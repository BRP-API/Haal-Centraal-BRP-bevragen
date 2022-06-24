# language: nl

@post-assert
Functionaliteit: Persoon adressering in onderzoek

  Rule: DatumIngangOnderzoekPersoon wordt gezet wanneer voor adressering benodigde velden van de persoon in onderzoek zijn

    Abstract Scenario: adressering benodigde veld(en) van persoon is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde                    |
      | burgerservicenummer                         | 555550001                 |
      | geslachtsaanduiding (04.10)                 | M                         |
      | aanduiding gegevens in onderzoek (01.83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (01.83.20)           | 20020701                  |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | E             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                | waarde                                  |
      | inOnderzoek.aanhef                                  | <aanhef in onderzoek>                   |
      | inOnderzoek.aanschrijfwijze                         | <aanschrijfwijze in onderzoek>          |
      | inOnderzoek.gebruikInLopendeTekst                   | <gebruik in lopende tekst in onderzoek> |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum                                   |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01                              |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002                             |

      Voorbeelden:
      | gba in onderzoek waarde | aanhef in onderzoek | aanschrijfwijze in onderzoek | gebruik in lopende tekst in onderzoek |
      | 010000                  | true                | true                         | true                                  |
      | 010200                  | true                | true                         | true                                  |
      | 010210                  | true                | true                         | true                                  |
      | 010220                  | true                | true                         | true                                  |
      | 010230                  | true                | true                         | true                                  |
      | 010240                  | true                | true                         | true                                  |
      | 010400                  | true                | true                         | true                                  |
      | 010410                  | true                | true                         | true                                  |
      | 016100                  | true                | true                         | true                                  |
      | 016110                  | true                | true                         | true                                  |

    Abstract Scenario: niet-adressering benodigde veld(en) van persoon is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde                    |
      | burgerservicenummer                         | 555550001                 |
      | geslachtsaanduiding (04.10)                 | M                         |
      | aanduiding gegevens in onderzoek (01.83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (01.83.20)           | 20020701                  |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | E             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | gba in onderzoek waarde |
      | 010100                  |
      | 010120                  |
      | 010300                  |
      | 010310                  |
      | 010320                  |
      | 010330                  |

    Abstract Scenario: voor gevraagde veld '<veld>' zijn één of meerdere adressering benodigde velden van persoon in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde    |
      | burgerservicenummer                         | 555550001 |
      | geslachtsaanduiding (04.10)                 | M         |
      | aanduiding gegevens in onderzoek (01.83.10) | 010000    |
      | datum ingang onderzoek (01.83.20)           | 20020701  |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | E             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.<veld>              |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                | waarde      |
      | <veld>                                              | <waarde>    |
      | inOnderzoek.<veld>                                  | true        |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

      Voorbeelden:
      | veld                  | waarde                     |
      | aanhef                | Geachte heer Geslachtsnaam |
      | gebruikInLopendeTekst | de heer Geslachtsnaam      |

    Scenario: voor gevraagde veld 'aanschrijfwijze' zijn één of meerdere adressering benodigde velden van persoon in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                        | waarde    |
      | burgerservicenummer                         | 555550001 |
      | geslachtsaanduiding (04.10)                 | M         |
      | aanduiding gegevens in onderzoek (01.83.10) | 010000    |
      | datum ingang onderzoek (01.83.20)           | 20020701  |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | E             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                | waarde      |
      | aanschrijfwijze.naam                                | todo        |
      | aanschrijfwijze.aanspreekvorm                       | todo        |
      | inOnderzoek.aanschrijfwijze                         | true        |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

  Rule: DatumIngangOnderzoekPartner wordt gezet wanneer voor adressering benodigde velden van de eerste/actuele/ontbonden partner in onderzoek zijn

    Abstract Scenario: adressering benodigde veld(en) van partner is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde                    |
      | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                | waarde                                  |
      | inOnderzoek.aanhef                                  | <aanhef in onderzoek>                   |
      | inOnderzoek.aanschrijfwijze                         | <aanschrijfwijze in onderzoek>          |
      | inOnderzoek.gebruikInLopendeTekst                   | <gebruik in lopende tekst in onderzoek> |
      | inOnderzoek.datumIngangOnderzoekPartner.type        | Datum                                   |
      | inOnderzoek.datumIngangOnderzoekPartner.datum       | 2002-07-01                              |
      | inOnderzoek.datumIngangOnderzoekPartner.langFormaat | 1 juli 2002                             |

      Voorbeelden:
      | gba in onderzoek waarde | aanhef in onderzoek | aanschrijfwijze in onderzoek | gebruik in lopende tekst in onderzoek |
      | 050000                  | true                | true                         | true                                  |
      | 050200                  | true                | true                         | true                                  |
      | 050220                  | true                | true                         | true                                  |
      | 050230                  | true                | true                         | true                                  |
      | 050240                  | true                | true                         | true                                  |

    Abstract Scenario: niet-adressering benodigde veld(en) van partner is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde                    |
      | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | gba in onderzoek waarde |
      | 050100                  |
      | 050120                  |
      | 050300                  |
      | 050310                  |
      | 050320                  |
      | 050330                  |
      | 050600                  |
      | 050610                  |
      | 050620                  |
      | 050630                  |
      | 051500                  |
      | 051510                  |

    Abstract Scenario: adressering benodigde veld(en) van eerste partner (oudste relatie) is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde         |
      | geslachtsnaam (02.40) | geslachtsnaam2 |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19650401 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde                    |
      | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                | waarde                                  |
      | inOnderzoek.aanhef                                  | <aanhef in onderzoek>                   |
      | inOnderzoek.aanschrijfwijze                         | <aanschrijfwijze in onderzoek>          |
      | inOnderzoek.gebruikInLopendeTekst                   | <gebruik in lopende tekst in onderzoek> |
      | inOnderzoek.datumIngangOnderzoekPartner.type        | Datum                                   |
      | inOnderzoek.datumIngangOnderzoekPartner.datum       | 2002-07-01                              |
      | inOnderzoek.datumIngangOnderzoekPartner.langFormaat | 1 juli 2002                             |

      Voorbeelden:
      | gba in onderzoek waarde | aanhef in onderzoek | aanschrijfwijze in onderzoek | gebruik in lopende tekst in onderzoek |
      | 050000                  | true                | true                         | true                                  |
      | 050200                  | true                | true                         | true                                  |
      | 050220                  | true                | true                         | true                                  |
      | 050230                  | true                | true                         | true                                  |
      | 050240                  | true                | true                         | true                                  |

    Abstract Scenario: niet-adressering benodigde veld(en) van eerste partner (oudste relatie) is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde         |
      | geslachtsnaam (02.40) | geslachtsnaam2 |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19650401 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde                    |
      | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | gba in onderzoek waarde |
      | 050100                  |
      | 050120                  |
      | 050300                  |
      | 050310                  |
      | 050320                  |
      | 050330                  |
      | 050600                  |
      | 050610                  |
      | 050620                  |
      | 050630                  |
      | 051500                  |
      | 051510                  |

    Scenario: eerste partner (oudste relatie) is niet in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde   |
      | aanduiding gegevens in onderzoek (83.10) | 050000   |
      | datum ingang onderzoek (83.20)           | 20020701 |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde         |
      | geslachtsnaam (02.40) | geslachtsnaam2 |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19650401 |
      En de persoon heeft een 'partner' met de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met een leeg 'adressering' object

    Abstract Scenario: adressering benodigde veld(en) van ontbonden partner is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                     | waarde                    |
      | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                  | waarde        |
      | geslachtsnaam (02.40) | geslachtsnaam |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                                                               | waarde   |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405 |
      En de 'partner' heeft de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 19850707 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                | waarde                                  |
      | inOnderzoek.aanhef                                  | <aanhef in onderzoek>                   |
      | inOnderzoek.aanschrijfwijze                         | <aanschrijfwijze in onderzoek>          |
      | inOnderzoek.gebruikInLopendeTekst                   | <gebruik in lopende tekst in onderzoek> |
      | inOnderzoek.datumIngangOnderzoekPartner.type        | Datum                                   |
      | inOnderzoek.datumIngangOnderzoekPartner.datum       | 2002-07-01                              |
      | inOnderzoek.datumIngangOnderzoekPartner.langFormaat | 1 juli 2002                             |

      Voorbeelden:
      | gba in onderzoek waarde | aanhef in onderzoek | aanschrijfwijze in onderzoek | gebruik in lopende tekst in onderzoek |
      | 050000                  | true                | true                         | true                                  |
      | 050200                  | true                | true                         | true                                  |
      | 050210                  | true                | true                         | true                                  |
      | 050220                  | true                | true                         | true                                  |
      | 050230                  | true                | true                         | true                                  |
      | 050240                  | true                | true                         | true                                  |
      | 050400                  | true                | true                         | true                                  |
      | 050410                  | true                | true                         | true                                  |

  Rule: DatumIngangOnderzoekVerblijfplaats wordt gezet wanneer voor adressering benodigde velden van de verblijfplaats in onderzoek zijn

    Abstract Scenario: adressering benodigde veld(en) van verblijfplaats is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | E             |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde                    |
      | straatnaam (11.10)                       | Spui                      |
      | huisnummer (11.20)                       | 123                       |
      | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                       | waarde                     |
      | inOnderzoek.adresregel1                                    | <adresregel1 in onderzoek> |
      | inOnderzoek.adresregel2                                    | <adresregel2 in onderzoek> |
      | inOnderzoek.adresregel3                                    | <adresregel3 in onderzoek> |
      | inOnderzoek.land                                           | <land in onderzoek>        |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum                      |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01                 |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002                |

      Voorbeelden:
      | gba in onderzoek waarde | adresregel1 in onderzoek | adresregel2 in onderzoek | adresregel3 in onderzoek | land in onderzoek |
      | 080000                  | true                     | true                     | true                     | true              |
      | 080900                  |                          | true                     |                          |                   |
      | 080910                  |                          | true                     |                          |                   |
      | 081100                  | true                     | true                     |                          |                   |
      | 081110                  | true                     |                          |                          |                   |
      | 081115                  | true                     |                          |                          |                   |
      | 081120                  | true                     |                          |                          |                   |
      | 081130                  | true                     |                          |                          |                   |
      | 081140                  | true                     |                          |                          |                   |
      | 081150                  | true                     |                          |                          |                   |
      | 081160                  |                          | true                     |                          |                   |
      | 081170                  |                          | true                     |                          |                   |
      | 081200                  | true                     |                          |                          |                   |
      | 081210                  | true                     |                          |                          |                   |
      | 081300                  | true                     | true                     | true                     | true              |
      | 081310                  |                          |                          |                          | true              |
      | 081330                  | true                     |                          |                          |                   |
      | 081340                  |                          | true                     |                          |                   |
      | 081350                  |                          |                          | true                     |                   |

    Abstract Scenario: niet-adressering benodigde veld(en) van verblijfplaats is/zijn in onderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 555550001 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                           | waarde        |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | E             |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                     | waarde                    |
      | straatnaam (11.10)                       | Spui                      |
      | huisnummer (11.20)                       | 123                       |
      | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met een leeg 'adressering' object

      Voorbeelden:
      | gba in onderzoek waarde |
      | 080910                  |
      | 080920                  |
      | 081000                  |
      | 081010                  |
      | 081030                  |
      | 081180                  |
      | 081190                  |
      | 081320                  |
      | 081400                  |
      | 081410                  |
      | 081420                  |
      | 081500                  |
      | 081510                  |
