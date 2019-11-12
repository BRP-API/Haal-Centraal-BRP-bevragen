# language: nl

Functionaliteit: Woonplaats wordt altijd gevuld voor een Nederlandse verblijfplaats
  In LO GBA wordt voorgeschreven dat voor een verblijfplaats de woonplaats (samen met naam openbare ruimte en BAG identificaties) alleen wordt gevuld wanneer het een BAG adres is. Dus al deze gegevens zijn gevuld of geen van deze gegevens hebben een waarde.

  In de API moet woonplaats voor een Nederlandse verblijfplaats altijd worden gevuld, zodat een gebruiker bij adressering maar op één plek hoeft te kijken voor de plaats in de adressering.

  ALS verblijfplaats.woonplaats leeg is
  EN verblijfplaats.straatnaam heeft een waarde OF verblijfplaats.locatiebeschrijving heeft een waarde
  DAN wordt verblijfplaats.woonplaats gevuld met de omschrijving van verblijfplaats.gemeenteVanInschrijving

  Consequentie is dat woonplaats niet wordt gevuld wanneer het een verblijfplaats in het buitenland betreft.

  Scenario: persoon heeft BAG adres met woonplaats gevuld
    Gegeven ingeschreven persoon met burgerservicenummer 999992934 heeft in de registratie element 08.11.70 met waarde "Scharwoude"
    Als ingeschreven persoon met burgerservicenummer 999993653 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.woonplaatsnaam gelijk aan "Scharwoude"

  Scenario: persoon heeft niet-BAG adres in Nederland
    Gegeven ingeschreven persoon met burgerservicenummer 999990482 heeft in de registratie geen waarde voor element 08.11.70
    En element 08.11.10 heeft een waarde
    En element 09.09.10 heeft de waarde "1681"
    En in de landelijke tabel 33 (gemeententabel) komt code "1681" voor met omschrijving "Borger-Odoorn"
    Als ingeschreven persoon met burgerservicenummer 999990482 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.woonplaatsnaam gelijk aan "Borger-Odoorn"

  Scenario: persoon heeft een locatiebeschrijving voor de verblijfplaats
    Gegeven ingeschreven persoon met burgerservicenummer 000009921 heeft in de registratie geen waarde voor element 08.11.70
    En element 08.11.10 heeft geen waarde
    En element 08.12.10 heeft een waarde
    En element 09.09.10 heeft de waarde "0599"
    En in de landelijke tabel 33 (gemeententabel) komt code "0599" voor met omschrijving "Rotterdam"
    Als ingeschreven persoon met burgerservicenummer 000009921 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.woonplaatsnaam gelijk aan "Rotterdam"

  Scenario: persoon verblijft in het buitenland
    Gegeven ingeschreven persoon met burgerservicenummer 999993483 heeft in de registratie geen waarde voor element 08.11.70
    En element 08.11.10 heeft geen waarde
    En element 08.12.10 heeft geen waarde
    En element 08.13.10 heeft een waarde
    Als ingeschreven persoon met burgerservicenummer 000009921 wordt geraadpleegd
    Dan komt in het antwoord verblijfplaats.woonplaatsnaam niet voor met een waarde
