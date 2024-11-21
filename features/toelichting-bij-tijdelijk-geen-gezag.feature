#language: nl

Functionaliteit: Leveren van een toelichting als een kind tijdelijk geen gezag heeft

  Als consumer van de BRP API
  wil ik een toelichting als een kind tijdelijk geen gezag heeft
  zodat ik weet wat de reden is dat het kind tijdelijk geen gezag heeft

  Regel: Een toelichting wordt geleverd als het gevraagde kind tijdelijk geen gezag heeft

    Scenario: Het gevraagde kind heeft tijdelijk geen gezag
      Gegeven de persoon met burgerservicenummer '000000012'
      * heeft tijdelijk geen gezag om de volgende reden
      | reden |
      | todo  |
      Als het 'gezag' veld wordt gevraagd voor de persoon met burgerservicenummer '000000012'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde             |
      | type                             | TijdelijkGeenGezag |
      | minderjarige.burgerservicenummer | 000000012          |
      | toelichting                      | todo               |

    Scenario: Meerdere gevraagde kinderen hebben tijdelijk geen gezag
      Gegeven de persoon met burgerservicenummer '000000012'
      * heeft tijdelijk geen gezag om de volgende reden
      | reden |
      | todo  |
      En de persoon met burgerservicenummer '000000024'
      * heeft tijdelijk geen gezag om de volgende reden
      | reden |
      | todo  |
      Als het 'gezag' veld wordt gevraagd voor de personen met de burgerservicenummers '000000012,000000024'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde             |
      | type                             | TijdelijkGeenGezag |
      | minderjarige.burgerservicenummer | 000000012          |
      | toelichting                      | todo               |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde             |
      | type                             | TijdelijkGeenGezag |
      | minderjarige.burgerservicenummer | 000000024          |
      | toelichting                      | todo               |

  Regel: Een toelichting wordt geleverd als een kind dat verblijft op het gevraagde adres tijdelijk geen gezag heeft
  
    Scenario: Een kind dat verblijft op het gevraagde adres heeft tijdelijk geen gezag
      Gegeven adres 'A1' heeft de volgende gegevens
      | identificatiecode verblijfplaats (11.80) |
      | 0599010000219679                         |
      En de persoon met burgerservicenummer '000000012'
      * is ingeschreven op adres 'A1'
      * heeft tijdelijk geen gezag om de volgende reden
      | reden |
      | todo  |
      Als het 'gezag' veld wordt gevraagd voor de personen die verblijven op adres 'A1'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde             |
      | type                             | TijdelijkGeenGezag |
      | minderjarige.burgerservicenummer | 000000012          |
      | toelichting                      | todo               |

    Scenario: Meerdere kinderen die verblijven op het gevraagde adres hebben tijdelijk geen gezag
      Gegeven adres 'A1' heeft de volgende gegevens
      | identificatiecode verblijfplaats (11.80) |
      | 0599010000219679                         |
      En de persoon met burgerservicenummer '000000012'
      * is ingeschreven op adres 'A1'
      * heeft tijdelijk geen gezag om de volgende reden
      | reden |
      | todo  |
      En de persoon met burgerservicenummer '000000024'
      * is ingeschreven op adres 'A1'
      * heeft tijdelijk geen gezag om de volgende reden
      | reden |
      | todo  |
      Als het 'gezag' veld wordt gevraagd voor de personen die verblijven op adres 'A1'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde             |
      | type                             | TijdelijkGeenGezag |
      | minderjarige.burgerservicenummer | 000000012          |
      | toelichting                      | todo               |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde             |
      | type                             | TijdelijkGeenGezag |
      | minderjarige.burgerservicenummer | 000000024          |
      | toelichting                      | todo               |
