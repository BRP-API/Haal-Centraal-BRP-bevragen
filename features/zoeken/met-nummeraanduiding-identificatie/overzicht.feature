# language: nl
Functionaliteit: zoek personen met de nummeraanduiding identificatie van een adres
  Als consumer
  wil ik de personen vinden door het opgeven van de nummeraanduiding identificatie van het adres waar zij staan ingeschreven

  Achtergrond:
    Gegeven adres 'A1'
      | identificatiecode nummeraanduiding (11.90) |
      |                           0599200000219679 |

  Regel: personen ingeschreven op het adres waarmee wordt gezocht, worden gevonden

    Scenario: één persoon staat ingeschreven op het adres waarmee wordt gezocht
      Gegeven de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan wordt 'Robin' gevonden

    Scenario: meerdere personen staan ingeschreven op het adres waarmee wordt gezocht
      Gegeven de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      En de persoon 'Saskia'
      En 'Saskia' is 2 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan worden 'Robin en Saskia' gevonden

    Scenario: niemand staat ingeschreven op het adres waarmee wordt gezocht
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met nummeraanduiding identificatie van 'A1'
      Dan worden er geen personen gevonden
