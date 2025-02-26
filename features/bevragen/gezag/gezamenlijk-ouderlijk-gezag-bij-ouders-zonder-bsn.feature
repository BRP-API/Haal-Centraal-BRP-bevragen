#language: nl

Functionaliteit: gezagsrelatie bij minderjarige met één of twee ouders zonder burgerservicenummer

    Achtergrond:
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0599                 | 0599010000208579                         |
      En de persoon 'Gerda'
        | burgerservicenummer (01.20) | geboortedatum (03.10) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | 000000012                   | vandaag - 2 jaar      | Gerda             | Jansen                | V                           |
      * is ingeschreven op adres 'A1' op 'vandaag - 2 jaar'
      
  @info-api
  Regel: een minderjarige geboren (of erkend) na 1-1-2023 met twee ouders heeft gezamenlijk ouderlijk gezag ongeacht of één of beide ouders geen burgerservicenummer hebben

    @info-api
    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
        | Jeanine           | Albers                | V                           |
      Als het 'gezagsrelaties' veld van <zoek methode>
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

    @info-api
    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
      * heeft de volgende persoon als ouder
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | 000000024                   | Jeanine           | Albers                | V                           |
      Als het 'gezagsrelaties' veld van <zoek methode>
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

  @info-api @deprecated
  Regel: wanneer gezag (fields veld bevat een string met waarde 'gezag') wordt gevraagd voor een minderjarige met één of twee ouders zonder burgerservicenummer, dan is het gezag niet te bepalen .

    @info-api @deprecated
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
      
    @info-api @deprecated
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
      Als het 'gezagsrelaties' veld van <zoek methode>
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
      
    @data-api
    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | Jan               | Jansen                | M                           |
      * heeft de volgende persoon als ouder
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
        | 000000024                   | Jeanine           | Albers                | V                           |
      Als het 'gezagsrelaties' veld van <zoek methode>
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum | geslacht.code | geslacht.omschrijving |
        | 000000012           | Gerda          | Jansen             | 2023-01-02     | V             | vrouw                 |
      * met een ouder
        | naam.voornamen | naam.geslachtsnaam | geslacht.code | geslacht.omschrijving |
        | Jan            | Jansen             | M             | man                   |
      * met nog een ouder
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geslacht.code | geslacht.omschrijving |
        | 000000024           | Jeanine        | Albers             | V             | vrouw                 |

      Voorbeelden:
      | zoek methode                                          |
      | 'Gerda' wordt gevraagd                                |
      | de personen ingeschreven op adres 'A1' wordt gevraagd |

    @data-api @deprecated
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
      
    @data-api @deprecated
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


  @gezag-api
  Regel: de velden van de gezagshouder(s) en de minderjarige worden door de gezag-api uit de persoonslijst van de minderjarige gehaald. De gezag-api levert voor elke bevraging zowel de oude (gezag veld) als de nieuwe (gezagsrelaties veld) gezagsverhouding variant

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
      En heeft de persoon een gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   | geslacht.code |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar | V             |
      * met ouders
        | naam.voornamen | naam.geslachtsnaam | geslacht.code |
        | Jan            | Jansen             | M             |
        | Jeanine        | Albers             | V             |
      En heeft de persoon een gezag
        | type               | toelichting                                                   |
        | GezagNietTeBepalen | Van één of beide ouders is de burgerservicenummer niet bekend |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |

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
      En heeft de persoon een gezag
        | type               | toelichting                                                   |
        | GezagNietTeBepalen | Van één of beide ouders is de burgerservicenummer niet bekend |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
