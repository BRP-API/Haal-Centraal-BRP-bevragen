#language: nl

Functionaliteit: gezagsrelatie bij minderjarige met één of twee ouders zonder burgerservicenummer

# regels of scenarios zonder een @[xxx]-api beschrijven de functionaliteit van de BRP API (personen, bewoning, verblijfplaatshistorie, reisdocumenten)
# - hiervoor is gekozen omdat er van uitgegaan wordt dat een scenario standaard een functionaliteit van de BRP API beschrijft
# - als een scenario de functionaliteit van een onderliggende microservice (informatie-, data- of gezag service) beschrijft, dan wordt de scenario getagd met respectievelijk @info-api, @data-api of @gezag-api
# - de regels en scenarios zonder @[xxx]-api tag worden gepubliceerd als documentatie
# - een regel of een scenario die wordt gedeprecate, wordt getagd met @deprecated. Een deprecated regel of scenario wordt niet gepubliceerd als documentatie, maar wordt wel uitgevoerd om de werking van de te deprecaten functionaliteit te valideren
# - scenarios die niet worden uitgevoerd, worden getagd met @skip-verify
# - een scenario die moet worden uitgevoerd in de context van een legacy gezag consumer, moet worden getagd met @legacy-gezag-consumer

    Achtergrond:
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0599                 | 0599010000208579                         |
      En de persoon 'Gerda'
        | burgerservicenummer (01.20) | geboortedatum (03.10) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | 000000012                   | vandaag - 2 jaar      | Gerda             | Jansen                | V                           |
      * is ingeschreven op adres 'A1' op 'vandaag - 2 jaar'
      
  Regel: een minderjarige geboren (of erkend) na 1-1-2023 met twee ouders heeft gezamenlijk ouderlijk gezag ongeacht of één of beide ouders een burgerservicenummer hebben

    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
        | Jeanine           | Albers                | V                           |
      Als het 'gezag' veld van <zoek methode>
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * met ouders
        | naam.volledigeNaam |
        | Jan Jansen         |
        | Jeanine Albers     |

      Voorbeelden:
      | zoek methode                                          |
      | 'Gerda' wordt gevraagd                                |
      | de personen ingeschreven op adres 'A1' wordt gevraagd |

    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
      * heeft de volgende persoon als ouder
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | 000000024                   | Jeanine           | Albers                | V                           |
      Als het 'gezag' veld van <zoek methode>
      Dan heeft de response een persoon
      En heeft de persoon een 'gezagsrelatie'
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * met een ouder
        | naam.volledigeNaam |
        | Jan Jansen         |
      * met nog een ouder   
        | burgerservicenummer | naam.volledigeNaam |
        | 000000024           | Jeanine Albers     |

      Voorbeelden:
      | zoek methode                                          |
      | 'Gerda' wordt gevraagd                                |
      | de personen ingeschreven op adres 'A1' wordt gevraagd |

    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft één ouder en de ouder heeft geen burgerservicenummer
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jeanine           | Albers                | V                           |
      Als het 'gezag' veld van <zoek methode>
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
        | type                     |
        | EenhoofdigOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * met ouder
        | naam.volledigeNaam |
        | Jeanine Albers     |

      Voorbeelden:
      | zoek methode                                          |
      | 'Gerda' wordt gevraagd                                |
      | de personen ingeschreven op adres 'A1' wordt gevraagd |

    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft een ouder zonder burgerservicenummer en een voogd

  @deprecated
  Regel: wanneer de gezagsrelatie wordt gevraagd van een minderjarige met één of twee ouders zonder burgerservicenummer door een legacy gezag consumer, dan is de gezagsrelatie niet te bepalen.

    @deprecated @legacy-gezag-consumer
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
        | Jeanine           | Albers                | V                           |
      Als het 'gezag' veld van <zoek methode>
      Dan heeft de response een persoon
      En heeft de persoon een gezag
        | type               | toelichting                                                   |
        | GezagNietTeBepalen | Van één of beide ouders is de burgerservicenummer niet bekend |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |

      Voorbeelden:
      | zoek methode                                          |
      | 'Gerda' wordt gevraagd                                |
      | de personen ingeschreven op adres 'A1' wordt gevraagd |
      
    @deprecated @legacy-gezag-consumer
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
      * heeft de volgende persoon als ouder
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | 000000024                   | Jeanine           | Albers                | V                           |
      Als het 'gezag' veld van <zoek methode>
      Dan heeft de response een persoon
      En heeft de persoon een gezag
        | type               | toelichting                                                   |
        | GezagNietTeBepalen | Van één of beide ouders is de burgerservicenummer niet bekend |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |

      Voorbeelden:
      | zoek methode                                          |
      | 'Gerda' wordt gevraagd                                |
      | de personen ingeschreven op adres 'A1' wordt gevraagd |

  @data-api
  Regel: gezag en/of gezagsrelaties opgevraagd via de gezag-api worden één op één doorgeleverd. Omschrijving voor het geslacht veld wordt toegevoegd

    @data-api
    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
        | Jeanine           | Albers                | V                           |
      Als het 'gezag' veld van <zoek methode>
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   | geslacht.code | geslacht.omschrijving |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar | V             | vrouw                 |
      * met ouders
        | naam.voornamen | naam.geslachtsnaam | geslacht.code | geslacht.omschrijving |
        | Jan            | Jansen             | M             | man                   |
        | Jeanine        | Albers             | V             | vrouw                 |

      Voorbeelden:
      | zoek methode                                          |
      | 'Gerda' wordt gevraagd                                |
      | de personen ingeschreven op adres 'A1' wordt gevraagd |
      
    @data-api @deprecated @legacy-gezag-consumer
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
        | Jeanine           | Albers                | V                           |
      Als het 'gezag' veld van <zoek methode>
      Dan heeft de response een persoon
      En heeft de persoon een gezag
        | type               | toelichting                                                   |
        | GezagNietTeBepalen | Van één of beide ouders is de burgerservicenummer niet bekend |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |

      Voorbeelden:
      | zoek methode                                          |
      | 'Gerda' wordt gevraagd                                |
      | de personen ingeschreven op adres 'A1' wordt gevraagd |
      

  @gezag-api
  Regel: de velden van de gezagshouder(s) en de minderjarige worden door de gezag-api uit de persoonslijst van de minderjarige gehaald. De gezag-api levert gezag met de nieuwe gezagsrelatie type als de request de 'accept-gezag-version' header met waarde '2' bevat. In alle andere gevallen wordt gezag met de oude gezagsrelatie type geleverd

    @gezag-api
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
        | Jeanine           | Albers                | V                           |
      Als gezag wordt gevraagd van 'Gerda'
      Dan heeft de response een persoon
        | burgerservicenummer |
        | 000000012           |
      En heeft de persoon een gezag
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   | geslacht.code |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar | V             |
      * met ouders
        | naam.voornamen | naam.geslachtsnaam | geslacht.code |
        | Jan            | Jansen             | M             |
        | Jeanine        | Albers             | V             |

    @gezag-api
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
      * heeft de volgende persoon als ouder
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | 000000024                   | Jeanine           | Albers                | V                           |
      Als gezag wordt gevraagd van 'Gerda'
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   | geslacht.code |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar | V             |
      * met een ouder
        | naam.voornamen | naam.geslachtsnaam | geslacht.code |
        | Jan            | Jansen             | M             |
      * met nog een ouder
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geslacht.code |
        | 000000024           | Jeanine        | Albers             | V             |

    @gezag-api @deprecated @legacy-gezag-consumer
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
        | Jeanine           | Albers                | V                           |
      Als gezag wordt gevraagd van 'Gerda'
      Dan heeft de response een persoon
        | burgerservicenummer |
        | 000000012           |
      En heeft de persoon een gezag
        | type               | toelichting                                                   |
        | GezagNietTeBepalen | Van één of beide ouders is de burgerservicenummer niet bekend |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   | geslacht.code |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar | V             |

    @gezag-api @deprecated @legacy-gezag-consumer
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
      * heeft de volgende persoon als ouder
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | 000000024                   | Jeanine           | Albers                | V                           |
      Als gezag wordt gevraagd van 'Gerda'
      Dan heeft de response een persoon
      En heeft de persoon een gezag
        | type               | toelichting                                                   |
        | GezagNietTeBepalen | Van één of beide ouders is de burgerservicenummer niet bekend |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   | geslacht.code |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar | V             |
