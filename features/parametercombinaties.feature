# language: nl

Functionaliteit: personen kunnen worden gezocht met bepaalde combinaties van parameters
  In de specificatie van deze operatie is een aantal mogelijke paramters gedefinieerd. Zie de [Open API](specificaties https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/openapi.yaml) of [Swagger](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/master/api-specificatie/openapi.yaml#/ingeschrevennatuurlijkpersonen/ingeschrevennatuurlijkpersonen).

  Er mag niet gezocht worden zonder zoekparamters.
  Bij het zoeken moet ten minste één van de volgende combinaties van parameters aanwezig zijn.
  - geslachtsnaam + geboortedatum
  - geslachtsnaam + gemeentevaninschrijving
  - burgerservicenummer
  - postcode + huisnummer
  - gemeentevaninschrijving + openbareruimtenaam + huisnummer
  - identificatiecodenummeraanduiding

  Het is mogelijk bovenop deze parameters alle toegestane parameters te gebruiken om de zoekresultaten verder in te perken.

  Wanneer een parameter wordt gebruikt die niet in de API specificatie is gedefinieerd, levert dit een foutmelding.

  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Scenario: Er kan niet gezocht worden zonder zoekparameters
    Als ingeschreven personen gezocht worden zonder parameters
    Dan levert dit een foutmelding

  Abstract Scenario: Er kan gezocht worden op minimale combinaties van zoekparamters + optioneel andere zoekparameters
    Als ingeschreven personen gezocht worden met <voorbeeld>
    Dan is het resultaat <resultaat>

    Voorbeelden: minimale combinaties van zoekparameters
      | Situatie | geslachtsnaam | voornamen | geboortedatum | geboorteplaats | geslachtsaanduiding | gemeentevaninschrijving | naamopenbareruimte | huisnummer | huisletter | huisnummertoevoeging | postcode | identificatiecodenummeraanduiding | burgerservicenummer | resultaat | voorbeeld |
      | geslachtsnaam+geboortedatum                               | Ja  |  -  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | zoekresultaten  | ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26 |
      | geslachtsnaam+geboortedatum+optionele parameter           | Ja  | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | zoekresultaten  | ?naam__geslachtsnaam=groen&naam__voornamen=frank&geboorte__datum=1983-05-26 |
      | geslachtsnaam+gemeentevaninschrijving                     | Ja  |  -  |  -  |  -  |  -  |  Ja |  -  |  -  |  -  |  -  |  -  |  -  |  -  | zoekresultaten  | ?naam__geslachtsnaam=groen&&verblijfplaats__gemeentevaninschrijving=0014 |
      | alle naam en geboorte parameters                          | Ja  | Ja  | Ja  | Ja  | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | zoekresultaten  | ?naam__geslachtsnaam=groen&naam__voornamen=frank&geboorte__datum=1983-05-26&geboorte__plaats=Sas%20van%20Gent&geslachtsaanduiding=M&verblijfplaats__gemeentevaninschrijving=0014 |
      | geslachtsnaam+geboortedatum + gedeelte andere combinatie  | Ja  |  -  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  |  -  |  -  | zoekresultaten  | ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&verblijfplaats__postcode=9744CZ |
      | meerdere minimale combinaties in één aanroep              | Ja  |  -  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  |  -  | zoekresultaten  | ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&verblijfplaats__identificatiecodenummeraanduiding=0704019876543210 |
      | meerdere min. combinaties gedeeltelijk                    | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  |  -  |  -  | een foutmelding | ?naam__geslachtsnaam=groen&naam__voornamen=frank&verblijfplaats__postcode=9744CZ |
      | alle optionele + gedeeltelijk min. combinaties            | Ja  | Ja  |  -  | Ja  | Ja  | Ja  | Ja  |  -  | Ja  | Ja  | Ja  |  -  |  -  | een foutmelding | ?naam__geslachtsnaam=groenlo&naam__voornamen=franka&geboorte__plaats=delft&geslachtsaanduiding=V&verblijfplaats__gemeentevaninschrijving=0503&verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat&verblijfplaats__huisletter=A&verblijfplaats__huisnummertoevoeging=to&verblijfplaats__postcode=2628HJ |
      | postcode+huisnummer                                       |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  |  -  |  -  | Ja  |  -  |  -  | zoekresultaten  | ?verblijfplaats__huisnummer=2&verblijfplaats__postcode=2628HJ |
      | postcode+huisnummer + optionele parameters                |  -  | Ja  | Ja  | Ja  | Ja  | Ja  |  -  | Ja  | Ja  | Ja  | Ja  |  -  |  -  | zoekresultaten  | ?naam__voornamen=franka&geboorte__datum=1983-05-26&geboorte__plaats=delft&geslachtsaanduiding=V&verblijfplaats__gemeentevaninschrijving=0503&verblijfplaats__huisnummer=2&verblijfplaats__huisletter=A&verblijfplaats__huisnummertoevoeging=to&verblijfplaats__postcode=2628HJ |
      | overlappende zoekparameters op verblijfplaats             |  -  |  -  |  -  |  -  |  -  | Ja  | Ja  | Ja  |  -  |  -  | Ja  | Ja  |  -  | zoekresultaten  | ?verblijfplaats__gemeentevaninschrijving=0503&verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat&verblijfplaats__huisnummer=2&verblijfplaats__postcode=2628HJ&verblijfplaats__identificatiecodenummeraanduiding=893675839595730 |
      | strijdige zoekparameters op verblijfplaats                |  -  |  -  |  -  |  -  |  -  | Ja  | Ja  | Ja  |  -  |  -  | Ja  | Ja  |  -  | zoekresultaten  | ?verblijfplaats__gemeentevaninschrijving=0503&verblijfplaats__naamopenbareruimte=Beethovenlaan&verblijfplaats__huisnummer=2&verblijfplaats__postcode=2628HJ&verblijfplaats__identificatiecodenummeraanduiding=704019876543210 |
      | gemeentevaninschrijving + openbareruimtenaam + huisnummer |  -  |  -  |  -  |  -  |  -  | Ja  | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  | zoekresultaten  | ?verblijfplaats__gemeentevaninschrijving=0503&verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat&verblijfplaats__huisnummer=2 |
      | verblijfplaats zonder huisnummer                          |  -  |  -  |  -  |  -  |  -  | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  |  -  | een foutmelding | ?verblijfplaats__gemeentevaninschrijving=0503&verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat |
      | verblijfplaats zonder openbareruimtenaam                  |  -  |  -  |  -  |  -  |  -  | Ja  |  -  | Ja  |  -  |  -  |  -  |  -  |  -  | een foutmelding | ?verblijfplaats__gemeentevaninschrijving=0503&verblijfplaats__huisnummer=2  |
      | verblijfplaats zonder gemeentevaninschrijving             |  -  |  -  |  -  |  -  |  -  |  -  | Ja  | Ja  |  -  |  -  |  -  |  -  |  -  | een foutmelding | ?verblijfplaats__naamopenbareruimte=Sint%20Aldegondestraat&verblijfplaats__huisnummer=2 |
      | identificatiecodenummeraanduiding                         |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  |  -  | een foutmelding | ?verblijfplaats__identificatiecodenummeraanduiding=0704019876543210 |
      | burgerservicenummer                                       |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  | Ja  | zoekresultaten  | ?burgerservicenummer=999999011 |


  Scenario: een parameter in een combinatie die leeg is of waarde null wordt beschouwd als niet opgegeven
    # Geen parameter geboorte__datum
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&naam__voornamen=frank
    Dan levert dit een foutmelding
    # Parameter geboorte__datum is leeg
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=&naam__voornamen=frank
    Dan levert dit een foutmelding
    # Parameter geboorte__datum is null
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=null&naam__voornamen=frank
    Dan levert dit een foutmelding

  Scenario: Wanneer een parameter wordt gebruikt die niet in de API specificatie is gedefinieerd, levert dit een foutmelding.
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&naam__voornamen=frank&burgerlijkeStaat=1
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter burgerlijkeStaat
