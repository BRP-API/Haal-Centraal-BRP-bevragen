Functionaliteit: historie wordt gesorteerd op geldigheid met meest actuele bovenaan
  Bij het ophalen van de historie worden de historische voorkomens aflopend teruggegeven op volgorde van geldigVan. De meest recente registratie staat dan bovenaan, de oudste situatie staat onderaan.

  Bij het zoeken van bewoningen worden de gevonden adressen niet gesorteerd teruggegeven. Binnen elk adres worden de bewoners aflopend gesorteerd, wanneer deze door gebruik van de [expand](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/expand.feature)-parameter zijn meegeladen met de resource.
  Bewoners worden aflopend gesorteerd op geldigVan, vervolgens aflopend op geldigTotEnMet.
  Wanneer geldigTotEnMet niet gevuld is, komt dit boven andere bewoners met dezelfde geldigVan en wel geldigTotEnMet gevuld.

  Achtergrond:
    Gegeven deze ingeschreven persoon staat vanaf 2013-05-01 ingeschreven met de volgende gegevens:
      | Attribuut              | Waarde     |
      | ---------------------- | ---------- |
      | burgerservicenummer    | 999999230  |
      | naamOpenbareRuimte     | Voorstraat |
      | verblijfstitelNumeriek | 21         |
      | burgerlijkeStaat       | 2          |
      | voornamen              | Pieterjan  |
      | indicatieGeheim        | 0          |
      | partner                | 999999345  |
      | verblijfstitel         | 23         |

    En een ingeschreven persoon kent de volgende historie in de registratie:
      | Gebeurtenis          | Datum      | Gewijzigd attribuut    | Nieuwe waarde  |
      | -------------------- | ---------- | ---------------------- |--------------- |
      | verhuizing           | 2014-03-01 | naamOpenbareRuimte     | Kerkstraat     |
      | verblijfstitel       | 2014-09-17 | verblijfstitelNumeriek | 25             |
      | gescheiden           | 2015-05-12 | partner.geldigTotEnMet | 2015-05-12     |
      | naamswijziging       | 2016-10-09 | voornamen              | Pieter Jan     |
      | verhuizing           | 2017-09-09 | naamOpenbareRuimte     | Loosduinsekade |
      | huwelijk             | 2018-02-09 | partner                | 999999242      |
      | indicatie geheim     | 2018-10-10 | indicatieGeheim        | 1              |

  Scenario: partnerhistorie wordt aflopend gesorteerd op geldigVan
    Als de partnerhistorie van ingeschreven persoon 999999230 wordt geraadpleegd vanaf 2014-01-01
    Dan worden er 2 partners teruggegeven
    En heeft de 1e partner burgerservicenummer 555555112 en geldigVan 2018-02-09
    En heeft de 2e partner burgerservicenummer 999999308 en geldigTotEnMet 2015-05-12

  Scenario: verblijfplaatshistorie wordt aflopend gesorteerd op geldigVan
    Als de verblijfplaatshistorie van ingeschreven persoon 999999230 wordt geraadpleegd vanaf 2014-01-01
    Dan worden er 3 verblijfplaatsen teruggegeven
    En heeft de 1e verblijfplaats naamOpenbareRuimte Loosduinsekade en geldigVan 2017-09-09
    En heeft de 2e verblijfplaats naamOpenbareRuimte Kerkstraat en geldigVan 2014-03-01
    En heeft de 3e verblijfplaats naamOpenbareRuimte Voorstraat en geldigVan 2013-05-01

  Scenario: verblijfstitelhistorie wordt aflopend gesorteerd op geldigVan
    Als de verblijfplaatshistorie van ingeschreven persoon 999999230 wordt geraadpleegd vanaf 2014-01-01
    Dan worden er 2 verblijfstitels teruggegeven
    En heeft de 1e verblijfstitel verblijfstitelNumeriek 25 en geldigVan 2014-09-17
    En heeft de 2e verblijfstitel verblijfstitelNumeriek 23 en geldigVan 2013-05-01

  Scenario: bij bewoningen worden de bewoners aflopend gesorteerd op geldigVan
    Gegeven de volgende personen hebben postcode 2595AK en huisnummer 21 als verblijfplaats:
      | burgerservicenummer | geldigVan  | geldigTotEnMet |
      | ------------------- | ---------- | -------------- |
      | 999999047           | 2013-05-01 | 2017-11-30     |
      | 999999059           | 2013-05-01 | null           |
      | 999999060           | 2017-05-16 | null           |
      | 999999345           | 2017-05-16 | 2017-07-31     |

    Als de bewoningen wordt gezocht op postcode 2595AK en huisnummer 21 vanaf 2017-01-01
    Dan worden er 4 bewoners teruggegeven
    En heeft de 1e bewoner burgerservicenummer 999999060 en geldigVan 2017-05-16 en geldigTotEnMet is null of niet opgenomen
    En heeft de 2e bewoner burgerservicenummer 999999345 en geldigVan 2017-05-16 en geldigTotEnMet 2017-07-31
    En heeft de 3e bewoner burgerservicenummer 999999060 en geldigVan 2013-05-01 en geldigTotEnMet is null of niet opgenomen
    En heeft de 4e bewoner burgerservicenummer 999999345 en geldigVan 2013-05-01 en geldigTotEnMet 2017-07-31
