# language: nl

@gba @autorisatie
Functionaliteit: autorisatie voor het gebruik van de API
  Autorisatie voor het gebruik van de API gebeurt op twee niveau's:
  1. autorisatie van de gebruiker door de afnemende organisatie
  2. autorisatie van de afnemer (organisatie) door RvIG

  Deze feature beschrijft alleen de autorisatie van de afnemer door RvIG.

  Autorisatie is gebaseerd op het autorisatiebesluit van een afnemer, die is vastgelegd in tabel 35 voor een afnemer.
  Deze kan je voor een afnemer zoeken op https://publicaties.rvig.nl/Landelijke_tabellen/Zoekpagina_tabel_35_autorisatietabel.
  In het autorisatiebesluit staat voor welke gegevens de afnemer geautoriseerd is. 

  De autorisatie voor gegevens is vastgelegd in Rubrieknummer ad hoc (35.95.60). 
  Deze bevat een lijst met rubrieknummers (spatie gescheiden) van gegevens die geleverd mogen worden. 
  Een rubrieknummer is het nummer voor een gegeven zoals gedefinieerd in het Logisch Ontwerp BRP (LO BRP) zonder voorloopnullen voor categorienummer (dus 5 of 6 cijfers).
  Voor het toepassen van de autorisatie moet het rubrieknummer worden vertaald naar het corresponderende veld in de BRP API resource (of andersom). Deze vertaling staat beschreven in /docs/BRP-LO GBA mapping.md.

  Autorisatie wordt verkregen met behulp van een Oauth 2 token. 
  In het verkregen token is de afnemerindicatie opgenomen die de afnemer uniek identificeert. Op basis van de afnemerindicatie kan de autorisatie worden opgezocht.
  Wanneer de afnemer een gemeente is, is er ook een gemeentecode opgenomen in de Oauth token.

  Voor één afnemer kunnen er meerdere rijen zijn in de autorisatietabel, maar daarvan kan er maar één actueel zijn. Alleen de actuele mag worden gebruikt.
  Een autorisatie is actueel wanneer de Datum ingang (35.99.98) in het verleden ligt en Datum beëindiging tabelregel (35.99.99) leeg is of in de toekomst ligt.

  # Autorisaties worden opgeslagen in de tabel lo3_autorisatie. Deze bevat minimaal:
  #  - autorisatie_id: technische identificatie (primary key) = max(autorisatie_id)+1
  #  - afnemer_code: vullen met 'Afnemersindicatie (35.95.10)' in Gegeven, wordt ook opgenomen in Oauth token gestuurd bij Als stap
  #  - tabel_regel_start_datum: vullen met 'Datum ingang (35.99.98)' in Gegeven stap
  #  - tabel_regel_eind_datum: vullen met 'Datum beëindiging tabelregel (35.99.99)' in Gegeven stap
  #  - ad_hoc_medium: vullen met 'Medium ad hoc (35.95.67)' in Gegeven stap, vaste waarde 'N' (betekent dat de autorisatie er wel is)
  #  - ad_hoc_rubrieken: vullen met waarde voor 'Rubrieknummer ad hoc (35.95.60)' in Gegeven stap


  # To Do (t.z.t.): regels voor leveren persoonsgegevens met geheimhouding aan derde (35.95.12)
  # To Do (t.z.t.): regels voor voorwaarderegel ad hoc (35.95.61)


  Rule: Een afnemer is geautoriseerd voor ad hoc gegevensverstrekking als Medium ad hoc (35.95.67) de waarde “N” of “A” heeft
    Wanneer Medium ad hoc (35.95.67) leeg is of een andere waarde dan "N" of "A" heeft, wordt een foutmelding gegeven

    @fout-case
    Scenario: Afnemer is niet geautoriseerd voor ad hoc gegevensverstrekking
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210                     |                          | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam.voornamen                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3 |
      | title    | U bent niet geautoriseerd voor het gebruik van deze API.    |
      | status   | 403                                                         |
      | detail   | Niet geautoriseerd voor ad hoc bevragingen.                 |
      | code     | unauthorized                                                |
      | instance | /haalcentraal/api/brp/personen                              |


  Rule: Zoeken met een parameter op een veld waarvoor de gebruiker niet geautoriseerd is geeft een foutmelding
    Om een parameter te mogen gebruiken moet de afnemer geautoriseerd zijn voor de LO BRP rubriek waar met de parameter op gefilterd wordt

    @fout-case
    Scenario: Zoeken met een zoektype met verplichte parameter waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)           | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80810 81110 81120 81130 81140 81150 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
      | 0599                 | 0599200000219679                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200000219679                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                                 |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                   |
      | status   | 403                                                                                         |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): nummeraanduidingIdentificatie. |
      | code     | unauthorizedParameter                                                                       |
      | instance | /haalcentraal/api/brp/personen                                                              |

    @fout-case
    Scenario: Zoeken met een optionele parameter waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)     | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210 10220 10230 10240 10310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | geslacht      | M                                   |
      | fields        | burgerservicenummer                 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3            |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).              |
      | status   | 403                                                                    |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): geslacht. |
      | code     | unauthorizedParameter                                                  |
      | instance | /haalcentraal/api/brp/personen                                         |


  Rule: Vragen met fields om een veld waarvoor de gebruiker niet geautoriseerd is geeft een foutmelding
    Om een veld te mogen vragen moet de afnemer geautoriseerd zijn voor alle LO BRP rubrieken waar het veld mee gevuld of van afgeleid wordt

    @fout-case
    Scenario: Afnemer vraagt om een veld (geboorte.plaats) waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)     | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210 10220 10230 10240 10310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                            |
      | type                | RaadpleegMetBurgerservicenummer                                   |
      | burgerservicenummer | 000000024                                                         |
      | fields              | burgerservicenummer,geboorte.datum,geboorte.plaats,naam.voornamen |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

    @fout-case
    Scenario: Afnemer vraagt om meerdere velden (geboorteplaatsen geboorteland) waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)     | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210 10220 10230 10240 10310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                       |
      | type                | RaadpleegMetBurgerservicenummer              |
      | burgerservicenummer | 000000024                                    |
      | fields              | geboorte.datum,geboorte.plaats,geboorte.land |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

    @fout-case
    Abstract Scenario: Afnemer vraagt om gegevensgroep <fields> en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) | aanduiding naamgebruik (61.10) |
      | 19830526              | Maassen               | Pieter            | M                           | E                              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields          | ad hoc rubrieken              | missende autorisatie                         |
      | naam            | 10120 10210 10220 10230 10240 | aanduidingNaamgebruik (16110)                |
      | geboorte        | 10120 10310                   | geboorteplaats (10320), geboorteland (10330) |
      | nationaliteiten | 10120 40510 46310 46410 46510 | datumIngangGeldigheid (48510)                |


  Rule: Vragen met fields gevraagd om een veld dat is afgeleid van één of meerdere andere velden, wanneer de gebruiker niet geautoriseerd is voor al die velden, geeft een foutmelding
  
    @fout-case
    Scenario: Afnemer vraagt om afgeleid gegeven <fields> en is niet geautoriseerd <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                                        | ad hoc rubrieken | missende autorisatie                 |
      | leeftijd                                      | 10120            | geboortedatum (10310)                |
      | immigratie.indicatieVestigingVanuitBuitenland | 10120 81410      | datum vestiging in nederland (81420) |

    @fout-case
    Scenario: Afnemer zonder autorisatie bijzonder Nederlanderschap vraagt om een gegeven van nationaliteit van persoon met Nederlandse nationaliteit
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 40510                     | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | nationaliteiten.nationaliteit   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

    @fout-case
    Scenario: Afnemer (niet gemeente) vindt geen enkele persoon op de zoekvraag en fields vraagt om geslacht (10410) waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 010240 010310            | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
      | 19830526              | Maassen               | Pieter            |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | geslacht                            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |


  Rule: Een veld dat automatisch wordt meegeleverd vereist geen autorisatie voor dat veld

    Scenario: Afnemer heeft onderzoek, geheimhouding, opschorting, rni en verificatie en heeft dat niet in de autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 010240                   | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                            | waarde                                      |
      | geslachtsnaam (02.40)           | Jansen                                      |
      | aanduiding in onderzoek (83.10) | 010000                                      |
      | datum ingang onderzoek (83.20)  | 20230219                                    |
      | rni-deelnemer (88.10)           | 0101                                        |
      | omschrijving verdrag (88.20)    | Belastingverdrag tussen België en Nederland |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde               |
      | indicatie geheim (70.10)             | 7                    |
      | datum opschorting bijhouding (67.10) | 20220829             |
      | reden opschorting bijhouding (67.20) | R                    |
      | datum verificatie (71.10)            | 20230126             |
      | omschrijving verificatie (71.20)     | bewijs nationaliteit |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000024                              |
      | fields              | burgerservicenummer,naam.geslachtsnaam |
      Dan heeft de response 1 persoon


  Rule: voor het vragen en beoordelen van gegevens is geen autorisatie nodig voor gebruik van indicatie onjuist (84.10)

    Scenario: kindgegevens zijn gecorrigeerd (zijn onjuist) en afnemer is heeft geen autorisatie voor indicatie onjuist (98410) 
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 09210 90310               | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Gegeven de persoon met burgerservicenummer '000000061' heeft een 'kind' met de volgende gegevens
      | naam                            | waarde          |
      | voornamen (02.10)               | Daan            |
      | voorvoegsel (02.30)             | de              |
      | geslachtsnaam (02.40)           | Vries           |
      | geboortedatum (03.10)           | 20031107        |
      | gemeente document (82.10)       | 0518            |
      | datum document (82.20)          | 20031109        |
      | beschrijving document (82.30)   | PL gerelateerde |
      | ingangsdatum geldigheid (85.10) | 20031107        |
      | datum van opneming (86.10)      | 20031109        |
      En het 'kind' is gecorrigeerd naar de volgende gegevens
      | naam                            | waarde           |
      | gemeente document (82.10)       | 0518             |
      | datum document (82.20)          | 20040105         |
      | beschrijving document (82.30)   | D27894-2004-A782 |
      | ingangsdatum geldigheid (85.10) | 20031107         |
      | datum van opneming (86.10)      | 20040112         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetBurgerservicenummer                 |
      | burgerservicenummer | 000000061                                       |
      | fields              | kinderen.naam.voornamen,kinderen.geboorte.datum |
      Dan heeft de response een persoon zonder 'kind' gegevens


  Rule: Een gemeente als afnemer is geautoriseerd voor alle zoekvragen voor haar eigen inwoners
    Wanneer de afnemer parameter gemeenteVanInschrijving gebruikt 
    en die is gelijk aan de waarde van gemeenteCode in de 'claim', 
    dan wordt niet gekeken naar de autorisatie van de afnemer

    Scenario: Gemeente is niet geautoriseerd voor de zoekparameters maar zoekt alleen eigen inwoners met parameter gemeenteVanInschrijving
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800200000219679                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0800200000219679                     |
      | gemeenteVanInschrijving       | 0800                                 |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 1 persoon
  
  Rule: Een gemeente als afnemer is geautoriseerd voor alle gegevens van eigen inwoners
    Wanneer de afnemer parameter gemeenteVanInschrijving gebruikt 
    en die is gelijk aan de waarde van gemeenteCode in de 'claim', 
    dan wordt niet gekeken naar de autorisatie van de afnemer

    Scenario: Gemeente raadpleegt een eigen inwoner met de gemeenteVanInschrijving parameter en fields vraagt om partners.geslacht (50410) dat niet in de autorisatie zit
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 50240 50610               | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | Groenen               | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                          |
      | type                    | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer     | 000000024                       |
      | gemeenteVanInschrijving | 0800                            |
      | fields                  | partners.geslacht               |
      Dan heeft de response 1 persoon

    @fout-case
    Scenario: Gemeente raadpleegt een eigen inwoner zonder de gemeenteVanInschrijving parameter en fields vraagt om partners.geslacht (50410) dat niet in de autorisatie zit
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 50240 50610               | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | Groenen               | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                          |
      | type                    | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer     | 000000024                       |
      | fields                  | partners.geslacht               |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

    @fout-case
    Scenario: Gemeente raadpleegt een inwoner van een andere gemeente met de gemeenteVanInschrijving parameter en fields vraagt om partners.geslacht (50410) dat niet in de autorisatie zit
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 50240 50610               | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) |
      | 0599                 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | Groenen               | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                          |
      | type                    | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer     | 000000024                       |
      | gemeenteVanInschrijving | 0599                            |
      | fields                  | partners.geslacht               |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |


  Rule: Alleen een autorisatie tabelregel waarbij de Datum beëindiging tabelregel (35.99.99) leeg is of in de toekomst ligt wordt gebruikt

    @fout-case
    Scenario: Autorisatie voor ad hoc gegevensverstrekking is ingetrokken
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) | Datum beëindiging tabelregel (35.99.99) |
      | 010120 010210                   | N                        | 20201128                | 20221201                                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3 |
      | title    | U bent niet geautoriseerd voor het gebruik van deze API.    |
      | status   | 403                                                         |
      | detail   | Niet geautoriseerd voor ad hoc bevragingen.                 |
      | code     | unauthorized                                                |
      | instance | /haalcentraal/api/brp/personen                              |

    @fout-case
    Scenario: Autorisatie voor gebruikte parameter is ingetrokken
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                 | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) | Datum beëindiging tabelregel (35.99.99) |
      | 10120 80810 81110 81120 81130 81140 81150 81190 | N                        | 20201128                | 20221201                                |
      En de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                 | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80810 81110 81120 81130 81140 81150       | N                        | 20221201                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
      | 0599                 | 0599200000219679                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200000219679                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                                 |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                   |
      | status   | 403                                                                                         |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): nummeraanduidingIdentificatie. |
      | code     | unauthorizedParameter                                                                       |
      | instance | /haalcentraal/api/brp/personen                                                              |

    @fout-case
    Scenario: Autorisatie voor gevraagd veld is ingetrokken
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) | Datum beëindiging tabelregel (35.99.99) |
      | 10120 81010 81110 81210 81310   | N                        | 20201128                | 20221201                                |
      En de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81110 81210 81310         | N                        | 20221201                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) |
      | 0599                              | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0599                 | Plein              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

    Scenario: Autorisatie voor gevraagd veld is toegevoegd
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) | Datum beëindiging tabelregel (35.99.99) |
      | 10120 81110 81210 81310         | N                        | 20201128                | 20221201                                |
      En de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81010 81110 81210 81310   | N                        | 20221201                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) |
      | 0599                              | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde          |
      | gemeentecode (92.10) | 0599            |
      | straatnaam (11.10)   | Borgesiusstraat |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response 1 persoon

    Scenario: Autorisatie heeft einddatum in de toekomst
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) | Datum beëindiging tabelregel (35.99.99) |
      | 10120 81010 81110 81210 81310   | N                        | 20221201                | 20300101                                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) |
      | 0599                              | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0599                 | Plein              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response 1 persoon

  Rule: Alleen een autorisatie tabelregel waarbij de Datum ingang (35.99.98) gelijk is aan vandaag of in het verleden ligt wordt gebruikt

    @fout-case
    Scenario: Autorisatie voor ad hoc gegevensverstrekking gaat morgen in
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 010210                   | N                        | morgen                  |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3 |
      | title    | U bent niet geautoriseerd voor het gebruik van deze API.    |
      | status   | 403                                                         |
      | detail   | Niet geautoriseerd voor ad hoc bevragingen.                 |
      | code     | unauthorized                                                |
      | instance | /haalcentraal/api/brp/personen                              |

    Scenario: Autorisatie voor ad hoc gegevensverstrekking is vandaag ingegaan
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 010210                   | N                        | vandaag                 |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response 1 persoon
