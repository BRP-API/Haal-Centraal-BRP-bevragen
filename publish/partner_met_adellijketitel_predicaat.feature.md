# Functionaliteit: Bij het opstellen van de aanhef maakt een adellijke titel of een predicaat van de partner onderdeel van uit.

## Regel: De aanhef voor een persoon wordt bepaald door het adellijkeTitelPredicaat van de (ex)partner onder de volgende condities:

### Abstract Scenario: partner heeft adellijke titel "`<adellijkeTitelPredicaat partner>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | V |
| voornamen (02.10) | Jo |
| voorvoegsel (02.30) | de |
| geslachtsnaam (02.40) | Boer |
| aanduiding naamgebruik (61.10) | P |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
| adellijke titel of predicaat (02.20) | `<adellijkeTitelPredicaat partner>` |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |

- Als personen wordt gezocht met de volgende parameters

| naam | waarde |
| --- | --- |
| type | RaadpleegMetBurgerservicenummer |
| burgerservicenummer | 000000139 |
| fields | adressering.aanhef |

- Dan heeft de response een persoon met de volgende 'adressering' gegevens

| naam | waarde |
| --- | --- |
| aanhef | `<aanhef>` |


#### Voorbeelden

| adellijkeTitelPredicaat partner | aanhef |
| --- | --- |
| B |Hoogwelgeboren vrouwe |
| G |Hooggeboren vrouwe |
| H |Hoogwelgeboren vrouwe |
| M |Hoogwelgeboren vrouwe |
| P |Hoogheid |
| R |Geachte mevrouw Van den Aedel |
| JH |Geachte mevrouw Van den Aedel |
| BS |Geachte mevrouw Van den Aedel |
| GI |Geachte mevrouw Van den Aedel |


### Abstract Scenario: persoon met geslacht "`<geslacht>`" en partner met adellijke titel "`<titel partner>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | `<geslacht>` |
| voornamen (02.10) | Jo |
| voorvoegsel (02.30) | de |
| geslachtsnaam (02.40) | Boer |
| aanduiding naamgebruik (61.10) | P |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
| adellijke titel of predicaat (02.20) | `<titel partner>` |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |

- Als personen wordt gezocht met de volgende parameters

| naam | waarde |
| --- | --- |
| type | RaadpleegMetBurgerservicenummer |
| burgerservicenummer | 000000139 |
| fields | adressering.aanhef |

- Dan heeft de response een persoon met de volgende 'adressering' gegevens

| naam | waarde |
| --- | --- |
| aanhef | `<aanhef>` |


#### Voorbeelden

| geslacht | titel partner | aanhef |
| --- | --- | --- |
| V |B |Hoogwelgeboren vrouwe |
| V |BS |Geachte mevrouw Van den Aedel |
| M |B |Geachte heer Van den Aedel |
| M |BS |Geachte heer Van den Aedel |
| O |B |Geachte J. van den Aedel |
| O |BS |Geachte J. van den Aedel |


### Abstract Scenario: adellijke titel van partner bij aanduiding naamgebruik "`<naamgebruik>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | V |
| voornamen (02.10) | Jo |
| voorvoegsel (02.30) | de |
| geslachtsnaam (02.40) | Boer |
| aanduiding naamgebruik (61.10) | `<naamgebruik>` |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
| adellijke titel of predicaat (02.20) | B |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |

- Als personen wordt gezocht met de volgende parameters

| naam | waarde |
| --- | --- |
| type | RaadpleegMetBurgerservicenummer |
| burgerservicenummer | 000000139 |
| fields | adressering.aanhef |

- Dan heeft de response een persoon met de volgende 'adressering' gegevens

| naam | waarde |
| --- | --- |
| aanhef | `<aanhef>` |


#### Voorbeelden

| naamgebruik | aanhef |
| --- | --- |
| E |Geachte mevrouw De Boer |
| P |Hoogwelgeboren vrouwe |
| V |Hoogwelgeboren vrouwe |
| N |Hoogwelgeboren vrouwe |


