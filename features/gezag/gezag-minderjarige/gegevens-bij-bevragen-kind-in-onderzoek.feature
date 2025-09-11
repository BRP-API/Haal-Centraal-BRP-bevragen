#language: nl

Functionaliteit: wanneer gegevens van het kind in onderzoek staan wordt een gezag uitspraak geleverd met een toelichting welke gegevens in onderzoek zijn

  Achtergrond:
    Gegeven de persoon 'Jorine' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Bastiaan' met burgerservicenummer '000000024'
    * is meerderjarig
    En de persoon 'Nandy' met burgerservicenummer '000000036'
    * is minderjarig
    * is in Nederland geboren
    * is ingeschreven in de BRP

  Abstract Scenario: gezag wordt bepaald met gegeven van persoon: <omschrijving> in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Nandy'
    * zijn de volgende gegevens gewijzigd
      | aanduiding in onderzoek (83.10) |
      | <aanduiding onderzoek>          |
    * heeft 'Jorine' als ouder 1
    * heeft 'Bastiaan' als ouder 2
    En 'Jorine' en 'Bastiaan' zijn met elkaar gehuwd
    Als 'gezag' wordt gevraagd van 'Nandy'

    Dan is het gezag over 'Nandy' gezamenlijk ouderlijk gezag met ouder 'Jorine' en ouder 'Bastiaan'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving   |
      | 010310               | geboortedatum  |
      | 010330               | geboorteland   |
      | 010000               | hele categorie |

  Scenario: gezag wordt bepaald met aktenummer van persoon in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Nandy'
    * zijn de volgende gegevens gewijzigd
      | aanduiding in onderzoek (83.10) |
      | 018120                          |
    * heeft 'Jorine' als ouder 1
    * is geadopteerd door 'Bastiaan' als ouder 2
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' gezamenlijk ouderlijk gezag met ouder 'Jorine' en ouder 'Bastiaan'
    En is het gezag in onderzoek

  Scenario: gezag wordt bepaald met historisch aktenummer van persoon in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Nandy'
    * zijn de volgende gegevens gewijzigd
      | aanduiding in onderzoek (83.10) |
      | 518120                          |
    * zijn de volgende gegevens gewijzigd
      | aanduiding in onderzoek (83.10) |
      |                                 |
    * heeft 'Jorine' als ouder 1
    * is geadopteerd door 'Bastiaan' als ouder 2
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' gezamenlijk ouderlijk gezag met ouder 'Jorine' en ouder 'Bastiaan'
    En is het gezag in onderzoek

  Abstract Scenario: gezag wordt bepaald met gegeven van huwelijk: <omschrijving> in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    Gegeven 'Jorine' en 'Bastiaan' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | aanduiding in onderzoek (83.10) |
      | gisteren - 2 jaar                                                  | <aanduiding onderzoek>          |
    Gegeven persoon 'Nandy'
    * heeft 'Jorine' als ouder 1
    * heeft 'Bastiaan' als ouder 2
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' gezamenlijk ouderlijk gezag met ouder 'Jorine' en ouder 'Bastiaan'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                                |
      | 050120               | burgerservicenummer partner                 |
      | 050000               | hele categorie partnerschap                 |
      | 050600               | hele groep aangaan huwelijk of partnerschap |
      | 050610               | datum aangaan huwelijk of partnerschap      |
      | 050710               | datum ontbinding huwelijk of partnerschap   |

  Abstract Scenario: gezag wordt bepaald met gegeven van huwelijk bij scheiding: <omschrijving> in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    Gegeven 'Jorine' en 'Bastiaan' zijn met elkaar gehuwd
    En 'Jorine' en 'Bastiaan' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | aanduiding in onderzoek (83.10) |
      | gisteren - 1 jaar                                            | <aanduiding onderzoek>          |
    Gegeven persoon 'Nandy'
    * heeft 'Jorine' als ouder 1
    * heeft 'Bastiaan' als ouder 2
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' gezamenlijk ouderlijk gezag met ouder 'Jorine' en ouder 'Bastiaan'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                              |
      | 050740               | reden ontbinding huwelijk of partnerschap |

  Abstract Scenario: gezag wordt bepaald met gegeven van gerechtelijke uitspraak: <omschrijving> in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Nandy' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | naam                                 | waarde                 |
      | indicatie gezag minderjarige (32.10) | 12                     |
      | ingangsdatum geldigheid (85.10)      | gisteren - 2 jaar      |
      | aanduiding in onderzoek (83.10)      | <aanduiding onderzoek> |
    En persoon 'Nandy'
    * heeft 'Jorine' als ouder 1
    * heeft 'Bastiaan' als ouder 2
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' gezamenlijk ouderlijk gezag met ouder 'Jorine' en ouder 'Bastiaan'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                  |
      | 113210               | indicatie gezag minderjarig   |
      | 118510               | ingangsdatum geldigheid gezag |
      | 110000               | hele groep                    |

  Abstract Scenario: gezag wordt bepaald met gegeven van gerechtelijke uitspraak voor de ouder 1: <omschrijving> in onderzoek er is sprake van EenhoofdigOuderlijkGezag
    En persoon 'Nandy'
    * heeft 'Jorine' als ouder 1
    * heeft 'Bastiaan' als ouder 2
    Gegeven voor 'Jorine' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | naam                               | waarde                 |
      | indicatie curateleregister (33.10) | 1                      |
      | ingangsdatum geldigheid (85.10)    | gisteren - 2 jaar      |
      | aanduiding in onderzoek (83.10)    | <aanduiding onderzoek> |
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' eenhoofdig ouderlijk gezag met ouder 'Bastiaan'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                |
      | 110000               | hele groep                  |
      | 113310               | indicatie curatele register |

  Abstract Scenario: gezag wordt bepaald met gegeven van gerechtelijke uitspraak voor de ouder 2: <omschrijving> in onderzoek er is sprake van EenhoofdigOuderlijkGezag
    En persoon 'Nandy'
    * heeft 'Jorine' als ouder 1
    * heeft 'Bastiaan' als ouder 2
    Gegeven voor 'Bastiaan' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | naam                               | waarde                 |
      | indicatie curateleregister (33.10) | 1                      |
      | ingangsdatum geldigheid (85.10)    | gisteren - 2 jaar      |
      | aanduiding in onderzoek (83.10)    | <aanduiding onderzoek> |
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' eenhoofdig ouderlijk gezag met ouder 'Jorine'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                |
      | 110000               | hele groep                  |
      | 113310               | indicatie curatele register |

  Abstract Scenario: gezag wordt bepaald met gegeven van ouder 1: <omschrijving> in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    En persoon 'Nandy'
    * heeft 'Jorine' als ouder 1 met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang familierechtelijke betrekking (62.10) |
      | <aanduiding onderzoek>          | gisteren - 2 jaar                                  |
    * heeft 'Bastiaan' als ouder 2
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' gezamenlijk ouderlijk gezag met ouder 'Jorine' en ouder 'Bastiaan'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                               |
      | 020120               | burgerservicenummer                        |
      | 020240               | geslachtsnaam                              |
      | 026210               | datum ingang familierechtelijke betrekking |
      | 020000               | hele groep                                 |

  Abstract Scenario: gezag wordt bepaald met gegeven van ouder 2: <omschrijving> in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    En persoon 'Nandy'
    * heeft 'Jorine' als ouder 1
    * heeft 'Bastiaan' als ouder 2 met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang familierechtelijke betrekking (62.10) |
      | <aanduiding onderzoek>          | gisteren - 2 jaar                                  |
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' gezamenlijk ouderlijk gezag met ouder 'Jorine' en ouder 'Bastiaan'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                               |
      | 030120               | burgerservicenummer                        |
      | 030240               | geslachtsnaam                              |
      | 036210               | datum ingang familierechtelijke betrekking |
      | 030000               | hele groep                                 |

  Scenario: gezag wordt bepaald met gegeven geslachtsnaam van ouder 1 in onderzoek, er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Jorine'
    * is een vrouw
    Gegeven persoon 'Bastiaan'
    * is een man
    Gegeven persoon 'Nandy'
    * heeft 'Jorine' als ouder 1 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) | aanduiding in onderzoek (83.10) |
      | V                           | gisteren - 17 jaar                                 | 020410                          |
    * heeft 'Bastiaan' als ouder 2 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | M                           | gisteren - 17 jaar                                 |
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' eenhoofdig ouderlijk gezag met ouder 'Jorine'
    En is het gezag in onderzoek

  Scenario: gezag wordt bepaald met gegeven geslachtsnaam van ouder 2 in onderzoek, er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Jorine'
    * is een vrouw
    Gegeven persoon 'Bastiaan'
    * is een man
    Gegeven persoon 'Nandy'
    * heeft 'Jorine' als ouder 1 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | V                           | gisteren - 17 jaar                                 |
    * heeft 'Bastiaan' als ouder 2 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) | aanduiding in onderzoek (83.10) |
      | M                           | gisteren - 17 jaar                                 | 030410                          |
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' eenhoofdig ouderlijk gezag met ouder 'Jorine'
    En is het gezag in onderzoek

  Scenario: gezag wordt bepaald met historich aktenummer van ouder 1 in onderzoek er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Nandy'
    * is erkend door 'Jorine' als ouder 1 met erkenning bij geboorteaangifte
    * zijn van ouder 1 de volgende gegevens gewijzigd
      | aanduiding in onderzoek (83.10) | datum ingang familierechtelijke betrekking (62.10) |
      | 528120                          | gisteren - 17 jaar                                 |
    * zijn van ouder 1 de volgende gegevens gewijzigd
      | aanduiding in onderzoek (83.10) | datum ingang familierechtelijke betrekking (62.10) |
      |                                 | gisteren - 17 jaar                                 |
    * heeft 'Bastiaan' als ouder 2
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' eenhoofdig ouderlijk gezag met ouder 'Bastiaan'
    En is het gezag in onderzoek

  Scenario: gezag wordt bepaald met historich aktenummer van ouder 2 in onderzoek er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Nandy'
    * heeft 'Jorine' als ouder 1
    * is erkend door 'Bastiaan' als ouder 2 met erkenning bij geboorteaangifte
    * zijn van ouder 2 de volgende gegevens gewijzigd
      | aanduiding in onderzoek (83.10) | datum ingang familierechtelijke betrekking (62.10) |
      | 538120                          | gisteren - 17 jaar                                 |
    * zijn van ouder 2 de volgende gegevens gewijzigd
      | aanduiding in onderzoek (83.10) | datum ingang familierechtelijke betrekking (62.10) |
      |                                 | gisteren - 17 jaar                                 |
    Als 'gezag' wordt gevraagd van 'Nandy'
    Dan is het gezag over 'Nandy' eenhoofdig ouderlijk gezag met ouder 'Jorine'
    En is het gezag in onderzoek
