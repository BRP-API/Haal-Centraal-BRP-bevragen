# language: nl

Functionaliteit: Hyperlinks naar gerelateerde resources worden opgenomen in _links
  Relaties van resources met andere resources worden als hyperlink opgenomen in _links.
  Alle links in HAL zijn absoluut. Dit geldt zowel voor gerelateerde resources in een andere registratie als gerelateerde resources binnen dezelfde registratie (zelfde API).
  De opgenomen links verwijzen naar de daadwerkelijke resource (API) waarmee de gegevens van de gerelateerde resource kunnen worden opgehaald.

  Bij elke resource is een link "self" opgenomen met daarin de url die resulteert in de opgenomen resource.

  Een resource url (en dus een link naar een resource) binnen deze API is opgebouwd met
    - http:// of https://
    - basis pad
    - /api/bevragingen_ingeschreven_personen/
    - major versie
    - path van de operatie

    Bijvoorbeeld:
    - https://datapunt.voorbeeldgemeente.nl/api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen
    - https://datapunt.voorbeeldgemeente.nl/api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen/999999023/partners

  Een link bevat nooit een trailing slash "/".

  Wanneer een relatie gevraagd is, maar bij de persoon niet voorkomt, wordt het relatieattribuut opgenomen met een lege collectie.

  Scenario: self link van een collectie
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=true&fields=naam,geboorte,overlijden
    Dan bevat attribuut _links.self.href /api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen
    En bevat attribuut _links.self.href naam__geslachtsnaam=groen
    En bevat attribuut _links.self.href geboorte__datum=1983-05-26
    En bevat attribuut _links.self.href inclusiefoverledenpersonen=true
    En bevat attribuut _links.self.href fields=naam,geboorte,overlijden
    En begint attribuut _links.self.href met http:// of https://
    En levert een GET request naar de url in _links.self.href een antwoord

  Scenario: self link van een resource in een collectie
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=true
    Dan geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst /api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst naam__geslachtsnaam=groen bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst geboorte__datum=1983-05-26 bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst inclusiefoverledenpersonen=true bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href begint met http:// of https://
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href geen waarde fields bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href geen waarde expand bevat
    En levert voor elk van de gevonden ingeschrevenpersonen een GET request naar de url in _links.self.href een antwoord

  Scenario: self link van een resource in een collectie-aanroep met expand en fields
    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&inclusiefoverledenpersonen=true&fields=naam,geboorte,overlijden&expand=partners,kinderen
    Dan geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst /api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst naam__geslachtsnaam=groen bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst geboorte__datum=1983-05-26 bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst inclusiefoverledenpersonen=true bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst fields=naam,geboorte,overlijden bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst expand=partners,kinderen bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst ? bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href de tekst & bevat
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href begint met http:// of https://
    En geldt voor elk van de gevonden ingeschrevenpersonen dat attribuut _links.self.href geen waarde /? bevat
    En levert voor elk van de gevonden ingeschrevenpersonen een GET request naar de url in _links.self.href een antwoord

  Scenario: self link van een resource
    Als ingeschreven persoon met burgerservicenummer 999999023 wordt geraadpleegd zonder fields-parameter en zonder expand-parameter
    Dan eindigt attribuut _links.self.href met /api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen/999999023
    En begint attribuut _links.self.href met http:// of https://
    En eindigt attribuut _links.self.href niet op /

  Scenario: self link van een resource-aanroep met expand en fields
    Als ingeschreven persoon met burgerservicenummer 999999023 wordt geraadpleegd met fields=naam,geboorte,overlijden&expand=partners,kinderen
    Dan bevat attribuut _links.self.href /api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen/999999023
    Dan bevat attribuut _links.self.href fields=naam,geboorte,overlijden
    Dan bevat attribuut _links.self.href expand=partners,kinderen
    En begint attribuut _links.self.href met http:// of https://

  Scenario: self link van een embedded resource
    Als ingeschreven persoon met burgerservicenummer 999999023 wordt geraadpleegd met expand=partners
    Dan bevat het attribuut _links.self.href in elke van de gevonden _embedded.partners /api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen/999999023/partners/
    En bevat het attribuut _links.self.href in geen van de gevonden _embedded.partners ?
    En bevat het attribuut _links.self.href in geen van de gevonden _embedded.partners &
    En eindigt het attribuut _links.self.href in geen van de gevonden _embedded.partners op /
    En begint het attribuut _links.self.href in elk van de gevonden _embedded.partners met http:// of https://
    En levert voor elk van de gevonden partners een GET request naar de url in _links.self.href een antwoord

  Scenario: link naar een gerelateerde resource binnen dezelfde API
    Als de ingeschreven persoon met burgerservicenummer 999999023 wordt geraadpleegd
    Dan bevat het attribuut href in elke van de gevonden _links.partners /api/bevragingen_ingeschreven_personen/v1/ingeschrevenpersonen/999999023/partners/
    En begint het attribuut href in elk van de gevonden _links.partners met http:// of https://
    En bevat het attribuut href in geen van de gevonden _links.partners ?
    En bevat het attribuut href in geen van de gevonden _links.partners &
    En eindigt het attribuut href in geen van de gevonden _links.partners op /
    En levert voor alle gevonden _links.partners een GET request naar de url in href een antwoord

  Scenario: link naar een gerelateerde resource van een andere API
    Gegeven nummeraanduidingen zijn te raadplegen in een BAG API
    En de geraadpleegde ingeschreven persoon heeft een BAG adres (nummeraanduiding) als verblijfplaats
    Als de ingeschreven persoon met burgerservicenummer 999999023 wordt geraadpleegd
    Dan bevat attribuut _links.nummeraanduidingen.href /api/
    En begint attribuut _links.nummeraanduidingen.href met http:// of https://
    En zit er geen ? in _links.nummeraanduidingen.href
    En zit er geen & in _links.nummeraanduidingen.href
    En eindigt attribuut _links.nummeraanduidingen.href niet op /
    En zit er geen bevragingen_ingeschreven_personen in _links.nummeraanduidingen.href
    En zit er geen ingeschrevenpersonen in _links.nummeraanduidingen.href
    En zit er geen 999999023 in _links.nummeraanduidingen.href
    En levert een GET request naar de url in _links.partners.href een antwoord

  Scenario: Relatie komt niet voor
    Gegeven de geraadpleegde ingeschreven persoon heeft geen kinderen
    Als de ingeschreven persoon met burgerservicenummer 999999011 wordt geraadpleegd
    Dan wordt attribuut _links.kinderen teruggegeven
    En is _links.kinderen leeg
