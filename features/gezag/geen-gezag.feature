# language: nl
Functionaliteit: Geen gezag
  Over meerderjarige of overleden personen wordt geen gezag geleverd.

  Gezag over een minderjarige stopt als het kind 18 jaar wordt of is overleden. 

  Achtergrond:
    Gegeven de persoon 'Bert' met burgerservicenummer '000000036'
    * is meerderjarig
    * is in Nederland geboren
    * is ingeschreven in een Nederlandse gemeente

  Regel: Als de persoon meerderjarig is, dan is er geen sprake van gezag

    @to-do @skip-verify
    Voorbeeld: De persoon is meerderjarig
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan heeft 'Bert' geen gezaghouder

  Regel: Als de persoon overleden is, dan is er geen sprake van gezag

    @to-do @skip-verify
    Voorbeeld: De persoon is overleden
      Gegeven persoon 'Bert'
      * is overleden
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan heeft 'Bert' geen gezaghouder
