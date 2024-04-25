#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor nationaliteiten 

  Regel: Gebruikte parameters worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.
    - voor nationaliteit type geldt rubriek aanduiding "PA.NT.01"
    - type wordt altijd meegeleverd, dus wordt ook altijd geprotocolleerd

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
      | fields                                            | gevraagde rubrieken            |
      | nationaliteiten.type                              | PANT01                         |
      | nationaliteiten.nationaliteit                     | 040510                         |
      | nationaliteiten.nationaliteit.code                | 040510                         |
      | nationaliteiten.nationaliteit.omschrijving        | 040510                         |
      | nationaliteiten.redenOpname                       | 046310                         |
      | nationaliteiten.redenOpname.code                  | 046310                         |
      | nationaliteiten.redenOpname.omschrijving          | 046310                         |
      | nationaliteiten.datumIngangGeldigheid             | 048510                         |
      | nationaliteiten.datumIngangGeldigheid.langFormaat | 048510                         |
      | nationaliteiten.datumIngangGeldigheid.type        | 048510                         |
      | nationaliteiten.datumIngangGeldigheid.datum       | 048510                         |
      | nationaliteiten.datumIngangGeldigheid.onbekend    | 048510                         |
      | nationaliteiten.datumIngangGeldigheid.jaar        | 048510                         |
      | nationaliteiten.datumIngangGeldigheid.maand       | 048510                         |
      | nationaliteiten                                   | 040510, 046310, 048510, PANT01 |

