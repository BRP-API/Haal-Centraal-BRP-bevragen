# language: nl

Functionaliteit: Woonplaats wordt altijd gevuld voor een Nederlandse verblijfplaats
  In LO GBA wordt voorgeschreven dat voor een verblijfplaats de woonplaats (samen met naam openbare ruimte en BAG identificaties) alleen wordt gevuld wanneer het een BAG adres is. Dus al deze gegevens zijn gevuld of geen van deze gegevens hebben een waarde.

  In de API moet woonplaats voor een Nederlandse verblijfplaats altijd worden gevuld, zodat een gebruiker bij adressering maar op één plek hoeft te kijken voor de plaats in de adressering.

  ALS verblijfplaats.woonplaats leeg is
  EN verblijfplaats.straatnaam heeft een waarde OF verblijfplaats.locatiebeschrijving heeft een waarde
  DAN wordt verblijfplaats.woonplaats gevuld met de omschrijving van verblijfplaats.gemeenteVanInschrijving

  Consequentie is dat woonplaats niet wordt gevuld wanneer het een verblijfplaats in het buitenland betreft.

  Scenario: persoon heeft BAG adres met woonplaats gevuld
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999992934 |
    En de persoon heeft de volgende verblijfplaats gegevens
    | naam                   | waarde     |
    | woonplaatsnaam (11.70) | Scharwoude |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999992934                       |
    | fields              | verblijfplaats.woonplaats       |
    Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'verblijfplaats' gegevens
    | naam       | waarde     |
    | woonplaats | Scharwoude |

  Scenario: persoon heeft niet-BAG adres in Nederland
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999990482 |
    En de persoon heeft de volgende verblijfplaats gegevens
    | naam                              | waarde         |
    | woonplaatsnaam (11.70)            |                |
    | straatnaam (11.10)                | een straatnaam |
    | gemeente van inschrijving (09.10) | 1681           |
    En de waardetabel 'Gemeenten' heeft de volgende waarden
    | code | omschrijving  |
    | 1681 | Borger-Odoorn |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999990482                       |
    | fields              | verblijfplaats.woonplaats       |
    Dan bevat de persoon met burgerservicenummer '999990482' de volgende 'verblijfplaats' gegevens
    | naam       | waarde        |
    | woonplaats | Borger-Odoorn |

  Scenario: persoon heeft een locatiebeschrijving voor de verblijfplaats
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000009921 |
    En de persoon heeft de volgende verblijfplaats gegevens
    | naam                              | waarde                   |
    | woonplaatsnaam (11.70)            |                          |
    | straatnaam (11.10)                |                          |
    | locatiebeschrijving (12.10)       | een locatie beschrijving |
    | gemeente van inschrijving (09.10) | 0599                     |
    En de waardetabel 'Gemeenten' heeft de volgende waarden
    | code | omschrijving |
    | 0599 | Rotterdam    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000009921                       |
    | fields              | verblijfplaats.woonplaats       |
    Dan bevat de persoon met burgerservicenummer '000009921' de volgende 'verblijfplaats' gegevens
    | naam       | waarde    |
    | woonplaats | Rotterdam |

  Scenario: persoon verblijft in het buitenland
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999993483 |
    En de persoon heeft de volgende verblijfplaats gegevens
    | naam                          | waarde |
    | woonplaatsnaam (11.70)        |        |
    | straatnaam (11.10)            |        |
    | locatiebeschrijving (12.10)   |        |
    | land adres buitenland (13.10) | 5010   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999993483                       |
    | fields              | verblijfplaats.woonplaats       |
    Dan bevat de persoon met burgerservicenummer '999993483' de volgende 'verblijfplaats' gegevens NIET
    | naam       |
    | woonplaats |
