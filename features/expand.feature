# language: nl

# Nederlandse API Strategie:
# API-10 Resources ondersteunen “lazy” en “eager” laden van relaties
# API-11 Gelinkte resources worden expliciet en selectief mee-geladen

Functionaliteit: Automatisch laden van sub-resources
  "eager loading" wordt mogelijk gemaakt voor de volgende sub-resources van een persoon:
  - kinderen
  - ouders
  - partners

  "eager loading" wordt mogelijk gemaakt voor de volgende sub-resource van bewoning:
  - bewoners

  Deze gelinkte resources kunnen direct bij de gezochte of geraadpleegde persoon (personen) worden meegeladen. Hiervoor gebruikt men de parameter expand.
  De gevraagde resources worden dan (conform HAL) opgenomen in veld _embedded binnen de resource.

  Gelinkte resources die in _embedded worden opgenomen bevatten altijd de (self) link naar de betreffende resource.

  In de API wordt expand=true niet ondersteund. Gewenste gelinkte resources moeten expliciet worden opgegeven.

  Dit wordt gedaan door de gewenste resources als een komma's gescheiden lijst te specificeren, bijvoorbeeld: expand=ouders,kinderen.

  De dot-notatie wordt gebruikt om specifieke velden van resources te selecteren, bijvoorbeeld expand=ouders.voornamen,ouders.geslachtsaanduiding.
  Wanneer geen specifieke velden van de resource zijn aangegeven, wordt de gehele resource opgenomen.

  Gegevensgroepen kunnen in gezamenlijk worden gevraagd door de naam van de groep op te nemen in de expand-parameter. In dat geval worden alle attributen van de groep opgenomen in het antwoord, voor zover ze een waarde hebben. Bijvoorbeeld expand=partners.burgerservicenummer,partners.naam geeft naast het burgerservicenummer alle attributen van de naam (geslachtsnaam, voornamen, voorvoegsel, enz.) van de partner(s) terug.

  We ondersteunen het automatisch laden van sub-resources één niveau diep. Dit betekent dat er geen gelinkte resources van de sub-resources direct kunnen worden meegeladen. Bijvoorbeeld van een persoon is er de sub-resource ouders, die de gegevens ouder de ouder toont die op de persoonslijst van een persoon staan (categorie 02/52 en 03/53). Deze sub-resource "ouders" kan automatisch worden meegeladen door gebruik van de parameter expand=ouders. In de sub-resource ouders is ook een link opgenomen naar de ouder zelf (deze link heet "ingeschrevenpersonen"), wanneer de ouder ook een ingeschreven persoon is. Deze relatie naar de ouder (de ingeschreven persoon) kan (zal) niet automatisch worden meegeladen met de sub-resource. De volledige resource van de ouder (ingeschreven persoon) kan met een extra aanroep naar de gegeven link in _embedded.ouders.ingeschrevenpersonen worden opgehaald.

  Relaties (links) van de embedded resource kunnen worden gevraagd met de naam van de relatie, al dan niet voorafgegaan door HAL-element _links. Bijvoorbeeld expand=partners.ingeschrevenpersonen geeft de link (uri) van de resource ingeschrevenpersoon die de partner is van de bevraagde persoon. Hetzelfde kan worden bereikt met expand=partners._links.ingeschrevenpersonen.

  Gevraagde attributen kunnen in willekeurige volgorde worden opgenomen in de expand-parameter. De volgorde waarin de gevraagde attributen worden opgesomd in de expand-parameter heeft geen invloed op de volgorde waarin deze attributen worden opgenomen in het antwoord (volgorde is niet relevant in een json object).

  Wanneer in de expand-parameter een resource(naam) of veld(naam) wordt opgegeven die niet bestaat, of waarvoor automatisch laden niet wordt ondersteund in de api, wordt een foutmelding teruggegeven.
  Wanneer de expand-parameter wordt opgenomen zonder waarde, wordt een foutmelding gegeven.

  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv
    En de te raadplegen persoon een actuele partner(partnerschap of huwelijk), ouders en kinderen heeft
    En in onderstaande scenario's wordt de fields-parameter niet gebruikt, tenzij expliciet aangegeven
    En de gebruiker geautoriseerd is voor gevraagde gegevens (sub-resources), tenzij expliciet anders aangegeven

  Scenario: Wanneer de expand-parameter niet is meegegeven, worden gerelateerden niet meegeladen
    Als een ingeschreven persoon wordt geraadpleegd zonder expand-parameter
    Dan is in het antwoord attribuut _embedded niet aanwezig
    En worden alle attributen van de persoon teruggegeven, voor zover ze een waarde hebben
    En wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.ouders teruggegeven
    En wordt attribuut _links.kinderen teruggegeven

  Scenario: Gebruik van expand=true is niet toegestaan
    Als een ingeschreven persoon wordt geraadpleegd met expand=true
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter expand

    Als een ingeschreven persoon wordt geraadpleegd met expand=True
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter expand

    Als ingeschreven personen gezocht worden met ?naam__geslachtsnaam=groen&geboorte__datum=1983-05-26&expand=true
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter expand

  Scenario: Expand met incorrecte resource of velden
    Als een ingeschreven persoon wordt geraadpleegd met expand=resourcebestaatniet
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter expand

    Als een ingeschreven persoon wordt geraadpleegd met expand=reisdocumenten # automatisch laden van reisdocumenten wordt niet ondersteund
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter expand

    Als een ingeschreven persoon wordt geraadpleegd met expand=ouders.veldbestaatniet
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter expand

  Scenario: Expand met lege waarde
    Als een ingeschreven persoon wordt geraadpleegd met expand=
    Dan levert dit een foutmelding
    En heeft de foutmelding betrekking op parameter expand

  Scenario: Er kunnen meerdere sub-resources worden meegeladen door deze als een komma's gescheiden lijst te specificeren
    Als een ingeschreven persoon wordt geraadpleegd met expand=partners,kinderen
    Dan wordt attribuut _embedded.partners teruggegeven
    En wordt attribuut _embedded.kinderen teruggegeven
    En is in het antwoord attribuut _embedded.ouders niet aanwezig
    En worden alle attributen van de persoon teruggegeven, voor zover ze een waarde hebben
    En wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.ouders teruggegeven
    En wordt attribuut _links.kinderen teruggegeven

  Scenario: De dot-notatie wordt gebruikt om specifieke attributen van resources te selecteren
    Als een ingeschreven persoon wordt geraadpleegd met expand=ouders.geslachtsaanduiding,ouders.ouder_aanduiding
    Dan wordt voor alle ouders in _embedded attribuut geslachtsaanduiding teruggegeven
    En wordt voor alle ouders in _embedded attribuut ouder_aanduiding teruggegeven
    En wordt voor alle ouders in _embedded attribuut _links.self teruggegeven
    En is voor alle ouders in _embedded attribuut burgerservicenummer niet aanwezig
    En is voor alle ouders in _embedded attribuut naam niet aanwezig
    En is voor alle ouders in _embedded attribuut geboorte niet aanwezig
    En is voor alle ouders in _embedded attribuut geldigVan niet aanwezig
    En is voor alle ouders in _embedded attribuut geldigTotEnMet niet aanwezig
    En is voor alle ouders in _embedded attribuut _links.ingeschrevenpersonen niet aanwezig
    En worden alle attributen van de persoon teruggegeven, voor zover ze een waarde hebben
    En wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.ouders teruggegeven
    En wordt attribuut _links.kinderen teruggegeven

  Scenario: Vragen om een hele gegevensgroep
    Als een ingeschreven persoon wordt geraadpleegd met expand=kinderen.naam,kinderen.geboorte
    Dan worden voor alle kinderen in _embedded alle attributen van naam teruggegeven voor zover ze een waarde hebben (voornamen, geslachtsnaam)
    En worden voor alle kinderen in _embedded alle attributen van geboorte teruggegeven voor zover ze een waarde hebben (plaats, datum, land)
    En wordt voor alle kinderen in _embedded attribuut _links.self teruggegeven
    En is voor alle kinderen in _embedded attribuut burgerservicenummer niet aanwezig
    En is voor alle kinderen in _embedded attribuut geldigVan niet aanwezig
    En is voor alle kinderen in _embedded attribuut geldigTotEnMet niet aanwezig
    En is voor alle kinderen in _embedded attribuut _links.ingeschrevenpersonen niet aanwezig
    En is in het antwoord attribuut _embedded.ouders niet aanwezig
    # geen andere resource dan die gevraagd is
    En is in het antwoord attribuut _embedded.partners niet aanwezig
    # geen andere resource dan die gevraagd is
    En worden alle attributen van de persoon teruggegeven, voor zover ze een waarde hebben
    En wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.ouders teruggegeven
    En wordt attribuut _links.kinderen teruggegeven

  Scenario: Vragen om attributen binnen een groep
    Als een ingeschreven persoon wordt geraadpleegd met expand=kinderen.naam.voornamen,kinderen.naam.geslachtsnaam
    Dan wordt voor alle kinderen in _embedded attribuut naam.voornamen teruggegeven
    En wordt voor alle kinderen in _embedded attribuut naam.geslachtsnaam teruggegeven
    En wordt voor alle kinderen in _embedded geen enkel ander attribuut dan naam en _links teruggegeven
    En wordt voor alle kinderen in _embedded geen enkel ander attribuut van naam teruggegeven dan voornamen en geslachtsnaam
    En wordt voor alle kinderen in _embedded geen enkel ander attribuut van _links teruggegeven dan self
    En is in het antwoord attribuut _embedded.ouders niet aanwezig
    En is in het antwoord attribuut _embedded.partners niet aanwezig
    En worden alle attributen van de persoon teruggegeven, voor zover ze een waarde hebben
    En wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.ouders teruggegeven
    En wordt attribuut _links.kinderen teruggegeven

  Scenario: Vragen om een link
    Als een ingeschreven persoon wordt geraadpleegd met expand=kinderen.naam.voornamen,kinderen.naam.geslachtsnaam
    Dan is voor alle kinderen in _embedded attribuut _links.ingeschrevenpersonen niet aanwezig
    # geen links geven waar niet naar gevraagd is
    En wordt voor alle kinderen in _embedded attribuut naam.voornamen teruggegeven
    En wordt voor alle kinderen in _embedded attribuut naam.geslachtsnaam teruggegeven
    En wordt voor alle kinderen in _embedded attribuut _links.self teruggegeven
    # de self link moet altijd worden opgenomen
    En worden alle attributen van de persoon teruggegeven, voor zover ze een waarde hebben
    En wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.ouders teruggegeven
    En wordt attribuut _links.kinderen teruggegeven

    Als een ingeschreven persoon wordt geraadpleegd met expand=kinderen.naam.voornamen,kinderen.naam.geslachtsnaam,kinderen.ingeschrevenpersonen
    Dan wordt voor alle kinderen in _embedded attribuut _links.ingeschrevenpersonen teruggegeven
    En wordt voor alle kinderen in _embedded attribuut naam.voornamen teruggegeven
    En wordt voor alle kinderen in _embedded attribuut naam.geslachtsnaam teruggegeven
    En wordt voor alle kinderen in _embedded attribuut _links.self teruggegeven
    # de self link moet altijd worden opgenomen
    En worden alle attributen van de persoon teruggegeven, voor zover ze een waarde hebben
    En wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.ouders teruggegeven
    En wordt attribuut _links.kinderen teruggegeven
