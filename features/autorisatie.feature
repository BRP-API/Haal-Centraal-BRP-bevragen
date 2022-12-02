# language: nl

Functionaliteit: autorisatie voor het gebruik van de API
  Autorisatie voor het gebruik van de API gebeurt op twee niveau's:
  1. autorisatie van de gebruiker door de afnemende organisatie
  2. autorisatie van de afnemer (organisatie) door RvIG

  Deze feature beschrijft alleen de autorisatie van de afnemer door RvIG.

  Autorisatie is gebaseerd op de Gaba autorisatie van een afnemer, die isvastgelegd in het autorisatiebesluit voor een afnemer. 
  In het autorisatiebesluit staat voor welke gegevens de afnemer geautoriseerd is. 
  De autorisatie voor gegevens is vastgelegd in Rubrieknummer ad hoc (35.95.60). 
  Deze bevat een lijst met rubrieknummers (spatie gescheiden) van gegevens die geleverd mogen worden. 
  Een rubrieknummer is het nummer voor een gegeven zoals gedefinieerd in het Logisch Ontwerp BRP (LO BRP) zonder voorloopnullen voor categorienummer (dus 5 of 6 cijfers).

  Autorisatie wordt verkregen met behulp van een Oauth 2 token. 
  In het verkregen token is de afnemerindicatie opgenomen die de afnemer uniek identificeert. 
  Wanneer de afnemer een gemeentecode is, is er ook een gemeentecode opgenomen in de Oauth token.

  # To Do: regels voor leveren persoonsgegevens met geheimhouding aan derde (35.95.12)

  # To Do: regels voor voorwaarderegel ad hoc (35.95.61)


  Rule: Wanneer een parameter wordt gebruikt van een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    Om een parameter te mogen gebruiken moet de afnemer geautoriseerd zijn voor de LO BRP rubriek waar met de parameter op gefilterd wordt

    @fout-case
    Scenario: Gebruik van een zoektype met verplichte parameter waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met afnemerindicatie '12345' heeft de volgende gegevens
      | Rubrieknummer ad hoc (35.95.60)           |
      | 10120 80810 81110 81120 81130 81140 81150 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
       En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeente_code | identificatiecode nummeraanduiding (11.90) |
      | 0599          | 0599200000219679                           |
      Als de afnemer met afnemerindicatie '12345' en gemeentecode '0518' personen zoekt met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200000219679                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                                  |
      | type     | https://learn.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?view=net-7.0#system-net-httpstatuscode-forbidden |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                                               |
      | status   | 403                                                                                                                     |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): geboorteplaats.                                            |
      | code     | unauthorizedParameter                                                                                                   |
      | instance | /haalcentraal/api/brp/personen                                                                                          |
      En heeft het object de volgende 'invalidParams' gegevens
      | code         | name           | reason                                                  |
      | unauthorized | geboorteplaats | Niet geautoriseerd voor het gebruik van deze parameter. |


      | ad hoc rubrieken                          | type                                 | parameter niet toegestaan             |
      | 10120 80810 81110 81120 81130 81140 81150 | ZoekMetNummeraanduidingIdentificatie | nummeraanduidingIdentificatie (81190) |

    @fout-case
    Scenario: Gebruik van een optionele parameter waarvoor de afnemer niet geautoriseerd is
      # in dit geval is de afnemer wel geautoriseerd voor alle verplichte parameters

      | ad hoc rubrieken                          | type                                 | parameter niet toegestaan             |
      | 10120 010210 010230 010240 010310         | ZoekMetGeslachtsnaamEnGeboortedatum  | geslacht (10410)                      |
      

    @fout-case
    Scenario: Gebruik van meerdere parameters waarvoor de afnemer niet geautoriseerd is

      | ad hoc rubrieken                  | type                                | parameter niet toegestaan                           |
      | 10120 010210 010230 010240 010310 | ZoekMetGeslachtsnaamEnGeboortedatum | geslacht (10410) en gemeenteVanInschrijving (80910) |


  Rule: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    Om een veld te mogen vragen moet de afnemer geautoriseerd zijn voor alle LO BRP rubrieken waar het veld mee gevuld of van afgeleid wordt

    @fout-case
    Scenario: Afnemer vraagt om een veld waarvoor deze niet geautoriseerd is

      | fields          | ad hoc rubrieken | missende autorisatie   |
      | geboorte.plaats | 10120 10310      | geboorteplaats (10320) |


    @fout-case
    Scenario: Afnemer vraagt om een gegevensgroep en is niet geautoriseerd voor alle velden in deze gegevensgroep

      | fields          | ad hoc rubrieken              | missende autorisatie                         |
      | geboorte        | 10120 10310                   | geboorteplaats (10320), geboorteland (10330) |
      | nationaliteiten | 10120 40510 46310 46410 46510 | datumIngangGeldigheid (48510)                |

    @fout-case
    Scenario: Afnemer vraagt om een afgeleid gegeven en is niet geautoriseerd voor alle velden waaruit het gegeven wordt afgeleid

      Voorbeelden:
      | fields                                        | ad hoc rubrieken | missende autorisatie              |
      | leeftijd                                      | 10120 10310      | overlijdensdatum (6810)           |
      | immigratie.indicatieVestigingVanuitBuitenland | 10120 81410      | land vanwaar ingeschreven (81420) |

    @fout-case
    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt adressering adresregel van persoon met Nederlands adres
      # gebruik hiervoor verblijfplaatsBinnenland, zie later in deze feature

      Voorbeelden:
      | fields                  | ad hoc rubrieken                                                                          |
      | adressering.adresregel1 | 10120 80910 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 |

    @fout-case
    Scenario: Afnemer zonder autorisatie voor datum aanvang verblijf buitenland vraagt om verblijfplaats datumVan van persoon met Nederlands adres
      # gebruik hiervoor verblijfplaatsBinnenland, zie later in deze feature

      # geraadpleegde persoon heeft datum aanvang adreshouding (81030), niet datum aanvang verblijf buitenland (81320)

      | fields                  | ad hoc rubrieken                                                                                      | missende autorisatie                      |
      | verblijfplaats.datumVan | 10120 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81330 81340 81350 | datum aanvang verblijf buitenland (81320) |

    @fout-case
    Scenario: Afnemer zonder autorisatie voor historischeaangaanHuwelijkPartnerschap vraagt om partner aangaanHuwelijkPartnerschap van persoon met actuele partner
      # geeft dit ook een fout wanneer de partner actueel is en deze dus uit bestaande autorisatie kan worden gehaald? 

      | fields                                     | ad hoc rubrieken                   | missende autorisatie                             |
      | partners.aangaanHuwelijkPartnerschap.datum | 010120 050210 050230 050240 050610 | historische aangaanHuwelijkPartnerschap (550610) |

    @fout-case
    Scenario: Afnemer zonder autorisatie bijzonder Nederlanderschap vraagt om een gegeven van nationaliteit van persoon met Nederlandse nationaliteit
      # afnemer is niet geautoriseerd voor alle velden waaruit het type nationaliteit wordt afgeleid

      | fields                        | ad hoc rubrieken | missende autorisatie                          |
      | nationaliteiten.nationaliteit | 10120 40510      | land (81310) |

    @fout-case
    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt gegeven van verblijfplaats van persoon met Nederlands adres
      # afnemer is niet geautoriseerd voor alle velden waaruit het type verblijfplaats wordt afgeleid
      # gebruik hiervoor verblijfplaatsBinnenland, zie later in deze feature

      | fields                      | ad hoc rubrieken                                                              | missende autorisatie |
      | verblijfplaats.functieAdres | 10120 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | land (81310)         |


  Rule: Een gemeente als afnemer is geautoriseerd voor alle gegevens van eigen inwoners

    Scenario: Gemeente raadpleegt een eigen inwoner en fields vraagt om een veld waarvoor de afnemer niet geautoriseerd is

      | fields            | ad hoc rubrieken                     | fields                                     | missende autorisatie |
      | partners.geslacht | 010120 50210 50220 50230 50240 50610 | partners.aangaanHuwelijkPartnerschap.datum | geslacht (50410)     |

    @fout-case
    Scenario: Gemeente raadpleegt een inwoner van een andere gemeente en fields vraagt om een veld waarvoor de afnemer niet geautoriseerd is

      | fields            | ad hoc rubrieken                     | fields                                     | missende autorisatie |
      | partners.geslacht | 010120 50210 50220 50230 50240 50610 | partners.aangaanHuwelijkPartnerschap.datum | geslacht (50410)     |


  Rule: Een afnemer die alleen geautoriseerd is voor binnenlandse adressen of locaties kan verblijfplaatsgegevens vragen met verblijfplaatsBinnenland

    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt gegeven van binnenlands adres van persoon met Nederlands adres

      Voorbeelden:
      | ad hoc rubrieken                                                                    | fields                                         |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.functieAdres          |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.verblijfsadres        |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.datumIngangGeldigheid |

    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt gegeven van binnenlands adres van persoon met locatiebeschrijving

      Voorbeelden:
      | ad hoc rubrieken                                                                    | fields                                         |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.functieAdres          |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.verblijfsadres        |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.datumIngangGeldigheid |

    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt gegeven van binnenlands adres van persoon met buitenlands adres

      Voorbeelden:
      | ad hoc rubrieken                                                                    | fields                                         |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.verblijfsadres        |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.datumIngangGeldigheid |

    Scenario: Afnemer zonder autorisatie buitenlandse verblijfplaats vraagt gegeven van binnenlands adres van persoon met onbekende verblijfplaats

      Voorbeelden:
      | ad hoc rubrieken                                                                    | fields                                         |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.verblijfsadres        |
      | 10120 81030 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 | verblijfplaatsBinnenland.datumIngangGeldigheid |


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
