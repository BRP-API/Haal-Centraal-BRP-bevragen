#language: nl

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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam                            |
      Dan heeft de persoon met anummer '1219379318' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken |
      | 1219379318 | 010120                 |

  Rule: Zoekrubrieken worden oplopend gesorteerd op rubrieknummer en gescheiden door komma en spatie

    Scenario: Zoek persoon met alleen de verplichte parameters
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) | voornamen (02.10) |  geslachtsnaam (02.40) | geboortedatum (03.10) |
      | 3965962492      | Jan Peter         |  Maassen               | 19830526              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | voornamen     | Jan Peter                           |
      | fields        | burgerservicenummer                 |
      Dan heeft de persoon met anummer '3965962492' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken |
      | 3965962492 | 010210, 010240, 010310 |

  Rule: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met inclusiefOverledenPersonen
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | 6761521367      | Maassen               | 19830526              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Maassen                             |
      | geboortedatum              | 1983-05-26                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer,naam.voornamen  |
      Dan heeft de persoon met anummer '6761521367' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken |
      | 6761521367 | 010240, 010310         |

  Rule: Gevraagde velden in fields worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: Gevraagde veld <fields veld> wordt vastgelegd in 'request_gevraagde_rubrieken' als <rubrieknummer>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 1346071371 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met anummer '1346071371' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 1346071371 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                      | gevraagde rubrieken |
      | naam.voornamen              | 010210              |
      | geboorte.datum              | 010310              |
      | partners.naam.geslachtsnaam | 050140              |

  Rule: Gevraagde rubrieken worden oplopend gesorteerd en gescheiden door komma en spatie

    Scenario: Gevraagde veld <fields veld> wordt vastgelegd in 'request_gevraagde_rubrieken' als <rubrieknummer>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 4363741376 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                    |
      | type                | RaadpleegMetBurgerservicenummer                           |
      | burgerservicenummer | 000000024                                                 |
      | fields              | geboorte.datum,partners.naam.voornamen,naam.geslachtsnaam |
      Dan heeft de persoon met anummer '4363741376' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 4363741376 | 010240, 010310, 050210      |

  Rule: Wanneer met fields een hele groep wordt gevraagd, worden alle velden in die groep opgenomen in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: vragen om hele groep <groep>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5472698941 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <groep>                         |
      Dan heeft de persoon met anummer '5472698941' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 5472698941 | <gevraagde rubrieken>       |

      Voorbeelden:
      | groep             | gevraagde rubrieken                    |
      | naam              | 010210, 010220, 010230, 010240, 016110 |
      | geboorte          | 010310, 010320, 010330                 |
      | nationaliteiten   | 040510, 046310, 046510, 048510         |
      | overlijden        | 060810, 060820, 060830                 |
      | europeesKiesrecht | 133110, 133130                         |

    Scenario: vragen om hele relatie <relatie>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5472698941 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <relatie>                       |
      Dan heeft de persoon met anummer '5472698941' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 5472698941 | <gevraagde rubrieken>       |

      Voorbeelden:
      | relatie  | gevraagde rubrieken                                                                                           |
      | partners | 050120 050210, 050220, 050230, 050240, 050310, 050320, 050330, 050410, 050610, 050620, 050630, 050710, 051510 |
      | kinderen | 090120 090210, 090220, 090230, 090240, 090310, 090320, 090330                                                 |

  Rule: Wanneer met fields een veld van ouders wordt gevraagd, worden de bijbehorende rubrieknummers voor ouder 1 én ouder 2 opgenomen in het veld 'request_gevraagde_rubrieken'.

    Scenario: vragen om <fields>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5472698941 |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | 20190614                                           | Moeder                | V                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                 |
      Dan heeft de persoon met anummer '5472698941' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 5472698941 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                         | gevraagde rubrieken                                            |
      | ouders.burgerservicenummer                     | 020120, 030120                                                 |
      | ouders.naam                                    | 020210, 020220, 020230, 020240, 030210, 030220, 030230, 030240 |
      | ouders.datumIngangFamilierechtelijkeBetrekking | 0206210, 036210                                                |

  Rule: Voor ouders.ouderAanduiding wordt niks opgenomen in veld 'request_gevraagde_rubrieken'

    Scenario: vragen om ouders.ouderAanduiding
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 7531580186 |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | 20190614                                           | Moeder                | V                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | ouders.ouderAanduiding          |
      Dan heeft de persoon met anummer '7531580186' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 7531580186 |                             |

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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met anummer '1748250197' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 1748250197 | <gevraagde rubrieken>       |

      Voorbeelden:
      | omschrijving                               | fields                                         | gevraagde rubrieken            |
      | persoon heeft geen adellijkeTitelPredicaat | naam                                           | 010210, 010220, 010230, 010240 |
      | persoon heeft geen partner                 | partners.geboorte                              | 050310, 050320, 050330         |
      | persoon is niet overleden                  | overlijden.datum                               | 060810                         |
      | persoon heeft geen verblijfstitel          | verblijfstitel.aanduiding                      | 103910                         |
      | persoon heeft geen kind                    | kinderen.naam.voornamen                        | 090210                         |
      | persoon heeft alleen ouder 1               | ouders.datumIngangFamilierechtelijkeBetrekking | 026210, 036210                 |

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
      | Datum verificatie (71.10)            | 20211103      |
      | Omschrijving verificatie (71.20)     | eigen verzoek |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000024                              |
      | fields              | burgerservicenummer,naam.geslachtsnaam |
      Dan heeft de persoon met anummer '1748250197' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 1748250197 | 010120, 010240              |

  Rule: Wanneer een veld wordt gevraagd dat wordt bepaald uit een of meerdere andere velden, dan worden alle daarvoor nodige velden in 'request_gevraagde_rubrieken' opgenomen.

    Abstract Scenario: Vragen om <fields>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5264846450 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met anummer '5264846450' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 5264846450 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                               | gevraagde rubrieken                                                                    |
      | leeftijd                             | 010310                                                                                 |
      | naam.voorletters                     | 010210                                                                                 |
      | naam.volledigeNaam                   | 010210, 010220, 010230, 010240, 010410                                                 |
      | verblijfplaats.datumVan              | 081030, 081320                                                                         |
      | adressering.aanschrijfwijze          | 010210, 010220, 010230, 010240, 010410, 016110, 050220, 050230, 050240, 050610, 050710 |
      | adressering.adresregel1              | 081110, 081120, 081130, 081140, 081150, 081210, 081310, 081330                         |
      | adressering.adresregel2              | 080910, 081110, 081120, 081160, 081170, 081210, 081310, 081340                         |
      | partners.aangaanHuwelijkPartnerschap | 050610, 550610                                                                         |

  Rule: Wanneer een veld wordt gevraagd waarbij meerdere velden worden meegeleverd voor het bepalen van het polymorfe type, dan worden alle daarvoor nodige velden in 'request_gevraagde_rubrieken' opgenomen.

    Abstract Scenario: Vragen om <fields> protocolleert ook benodigde velden voor het type
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5264846450 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met anummer '5264846450' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 5264846450 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                        | gevraagde rubrieken            |
      | nationaliteiten.nationaliteit | 040510, 046510                 |
      | nationaliteiten.redenOpname   | 040510, 046310, 046510         |
      | verblijfplaats.functieAdres   | 081010, 081110, 081210, 081310 |
  
  Rule: Wanneer een gevraagde rubriek nodig is voor meerdere fields velden, wordt de rubriek één keer in 'request_gevraagde_rubrieken' opgenomen.

    Abstract Scenario: Vragen om <fields> protocolleert ook benodigde velden voor het type
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5264846450 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met anummer '5264846450' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 5264846450 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                                                   | gevraagde rubrieken                                                                    |
      | adressering.aanhef,adressering.aanschrijfwijze,naam                      | 010210, 010220, 010230, 010240, 010410, 016110, 050220, 050230, 050240, 050610, 050710 |
      | leeftijd,geboorte.datum                                                  | 010310                                                                                 |
      | verblijfplaats.functieAdres,verblijfplaats.verblijfadres.korteStraatnaam | 081010, 081110, 081210, 081310                                                         |

  Rule: Wanneer in het antwoord meerdere personen worden geleverd, dan wordt er per geleverde persoon een protocolleringsrecord opgenomen

    Scenario: Zoek persoon met alle mogelijke parameters
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      | 2937183560      | Jan Peter         | van                 | Maassen               | 19830526              | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      | 5069308085      | Caroline          | van                 | Maassen               | 19830526              | V                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                      |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum         |
      | geslachtsnaam           | Maassen                                     |
      | geboortedatum           | 1983-05-26                                  |
      | voorvoegsel             | van                                         |
      | gemeenteVanInschrijving | 0599                                        |
      | fields                  | burgerservicenummer,naam.voornamen,geslacht |
      Dan heeft de persoon met anummer '2937183560' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken                 | request_gevraagde_rubrieken |
      | 2937183560 | 010230, 010240, 010310, 010410, 080910 | 010120, 010210, 010410      |
      En heeft de persoon met anummer '5069308085' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken                 | request_gevraagde_rubrieken |
      | 5069308085 | 010230, 010240, 010310, 010410, 080910 | 010120, 010210, 010410      |
