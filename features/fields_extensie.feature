# language: nl

Functionaliteit: Aanpasbare representatie met de fields parameter
  Deze feature is een extensie op https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/master/features/fields.feature

  In de BRP API wordt de uitgebreide variant van fields ondersteund. Velden in een groep kunnen dus worden opgevraagd zonder het hele pad op te noemen, bijvoorbeeld fields=voornamen levert naam.voornamen.

  De volgende velden worden geleverd ongeacht of de fields parameter is gebruikt en ongeacht de eventueel gevraagde velden in de fields parameter:
  - inOnderzoek wordt meegegeven wanneer gevraagde corresponderende velden in onderzoek zijn. Zie in_onderzoek.feature voor uitleg wanneer attributen in onderzoek zijn.
  - geheimhoudingPersoonsgegevens wordt altijd meegegeven wanneer deze de waarde true heeft.
  - opschortingBijhouding reden en datum worden altijd meegegeven wanneer deze een waarde hebben.

  Achtergrond:
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999994086 |
    En de persoon heeft de volgende geboorte gegevens
    | naam                                      | waarde   |
    | datum (01.03.10)                          | 19860401 |
    | land.code                                 | 6030     |
    | plaats.code                               | 0518     |
    | inOnderzoek.aanduidingGegevensInOnderzoek | TODO     |
    | inOnderzoek.datum                         | 20200601 |
    En het systeem heeft een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 999993483 |
    | geheimhoudingPersoonsgegevens | 7         |
    En de persoon heeft de volgende geboorte gegevens
    | naam        | waarde |
    | plaats.code | 0518   |
    En het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992077 |
    En de persoon heeft de volgende geboorte gegevens
    | naam        | waarde |
    | plaats.code | 0518   |
    En de persoon heeft de volgende overlijden gegevens
    | naam | waarde |
    | TODO | TODO   |
    En de persoon heeft de volgende opschortingBijhouding gegevens
    | naam       | waarde     |
    | reden.code | overlijden |
    | datum      | 20151001   |
    En de waardetabel 'Gemeenten' heeft de volgende waarden
    | code | omschrijving  |
    | 0518 | 's-Gravenhage |
    En de waardetabel 'Landen' heeft de volgende waarden
    | code | omschrijving |
    | 6030 | Nederland    |

  Scenario: geboortedatum is in onderzoek en geboorte wordt gevraagd met de fields parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | geboorte                        |
    Dan bevat de persoon met burgerservicenummer '999994086' de volgende geboorte gegevens
    | naam                             | waarde        |
    | datum.type                       | Datum         |
    | datum.datum                      | 1986-04-01    |
    | land.code                        | 6030          |
    | land.omschrijving                | Nederland     |
    | plaats.code                      | 0518          |
    | plaats.omschrijving              | 's-Gravenhage |
    | inOnderzoek.datumIngangOnderzoek | 2020-06-01    |
    | inOnderzoek.datum                | true          |
    | inOnderzoek.land                 |               |
    | inOnderzoek.plaats               |               |

  Scenario: geboortedatum is in onderzoek en geboortedatum wordt gevraagd met de fields parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | geboorte.datum                  |
    Dan bevat de persoon met burgerservicenummer '999994086' de volgende geboorte gegevens
    | naam                             | waarde     |
    | datum.type                       | Datum      |
    | datum.datum                      | 1986-04-01 |
    | inOnderzoek.datumIngangOnderzoek | 2020-06-01 |
    | inOnderzoek.datum                | true       |

  Scenario: geboortedatum is in onderzoek en een ander gegeven in de gegevens groep wordt gevraagd met de fields parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999994086                       |
    | fields              | geboorte.plaats                 |
    Dan bevat de persoon met burgerservicenummer '999994086' de volgende geboorte gegevens
    | naam                | waarde        |
    | plaats.code         | 0518          |
    | plaats.omschrijving | 's-Gravenhage |
    En bevat de persoon met burgerservicenummer '999994086' de volgende geboorte gegevens NIET
    | naam        |
    | inOnderzoek |

  Scenario: persoon heeft geheimhouding en andere gegevens wordt gevraagd met de fields parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999993483                       |
    | fields              | geboorte.plaats                 |
    Dan bevat de persoon met burgerservicenummer '999993483' de volgende gegevens
    | naam                          | waarde |
    | geheimhoudingPersoonsgegevens | true   |
    En bevat de persoon met burgerservicenummer '999994086' de volgende geboorte gegevens
    | naam                | waarde        |
    | plaats.code         | 0518          |
    | plaats.omschrijving | 's-Gravenhage |

  Scenario: persoon heeft opschorting bijhouding en andere gegevens wordt gevraagd met de fields parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992077                       |
    | fields              | geboorte.plaats                 |
    Dan bevat de persoon met burgerservicenummer '999992077' de volgende geboorte gegevens
    | naam                | waarde        |
    | plaats.code         | 0518          |
    | plaats.omschrijving | 's-Gravenhage |
    En bevat de persoon met burgerservicenummer '999992077' de volgende opschortingBijhouding gegevens
    | naam              | waarde     |
    | reden.code        | overlijden |
    | reden.datum.datum | 2015-10-01 |
    | reden.datum.type  | Datum      |
    En bevat de persoon met burgerservicenummet '999992077' geen overlijden gegevens
