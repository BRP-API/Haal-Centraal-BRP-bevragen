#language: nl

Functionaliteit: Zoek met geslachtsnaam en geboortedatum

    Achtergrond:
        Gegeven het systeem heeft personen met de volgende gegevens
        | burgerservicenummer | geslachtsaanduiding (04.10) |
        | 999995078           | M                           |
        | 999995079           | M                           |
        | 999995080           | M                           |
        | 999995081           | M                           |
        | 999995082           | M                           |
        | 999995083           | M                           |
        | 999995084           | V                           |
        | 999995085           | V                           |
        En het systeem heeft personen met de volgende geboorte gegevens
        | burgerservicenummer | datum    | plaats.omschrijving |
        | 999995078           | 19830526 | Noordwijk           |
        | 999995079           | 19830526 | Leiden              |
        | 999995080           | 19830526 | Katwijk             |
        | 999995081           | 19830526 | Lisse               |
        | 999995082           | 19830526 | Wassenaar           |
        | 999995083           | 19830526 |                     |
        | 999995084           | 19830526 |                     |
        | 999995085           | 19830526 |                     |
        En het systeem heeft de volgende naam gegevens
        | burgerservicenummer | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        | 999995078           | Maassen               | Pieter            |                     |
        | 999995079           | Groen                 |                   |                     |
        | 999995080           | Groot                 |                   |                     |
        | 999995081           | Jansen                |                   |                     |
        | 999995082           | Maassen               | Jan Peter         | van                 |
        | 999995083           | Groenlo               |                   |                     |
        | 999995084           | Aedel                 | Petra             | van den             |
        | 999995085           | Jansen                |                   |                     |
        En het systeem heeft de volgende overlijden gegevens
        | burgerservicenummer | datum    |
        | 999995085           | 20220301 |

