# language: nl

# Nederlandse API Strategie:
# API-12 Representatie op maat wordt ondersteund
# Het is mogelijk om een door komma's gescheiden lijst van veldennamen op te geven met de query-parameter fields om een representatie op maat te krijgen. Als niet-bestaande veldnamen worden meegegeven wordt een 400 Bad Request teruggegeven.

# De gebruiker van een API heeft niet altijd de volledige representatie (lees alle velden) van een resource nodig. De mogelijkheid bieden om de gewenste velden te selecteren helpt bij het beperken van het netwerkverkeer (relevant voor lichtgewicht toepassingen), vereenvoudigt het gebruik van de API en maakt deze aanpasbaar (op maat). Om dit mogelijk te maken wordt de query-parameter fields ondersteund. De query-parameter accepteert een door komma's gescheiden lijst met veldnamen. Het resultaat is een representatie op maat.
# In het geval van HAL zijn de gelinkte resources embedded in de standaard representatie. Met de hier beschreven fields parameter ontstaat de mogelijkheid om de inhoud van de body naar behoefte aan te passen.

Functionaliteit: Aanpasbare representatie met de fields parameter
  Het is mogelijk om een door komma's gescheiden lijst van veldennamen op te geven met de query-parameter fields om een representatie op maat te krijgen.

  Wanneer de fields parameter niet wordt meegegeven in het request, worden alle attributen van de resource die een waarde hebben teruggegeven in het antwoord. Dit is inclusief alle relaties in _links.

  Wanneer de fields parameter is meegegeven in het request, worden alleen de attributen van de resource teruggegeven die zijn genoemd in de fields parameter.

  De self-link in _links (JSON HAL) wordt altijd teruggegeven in het antwoord. Deze hoeft niet worden opgenomen in de fields parameter.

  Met de fields parameter kan ook worden aangegeven welke relaties moeten worden opgenomen (in _links). Wanneer de fields parameter is meegegeven in het request worden alleen die relaties teruggegeven die zijn gevraagd in de fields parameter. Bijvoorbeeld de links naar de kinderen van een persoon worden teruggegeven bij fields=burgerservicenummer,naam,kinderen. In dat geval worden andere relaties, zoals ouders en partners niet opgenomen in het antwoord (in _links).

  Gevraagde attributen worden komma-gescheiden opgesomd. Bijvoorbeeld fields=burgerservicenummer,naam,geslachtsaanduiding.
  Gevraagde attributen kunnen in willekeurige volgorde worden opgenomen in de fields parameter. De volgorde waarin de gevraagde attributen worden opgesomd in de fields parameter heeft geen invloed op de volgorde waarin deze attributen worden opgenomen in het antwoord (volgorde is niet relevant in een json object).

  Categorieën (groepen attributen) kunnen in gezamenlijk worden gevraagd door de naam van de categorie op te nemen in de fields-parameter. In dat geval worden alle attributen van de categorie opgenomen in het antwoord, voor zover ze een waarde hebben. Bijvoorbeeld fields=burgerservicenummer,naam geeft naast het burgerservicenummer alle attributen van de naam (geslachtsnaam, voornamen, voorvoegsel, enz.) terug.

  Attributen binnen een categorie (een groep attributen) kunnen ook individueel worden bevraagd. De dot-notatie wordt gebruikt om specifieke velden van een categorie te selecteren. Bijvoorbeeld de voornamen, geboortedatum en geboorteplaats van een persoon kunnen worden opgevraagd via fields=naam.voornamen,geboorte.datum,geboorte.plaats.

  Gebruik van de fields parameter heeft geen invloed op eventueel meegeladen sub-resources. Dat wordt gestuurd via de expand parameter.

  Wanneer de fields-parameter wordt opgenomen zonder waarde, wordt een foutmelding gegeven.
  Wanneer in de fields-parameter namen zijn opgenomen die niet voorkomen als attribuut in de resource, wordt een foutmelding gegeven.

  In de fields-parameter moeten veldnamen exact zo worden geschreven als voor de resource-response gedefinieerd. Dit is case sensitive. Bijvoorbeeld fields=BURGERSERVICENUMMER levert een foutmelding, want dat attribuut bestaat niet (attribuut burgerservicenummer bestaat wel).

  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv

  Scenario: De fields-parameter is niet opgenomen
    Als een ingeschreven persoon wordt geraadpleegd zonder fields-parameter
    Dan worden alle attributen van de resource teruggegeven
    En worden alle relaties van de resource teruggegeven

  Scenario: Slechts één enkel attribuut wordt gevraagd
    Als een ingeschreven persoon wordt geraadpleegd met fields=geslachtsaanduiding
    Dan wordt attribuut geslachtsaanduiding teruggegeven
    En wordt geen enkel ander attribuut dan geslachtsaanduiding teruggegeven
    En wordt geen enkele relatie van de resource teruggegeven
    En wordt de self-link teruggegeven

  Scenario: Meerdere attributen worden gevraagd
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,burgerlijkeStaat,geslachtsaanduiding
    Dan wordt attribuut burgerservicenummer teruggegeven
    En wordt attribuut burgerlijkeStaat teruggegeven
    En wordt attribuut geslachtsaanduiding teruggegeven
    En wordt geen enkel ander attribuut dan burgerservicenummer, burgerlijkeStaat en geslachtsaanduiding teruggegevenEn wordt geen enkele relatie van de resource teruggegeven
    En wordt de self-link teruggegeven

  Scenario: Hele categorie wordt gevraagd
    Gegeven de te raadplegen persoon heeft voornamen, geslachtsnaam en voorvoegsel
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam
    Dan wordt attribuut burgerservicenummer teruggegeven
    En wordt attribuut naam.voornamen teruggegeven
    En wordt attribuut naam.geslachtsnaam teruggegeven
    En wordt attribuut naam.voorvoegsel teruggegeven

  Scenario: Enkele attributen binnen een categorie (gegevensgroep) worden gevraagd
    Als een ingeschreven persoon wordt geraadpleegd met fields=naam.voorvoegsel,naam.geslachtsnaam
    Dan wordt attribuut naam.geslachtsnaam teruggegeven
    En wordt attribuut naam.voorvoegsel teruggegeven
    En wordt van categorie naam geen enkel ander attribuut dan voorvoegsel en geslachtsnaam teruggegeven

  Scenario: Relaties (links) vragen (en beperken) in het antwoord
    Gegeven de geraadpleegde persoon een actuele partner(partnerschap of huwelijk), ouders en kinderen heeft
    En de geraadpleegde persoon een BAG-adres (nummeraanduiding) als verblijfplaats heeft
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam,partners
    Dan wordt er een link partners teruggegeven
    En wordt geen enkele andere link dan partners teruggegeven
    En wordt de self-link teruggegeven
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam,ouders
    Dan wordt er een link ouders teruggegeven
    En wordt geen enkele andere relatie van de resource dan ouders teruggegeven
    En wordt de self-link teruggegeven
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam,kinderen
    Dan wordt er een link kinderen teruggegeven
    En wordt geen enkele andere relatie van de resource dan kinderen teruggegeven
    En wordt de self-link teruggegeven
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam,partners,nummeraanduidingen
    Dan wordt er een link partners teruggegeven
    En wordt geen enkele andere relatie van de resource dan partners en nummeraanduidingen teruggegeven
    En wordt de self-link teruggegeven

  Scenario: Gebruik van de fields parameter heeft geen invloed op embedded sub-resources
    Als een ingeschreven persoon wordt geraadpleegd met fields=partners&expand=kinderen
    Dan wordt er een link partners teruggegeven
    En wordt geen enkele andere link dan partners teruggegeven
    En wordt de self-link teruggegeven
    En bevat _embedded de sub-resource kinderen
    En bevat _embedded geen enkele andere sub-resource dan kinderen

  Scenario: Lege fields parameter geeft een foutmelding
    Als een ingeschreven persoon wordt geraadpleegd met fields=
    Dan levert dit een foutmelding

  Scenario: Fields parameter met veldnaam die niet bestaat
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,geslachtsaanduiding,bestaatniet
    Dan levert dit een foutmelding
    Als een ingeschreven persoon wordt geraadpleegd met fields=BurgerServiceNummer
    Dan levert dit een foutmelding
