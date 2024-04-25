#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor partner 

  Regel: Gebruikte parameters worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 8016043787 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                                    | gevraagde rubrieken                                                                                                    |
      | partners.burgerservicenummer                              | 050120                                                                                                                 |
      | partners.naam.voornamen                                   | 050210                                                                                                                 |
      | partners.naam.adellijkeTitelPredicaat                     | 050220                                                                                                                 |
      | partners.naam.adellijkeTitelPredicaat.code                | 050220                                                                                                                 |
      | partners.naam.adellijkeTitelPredicaat.omschrijving        | 050220                                                                                                                 |
      | partners.naam.adellijkeTitelPredicaat.soort               | 050220                                                                                                                 |
      | partners.naam.voorvoegsel                                 | 050230                                                                                                                 |
      | partners.naam.geslachtsnaam                               | 050240                                                                                                                 |
      | partners.naam.voorletters                                 | PAHP01                                                                                                                 |
      | partners.naam                                             | 050210, 050220, 050230, 050240, PAHP01                                                                                 |
      | partners.geboorte.datum                                   | 050310                                                                                                                 |
      | partners.geboorte.datum.langFormaat                       | 050310                                                                                                                 |
      | partners.geboorte.datum.type                              | 050310                                                                                                                 |
      | partners.geboorte.datum.datum                             | 050310                                                                                                                 |
      | partners.geboorte.datum.onbekend                          | 050310                                                                                                                 |
      | partners.geboorte.datum.jaar                              | 050310                                                                                                                 |
      | partners.geboorte.datum.maand                             | 050310                                                                                                                 |
      | partners.geboorte.plaats                                  | 050320                                                                                                                 |
      | partners.geboorte.plaats.code                             | 050320                                                                                                                 |
      | partners.geboorte.plaats.omschrijving                     | 050320                                                                                                                 |
      | partners.geboorte.land                                    | 050330                                                                                                                 |
      | partners.geboorte.land.code                               | 050330                                                                                                                 |
      | partners.geboorte.land.omschrijving                       | 050330                                                                                                                 |
      | partners.geboorte                                         | 050310, 050320, 050330                                                                                                 |
      | partners.geslacht                                         | 050410                                                                                                                 |
      | partners.geslacht.code                                    | 050410                                                                                                                 |
      | partners.geslacht.omschrijving                            | 050410                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.datum                | 050610                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.datum.langFormaat    | 050610                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.datum.type           | 050610                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.datum.datum          | 050610                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.datum.onbekend       | 050610                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.datum.jaar           | 050610                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.datum.maand          | 050610                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.plaats               | 050620                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.plaats.code          | 050620                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.plaats.omschrijving  | 050620                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.land                 | 050630                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.land.code            | 050630                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap.land.omschrijving    | 050630                                                                                                                 |
      | partners.aangaanHuwelijkPartnerschap                      | 050610, 050620, 050630                                                                                                 |
      | partners.ontbindingHuwelijkPartnerschap                   | 050710                                                                                                                 |
      | partners.ontbindingHuwelijkPartnerschap.datum             | 050710                                                                                                                 |
      | partners.ontbindingHuwelijkPartnerschap.datum.langFormaat | 050710                                                                                                                 |
      | partners.ontbindingHuwelijkPartnerschap.datum.type        | 050710                                                                                                                 |
      | partners.ontbindingHuwelijkPartnerschap.datum.datum       | 050710                                                                                                                 |
      | partners.ontbindingHuwelijkPartnerschap.datum.onbekend    | 050710                                                                                                                 |
      | partners.ontbindingHuwelijkPartnerschap.datum.jaar        | 050710                                                                                                                 |
      | partners.ontbindingHuwelijkPartnerschap.datum.maand       | 050710                                                                                                                 |
      | partners.soortVerbintenis                                 | 051510                                                                                                                 |
      | partners.soortVerbintenis.code                            | 051510                                                                                                                 |
      | partners.soortVerbintenis.omschrijving                    | 051510                                                                                                                 |
      | partners                                                  | 050120, 050210, 050220, 050230, 050240, 050310, 050320, 050330, 050410, 050610, 050620, 050630, 050710, 051510, PAHP01 |
