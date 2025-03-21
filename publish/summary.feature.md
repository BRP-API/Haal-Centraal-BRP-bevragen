# Functionaliteit: Aanhef bepalen

Als consumer van de BRP API Wil ik de aanhef (introducerende zin van een brief of e-mail) voor een persoon kunnen vragen
Zodat ik de persoon op de juiste en consistente manier kan aanschrijven

## Regel: De aanhef van een persoon zonder partner wordt samengesteld door geslacht, de voorletters, voorvoegsels en geslachtsnaam te combineren.

### Abstract Scenario: Aanhef voor persoon met voorletter, voorvoegsel en geslachtsnaam bij geslacht `<voorbeeld>`

- Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | `<geslacht>` |
| voornamen (02.10) | Robin Melle |
| voorvoegsel (02.30) | van |
| geslachtsnaam (02.40) | Puffelen |
| aanduiding naamgebruik (61.10) | E |

- Als personen wordt gezocht met de volgende parameters

| naam | waarde |
| --- | --- |
| type | RaadpleegMetBurgerservicenummer |
| burgerservicenummer | 000000140 |
| fields | adressering.aanhef |

- Dan heeft de response een persoon met de volgende 'adressering' gegevens

| naam | waarde |
| --- | --- |
| aanhef | `<aanhef>` |


#### Voorbeelden

| voorbeeld | geslacht | aanhef |
| --- | --- | --- |
| man |M |Geachte heer Van Puffelen |
| vrouw |V |Geachte mevrouw Van Puffelen |
| onbekend |O |Geachte R.M. van Puffelen |


### Abstract Scenario: Aanhef voor persoon met voorletters en geslachtsnaam bij geslacht `<voorbeeld>`

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | `<geslacht>` |
| voornamen (02.10) | Jo Rene |
| geslachtsnaam (02.40) | Groenen |
| aanduiding naamgebruik (61.10) | E |

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

| voorbeeld | geslacht | aanhef |
| --- | --- | --- |
| man |M |Geachte heer Groenen |
| vrouw |V |Geachte mevrouw Groenen |
| onbekend |O |Geachte J.R. Groenen |


### Abstract Scenario: Aanhef van een persoon die nooit huwelijk of partnerschap heeft gehad met aanduidingNaamgebruik "`<aanduidingNaamgebruik>`"

- Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | V |
| voorvoegsel (02.30) | in het |
| geslachtsnaam (02.40) | Veld |
| aanduiding naamgebruik (61.10) | `<aanduidingNaamgebruik>` |

- En de persoon heeft geen (ex)partner
- Als personen wordt gezocht met de volgende parameters

| naam | waarde |
| --- | --- |
| type | RaadpleegMetBurgerservicenummer |
| burgerservicenummer | 000000139 |
| fields | adressering.aanhef |

- Dan heeft de response een persoon met de volgende 'adressering' gegevens

| naam | waarde |
| --- | --- |
| aanhef | Geachte mevrouw In het Veld |


#### Voorbeelden

| aanduidingNaamgebruik |
| --- |
| E |
| P |
| V |
| N |


## Regel: De aanhef van een persoon met een (ex-)partner wordt samengesteld door geslacht, de voorletters, voorvoegsels en geslachtsnaam te combineren.

### Abstract Scenario: Aanhef van een persoon met een (ex-)partner bij aanduidingNaamgebruik "`<naamgebruik>`"

- Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens

| naam | waarde |
| --- | --- |
| geslachtsaanduiding (04.10) | V |
| voorvoegsel (02.30) | `<voorvoegsel>` |
| geslachtsnaam (02.40) | `<geslachtsnaam>` |
| aanduiding naamgebruik (61.10) | `<naamgebruik>` |

- En de persoon heeft een 'partner' met de volgende gegevens

| naam | waarde |
| --- | --- |
| voorvoegsel (02.30) | `<partner voorvoegsel>` |
| geslachtsnaam (02.40) | `<partner geslachtsnaam>` |

- Als personen wordt gezocht met de volgende parameters

| naam | waarde |
| --- | --- |
| type | RaadpleegMetBurgerservicenummer |
| burgerservicenummer | 000000152 |
| fields | adressering.aanhef |

- Dan heeft de response een persoon met de volgende 'adressering' gegevens

| naam | waarde |
| --- | --- |
| aanhef | `<aanhef>` |


#### Voorbeelden

| naamgebruik | voorvoegsel | geslachtsnaam | partner voorvoegsel | partner geslachtsnaam | aanhef |
| --- | --- | --- | --- | --- | --- |
| E |in het |Veld |van |Velzen |Geachte mevrouw In het Veld |
| E | |Groenen | |Groenink |Geachte mevrouw Groenen |
| P |in het |Veld |van |Velzen |Geachte mevrouw Van Velzen |
| P | |Groenen | |Groenink |Geachte mevrouw Groenink |
| V |in het |Veld |van |Velzen |Geachte mevrouw Van Velzen-in het Veld |
| V | |Groenen | |Groenink |Geachte mevrouw Groenink-Groenen |
| N |in het |Veld |van |Velzen |Geachte mevrouw In het Veld-van Velzen |
| N | |Groenen | |Groenink |Geachte mevrouw Groenen-Groenink |


