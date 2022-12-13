#language: nl

Functionaliteit: Fields fout cases

Rule: De Fields parameter is verplicht.

Rule: De Fields parameter mag maximaal 130 veld paden bevatten

Rule: De Fields parameter bevat het pad naar de op te vragen velden
  - zie fields-mapping.csv: wanneer een in fields opgegeven veld(pad) niet voorkomt in de linker kolom, geeft dat een foutmelding
  - velden worden gescheiden door een komma, zonder spatie

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
