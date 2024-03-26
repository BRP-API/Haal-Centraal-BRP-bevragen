#language: nl

@protocollering
Functionaliteit: Als burger wil ik zien wie welke gegegevens van mij heeft gezien of gebruikt
  Zoeken en raadplegen van gegevens van burgers worden "geprotocolleerd" (formeel gelogd).

  Protocollering moet gebeuren op twee niveau's:
  - bij de RvIG op het niveau van afnemende organisaties
  - bij de afnemende organisatie op het niveau van gebruikers

  Deze feature beschrijft alleen de werking van protocollering op het niveau van afnemende organisaties bij de bron (RvIG)

  Daarin worden de volgende gegevens vastgelegd:
  - request_id: unieke identificatie van de berichtuitwisseling
  - request_datum: tijdstip waarop de protocollering is vastgelegd
  - afnemer_code: identificatiecode van de afnemende organisatie, zoals die is opgenomen in de gestuurde Oauth 2 token
  - anummer: het A-nummer van de persoon waarvan gegevens zijn gevraagd of geleverd
  - request_zoek_rubrieken: lijst van alle parameters die in het request gebruikt zijn, vertaald naar LO-BRP elementnummers
  - request_gevraagde_rubrieken: lijst van alle gegevens die met fields gevraagd zijn, vertaald naar LO-BRP elementnummers
  - verwerkt: vaste waarde false (boolean)

  Zowel request_zoek_rubrieken als request_gevraagde_rubrieken bevatten de LO-BRP elementnummers als 6 cijferig rubrieknummer (incl. voorloopnul), gescheiden door komma spatie, en oplopend gesorteerd.

  Rule: Gebruikte parameters worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Raadpleeg een persoon op burgerservicenummer
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) |
      | 1219379318      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam                            |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010120                 |

  Rule: Zoekrubrieken worden oplopend gesorteerd op rubrieknummer en gescheiden door komma en spatie

    Scenario: Zoek persoon met alleen de verplichte parameters
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jan Peter         | Maassen               | 19830526              |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | voornamen     | Jan Peter                           |
      | fields        | burgerservicenummer                 |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010210, 010240, 010310 |

  Rule: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met inclusiefOverledenPersonen
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Maassen               | 19830526              |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Maassen                             |
      | geboortedatum              | 1983-05-26                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer,naam.voornamen  |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010240, 010310         |

  Rule: Gevraagde velden in fields worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: Gevraagde veld <fields veld> wordt vastgelegd in 'request_gevraagde_rubrieken' als <rubrieknummer>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 1346071371 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                      | gevraagde rubrieken |
      | naam.voornamen              | 010210              |
      | geboorte.datum              | 010310              |
      | geboorte.datum.type         | 010310              |
      | geboorte.datum.datum        | 010310              |
      | geboorte.datum.langFormaat  | 010310              |
      | geboorte.datum.jaar         | 010310              |
      | geboorte.datum.maand        | 010310              |
      | geboorte.datum.onbekend     | 010310              |
      | geslacht                    | 010410              |
      | geslacht.code               | 010410              |
      | geslacht.omschrijving       | 010410              |
      | partners.naam.geslachtsnaam | 050240              |

  Rule: Gevraagde rubrieken worden oplopend gesorteerd en gescheiden door komma en spatie

    Scenario: Gevraagde veld <fields veld> wordt vastgelegd in 'request_gevraagde_rubrieken' als <rubrieknummer>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 4363741376 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                                                                 |
      | type                | RaadpleegMetBurgerservicenummer                                                                                                        |
      | burgerservicenummer | 000000024                                                                                                                              |
      | fields              | geboorte.datum,adressering.adresregel2,partners.naam.voornamen,adressering.gebruikInLopendeTekst,naam.geslachtsnaam,adressering.aanhef |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken                    |
      | 010240, 010310, 050210, PANM03, PANM06, PAVP04 |

  Rule: Wanneer met fields een hele groep wordt gevraagd, worden alle velden in die groep opgenomen in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: vragen om hele groep <groep>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5472698941 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <groep>                         |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | groep                                | gevraagde rubrieken    |
      | geboorte                             | 010310, 010320, 010330 |
      | overlijden                           | 060810, 060820, 060830 |
      | europeesKiesrecht                    | 133110, 133130         |
      | partners.aangaanHuwelijkPartnerschap | 050610, 050620, 050630 |

    Scenario: vragen om hele relatie <relatie>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5472698941 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <relatie>                       |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | relatie  | gevraagde rubrieken                                                                                                    |
      | partners | 050120, 050210, 050220, 050230, 050240, 050310, 050320, 050330, 050410, 050610, 050620, 050630, 050710, 051510, PAHP01 |
      | kinderen | 090120, 090210, 090220, 090230, 090240, 090310, 090320, 090330, PAKD01                                                 |


  Rule: Wanneer een gevraagd veld niet geleverd wordt (bijv. omdat het geen waarde heeft), wordt het wel in het veld 'request_gevraagde_rubrieken' opgenomen.
    
    Abstract Scenario: Vragen om <fields> en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                  | waarde     |
      | anummer (01.10)       | 1748250197 |
      | voornamen (02.10)     | Jan Pieter |
      | voorvoegsel (02.30)   | van        |
      | geslachtsnaam (02.40) | Maassen    |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | 20190614                                           | Moeder                | V                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | omschrijving                               | fields                                         | gevraagde rubrieken                                    |
      | persoon heeft geen adellijkeTitelPredicaat | naam                                           | 010210, 010220, 010230, 010240, 016110, PANM01, PANM02 |
      | persoon heeft geen partner                 | partners.geboorte                              | 050310, 050320, 050330                                 |
      | persoon is niet overleden                  | overlijden.datum                               | 060810                                                 |
      | persoon heeft geen verblijfstitel          | verblijfstitel.aanduiding                      | 103910                                                 |
      | persoon heeft geen kind                    | kinderen.naam.voornamen                        | 090210                                                 |
      | persoon heeft alleen ouder 1               | ouders.datumIngangFamilierechtelijkeBetrekking | 026210, 036210                                         |

  Rule: Wanneer een veld ongevraagd geleverd wordt, wordt het niet in 'request_gevraagde_rubrieken' opgenomen.
    Dit betreft geheimhouding, opschorting, in onderzoek, RNI en verificatie

    Scenario: Persoon heeft geheimhouding, opschorting, in onderzoek, RNI en verificatie
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                            | waarde                                      |
      | anummer (01.10)                 | 1748250197                                  |
      | aanduiding in onderzoek (83.10) | 010000                                      |
      | datum ingang onderzoek (83.20)  | 20020701                                    |
      | rni-deelnemer (88.10)           | 0101                                        |
      | omschrijving verdrag (88.20)    | Belastingverdrag tussen België en Nederland |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde        |
      | datum opschorting bijhouding (67.10) | 20180421      |
      | reden opschorting bijhouding (67.20) | R             |
      | indicatie geheim (70.10)             | 7             |
      | datum verificatie (71.10)            | 20211103      |
      | omschrijving verificatie (71.20)     | eigen verzoek |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000024                              |
      | fields              | burgerservicenummer,naam.geslachtsnaam |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | 010120, 010240              |

  Rule: Wanneer een veld wordt gevraagd dat wordt bepaald uit een of meerdere andere velden, dan worden alle daarvoor nodige velden in 'request_gevraagde_rubrieken' opgenomen.

    Abstract Scenario: Vragen om <fields>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5264846450 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields             | gevraagde rubrieken |
      | leeftijd           | PAGL01              |
      | naam.voorletters   | PANM01              |
      | naam.volledigeNaam | PANM02              |

  Rule: Wanneer in het antwoord meerdere personen worden geleverd, dan wordt er per geleverde persoon een protocolleringsrecord opgenomen

    Scenario: Zoek persoon met alle mogelijke parameters
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      | Jan Peter         | van                 | Maassen               | 19830526              | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      | Caroline          | van                 | Maassen               | 19830526              | V                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                      |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum         |
      | geslachtsnaam           | Maassen                                     |
      | geboortedatum           | 1983-05-26                                  |
      | voorvoegsel             | van                                         |
      | gemeenteVanInschrijving | 0599                                        |
      | fields                  | burgerservicenummer,naam.voornamen,geslacht |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken         | request_gevraagde_rubrieken |
      | 010230, 010240, 010310, 080910 | 010120, 010210, 010410      |
      En heeft de persoon met burgerservicenummer '000000048' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken         | request_gevraagde_rubrieken |
      | 010230, 010240, 010310, 080910 | 010120, 010210, 010410      |
