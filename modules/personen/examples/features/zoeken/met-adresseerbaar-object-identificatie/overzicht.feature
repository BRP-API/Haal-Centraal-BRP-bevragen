# language: nl
Functionaliteit: zoek personen met de adresseerbaar object identificatie van een adres
  Als consumer
  wil ik personen vinden door het opgeven van de adresseerbaar object identificatie van het adres waar zij staan ingeschreven

  Achtergrond:
    Gegeven adres 'A1'
      | identificatiecode verblijfplaats (11.80) |
      |                         0599010000219679 |

  Regel: personen worden gevonden die staan ingeschreven op het adres waarmee wordt gezocht

    Scenario: één persoon staat ingeschreven op het adres waarmee wordt gezocht
      Gegeven de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met adresseerbaar object identificatie van 'A1'
      Dan wordt 'Robin' gevonden

    Scenario: meerdere personen staan ingeschreven op het adres waarmee wordt gezocht
      Gegeven de persoon 'Robin'
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
      En de persoon 'Saskia'
      En 'Saskia' is 2 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met adresseerbaar object identificatie van 'A1'
      Dan worden 'Robin en Saskia' gevonden

    Scenario: niemand staat ingeschreven op het adres waarmee wordt gezocht
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met adresseerbaar object identificatie van 'A1'
      Dan worden er geen personen gevonden
