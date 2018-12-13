Functionaliteit: historie wordt gesorteerd op geldigheid met meest actuele bovenaan
  Bij het ophalen van de historie worden de historische voorkomens aflopend teruggegeven op volgorde van geldigVan. De meest recente registratie staat dan bovenaan, de oudste situatie staat onderaan.

  Bij het zoeken van bewoningen worden de gevonden adressen niet gesorteerd teruggegeven. Binnen elk adres worden de bewoners aflopend gesorteerd op geldigVan, wanneer deze door gebruik van de [expand](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/expand.feature)-parameter zijn meegeladen met de resource.

  Achtergrond:
    Gegeven deze ingeschreven persoon staat vanaf 2013-05-01 ingeschreven met de volgende gegevens:
      | Attribuut              | Waarde     |
      | ---------------------- | ---------- |
      | naamOpenbareRuimte     | Voorstraat |
      | verblijfstitelNumeriek | 21         |
      | burgerlijkeStaat       | 2          |
      | voornamen              | Pieterjan  |
      | indicatieGeheim        | 0          |
      | partner                | 999999308  |

    En een ingeschreven persoon kent de volgende historie in de registratie
      | Gebeurtenis          | Datum      | Gewijzigd attribuut    | Nieuwe waarde  |
      | -------------------- | ---------- | ---------------------- |--------------- |
      | verhuizing           | 2014-03-01 | naamOpenbareRuimte     | Kerkstraat     |
      | verblijfstitel       | 2014-09-17 | verblijfstitelNumeriek | 25             |
      | gescheiden           | 2015-05-12 | partner.geldigTotEnMet | 2015-05-12     |
      | naamswijziging       | 2016-10-09 | voornamen              | Pieter Jan     |
      | verhuizing           | 2017-09-09 | naamOpenbareRuimte     | Loosduinsekade |
      | huwelijk             | 2018-02-09 | partner                | 555555112      |
      | indicatie geheim     | 2018-10-10 | indicatieGeheim        | 1              |

  Scenario: partnerhistorie wordt aflopend gesorteerd op geldigVan
    Als de partnerhistorie van ingeschreven persoon wordt geraadpleegd vanaf 2013-05-01
    Dan worden er 2 partners teruggegeven
    En wordt eerst de partner getoond met burgerservicenummer 555555112 en geldigVan 2018-02-09
    En wordt daarna de partner getoond met burgerservicenummer 999999308 en geldigTotEnMet 2015-05-12

  Scenario: verblijfplaatshistorie wordt aflopend gesorteerd op geldigVan

  Scenario: verblijfstitelhistorie wordt aflopend gesorteerd op geldigVan

  Scenario: bij bewoningen worden de bewoners aflopend gesorteerd op geldigVan
