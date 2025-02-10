#language: nl

Functionaliteit: Leveren van de volledige naam van een (mogelijke) bewoner

  Als consumer van de bewoning API
  wil ik dat voor een (mogelijke) bewoner zijn volledige naam en geboortedatum wordt meegeleverd

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      |                 0800 |                         0800010000000001 |

Regel: de volledige naam wordt samengesteld door het achter elkaar plaatsen van voornamen, voorvoegsels en geslachtsnaam. Zie de [volledige naam feature]() voor de 'volledige naam' specificaties

@info-api
Abstract Scenario: bewoner heeft geen voorvoegsel en geen adellijke titel/predicaat
  Gegeven de persoon met de volgende gegevens
  | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
  | 000000012                   | Karel             | Jansen                |
  En de persoon is ingeschreven op adres 'A1' vanaf '2024-01-01'
  Als de bewoning wordt gevraagd van adres 'A1' voor <vraag>
  Dan heeft de response een bewoning met de volgende gegevens
  | type               | adresseerbaarObjectIdentificatie | periode   |
  | BewoningMetPeriode | 0800010000000001                 | <periode> |
  En heeft de bewoning bewoners met de volgende gegevens
  | burgerservicenummer | naam.volledigeNaam |
  | 000000012           | Karel Jansen       |

  Voorbeelden:
  | vraag                               | periode                   |
  | periode '2024-01-01 tot 2025-01-01' | 2024-01-01 tot 2025-01-01 |
  | peildatum '2024-01-01'              | 2024-01-01 tot 2024-01-02 |

@data-api
Abstract Scenario: bewoner heeft geen voorvoegsel en geen adellijke titel/predicaat
  Gegeven de persoon met de volgende gegevens
  | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
  | 000000012                   | Karel             | Jansen                |
  En de persoon is ingeschreven op adres 'A1' vanaf '2024-01-01'
  Als de bewoning wordt gevraagd van adres 'A1' voor <vraag>
  Dan heeft de response een bewoning
  * met velden
  | type               | adresseerbaarObjectIdentificatie | periode   |
  | BewoningMetPeriode | 0800010000000001                 | <periode> |
  * met bewoners lijsten veld
  | burgerservicenummer | naam.voornamen | naam.geslachtsnaam | geslacht.code | geslacht.omschrijving |
  | 000000012           | Karel          | Jansen             | M             | man                   |

  Voorbeelden:
  | vraag                               | periode                   |
  | periode '2024-01-01 tot 2025-01-01' | 2024-01-01 tot 2025-01-01 |
  | peildatum '2024-01-01'              | 2024-01-01 tot 2024-01-02 |
