# language: nl

Functionaliteit: autorisatie voor het gebruik van de API

  Achtergrond:
    Gegeven de gebruiker is geautoriseerd voor alleen de volgende velden  
      | naam                                         | elementnummer |
      | burgerservicenummer                          | 01.01.20      |
      | naam.voornamen                               | 01.02.10      |
      | naam.voorvoegsel                             | 01.02.30      |
      | naam.geslachtsnaam                           | 01.02.40      |
      | geboorte.datum                               | 01.03.10      |
      | verblijfplaats.gemeenteVanInschrijving       | 08.09.10      |
      | verblijfplaats.korteNaam                     | 08.11.10      |
      | verblijfplaats.straat                        | 08.11.15      |
      | verblijfplaats.huisnummer                    | 08.11.20      |
      | verblijfplaats.postcode                      | 08.11.60      |
      | verblijfplaats.nummeraanduidingIdentificatie | 08.11.90      |

  Rule: Een parameter mag alleen worden gebruikt bij zoeken wanneer de gebruiker voor dit gegeven geautoriseerd is

    Scenario: gebruik van een parameter waarvoor de gebruiker niet geautoriseerd is
      Als personen wordt gezocht met de volgende parameters
      | naam           | waarde                                            |
      | type           | ZoekMetGeslachtsnaamEnGeboortedatum               |
      | geslachtsnaam  | vries                                             |
      | geboortedatum  | 1964-09-24                                        |
      | geboorteplaats | Utrecht                                           |
      | fields         | burgerservicenummer,naam.voornamen,geboorte.datum |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                                   |
      | status   | 403                                                                                                         |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): geboorteplaats.                                |
      | code     | unauthorizedParameter                                                                                       |
      | instance | /haalcentraal/api/brp/personen                                                                              |

    Scenario: gebruik van meerdere parameters waarvoor de gebruiker niet geautoriseerd is
      Als personen wordt gezocht met de volgende parameters
      | naam                 | waarde                                            |
      | type                 | ZoekMetPostcodeEnHuisnummer                       |
      | postcode             | 1234AB                                            |
      | huisnummer           | 123                                               |
      | huisletter           | a                                                 |
      | huisnummertoevoeging | bis                                               |
      | fields               | burgerservicenummer,naam.voornamen,geboorte.datum |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                                   |
      | status   | 403                                                                                                         |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): huisletter,huisnummertoevoeging.               |
      | code     | unauthorizedParameter                                                                                       |
      | instance | /haalcentraal/api/brp/personen                                                                              |
      
  Rule: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven

    Scenario: Fields vraagt specifiek om een veld waarvoor deze niet geautoriseerd is
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                           |
      | type                | RaadpleegMetBurgerservicenummer                                  |
      | burgerservicenummer | 555555021                                                        |
      | fields              | burgerservicenummer,naam.voornamen,geboorte.plaats,geboorte.land |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | U bent niet geautoriseerd voor de in fields gevraagde gegevens.                                             |
      | status   | 403                                                                                                         |
      | detail   | U bent niet geautoriseerd voor: geboorte.plaats,geboorte.land.                                              |
      | code     | unauthorizedFields                                                                                          |
      | instance | /haalcentraal/api/brp/personen                                                                              |

    Scenario: Fields vraagt om een gegevensgroep en de gebruiker is niet geautoriseerd voor alle velden in deze gegevensgroep
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                      |
      | type                | RaadpleegMetBurgerservicenummer             |
      | burgerservicenummer | 555555021                                   |
      | fields              | burgerservicenummer,naam.voornamen,geboorte |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | U bent niet geautoriseerd voor de in fields gevraagde gegevens.                                             |
      | status   | 403                                                                                                         |
      | detail   | U bent niet geautoriseerd voor: geboorte.plaats,geboorte.land.                                              |
      | code     | unauthorizedFields                                                                                          |
      | instance | /haalcentraal/api/brp/personen                                                                              |


  @gba
  Rule: Wanneer de gebruiker niet geautoriseerd is voor adresvragen (35.95.66 is ongelijk aan "1") dan moet bij zoeken ten minste één van de parameters burgerservicenummer, geslachtsnaam, geboortedatum en/of postcode gebruikt worden
    Wanneer er geen autorisatie is voor adresvragen, zijn de volgende zoekpaden niet toegestaan:
    - ZoekMetNummeraanduidingIdentificatie
    - ZoekMetStraatHuisnummerEnGemeenteVanInschrijving

    # is verbieden van ZoekMetNummeraanduidingIdentificatie terecht? Een nummeraanduiding is een code voor combinatie postcode + huisnummer

    @gba
    Abstract Scenario: <type> zoeken zonder adresvraagbevoegdheid
      Gegeven in autorisatietabel van de gebruiker heeft Adresvraagbevoegdheid (35.95.66) de waarde "0"
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                                            |
      | type                          | <type>                                            |
      | nummeraanduidingIdentificatie | <nummeraanduidingIdentificatie>                   |
      | gemeenteVanInschrijving       | <gemeenteVanInschrijving>                         |
      | straat                        | <straat>                                          |
      | huisnummer                    | <huisnummer>                                      |
      | fields                        | burgerservicenummer,naam.voornamen,geboorte.datum |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | U bent niet geautoriseerd voor het gebruikte zoektype.                                                      |
      | status   | 403                                                                                                         |
      | detail   | U bent niet geautoriseerd voor zoektype: <type>.                                                            |
      | code     | unauthorizedFields                                                                                          |
      | instance | /haalcentraal/api/brp/personen                                                                              |

      Voorbeelden:
      | type                                             | nummeraanduidingIdentificatie | gemeenteVanInschrijving | straat | huisnummer |
      | ZoekMetNummeraanduidingIdentificatie             | 0518200000366054              |                         |        |            |
      | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |                               | 0519                    | Spuit  | 70         |