#language: nl

@gba
Functionaliteit: persoon: in onderzoek leveren bij vragen om gegevens van verblijfplaats

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 010000                          | 20230101                       |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 222222222                   | 020000                          | 20230102                       |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0052                  | 040000                          | 20230104                       |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 555555555                   | 050000                          | 20230105                       |
      En de persoon heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 20020701                 | 060000                          | 20230106                       |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0000                          | 080000                          | 20230108                       |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 999999999                   | 090000                          | 20230109                       |
      En de persoon heeft de volgende 'verblijfstitel' gegevens
      | aanduiding verblijfstitel (39.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 37                                | 100000                          | 20230110                       |
      En de persoon heeft de volgende 'gezagsverhouding' gegevens
      | indicatie curateleregister (33.10) | indicatie gezag minderjarige (32.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1                                  | 12                                   | 110000                          | 20230111                       |

  Regel: onderzoek wordt geleverd wanneer ten minste één gegeven uit die categorie is gevraagd

    Abstract Scenario: meerdere categorieën in onderzoek en <fields> uit categorie Verblijfplaats wordt gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                      | waarde   |
      | inOnderzoek.aanduidingGegevensInOnderzoek | 080000   |
      | inOnderzoek.datumIngangOnderzoek          | 20230108 |

      Voorbeelden:
      | fields                                  |
      | datumInschrijvingInGemeente             |
      | datumInschrijvingInGemeente.langFormaat |
      | datumInschrijvingInGemeente.type        |
      | datumInschrijvingInGemeente.datum       |
      | datumInschrijvingInGemeente.onbekend    |
      | datumInschrijvingInGemeente.jaar        |
      | datumInschrijvingInGemeente.maand       |
      | gemeenteVanInschrijving                 |
      | gemeenteVanInschrijving.code            |
      | gemeenteVanInschrijving.omschrijving    |

    Abstract Scenario: meerdere categorieën in onderzoek en <fields> uit categorie Verblijfplaats wordt gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                      | waarde   |
      | land.code                                 | 0000     |
      | land.omschrijving                         | Onbekend |
      | inOnderzoek.aanduidingGegevensInOnderzoek | 080000   |
      | inOnderzoek.datumIngangOnderzoek          | 20230108 |

      Voorbeelden:
      | fields                                                            |
      | verblijfplaats                                                    |
      | verblijfplaats.type                                               |
      | verblijfplaats.datumIngangGeldigheid                              |
      | verblijfplaats.datumIngangGeldigheid.langFormaat                  |
      | verblijfplaats.datumIngangGeldigheid.type                         |
      | verblijfplaats.datumIngangGeldigheid.datum                        |
      | verblijfplaats.datumIngangGeldigheid.onbekend                     |
      | verblijfplaats.datumIngangGeldigheid.jaar                         |
      | verblijfplaats.datumIngangGeldigheid.maand                        |
      | verblijfplaats.datumVan                                           |
      | verblijfplaats.datumVan.langFormaat                               |
      | verblijfplaats.datumVan.type                                      |
      | verblijfplaats.datumVan.datum                                     |
      | verblijfplaats.datumVan.onbekend                                  |
      | verblijfplaats.datumVan.jaar                                      |
      | verblijfplaats.datumVan.maand                                     |
      | verblijfplaats.verblijfadres                                      |
      | verblijfplaats.verblijfadres.land                                 |
      | verblijfplaats.verblijfadres.land.code                            |
      | verblijfplaats.verblijfadres.land.omschrijving                    |
      | verblijfplaats.verblijfadres.regel1                               |
      | verblijfplaats.verblijfadres.regel2                               |
      | verblijfplaats.verblijfadres.regel3                               |
      | verblijfplaats.adresseerbaarObjectIdentificatie                   |
      | verblijfplaats.functieAdres                                       |
      | verblijfplaats.functieAdres.code                                  |
      | verblijfplaats.functieAdres.omschrijving                          |
      | verblijfplaats.nummeraanduidingIdentificatie                      |
      | verblijfplaats.verblijfadres.aanduidingBijHuisnummer              |
      | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.code         |
      | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.omschrijving |
      | verblijfplaats.verblijfadres.huisletter                           |
      | verblijfplaats.verblijfadres.huisnummer                           |
      | verblijfplaats.verblijfadres.huisnummertoevoeging                 |
      | verblijfplaats.verblijfadres.korteStraatnaam                      |
      | verblijfplaats.verblijfadres.officieleStraatnaam                  |
      | verblijfplaats.verblijfadres.postcode                             |
      | verblijfplaats.verblijfadres.woonplaats                           |
      | verblijfplaats.verblijfadres.locatiebeschrijving                  |

    Abstract Scenario: meerdere categorieën in onderzoek en <fields> uit categorie Verblijfplaats wordt gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                      | waarde   |
      | inOnderzoek.aanduidingGegevensInOnderzoek | 080000   |
      | inOnderzoek.datumIngangOnderzoek          | 20230108 |

      Voorbeelden:
      | fields                                           |
      | immigratie                                       |
      | immigratie.datumVestigingInNederland             |
      | immigratie.datumVestigingInNederland.langFormaat |
      | immigratie.datumVestigingInNederland.type        |
      | immigratie.datumVestigingInNederland.datum       |
      | immigratie.datumVestigingInNederland.onbekend    |
      | immigratie.datumVestigingInNederland.jaar        |
      | immigratie.datumVestigingInNederland.maand       |
      | immigratie.indicatieVestigingVanuitBuitenland    |
      | immigratie.landVanwaarIngeschreven               |
      | immigratie.landVanwaarIngeschreven.code          |
      | immigratie.landVanwaarIngeschreven.omschrijving  |
      | immigratie.vanuitVerblijfplaatsOnbekend          |
