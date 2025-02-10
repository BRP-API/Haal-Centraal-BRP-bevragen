#language: nl

Functionaliteit: gezagsrelatie bij minderjarige met één of twee ouders zonder burgerservicenummer

  @info-api
  Regel: een minderjarige geboren (of erkend) na 1-1-2023 met twee ouders heeft gezamenlijk ouderlijk gezag ongeacht of één of beide ouders geen burgerservicenummer hebben

    @info-api
    Scenario: minderjarige geboren na 1-1-2023 heeft twee ouders zonder burgerservicenummer
      Gegeven de persoon
        | burgerservicenummer | geboortedatum    | voornamen | geslachtsnaam |
        | 000000012           | vandaag - 2 jaar | Gerda     | Jansen        |
      * heeft de volgende personen zonder burgerservicenummer als ouder
        | voornamen | geslachtsnaam |
        | Jan       | Jansen        |
        | Jeanine   | Albers        |
      Als het 'gezag' veld van 'Gerda' wordt gevraagd
      Dan heeft de response een persoon met gezagsrelatie
        | type                  |
        | GezamenOuderlijkGezag |
      * heeft de gezagsrelatie de minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * heeft de gezagsrelatie de ouders
        | naam.volledigeNaam |
        | Jan Jansen         |
        | Jeanine Albers     |
      En heeft de persoon een gezag
        | type                      |
        | TweehoofdigOuderlijkGezag |
      * heeft het gezag de minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * heeft het gezag de ouders
        | type           | naam.volledigeNaam |
        | OuderZonderBsn | Jan Jansen         |
        | OuderZonderBsn | Jeanine Albers     |

    @info-api
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
      Dan heeft de response een persoon met gezagsrelatie
        | type                      |
        | GezamenlijkOuderlijkGezag |
      * heeft de gezagsrelatie de minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * heeft de gezagsrelatie de ouders
        | burgerservicenummer | naam.volledigeNaam |
        |                     | Jan Jansen         |
        | 000000024           | Jeanine Albers     |
      En heeft de persoon een gezag
        | type                      |
        | TweehoofdigOuderlijkGezag |
      * heeft het gezag de minderjarige
        | burgerservicenummer | naam.volledigeNaam | leeftijd |
        | 000000012           | Gerda Jansen       | 2        |
      * heeft het gezag de ouders
        | type           | burgerservicenummer | naam.volledigeNaam |
        | OuderZonderBsn |                     | Jan Jansen         |
        | OuderMetBsn    | 000000024           | Jeanine Albers     |

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
      Dan heeft de response een persoon met gezagsrelatie
      | type                      |
      | GezamenlijkOuderlijkGezag |
      * heeft de gezagsrelatie de minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar |
      * heeft de gezagsrelatie de ouders
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
      Dan heeft de response een persoon met gezagsrelatie
      | type                      |
      | GezamenlijkOuderlijkGezag |
      * heeft de gezagsrelatie de minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum |
        | 000000012           | Gerda          | Jansen             | 2023-01-02     |
      * heeft de gezagsrelatie de ouders
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam |
        |                     | Jan            | Jansen             |
        | 000000024           | Jeanine        | Albers             |

  @gezag-api
  Regel: de velden van de gezagshouder(s) en de minderjarige worden door de gezag-api uit de persoonslijst van de minderjarige gehaald

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
      Dan heeft de response een persoon met gezagsrelatie
      | type                      |
      | GezamenlijkOuderlijkGezag |
      * heeft de gezagsrelatie de minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar |
      * heeft de gezagsrelatie de ouders
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
      Dan heeft de response een persoon met gezagsrelatie
      | type                      |
      | GezamenlijkOuderlijkGezag |
      * heeft de gezagsrelatie de minderjarige
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geboorte.datum   |
        | 000000012           | Gerda          | Jansen             | vandaag - 2 jaar |
      * heeft de gezagsrelatie de ouders
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam |
        |                     | Jan            | Jansen             |
        | 000000024           | Jeanine        | Albers             |
