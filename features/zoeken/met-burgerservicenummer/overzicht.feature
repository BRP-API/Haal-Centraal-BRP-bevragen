# language: nl
Functionaliteit: gegevens raadplegen van een persoon

  Als consumer
  wil ik de actuele gegevens van één of meer personen kunnen raadplegen door het opgeven van zijn/hun burgerservicenummer

    Achtergrond:
      Gegeven de persoon 'Robin' met burgerservicenummer '000000024'
      En de persoon 'Saskia' met burgerservicenummer '000000025'
      En de persoon 'Gerda' met burgerservicenummer '000000026'

  Regel: een persoon moet worden gezocht met zijn burgerservicenummer om zijn actuele gegevens te kunnen raadplegen

    Scenario: het burgerservicenummer van één persoon is opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin'
      Dan wordt 'Robin' gevonden

    Scenario: het burgerservicenummer van meer personen is opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin, Saskia en Gerda'
      Dan worden 'Robin, Saskia en Gerda' gevonden

  Regel: de optionele 'gemeenteVanInschrijving' parameter kan worden gebruikt om de zoek criteria aan te scherpen

    Scenario: de opgegeven gemeente van inschrijving komt overeen met de gemeente van inschrijving van de persoon
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0599                 | 0599010051001502                         |
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        | 0599                              |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin' en parameters
        | gemeenteVanInschrijving |
        |                    0599 |
      Dan wordt 'Robin' gevonden

    Scenario: de opgegeven gemeente van inschrijving komt niet overeen met de gemeente van inschrijving van de persoon
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0599                 | 0599010051001502                         |
      En 'Robin' is 3 jaar geleden ingeschreven op adres 'A1' met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        | 0518                              |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin' en parameters
        | gemeenteVanInschrijving |
        |                    0599 |
      Dan worden er geen personen gevonden
