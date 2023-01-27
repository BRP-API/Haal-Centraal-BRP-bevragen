# language: nl

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
      | title    | U bent niet geautoriseerd voor deze operatie.               |
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
      | gemeenteCode | 0518   |
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


  Rule: Vragen met fields gevraagd om een veld waarvoor de gebruiker niet geautoriseerd is geeft een foutmelding
    Om een veld te mogen vragen moet de afnemer geautoriseerd zijn voor alle LO BRP rubrieken waar het veld mee gevuld of van afgeleid wordt

    @fout-case
    Scenario: Afnemer vraagt om een veld (geboorte.plaats) waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)     | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210 10220 10230 10240 10310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
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
      | leeftijd                                      | 10120 10310      | overlijdensdatum (60810)             |
      | leeftijd                                      | 10120 60810      | geboortedatum (10310)                |
      | immigratie.indicatieVestigingVanuitBuitenland | 10120 81410      | datum vestiging in nederland (81420) |

    @fout-case
    Scenario: Afnemer zonder autorisatie voor historische aangaanHuwelijkPartnerschap (550610) vraagt om partner aangaanHuwelijkPartnerschap van persoon met actuele partner
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 50240 50610               | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft een 'partner' met de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | soort verbintenis (15.10) |
      | Jan               | Groenen               | 19820526              | 20171103                                                           | 0513                                                                | 6030                                                              | H                         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                 |
      | type                | RaadpleegMetBurgerservicenummer                                        |
      | burgerservicenummer | 000000024                                                              |
      | fields              | partners.naam.geslachtsnaam,partners.aangaanHuwelijkPartnerschap.datum |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

    @fout-case
    Scenario: Afnemer zonder autorisatie bijzonder Nederlanderschap vraagt om een gegeven van nationaliteit van persoon met Nederlandse nationaliteit
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 40510                     | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
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

  Rule: Vragen met fields gevraagd wordt om ouders.ouderAanduiding, wanneer de afnemer niet geautoriseerd is voor ten minste één gegeven van ouder 1 én ten minste één gegeven van ouder 2, geeft een foutmelding

    @fout-case
    Abstract Scenario: Afnemer is <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>                     | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | voornamen (02.10)  |
      | Chantal            |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | voornamen (02.10)  |
      | Christiaan         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders.ouderAanduiding          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken              | missende autorisatie                  |
      | 10120 10210 10220 10230 10240 | niet geautoriseerd voor oudergegevens |
      | 10120 20210 20220 20230 20240 | niet geautoriseerd voor ouder 2       |
      | 10120 30210 30220 30230 30240 | niet geautoriseerd voor ouder 1       |

    Abstract Scenario: Afnemer is wel geautoriseerd voor <autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | voornamen (02.10) |
      | Chantal           |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | voornamen (02.10) |
      | Mark              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders.ouderAanduiding          |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam            | waarde  |
      | ouderAanduiding | 1       |
      En heeft de persoon een 'ouder' met de volgende gegevens
      | naam            | waarde |
      | ouderAanduiding | 2      |

      Voorbeelden:
      | ad hoc rubrieken              | autorisatie                                            |
      | 10120 20210 30210             | exact 1 gegeven van ouder 1 en 1 gegeven van ouder 2   |
      | 10120 20120 20240 30310 30320 | meerdere gegevens van ouder 1 en 1 gegeven van ouder 2 |
  
  
  Rule: Een gemeente als afnemer is geautoriseerd voor alle gegevens van eigen inwoners

    Scenario: Gemeente raadpleegt een eigen inwoner en fields vraagt om partners.geslacht (50410) dat niet in de autorisatie zit
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 50240 50610               | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0599   |
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
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners.geslacht               |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                          | waarde    |
      | geslacht.code                 | M         |
      | geslacht.omschrijving         | man       |

    Scenario: Gemeente vindt geen enkele persoon op de zoekvraag en fields vraagt om geslacht (10410) waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 010240 010310            | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0599   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
      | 19830526              | Maassen               | Pieter                         |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) |
      | 0599                 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | geslacht                            |
      Dan heeft de response 0 personen
      

    @fout-case
    Scenario: Gemeente raadpleegt een inwoner van een andere gemeente en fields vraagt om partners.geslacht (50410) dat niet in de autorisatie zit
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 050240 050610            | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
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
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners.geslacht               |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

    @fout-case
    Scenario: Gemeente vindt op een zoekvraag een eigen inwoner én een inwoner van een andere gemeente en fields vraagt om geslacht (10410) waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 010240 010310            | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0599   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
      | 19830526              | Maassen               | Pieter                         |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) |
      | 0599                 |
      En de persoon met burgerservicenummer '000000025' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
      | 19830526              | Maassen               | Jan Peter         | van                 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) |
      | 0518                 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | naam.geslachtsnaam,geslacht         |
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
      | 10120 80810 81110 81120 81130 81140 81150       | N                        | 20221201                |                                         |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
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
      | 10120 81110 81210 81310         | N                        | 20221201                |                                         |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) |
      | 0599                              | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | 0599            |
      | straatnaam (11.10)   | Borgesiusstraat |
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
      | 10120 81010 81110 81210 81310   | N                        | 20221201                |                                         |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
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
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                      | waarde          |
      | straat                    | Borgesiusstraat |
      | functieAdres.code         | W               |
      | functieAdres.omschrijving | woonadres       |

    Scenario: Autorisatie heeft einddatum in de toekomst
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) | Datum beëindiging tabelregel (35.99.99) |
      | 10120 81010 81110 81210 81310   | N                        | 20221201                | 20300101                                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) |
      | 0599                              | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde          |
      | gemeentecode (92.10) | 0599            |
      | straatnaam (11.10)   | Borgesiusstraat |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                      | waarde          |
      | straat                    | Borgesiusstraat |
      | functieAdres.code         | W               |
      | functieAdres.omschrijving | woonadres       |

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
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
