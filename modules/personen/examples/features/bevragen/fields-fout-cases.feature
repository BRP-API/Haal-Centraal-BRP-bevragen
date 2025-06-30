#language: nl

Functionaliteit: persoon/persoon beperkt velden vragen met fields - fout cases

Regel: De fields parameter is een verplichte parameter

  @fout-case
  Scenario: De fields parameter ontbreekt bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                  |
    | required | fields | Parameter is verplicht. |

  @fout-case
  Scenario: De fields parameter ontbreekt bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                  |
    | required | fields | Parameter is verplicht. |

Regel: De fields parameter bevat een lijst met minimaal één veld pad

  @fout-case
  Scenario: De fields parameter bevat een lege lijst bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              |                                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                          |
    | minItems | fields | Array bevat minder dan 1 items. |

  @fout-case
  Scenario: De fields parameter bevat een lege lijst bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        |                                     |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                          |
    | minItems | fields | Array bevat minder dan 1 items. |

  @fout-case
  Scenario: De fields parameter bevat een string met veld paden gescheiden door een komma bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields (als string) | burgerservicenummer,geslacht    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name   | reason                   |
    | array | fields | Parameter is geen array. |

  @fout-case
  Scenario: De fields parameter bevat een string met veld paden gescheiden door een komma bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam       | Kierkegaard                         |
    | geboortedatum       | 1956-11-15                          |
    | fields (als string) | burgerservicenummer,geslacht        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name   | reason                   |
    | array | fields | Parameter is geen array. |

