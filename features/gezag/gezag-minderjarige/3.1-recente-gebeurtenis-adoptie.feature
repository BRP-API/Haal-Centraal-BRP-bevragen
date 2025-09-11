#language: nl

Functionaliteit: 3.1 - is er sprake van een recente gebeurtenis - adoptie
  Precondities voor deze vraag:
  | 1.1 Staat persoon (minderjarige) als ingezetene in de BRP?             | Ja                                                                                 |
  | 1.2 Is persoon a. minderjarig en b. niet overleden?                    | Ja                                                                                 |
  | 1.3 Is minderjarige naar het buitenland geëmigreerd geweest?           | Nee                                                                                |
  | 1.3a Is minderjarige in buitenland geboren?                            | Nee of geadopteerd met NL akte                                                     |
  | 1.4 Uitspraak gezag aanwezig?                                          | Ja                                                                                 |

  Het is mogelijk dat er een uitspraak is gedaan door de rechter, maar door een recentere gebeurtenis het gezag toch weer van rechtswege is verkregen of ingetrokken (ontkenning).
  Dit is (mogelijk) het geval bij de volgende gebeurtenissen: adoptie, hertrouwen of ontkenning ouderschap.

  Adoptie
  Adoptiefouders zijn vaak eerst voogd geweest van de minderjarige. Nadat de adoptie rechtskracht heeft, vervalt de voogdij (1:281 lid 1b BW).
  Informatie over voogdij staat niet vermeld in de BRP. Deze moet worden opgevraagd uit het Gezagsregister.

  Hoe te achterhalen?
  Adoptie: Als de ingangsdatum gezag kleiner is dan de datum ingang familierechtelijke betrekking en de akteaanduiding bevat de waarde Q op de 3e positie
  dan is sprake van een adoptie nadat het gezag is opgenomen. Deze kan in de actuele categorie voorkomen maar ook in een historische categorie omdat er later
  nog een ander rechtsfeit geregistreerd kan zijn.
  De akteaanduiding Q kan overschreven zijn met de waarde T als door de ouders een verzoek is ontvangen om de gegevens van de adoptie te verwijderen/overschrijven.
  In die gevallen is de adoptie niet meer te herkennen op een persoonslijst.

  Gebruikte velden:
  - Indicatie gezag -> 11.32.10
  - Ingangsdatum gezag -> 11.85.10

  Achtergrond:
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Aart' met burgerservicenummer '000000024'
    * is meerderjarig
    En 'Gerda' en 'Aart' zijn met elkaar gehuwd
    En de persoon 'Bert' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is niet geëmigreerd geweest
    * is in Nederland geboren

  Regel: Als adoptie heeft plaatsgevonden na de gerechtelijke uitspraak over gezag, wordt het gezag van rechtswege bepaald

  Abstract Scenario: Een kind is geadopteerd door beide ouders na een gerechtelijke uitspraak er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | <indicatie gezag>                    | gisteren - 5 jaar               |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aktenummer (81.20) |
      | morgen - 4 jaar                                    | 1AQ0101            |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aktenummer (81.20) |
      | morgen - 4 jaar                                    | 1AQ0101            |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeelden:
      | indicatie gezag |
      | 1               |
      | 2               |
      | 12              |
      | 1D              |
      | 2D              |
      | D               |

  Abstract Scenario: Een kind is geadopteerd door <adoptie ouder> na de gerechtelijke uitspraak er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | gisteren - 5 jaar               |
    En heeft '<andere ouder>' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | gisteren - 17 jaar                                 |
    En 'Bert' is geadopteerd door '<adoptie ouder>' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aktenummer (81.20) |
      | morgen - 4 jaar                                    | 1AQ0102            |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeelden:
      | adoptie ouder | andere ouder | andere ouder bsn |
      | Gerda         | Aart         | 000000024        |
      | Aart          | Gerda        | 000000012        |

  Scenario: Een kind is geadopteerd vóór de gerechtelijke uitspraak er is sprake van Voogdij
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | gisteren - 5 jaar               |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 6 jaar                                    |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 6 jaar                                    |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' voogdij

  Abstract Scenario: Een kind is geadopteerd vóór de gerechtelijke uitspraak en de gegevens van het kind zijn na de uitspraak gewijzigd <omschrijving> er is sprake van Voogdij
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | gisteren - 5 jaar               |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 6 jaar                                    |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 6 jaar                                    |
    En zijn de volgende gegevens gewijzigd
      | aktenummer (81.20) | ingangsdatum geldigheid (85.10) |
      | <aktenummer>       | morgen - 4 jaar                 |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' voogdij

    Voorbeelden:
      | aktenummer | omschrijving                           |
      | 1AQ0100    | onder zelfde adoptie aktenummer        |
      | 1AW0200    | ander soort wijziging (naamswijziging) |

  Regel: Als adoptie gegevens gecorrigeerd zijn worden de vorige adoptiegegevens genegeerd

  Scenario: Voor een kind is de gerechtelijke uitspraak voor adoptie gecorrigeerd er is sprake van Voogdij
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | gisteren - 5 jaar               |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 4 jaar                                    |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 4 jaar                                    |
    En de adoptie van 'Bert' is herroepen voor 'Gerda' als ouder 1
    En de adoptie van 'Bert' is herroepen voor 'Aart' als ouder 2
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' voogdij

  Regel: Als de datum van de gerechtelijke uitspraak over gezag onbekend is kan er geen gezag uitspraak worden gedaan

  Scenario: Een kind is geadopteerd en datum ingang de gerechtelijke uitspraak is volledig onbekend er is sprake van GezagNietTeBepalen
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | 00000000                        |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 4 jaar                                    |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | morgen - 4 jaar                                    |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'Gezag kan niet worden bepaald omdat relevante gegevens ontbreken. Het gaat om de volgende gegevens: ingangsdatum geldigheid van gezagsverhouding'

  Regel: Als de datum van de gerechtelijke uitspraak over gezag gedeeltelijk onbekend is, wordt de eerste dag van de maand van de onzekerheidsperiode aangenomen

  Abstract Scenario: gezag wordt van rechtswege bepaald voor minderjarige die is geadopteerd en <omschrijving> er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | <datum uitspraak gezag>         |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | 20210617                                           |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | 20210617                                           |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeelden:
      | datum uitspraak gezag | omschrijving                                                                     |
      | 20190000              | alleen jaar is bekend van datum uitspraak en ligt zeker voor datum adoptie       |
      | 20210000              | alleen jaar is bekend van datum uitspraak en is zelfde jaar als datum adoptie    |
      | 20210500              | jaar en maand is bekend van datum uitspraak en ligt zeker voor datum adoptie     |
      | 20210600              | jaar en maand is bekend van datum uitspraak en is zelfde maand als datum adoptie |

  Abstract Scenario: gezag wordt bepaald uit gerechtelijke uitspraak voor minderjarige die is geadopteerd en <omschrijving> er is sprake van Voogdij
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | <datum uitspraak gezag>         |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | 20210617                                           |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | 20210617                                           |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' voogdij

    Voorbeelden:
      | datum uitspraak gezag | omschrijving                                                               |
      | 20230000              | alleen jaar is bekend van datum uitspraak en ligt zeker na datum adoptie   |
      | 20210700              | jaar en maand is bekend van datum uitspraak en ligt zeker na datum adoptie |

  Regel: Als de datum adoptie volledig onbekend is, wordt gezag bepaald volgens de gerechtelijke uitspraak over gezag

  Abstract Scenario: gezag wordt bepaald uit gerechtelijke uitspraak voor minderjarige die is geadopteerd en datum adoptie is volledig onbekend er is sprake van Voogdij
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | 20210617                        |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | <datum adoptie door Gerda>                         |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | <datum adoptie door Aart>                          |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' voogdij

    Voorbeelden:
      | datum adoptie door Gerda | datum adoptie door Aart |
      | 00000000                 | morgen - 17 jaar        |
      | morgen - 17 jaar         | 00000000                |
      | 00000000                 | 00000000                |

  Regel: Als de datum adoptie gedeeltelijk onbekend is, wordt de eerste dag van de maand van de onzekerheidsperiode aangenomen

  Abstract Scenario: gezag wordt van rechtswege bepaald voor minderjarige die is geadopteerd en <omschrijving> er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | 20210617                        |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | <datum adoptie>                                    |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | <datum adoptie>                                    |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeelden:
      | datum adoptie | omschrijving                                                                     |
      | 20230000      | alleen jaar is bekend van datum adoptie en ligt zeker na datum uitspraak gezag   |
      | 20210700      | jaar en maand is bekend van datum adoptie en ligt zeker na datum uitspraak gezag |
      | 20230000      | alleen jaar is bekend van datum adoptie en ligt zeker na datum uitspraak gezag   |
      | 20210700      | jaar en maand is bekend van datum adoptie en ligt zeker na datum uitspraak gezag |

  Abstract Scenario: gezag wordt bepaald uit gerechtelijke uitspraak voor minderjarige die is geadopteerd en <omschrijving> er is sprake van Voogdij
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | <datum uitspraak gezag>         |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | <datum adoptie>                                    |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) |
      | <datum adoptie>                                    |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' voogdij

    Voorbeelden:
      | datum adoptie | datum uitspraak gezag | omschrijving                                                                             |
      | 20190000      | 20210617              | alleen jaar is bekend van datum adoptie en ligt zeker voor datum uitspraak gezag         |
      | 20210000      | 20210617              | alleen jaar is bekend van datum adoptie en is zelfde jaar als uitspraak gezag            |
      | 20210000      | 20210101              | alleen jaar is bekend van datum adoptie en uitspraak gezag is eerste dag van dat jaar    |
      | 20210500      | 20210617              | jaar en maand is bekend van datum adoptie en ligt zeker voor datum uitspraak gezag       |
      | 20210600      | 20210617              | jaar en maand is bekend van datum adoptie en is zelfde maand als uitspraak gezag         |
      | 20210600      | 20210601              | jaar en maand is bekend van datum adoptie en uitspraak gezag is eerste dag van die maand |

  Regel: Als datum familierechtelijke betrekking in onderzoek staat is het gezag niet te bepalen

  Abstract Scenario: gezag wordt bepaald wanneer <omschrijving> in onderzoek staat er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | gisteren - 5 jaar               |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aanduiding in onderzoek (83.10) |
      | gisteren - 4 jaar                                  | <aanduiding onderzoek Gerda>    |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aanduiding in onderzoek (83.10) |
      | gisteren - 4 jaar                                  | <aanduiding onderzoek Aart>     |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek Gerda | aanduiding onderzoek Aart | omschrijving                                           |
      | 020000                     |                           | hele categorie ouder 1                                 |
      | 026200                     |                           | hele groep familierechtelijke betrekking van ouder 1   |
      | 026210                     |                           | datum ingang familierechtelijke betrekking van ouder 1 |
      |                            | 030000                    | hele categorie ouder 2                                 |
      |                            | 036200                    | hele groep familierechtelijke betrekking van ouder 2   |
      |                            | 036210                    | datum ingang familierechtelijke betrekking van ouder 2 |

  Scenario: gezag wordt bepaald als het onderzoek op de familierechtelijke betrekking is beëindigd er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | gisteren - 5 jaar               |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aanduiding in onderzoek (83.10) | datum einde onderzoek (83.30) |
      | gisteren - 4 jaar                                  | 026210                          | gisteren                      |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aanduiding in onderzoek (83.10) | datum einde onderzoek (83.30) |
      | gisteren - 4 jaar                                  | 036210                          | gisteren                      |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

  Abstract Scenario: gezag kan worden bepaald wanneer het onderzoek op de familierechtelijke betrekking is beëindigd voor een ouder en niet beëindigd voor de andere ouder er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | gisteren - 5 jaar               |
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aanduiding in onderzoek (83.10) | datum einde onderzoek (83.30) |
      | gisteren - 4 jaar                                  | 026210                          | <einde onderzoek Gerda>       |
    En 'Bert' is geadopteerd door 'Aart' als ouder 2 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aanduiding in onderzoek (83.10) | datum einde onderzoek (83.30) |
      | gisteren - 4 jaar                                  | 036210                          | <einde onderzoek Aart>        |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'
    En is het gezag in onderzoek

    Voorbeelden:
      | einde onderzoek Gerda | einde onderzoek Aart |
      | gisteren              |                      |
      |                       | gisteren             |

  Regel: Als indicatie gezag of ingangsdatum gezagsverhouding in onderzoek staan, is het gezag niet te bepalen

  Abstract Scenario: gezag kan worden bepaald wanneer <omschrijving> in onderzoek staat er is sprake van Voogdij
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) | aanduiding in onderzoek (83.10) |
      | D                                    | gisteren - 5 jaar               | <aanduiding onderzoek>          |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' voogdij
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                    |
      | 110000               | hele categorie gezagsverhouding |
      | 113200               | hele groep gezag minderjarige   |
      | 113210               | indicatie gezag minderjarige    |
      | 118500               | hele groep geldigheid           |
      | 118510               | datum ingang geldigheid         |

  Scenario: gezag kan wel worden bepaald als het onderzoek op de gezagsverhouding is beëindigd er is sprake van Voogdij
    Gegeven voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) | aanduiding in onderzoek (83.10) | datum einde onderzoek (83.30) |
      | D                                    | gisteren - 5 jaar               | 110000                          | gisteren                      |
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan is het gezag over 'Bert' voogdij
