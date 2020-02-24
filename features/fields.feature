# language: nl

# Nederlandse API Strategie:
# API-12 Representatie op maat wordt ondersteund
# Het is mogelijk om een door komma's gescheiden lijst van attribuutnamen op te geven met de query-parameter fields om een representatie op maat te krijgen. Als niet-bestaande attribuutnamen worden meegegeven wordt een 400 Bad Request teruggegeven.

# De gebruiker van een API heeft niet altijd de volledige representatie (lees alle attributen) van een resource nodig. De mogelijkheid bieden om de gewenste attributen te selecteren helpt bij het beperken van het netwerkverkeer (relevant voor lichtgewicht toepassingen), vereenvoudigt het gebruik van de API en maakt deze aanpasbaar (op maat). Om dit mogelijk te maken wordt de query-parameter fields ondersteund. De query-parameter accepteert een door komma's gescheiden lijst met attribuutnamen. Het resultaat is een representatie op maat.
# In het geval van HAL zijn de gelinkte resources embedded in de standaard representatie. Met de hier beschreven fields parameter ontstaat de mogelijkheid om de inhoud van de body naar behoefte aan te passen.

Functionaliteit: Aanpasbare representatie met de fields parameter
  Het is mogelijk om een door komma's gescheiden lijst van attribuutnamen op te geven met de query-parameter fields om een representatie op maat te krijgen. Hierin kan elk attribuut van de resource worden opgenomen met exact de naam zoals deze wordt opgenomen in het antwoord.

  Wanneer de fields parameter niet wordt meegegeven in het request, worden alle attributen van de resource die een waarde hebben en waarvoor de afnemer (gemeente) is geautoriseerd teruggegeven in het antwoord. Dit is inclusief een verwijzing naar alle relaties in _links.

  Wanneer de fields parameter is meegegeven in het request, worden alleen de attributen van de resource teruggegeven die zijn genoemd in de fields parameter, een waarde hebben en waarvoor de afnemer is geautoriseerd.
  Dus wanneer de gebruiker vraagt om gegevens waarvoor zij of hij niet geautoriseerd is, wordt er minder teruggegeven dan er gevraagd is in de fields-parameter.

  Gevraagde attributen worden komma-gescheiden opgesomd. Bijvoorbeeld fields=burgerservicenummer,naam,geslachtsaanduiding.
  Gevraagde attributen kunnen in willekeurige volgorde worden opgenomen in de fields parameter. De volgorde waarin de gevraagde attributen worden opgesomd in de fields parameter heeft geen invloed op de volgorde waarin deze attributen worden opgenomen in het antwoord (volgorde is niet relevant in een json object).

  Groepen kunnen in gezamenlijkheid worden gevraagd door de naam van de groep op te nemen in de fields-parameter. In dat geval worden alle attributen van de groep opgenomen in het antwoord, voor zover ze een waarde hebben. Bijvoorbeeld fields=burgerservicenummer,naam geeft naast het burgerservicenummer alle attributen van de naam (geslachtsnaam, voornamen, voorvoegsel, enz.) terug.

  Attributen binnen een groep kunnen ook individueel worden bevraagd. De dot-notatie wordt gebruikt om specifieke attributen van een groep te selecteren. Bijvoorbeeld de voornamen, geboortedatum en geboorteplaats van een persoon kunnen worden opgevraagd via fields=naam.voornamen,geboorte.datum,geboorte.plaats.

  Met de fields parameter kan ook worden aangegeven welke relaties moeten worden opgenomen. Dit betreft de links (in _links) die verwijzen (uri) naar de betreffende gerelateerde resource. Wanneer de fields parameter is meegegeven in het request worden alleen die relaties teruggegeven die zijn gevraagd in de fields parameter.
  In de fields parameter kan de relatie worden gevraagd door de relatienaam op te nemen al dan niet voorafgegaan door HAL-element _links.
  Bijvoorbeeld de links naar de kinderen van een persoon worden teruggegeven bij fields=burgerservicenummer,naam,kinderen. In dat geval worden andere relaties, zoals ouders en partners niet opgenomen in het antwoord (in _links). Hetzelfde antwoord kan worden verkregen met fields=burgerservicenummer,naam,_links.kinderen.

  De self-link in _links (JSON HAL) wordt altijd teruggegeven in het antwoord. Deze hoeft (en mag) niet te worden opgenomen in de fields parameter.

  Attributen inOnderzoek worden meegegeven wanneer gevraagde attributen in onderzoek zijn. Zie in_onderzoek.feature voor uitleg wanneer attributen in onderzoek zijn.

  Attribuut indicatieGeheim wordt altijd meegegeven wanneer deze een waarde anders dan 0 heeft.

  Attributen datumOpschortingBijhouding en redenOpschortingBijhouding worden altijd meegegeven wanneer deze een waarde hebben.

  Gebruik van de fields parameter heeft geen invloed op eventueel meegeladen sub-resources. Dat wordt gestuurd via de expand parameter. Dus wanneer er specifieke attributen van een sub-resource gewenst zijn, worden die opgesomd in de expand parameter. Bijvoorbeeld expand=partners.geslachtsnaam. Zie verder expand.feature

  Gebruik van parameter fields zonder waarde (lege waarde) is equivalent aan het niet opnemen van de fields parameter. Wanneer de fields-parameter wordt opgenomen zonder waarde, worden alle attribbuten teruggegeven met een waarden en waarvoor autorisatie is.

  Wanneer in de fields-parameter namen zijn opgenomen die niet voorkomen als attribuut in de resource, wordt een foutmelding gegeven.

  In de fields-parameter moeten attribuutnamen exact zo worden geschreven als voor de resource-response gedefinieerd. Dit is case sensitive. Bijvoorbeeld fields=BURGERSERVICENUMMER levert een foutmelding, want dat attribuut bestaat niet (attribuut burgerservicenummer bestaat wel).


  Achtergrond:
    Gegeven de registratie ingeschreven personen kent zoals beschreven in testdata.csv
    En in onderstaande scenario's wordt de expand parameter niet gebruikt, tenzij expliciet aangegeven
    En de gebruiker geautoriseerd is voor gevraagde gegevens, tenzij expliciet anders aangegeven

  Scenario: De fields-parameter is niet opgenomen
    Als een ingeschreven persoon wordt geraadpleegd zonder fields-parameter
    Dan worden alle attributen van de resource teruggegeven
    En worden alle relaties van de resource teruggegeven
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

  Scenario: Slechts één enkel attribuut wordt gevraagd
    Als een ingeschreven persoon wordt geraadpleegd met fields=geslachtsaanduiding
    Dan wordt attribuut geslachtsaanduiding teruggegeven
    En wordt geen enkel ander attribuut dan geslachtsaanduiding teruggegeven
    En wordt geen enkele relatie van de resource in _links teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

  Scenario: Meerdere attributen worden gevraagd
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,burgerlijkeStaat,geslachtsaanduiding
    Dan wordt attribuut burgerservicenummer teruggegeven
    En wordt attribuut burgerlijkeStaat teruggegeven
    En wordt attribuut geslachtsaanduiding teruggegeven
    En wordt geen enkel ander attribuut dan burgerservicenummer, burgerlijkeStaat en geslachtsaanduiding teruggegeven
    En wordt geen enkele relatie van de resource in _links teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

  Scenario: Hele groep wordt gevraagd
    Gegeven de te raadplegen persoon heeft voornamen, geslachtsnaam en voorvoegsel
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam
    Dan wordt attribuut burgerservicenummer teruggegeven
    En wordt attribuut naam.voornamen teruggegeven
    En wordt attribuut naam.geslachtsnaam teruggegeven
    En wordt attribuut naam.voorvoegsel teruggegeven
    En wordt geen enkel ander attribuut dan burgerservicenummer en naam teruggegeven
    En wordt geen enkele relatie van de resource in _links teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

  Scenario: Een of enkele attributen binnen een groep worden gevraagd
    Als een ingeschreven persoon wordt geraadpleegd met fields=naam.aanschrijfwijze
    Dan wordt attribuut naam.aanschrijfwijze teruggegeven
    En wordt in naam geen enkel ander attribuut dan aanschrijfwijze teruggegeven
    En wordt geen enkel ander attribuut dan naam en _links teruggegeven
    En wordt geen enkele relatie van de resource in _links teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

    Als een ingeschreven persoon wordt geraadpleegd met fields=naam.voorvoegsel,naam.geslachtsnaam
    Dan wordt attribuut naam.geslachtsnaam teruggegeven
    En wordt attribuut naam.voorvoegsel teruggegeven
    En wordt in naam geen enkel ander attribuut dan voorvoegsel en geslachtsnaam teruggegeven
    En wordt geen enkele relatie van de resource in _links teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

  Scenario: Relaties (links) vragen (en beperken) in het antwoord
    Gegeven de te raadplegen persoon heeft een actuele partner(partnerschap of huwelijk), ouders en kinderen
    En de te raadplegen persoon heeft een BAG-adres (nummeraanduiding) als verblijfplaats

    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam,partners
    Dan wordt attribuut _links.partners teruggegeven
    En wordt attribuut burgerservicenummer teruggegeven
    En wordt attribuut naam.voornamen teruggegeven
    En wordt attribuut naam.geslachtsnaam teruggegeven
    En wordt attribuut naam.voorvoegsel teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt in _links geen enkel ander attribuut dan self en partners teruggegeven
    En is elke link partners een geldige uri
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam,ouders
    Dan wordt attribuut _links.ouders teruggegeven
    En wordt attribuut burgerservicenummer teruggegeven
    En wordt attribuut naam.voornamen teruggegeven
    En wordt attribuut naam.geslachtsnaam teruggegeven
    En wordt attribuut naam.voorvoegsel teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt in _links geen enkel ander attribuut dan self en ouders teruggegeven
    En is elke link ouders een geldige uri
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam,kinderen
    Dan wordt attribuut _links.kinderen teruggegeven
    En wordt attribuut burgerservicenummer teruggegeven
    En wordt attribuut naam.voornamen teruggegeven
    En wordt attribuut naam.geslachtsnaam teruggegeven
    En wordt attribuut naam.voorvoegsel teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt in _links geen enkel ander attribuut dan self en kinderen teruggegeven
    En is elke link kinderen een geldige uri
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,naam,partners,ouders
    Dan wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.ouders teruggegeven
    En wordt attribuut burgerservicenummer teruggegeven
    En wordt attribuut naam.voornamen teruggegeven
    En wordt attribuut naam.geslachtsnaam teruggegeven
    En wordt attribuut naam.voorvoegsel teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt in _links geen enkel ander attribuut dan self, partners en ouders teruggegeven
    En is elke link partners een geldige uri
    En is elke link ouders een geldige uri
    En wordt er geen gerelateerde sub-resource teruggegeven in _embedded

  Scenario: Gebruik van de fields parameter heeft geen invloed op embedded sub-resources
    Als een ingeschreven persoon wordt geraadpleegd met fields=partners&expand=kinderen
    Dan wordt attribuut _links.partners teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt in _links geen enkel ander attribuut dan self en partners teruggegeven
    En wordt attribuut _embedded.kinderen teruggegeven
    En wordt in _embedded geen enkel ander attribuut dan kinderen teruggegeven
    En wordt geen enkel ander attribuut dan _links en _embedded teruggegeven

    Als een ingeschreven persoon wordt geraadpleegd met fields=naam&expand=kinderen
    Dan wordt attribuut naam teruggegeven
    En wordt attribuut _links.self teruggegeven
    En wordt in _links geen enkel ander attribuut dan self teruggegeven
    En wordt geen enkel ander attribuut dan naam, _links en _embedded teruggegeven
    En wordt attribuut _embedded.kinderen teruggegeven
    En wordt attribuut _embedded.kinderen.burgerservicenummer teruggegeven
    # wordt op de resource niet gevraagd (fields), maar van de sub-resource wel (expand)
    En wordt attribuut _embedded.kinderen.geboorte teruggegeven
    En wordt attribuut _embedded.kinderen._links.ingeschrevenpersonen teruggegeven

  Scenario: Lege fields parameter geeft alle attributen
    Als een ingeschreven persoon wordt geraadpleegd met fields=
    Dan levert dit alle attributen die een waarde hebben en waarvoor autorisatie is

  Scenario: Fields parameter met attribuutnaam die niet bestaat
    Als een ingeschreven persoon wordt geraadpleegd met fields=burgerservicenummer,geslachtsaanduiding,bestaatniet
    Dan levert dit een foutmelding

    Als een ingeschreven persoon wordt geraadpleegd met fields=BurgerServiceNummer
    Dan levert dit een foutmelding

    Als een ingeschreven persoon wordt geraadpleegd met expand=kinderen&fields=kinderen.naam
    Dan levert dit een foutmelding

  Scenario: Fields bevat attributen waarvoor de gebruiker niet geautoriseerd is
    Gegeven de gebruiker is geautoriseerd voor geboortedatum
    En de gebruiker is niet geautoriseerd voor geboorteplaats
    Als een ingeschreven persoon wordt geraadpleegd met fields=geboorte
    Dan wordt attribuut geboorte.datum teruggegeven
    En is in het antwoord attribuut geboorte.plaats niet aanwezig
    En wordt attribuut _links.self teruggegeven
    En wordt in _links geen enkel ander attribuut dan self teruggegeven

    Gegeven de gebruiker is geautoriseerd voor geboortedatum
    En de gebruiker is niet geautoriseerd voor geboorteplaats
    Als een ingeschreven persoon wordt geraadpleegd met fields=geboorte.datum,geboorte.plaats
    Dan wordt attribuut geboorte.datum teruggegeven
    En is in het antwoord attribuut geboorte.plaats niet aanwezig
    En wordt attribuut _links.self teruggegeven
    En wordt in _links geen enkel ander attribuut dan self teruggegeven

  Scenario: Fields bevat attributen die bij de geraadpleegde persoon geen waarde hebben
    Gegeven de te raadplegen persoon verblijft in het buitenland
    Als een ingeschreven persoon wordt geraadpleegd met fields=verblijfplaats.postcode,verblijfplaats.huisnummer,verblijfplaats.verblijfBuitenland
    Dan wordt attribuut verblijfplaats.verblijfBuitenland teruggegeven
    En is in het antwoord attribuut verblijfplaats.postcode afwezig
    En is in het antwoord attribuut verblijfplaats.huisnummer afwezig

  Scenario: inOnderzoek wordt altijd teruggegeven wanneer dat van toepassing is
    Gegeven de te raadplegen persoon heeft geboortedatum in onderzoek (83.10 = 010310)
    Als een ingeschreven persoon wordt geraadpleegd met fields=geboorte.datum
    Dan wordt attribuut geboorte.datum teruggegeven
    En wordt attribuut geboorte.inOnderzoek.datum teruggegeven
    En is in het antwoord attribuut geboorte.inOnderzoek.plaats afwezig
    En is in het antwoord attribuut inOnderzoek afwezig

    Gegeven de te raadplegen persoon heeft naam in onderzoek (83.10 = 010200)
    Als een ingeschreven persoon wordt geraadpleegd met fields=naam
    Dan is in het antwoord naam.inOnderzoek.voornamen=true
    En is in het antwoord naam.inOnderzoek.adellijkeTitel_predikaat=true
    Dan is in het antwoord naam.inOnderzoek.voorvoegsel=true
    Dan is in het antwoord naam.inOnderzoek.geslachtsnaam=true
    En is in het antwoord attribuut naam.inOnderzoek.aanduidingNaamgebruik afwezig
    En is in het antwoord attribuut inOnderzoek afwezig

    Gegeven de te raadplegen persoon heeft naam in onderzoek (83.10 = 010200)
    Als een ingeschreven persoon wordt geraadpleegd met fields=naam.voornamen,naam.geslachtsnaam
    Dan is in het antwoord naam.inOnderzoek.voornamen=true
    En is in het antwoord attribuut naam.inOnderzoek.adellijkeTitel_predikaat afwezig
    En is in het antwoord attribuut naam.inOnderzoek.voorvoegsel afwezig
    En is in het antwoord naam.inOnderzoek.geslachtsnaam=true
    En is in het antwoord attribuut naam.inOnderzoek.aanduidingNaamgebruik afwezig
    En is in het antwoord attribuut inOnderzoek afwezig

    Gegeven de te raadplegen persoon heeft naam in onderzoek (83.10 = 010200)
    Als een ingeschreven persoon wordt geraadpleegd met fields=geboorte
    Dan is in het antwoord attribuut naam.inOnderzoek afwezig
    En is in het antwoord attribuut geboorte.inOnderzoek afwezig
    En is in het antwoord attribuut inOnderzoek afwezig

    Gegeven de te raadplegen persoon heeft de hele categorie persoon in onderzoek (83.10 = 010000)
    Als een ingeschreven persoon wordt geraadpleegd met fields=geboorte
    Dan is in het antwoord geboorte.inOnderzoek.datum=true
    En is in het antwoord geboorte.inOnderzoek.plaats=true
    En is in het antwoord geboorte.inOnderzoek.land=true
    En is in het antwoord attribuut naam.inOnderzoek afwezig
    En is in het antwoord attribuut inOnderzoek afwezig

  Scenario: indicatie geheim wordt altijd meegegeven wanneer deze een waarde heeft anders dan 0
    Gegeven de te raadplegen persoon heeft indicatie geheim "niet aan kerken" (70.10 = 2)
    Als een ingeschreven persoon wordt geraadpleegd met fields=geslachtsaanduiding
    Dan wordt attribuut geslachtsaanduiding teruggegeven
    En wordt attribuut indicatieGeheim teruggegeven
    En is in het antwoord indicatieGeheim=2
    En wordt attribuut _links.self teruggegeven
    En wordt geen enkel ander attribuut dan geslachtsaanduiding, indicatieGeheim en _links.self teruggegeven

    Gegeven de te raadplegen persoon heeft indicatie geheim "geen beperking" (70.10 = 0)
    Als een ingeschreven persoon wordt geraadpleegd met fields=geslachtsaanduiding
    Dan wordt attribuut geslachtsaanduiding teruggegeven
    En is in het antwoord attribuut indicatieGeheim afwezig
    En wordt attribuut _links.self teruggegeven
    En wordt geen enkel ander attribuut dan geslachtsaanduiding en _links.self teruggegeven

    Gegeven de te raadplegen persoon heeft indicatie geheim "geen beperking" (70.10 = 0)
    Als een ingeschreven persoon wordt geraadpleegd met fields=geslachtsaanduiding,indicatieGeheim
    Dan wordt attribuut geslachtsaanduiding teruggegeven
    En wordt attribuut indicatieGeheim teruggegeven
    En is in het antwoord indicatieGeheim=0
    En wordt attribuut _links.self teruggegeven
    En wordt geen enkel ander attribuut dan geslachtsaanduiding, indicatieGeheim en _links.self teruggegeven

  Scenario: reden opschorting bijhouding wordt altijd meegegeven wanneer deze een waarde heeft
    Gegeven de te raadplegen persoon heeft Datum opschorting bijhouding = "20100101"
    En de te raadplegen persoon heeft Omschrijving reden opschorting bijhouding (67.20) = "E" (emigratie)
    Als een ingeschreven persoon wordt geraadpleegd met fields=geslachtsaanduiding
    Dan wordt attribuut geslachtsaanduiding teruggegeven
    En wordt attribuut datumOpschortingBijhouding teruggegeven
    En wordt attribuut redenOpschortingBijhouding teruggegeven
    En is in het antwoord datumOpschortingBijhouding.datum=2010-01-01
    En is in het antwoord redenOpschortingBijhouding=E
    En wordt attribuut _links.self teruggegeven
    En wordt geen enkel ander attribuut dan geslachtsaanduiding, datumOpschortingBijhouding, redenOpschortingBijhouding en _links.self teruggegeven
