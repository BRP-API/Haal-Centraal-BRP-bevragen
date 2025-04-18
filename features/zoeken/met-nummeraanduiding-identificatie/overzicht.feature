# language: nl
Functionaliteit: zoek personen met de nummeraanduiding identificatie van een adres
  Als consumer
  wil ik de personen vinden door het opgeven van de nummeraanduiding identificatie van het adres waar zij staan ingeschreven

  Regel: personen ingeschreven op het gezochte adres worden gevonden

    Scenario: één persoon staat ingeschreven op het adres waarmee wordt gezocht
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
        |                 0599 |                           0599200000219679 |
      En de persoon 'Robin' met burgerservicenummer '000000140'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan wordt 'Robin' gevonden

    Scenario: meerdere personen staan ingeschreven op het adres waarmee wordt gezocht
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
        |                 0518 |                           0518200000617227 |
      En de persoon 'Robin' met burgerservicenummer '000000024'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      En de persoon 'Saskia' met burgerservicenummer '000000025'
      En 'Saskia' is 2 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan worden 'Robin en Saskia' gevonden

    Scenario: niemand staat ingeschreven op het adres waarmee wordt gezocht
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
        |                 0518 |                           0518200000617227 |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan worden er geen personen gevonden

  Regel: overleden personen ingeschreven op het adres waarmee wordt gezocht, worden niet gevonden

    Scenario: een overleden persoon staat ingeschreven op het gezochte adres
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
        |                 0518 |                           0518200000617227 |
      En de persoon 'Robin' met burgerservicenummer '000000024'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      En de persoon 'Saskia' met burgerservicenummer '000000025'
      En 'Saskia' is 2 jaar geleden ingeschreven op adres 'A1'
      En 'Saskia' is overleden
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan wordt alleen 'Robin' gevonden

  Regel: de optionele 'gemeenteVanInschrijving' parameter kan worden gebruikt om de zoek criteria aan te scherpen

    Scenario: de opgegeven gemeente van inschrijving komt overeen met de gemeente van inschrijving van de persoon
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
        |                 0599 |                           0599200000219679 |
      En de persoon 'Robin' met burgerservicenummer '000000024'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        | 0599                              |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1' en parameters
        | gemeenteVanInschrijving |
        |                    0599 |
      Dan wordt 'Robin' gevonden

    Scenario: de opgegeven gemeente van inschrijving komt niet overeen met de gemeente van inschrijving van de persoon
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
        |                 0599 |                           0599200000219679 |
      En de persoon 'Robin' met burgerservicenummer '00000024'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        | 0518                              |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1' en parameters
        | gemeenteVanInschrijving |
        |                    0599 |
      Dan worden er geen personen gevonden
