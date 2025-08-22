# language: nl
Functionaliteit: geldige fields waarden voor het vragen van waardetabel velden

  Achtergrond:
    Gegeven adres 'A1'
      | identificatiecode verblijfplaats (11.80) |
      |                         0599010000219679 |
    En de op 26-05-1983 geboren 'Pieter'
    * heeft de volgende gegevens
      | geslachtsnaam (02.40) | geslachtsaanduiding (04.10) |
      | Maassen               | M                           |
    * 'Pieter' is 3 jaar geleden ingeschreven op adres 'A1'

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een datum veld moet worden opgegeven als fields waarde om alle velden van het betreffende veld te vragen

    Abstract Scenario: het geslacht veld wordt gevraagd met fields waarde 'geslacht'
      Als 'geboorte.datum' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | zoek methode                                          |
        | burgerservicenummer van 'Pieter'                      |
        | geslachtsnaam 'Maassen' en geboortedatum '1983-05-26' |

  Regel: alle velden ven een waardetabel veld worden geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het geslacht veld wordt gevraagd met fields waarde 'geslacht.<sub-veld>'
      Als 'geslacht.<sub-veld>' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | zoek methode                                          | sub-veld     |
        | burgerservicenummer van 'Pieter'                      | code         |
        | geslachtsnaam 'Maassen' en geboortedatum '1983-05-26' | omschrijving |
        | adresseerbaar object identificatie van 'A1'           | nietBestaand |
