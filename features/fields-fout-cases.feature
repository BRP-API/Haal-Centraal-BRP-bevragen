#language: nl

Functionaliteit: Fields fout cases

Rule: De Fields parameter is verplicht.

  @fout-case
  Scenario: Raadpleeg met burgerservicenummer: Fields parameter ontbreekt
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
  Scenario: Zoek met geslachtsnaam en geboortedatum: Fields parameter ontbreekt
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

  @fout-case
  Scenario: Raadpleeg met burgerservicenummer: Fields parameter is leeg
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
  Scenario: Zoek met geslachtsnaam en geboortedatum: Fields parameter is leeg
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
  Scenario: Raadpleeg met burgerservicenummer: Fields parameter is geen array
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields (als string) | burgerservicenummer             |
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
  Scenario: Zoek met geslachtsnaam en geboortedatum: Fields parameter is geen array
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam       | Kierkegaard                         |
    | geboortedatum       | 1956-11-15                          |
    | fields (als string) | burgerservicenummer                 |
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

Rule: De Fields parameter mag maximaal 130 veld paden bevatten

  @fout-case
  Scenario: Raadpleeg met burgerservicenummer: Fields parameter bevat meer dan 130 veld paden
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | <131 maal aNummer>              |
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
    | 131 maal aNummer |
    |   aanduidingNaamgebruik,aanduidingNaamgebruik.code,aangaanHuwelijkPartnerschap,aanhef,aanschrijfwijze,aanschrijfwijze.aanspreekvorm,aanschrijfwijze.naam,aanspreekvorm,adresregel1,adresregel2,adresregel3,adressering,adressering.aanhef,adressering.aanschrijfwijze,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.inOnderzoek,adressering.inOnderzoek.aanhef,adressering.inOnderzoek.land,adressering.land,adressering.land.code,adressering.land.omschrijving,aNummer,burgerservicenummer,datumEersteInschrijvingGBA,datumEinde,datumEinde.datum,datumEinde.jaar,datumEinde.langFormaat,datumEinde.maand,datumEinde.onbekend,datumEinde.type,datumIngang,datumIngang.datum,datumIngang.jaar,datumIngang.langFormaat,datumIngang.maand,datumIngang.onbekend,datumIngang.type,datumVan,datumVan.datum,datumVan.jaar,datumVan.langFormaat,datumVan.maand,datumVan.type,datumVestigingInNederland,einddatum,einddatum.datum,einddatum.jaar,einddatum.langFormaat,einddatum.maand,einddatum.type,einddatumUitsluiting,einddatumUitsluiting.jaar,einddatumUitsluiting.maand,einddatumUitsluiting.type,europeesKiesrecht,geboorte,geboorte.datum,geboorte.datum.datum,geboorte.datum.jaar,geboorte.datum.langFormaat,geboorte.datum.maand,geboorte.datum.onbekend,geboorte.datum.type,geboorte.inOnderzoek,geboorte.inOnderzoek.datum,geboorte.inOnderzoek.land,geboorte.inOnderzoek.plaats,geboorte.land,geboorte.land.code,geboorte.land.omschrijving,geboorte.plaats,geboorte.plaats.code,geboorte.plaats.omschrijving,gebruikInLopendeTekst,geslacht,geslacht.code,geslacht.omschrijving,huisletter,huisnummer,huisnummertoevoeging,immigratie,indicatieOverleden,inOnderzoek,inOnderzoek.aanduiding,inOnderzoek.aanhef,inOnderzoek.aanschrijfwijze,inOnderzoek.geslacht,inOnderzoek.huisletter,inOnderzoek.huisnummer,inOnderzoek.korteNaam,inOnderzoek.leeftijd,inOnderzoek.nationaliteit,inOnderzoek.postcode,inOnderzoek.redenOpname,inOnderzoek.regel1,inOnderzoek.regel2,inOnderzoek.regel3,inOnderzoek.soortVerbintenis,inOnderzoek.straat,inOnderzoek.volledigeNaam,inOnderzoek.woonplaats,kinderen,kinderen.burgerservicenummer,kinderen.geboorte,kinderen.geboorte.datum,kinderen.geboorte.datum.datum,kinderen.geboorte.datum.jaar,kinderen.naam,kinderen.naam.voorletters,kinderen.naam.voornamen,kinderen.naam.voorvoegsel,korteNaam,leeftijd,locatiebeschrijving,naam,naam.aanduidingNaamgebruik,naam.inOnderzoek.voorvoegsel,naam.volledigeNaam,naam.voorletters,naam.voornamen,naam.voorvoegsel,ouders,ouders.geslacht,overlijden,woonplaats,rni,regel1,regel2,regel3 |

  @fout-case
  Scenario: Zoek met geslachtsnaam en geboortedatum: Fields parameter bevat meer dan 130 veld paden
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | <131 maal aNummer>                  |
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
    | 131 maal aNummer |
    |  aanduidingNaamgebruik,aanduidingNaamgebruik.code,aangaanHuwelijkPartnerschap,aanhef,aanschrijfwijze,aanschrijfwijze.aanspreekvorm,aanschrijfwijze.naam,aanspreekvorm,adresregel1,adresregel2,adresregel3,adressering,adressering.aanhef,adressering.aanschrijfwijze,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.inOnderzoek,adressering.inOnderzoek.aanhef,adressering.inOnderzoek.land,adressering.land,adressering.land.code,adressering.land.omschrijving,aNummer,burgerservicenummer,datumEersteInschrijvingGBA,datumEinde,datumEinde.datum,datumEinde.jaar,datumEinde.langFormaat,datumEinde.maand,datumEinde.onbekend,datumEinde.type,datumIngang,datumIngang.datum,datumIngang.jaar,datumIngang.langFormaat,datumIngang.maand,datumIngang.onbekend,datumIngang.type,datumVan,datumVan.datum,datumVan.jaar,datumVan.langFormaat,datumVan.maand,datumVan.type,datumVestigingInNederland,einddatum,einddatum.datum,einddatum.jaar,einddatum.langFormaat,einddatum.maand,einddatum.type,einddatumUitsluiting,einddatumUitsluiting.jaar,einddatumUitsluiting.maand,einddatumUitsluiting.type,europeesKiesrecht,geboorte,geboorte.datum,geboorte.datum.datum,geboorte.datum.jaar,geboorte.datum.langFormaat,geboorte.datum.maand,geboorte.datum.onbekend,geboorte.datum.type,geboorte.inOnderzoek,geboorte.inOnderzoek.datum,geboorte.inOnderzoek.land,geboorte.inOnderzoek.plaats,geboorte.land,geboorte.land.code,geboorte.land.omschrijving,geboorte.plaats,geboorte.plaats.code,geboorte.plaats.omschrijving,gebruikInLopendeTekst,geslacht,geslacht.code,geslacht.omschrijving,huisletter,huisnummer,huisnummertoevoeging,immigratie,indicatieOverleden,inOnderzoek,inOnderzoek.aanduiding,inOnderzoek.aanhef,inOnderzoek.aanschrijfwijze,inOnderzoek.geslacht,inOnderzoek.huisletter,inOnderzoek.huisnummer,inOnderzoek.korteNaam,inOnderzoek.leeftijd,inOnderzoek.nationaliteit,inOnderzoek.postcode,inOnderzoek.redenOpname,inOnderzoek.regel1,inOnderzoek.regel2,inOnderzoek.regel3,inOnderzoek.soortVerbintenis,inOnderzoek.straat,inOnderzoek.volledigeNaam,inOnderzoek.woonplaats,kinderen,kinderen.burgerservicenummer,kinderen.geboorte,kinderen.geboorte.datum,kinderen.geboorte.datum.datum,kinderen.geboorte.datum.jaar,kinderen.naam,kinderen.naam.voorletters,kinderen.naam.voornamen,kinderen.naam.voorvoegsel,korteNaam,leeftijd,locatiebeschrijving,naam,naam.aanduidingNaamgebruik,naam.inOnderzoek.voorvoegsel,naam.volledigeNaam,naam.voorletters,naam.voornamen,naam.voorvoegsel,ouders,ouders.geslacht,overlijden,woonplaats,rni,regel1,regel2,regel3 |

