# language: nl
Functionaliteit: zoek personen met de nummeraanduiding identificatie van een adres
  Als consumer
  wil ik de personen vinden door het opgeven van de nummeraanduiding identificatie van het adres waar zij staan ingeschreven

  Regel: personen ingeschreven op het adres waarmee wordt gezocht, worden gevonden

    Scenario: één persoon staat ingeschreven op het adres waarmee wordt gezocht
      Gegeven adres 'A1' in gemeente 'Rotterdam'
      En de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan wordt 'Robin' gevonden

    Scenario: meerdere personen staan ingeschreven op het adres waarmee wordt gezocht
      Gegeven adres 'A1' in gemeente '\'s-Gravenhage'
      En de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      En de persoon 'Saskia'
      En 'Saskia' is 2 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan worden 'Robin en Saskia' gevonden

    Scenario: niemand staat ingeschreven op het adres waarmee wordt gezocht
      Gegeven adres 'A1' in gemeente '\'s-Gravenhage'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan worden er geen personen gevonden

  Regel: overleden personen ingeschreven op het adres waarmee wordt gezocht, worden niet gevonden

    Scenario: een overleden persoon staat ingeschreven op het gezochte adres
      Gegeven adres 'A1' in gemeente '\'s-Gravenhage'
      En de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      En de persoon 'Saskia'
      En 'Saskia' is 2 jaar geleden ingeschreven op adres 'A1'
      En 'Saskia' is overleden
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan wordt alleen 'Robin' gevonden

  Regel: om uitsluitend binnengemeentelijk te zoeken moet de optionele 'gemeenteVanInschrijving' parameter worden gebruikt

    Scenario: de opgegeven gemeente van inschrijving komt overeen met de gemeente van inschrijving van de persoon
      Gegeven adres 'A1' in gemeente 'Rotterdam'
      En de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1' en parameters
        | gemeenteVanInschrijving |
        |                    0599 |
      Dan wordt 'Robin' gevonden

    Scenario: de opgegeven gemeente van inschrijving komt niet overeen met de gemeente van inschrijving van de persoon
      Gegeven adres 'A1' in gemeente 'Rotterdam'
      En de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1' en parameters
        | gemeenteVanInschrijving |
        |                    0518 |
      Dan worden er geen personen gevonden
