#language: nl

Functionaliteit: persoon/persoon beperkt velden vragen met fields - fout cases

Rule: De fields parameter is een verplichte parameter

  @fout-case
  Scenario: De fields parameter ontbreekt bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsCombination                                           |
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
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name   | reason                  |
    | required | fields | Parameter is verplicht. |

Rule: De fields parameter bevat een lijst met minimaal één veld pad

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

Rule: De fields parameter bevat een lijst met maximaal 130 veld paden

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
    | fields                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
    | aanduidingNaamgebruik,aanduidingNaamgebruik.code,aangaanHuwelijkPartnerschap,aanhef,aanschrijfwijze,aanschrijfwijze.aanspreekvorm,aanschrijfwijze.naam,aanspreekvorm,adresregel1,adresregel2,adresregel3,adressering,adressering.aanhef,adressering.aanschrijfwijze,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.inOnderzoek,adressering.inOnderzoek.aanhef,adressering.inOnderzoek.land,adressering.land,adressering.land.code,adressering.land.omschrijving,aNummer,burgerservicenummer,datumEersteInschrijvingGBA,datumEinde,datumEinde.datum,datumEinde.jaar,datumEinde.langFormaat,datumEinde.maand,datumEinde.onbekend,datumEinde.type,datumIngang,datumIngang.datum,datumIngang.jaar,datumIngang.langFormaat,datumIngang.maand,datumIngang.onbekend,datumIngang.type,datumVan,datumVan.datum,datumVan.jaar,datumVan.langFormaat,datumVan.maand,datumVan.type,datumVestigingInNederland,einddatum,einddatum.datum,einddatum.jaar,einddatum.langFormaat,einddatum.maand,einddatum.type,einddatumUitsluiting,einddatumUitsluiting.jaar,einddatumUitsluiting.maand,einddatumUitsluiting.type,europeesKiesrecht,geboorte,geboorte.datum,geboorte.datum.datum,geboorte.datum.jaar,geboorte.datum.langFormaat,geboorte.datum.maand,geboorte.datum.onbekend,geboorte.datum.type,geboorte.inOnderzoek,geboorte.inOnderzoek.datum,geboorte.inOnderzoek.land,geboorte.inOnderzoek.plaats,geboorte.land,geboorte.land.code,geboorte.land.omschrijving,geboorte.plaats,geboorte.plaats.code,geboorte.plaats.omschrijving,gebruikInLopendeTekst,geslacht,geslacht.code,geslacht.omschrijving,huisletter,huisnummer,huisnummertoevoeging,immigratie,indicatieOverleden,inOnderzoek,inOnderzoek.aanduiding,inOnderzoek.aanhef,inOnderzoek.aanschrijfwijze,inOnderzoek.geslacht,inOnderzoek.huisletter,inOnderzoek.huisnummer,inOnderzoek.korteNaam,inOnderzoek.leeftijd,inOnderzoek.nationaliteit,inOnderzoek.postcode,inOnderzoek.redenOpname,inOnderzoek.regel1,inOnderzoek.regel2,inOnderzoek.regel3,inOnderzoek.soortVerbintenis,inOnderzoek.officieleStraatnaam,inOnderzoek.volledigeNaam,inOnderzoek.woonplaats,kinderen,kinderen.burgerservicenummer,kinderen.geboorte,kinderen.geboorte.datum,kinderen.geboorte.datum.datum,kinderen.geboorte.datum.jaar,kinderen.naam,kinderen.naam.voorletters,kinderen.naam.voornamen,kinderen.naam.voorvoegsel,korteStraatn,leeftijd,locatiebeschrijving,naam,naam.aanduidingNaamgebruik,naam.inOnderzoek.voorvoegsel,naam.volledigeNaam,naam.voorletters,naam.voornamen,naam.voorvoegsel,ouders,ouders.geslacht,overlijden,woonplaats,rni,regel1,regel2,regel3 |

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
    | fields                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
    | aanduidingNaamgebruik,aanduidingNaamgebruik.code,aangaanHuwelijkPartnerschap,aanhef,aanschrijfwijze,aanschrijfwijze.aanspreekvorm,aanschrijfwijze.naam,aanspreekvorm,adresregel1,adresregel2,adresregel3,adressering,adressering.aanhef,adressering.aanschrijfwijze,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.inOnderzoek,adressering.inOnderzoek.aanhef,adressering.inOnderzoek.land,adressering.land,adressering.land.code,adressering.land.omschrijving,aNummer,burgerservicenummer,datumEersteInschrijvingGBA,datumEinde,datumEinde.datum,datumEinde.jaar,datumEinde.langFormaat,datumEinde.maand,datumEinde.onbekend,datumEinde.type,datumIngang,datumIngang.datum,datumIngang.jaar,datumIngang.langFormaat,datumIngang.maand,datumIngang.onbekend,datumIngang.type,datumVan,datumVan.datum,datumVan.jaar,datumVan.langFormaat,datumVan.maand,datumVan.type,datumVestigingInNederland,einddatum,einddatum.datum,einddatum.jaar,einddatum.langFormaat,einddatum.maand,einddatum.type,einddatumUitsluiting,einddatumUitsluiting.jaar,einddatumUitsluiting.maand,einddatumUitsluiting.type,europeesKiesrecht,geboorte,geboorte.datum,geboorte.datum.datum,geboorte.datum.jaar,geboorte.datum.langFormaat,geboorte.datum.maand,geboorte.datum.onbekend,geboorte.datum.type,geboorte.inOnderzoek,geboorte.inOnderzoek.datum,geboorte.inOnderzoek.land,geboorte.inOnderzoek.plaats,geboorte.land,geboorte.land.code,geboorte.land.omschrijving,geboorte.plaats,geboorte.plaats.code,geboorte.plaats.omschrijving,gebruikInLopendeTekst,geslacht,geslacht.code,geslacht.omschrijving,huisletter,huisnummer,huisnummertoevoeging,immigratie,indicatieOverleden,inOnderzoek,inOnderzoek.aanduiding,inOnderzoek.aanhef,inOnderzoek.aanschrijfwijze,inOnderzoek.geslacht,inOnderzoek.huisletter,inOnderzoek.huisnummer,inOnderzoek.korteNaam,inOnderzoek.leeftijd,inOnderzoek.nationaliteit,inOnderzoek.postcode,inOnderzoek.redenOpname,inOnderzoek.regel1,inOnderzoek.regel2,inOnderzoek.regel3,inOnderzoek.soortVerbintenis,inOnderzoek.officieleStraatnaam,inOnderzoek.volledigeNaam,inOnderzoek.woonplaats,kinderen,kinderen.burgerservicenummer,kinderen.geboorte,kinderen.geboorte.datum,kinderen.geboorte.datum.datum,kinderen.geboorte.datum.jaar,kinderen.naam,kinderen.naam.voorletters,kinderen.naam.voornamen,kinderen.naam.voorvoegsel,korteStraatnaam,leeftijd,locatiebeschrijving,naam,naam.aanduidingNaamgebruik,naam.inOnderzoek.voorvoegsel,naam.volledigeNaam,naam.voorletters,naam.voornamen,naam.voorvoegsel,ouders,ouders.geslacht,overlijden,woonplaats,rni,regel1,regel2,regel3 |

Rule: De fields parameter bevat verkorte/volledig veld paden die verwijzen naar een bestaand veld. Een veld pad is een string bestaande uit minimaal 1 en maximaal 200 karakters. Deze karakters kunnen zijn:
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
    | naam                | waarde                                                                                                                                                                                                   |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                                                                          |
    | burgerservicenummer | 000000139                                                                                                                                                                                                |
    | fields              | bestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbest |
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
    | pattern | fields[0] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |

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