Rule: Geslachtsnaam en geboortedatum zijn verplichte parameters
      Zoeken is niet hoofdlettergevoelig

    @gba
    Abstract Scenario: Zoek met volledige geslachtsnaam en geboortedatum

        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam>                     |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995078           |
        | 999995082           |

        Voorbeelden:
        | geslachtsnaam |
        | Maassen       |
        | maassen       |
        | MAASSEN       |

    @gba
    Abstract Scenario: Zoek met deel van geslachtsnaam en geboortedatum

        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                                                |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum                   |
        | geslachtsnaam | <geslachtsnaam>                                       |
        | geboortedatum | 1983-05-26                                            |
        | fields        | burgerservicenummer,geboorte.datum,naam.geslachtsnaam |
        Dan bevat de response geen personen 

        Voorbeelden:
        | geslachtsnaam |
        | Maas          |
        | jans          |
        | MAAS          |

    @gba
    Abstract Scenario: Zoek met volledige voornaam
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam>                     |
        | voornamen     | <voornamen>                         |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer   |
        | <burgerservicenummer> |

        Voorbeelden:
        | geslachtsnaam | voornamen | burgerservicenummer |
        | Maassen       | Pieter    | 999995078           |
        | maassen       | PIETER    | 999995078           |
        | MAASSEN       | pieter    | 999995078           |
        | maassen       | jan peter | 999995082           |

    @gba
    Abstract Scenario: Zoek met volledige voorvoegsel
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam>                     |
        | voorvoegsel   | <voorvoegsel>                       |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995082           |

        Voorbeelden:
        | geslachtsnaam | voorvoegsel |
        | Maassen       | van         |
        | maassen       | VAN         |
        | MAASSEN       | Van         |

    @gba
    Abstract Scenario: Zoek met geslachtsaanduiding
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                              |
        | type                | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam       | Aedel                               |
        | geslachtsaanduiding | <geslachtsaanduiding>               |
        | geboortedatum       | 1983-05-26                          |
        | fields              | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995084           |

        Voorbeelden:
        | geslachtsaanduiding |
        | v                   |
        | V                   |

    @gba
    Abstract Scenario: Zoek met geboorteplaats
        Als personen wordt gezocht met de volgende parameters
        | naam           | waarde                              |
        | type           | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam  | Maassen                             |
        | geboorteplaats | <geboorteplaats>                    |
        | geboortedatum  | 1983-05-26                          |
        | fields         | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995082           |

        Voorbeelden:
        | geboorteplaats |
        | Wassenaar      |
        | wassenaar      |
        | WASSENAAR      |

    @gba
    Scenario: Zoek met inclusiefOverledenPersonen
        Als personen wordt gezocht met de volgende parameters
        | naam                       | waarde                              |
        | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam              | Jansen                              |
        | inclusiefOverledenPersonen | true                                |
        | geboortedatum              | 1983-05-26                          |
        | fields                     | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995081           |
        | 999995085           |

    @fout-case
    Abstract Scenario: <titel>
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam>                     |
        | geboortedatum | <geboortedatum>                     |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                                                                                                                                                                                                                                         |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest                                                                                                                                                                                                                    |
        | title    | Minimale combinatie van parameters moet worden opgegeven.                                                                                                                                                                                                                                                                      |
        | status   | 400                                                                                                                                                                                                                                                                                                                            |
        | detail   | Combinatie van gevulde velden was niet correct. Geef waarde aan één van de volgende veld combinaties: burgerservicenummer of geboortedatum en geslachtsnaam of gemeenteVanInschrijving, voornamen en geslachtsnaam of postcode en huisnummer of straat, gemeenteVanInschrijving en huisnummer of nummeraanduidingIdentificatie |
        | code     | paramsCombination                                                                                                                                                                                                                                                                                                              |
        | instance | /personen                                                                                                                                                                                                                                                                                                                      |
        En bevat de response geen invalidParams

        Voorbeelden:
        | titel                                      | geboortedatum | geslachtsnaam |
        | Zoek zonder geslachtsnaam en geboortedatum |               |               |
        | Zoek met alleen valide geslachtsnaam       |               | maassen       |
        | Zoek met alleen valide geboortedatum       | 1983-05-26    |               |

    @fout-case
    Abstract Scenario: Zoek met invalide geboortedatum
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | Maassen                             |
        | geboortedatum | <geboortedatum>                     |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geboortedatum.                                                               |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code | name          | reason                        |
        | date | geboortedatum | Waarde is geen geldige datum. |

        Voorbeelden:
        | geboortedatum |
        | 19830526      |
        | 26 mei 1983   |

    @fout-case
    Abstract Scenario: <titel>
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam>                     |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geslachtsnaam.                                                               |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code   | name          | reason   |
        | <code> | geslachtsnaam | <reason> |

        Voorbeelden:
        | titel                                        | code      | reason                                    | geslachtsnaam                                                                                                                                                                                                       |
        | Geslachtsnaam is meer dan 200 karakters lang | maxLength | Waarde is langer dan maximale lengte 200. | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
        | Geslachtsnaam bevat ongeldige karakters      | pattern   | Waarde voldoet niet aan patroon TODO      | <script>alert('hello world');</script>                                                                                                                                                                              |

    @fout-case
    Scenario: Meerdere invalide parameters
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                                 |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum    |
        | geslachtsnaam | <script>alert('hello world');</script> |
        | geboortedatum | 19830526                               |
        | fields        | burgerservicenummer                    |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geboortedatum, geslachtsnaam.                                                |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code    | name          | reason                               |
        | pattern | geslachtsnaam | Waarde voldoet niet aan patroon TODO |
        | date    | geboortedatum | Waarde is geen geldige datum.        |

