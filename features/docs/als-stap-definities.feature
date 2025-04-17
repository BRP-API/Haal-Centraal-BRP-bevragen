# language: nl
@stap-documentatie
Functionaliteit: als stap definities

  Scenario: personen zoeken met burgerservicenummer
    Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer '000000012'

  Scenario: personen zoeken met meerdere burgerservicenummers
    Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummers '000000012,000000013'

  Abstract Scenario: personen zoeken met burgerservicenummer van '[persoon aanduiding]'
    Gegeven persoon 'Gerda' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Jansen                |
    Als <stap>

    Voorbeelden:
      | stap                                                                            |
      | 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Gerda' |
      | 'gezag' wordt gevraagd van 'Gerda'                                              |

  Scenario: personen zoeken met burgerservicenummer en optionele parameters
    Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer '000000012' en parameters
      | gemeenteVanInschrijving |
      |                    0518 |

  Scenario: personen zoeken met burgerservicenummer van '[persoon aanduiding]' en optionele parameters
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    En de persoon 'Saskia' met burgerservicenummer '000000013'
    Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Gerda en Saskia' en parameters
      | gemeenteVanInschrijving |
      |                    0518 |

  Scenario: personen zoeken met burgerservicenummer zonder opgeven van burgerservicenummer
    Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer ''
