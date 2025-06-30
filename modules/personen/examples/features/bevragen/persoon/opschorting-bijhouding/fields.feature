#language: nl

Functionaliteit: Persoon: opschorting bijhouding leveren als niet gevraagd met fields


Regel: opschortingBijhouding wordt automatisch geleverd indien van toepassing

  Abstract Scenario: 'reden opschorting bijhouding (67.20)' met waarde '<opschorting reden>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 0123456789      | William           | de                  | Vries                 | 20040526              | M                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20020701                             | <opschorting reden>                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam,geboorte,geslacht          |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde |
    | geslacht.code         | M      |
    | geslacht.omschrijving | man    |
    En heeft de persoon de volgende 'naam' gegevens
    | naam          | waarde           |
    | voornamen     | William          |
    | voorvoegsel   | de               |
    | geslachtsnaam | Vries            |
    | volledigeNaam | William de Vries |
    | voorletters   | W.               |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 2004-05-26  |
    | datum.langFormaat | 26 mei 2004 |
    En heeft de persoon de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde               |
    | reden.code         | <opschorting reden>  |
    | reden.omschrijving | <reden omschrijving> |
    | datum.type         | Datum                |
    | datum.datum        | 2002-07-01           |
    | datum.langFormaat  | 1 juli 2002          |

    Voorbeelden:
    | opschorting reden | reden omschrijving        |
    | O                 | overlijden                |
    | E                 | emigratie                 |
    | M                 | ministerieel besluit      |
    | R                 | pl is aangelegd in de rni |
    | .                 | onbekend                  |

  Abstract Scenario: 'datum opschorting bijhouding (67.10)' van het type '<type>'
    Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde     |
    | reden opschorting bijhouding (67.20) | O          |
    | datum opschorting bijhouding (67.10) | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000140                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000140 |
    En heeft de persoon de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde        |
    | reden.code         | O             |
    | reden.omschrijving | overlijden    |
    | datum.type         | <type>        |
    | datum.datum        | <datum>       |
    | datum.jaar         | <jaar>        |
    | datum.maand        | <maand>       |
    | datum.onbekend     | <onbekend>    |
    | datum.langFormaat  | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
    | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
    | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
    | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

Regel: opschortingBijhouding mag niet worden gevraagd, omdat het automatisch wordt geleverd

  @fout-case
  Abstract Scenario: veld <fields> mag niet worden gevraagd, omdat het automatisch wordt geleverd 
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
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
    | fields                                    |
    | opschortingBijhouding                     |
    | opschortingBijhouding.reden               |
    | opschortingBijhouding.reden.code          |
    | opschortingBijhouding.reden.omschrijving  |
    | opschortingBijhouding.datum               |
    | opschortingBijhouding.datum.type          |
    | opschortingBijhouding.datum.datum         |
    | opschortingBijhouding.datum.langFormaat   |
    | opschortingBijhouding.datum.jaar          |
    | opschortingBijhouding.datum.maand         |
    | opschortingBijhouding.datum.onbekend      |
    | opschortingBijhouding,burgerservicenummer |

  @fout-case
  Scenario: meerdere velden worden gevraagd van opschortingBijhouding
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                           |
    | type                | RaadpleegMetBurgerservicenummer                                                  |
    | burgerservicenummer | 000000024                                                                        |
    | fields              | burgerservicenummer,opschortingBijhouding.reden,opschortingBijhouding.datum,naam |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1], fields[2].        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                        |
    | fields | fields[1] | Parameter bevat een niet toegestane veldnaam. |
    | fields | fields[2] | Parameter bevat een niet toegestane veldnaam. |