Rule: De Fields parameter bevat het pad naar de op te vragen velden
  - zie fields-mapping.csv: wanneer een in fields opgegeven veld(pad) niet voorkomt in de linker kolom, geeft dat een foutmelding
  - velden worden gescheiden door een komma, zonder spatie

  @fout-case
  Abstract Scenario: Raadpleeg met burgerservicenummer: gevraagde veld bestaat niet
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
    | code   | name      | reason   |
    | <code> | fields[0] | <reason> |

    Voorbeelden:
    | code    | reason                                                   | fields                                                                                                                                                                                                   |
    | fields  | Parameter bevat een niet bestaande veldnaam.             | bestaatniet                                                                                                                                                                                              |
    | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. | bestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbest |

  @fout-case
  Abstract Scenario: Zoek met geslachtsnaam en geboortedatum: gevraagde veld bestaat niet
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
    | code   | name      | reason   |
    | <code> | fields[0] | <reason> |

    Voorbeelden:
    | code    | reason                                                   | fields                                                                                                                                                                                                   |
    | fields  | Parameter bevat een niet bestaande veldnaam.             | bestaatniet                                                                                                                                                                                              |
    | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. | bestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbest |

  @fout-case
  Scenario: Raadpleeg met burgerservicenummer: meerdere gevraagde velden bestaan niet
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                         |
    | type                | RaadpleegMetBurgerservicenummer                |
    | burgerservicenummer | 000000139                                      |
    | fields              | burgerservicenummer,bestaatniet,bestaatookniet |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1], fields[2].        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[1] | Parameter bevat een niet bestaande veldnaam. |
    | fields | fields[2] | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Scenario: Pad van een gevraagd veld is opgegeven in onjuiste case
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | BurgerServiceNummer,geslacht    |
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
  Abstract Scenario: opgegeven pad is niet uniek en leidt naar meer dan één veld
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | burgerservicenummer,<pad>       |
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

    Voorbeelden:
    | pad                                  |
    | voorletters                          |
    | voornamen                            |
    | adellijkeTitelPredicaat              |
    | adellijkeTitelPredicaat.code         |
    | adellijkeTitelPredicaat.omschrijving |
    | adellijkeTitelPredicaat.soort        |
    | voorvoegsel                          |
    | geslachtsnaam                        |
    | datum                                |
    | plaats                               |
    | land                                 |
    | type                                 |
    | code                                 |
    | plaats.code                          |
    | land.code                            |
    | omschrijving                         |
    | plaats.omschrijving                  |
    | land.omschrijving                    |
    | soort                                |
    | datumIngangGeldigheid                |
    | indicatieOnbekend                    |

  @fout-case
  Scenario: Veld pad bevat spaties
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | burgerservicenummer, naam       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name      | reason                                                   |
    | pattern | fields[1] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |

  @fout-case
  Scenario: Veld pad is een lege string
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | burgerservicenummer,,naam       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name      | reason                                                   |
    | pattern | fields[1] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |

  @fout-case
  Abstract Scenario: Gevraagde velden worden niet gescheiden door een komma
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
    | code   | name      | reason   |
    | <code> | fields[0] | <reason> |

    Voorbeelden:
    | fields                                 | code    | reason                                                   |
    | burgerservicenummer\naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |
    | burgerservicenummer;naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |
    | burgerservicenummer naam.geslachtsnaam | pattern | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,199}$. |
    | burgerservicenummer_naam.geslachtsnaam | fields  | Parameter bevat een niet bestaande veldnaam.             |
    | burgerservicenummernaam.geslachtsnaam  | fields  | Parameter bevat een niet bestaande veldnaam.             |

  @fout-case
  Scenario: Zoek met geslachtsnaam en geboortedatum: gevraagde veld is geen PersoonBeperkt veld
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
