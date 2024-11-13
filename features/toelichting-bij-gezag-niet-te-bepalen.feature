#language: nl

Functionaliteit: Toelichting bij gezag niet te bepalen

  Als consumer van de BRP API
  wil ik een toelichting als het gezag voor een kind niet kan worden bepaald
  zodat ik weet wat de reden is dat het gezag voor het kind niet kan worden bepaald

  Regel: Een toelichting wordt geleverd als het gezag van een gevraagde kind niet kan worden bepaald

    Scenario: Het gezag van gevraagde kind kan niet worden bepaald
      Gegeven de persoon met burgerservicenummer '000000012'
      * wiens gezag niet kan worden bepaald om de volgende reden
      | reden                                                                |
      | gezag is niet te bepalen omdat minderjarige niet in Nederland woont. |
      Als het 'gezag' veld wordt gevraagd voor de persoon met burgerservicenummer '000000012'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                                                               |
      | type                             | GezagNietTeBepalen                                                   |
      | minderjarige.burgerservicenummer | 000000012                                                            |
      | toelichting                      | gezag is niet te bepalen omdat minderjarige niet in Nederland woont. |

    Scenario: Het gezag van meerdere gevraagde kinderen kan niet worden bepaald
      Gegeven de persoon met burgerservicenummer '000000012'
      * wiens gezag niet kan worden bepaald om de volgende reden
      | reden                                                                |
      | gezag is niet te bepalen omdat minderjarige niet in Nederland woont. |
      En de persoon met burgerservicenummer '000000024'
      * wiens gezag niet kan worden bepaald om de volgende reden
      | reden                                                                                                         |
      | gezag is niet te bepalen omdat de volgende relevante gegevens ontbreken: verblijfplaats van bevraagde persoon |
      Als het 'gezag' veld wordt gevraagd voor de personen met de burgerservicenummers '000000012,000000024'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                                                               |
      | type                             | GezagNietTeBepalen                                                   |
      | minderjarige.burgerservicenummer | 000000012                                                            |
      | toelichting                      | gezag is niet te bepalen omdat minderjarige niet in Nederland woont. |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                                                                                                        |
      | type                             | GezagNietTeBepalen                                                                                            |
      | minderjarige.burgerservicenummer | 000000024                                                                                                     |
      | toelichting                      | gezag is niet te bepalen omdat de volgende relevante gegevens ontbreken: verblijfplaats van bevraagde persoon |

  Regel: Een toelichting wordt geleverd als het gezag van een kind dat verblijft op het gevraagde adres niet kan worden bepaald

    Scenario: Het gezag van een kind dat verblijft op het gevraagde adres kan niet worden bepaald
      Gegeven adres 'A1' heeft de volgende gegevens
      | identificatiecode verblijfplaats (11.80) |
      | 0599010000219679                         |
      En de persoon met burgerservicenummer '000000012'
      * is ingeschreven op adres 'A1'
      * wiens gezag niet kan worden bepaald om de volgende reden
      | reden                                                                         |
      | gezag is niet te bepalen omdat minderjarige buiten Nederland heeft verbleven. |
      Als het 'gezag' veld wordt gevraagd voor de personen die verblijven op adres 'A1'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                                                                        |
      | type                             | GezagNietTeBepalen                                                            |
      | minderjarige.burgerservicenummer | 000000012                                                                     |
      | toelichting                      | gezag is niet te bepalen omdat minderjarige buiten Nederland heeft verbleven. |

    Scenario: Het gezag van meerdere kinderen die verblijven op het gevraagde adres kan niet worden bepaald
      Gegeven adres 'A1' heeft de volgende gegevens
      | identificatiecode verblijfplaats (11.80) |
      | 0599010000219679                         |
      En de persoon met burgerservicenummer '000000012'
      * is ingeschreven op adres 'A1'
      * wiens gezag niet kan worden bepaald om de volgende reden
      | reden                                                                         |
      | gezag is niet te bepalen omdat minderjarige buiten Nederland heeft verbleven. |
      En de persoon met burgerservicenummer '000000024'
      * is ingeschreven op adres 'A1'
      * wiens gezag niet kan worden bepaald om de volgende reden
      | reden                                                                                                                |
      | gezag is niet te bepalen omdat minderjarige in het buitenland is geboren en geen Nederlandse adoptie-akte bekend is. |
      Als het 'gezag' veld wordt gevraagd voor de personen die verblijven op adres 'A1'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                                                                        |
      | type                             | GezagNietTeBepalen                                                            |
      | minderjarige.burgerservicenummer | 000000012                                                                     |
      | toelichting                      | gezag is niet te bepalen omdat minderjarige buiten Nederland heeft verbleven. |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                                                                                                               |
      | type                             | GezagNietTeBepalen                                                                                                   |
      | minderjarige.burgerservicenummer | 000000024                                                                                                            |
      | toelichting                      | gezag is niet te bepalen omdat minderjarige in het buitenland is geboren en geen Nederlandse adoptie-akte bekend is. |
