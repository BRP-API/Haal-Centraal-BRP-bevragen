#language: nl

Functionaliteit: 3.1 - is er sprake van een recente gebeurtenis - hertrouwen
  Precondities voor deze vraag:
  | 1.1 Staat persoon (minderjarige) als ingezetene in de BRP?             | Ja                                                                                 |
  | 1.2 Is persoon a. minderjarig en b. niet overleden?                    | Ja                                                                                 |
  | 1.3 Is minderjarige naar het buitenland geëmigreerd geweest?           | Nee                                                                                |
  | 1.3a Is minderjarige in buitenland geboren?                            | Nee of geadopteerd met NL akte                                                     |
  | 1.4 Uitspraak gezag aanwezig?                                          | Ja                                                                                 |

  Het is mogelijk dat er een uitspraak is gedaan door de rechter, maar door een recentere gebeurtenis het gezag toch weer van rechtswege is verkregen of ingetrokken (ontkenning).
  Dit is (mogelijk) het geval bij de volgende gebeurtenissen: adoptie, hertrouwen of ontkenning ouderschap.

  Hertrouwen
  Indien gewezen echtgenoten met elkaar hertrouwen dan wel een geregistreerd partnerschap aangaan, herleeft van rechtswege het gezamenlijk
  gezag (1:253 lid 1 BW). Dit geldt als het gezag na de scheiding bij één van de ouders lag door beëindiging van het gezag op grond van 1:251a of 1:253n.
  Hierbij moet rekening gehouden worden met de uitzonderingen, de ‘tenzij’ in dit artikel. De uitzonderingen zijn:
  • Het gezag is beëindigd op grond van artikel 1:266 BW -> Let op: Dit is nu niet of lastig te achterhalen!
  • Het gezag wordt inmiddels gezamenlijk uitgeoefend met een ander dan de ouder (1:253t BW)

  Hoe te achterhalen?
  Reparatiehuwelijk: Indicatie gezag gelijk aan ‘1’ of ‘2’ en laatste huwelijksdatum van de ouders is groter dan ingangsdatum van de indicatie gezag.
  Bij een reparatiehuwelijk (twee huwelijk/ geregistreerd partnerschap tussen dezelfde personen) is dit alleen van toepassing als het gezag eerder
  toegewezen was aan één der ouders.

  Opmerkingen
  - openstaande vraag is waarom is het sluiten van een huwelijk geen reden om de indicatie gezag te herzien en een reparatiehuwelijk wel?

  Aanbevelingen
  Een actieve registratie van categorie 11 op basis van de meest voorkomende gebeurtenissen zou een betere oplossing zijn dan het afleiden aan de hand van
  uitzonderingsssituaties zoals nu in vraag 3.1.

  Gebruikte velden:
  - Indicatie gezag -> 11.32.10
  - Ingangsdatum gezag -> 11.85.10
  - Datum ingang familierechtelijke betrekking -> 02.62.10 en 03.62.10
  - Laatste huwelijksdatum -> 05.06.10

  Achtergrond:
    Gegeven de persoon 'Laura' met burgerservicenummer '000000012'
    * is meerderjarig, niet overleden en staat niet onder curatele
    En de persoon 'Lido' met burgerservicenummer '000000024'
    * is meerderjarig, niet overleden en staat niet onder curatele
    En de persoon 'Rik' met burgerservicenummer '000000048'
    * is meerderjarig
    En de persoon 'Janine' met burgerservicenummer '000000061'
    * is meerderjarig
    En de persoon 'Linda' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is niet geëmigreerd geweest
    * is in Nederland geboren
    * heeft 'Laura' als ouder 1
    * heeft 'Lido' als ouder 2

  Regel: Als de ouders met elkaar zijn hertrouwd of opnieuw partnerschap zijn aangegaan na gerechtelijke uitspraak tot gezag voor één van beide ouders, wordt het gezag van rechtswege bepaald

  Abstract Scenario: gezag wordt van rechtswege bepaald voor minderjarige waarbij na gerechtelijke uitspraak tot gezag ouder<indicatie gezag> de ouders zijn hertrouwd er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | <indicatie gezag>                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 6 jaar                                            |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 2 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' gezamenlijk ouderlijk gezag met ouder 'Laura' en ouder 'Lido'

    Voorbeelden:
      | indicatie gezag |
      | 1               |
      | 2               |

  Abstract Scenario: gezag wordt van rechtswege bepaald voor minderjarige waarbij <omschrijving> er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | <datum aangaan 1e huwelijk>                                        |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | <datum ontbinding 1e huwelijk>                               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 2 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' gezamenlijk ouderlijk gezag met ouder 'Laura' en ouder 'Lido'

    Voorbeelden:
      | datum aangaan 1e huwelijk | datum ontbinding 1e huwelijk | omschrijving                                                                             |
      | gisteren - 20 jaar        | gisteren - 6 jaar            | ouders zijn getrouwd en gescheiden voor de uitspraak en na de uitspraak hertrouwd        |
      | gisteren - 20 jaar        | gisteren - 4 jaar            | ouders zijn getrouwd voor de uitspraak en gescheiden na de uitspraak en daarna hertrouwd |
      | gisteren - 4 jaar         | gisteren - 3 jaar            | ouders zijn getrouwd en gescheiden na de uitspraak en daarna hertrouwd                   |

  Scenario: geen 'recente gebeurtenis' omdat de ouders na de uitspraak voor het eerst met elkaar zijn getrouwd er is sprake van EenhoofdigOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 3 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' eenhoofdig ouderlijk gezag met ouder 'Laura'

  Scenario: geen 'recente gebeurtenis' omdat de ouders na het 'herstelhuwelijk' weer zijn gescheiden er is sprake van EenhoofdigOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 6 jaar                                            |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 2 jaar                                                  | gisteren - 1 jaar                                            |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' gezamenlijk ouderlijk gezag met ouder 'Laura' en ouder 'Lido'

  Scenario: geen 'recente gebeurtenis' omdat de ouders getrouwd zijn met een andere derde persoon (niet de ander ouder) er is sprake van EenhoofdigOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 6 jaar                                            |
    En 'Laura' en 'Rik' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 4 jaar                                                  |
    En 'Lido' en 'Janine' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 4 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' eenhoofdig ouderlijk gezag met ouder 'Laura'

  Scenario: geen 'recente gebeurtenis' omdat de ouders al voor de uitspraak met elkaar hertrouwd zijn er is sprake van EenhoofdigOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 12 jaar                                           |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 6 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' eenhoofdig ouderlijk gezag met ouder 'Laura'

  Scenario: geen 'recente gebeurtenis' omdat de gerechtelijke uitspraak tot gezag een derde is er is sprake van Voogdij
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 6 jaar                                            |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 2 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' voogdij

  Abstract Scenario: : geen 'recente gebeurtenis' omdat de gerechtelijke uitspraak tot gezag <omschrijving uitspraak> is er is sprake van GezamenlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | <indicatie gezag>                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 6 jaar                                            |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 2 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' gezamenlijk gezag met ouder '<ouder>' en een onbekende derde

    Voorbeelden:
      | indicatie gezag | omschrijving uitspraak | ouder |
      | 1D              | ouder 1 en een derde   | Laura |
      | 2D              | ouder 2 en een derde   | Lido  |

  Regel: Onjuist opgenomen (gecorrigeerde) huwelijks- of partnerschapsgegevens worden genegeerd

  Scenario: geen 'recente gebeurtenis' omdat het herstelhuwelijk met een correctie volledig is verwijderd er is sprake van EenhoofdigOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 6 jaar                                            |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 2 jaar                                                  |
    En is het huwelijk van 'Laura' en 'Lido' gecorrigeerd met de volgende gegevens
      | naam                                                                | waarde |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  |        |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) |        |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   |        |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' eenhoofdig ouderlijk gezag met ouder 'Laura'

  Scenario: geen 'recente gebeurtenis' wanneer het eerste huwelijk met een correctie volledig is verwijderd er is sprake van EenhoofdigOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En is het huwelijk van 'Laura' en 'Lido' gecorrigeerd met de volgende gegevens
      | naam                                                                | waarde |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  |        |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) |        |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   |        |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 2 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' eenhoofdig ouderlijk gezag met ouder 'Laura'

  Scenario: geen 'recente gebeurtenis' wanneer de datum huwelijkssluiting van het eerste en enige huwelijk is gecorrigeerd er is sprake van EenhoofdigOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 2 jaar                                                  |
    En is het huwelijk van 'Laura' en 'Lido' gecorrigeerd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | vandaag - 2 jaar                                                   |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' eenhoofdig ouderlijk gezag met ouder 'Laura'

  Regel: Als het huwelijk of partnerschap in staat onderzoek, is het gezag wel te bepalen

  Abstract Scenario: Gezag wordt van rechtswege bepaald na reparatiehuwelijk en <omschrijving> staat in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 6 jaar                                            |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | aanduiding in onderzoek (83.10) |
      | gisteren - 2 jaar                                                  | <aanduiding onderzoek>          |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' gezamenlijk ouderlijk gezag met ouder 'Laura' en ouder 'Lido'

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                            |
      | 050200               | hele groep naam van partner             |
      | 050240               | geslachtsnaam van partner               |
      | 050300               | hele groep geboorte van partner         |
      | 050620               | plaats aangaan huwelijk of partnerschap |
      | 050670               | land aangaan huwelijk of partnerschap   |

  Abstract Scenario: Gezag wordt van rechtswege bepaald na reparatiehuwelijk en <omschrijving> staat in onderzoek er is sprake van GezamenlijkOuderlijkGezag
    Gegeven voor 'Linda' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | gisteren - 5 jaar               |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 20 jaar                                                 |
    En 'Laura' en 'Lido' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 6 jaar                                            |
    En 'Laura' en 'Lido' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | aanduiding in onderzoek (83.10) |
      | gisteren - 2 jaar                                                  | <aanduiding onderzoek>          |
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan is het gezag over 'Linda' gezamenlijk ouderlijk gezag met ouder 'Laura' en ouder 'Lido'
    En is het gezag in onderzoek

    Voorbeelden:
      | aanduiding onderzoek | omschrijving                                |
      | 050120               | burgerservicenummer partner                 |
      | 050000               | hele categorie partnerschap                 |
      | 050600               | hele groep aangaan huwelijk of partnerschap |
      | 050610               | datum aangaan huwelijk of partnerschap      |