Regel: De fields parameter bevat een lijst met maximaal 130 veld paden

  @fout-case
  Scenario: De fields parameter bevat meer dan 130 veld paden bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | <fields>                        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                          |
    | maxItems | fields | Array bevat meer dan 130 items. |

    Voorbeelden:
      | fields                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | aNummer,adressering,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land,adressering.aanhef,adressering.aanschrijfwijze,adressering.aanschrijfwijze.aanspreekvorm,adressering.aanschrijfwijze.naam,adressering.gebruikInLopendeTekst,burgerservicenummer,datumEersteInschrijvingGBA,datumInschrijvingInGemeente,europeesKiesrecht,europeesKiesrecht.aanduiding,europeesKiesrecht.einddatumUitsluiting,geboorte,geboorte.datum,geboorte.land,geboorte.plaats,gemeenteVanInschrijving,geslacht,immigratie,immigratie.datumVestigingInNederland,immigratie.indicatieVestigingVanuitBuitenland,immigratie.landVanwaarIngeschreven,immigratie.vanuitVerblijfplaatsOnbekend,indicatieCurateleRegister,indicatieGezagMinderjarige,kinderen,kinderen.burgerservicenummer,kinderen.geboorte,kinderen.geboorte.datum,kinderen.geboorte.land,kinderen.geboorte.plaats,kinderen.naam,kinderen.naam.adellijkeTitelPredicaat,kinderen.naam.geslachtsnaam,kinderen.naam.voorletters,kinderen.naam.voornamen,kinderen.naam.voorvoegsel,leeftijd,naam,naam.adellijkeTitelPredicaat,naam.geslachtsnaam,naam.volledigeNaam,naam.voorletters,naam.voornamen,naam.voorvoegsel,naam.aanduidingNaamgebruik,nationaliteiten,nationaliteiten.redenOpname,nationaliteiten.datumIngangGeldigheid,nationaliteiten.nationaliteit,opschortingBijhouding,opschortingBijhouding.datum,ouders,ouders.burgerservicenummer,ouders.datumIngangFamilierechtelijkeBetrekking,ouders.geboorte,ouders.geboorte.datum,ouders.geboorte.land,ouders.geboorte.plaats,ouders.geslacht,ouders.naam,ouders.naam.adellijkeTitelPredicaat,ouders.naam.geslachtsnaam,ouders.naam.voorletters,ouders.naam.voornamen,ouders.naam.voorvoegsel,ouders.ouderAanduiding,overlijden,overlijden.datum,overlijden.land,overlijden.plaats,partners,partners.aangaanHuwelijkPartnerschap,partners.aangaanHuwelijkPartnerschap.datum,partners.aangaanHuwelijkPartnerschap.land,partners.aangaanHuwelijkPartnerschap.plaats,partners.burgerservicenummer,partners.geboorte,partners.geboorte.datum,partners.geboorte.land,partners.geboorte.plaats,partners.geslacht,partners.naam,partners.naam.adellijkeTitelPredicaat,partners.naam.geslachtsnaam,partners.naam.voorletters,partners.naam.voornamen,partners.naam.voorvoegsel,partners.ontbindingHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap.datum,partners.soortVerbintenis,uitsluitingKiesrecht,uitsluitingKiesrecht.einddatum,uitsluitingKiesrecht.uitgeslotenVanKiesrecht,verblijfplaats,verblijfplaats.datumIngangGeldigheid,verblijfplaats.datumVan,verblijfplaats.verblijfadres,verblijfplaats.verblijfadres.land,verblijfplaats.verblijfadres.regel1,verblijfplaats.verblijfadres.regel2,verblijfplaats.verblijfadres.regel3,verblijfplaats.adresseerbaarObjectIdentificatie,verblijfplaats.functieAdres,verblijfplaats.nummeraanduidingIdentificatie,verblijfplaats.verblijfadres.aanduidingBijHuisnummer,verblijfplaats.verblijfadres.huisletter,verblijfplaats.verblijfadres.huisnummer,verblijfplaats.verblijfadres.huisnummertoevoeging,verblijfplaats.verblijfadres.korteStraatnaam,verblijfplaats.verblijfadres.officieleStraatnaam,verblijfplaats.verblijfadres.postcode,verblijfplaats.verblijfadres.woonplaats,verblijfplaats.verblijfadres.locatiebeschrijving,verblijfstitel,verblijfstitel.aanduiding,verblijfstitel.datumEinde,verblijfstitel.datumIngang,verblijfplaatsBinnenland,verblijfplaatsBinnenland.datumIngangGeldigheid,verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.verblijfadres,verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie,verblijfplaatsBinnenland.functieAdres,verblijfplaatsBinnenland.nummeraanduidingIdentificatie,verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer,verblijfplaatsBinnenland.verblijfadres.huisletter,verblijfplaatsBinnenland.verblijfadres.huisnummer,verblijfplaatsBinnenland.verblijfadres.huisnummertoevoeging,verblijfplaatsBinnenland.verblijfadres.korteStraatnaam,verblijfplaatsBinnenland.verblijfadres.officieleStraatnaam,verblijfplaatsBinnenland.verblijfadres.postcode,verblijfplaatsBinnenland.verblijfadres.woonplaats,verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving,adresseringBinnenland,adresseringBinnenland.adresregel1,adresseringBinnenland.adresregel2 |

  @fout-case
  Scenario: De fields parameter bevat meer dan 130 veld paden bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | <fields>                            |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                          |
    | maxItems | fields | Array bevat meer dan 130 items. |

    Voorbeelden:
      | fields                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | aNummer,adressering,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land,adressering.aanhef,adressering.aanschrijfwijze,adressering.aanschrijfwijze.aanspreekvorm,adressering.aanschrijfwijze.naam,adressering.gebruikInLopendeTekst,burgerservicenummer,datumEersteInschrijvingGBA,datumInschrijvingInGemeente,europeesKiesrecht,europeesKiesrecht.aanduiding,europeesKiesrecht.einddatumUitsluiting,geboorte,geboorte.datum,geboorte.land,geboorte.plaats,gemeenteVanInschrijving,geslacht,immigratie,immigratie.datumVestigingInNederland,immigratie.indicatieVestigingVanuitBuitenland,immigratie.landVanwaarIngeschreven,immigratie.vanuitVerblijfplaatsOnbekend,indicatieCurateleRegister,indicatieGezagMinderjarige,kinderen,kinderen.burgerservicenummer,kinderen.geboorte,kinderen.geboorte.datum,kinderen.geboorte.land,kinderen.geboorte.plaats,kinderen.naam,kinderen.naam.adellijkeTitelPredicaat,kinderen.naam.geslachtsnaam,kinderen.naam.voorletters,kinderen.naam.voornamen,kinderen.naam.voorvoegsel,leeftijd,naam,naam.adellijkeTitelPredicaat,naam.geslachtsnaam,naam.volledigeNaam,naam.voorletters,naam.voornamen,naam.voorvoegsel,naam.aanduidingNaamgebruik,nationaliteiten,nationaliteiten.redenOpname,nationaliteiten.datumIngangGeldigheid,nationaliteiten.nationaliteit,opschortingBijhouding,opschortingBijhouding.datum,ouders,ouders.burgerservicenummer,ouders.datumIngangFamilierechtelijkeBetrekking,ouders.geboorte,ouders.geboorte.datum,ouders.geboorte.land,ouders.geboorte.plaats,ouders.geslacht,ouders.naam,ouders.naam.adellijkeTitelPredicaat,ouders.naam.geslachtsnaam,ouders.naam.voorletters,ouders.naam.voornamen,ouders.naam.voorvoegsel,ouders.ouderAanduiding,overlijden,overlijden.datum,overlijden.land,overlijden.plaats,partners,partners.aangaanHuwelijkPartnerschap,partners.aangaanHuwelijkPartnerschap.datum,partners.aangaanHuwelijkPartnerschap.land,partners.aangaanHuwelijkPartnerschap.plaats,partners.burgerservicenummer,partners.geboorte,partners.geboorte.datum,partners.geboorte.land,partners.geboorte.plaats,partners.geslacht,partners.naam,partners.naam.adellijkeTitelPredicaat,partners.naam.geslachtsnaam,partners.naam.voorletters,partners.naam.voornamen,partners.naam.voorvoegsel,partners.ontbindingHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap.datum,partners.soortVerbintenis,uitsluitingKiesrecht,uitsluitingKiesrecht.einddatum,uitsluitingKiesrecht.uitgeslotenVanKiesrecht,verblijfplaats,verblijfplaats.datumIngangGeldigheid,verblijfplaats.datumVan,verblijfplaats.verblijfadres,verblijfplaats.verblijfadres.land,verblijfplaats.verblijfadres.regel1,verblijfplaats.verblijfadres.regel2,verblijfplaats.verblijfadres.regel3,verblijfplaats.adresseerbaarObjectIdentificatie,verblijfplaats.functieAdres,verblijfplaats.nummeraanduidingIdentificatie,verblijfplaats.verblijfadres.aanduidingBijHuisnummer,verblijfplaats.verblijfadres.huisletter,verblijfplaats.verblijfadres.huisnummer,verblijfplaats.verblijfadres.huisnummertoevoeging,verblijfplaats.verblijfadres.korteStraatnaam,verblijfplaats.verblijfadres.officieleStraatnaam,verblijfplaats.verblijfadres.postcode,verblijfplaats.verblijfadres.woonplaats,verblijfplaats.verblijfadres.locatiebeschrijving,verblijfstitel,verblijfstitel.aanduiding,verblijfstitel.datumEinde,verblijfstitel.datumIngang,verblijfplaatsBinnenland,verblijfplaatsBinnenland.datumIngangGeldigheid,verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.verblijfadres,verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie,verblijfplaatsBinnenland.functieAdres,verblijfplaatsBinnenland.nummeraanduidingIdentificatie,verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer,verblijfplaatsBinnenland.verblijfadres.huisletter,verblijfplaatsBinnenland.verblijfadres.huisnummer,verblijfplaatsBinnenland.verblijfadres.huisnummertoevoeging,verblijfplaatsBinnenland.verblijfadres.korteStraatnaam,verblijfplaatsBinnenland.verblijfadres.officieleStraatnaam,verblijfplaatsBinnenland.verblijfadres.postcode,verblijfplaatsBinnenland.verblijfadres.woonplaats,verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving,adresseringBinnenland,adresseringBinnenland.adresregel1,adresseringBinnenland.adresregel2 |


