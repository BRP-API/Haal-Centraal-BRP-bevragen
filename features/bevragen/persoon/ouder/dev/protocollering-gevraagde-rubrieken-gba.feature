#language: nl

@gba @protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor ouders 

  Rule: Wanneer met fields een veld van ouders wordt gevraagd, worden de bijbehorende rubrieknummers voor ouder 1 én ouder 2 opgenomen in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 8016043787 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met anummer '8016043787' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 8016043787 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                                     | gevraagde rubrieken                                                                                                                                            |
      | ouders                                                     | 020120, 020210, 020220, 020230, 020240, 020310, 020320, 020330, 020410, 026210, 030120, 030210, 030220, 030230, 030240, 030310, 030320, 030330, 030410, 036210 |
      | ouders.burgerservicenummer                                 | 020120, 030120                                                                                                                                                 |
      | ouders.datumIngangFamilierechtelijkeBetrekking             | 026210, 036210                                                                                                                                                 |
      | ouders.datumIngangFamilierechtelijkeBetrekking.langFormaat | 026210, 036210                                                                                                                                                 |
      | ouders.datumIngangFamilierechtelijkeBetrekking.type        | 026210, 036210                                                                                                                                                 |
      | ouders.datumIngangFamilierechtelijkeBetrekking.datum       | 026210, 036210                                                                                                                                                 |
      | ouders.datumIngangFamilierechtelijkeBetrekking.onbekend    | 026210, 036210                                                                                                                                                 |
      | ouders.datumIngangFamilierechtelijkeBetrekking.jaar        | 026210, 036210                                                                                                                                                 |
      | ouders.datumIngangFamilierechtelijkeBetrekking.maand       | 026210, 036210                                                                                                                                                 |
      | ouders.geboorte                                            | 020310, 020320, 020330, 030310, 030320, 030330                                                                                                                 |
      | ouders.geboorte.datum                                      | 020310, 030310                                                                                                                                                 |
      | ouders.geboorte.datum.langFormaat                          | 020310, 030310                                                                                                                                                 |
      | ouders.geboorte.datum.type                                 | 020310, 030310                                                                                                                                                 |
      | ouders.geboorte.datum.datum                                | 020310, 030310                                                                                                                                                 |
      | ouders.geboorte.datum.onbekend                             | 020310, 030310                                                                                                                                                 |
      | ouders.geboorte.datum.jaar                                 | 020310, 030310                                                                                                                                                 |
      | ouders.geboorte.datum.maand                                | 020310, 030310                                                                                                                                                 |
      | ouders.geboorte.land                                       | 020330, 030330                                                                                                                                                 |
      | ouders.geboorte.land.code                                  | 020330, 030330                                                                                                                                                 |
      | ouders.geboorte.land.omschrijving                          | 020330, 030330                                                                                                                                                 |
      | ouders.geboorte.plaats                                     | 020320, 030320                                                                                                                                                 |
      | ouders.geboorte.plaats.code                                | 020320, 030320                                                                                                                                                 |
      | ouders.geboorte.plaats.omschrijving                        | 020320, 030320                                                                                                                                                 |
      | ouders.geslacht                                            | 020410, 030410                                                                                                                                                 |
      | ouders.geslacht.code                                       | 020410, 030410                                                                                                                                                 |
      | ouders.geslacht.omschrijving                               | 020410, 030410                                                                                                                                                 |
      | ouders.naam                                                | 020210, 020220, 020230, 020240, 030210, 030220, 030230, 030240                                                                                                 |
      | ouders.naam.adellijkeTitelPredicaat                        | 020220, 030220                                                                                                                                                 |
      | ouders.naam.adellijkeTitelPredicaat.code                   | 020220, 030220                                                                                                                                                 |
      | ouders.naam.adellijkeTitelPredicaat.omschrijving           | 020220, 030220                                                                                                                                                 |
      | ouders.naam.adellijkeTitelPredicaat.soort                  | 020220, 030220                                                                                                                                                 |
      | ouders.naam.geslachtsnaam                                  | 020240, 030240                                                                                                                                                 |
      | ouders.naam.voorletters                                    | 020210, 030210                                                                                                                                                 |
      | ouders.naam.voornamen                                      | 020210, 030210                                                                                                                                                 |
      | ouders.naam.voorvoegsel                                    | 020230, 030230                                                                                                                                                 |

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