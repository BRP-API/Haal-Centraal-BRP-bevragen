#language: nl

Functionaliteit: 3.1 - is er sprake van een recente gebeurtenis - ontkenning
  Precondities voor deze vraag:
  | 1.1 Staat persoon (minderjarige) als ingezetene in de BRP?             | Ja                                                                                 |
  | 1.2 Is persoon a. minderjarig en b. niet overleden?                    | Ja                                                                                 |
  | 1.3 Is minderjarige naar het buitenland geëmigreerd geweest?           | Nee                                                                                |
  | 1.3a Is minderjarige in buitenland geboren?                            | Nee of geadopteerd met NL akte                                                     |
  | 1.4 Uitspraak gezag aanwezig?                                          | Ja                                                                                 |

  Het is mogelijk dat er een uitspraak is gedaan door de rechter, maar door een recentere gebeurtenis het gezag toch weer van rechtswege is verkregen of ingetrokken (ontkenning).
  Dit is (mogelijk) het geval bij de volgende gebeurtenissen: adoptie, hertrouwen of ontkenning ouderschap.

  Ontkenning ouderschap
  Omvat: ontkenning vaderschap (art. 1:200 en 1:201 BW) of moederschap (art. 1:202a en 1:202b BW) of nietige erkenning (art. 1:204) of vernietiging erkenning (art.
  1:205 en 1:205a BW).
  Het door het huwelijk of geregistreerd partnerschap ontstane ouderschap wordt geacht nimmer gevolg te hebben gehad (art. (1:202b in
  verbinding met) art. 1:202 lid 1 BW). Door de nietigheid/vernietiging van de erkenning wordt de erkenning geacht nimmer gevolg te hebben gehad
  (art. 1:206 lid 1 BW). Na ontekenning is de ouder niet meer juridisch ouder van het kind, terwijl de ouder volgens een eerdere uitspraak wel het gezag had.

  Hoe te achterhalen?
  Ontkenning ouderschap/vernietiging erkenning:
  Indicatie gezag bevat de waarde ‘1’ of ‘12’ en de geslachtsnaam van die ouder komt niet voor of bevat de waarde ‘.’. of de indicatie gezag bevat de waarde ‘2’ of ‘12’
  en de geslachtsnaam van die ouder komt niet voor of bevat de waarde ‘.’.
  Een ontkenning ouderschap en/of een vernietiging van een erkenning hebben altijd terugwerkende kracht en er ontstaat een ‘lege’ oudercategorie,
  herkenbaar aan het ontbreken van de geslachtsnaam. Als de geslachtsnaam wel voorkomt maar de waarde ‘.’ bevat dan is (nog) niet bekend wie die ouder is.

  Gebruikte velden:
  - Ouder -> 02.02.40
  - Geslachtsnaam van de ouder -> 03.02.40
  - Indicatie gezag -> 11.32.10
  - Ingangsdatum gezag -> 11.85.10
  - Datum ingang familierechtelijke betrekking -> 02.62.10 en 03.62.10

  Achtergrond:
    Gegeven de persoon 'Nelly' met burgerservicenummer '000000012'
    * is meerderjarig, niet overleden en staat niet onder curatele
    En de persoon 'Johnnie' met burgerservicenummer '000000024'
    * is meerderjarig, niet overleden en staat niet onder curatele
    En 'Nelly' en 'Johnnie' zijn met elkaar gehuwd
    En de persoon 'Kees' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is niet geëmigreerd geweest
    * is in Nederland geboren
    * heeft 'Nelly' als ouder 1
    * heeft 'Johnnie' als ouder 2

  Regel: Als vaderschap is ontkend of de erkenning is vernietigd en er was een uitspraak gezag voor die ouder, wordt het gezag van rechtswege bepaald

  @skip-verify
  Abstract Scenario: er is uitspraak gezag voor ouder 1 en ouder 2 en erkenning door ouder <ouder> is ontkend of vernietigd er is sprake van EenhoofdigOuderlijkGezag
    Gegeven voor 'Kees' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 12                                   | morgen - 10 jaar                |
    En zijn van ouder <ouder> de volgende gegevens <soort wijziging>
      | naam                                               | waarde       |
      | burgerservicenummer (01.20)                        |              |
      | geslachtsnaam (02.40)                              | <naam ouder> |
      | geboortedatum (03.10)                              |              |
      | datum ingang familierechtelijke betrekking (62.10) |              |
      | aktenummer (81.20)                                 | 1AF0100      |
    Als 'gezag' wordt gevraagd van 'Kees'
    Dan is het gezag over 'Kees' eenhoofdig ouderlijk gezag met ouder '<ouder naam>'

    Voorbeelden:
      | ouder | naam ouder | soort wijziging | ouder naam |
      | 1     |            | gewijzigd       | Johnnie    |
      | 1     | .          | gewijzigd       | Johnnie    |
      | 1     |            | gecorrigeerd    | Johnnie    |
      | 1     | .          | gecorrigeerd    | Johnnie    |
      | 2     |            | gewijzigd       | Nelly      |
      | 2     | .          | gewijzigd       | Nelly      |
      | 2     |            | gecorrigeerd    | Nelly      |
      | 2     | .          | gecorrigeerd    | Nelly      |

  Abstract Scenario: er is uitspraak gezag voogdij en erkenning door ouder 2 is ontkend of vernietigd er is sprake van Voogdij
    Gegeven voor 'Kees' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | D                                    | morgen - 10 jaar                |
    En zijn van ouder <ouder> de volgende gegevens <soort wijziging>
      | naam                                               | waarde       |
      | burgerservicenummer (01.20)                        |              |
      | geslachtsnaam (02.40)                              | <naam ouder> |
      | geboortedatum (03.10)                              |              |
      | datum ingang familierechtelijke betrekking (62.10) |              |
      | aktenummer (81.20)                                 | 1AF0100      |
    Als 'gezag' wordt gevraagd van 'Kees'
    Dan is het gezag over 'Kees' voogdij

    Voorbeelden:
      | ouder | naam ouder | soort wijziging |
      | 1     |            | gewijzigd       |
      | 1     | .          | gewijzigd       |
      | 1     |            | gecorrigeerd    |
      | 1     | .          | gecorrigeerd    |
      | 2     |            | gewijzigd       |
      | 2     | .          | gewijzigd       |
      | 2     |            | gecorrigeerd    |
      | 2     | .          | gecorrigeerd    |
