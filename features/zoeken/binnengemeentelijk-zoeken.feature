# language: nl
Functionaliteit: Binnengemeentelijk zoeken
  Als gemeente
  wil ik alleen personen vinden die staan ingeschreven in mijn gemeente

  Achtergrond:
    Gegeven adres 'A1' in gemeente 'Rotterdam'
    En de op 26-05-1983 geboren 'Robin'
    * heeft de volgende gegevens
      | geslachtsnaam (02.40) |
      | Maassen               |
    En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'

  Regel: de optionele parameter 'gemeenteVanInschrijving' moet worden opgegeven om uitsluitend binnengemeentelijk te zoeken

    Abstract Scenario: de opgegeven gemeente van inschrijving komt overeen met de gemeente van inschrijving van personen die matchen met de overige opgegeven zoek criteria
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met <zoek criteria> en parameters
        | gemeenteVanInschrijving |
        |                    0599 |
      Dan wordt 'Robin' gevonden

      Voorbeelden:
        | zoek criteria                               |
        | adresseerbaar object identificatie van 'A1' |
        | burgerservicenummer van 'Robin'             |
        | geslachtsnaam en geboortedatum van 'Robin'  |
        | nummeraanduiding identificatie van 'A1'     |
        | postcode en huisnummer van 'A1'             |

    Abstract Scenario: de opgegeven gemeente van inschrijving komt niet overeen met de gemeente van inschrijving van personen die matchen met de overige opgegeven zoek criteria
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met adresseerbaar object identificatie van 'A1' en parameters
        | gemeenteVanInschrijving |
        |                    0518 |
      Dan worden er geen personen gevonden

      Voorbeelden:
        | zoek criteria                               |
        | adresseerbaar object identificatie van 'A1' |
        | burgerservicenummer van 'Robin'             |
        | geslachtsnaam en geboortedatum van 'Robin'  |
        | nummeraanduiding identificatie van 'A1'     |
        | postcode en huisnummer van 'A1'             |
