#language: nl

Functionaliteit: het overlijden van een persoon heeft invloed op de gezagsuitspraak

  Voor een overleden ouder kan geen gezag worden opgevraagd.
  De gezagsmodule geeft alleen gezagsuitspraken voor levende meerderjarigen.
  Wanneer een minderjarige overlijdt, komt deze niet meer voor in de gezagsuitspraak van de ouder voor.

  Achtergrond:
    Gegeven de persoon 'Hendrik' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Laura' met burgerservicenummer '000000024'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * heeft 'Hendrik' als ouder 1
    En de persoon 'Arjan' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * heeft 'Hendrik' als ouder 1
    En de persoon 'Jan' met burgerservicenummer '000000048'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * heeft 'Hendrik' als ouder 1

  Regel: een gezagsbevraging voor een meerderjarige levert zijn gezagsrelatie met zijn niet overleden minderjarige kinderen

  Scenario: voor een meerderjarige wordt gezag over alle drie de kinderen geleverd
    Als 'gezag' wordt gevraagd van 'Hendrik'
    Dan heeft 'Hendrik' de volgende gezagsrelaties
    * is het gezag over 'Laura' eenhoofdig ouderlijk gezag met ouder 'Hendrik'
    * is het gezag over 'Arjan' eenhoofdig ouderlijk gezag met ouder 'Hendrik'
    * is het gezag over 'Jan' eenhoofdig ouderlijk gezag met ouder 'Hendrik'

  Scenario: voor een meerderjarige die is overleden wordt geen gezag geleverd
    Gegeven persoon 'Hendrik'
    * is overleden
    Als 'gezag' wordt gevraagd van 'Hendrik'
    Dan heeft 'Hendrik' de volgende gezagsrelaties
    * heeft de persoon geen gezag

  Scenario: voor een meerderjarige waarvan een minderjarige is overleden wordt gezag geleverd voor de twee niet overleden minderjarige geleverd
    Gegeven persoon 'Laura'
    * is overleden
    Als 'gezag' wordt gevraagd van 'Hendrik'
    Dan heeft 'Hendrik' de volgende gezagsrelaties
    * is het gezag over 'Arjan' eenhoofdig ouderlijk gezag met ouder 'Hendrik'
    * is het gezag over 'Jan' eenhoofdig ouderlijk gezag met ouder 'Hendrik'

  Scenario: voor een meerderjarige waarvan alle minderjarige zijn overleden wordt geen gezag geleverd
    Gegeven persoon 'Laura'
    * is overleden
    Gegeven persoon 'Arjan'
    * is overleden
    Gegeven persoon 'Jan'
    * is overleden
    Als 'gezag' wordt gevraagd van 'Hendrik'
    Dan heeft 'Hendrik' de volgende gezagsrelaties
    * heeft de persoon geen gezag
