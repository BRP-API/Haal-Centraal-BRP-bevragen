#language: nl

Functionaliteit: Gezag Persoon Beperkt: adresregel velden in onderzoek

    Abstract Scenario: '<type>' is in onderzoek en alle adresregel velden worden gevraagd
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0599010051001502                         |
      En de persoon met burgerservicenummer '000000188' is ingeschreven op het adres met de volgende gegevens
      | naam                                     | waarde                    |
      | aanduiding in onderzoek (83.10)          | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                                                                   |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie                                                  |
      | adresseerbaarObjectIdentificatie | 0599010051001502                                                                         |
      | fields                           | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon met de volgende 'adressering' gegevens
      | naam                                                       | waarde           |
      | inOnderzoek.adresregel1                                    | <adresregel1 io> |
      | inOnderzoek.adresregel2                                    | <adresregel2 io> |
      | inOnderzoek.adresregel3                                    | <adresregel3 io> |
      | inOnderzoek.land                                           | <land io>        |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum            |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01       |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002      |

      Voorbeelden:
      | aanduiding in onderzoek | adresregel1 io | adresregel2 io | adresregel3 io | land io | type                          |
      | 080000                  | true           | true           | true           | true    | hele categorie verblijfplaats |
      | 080900                  |                | true           |                |         | hele groep gemeente           |
      | 080910                  |                | true           |                |         | gemeente van inschrijving     |
      | 081100                  | true           | true           |                |         | hele groep adres              |
      | 081110                  | true           |                |                |         | straatnaam                    |
      | 081120                  | true           |                |                |         | huisnummer                    |
      | 081130                  | true           |                |                |         | huisletter                    |
      | 081140                  | true           |                |                |         | huinummertoevoeging           |
      | 081150                  | true           |                |                |         | aanduiding bij huisnummer     |
      | 081160                  |                | true           |                |         | postcode                      |
      | 081170                  |                | true           |                |         | woonplaatsnaam                |
      | 081200                  | true           |                |                |         | hele groep locatie            |
      | 081210                  | true           |                |                |         | locatiebeschrijving           |
      | 081300                  | true           | true           | true           | true    | hele groep adres buitenland   |
      | 081310                  |                |                |                | true    | land adres buitenland         |
      | 081330                  | true           |                |                |         | regel 1 adres buitenland      |
      | 081340                  |                | true           |                |         | regel 2 adres buitenland      |
      | 081350                  |                |                | true           |         | regel 3 adres buitenland      |

    Abstract Scenario: '<type>' is in onderzoek en alle adresregel velden worden gevraagd
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0599010051001502                         |
      En de persoon met burgerservicenummer '000000188' is ingeschreven op het adres met de volgende gegevens
      | naam                                     | waarde                    |
      | aanduiding in onderzoek (83.10)          | <aanduiding in onderzoek> |
      | datum ingang onderzoek (83.20)           | 20020701                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                                                                   |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie                                                  |
      | adresseerbaarObjectIdentificatie | 0599010051001502                                                                         |
      | fields                           | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon zonder gegevens

      Voorbeelden:
      | aanduiding in onderzoek | type                               |
      | 080920                  | datum inschrijving                 |
      | 081000                  | hele groep adreshouding            |
      | 081010                  | functie adres                      |
      | 081030                  | datum aanvang adreshouding         |
      | 081115                  | naam openbare ruimte               |
      | 081180                  | identificatiecode verblijfplaats   |
      | 081190                  | identificatiecode nummeraanduiding |
      | 081320                  | datum aanvang adres buitenland     |
      | 081400                  | hele groep immigratie              |
      | 081410                  | land vanwaar ingeschreven          |
      | 081420                  | datum vestiging in Nederland       |
      | 088500                  | hele groep geldigheid              |
      | 088510                  | datum ingang geldigheid            |
