# Functionaliteit: Bij het opstellen van de aanhef maakt een adellijke titel of een predicaat daar onderdeel van uit.

## Regel: De aanhef voor een persoon met adellijke titel of predicaat wordt bepaald op basis van adellijkeTitelPredicaat en het geslacht:

### Abstract Scenario: persoon heeft adellijke titel "`<adellijkeTitelPredicaat>`" en geslacht "`<geslacht>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | `<geslacht>` |
| voornamen (02.10) | Pieter |
| adellijke titel of predicaat (02.20) | `<adellijkeTitelPredicaat>` |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |
| aanduiding naamgebruik (61.10) | E |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
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

| adellijkeTitelPredicaat | geslacht | aanhef |
| --- | --- | --- |
| R |M |Hoogwelgeboren heer |
| R |V |Hoogwelgeboren vrouwe |
| R |O |Geachte P. van den Aedel |
| B |M |Hoogwelgeboren heer |
| B |V |Hoogwelgeboren vrouwe |
| B |O |Geachte P. van den Aedel |
| BS |M |Hoogwelgeboren heer |
| BS |V |Hoogwelgeboren vrouwe |
| BS |O |Geachte P. van den Aedel |
| G |M |Hooggeboren heer |
| G |V |Hooggeboren vrouwe |
| G |O |Geachte P. van den Aedel |
| GI |M |Hooggeboren heer |
| GI |V |Hooggeboren vrouwe |
| GI |O |Geachte P. van den Aedel |
| P |M |Hoogheid |
| P |V |Hoogheid |
| P |O |Hoogheid |
| PS |M |Hoogheid |
| PS |V |Hoogheid |
| PS |O |Hoogheid |


### Abstract Scenario: persoon heeft adellijke titel "`<adellijkeTitelPredicaat>`" en naamgebruik "`<naamgebruik>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | M |
| voornamen (02.10) | Pieter |
| adellijke titel of predicaat (02.20) | `<adellijkeTitelPredicaat>` |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |
| aanduiding naamgebruik (61.10) | `<naamgebruik>` |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
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

| adellijkeTitelPredicaat | naamgebruik | aanhef |
| --- | --- | --- |
| G |E |Hooggeboren heer |
| G |V |Hooggeboren heer |
| G |N |Hooggeboren heer |
| G |P |Geachte heer De Boer |


### Abstract Scenario: persoon met partner heeft predicaat en geslacht "`<geslacht>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | `<geslacht>` |
| voornamen (02.10) | Pieter |
| adellijke titel of predicaat (02.20) | JV |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |
| aanduiding naamgebruik (61.10) | E |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
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

| geslacht | aanhef |
| --- | --- |
| M |Hoogwelgeboren heer |
| V |Geachte mevrouw Van den Aedel |
| O |Geachte P. van den Aedel |


### Abstract Scenario: persoon met partner heeft predicaat en naamgebruik "`<naamgebruik>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | M |
| voornamen (02.10) | Pieter |
| adellijke titel of predicaat (02.20) | JH |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |
| aanduiding naamgebruik (61.10) | `<naamgebruik>` |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
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

| naamgebruik | aanhef |
| --- | --- |
| E |Hoogwelgeboren heer |
| P |Geachte heer De Boer |
| V |Hoogwelgeboren heer |
| N |Hoogwelgeboren heer |


### Abstract Scenario: persoon heeft predicaat en geslacht "`<geslacht>`" en naamgebruik "`<naamgebruik>`" heeft ontbonden huwelijk

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | `<geslacht>` |
| voornamen (02.10) | Pieter |
| adellijke titel of predicaat (02.20) | JH |
| voorvoegsel (02.30) | van den |
| geslachtsnaam (02.40) | Aedel |
| aanduiding naamgebruik (61.10) | `<naamgebruik>` |

- En de persoon heeft geen actuele partner
- En de persoon heeft een 'ex-partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
| voorvoegsel (02.30) | de |
| geslachtsnaam (02.40) | Boer |
| datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20211109 |

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

| geslacht | naamgebruik | aanhef |
| --- | --- | --- |
| M |E |Hoogwelgeboren heer |
| M |P |Geachte heer De Boer |
| M |V |Hoogwelgeboren heer |
| M |N |Hoogwelgeboren heer |
| V |E |Hoogwelgeboren vrouwe |
| V |P |Geachte mevrouw De Boer |
| V |V |Geachte mevrouw De Boer-van den Aedel |
| V |N |Geachte mevrouw Van den Aedel-de Boer |
| O |E |Geachte P. van den Aedel |
| O |P |Geachte P. de Boer |
| O |V |Geachte P. de Boer-van den Aedel |
| O |N |Geachte P. van den Aedel-de Boer |


