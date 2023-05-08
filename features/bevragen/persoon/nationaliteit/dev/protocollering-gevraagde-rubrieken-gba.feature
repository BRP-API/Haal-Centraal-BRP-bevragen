#language: nl

@gba @protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor nationaliteiten 

  Rule: Gebruikte parameters worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 8016043787 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                            | gevraagde rubrieken            |
      | nationaliteiten                                   | 040510, 046310, 046510, 048510 |
      | nationaliteiten.redenOpname                       | 040510, 046310, 046510         |
      | nationaliteiten.redenOpname.code                  | 040510, 046310, 046510         |
      | nationaliteiten.redenOpname.omschrijving          | 040510, 046310, 046510         |
      | nationaliteiten.type                              | 040510, 046510                 |
      | nationaliteiten.datumIngangGeldigheid             | 040510, 046510, 048510         |
      | nationaliteiten.datumIngangGeldigheid.langFormaat | 040510, 046510, 048510         |
      | nationaliteiten.datumIngangGeldigheid.type        | 040510, 046510, 048510         |
      | nationaliteiten.datumIngangGeldigheid.datum       | 040510, 046510, 048510         |
      | nationaliteiten.datumIngangGeldigheid.onbekend    | 040510, 046510, 048510         |
      | nationaliteiten.datumIngangGeldigheid.jaar        | 040510, 046510, 048510         |
      | nationaliteiten.datumIngangGeldigheid.maand       | 040510, 046510, 048510         |
      | nationaliteiten.nationaliteit                     | 040510, 046510                 |
      | nationaliteiten.nationaliteit.code                | 040510, 046510                 |
      | nationaliteiten.nationaliteit.omschrijving        | 040510, 046510                 |