## Regel: Voor het bepalen van de aanhef gaat gebruik van de adellijke titel van de partner boven de adellijke titel van de persoon:

### Abstract Scenario: vrouw heeft adellijke titel `<adellijkeTitelPredicaat>` en haar partner heeft adellijke titel "`<adellijkeTitelPredicaat partner>`" bij aanduidingNaamgebruik "`<naamgebruik>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | V |
| voornamen (02.10) | Jo |
| adellijke titel of predicaat (02.20) | `<adellijkeTitelPredicaat>` |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |
| aanduiding naamgebruik (61.10) | `<naamgebruik>` |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | M |
| adellijke titel of predicaat (02.20) | `<adellijkeTitelPredicaat partner>` |
| voorvoegsel (02.30) | de |
| geslachtsnaam (02.40) | Boer |

- Als personen wordt gezocht met de volgende parameters

| naam | waarde |
| --- | --- |
| type | RaadpleegMetBurgerservicenummer |
| burgerservicenummer | 000000139 |
| fields | adressering.aanhef |

- Dan heeft de response een persoon met de volgende 'adressering' gegevens

| naam | waarde |
| --- | --- |
| aanhef | `<aanhef>` |


#### Voorbeelden

| adellijkeTitelPredicaat | adellijkeTitelPredicaat partner | naamgebruik | aanhef |
| --- | --- | --- | --- |
| GI |B |E |Hooggeboren vrouwe |
| GI |B |P |Hoogwelgeboren vrouwe |
| GI |B |V |Hoogwelgeboren vrouwe |
| GI |B |N |Hoogwelgeboren vrouwe |
| BS |P |E |Hoogwelgeboren vrouwe |
| BS |P |P |Hoogheid |
| BS |P |V |Hoogheid |
| BS |P |N |Hoogheid |
| GI |R |E |Hooggeboren vrouwe |
| GI |R |P |Geachte mevrouw De Boer |
| GI |R |V |Hooggeboren vrouwe |
| GI |R |N |Hooggeboren vrouwe |
| PS |B |E |Hoogheid |
| PS |B |P |Hoogwelgeboren vrouwe |
| PS |B |V |Hoogwelgeboren vrouwe |
| PS |B |N |Hoogwelgeboren vrouwe |


### Abstract Scenario: man heeft adellijke titel `<adellijkeTitelPredicaat>` en zijn partner heeft adellijke titel "`<adellijkeTitelPredicaat partner>`" bij aanduidingNaamgebruik "`<naamgebruik>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | M |
| voornamen (02.10) | Jo |
| adellijke titel of predicaat (02.20) | `<adellijkeTitelPredicaat>` |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |
| aanduiding naamgebruik (61.10) | `<naamgebruik>` |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | V |
| adellijke titel of predicaat (02.20) | `<adellijkeTitelPredicaat partner>` |
| voorvoegsel (02.30) | de |
| geslachtsnaam (02.40) | Boer |

- Als personen wordt gezocht met de volgende parameters

| naam | waarde |
| --- | --- |
| type | RaadpleegMetBurgerservicenummer |
| burgerservicenummer | 000000139 |
| fields | adressering.aanhef |

- Dan heeft de response een persoon met de volgende 'adressering' gegevens

| naam | waarde |
| --- | --- |
| aanhef | `<aanhef>` |


#### Voorbeelden

| adellijkeTitelPredicaat | adellijkeTitelPredicaat partner | naamgebruik | aanhef |
| --- | --- | --- | --- |
| G |BS |E |Hooggeboren heer |
| G |BS |P |Geachte heer De Boer |
| G |BS |V |Hooggeboren heer |
| G |BS |N |Hooggeboren heer |
| B |PS |E |Hoogwelgeboren heer |
| B |PS |P |Geachte heer De Boer |
| B |PS |V |Hoogwelgeboren heer |
| B |PS |N |Hoogwelgeboren heer |


