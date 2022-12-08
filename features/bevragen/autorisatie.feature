# language: nl

Functionaliteit: autorisatie voor het gebruik van de API
  Autorisatie voor het gebruik van de API gebeurt op twee niveau's:
  1. autorisatie van de gebruiker door de afnemende organisatie
  2. autorisatie van de afnemer (organisatie) door RvIG

  Deze feature beschrijft alleen de autorisatie van de afnemer door RvIG.

  Autorisatie is gebaseerd op de Gaba autorisatie van een afnemer, die is vastgelegd in het autorisatiebesluit voor een afnemer. 
  In het autorisatiebesluit staat voor welke gegevens de afnemer geautoriseerd is. 
  De autorisatie voor gegevens is vastgelegd in Rubrieknummer ad hoc (35.95.60). 
  Deze bevat een lijst met rubrieknummers (spatie gescheiden) van gegevens die geleverd mogen worden. 
  Een rubrieknummer is het nummer voor een gegeven zoals gedefinieerd in het Logisch Ontwerp BRP (LO BRP) zonder voorloopnullen voor categorienummer (dus 5 of 6 cijfers).
  Voor het toepassen van de autorisatie moet het rubrieknummer worden vertaald naar het corresponderende veld in de BRP API resource (of andersom). Deze vertaling staat beschreven in /docs/BRP-LO GBA mapping.md.

  Autorisatie wordt verkregen met behulp van een Oauth 2 token. 
  In het verkregen token is de afnemerindicatie opgenomen die de afnemer uniek identificeert. Op basis van de afnemerindicatie kan de autorisatie worden opgezocht.
  Wanneer de afnemer een gemeente is, is er ook een gemeentecode opgenomen in de Oauth token.

  # Autorisaties worden opgeslagen in de tabel lo3_autorisatie. Deze bevat minimaal:
  #  - autorisatie_id: technische identificatie (primary key) = max(autorisatie_id)+1
  #  - afnemer_code: vullen met 'Afnemersindicatie (35.95.10)' in Gegeven, wordt ook opgenomen in Oauth token gestuurd bij Als stap
  #  - tabel_regel_start_datum: vullen met 'Datum ingang (35.99.98)' in Gegeven stap
  #  - tabel_regel_eind_datum: vullen met 'Datum beëindiging tabelregel (35.99.99)' in Gegeven stap
  #  - ad_hoc_medium: vullen met 'Medium ad hoc (35.95.67)' in Gegeven stap, vaste waarde 'N' (betekent dat de autorisatie er wel is)
  #  - ad_hoc_rubrieken: vullen met waarde voor 'Rubrieknummer ad hoc (35.95.60)' in Gegeven stap

  Voor één afnemer kunnen er meerdere rijen zijn in de autorisatietabel, maar daarvan kan er maar één actueel zijn. Alleen de actuele mag worden gebruikt.
  Een autorisatie is actueel wanneer de Datum ingang (35.99.98) in het verleden ligt en Datum beëindiging tabelregel (35.99.99) leeg is of in de toekomst ligt.


  # To Do (t.z.t.): alleen regel gebruiken met datum ingang <= vandaag

  # To Do (t.z.t.): regels voor leveren persoonsgegevens met geheimhouding aan derde (35.95.12)

  # To Do (t.z.t.): regels voor voorwaarderegel ad hoc (35.95.61)


  Rule: Wanneer een parameter wordt gebruikt van een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    Om een parameter te mogen gebruiken moet de afnemer geautoriseerd zijn voor de LO BRP rubriek waar met de parameter op gefilterd wordt

    @fout-case
    Scenario: Gebruik van een zoektype met verplichte parameter waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)           | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80810 81110 81120 81130 81140 81150 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0518   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
       En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | identificatiecode nummeraanduiding (11.90) |
      | 0599          | 0599200000219679                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200000219679                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                                  |
      | type     | https://learn.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?view=net-7.0#system-net-httpstatuscode-forbidden |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                                               |
      | status   | 403                                                                                                                     |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): nummeraanduidingIdentificatie.                             |
      | code     | unauthorizedParameter                                                                                                   |
      | instance | /haalcentraal/api/brp/personen                                                                                          |

    @fout-case
    Scenario: Gebruik van een optionele parameter waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)     | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210 10220 10230 10240 10310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode |        |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | geslacht      | M                                   |
      | fields        | burgerservicenummer                 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                                  |
      | type     | https://learn.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?view=net-7.0#system-net-httpstatuscode-forbidden |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                                               |
      | status   | 403                                                                                                                     |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): geslacht.                                                  |
      | code     | unauthorizedParameter                                                                                                   |
      | instance | /haalcentraal/api/brp/personen                                                                                          |


  Rule: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    Om een veld te mogen vragen moet de afnemer geautoriseerd zijn voor alle LO BRP rubrieken waar het veld mee gevuld of van afgeleid wordt

    @fout-case
    Scenario: Afnemer vraagt om een veld waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)     | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10210 10220 10230 10240 10310 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode |        |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                            |
      | type                | RaadpleegMetBurgerservicenummer                                   |
      | burgerservicenummer | 000000024                                                         |
      | fields              | burgerservicenummer,geboorte.datum.geboorte.plaats,naam.voornamen |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve parameter(s) zijn: fields[2].                               |
      | code     | autorisation                                                            |
      | instance | /haalcentraal/api/brp/personen                                          |

    @fout-case
    Abstract Scenario: Afnemer vraagt om gegevensgroep <fields> en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode |        |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) | aanduiding naamgebruik (61.10) |
      | 19830526              | Maassen               | Pieter            | M                           | E                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve parameter(s) zijn: fields[0].                               |
      | code     | autorisation                                                            |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields          | ad hoc rubrieken              | missende autorisatie                         |
      | naam            | 10120 10210 10220 10230 10240 | aanduidingNaamgebruik (16110)                |
      | geboorte        | 10120 10310                   | geboorteplaats (10320), geboorteland (10330) |
      | nationaliteiten | 10120 40510 46310 46410 46510 | datumIngangGeldigheid (48510)                |


  Rule: Wanneer met fields gevraagd wordt om een veld dat is afgeleid van één of meerdere andere velden, en de gebruiker is niet geautoriseerd al die velden, wordt een foutmelding gegeven

    @fout-case
    Scenario: Afnemer vraagt om afgeleid gegeven <fields> en is niet geautoriseerd <missende autorisatie>
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode |        |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve parameter(s) zijn: fields[0].                               |
      | code     | autorisation                                                            |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                                        | ad hoc rubrieken | missende autorisatie                 |
      | leeftijd                                      | 10120 10310      | overlijdensdatum (60810)             |
      | leeftijd                                      | 10120 60810      | geboortedatum (10310)                |
      | immigratie.indicatieVestigingVanuitBuitenland | 10120 81410      | datum vestiging in nederland (81420) |

    @fout-case
    Scenario: Afnemer zonder autorisatie voor historischeaangaanHuwelijkPartnerschap vraagt om partner aangaanHuwelijkPartnerschap van persoon met actuele partner
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 050240 050610            | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode |        |
      En de persoon met burgerservicenummer '000000024' heeft een 'partner' met de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30) | soort verbintenis (15.10) |
      | Jan               | Groenen               | 19820526              | 20171103                                                           | 0513                                                                | 6030                                                              | H                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                 |
      | type                | RaadpleegMetBurgerservicenummer                                        |
      | burgerservicenummer | 000000024                                                              |
      | fields              | partners.naam.geslachtsnaam,partners.aangaanHuwelijkPartnerschap.datum |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve parameter(s) zijn: fields[1].                               |
      | code     | autorisation                                                            |
      | instance | /haalcentraal/api/brp/personen                                          |
      # Hier is de missende autorisatie een historische aangaanHuwelijkPartnerschap (550610)

    @fout-case
    Scenario: Afnemer zonder autorisatie bijzonder Nederlanderschap vraagt om een gegeven van nationaliteit van persoon met Nederlandse nationaliteit
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 40510                     | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode |        |
      En de persoon met burgerservicenummer '000000024' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | nationaliteiten.nationaliteit   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve parameter(s) zijn: fields[0].                               |
      | code     | autorisation                                                            |
      | instance | /haalcentraal/api/brp/personen                                          |

  Rule: Wanneer met fields gevraagd wordt om ouders.ouderAanduiding, en de afnemer is niet geautoriseerd voor ten minste één gegeven van ouder 1 én ten minste één gegeven van ouder 2, wordt een foutmelding gegeven

    @fout-case
    Abstract Scenario: Afnemer is <missende autorisatie>
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>                     | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode |        |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | voornamen (02.10)  |
      | Chantal            |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | voornamen (02.10)  |
      | Christiaan         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders.ouderAanduiding          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve parameter(s) zijn: fields[0].                               |
      | code     | autorisation                                                            |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                   | missende autorisatie                  |
      | 010120 010210 010220 010230 010240 | niet geautoriseerd voor oudergegevens |
      | 010120 020210 020220 020230 020240 | niet geautoriseerd voor ouder 2       |
      | 010120 030210 030220 030230 030240 | niet geautoriseerd voor ouder 1       |

    Abstract Scenario: Afnemer is wel geautoriseerd voor ten minste één gegeven van ouder 1 en van ouder 2
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode |        |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | voornamen (02.10) |
      | Chantal           |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | voornamen (02.10) |
      | Mark              |
      Als personen wordt gezocht met de volgende parameters
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
      | ad hoc rubrieken                   | autorisatie                                            |
      | 010120 020210 030210               | exact 1 gegeven van ouder 1 en 1 gegeven van ouder 2   |
      | 010120 020120 020210 030120 030210 | meerdere gegevens van ouder 1 en 1 gegeven van ouder 2 |
  
  
  Rule: Een gemeente als afnemer is geautoriseerd voor alle gegevens van eigen inwoners

    Scenario: Gemeente raadpleegt een eigen inwoner en fields vraagt om partners.geslacht (50410) dat niet in de autorisatie zit
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 050240 050610            | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0599   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | 0599 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | Groenen               | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners.geslacht               |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                          | waarde    |
      | geslacht.code                 | M         |
      | geslacht.omschrijving         | man       |

    @fout-case
    Scenario: Gemeente raadpleegt een inwoner van een andere gemeente en fields vraagt om partners.geslacht (50410) dat niet in de autorisatie zit
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 050240 050610            | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0518   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | 0599 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | Groenen               | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners.geslacht               |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve parameter(s) zijn: fields[0].                               |
      | code     | autorisation                                                            |
      | instance | /haalcentraal/api/brp/personen                                          |

      | fields            | ad hoc rubrieken                     | fields                                     | missende autorisatie |
      | partners.geslacht | 010120 50210 50220 50230 50240 50610 | partners.aangaanHuwelijkPartnerschap.datum | geslacht (50410)     |

    @fout-case
    Scenario: Gemeente vindt op een zoekvraag een eigen inwoner én een inwoner van een andere gemeente en fields vraagt om een veld waarvoor de afnemer niet geautoriseerd is
      # voeg parameter gemeenteVanInschrijving toe om te zorgen dat je alleen eigen inwoners vindt en deze fout niet krijgt
      Gegeven de afnemer met indicatie '12345' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 010120 010240 010310            | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 12345  |
      | gemeenteCode | 0599   |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
      | 19830526              | Maassen               | Pieter            |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | 0599 |
      En de persoon met burgerservicenummer '000000025' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
      | 19830526              | Maassen               | Jan Peter         | van                 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | 0518 |
      Als personen wordt gezocht met de volgende parameters
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
      | detail   | De foutieve parameter(s) zijn: fields[1].                               |
      | code     | autorisation                                                            |
      | instance | /haalcentraal/api/brp/personen                                          |


  Rule: Een afnemer die alleen geautoriseerd is voor binnenlandse adressen of locaties kan adressering vragen met adresseringBinnenland

    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt adressering adresregel van persoon met Nederlands adres

      Voorbeelden:
      | ad hoc rubrieken                                                                          | fields                            |
      | 10120 80910 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | adresseringBinnenland.adresregel1 |

    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt adressering adresregel van persoon met locatiebeschrijving

      Voorbeelden:
      | ad hoc rubrieken                                                                          | fields                            |
      | 10120 80910 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | adresseringBinnenland.adresregel1 |

    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt adressering adresregel van persoon met buitenlands adres

      Voorbeelden:
      | ad hoc rubrieken                                                                          | fields                            |
      | 10120 80910 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | adresseringBinnenland.adresregel1 |

    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt adressering adresregel van persoon met onbekende verblijfplaats

      Voorbeelden:
      | ad hoc rubrieken                                                                          | fields                            |
      | 10120 80910 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | adresseringBinnenland.adresregel1 |


  Rule: Alleen een autorisatie tabelregel waarbij de Datum beëindiging tabelregel (35.99.99) leeg is of in de toekomst ligt wordt gebruikt

    Scenario: Afnemer met beëindigde tabelregel en actuele tabelregel zonder einddatum

    Scenario: Afnemer met beëindigde tabelregel en actuele tabelregel met einddatum in de toekomst

    Scenario: Afnemer met alleen een beëindigde tabelregel (einddatum in het verleden)

