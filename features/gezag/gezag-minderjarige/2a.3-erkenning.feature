#language: nl

Functionaliteit: 2a.3 - erkenning
  Precondities voor deze vraag:
  | 1.1 Staat persoon (minderjarige) als ingezetene in de BRP?             | Ja                                                                                 |
  | 1.2 Is persoon a. minderjarig en b. niet overleden?                    | Ja                                                                                 |
  | 1.3 Is minderjarige naar het buitenland geëmigreerd geweest?           | Nee                                                                                |
  | 1.3a Is minderjarige in buitenland geboren?                            | Nee of geadopteerd met NL akte                                                     |
  | 1.4 Uitspraak gezag aanwezig?                                          | Nee of door een recente gebeurtenis het gezag toch (weer) van rechtswege verkregen |
  | 2.1 Hoeveel juridische ouders heeft de minderjarige?                   | 2                                                                                  |
  | 2a.1 Zijn beide ouders nu met elkaar gehuwd of geregistreerd partners? | Nee nooit                                                                          |
  | 2a.2 Is persoon geadopteerd met Nederlandse akte                       | Nee                                                                                |

  Hoe achterhalen of er erkenning is: Aktenummer Ouder1 of Ouder2 bevat op de 3e positie de akteaanduiding B (erkenning bij
  geboorteaangifte), C (erkenning na geboorte), J (erkenning bij notariële akte) of V (gerechtelijke vaststelling ouderschap). Deze kan in de actuele categorie voorkomen maar ook
  in een historische categorie omdat er later nog een ander rechtsfeit geregistreerd kan zijn. De datum van erkenning kan ontleend worden aan
  datum familierechtelijke betrekking van dezelfde categorie als die waarin akteaanduiding B of C geconstateerd is. Kan dus ook in de
  historie voorkomen.

  Aktenummers zoals vastgelecht in de BRP en opgenomen in de lijst erkenningscodes uit de publieke tabel 39.
  Zie: https://publicaties.rvig.nl/Landelijke_tabellen/Landelijke_tabellen_32_t_m_61_excl_tabel_35/Landelijke_Tabellen_32_t_m_61_in_csv_formaat/Tabel_39_Akteaanduiding

  Het bepalen of sprake is geweest van een erkenning ongeboren vrucht kan aan de hand van akteaanduiding A terwijl de ouders op
  moment geboorte niet met elkaar gehuwd zijn of een geregistreerd partnerschap hebben. Ook hierbij kan de akteaanduiding A in de historie
  voorkomen. Vervolgens moet dan wel uitgesloten worden dat ook niet een categorie voorkomt waarin akteaanduiding B, C of J voorkomt,
  want dat zou betekenen dat het kind later erkend is. Ook akteaanduiding Q moet uitgesloten worden want dat zou betekenen dat het kind later
  geadopteerd is. Ook hier geldt actueel en historisch voor wat betreft personen geboren voor 1-1-23 is duidelijk dat de
  erkenning ongeboren vrucht ook voor 1-1-23 geweest moet zijn, voor personen geboren na 1-1-23 is dat tot medio 10-2023 niet aan de BRP te
  herleiden.

  Wat betekend het wanneer een kind (of ongeboren vrucht) is erkend?
  - Indien het kind (of de ongeboren vrucht) is erkend voor 1-1-2023 is er sprake van 1 hoofdig gezag voor de moeder en volgt stap 4a Achterhalen bevoegdheid tot gezag (1 hoofdig gezag)
  - Indien het kind of de ongeboren vrucht is erkend na 1-1-2023 is er sprake van gezamenlijk ouderlijk gezag en volgt stap 4a Achterhalen bevoegdheid tot gezag (gezamenlijk ouderlijk gezag)

  Gebruikte velden:
  - Geboortedatum persoon -> 01.03.10
  - Aktenummer persoon -> 01.81.20
  - Aktenummer persoon historisch -> 51.81.20
  - Aktenummer ouder 1 -> 02.81.20
  - Aktenummer ouder 1 historisch -> 52.81.20
  - Aktenummer ouder 2 -> 03.81.20
  - Aktenummer ouder 2 historisch -> 53.81.20
  - Datum ingang familiebetrekking ouder 1 -> 02.62.10
  - Datum ingang familiebetrekking ouder 2 -> 03.62.10

  Achtergrond:
    Gegeven de persoon 'Lotte' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Dirk' met burgerservicenummer '000000024'
    * is meerderjarig
    En de persoon 'Filip' met burgerservicenummer '000000036'
    * is in Nederland geboren
    * is ingeschreven in de BRP

  Regel: Kind is geboren voor 01-01-2023

  Scenario: Het kind is niet erkend er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' eenhoofdig ouderlijk gezag met ouder 'Lotte'

  # Zie voor uitgebreidere voorbeelden betreft geboorte moeder bepaling feature: geboorte-moeder.feature
  Scenario: Het kind heeft twee ouders met onbekend geslacht is erkend als ongeboren vrucht maar is niet erkend achteraf er is sprake van GezagNietTeBepalen
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | O                           | gisteren - 17 jaar                                 |
    * heeft 'Dirk' als ouder 2 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | O                           | gisteren - 17 jaar                                 |
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' niet te bepalen met de toelichting 'Gezag kan niet worden bepaald omdat niet kan worden vastgesteld welke ouder de geboortemoeder is.'

  Scenario: Eén van de ouders heeft het kind erkend met de geboorteaangifte er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning bij geboorteaangifte
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' eenhoofdig ouderlijk gezag met ouder 'Lotte'

  Scenario: Eén van de ouders heeft het kind erkend na de geboorteaangifte er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning na geboorteaangifte op 30-12-2022
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' eenhoofdig ouderlijk gezag met ouder 'Lotte'

  Scenario: Eén van de ouders heeft het kind erkend na de geboorteaangifte op 01-01-2023 er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning na geboorteaangifte op 01-01-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

  Scenario: Eén van de ouders heeft het kind erkend na de geboorteaangifte na 01-01-2023 er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning na geboorteaangifte op 01-02-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

  Scenario: Eén van de ouders heeft het kind met een notariële akte erkend er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning bij notariële akte op 30-12-2022
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' eenhoofdig ouderlijk gezag met ouder 'Lotte'

  Scenario: Eén van de ouders heeft het kind met een notariële akte erkend op 01-01-2023 er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning bij notariële akte op 01-01-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

  Scenario: Eén van de ouders heeft het kind met een notariële akte erkend na 01-01-2023 er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning bij notariële akte op 26-01-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

  Scenario: Er is een gerechtelijke vaststelling ouderschap door één van de ouders is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met gerechtelijke vaststelling ouderschap op 30-12-2022
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' eenhoofdig ouderlijk gezag met ouder 'Lotte'

  Scenario: Er is een gerechtelijke vaststelling ouderschap door één van de ouders op 01-01-2023 er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning bij notariële akte op 01-01-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

  Scenario: Er is een gerechtelijke vaststelling ouderschap door één van de ouders na 01-01-2023 er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op 1-12-2022
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning bij notariële akte op 03-03-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

  Regel: Kind is geboren op 01-01-2023 of na 01-01-2023

  Abstract Scenario: Het kind geboren op <geboorte-datum> is als ongeboren vrucht erkend maar na geboorte niet erkend er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op <geboorte-datum>
    * heeft 'Lotte' als ouder 1
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' eenhoofdig ouderlijk gezag met ouder 'Lotte'

    Voorbeelden:
      | geboorte-datum |
      | 1-1-2023       |
      | 6-4-2023       |

  Abstract Scenario: Het kind geboren op <geboorte-datum> heeft twee ouder en is niet erkend er is sprake van TweehoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op <geboorte-datum>
    * heeft 'Lotte' als ouder 1
    * heeft 'Dirk' als ouder 2
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

    Voorbeelden:
      | geboorte-datum |
      | 1-1-2023       |
      | 6-4-2023       |

  Abstract Scenario: Eén van de ouders heeft het kind geboren op <geboorte-datum> erkend met de geboorteaangifte er is sprake van TweehoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op <geboorte-datum>
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning bij geboorteaangifte
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

    Voorbeelden:
      | geboorte-datum |
      | 1-1-2023       |
      | 6-4-2023       |

  Abstract Scenario: Eén van de ouders heeft het kind geboren op <geboorte-datum> erkend na de geboorteaangifte er is sprake van TweehoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op <geboorte-datum>
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning na geboorteaangifte op 29-01-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

    Voorbeelden:
      | geboorte-datum |
      | 1-1-2023       |
      | 6-4-2023       |

  Abstract Scenario: Eén van de ouders heeft het kind geboren op <geboorte-datum> met een notariële akte erkend er is sprake van TweehoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op <geboorte-datum>
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met erkenning bij notariële akte op 28-01-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

    Voorbeelden:
      | geboorte-datum |
      | 1-1-2023       |
      | 6-4-2023       |

  Abstract Scenario: Er is een gerechtelijke vaststelling ouderschap door één van de ouders er is sprake van TweehoofdigOuderlijkGezag
    Gegeven persoon 'Filip'
    * is geboren op <geboorte-datum>
    * heeft 'Lotte' als ouder 1
    * is erkend door 'Dirk' als ouder 2 met gerechtelijke vaststelling ouderschap op 01-02-2023
    Als 'gezag' wordt gevraagd van 'Filip'
    Dan is het gezag over 'Filip' gezamenlijk ouderlijk gezag met ouder 'Lotte' en ouder 'Dirk'

    Voorbeelden:
      | geboorte-datum |
      | 1-1-2023       |
      | 6-4-2023       |
