# language: nl

# Nederlandse API Strategie:
# API-09 Representatie op maat wordt ondersteund
# Het is mogelijk om een door komma's gescheiden lijst van attribuutnamen op te geven met de query-parameter fields om een representatie op maat te krijgen. Als niet-bestaande attribuutnamen worden meegegeven wordt een 400 Bad Request teruggegeven.

# Bij de BRP-Persoon-Bevragen API is het verplicht gesteld dat de gebruiker van de API exact aangeeft welke representatie van de resource in de response gewenst is. Om dit mogelijk te maken is de query-parameter fields verplicht. De query-parameter accepteert een door komma's gescheiden lijst met attribuutnamen. Het resultaat is een representatie op maat.

Functionaliteit: Aanpasbare representatie met de fields parameter
  Het is verplicht om een door komma's gescheiden lijst van attribuutnamen op te geven met de query-parameter fields om een representatie op maat te krijgen. Hierin kan elk attribuut van de resource worden opgenomen met exact de naam zoals deze wordt opgenomen in het antwoord.

  Wanneer de fields parameter niet wordt meegegeven in het request, wordt er een foutmelding geretourneerd.

  Gebruik van parameter fields zonder waarde (lege waarde) is equivalent aan het niet opnemen van de fields parameter. Wanneer de fields-parameter wordt opgenomen zonder waarde, wordt er een foutmelding geretourneerd.

  Wanneer in de fields-parameter namen zijn opgenomen die niet voorkomen als attribuut in de resource, wordt een foutmelding gegeven.

  In de fields-parameter moeten attribuutnamen exact zo worden geschreven als voor de resource-response gedefinieerd. Dit is case sensitive. Bijvoorbeeld fields=BURGERSERVICENUMMER levert een foutmelding, want dat attribuut bestaat niet (attribuut burgerservicenummer bestaat wel).

  De attributen van de resource die zijn genoemd in de fields parameter worden teruggeven indien ze een waarde hebben en de afnemer is geautoriseerd voor die attributen.
  Dus wanneer de gebruiker vraagt om gegevens waarvoor zij of hij niet geautoriseerd is, wordt er minder teruggegeven dan er gevraagd is in de fields-parameter.

  Wanneer het endpoint een collectie van resources teruggeeft, worden in fields de properties van de resource opgenomen. Bovenliggende berichtelementen die de collectie definieren worden hierbij niet opgenomen. Om bijvoorbeeld de straat en huisnummer te vragen in een collectie van adressen gaat met fields=straat,huisnummer. Dus niet met _embedded.adressen.straat,_embedded.adressen.huisnummer.

  Gevraagde attributen worden komma-gescheiden opgesomd. Bijvoorbeeld fields=burgerservicenummer,naam,geslachtsaanduiding.
  Gevraagde attributen kunnen in willekeurige volgorde worden opgenomen in de fields parameter. De volgorde waarin de gevraagde attributen worden opgesomd in de fields parameter heeft geen invloed op de volgorde waarin deze attributen worden opgenomen in het antwoord (volgorde is niet relevant in een json object).

  Groepen kunnen in gezamenlijkheid worden gevraagd door de naam van de groep op te nemen in de fields-parameter. In dat geval worden alle attributen van de groep opgenomen in het antwoord, voor zover ze een waarde hebben. Bijvoorbeeld fields=burgerservicenummer,naam geeft naast het burgerservicenummer alle attributen van de naam (geslachtsnaam, voornamen, voorvoegsel, enz.) terug.

  Attributen binnen een groep kunnen ook individueel worden bevraagd. De dot-notatie wordt gebruikt om specifieke attributen van een groep te selecteren. Bijvoorbeeld de voornamen, geboortedatum en geboorteplaats van een persoon kunnen worden opgevraagd via fields=naam.voornamen,geboorte.datum,geboorte.plaats. Daarnaast kunnen attributen in een groep worden opgevraagd door alleen de naam van de property op te geven, of een deel van het pad, niet het hele pad ervoor. Dit kan nuttig zijn om de lengte van de waarde in fields te beperken.

  Met de fields parameter kan een gevraagd veld worden aangeduid met:
  - het hele pad naar dat veld, bijvoorbeeld fields=verblijfplaats.datumAanvangAdreshouding.jaar
  - het laatste deel van het pad naar dat veld, bijvoorbeeld fields=datumAanvangAdreshouding.jaar
  - alleen de veldnaam, bijvoorbeeld fields=jaar

  Voor elk veld in fields moet dit leiden tot één uniek veld in de resource, ongeacht of dit veld bij de specifiek opgevraagde resource een waarde heeft. Bijvoorbeeld een persoon heeft geboorte.land en overlijden.land, dus is fields=land niet toegestaan. In dat geval wordt een foutmelding teruggegeven. In de foutmelding worden de gevonden velden teruggegeven in invalidParams.detail. Wanneer veel velden zijn gevonden (bijvoorbeeld meer dan 3), dan worden de eerste resultaten (bijv. de eerste 3 gevonden velden) gemeld.
  Wanneer een veld in fields exact zo voorkomt in de resource, maar ook zo voorkomt als einde van het pad naar een ander veld, dan wordt het veld teruggegeven die exact wordt aangeduid met wat in fields is opgenomen.

  De volgende velden worden geleverd ongeacht of de fields parameter is gebruikt en ongeacht de eventueel gevraagde velden in de fields parameter:
  - inOnderzoek wordt meegegeven wanneer gevraagde corresponderende velden in onderzoek zijn. Zie in_onderzoek.feature voor uitleg wanneer attributen in onderzoek zijn.
  - geheimhoudingPersoonsgegevens wordt altijd meegegeven wanneer deze de waarde true heeft.
  - opschortingBijhouding reden wordt altijd meegegeven wanneer deze een waarde heeft.

  Rule: De Fields parameter is verplicht.
    Scenario: Fields parameter ontbreekt
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999994086                       |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | Minimale combinatie van parameters moet worden opgegeven.                                                   |
      | status   | 400                                                                                                         |
      | detail   | De parameter fields mag niet leeg zijn.                                                                     |
      | code     | paramsCombination                                                                                           |
      | instance | /personen                                                                                                   |
      En heeft de response een invalidParams met de volgende gegevens
      | code     | name          | reason                  |
      | required | fields        | Parameter is verplicht. |

  Rule: De Fields parameter mag alleen valide en unieke attribuutnamen bevatten.
    Scenario: Fields parameter is leeg
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999994086                       |
      | fields              |                                 |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | Een of meerdere parameters zijn niet correct.                                                               |
      | status   | 400                                                                                                         |
      | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
      | code     | paramsValidation                                                                                            |
      | instance | /personen                                                                                                   |
      En heeft de response een invalidParams met de volgende gegevens
      | code     | name          | reason                                      |
      | pattern  | fields        | Waarde voldoet niet aan patroon {pattern}.  |

    Scenario: Fields parameter met attribuutnaam die niet bestaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 999994086                               |
      | fields              | burgerservicenummer,bestaatniet         |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | Een of meerdere parameters zijn niet correct.                                                               |
      | status   | 400                                                                                                         |
      | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
      | code     | paramsValidation                                                                                            |
      | instance | /personen                                                                                                   |
      En heeft de response een invalidParams met de volgende gegevens
      | code     | name          | reason                                           |
      | fields   | fields        | Parameter bevat een niet bestaande propertynaam. |

    Scenario: Fields parameter met attribuutnaam met onjuiste case
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                   |
      | type                | RaadpleegMetBurgerservicenummer          |
      | burgerservicenummer | 999994086                                |
      | fields              | BurgerServiceNummer,geslachtsaanduiding  |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | Een of meerdere parameters zijn niet correct.                                                               |
      | status   | 400                                                                                                         |
      | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
      | code     | paramsValidation                                                                                            |
      | instance | /personen                                                                                                   |
      En heeft de response een invalidParams met de volgende gegevens
      | code     | name          | reason                                                |
      | fields   | fields        | Parameter bevat een porpertynaam met onjuiste casing. |

  Rule: properties die met dezelfde naam in meerdere groepen voorkomen moeten met een .(dot)-notatie worden opgenomen in fields
    Scenario: opvragen property waarvan de naam in meerdere groepen voorkomt met .(dot)-notatie in de fields
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                                      | waarde   |
      | datum (01.03.10)                          | 19860401 |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                                      | waarde   |
      | datum (01.03.10)                          | 20151001 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                   |
      | type                | RaadpleegMetBurgerservicenummer          |
      | burgerservicenummer | 999994086                                |
      | fields              | burgerservicenummer,geboorte.datum       |
      Dan heeft de persoon met burgerservicenummer '999994086' volgende gegevens
      | naam                 | waarde      |
      | burgerservicenummer  | 999994086   |
      En heeft de persoon met burgerservicenummer '999994086' volgende 'geboorte' gegevens
      | naam        | waarde      |
      | datum.datum | 19860401    |
      | datum.type  | Datum       |

    Scenario: opvragen veld met fields door opgeven naam veld die meerdere keren voorkomt zonder .(dot)- notatie
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                                      | waarde   |
      | datum (01.03.10)                          | 19860401 |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                                      | waarde   |
      | datum (01.03.10)                          | 20151001 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                   |
      | type                | RaadpleegMetBurgerservicenummer          |
      | burgerservicenummer | 999994086                                |
      | fields              | datum                                    |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                                                      |
      | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
      | title    | Een of meerdere parameters zijn niet correct.                                                               |
      | status   | 400                                                                                                         |
      | detail   | De foutieve parameter(s) zijn: fields.                                                                      |
      | code     | paramsValidation                                                                                            |
      | instance | /personen                                                                                                   |
      En heeft de response een invalidParams[0] met de volgende gegevens
      | code     | name          | reason              |
      | fields   | fields        | Deel van de parameterwaarde niet correct: datum. Er zijn meerdere resultaten gevonden voor waarde: overlijden.datum, geboorte.datum  |

  Rule: properties die onderdeel uitmaken van een groep, maar wel een unieke propertynaam hebben mogen met alleen de propertynaam worden opgenomen in fields
    Scenario: opvragen veld met fields door opgeven hele pad naar het veld
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                      |
      | voornamen                 | Johannnes Geurt |
      | geslachtsnaam             | Janssen         |
      | aanduidingNaamgebruik     | E               |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                                      | waarde   |
      | datum.type                                | Datum    |
      | datum.datum (01.03.10)                    | 19860401 |
      | land.code                                 | 6030     |
      | plaats.code                               | 0518     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 999994086                                          |
      | fields              | geboorte.plaats.code                               |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende 'geboorte' gegevens
      | naam                 | waarde       |
      | geboorte.plaats.code | 0518         |
      En heeft de persoon GEEN andere properties

    Scenario: opvragen veld met fields door opgeven laatste deel van het pad naar het veld
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                      |
      | voornamen                 | Johannnes Geurt |
      | geslachtsnaam             | Janssen         |
      | aanduidingNaamgebruik     | E               |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                                      | waarde   |
      | datum (01.03.10)                          | 19860401 |
      | land                                      | 6030     |
      | plaats                                    | 0518     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                             |
      | type                | RaadpleegMetBurgerservicenummer                    |
      | burgerservicenummer | 999994086                                          |
      | fields              | plaats.code |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende 'geboorte' gegevens
      | naam        | waarde       |
      | plaats.code | 0518         |
      En heeft de response GEEN andere properties

  Rule: De response bevat alleen de properties die in de fields parameter gevraagd.
    Scenario: Slechts één enkel attribuut wordt gevraagd
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999994086                       |
      | fields              | geslachtsaanduiding             |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende gegevens
      | naam                | waarde |
      | geslachtsaanduiding | 'M'    |
      En heeft de response GEEN andere properties

    Scenario: Meerdere attributen worden gevraagd
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 999994086                               |
      | fields              | burgerservicenummer,geslachtsaanduiding |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding |  M        |
      En heeft de response GEEN andere properties

    Scenario: Hele groep wordt gevraagd
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende naam gegevens
      | naam                      |
      | voornamen                 | Johannnes Geurt |
      | geslachtsnaam             | Janssen         |
      | aanduidingNaamgebruik     | E               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 999994086                               |
      | fields              | burgerservicenummer,naam                |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende gegevens
      | naam                       | waarde          |
      | burgerservicenummer        | 999994086       |
      En heeft de persoon met burgerservicenummer '999994086' de volgende 'naam' gegevens
      | voornamen             | Johannnes Geurt |
      | geslachtsnaam         | Janssen         |
      | aanduidingNaamgebruik | E               |
      En heeft de response GEEN andere properties

    Scenario: Een of enkele attributen binnen een groep worden gevraagd
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende naam gegevens
      | naam                      | waarde          |
      | voornamen                 | Johannnes Geurt |
      | geslachtsnaam             | Janssen         |
      | aanduidingNaamgebruik     | E               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 999994086                               |
      | fields              | burgerservicenummer,naam.voornamen,naam.aanduidingNaamgebruik |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende gegevens
      | naam                       | waarde          |
      | burgerservicenummer        | 999994086       |
      En heeft de persoon met burgerservicenummer '999994086' de volgende 'naam' gegevens
      | naam                  | waarde          |
      | voornamen             | Johannnes Geurt |
      | aanduidingNaamgebruik | E               |
      En heeft de response GEEN andere properties

    Scenario: Fields bevat attributen die bij de geraadpleegde persoon geen waarde hebben
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende naam gegevens
      | naam                      |
      | voornamen                 | Franklin |
      | geslachtsnaam             | Groenen  |
      | aanduidingNaamgebruik     | E               |
      En de persoon heeft de volgende geboorte gegevens
      | naam                                | waarde   |
      | datum (01.03.10)                    | 19860401 |
      | land                                |          |
      | plaats                              | 0518     |
      En de waardetabel 'Gemeenten' heeft de volgende waarden
      | code | omschrijving  |
      | 0518 | 's-Gravenhage |
      En de waardetabel 'Landen' heeft de volgende waarden
      | code | omschrijving |
      | 6030 | Nederland    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                              |
      | type                | RaadpleegMetBurgerservicenummer                     |
      | burgerservicenummer | 999992934                                           |
      | fields              | burgerservicenummer,geboorte.plaats,geboorte.land   |
      Dan heeft de persoon met burgerservicenummer '999992934' de volgende gegevens
      | naam                 | waarde       |
      | burgerservicenummer  | 999992934    |
      En heeft de persoon met burgerservicenummer '999992934' de volgende 'geboorte' gegevens
      | naam                | waarde        |
      | plaats.code         | 0518          |
      | plaats.omschrijving | 's-Gravenhage |
      En heeft de response GEEN andere properties

    Scenario: gebruik fields als de response meerdere resources in een collectie retourneert.
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende naam gegevens
      | naam                      |
      | voornamen                 | Franklin |
      | geslachtsnaam             | Groenen  |
      | aanduidingNaamgebruik     | E               |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                                      | waarde   |
      | postcode                                  | 3552RA   |
      | huisnummer                                | 35       |
      En het systeem heeft een persoon met de volgende gegevens
      | burgerservicenummer | 999994086 |
      | geslachtsaanduiding | M         |
      En de persoon heeft de volgende naam gegevens
      | naam                      |
      | voornamen                 | Johannnes Geurt |
      | geslachtsnaam             | Janssen         |
      | aanduidingNaamgebruik     | E               |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                                      | waarde   |
      | postcode                                  | 3552RA   |
      | huisnummer                                | 35       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                              |
      | type                | RaadpleegMetPostcodeEnHuisnummer                    |
      | postcode            | 3552RA                                              |
      | huisnummer          | 35                                                  |
      | fields              | burgerservicenummer,naam.geslachtsnaam              |
      Dan heeft de persoon met burgerservicenummer '999992934' de volgende gegevens
      | naam                | waarde               |
      | burgerservicenummer | 999992934            |
      En heeft de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                | waarde               |
      | geslachtsnaam       | Groenen              |
      En heeft de persoon met burgerservicenummer '999994086' de volgende gegevens
      | naam                | waarde               |
      | burgerservicenummer | 999994086            |
      En heeft de persoon met burgerservicenummer '999994086' de volgende 'naam' gegevens
      | naam                | waarde               |
      | geslachtsnaam       | Janssen              |
      En heeft de response GEEN andere properties

  Rule: De volgende velden worden geleverd ongeacht de eventueel gevraagde velden in de fields parameter:
    - inOnderzoek wordt meegegeven wanneer gevraagde corresponderende velden in onderzoek zijn. Zie in_onderzoek.feature voor uitleg wanneer attributen in onderzoek zijn.
    - geheimhoudingPersoonsgegevens wordt altijd meegegeven wanneer deze de waarde true heeft.
    - opschortingBijhouding reden wordt altijd meegegeven wanneer deze een waarde heeft.
    - type wordt meegeleverd als er voor een gevraagde property sprake is van polymorfie

    Scenario: geboortedatum is in onderzoek en geboorte wordt gevraagd met de fields parameter
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      En de persoon heeft de volgende geboorte gegevens
      | naam                                      | waarde   |
      | datum (01.03.10)                          | 19860401 |
      | land                                      | 6030     |
      | plaats                                    | 0518     |
      | inOnderzoek.datum                         | 20200601 |
      En de waardetabel 'Gemeenten' heeft de volgende waarden
      | code | omschrijving  |
      | 0518 | 's-Gravenhage |
      En de waardetabel 'Landen' heeft de volgende waarden
      | code | omschrijving |
      | 6030 | Nederland    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999994086                       |
      | fields              | geboorte                        |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende 'geboorte' gegevens
      | naam                                   | waarde        |
      | datum.type                             | Datum         |
      | datum.datum                            | 1986-04-01    |
      | land.code                              | 6030          |
      | land.omschrijving                      | Nederland     |
      | plaats.code                            | 0518          |
      | plaats.omschrijving                    | 's-Gravenhage |
      | inOnderzoek.datumIngangOnderzoek.datum | 2020-06-01    |
      | inOnderzoek.datumIngangOnderzoek.type  | Datum         |
      | inOnderzoek.datum                      | true          |
      | inOnderzoek.land                       |               |
      | inOnderzoek.plaats                     |               |
      En heeft de response GEEN andere properties

    Scenario: geboortedatum is in onderzoek en geboortedatum wordt gevraagd met de fields parameter
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      En de persoon heeft de volgende geboorte gegevens
      | naam                                      | waarde   |
      | datum (01.03.10)                          | 19860401 |
      | land                                      | 6030     |
      | plaats                                    | 0518     |
      | inOnderzoek.datum                         | 20200601 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999994086                       |
      | fields              | geboorte.datum                  |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende 'geboorte' gegevens
      | naam                                   | waarde     |
      | datum.type                             | Datum      |
      | datum.datum                            | 1986-04-01 |
      | inOnderzoek.datumIngangOnderzoek.datum | 2020-06-01 |
      | inOnderzoek.datumIngangOnderzoek.type  | Datum      |
      | inOnderzoek.datum                      | true       |
      En heeft de response GEEN andere properties

    Scenario: geboortedatum is in onderzoek en een ander gegeven in de gegevens groep wordt gevraagd met de fields parameter
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999994086 |
      En de persoon heeft de volgende geboorte gegevens
      | naam                                      | waarde   |
      | datum (01.03.10)                          | 19860401 |
      | land                                      | 6030     |
      | plaats                                    | 0518     |
      | inOnderzoek.datum                         | 20200601 |
      En de waardetabel 'Gemeenten' heeft de volgende waarden
      | code | omschrijving  |
      | 0518 | 's-Gravenhage |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999994086                       |
      | fields              | geboorte.plaats                 |
      Dan heeft de persoon met burgerservicenummer '999994086' de volgende 'geboorte' gegevens
      | naam                | waarde        |
      | plaats.code         | 0518          |
      | plaats.omschrijving | 's-Gravenhage |
      En bevat de persoon met burgerservicenummer '999994086' de volgende 'geboorte' gegevens NIET
      | naam        |
      | inOnderzoek |
      En heeft de response GEEN andere properties

    Scenario: persoon heeft geheimhouding en andere gegevens wordt gevraagd met de fields parameter
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 999993483 |
      | geheimhoudingPersoonsgegevens | 7         |
      En de persoon heeft de volgende geboorte gegevens
      | naam        | waarde |
      | plaats      | 0518   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993483                       |
      | fields              | geboorte.plaats                 |
      Dan heeft de persoon met burgerservicenummer '999993483' de volgende gegevens
      | naam                          | waarde |
      | geheimhoudingPersoonsgegevens | true   |

    Scenario: persoon heeft opschorting bijhouding en andere gegevens wordt gevraagd met de fields parameter
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992077 |
      En de persoon heeft de volgende geboorte gegevens
      | naam        | waarde |
      | plaats.code | 0518   |
      En de persoon heeft de volgende overlijden gegevens
      | naam               | waarde   |
      | indicatieOverleden | true     |
      | datum              | 20151001 |
      | land               | 6030     |
      | plaats             | 0344     |
      En de persoon heeft de volgende opschortingBijhouding gegevens
      | naam       | waarde     |
      | reden.code | overlijden |
      | datum      | 20151001   |
      En de waardetabel 'Gemeenten' heeft de volgende waarden
      | code | omschrijving  |
      | 0518 | 's-Gravenhage |
      | 0344 | Utrecht
      En de waardetabel 'Landen' heeft de volgende waarden
      | code | omschrijving |
      | 6030 | Nederland    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992077                       |
      | fields              | geboorte.plaats                 |
      Dan heeft persoon met burgerservicenummer '999992077' de volgende 'geboorte' gegevens
      | naam                | waarde        |
      | plaats.code         | 0518          |
      | plaats.omschrijving | 's-Gravenhage |
      En bevat de persoon met burgerservicenummer '999992077' de volgende 'opschortingBijhouding' gegevens
      | naam              | waarde     |
      | reden.code        | overlijden |
      En heeft de persoon met burgerservicenummer '999992077' GEEN 'overlijden' gegevens

  Rule: Als properties uit een gegevensgroepen van een bepaald type worden gevraagd, maar er worden een ander type geleverd wordt van de gorpe alleen het type geleverd.
    Scenario: persoon heeft geboortedatum onbekend en de property geboortedatum wordt gevraagd.
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992077 |
      En de persoon heeft volgende geboorte gegevens
      | naam               | waarde   |
      | datum              | 00000000 |
      | land               | 6030     |
      | plaats             | 0518     |
      En de waardetabel 'Gemeenten' heeft de volgende waarden
      | code | omschrijving  |
      | 0518 | 's-Gravenhage |
      En de waardetabel 'Landen' heeft de volgende waarden
      | code | omschrijving |
      | 6030 | Nederland    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992077                       |
      | fields              | geboorte.datum.datum            |
      Dan heeft persoon met burgerservicenummer '999992077' de volgende 'geboorte' gegevens
      | naam                | waarde        |
      | type                | OnbekendDatum |
      En heeft de response GEEN andere properties
