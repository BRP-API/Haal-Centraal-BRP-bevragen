# language: nl

Functionaliteit: Persoon adressering in onderzoek

  Rule: DatumIngangOnderzoekPersoon wordt gezet wanneer voor adressering benodigde velden van de persoon in onderzoek zijn

    Abstract Scenario: adressering benodigde veld(en) van persoon is/zijn in onderzoek
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | geslachtsaanduiding (04.10)     | M                         |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | voornamen (02.10)               | voornamen                 |
      | geslachtsnaam (02.40)           | geslachtsnaam             |
      | aanduiding naamgebruik (61.10)  | E                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
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
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde                    |
      | geslachtsaanduiding (04.10)     | M                         |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | voornamen (02.10)               | voornamen                 |
      | geslachtsnaam (02.40)           | geslachtsnaam             |
      | aanduiding naamgebruik (61.10)  | E                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
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
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde        |
      | geslachtsaanduiding (04.10)     | M             |
      | aanduiding in onderzoek (83.10) | 010000        |
      | datum ingang onderzoek (83.20)  | 20020701      |
      | voornamen (02.10)               | voornamen     |
      | geslachtsnaam (02.40)           | geslachtsnaam |
      | aanduiding naamgebruik (61.10)  | E             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
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
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                            | waarde        |
      | geslachtsaanduiding (04.10)     | M             |
      | aanduiding in onderzoek (83.10) | 010000        |
      | datum ingang onderzoek (83.20)  | 20020701      |
      | voornamen (02.10)               | voornamen     |
      | geslachtsnaam (02.40)           | geslachtsnaam |
      | aanduiding naamgebruik (61.10)  | E             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | adressering.aanschrijfwijze     |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                | waarde           |
      | aanschrijfwijze.naam                                | V. geslachtsnaam |
      | inOnderzoek.aanschrijfwijze                         | true             |
      | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum            |
      | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01       |
      | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002      |

  Rule: DatumIngangOnderzoekPartner wordt gezet wanneer voor adressering benodigde velden van de eerste/actuele/ontbonden partner in onderzoek zijn

    Abstract Scenario: adressering benodigde veld(en) van partner is/zijn in onderzoek
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                           | waarde        |
      | geslachtsaanduiding (04.10)    | M             |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | geslachtsnaam (02.40)           | geslachtsnaam             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
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
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                           | waarde        |
      | geslachtsaanduiding (04.10)    | M             |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                            | waarde                    |
      | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)  | 20020701                  |
      | geslachtsnaam (02.40)           | geslachtsnaam             |
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
      | 050210                  |
      | 050300                  |
      | 050310                  |
      | 050320                  |
      | 050330                  |
      | 050400                  |
      | 050410                  |
      | 050600                  |
      | 050610                  |
      | 050620                  |
      | 050630                  |
      | 051500                  |
      | 051510                  |

    Abstract Scenario: adressering benodigde veld(en) van eerste partner (oudste relatie) is/zijn in onderzoek
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                           | waarde        |
      | geslachtsaanduiding (04.10)    | M             |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde         |
      | geslachtsnaam (02.40)                                              | geslachtsnaam2 |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19650401       |
      En de persoon heeft nog een 'partner' met de volgende gegevens
      | naam                                                               | waarde                    |
      | aanduiding in onderzoek (83.10)                                    | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)                                     | 20020701                  |
      | geslachtsnaam (02.40)                                              | geslachtsnaam             |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
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
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                           | waarde        |
      | geslachtsaanduiding (04.10)    | M             |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde         |
      | geslachtsnaam (02.40)                                              | geslachtsnaam2 |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19650401       |
      En de persoon heeft nog een 'partner' met de volgende gegevens
      | naam                                                               | waarde                    |
      | aanduiding in onderzoek (83.10)                                    | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)                                     | 20020701                  |
      | geslachtsnaam (02.40)                                              | geslachtsnaam             |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
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
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                           | waarde        |
      | geslachtsaanduiding (04.10)    | M             |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde         |
      | aanduiding in onderzoek (83.10)                                    | 050000         |
      | datum ingang onderzoek (83.20)                                     | 20020701       |
      | geslachtsnaam (02.40)                                              | geslachtsnaam2 |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19650401       |
      En de persoon heeft nog een 'partner' met de volgende gegevens
      | naam                                                               | waarde        |
      | geslachtsnaam (02.40)                                              | geslachtsnaam |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | adressering.inOnderzoek         |
      Dan heeft de response een persoon met een leeg 'adressering' object

    Abstract Scenario: adressering benodigde veld(en) van ontbonden partner is/zijn in onderzoek
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                           | waarde        |
      | geslachtsaanduiding (04.10)    | M             |
      | voornamen (02.10)              | voornamen     |
      | geslachtsnaam (02.40)          | geslachtsnaam |
      | aanduiding naamgebruik (61.10) | N             |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                               | waarde                    |
      | aanduiding in onderzoek (83.10)                                    | <gba in onderzoek waarde> |
      | datum ingang onderzoek (83.20)                                     | 20020701                  |
      | geslachtsnaam (02.40)                                              | geslachtsnaam             |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 19630405                  |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10)       | 19850707                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
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
