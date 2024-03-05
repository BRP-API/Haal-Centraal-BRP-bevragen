#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor gezag

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000048' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En voor de persoon met burgerservicenummer '000000048' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG1        | 000000048        |
      | 000000024       | OG2        | 000000048        |
      En de persoon met burgerservicenummer '000000061' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000061' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | OG2        | 000000061        |
      | 000000036       | GG         | 000000061        |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG1        | 000000048        |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | OG2        | 000000048        |
      | 000000024       | OG2        | 000000061        |
      En de persoon met burgerservicenummer '000000036' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En voor de persoon met burgerservicenummer '000000036' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000036       | GG         | 000000061        |
      | 000000036       | GG         | 000000048        |
      En de persoon met burgerservicenummer '000000073' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 20040730 |
      En de persoon met burgerservicenummer '000000073' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000085' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 20190516 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En voor de persoon met burgerservicenummer '000000085' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000085       | N          |                  |
      En de persoon met burgerservicenummer '000000085' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 20190516 |
      En voor de persoon met burgerservicenummer '000000097' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000097       | G          |                  |


  Rule: Wanneer gezag wordt gevraagd, wordt gevraagde rubriek 'PAGZ01' geprotocolleerd

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken 'PAGZ01'
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | PAGZ01                      |

      Voorbeelden:
      | fields                                     |
      | gezag                                      |
      | gezag.type                                 |
      | gezag.minderjarige                         |
      | gezag.ouders                               |
      | gezag.ouder                                |
      | gezag.derde                                |
      | gezag.derden                               |
      | gezag.minderjarige.burgerservicenummer     |
      | gezag.ouders.burgerservicenummer           |
      | gezag.ouder.burgerservicenummer            |
      | gezag.derde.burgerservicenummer            |
      | gezag.derden.burgerservicenummer           |
      | gezag.ouders,gezag.ouder                   |

    Abstract Scenario: Gezag vragen levert <testsitatie> en wordt geprotocolleerd als gevraagde rubrieken 'PAGZ01'
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | gezag                           |
      Dan heeft de persoon met burgerservicenummer '<burgerservicenummer>' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | PAGZ01                      |

      Voorbeelden:
      | burgerservicenummer | testsitatie               |
      | 000000012           | EenhoofdigOuderlijkGezag  |
      | 000000024           | TweehoofdigOuderlijkGezag |
      | 000000036           | GezamenlijkGezag          |
      | 000000048           | meerdere gezagsrelaties   |
      | 000000073           | geen gezagsrelatie        |
      | 000000085           | GezagNietTeBepalen        |
      | 000000097           | TijdelijkGeenGezag        |
