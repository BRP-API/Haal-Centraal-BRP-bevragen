# language: nl
Functionaliteit: gegevens raadplegen van een persoon

  Als consumer
  wil ik de actuele gegevens van één of meer personen kunnen raadplegen door het opgeven van zijn/hun burgerservicenummer

    Achtergrond:
      Gegeven de persoon 'Robin'
      En de persoon 'Saskia'
      En de persoon 'Gerda'

  Regel: een persoon moet worden gezocht met zijn burgerservicenummer om zijn actuele gegevens te kunnen raadplegen

    Scenario: het burgerservicenummer van één persoon is opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin'
      Dan wordt 'Robin' gevonden

    Scenario: het burgerservicenummer van meer personen is opgegeven
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin, Saskia en Gerda'
      Dan worden 'Robin, Saskia en Gerda' gevonden

