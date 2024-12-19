# language: nl
Functionaliteit: Leveren van een toelichting en de burgerservicenummer van het kind als het gezag van een kind niet kan worden bepaald
  Als consumer van de BRP API
  wil ik een toelichting en het burgerservicenummer van het kind als het gezag voor een kind niet kan worden bepaald
  zodat ik weet wat de reden is dat het gezag voor het kind niet kan worden bepaald en welk kind het betreft

  Regel: Een toelichting en de burgerservicenummer van het kind worden geleverd als het gezag van een gevraagde kind niet kan worden bepaald

    Scenario: Het gezag van het gevraagde kind kan niet worden bepaald
      Gegeven de persoon 'Zoe' met burgerservicenummer '000000036'
      * het gezag is niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet in Nederland woont.'
      Als gezag wordt gevraagd van 'Zoe'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde                                                               |
        | type                             | GezagNietTeBepalen                                                   |
        | minderjarige.burgerservicenummer |                                                            000000036 |
        | toelichting                      | gezag is niet te bepalen omdat minderjarige niet in Nederland woont. |

    Scenario: Het gezag van meerdere gevraagde kinderen kan niet worden bepaald
      Gegeven de persoon 'Alex' met burgerservicenummer '000000012'
      * het gezag is niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet in Nederland woont.'
      Gegeven de persoon 'Jan' met burgerservicenummer '000000024'
      * het gezag is niet te bepalen met de toelichting 'gezag is niet te bepalen omdat de volgende relevante gegevens ontbreken: verblijfplaats van bevraagde persoon'
      Gegeven de persoon 'Zoe' met burgerservicenummer '000000036'
      * het gezag is niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet in Nederland woont.'
      Als gezag wordt gevraagd van 'Alex,Jan,Zoe'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde                                                               |
        | type                             | GezagNietTeBepalen                                                   |
        | minderjarige.burgerservicenummer |                                                            000000012 |
        | toelichting                      | gezag is niet te bepalen omdat minderjarige niet in Nederland woont. |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde                                                                                                        |
        | type                             | GezagNietTeBepalen                                                                                            |
        | minderjarige.burgerservicenummer |                                                                                                     000000024 |
        | toelichting                      | gezag is niet te bepalen omdat de volgende relevante gegevens ontbreken: verblijfplaats van bevraagde persoon |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde                                                               |
        | type                             | GezagNietTeBepalen                                                   |
        | minderjarige.burgerservicenummer |                                                            000000036 |
        | toelichting                      | gezag is niet te bepalen omdat minderjarige niet in Nederland woont. |

  Regel: Een toelichting en de burgerservicenummer van het kind worden geleverd als het gezag van een kind dat verblijft op het gevraagde adres niet kan worden bepaald

    Scenario: 'burgerservicenummer (01.20)' wordt gevraagd met 'burgerservicenummer'
      Gegeven adres 'A1' heeft de volgende gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        |                 0599 |                         0599010051001502 |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
        | naam                        | waarde            |
        | geslachtsnaam (02.40)       | Maassen           |
        | geboortedatum (03.10)       | vandaag - 10 jaar |
        | geslachtsaanduiding (04.10) | V                 |
      En het gezag over de persoon met burgerservicenummer '000000048' is niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet in Nederland woont.'
      En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        |                              0599 |
      Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie |                        0599010051001502 |
        | fields                           | gezag                                   |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde                                                               |
        | type                             | GezagNietTeBepalen                                                   |
        | minderjarige.burgerservicenummer |                                                            000000048 |
        | toelichting                      | gezag is niet te bepalen omdat minderjarige niet in Nederland woont. |

    Scenario: Het gezag van meerdere kinderen die verblijven op het gevraagde adres kan niet worden bepaald
      Gegeven adres 'A1' heeft de volgende gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        |                 0599 |                         0599010051001502 |
      En de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
        | naam                        | waarde            |
        | geslachtsnaam (02.40)       | Maassen           |
        | geboortedatum (03.10)       | vandaag - 10 jaar |
        | geslachtsaanduiding (04.10) | V                 |
      En het gezag over de persoon met burgerservicenummer '000000012' is niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige buiten Nederland heeft verbleven.'
      En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        |                              0599 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
        | naam                        | waarde            |
        | geslachtsnaam (02.40)       | Maassen           |
        | geboortedatum (03.10)       | vandaag - 10 jaar |
        | geslachtsaanduiding (04.10) | V                 |
      En het gezag over de persoon met burgerservicenummer '000000024' is niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige in het buitenland is geboren en geen Nederlandse adoptie-akte bekend is.'
      En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        |                              0599 |
      Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie |                        0599010051001502 |
        | fields                           | gezag                                   |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde                                                                        |
        | type                             | GezagNietTeBepalen                                                            |
        | minderjarige.burgerservicenummer |                                                                     000000012 |
        | toelichting                      | gezag is niet te bepalen omdat minderjarige buiten Nederland heeft verbleven. |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde                                                                                                               |
        | type                             | GezagNietTeBepalen                                                                                                  |
        | minderjarige.burgerservicenummer |                                                                                                            000000024 |
        | toelichting                      | gezag is niet te bepalen omdat minderjarige in het buitenland is geboren en geen Nederlandse adoptie-akte bekend is. |
