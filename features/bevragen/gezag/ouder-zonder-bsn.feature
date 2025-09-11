# language: nl
Functionaliteit: gezagsrelatie bij minderjarige met een ouder zonder burgerservicenummer
# regels of scenarios zonder een @[xxx]-api tag beschrijven de functionaliteit van de BRP API (personen, bewoning, verblijfplaatshistorie, reisdocumenten)
# - hiervoor is gekozen omdat er van uitgegaan wordt dat een scenario standaard een functionaliteit van de BRP API beschrijft
# - een scenario zonder een @[xxx]-api tag is uitvoerbaar voor alle onderliggende microservices
# - als een scenario de functionaliteit van een onderliggende microservice (informatie-, data- of gezag service) beschrijft, dan wordt de scenario getagd met respectievelijk @info-api, @data-api of @gezag-api
# - de regels en scenarios zonder tags of met @info-api tag worden gepubliceerd als documentatie
# - een regel of een scenario die wordt gedeprecate, wordt getagd met @deprecated. Een deprecated regel of scenario wordt niet gepubliceerd als documentatie, maar wordt wel uitgevoerd om de werking van de te deprecaten functionaliteit te valideren
# - scenarios die niet worden uitgevoerd, worden getagd met @skip-verify

  Achtergrond:
    Gegeven adres 'A1'
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      |                 0599 |                         0599010000208579 |
    En de persoon 'Albers' met burgerservicenummer '000000024'
    * is meerderjarig
    En de persoon 'Jansen' zonder burgerservicenummer
    * is meerderjarig
    En 'Albers' en 'Jansen' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      |                                                           20000401 |
    En de persoon 'Gerda' met burgerservicenummer '000000012'
    * is in Nederland geboren
    En de persoon 'Gerda' heeft de volgende gegevens
      | geboortedatum (03.10) |
      | vandaag - 2 jaar      |
    En 'Gerda' is vandaag 2 jaar geleden ingeschreven op adres 'A1'

  Regel: een minderjarige geboren (of erkend) na 1-1-2023 met twee ouders waarvan één zonder burgerservicenummer heeft gezamenlijk ouderlijk gezag

    @info-api @data-api
    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      Gegeven persoon 'Gerda'
      * heeft 'Jansen' als ouder 1
      * heeft 'Albers' als ouder 2
      Als 'gezag' wordt gevraagd van personen gezocht met adresseerbaar object identificatie van 'A1'
      Dan is het gezag over 'Gerda' gezamenlijk ouderlijk gezag met ouder 'Jansen' en ouder 'Albers'

    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      Gegeven persoon 'Gerda'
      * heeft 'Jansen' als ouder 1
      * heeft 'Albers' als ouder 2
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Gerda'
      Dan is het gezag over 'Gerda' gezamenlijk ouderlijk gezag met ouder 'Jansen' en ouder 'Albers'

  @deprecated
  Regel: voor een minderjarige geboren (of erkend) na 1-1-2023 met twee ouders waarvan één zonder burgerservicenummer is het gezag niet te bepalen

    @info-api @data-api
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      Gegeven persoon 'Gerda'
      * heeft 'Jansen' als ouder 1
      * heeft 'Albers' als ouder 2
      Als 'gezag' wordt gevraagd van personen gezocht met adresseerbaar object identificatie van 'A1'
      Dan is het gezag over 'Gerda' niet te bepalen met de toelichting 'Van één of beide ouders is de burgerservicenummer niet bekend'

    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      Gegeven persoon 'Gerda'
      * heeft 'Jansen' als ouder 1
      * heeft 'Albers' als ouder 2
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Gerda'
      Dan is het gezag over 'Gerda' niet te bepalen met de toelichting 'Van één of beide ouders is de burgerservicenummer niet bekend'

  # TODO: scenario toevoegen voor gezamenlijk gezag met ouder zonder burgerservicenummer
