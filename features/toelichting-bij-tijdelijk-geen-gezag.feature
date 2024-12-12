# language: nl
Functionaliteit: Leveren van een toelichting en de burgerservicenummer van het kind als het gezag van een kind niet kan worden bepaald
  Als consumer van de BRP API
  wil ik een toelichting en het burgerservicenummer van het kind als het gezag voor een kind niet kan worden bepaald
  zodat ik weet wat de reden is dat het gezag voor het kind niet kan worden bepaald en welk kind het betreft

  Regel: Een toelichting en de burgerservicenummer van het kind worden geleverd als het gezag van een gevraagde kind niet kan worden bepaald

    Scenario: Er is tijdelijk geen gezag over het gevraagde kind
      Gegeven de persoon 'Zoe' met burgerservicenummer '000000036'
      En er is tijdelijk geen gezag met de toelichting 'tijdelijk geen gezag omdat een ouder is opgeschort.'
      Als gezag wordt gevraagd van 'Zoe'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde             |
        | type                             | TijdelijkGeenGezag |
        | minderjarige.burgerservicenummer |          000000036 |

    Scenario: Er is tijdelijk geen gezag over meerdere gevraagde kinderen
      Gegeven de persoon 'Alex' met burgerservicenummer '000000012'
      En er is tijdelijk geen gezag met de toelichting 'tijdelijk geen gezag omdat een ouder is opgeschort.'
      Gegeven de persoon 'Jan' met burgerservicenummer '000000024'
      En er is tijdelijk geen gezag met de toelichting 'tijdelijk geen gezag omdat een ouder is overleden.'
      Gegeven de persoon 'Zoe' met burgerservicenummer '000000036'
      En er is tijdelijk geen gezag met de toelichting 'tijdelijk geen gezag omdat een ouder onder curatele staat.'
      Als gezag wordt gevraagd van 'Alex,Jan,Zoe'
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde             |
        | type                             | TijdelijkGeenGezag |
        | minderjarige.burgerservicenummer |          000000012 |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde             |
        | type                             | TijdelijkGeenGezag |
        | minderjarige.burgerservicenummer |          000000024 |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde             |
        | type                             | TijdelijkGeenGezag |
        | minderjarige.burgerservicenummer |          000000036 |

  Regel: Een toelichting en de burgerservicenummer van het kind worden geleverd als er tijdelijk geen gezag is over een kind dat verblijft op het gevraagde adres

    Scenario: 'burgerservicenummer (01.20)' wordt gevraagd met 'burgerservicenummer'
      Gegeven adres 'A1' heeft de volgende gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        |                 0599 |                         0599010051001502 |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
        | naam                        | waarde            |
        | geslachtsnaam (02.40)       | Maassen           |
        | geboortedatum (03.10)       | vandaag - 10 jaar |
        | geslachtsaanduiding (04.10) | V                 |
      En er is tijdelijk geen gezag over de persoon met burgerservicenummer '000000048' met de toelichting 'tijdelijk geen gezag omdat een ouder is opgeschort.'
      En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        |                              0599 |
      Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie |                        0599010051001502 |
        | fields                           | gezag                                   |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde             |
        | type                             | TijdelijkGeenGezag |
        | minderjarige.burgerservicenummer |          000000048 |

    Scenario: Er is tijdelijk geen gezag over meerdere kinderen die verblijven op het gevraagde adres
      Gegeven adres 'A1' heeft de volgende gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        |                 0599 |                         0599010051001502 |
      En de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
        | naam                        | waarde            |
        | geslachtsnaam (02.40)       | Maassen           |
        | geboortedatum (03.10)       | vandaag - 10 jaar |
        | geslachtsaanduiding (04.10) | V                 |
      En er is tijdelijk geen gezag over de persoon met burgerservicenummer '000000012' met de toelichting 'tijdelijk geen gezag omdat een ouder is opgeschort.'
      En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        |                              0599 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
        | naam                        | waarde            |
        | geslachtsnaam (02.40)       | Maassen           |
        | geboortedatum (03.10)       | vandaag - 10 jaar |
        | geslachtsaanduiding (04.10) | V                 |
      En er is tijdelijk geen gezag over de persoon met burgerservicenummer '000000024' met de toelichting 'tijdelijk geen gezag omdat een ouder is overleden.'
      En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        |                              0599 |
      Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie |                        0599010051001502 |
        | fields                           | gezag                                   |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde             |
        | type                             | TijdelijkGeenGezag |
        | minderjarige.burgerservicenummer |          000000012 |
      En heeft de response een persoon met een 'gezag' met de volgende gegevens
        | naam                             | waarde             |
        | type                             | TijdelijkGeenGezag |
        | minderjarige.burgerservicenummer |          000000024 |
