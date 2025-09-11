# language: nl
Functionaliteit: Geen ouder
  Gezag bepalen voor een minderjarige zonder juridische ouder en nog geen voogdij toegewezen.
  
  Er kan dan een situatie ontstaan dat er geen gezag is over de minderjarige. Deze situatie is altijd tijdelijk.

  Achtergrond:
    Gegeven de persoon 'Bert' met burgerservicenummer '000000048'
    * is minderjarig
    * is ingeschreven in de BRP

  Regel: Als er geen of alleen onbekende ouders zijn, dan is er tijdelijk geen gezag

    @to-do @skip-verify
    Voorbeeld: De ouders zijn onbekend
      Gegeven persoon 'Bert'
      * is met onbekende ouders ingeschreven
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' tijdelijk geen gezag met de toelichting 'Tijdelijk geen gezag omdat beide ouders onbekend zijn'

    @to-do @skip-verify
    Voorbeeld: Er is een onbekende ouder
      Gegeven persoon 'Bert'
      * is 1 jaar geleden als vondeling geboren
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' tijdelijk geen gezag met de toelichting 'Tijdelijk geen gezag omdat beide ouders onbekend zijn'