Regel: De fields parameter bevat veld paden die verwijzen naar een bestaand veld. Een veld pad is een string bestaande uit minimaal 1 en maximaal 200 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - cijfers (0-9)
      - punt (.) en de laag streepje teken (_)

  @fout-case
  Abstract Scenario: De fields parameter bevat een veld pad met ongeldige karakters bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | <fields>                        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name      | reason                                                   |
    | pattern | fields[0] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,200}$. |

    Voorbeelden:
    | fields                | sub-titel                   |
    | a*nummer              | veld pad bevat * karakter   |
    | burger service nummer | veld pad bevat spaties      |
    | ,burgerservicenummer  | veld pad is een lege string |
    
  @fout-case
  Scenario: De fields parameter bevat een veld pad met meer dan 200 valide karakters bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                                                                                    |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                                                                           |
    | burgerservicenummer | 000000139                                                                                                                                                                                                 |
    | fields              | bestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbesta |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name      | reason                                                   |
    | pattern | fields[0] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,200}$. |

  @fout-case
  Scenario: De fields parameter bevat het pad naar een niet bestaand veld (onjuiste case) bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | anummer                         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Scenario: De fields parameter bevat het pad naar een niet bestaand veld bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | burgerservicenummer,aNummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[1] | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Abstract Scenario: Automatisch geleverd veld <fields> mag niet worden gevraagd bij raadplegen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | <fields>                        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                        |
    | fields | fields[0] | Parameter bevat een niet toegestane veldnaam. |

    Voorbeelden:
    | fields                                                         |
    | geheimhoudingPersoonsgegevens                                  |
    | opschortingBijhouding                                          |
    | opschortingBijhouding.reden                                    |
    | opschortingBijhouding.reden.omschrijving                       |
    | opschortingBijhouding.datum                                    |
    | opschortingBijhouding.datum.type                               |
    | rni                                                            |
    | rni.deelnemer                                                  |
    | rni.deelnemer.code                                             |
    | rni.omschrijvingVerdrag                                        |
    | rni.categorie                                                  |
    | verificatie                                                    |
    | verificatie.datum                                              |
    | verificatie.datum.datum                                        |
    | verificatie.omschrijving                                       |
    | inOnderzoek                                                    |
    | inOnderzoek.burgerservicenummer                                |
    | inOnderzoek.datumIngangOnderzoekPersoon                        |
    | inOnderzoek.datumIngangOnderzoekGemeente.langFormaat           |
    | naam.inOnderzoek.voornamen                                     |
    | geboorte.inOnderzoek.datumIngangOnderzoek                      |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datum         |
    | adressering.indicatieVastgesteldVerblijftNietOpAdres           |
    | adresseringBinnenland.indicatieVastgesteldVerblijftNietOpAdres |
    | verblijfplaats.indicatieVastgesteldVerblijftNietOpAdres        |

  @fout-case
  Scenario: Automatisch geleverd veld <fields> mag niet worden gevraagd bij zoeken
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | <fields>                            |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                        |
    | fields | fields[0] | Parameter bevat een niet toegestane veldnaam. |

    Voorbeelden:
    | fields                                                         |
    | geheimhoudingPersoonsgegevens                                  |
    | opschortingBijhouding                                          |
    | opschortingBijhouding.reden                                    |
    | opschortingBijhouding.reden.omschrijving                       |
    | opschortingBijhouding.datum                                    |
    | opschortingBijhouding.datum.type                               |
    | rni                                                            |
    | rni.deelnemer                                                  |
    | rni.deelnemer.code                                             |
    | rni.omschrijvingVerdrag                                        |
    | rni.categorie                                                  |
    | verificatie                                                    |
    | verificatie.datum                                              |
    | verificatie.datum.datum                                        |
    | verificatie.omschrijving                                       |
    | inOnderzoek                                                    |
    | inOnderzoek.burgerservicenummer                                |
    | inOnderzoek.datumIngangOnderzoekPersoon                        |
    | naam.inOnderzoek.voornamen                                     |
    | geboorte.inOnderzoek.datumIngangOnderzoek                      |
    | adressering.indicatieVastgesteldVerblijftNietOpAdres           |
    | adresseringBinnenland.indicatieVastgesteldVerblijftNietOpAdres |
