# language: nl
Functionaliteit: Overleden personen zoeken

  Achtergrond:
    Gegeven adres 'A1' in gemeente '\'s-Gravenhage'
    En de op 26-05-1983 geboren 'Robin'
    * heeft de volgende gegevens
      | geslachtsnaam (02.40) |
      | Maassen               |
    En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1'
    En de op 26-05-1983 geboren 'Saskia'
    * heeft de volgende gegevens
      | geslachtsnaam (02.40) | voornamen (02.10) |
      | Maassen               | Saskia            |
    En 'Saskia' is 2 jaar geleden ingeschreven op adres 'A1'
    En 'Saskia' is op 23-03-2023 overleden

  Regel: met uitzondering van het zoekpad 'raadplegen met burgerservicenummer', wordt overleden personen die matchen aan de opgegeven zoek criteria niet geleverd tenzij met de optionele 'inclusiefOverledenPersonen' parameter hierom wordt gevraagd

    Abstract Scenario: de optionele parameter 'inclusiefOverledenPersonen' is niet opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met <zoek criteria>
      Dan wordt alleen 'Robin' gevonden

      Voorbeelden:
        | zoek criteria                                         |
        | adresseerbaar object identificatie van 'A1'           |
        | geslachtsnaam 'Maassen' en geboortedatum '1983-05-26' |
        | nummeraanduiding identificatie van 'A1'               |
        | postcode en huisnummer van 'A1'                       |
        | straatnaam, huisnummer en gemeentecode van 'A1'       |

    Scenario: de optionele parameter 'inclusiefOverledenPersonen' is niet opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Maassen', voornamen 'Saskia' en gemeente van inschrijving '0518'
      Dan worden er geen personen gevonden

    @info-api
    Abstract Scenario: de optionele parameter 'inclusiefOverledenPersonen' is opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met <zoek criteria> en parameters
        | inclusiefOverledenPersonen |
        | true                       |
      Dan wordt 'Robin en Saskia' gevonden
      En heeft 'Saskia' de volgende 'opschortingBijhouding' gegevens
        | reden.code | reden.omschrijving | datum.datum | datum.langFormaat | datum.type |
        | O          | overlijden         |  2023-03-23 |     23 maart 2023 | Datum      |

      Voorbeelden:
        | zoek criteria                                         |
        | adresseerbaar object identificatie van 'A1'           |
        | geslachtsnaam 'Maassen' en geboortedatum '1983-05-26' |
        | nummeraanduiding identificatie van 'A1'               |
        | postcode en huisnummer van 'A1'                       |
        | straatnaam, huisnummer en gemeentecode van 'A1'       |

    @info-api
    Scenario: de optionele parameter 'inclusiefOverledenPersonen' is niet opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Maassen', voornamen 'Saskia' en gemeente van inschrijving '0518' en parameters
        | inclusiefOverledenPersonen |
        | true                       |
      Dan wordt 'Saskia' gevonden
      En heeft 'Saskia' de volgende 'opschortingBijhouding' gegevens
        | reden.code | reden.omschrijving | datum.datum | datum.langFormaat | datum.type |
        | O          | overlijden         |  2023-03-23 |     23 maart 2023 | Datum      |

    @info-api
    Scenario: de met burgerservicenummer gezochte persoon is overleden
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met burgerservicenummer van 'Saskia'
      Dan wordt 'Saskia' gevonden
      En heeft 'Saskia' de volgende 'opschortingBijhouding' gegevens
        | reden.code | reden.omschrijving | datum.datum | datum.langFormaat | datum.type |
        | O          | overlijden         |  2023-03-23 |     23 maart 2023 | Datum      |
