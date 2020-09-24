# language: nl

Functionaliteit:
  Veld "straat" wordt gevuld met de naam openbare ruimte (11.15) wanneer die bekend is, en anders met straatnaam (11.10)
  Veld "korteNaam" wordt gevuld met straatnaam (11.10).
  Veld "woonplaats" wordt gevuld met de woonplaats (11.70) wanneer die bekend is, en anders met de omschrijving van de gemeente van inschrijving (09.10 via tabel 33 Gemeententabel) als de verblijfplaats geen geen buitenlands adres betreft.
  Veld "land" wordt alleen opgenomen wanneer het een buitenlands adres betreft.

  Adresregels worden gevuld met het binnenlandse of buitenlandse adres:
    Als de verblijfplaats een binnenlands BAG-adres is (Identificatiecode nummeraanduiding 11.90 heeft een waarde),
    Dan wordt verblijfplaats.adresregel1 gevuld met straat (11.10) + huisnummer (11.20)+ huisletter (11.30) + huisnummertoevoeging (11.40)
    En wordt verblijfplaats.adresregel2 gevuld met postcode (11.60) en woonplaats (11.70)
    En wordt verblijfplaats.adresregel3 niet opgenomen
    En wordt verblijfplaats.land niet opgenomen

    Als de verblijfplaats een binnenlands niet-BAG adres is (Identificatiecode nummeraanduiding 11.90 heeft geen waarde, maar straat 11.10 wel),
    Dan wordt verblijfplaats.adresregel1 gevuld met straat (11.10)+ huisnummer (11.20)+ huisletter (11.30) + huisnummertoevoeging (11.40) + aanduidingBijHuisnummer (11.50)
    En wordt verblijfplaats.adresregel2 gevuld met postcode (11.60) en gemeenteVanInschrijving.omschrijving
    En wordt verblijfplaats.adresregel3 niet opgenomen
    En wordt verblijfplaats.land niet opgenomen

    Als de verblijfplaats een locatiebeschrijving (12.10) heeft,
    Dan wordt verblijfplaats.adresregel1 gevuld met locatiebeschrijving
    En wordt verblijfplaats.adresregel2 gevuld gemeenteVanInschrijving.omschrijving (09.10 via tabel 33 Gemeententabel)
    En wordt verblijfplaats.adresregel3 niet opgenomen
    En wordt verblijfplaats.land niet opgenomen

    Als de verblijfplaats een buitenlands adres is (land adres buitenland 13.10 komt voor met een waarde ongelijk aan "0000"),
    Dan wordt verblijfplaats.adresregel1 gevuld met verblijfBuitenland.adresregel1 (13.30)
    En wordt verblijfplaats.adresregel2 gevuld met verblijfBuitenland.adresregel2 (13.40)
    En wordt verblijfplaats.adresregel2 gevuld met verblijfBuitenland.adresregel3 (13.50)
    En wordt verblijfplaats.land gevuld met de code en omschrijving van het land (13.10 via tabel 34 Landen)

    Als de verblijfplaats in het buitenland onbekend is (land adres buitenland 13.10 heeft de waarde "0000"),
    Dan wordt verblijfplaats.adresregel1 niet opgenomen
    En wordt verblijfplaats.adresregel2 niet opgenomen
    En wordt verblijfplaats.adresregel3 niet opgenomen
    En wordt verblijfplaats.land niet opgenomen
    En wordt verblijfplaats.vertrokkenOnbekendWaarheen opgenomen met de waarde true.

    Wanneer er een huisnummertoevoeging is, wordt er een "-" opgenomen voor de huisnummertoevoeging in adresregel1.
    Wanneer er een aanduidingBijHuisnummer is, wordt er een spatie opgenomen voor de aanduidingBijHuisnummer in adresregel1.

  Scenario: verblijfplaats is een binnenlands BAG-adres
    Gegeven persoon met burgerservicenummer "999995492" heeft de volgende gegevens bij verblijfplaats:
    """
      "gemeente van inschrijving": "1810",
      "straatnaam": "Kappeyne v d Cappellostr",
      "naam openbare ruimte": "Annelien Kappeyne van de Coppellostraat",
      "huisnummer": 18,
      "postcode": "2755ED",
      "woonplaats": "Toetsoog"
    """
    Als persoon met burgerservicenummer "999995492" wordt opgevraagd met fields=verblijfplaats
    Dan bevat in het antwoord verblijfplaats:
    """
      "straat": "Annelien Kappeyne van de Coppellostraat",
      "korteNaam": "Kappeyne v d Cappellostr",
      "woonplaats": "Toetsoog",
      "adresregel1": "Kappeyne v d Cappellostr 18",
      "adresregel2": "2755ED Toetsoog"
    """
    En bevat het antwoord geen veld verblijfplaats.adresregel3
    En bevat het antwoord geen veld verblijfplaats.land

  Scenario: verblijfplaats is een binnenlands BAG-adres met huisletter en huisnummertoevoeging
    Gegeven persoon met burgerservicenummer "999990160" heeft de volgende gegevens bij verblijfplaats:
    """
      "naamOpenbareRuimte": "St. Jacobsstraat",
      "straatnaam": "St. Jacobsstraat",
      "huisnummer": 400,
      "huisletter": "L",
      "huisnummertoevoeging": "Toe",
      "postcode": "3511BT",
      "woonplaats": "Utrecht"
    """
    Als persoon met burgerservicenummer "999990160" wordt opgevraagd met fields=verblijfplaats
    Dan bevat in het antwoord verblijfplaats:
    """
      "straat": "St. Jacobsstraat",
      "korteNaam": "St. Jacobsstraat",
      "woonplaats": "Utrecht",
      "adresregel1": "St. Jacobsstraat 400L-Toe",
      "adresregel2": "3511BT Utrecht"
    """
    En bevat het antwoord geen veld verblijfplaats.adresregel3
    En bevat het antwoord geen veld verblijfplaats.land

  Scenario: verblijfplaats is een binnenlands niet-BAG adres
    Gegeven persoon met burgerservicenummer "999991802" heeft de volgende gegevens bij verblijfplaats:
    """
      "gemeente van inschrijving": "0363",
      "straatnaam": "Zomerdijkstrtaat",
      "huisnummer": 17,
      "postcode": "1079WZ"
    """
    En verblijfplaats heeft geen waarde voor "naam openbare ruimte"
    En verblijfplaats heeft geen waarde voor "woonplaats"
    Als persoon met burgerservicenummer "999991802" wordt opgevraagd met fields=verblijfplaats
    Dan bevat in het antwoord verblijfplaats:
    """
      "straat": "Zomerdijkstrtaat",
      "korteNaam": "Zomerdijkstrtaat",
      "woonplaats": "Amsterdam",
      "adresregel1": "Zomerdijkstrtaat 17",
      "adresregel2": "1079WZ Amsterdam"
    """

  Scenario: verblijfplaats is een binnenlands adres met aanduidingBijHuisnummer
    Gegeven persoon met burgerservicenummer "999990482" heeft de volgende gegevens bij verblijfplaats:
    """
      "gemeente van inschrijving": "1681",
      "straatnaam": "1e Exloërmond",
      "huisnummer": 3,
      "aanduidingBijHuisnummer": "tegenover",
      "postcode": "9573PA"
    """
    Als persoon met burgerservicenummer "999990482" wordt opgevraagd met fields=verblijfplaats
    Dan bevat in het antwoord verblijfplaats:
    """
      "straat": "1e Exloërmond",
      "korteNaam": "1e Exloërmond",
      "woonplaats": "Borger-Odoorn",
      "adresregel1": "1e Exloërmond 3 tegenover",
      "adresregel2": "9573PA Borger-Odoorn"
    }
    """

  Scenario: verblijfplaats is een locatiebeschrijving
    Gegeven persoon met burgerservicenummer "000009921" heeft de volgende gegevens bij verblijfplaats:
    """
      "gemeenteVanInschrijving": "0518",
      "locatiebeschrijving": "Woonboot in de Grote Sloot"
    """
    Als persoon met burgerservicenummer "000009921" wordt opgevraagd met fields=verblijfplaats
    Dan bevat in het antwoord verblijfplaats:
    """
      "woonplaats": "'s-Gravenhage",
      "adresregel1": "Woonboot in de Grote Sloot",
      "adresregel2": "'s-Gravenhage"
    }
    """
    En bevat het antwoord geen veld verblijfplaats.straat
    En bevat het antwoord geen veld verblijfplaats.korteNaam

  Scenario: verblijfplaats is een adres in het buitenland
    Gegeven persoon met burgerservicenummer "000009921" heeft de volgende gegevens bij verblijfplaats:
    """
      "adresregel1": "Rue du pomme 25",
      "adresregel2": "Bruxelles",
      "adresregel3": "postcode 1000",
      "land": "5010"
    """
    Als persoon met burgerservicenummer "999993653" wordt opgevraagd met fields=verblijfplaats
    Dan bevat in het antwoord verblijfplaats:
    """
      "adresregel1": "Rue du pomme 25",
      "adresregel2": "Bruxelles",
      "adresregel3": "postcode 1000",
      "land": {
        "code": "5010",
        "omschrijving": "België"
      }
    """
    En bevat het antwoord geen veld verblijfplaats.straat
    En bevat het antwoord geen veld verblijfplaats.korteNaam
    En bevat het antwoord geen veld verblijfplaats.woonplaats

  Scenario: verblijfplaats is onbekend (vertrokken onbekend waarheen)
    Gegeven persoon met burgerservicenummer "999993586" heeft bij verblijfplaats verblijfbuitenland.land met code "0000"
    Als persoon met burgerservicenummer "999993586" wordt opgevraagd met fields=verblijfplaats.adresregel1,verblijfplaats.adresregel2,verblijfplaats.adresregel3,verblijfplaats.land,verblijfplaats.vertrokkenOnbekendWaarheen
    Dan bevat het antwoord verblijfplaats.vertrokkenOnbekendWaarheen met de waarde true
    En bevat het antwoord geen veld verblijfplaats.adresregel1
    En bevat het antwoord geen veld verblijfplaats.adresregel2
    En bevat het antwoord geen veld verblijfplaats.land
    """
    "verblijfplaats": {
      "vertrokkenOnbekendWaarheen": true
    }
    """