Rule: Bij zoeken met de "*" wildcard moet minimaal 2 letters (exclusief de wildcard teken) worden opgegeven
      De "*" wildcard komt overeen met nul of meer (niet-spatie) karakters

    @gba
    Abstract Scenario: Zoek met "*" wildcard als laatste karakter in geslachtsnaam
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995079           |
        | 999995080           |

        Voorbeelden:
        | geslachtsnaam filter |
        | gro*                 |
        | Gro*                 |
        | GRO*                 |

    @gba
    Abstract Scenario: Zoek met "*" wildcard als eerste karakter in geslachtsnaam
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995078           |
        | 999995081           |
        | 999995082           |

        Voorbeelden:
        | geslachtsnaam filter |
        | *sen                 |
        | *SEN                 |

    @gba
    Abstract Scenario: Zoek met "*" wildcard als eerste en laatste karakter in geslachtsnaam
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995079           |
        | 999995083           |

        Voorbeelden:
        | geslachtsnaam filter |
        | *oen*                |
        | *OEN*                |

    @gba
    Abstract Scenario: Zoek met "*" wildcard als laatste karakter in voornamen
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | maassen                             |
        | voornamen     | <voornamen filter>                  |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995082           |

        Voorbeelden:
        | voornamen filter |
        | Jan*             |
        | jan*             |
        | JAN*             |

    @fout-case
    Abstract Scenario: Zoek met "*" wildcard als eerste karakter in voornamen
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | maassen                             |
        | voornamen     | <voornamen filter>                  |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geslachtsnaam.                                                               |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code     | name      | reason                                     |
        | wildcard | voornamen | Incorrect gebruik van wildcard karakter *. |

        Voorbeelden:
        | voornamen filter |
        | *eter            |
        | *ETER            |

    @fout-case
    Abstract Scenario: geslachtsnaam met maximimaal één letter exclusief "*" wildcard karakter
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geslachtsnaam.                                                               |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code     | name          | reason                                     |
        | wildcard | geslachtsnaam | Incorrect gebruik van wildcard karakter *. |

        Voorbeelden:
        | geslachtsnaam filter |
        | *                    |
        | *n                   |
        | n*                   |
        | ***                  |

    @fout-case
    Abstract Scenario: De "*" wildcard karakter staat niet aan het begin en/of aan het eind van de geslachtsnaam zoekstring
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geslachtsnaam.                                                               |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code     | name          | reason                                     |
        | wildcard | geslachtsnaam | Incorrect gebruik van wildcard karakter *. |

        Voorbeelden:
        | geslachtsnaam filter |
        | *r*ot                |
        | gr*o*                |
        | gr*t                 |
        | gr**                 |

Rule: Bij zoeken met de "?" wildcard moet minimaal 2 letters (exclusief de wildcard teken) worden opgegeven
      De "?" wildcard mag meerdere keren achter elkaar voorkomen in een zoekstring
      De "?" wildcard komt overeen met één (niet-spatie) karakter

    @gba
    Abstract Scenario: Zoek (case insensitive) met "?" wildcard karakter in geslachtsnaam
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995083           |

        Voorbeelden:
        | geslachtsnaam filter |
        | groen??              |
        | Groen??              |
        | GROEN??              |
        | ??OENLO              |

    @fout-case
    Abstract Scenario: geslachtsnaam met maximimaal één letter exclusief "?" wildcard karakter
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geslachtsnaam.                                                               |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code     | name          | reason                                     |
        | wildcard | geslachtsnaam | Incorrect gebruik van wildcard karakter ?. |

        Voorbeelden:
        | geslachtsnaam filter |
        | ?                    |
        | ?n                   |
        | n?                   |
        | ???                  |

    @fout-case
    Abstract Scenario: De "?" wildcard karakter staat niet aan het begin en/of aan het eind van de geslachtsnaam zoekstring
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geslachtsnaam.                                                               |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code     | name          | reason                                     |
        | wildcard | geslachtsnaam | Incorrect gebruik van wildcard karakter ?. |

        Voorbeelden:
        | geslachtsnaam filter |
        | ?r?ot                |
        | gr?o?                |
        | gr?t                 |

    @fout-case:
    Abstract Scenario: Het aantal opgegeven "?" wildcard karakters achter elkaar is meer dan het toegestane maximum
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam filter>              |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                                                                                      |
        | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
        | title    | Een of meerdere parameters zijn niet correct.                                                               |
        | status   | 400                                                                                                         |
        | detail   | De foutieve parameter(s) zijn: geslachtsnaam.                                                               |
        | code     | paramsValidation                                                                                            |
        | instance | /personen                                                                                                   |
        En bevat de response een invalidParams met de volgende gegevens
        | code     | name          | reason                                     |
        | wildcard | geslachtsnaam | Incorrect gebruik van wildcard karakter ?. |

        Voorbeelden:
        | geslachtsnaam filter |
        | ??????rot            |
        | gro??????            |
        | ??????rot??????      |
