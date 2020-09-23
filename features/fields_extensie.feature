# language: nl

Functionaliteit: Aanpasbare representatie met de fields parameter
  Deze feature is een extensie op https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/master/features/fields.feature

  In de BRP API wordt de uitgebreide variant van fields ondersteund. Velden in een groep kunnen dus worden opgevraagd zonder het hele pad op te noemen, bijvoorbeeld fields=voornamen levert naam.voornamen.

  De volgende velden worden geleverd ongeacht of de fields parameter is gebruikt en ongeacht de eventueel gevraagde velden in de fields parameter:
  - inOnderzoek wordt meegegeven wanneer gevraagde corresponderende velden in onderzoek zijn. Zie in_onderzoek.feature voor uitleg wanneer attributen in onderzoek zijn.
  - geheimhoudingPersoonsgegevens wordt altijd meegegeven wanneer deze de waarde true heeft.
  - opschortingBijhouding reden en datum worden altijd meegegeven wanneer deze een waarde hebben.

  Gegeven: persoon met burgerservicenummer 999994086 heeft geboortedatum (01.03.10) in onderzoek

  Scenario: gevraagd gegeven is in onderzoek en geen fields gebruikt
    Als persoon wordt gevraagd met "/ingeschrevenpersonen/999994086"
    Dan bevat het antwoord geboorte.datum met de waarde "1986-04-01"
    En bevat het antwoord geboorte.inOnderzoek.datum met de waarde true
    En bevat het antwoord geboorte.inOnderzoek.datumIngangOnderzoek
    En bevat het antwoord veld geboorte.plaats met een waarde
    En bevat het antwoord niet geboorte.inOnderzoek.plaats
    En bevat het antwoord veld geboorte.land met een waarde
    En bevat het antwoord niet geboorte.inOnderzoek.land

    Scenario: gevraagd gegeven is in onderzoek en het gegeven in onderzoek wordt gevraagd
      Als persoon wordt gevraagd met "/ingeschrevenpersonen/999994086?fields=geboorte.datum"
      Dan bevat het antwoord geboorte.datum.datum met de waarde "1986-04-01"
      En bevat het antwoord geboorte.inOnderzoek.datum met de waarde true
      En bevat het antwoord geboorte.inOnderzoek.datumIngangOnderzoek
      En bevat het antwoord geboorte.plaats met een waarde
      En bevat het antwoord geboorte.inOnderzoek.plaats
      En bevat het antwoord geboorte.land met een waarde
      En bevat het antwoord geboorte.inOnderzoek.land

    Scenario: gevraagd gegeven is in onderzoek en de groep waar het gegeven in onderzoek in zit wordt gevraagd met fields
      Als persoon wordt gevraagd met "/ingeschrevenpersonen/999994086?fields=geboorte"
      Dan bevat het antwoord geboorte.datum met de waarde "1986-04-01"
      En bevat het antwoord geboorte.inOnderzoek.datum met de waarde true
      En bevat het antwoord geboorte.inOnderzoek.datumIngangOnderzoek
      En bevat het antwoord veld geboorte.plaats met een waarde
      En bevat het antwoord niet geboorte.inOnderzoek.plaats
      En bevat het antwoord veld datgeboorteum.land met een waarde
      En bevat het antwoord niet geboorte.inOnderzoek.land

    Scenario: gevraagd gegeven is in onderzoek en het gegeven in onderzoek wordt niet gevraagd met fields
      Als persoon wordt gevraagd met "/ingeschrevenpersonen/999994086?fields=geboorte.plaats"
      Dan bevat het antwoord veld geboorte.plaats met een waarde
      En bevat het antwoord niet geboorte.datum
      En bevat het antwoord niet geboorte.land
      En bevat het antwoord niet geboorte.inOnderzoek
