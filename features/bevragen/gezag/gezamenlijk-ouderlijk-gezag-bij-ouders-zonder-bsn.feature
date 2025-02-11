#language: nl

Functionaliteit: gezagsrelatie bij minderjarige met één of twee ouders zonder burgerservicenummer

  @info-api
  Regel: een minderjarige geboren (of erkend) na 1-1-2023 met twee ouders heeft gezamenlijk ouderlijk gezag ongeacht of één of beide ouders geen burgerservicenummer hebben

# Wanneer het nieuwe gezag (gezagsrelaties) naast het oude komt te staan, moet wanneer met fields is gezag of gezagsrelaties beide velden worden geleverd
# De oude GezagOuder wordt niet gewijzigd. Wat moet er als burgerservicenummer worden geleverd? 0000000 of een lege string ("")?

    @info-api
    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      Gegeven de persoon
        | burgerservicenummer | geboortedatum    | voornamen | geslachtsnaam |
        | 000000012           | vandaag - 2 jaar | Gerda     | Jansen        |
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen | geslachtsnaam |
        | Jan       | Jansen        |
        | Jeanine   | Albers        |
      Als het '<fields>' veld van 'Gerda' wordt gevraagd
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
      En heeft de persoon een gezag
        | type                      |
        | TweehoofdigOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * met ouders
        | burgerservicenummer | naam.volledigeNaam |
        | 000000000           | Jan Jansen         |
        | lege string         | Jeanine Albers     |

      Voorbeelden:
      | fields         |
      | gezag          |
      | gezagsrelaties |
      
    @info-api
    Abstract Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      Gegeven de persoon
        | burgerservicenummer | geboortedatum    | voornamen | geslachtsnaam |
        | 000000012           | vandaag - 2 jaar | Gerda     | Jansen        |
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen | geslachtsnaam |
        | Jan       | Jansen        |
      * heeft de volgende persoon als ouder
        | burgerservicenummer | voornamen | geslachtsnaam |
        | 000000024           | Jeanine   | Albers        |
      Als het '<fields>' veld van 'Gerda' wordt gevraagd
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
      En heeft de persoon een gezag
        | type                      |
        | TweehoofdigOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * met ouders
        | burgerservicenummer | naam.volledigeNaam |
        | lege string         | Jan Jansen         |
        | 000000024           | Jeanine Albers     |

      Voorbeelden:
      | fields         |
      | gezag          |
      | gezagsrelaties |

  @data-api
  Regel: gezagsrelaties opgevraagd via de gezag-api worden één op één doorgeleverd

    @data-api
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      Gegeven de persoon
        | burgerservicenummer | geboortedatum    | voornamen | geslachtsnaam |
        | 000000012           | vandaag - 2 jaar | Gerda     | Jansen        |
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen | geslachtsnaam |
        | Jan       | Jansen        |
        | Jeanine   | Albers        |
      Als het 'gezagsrelaties' veld van 'Gerda' wordt gevraagd
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar |
      * met ouders
        | naam.voornamen | naam.geslachtsnaam |
        | Jan            | Jansen             |
        | Jeanine        | Albers             |

    @data-api
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      Gegeven de persoon
        | burgerservicenummer | geboortedatum | voornamen | geslachtsnaam |
        | 000000012           | 2023-01-02    | Gerda     | Jansen        |
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen | geslachtsnaam |
        | Jan       | Jansen        |
      * heeft de volgende persoon als ouder
        | burgerservicenummer | voornamen | geslachtsnaam |
        | 000000024           | Jeanine   | Albers        |
      Als het 'gezagsrelaties' veld van 'Gerda' wordt gevraagd
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum |
        | 000000012           | Gerda          | Jansen             | 2023-01-02     |
      * met een ouder
        | naam.voornamen | naam.geslachtsnaam |
        | Jan            | Jansen             |
      * met noge een ouder
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam |
        | 000000024           | Jeanine        | Albers             |

  @gezag-api
  Regel: de velden van de gezagshouder(s) en de minderjarige worden door de gezag-api uit de persoonslijst van de minderjarige gehaald

  # Levert de gezag-api alleen voor een ouder de naam gegevens of ook voor de andere personen in een gezagsrelatie (minderjarige, derde)?


    @gezag-api
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      Gegeven de persoon
        | burgerservicenummer | geboortedatum    | voornamen | geslachtsnaam |
        | 000000012           | vandaag - 2 jaar | Gerda     | Jansen        |
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen | geslachtsnaam |
        | Jan       | Jansen        |
        | Jeanine   | Albers        |
      Als het 'gezagsrelaties' veld van 'Gerda' wordt gevraagd
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar |
      * met ouders
        | naam.voornamen | naam.geslachtsnaam |
        | Jan            | Jansen             |
        | Jeanine        | Albers             |

    @gezag-api
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders waarvan één zonder burgerservicenummer
      Gegeven de persoon
        | burgerservicenummer | geboortedatum    | voornamen | geslachtsnaam |
        | 000000012           | vandaag - 2 jaar | Gerda     | Jansen        |
      * heeft de volgende persoon zonder burgerservicenummer als ouder
        | voornamen | geslachtsnaam |
        | Jan       | Jansen        |
      * heeft de volgende persoon als ouder
        | burgerservicenummer | voornamen | geslachtsnaam |
        | 000000024           | Jeanine   | Albers        |
      Als het 'gezagsrelaties' veld van 'Gerda' wordt gevraagd
      Dan heeft de response een persoon
      En heeft de persoon een gezagsrelatie
      | type                      |
      | GezamenlijkOuderlijkGezag |
      * met minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar |
      * met een ouder
        | naam.voornamen | naam.geslachtsnaam |
        | Jan            | Jansen             |
      * met nog een ouder
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam |
        | 000000024           | Jeanine        | Albers             |
