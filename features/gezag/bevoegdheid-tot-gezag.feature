# language: nl
Functionaliteit: Bevoegdheid tot gezag
  Gezag bepalen voor een minderjarige wanneer een of beide ouders zijn overleden of niet bevoegd zijn tot gezag.
  
  Een persoon is onbevoegd tot gezag wanneer die:
  - onder curatele staat
  - minderjarig is

  Regel: Er is sprake van eenhoofdig ouderlijk gezag als één van de ouders met gezamenlijk ouderlijk gezag overleden of niet bevoegd is

    Voorbeeld: Minderjarige heeft twee ouders en één van de ouders staat onder curatele
      Gegeven de minderjarige persoon 'Bert' met twee gehuwde ouders 'Gerda' en 'Aart'
      En 'Gerda' staat onder curatele
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Aart'

  Regel: Er is tijdelijk geen gezag als beide ouders met gezamenlijk ouderlijk gezag overleden of niet bevoegd zijn
    #Bespreken: een ouder of beide ouders minderjarig met meerderjarigheidsverklaring - kunnnen we meerderjarigheidsverklaring herkennen of aannemen in de BRP?

    Voorbeeld: Minderjarige heeft twee ouders en beide ouders staan onder curatele
      Gegeven de minderjarige persoon 'Bert' met twee gehuwde ouders 'Gerda' en 'Aart'
      En 'Gerda' <bevoegdheid Gerda>
      En 'Aart' <bevoegdheid Aart>
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' tijdelijk geen gezag met de toelichting '<toelichting>.'

      Voorbeelden:
        | bevoegdheid Gerda    | bevoegdheid Aart     | toelichting                                                                                 |
        | is overleden         | is overleden         | Tijdelijk geen gezag omdat beide ouders overleden zijn                                      |
        | staat onder curatele | staat onder curatele | Tijdelijk geen gezag omdat beide ouders onder curatele staan                                |
        | is minderjarig       | is minderjarig       | Tijdelijk geen gezag omdat beide ouders minderjarig zijn                                    |
        | is overleden         | staat onder curatele | Tijdelijk geen gezag omdat een ouder overleden is en de andere ouder onder curatele staat   |
        | is overleden         | is minderjarig       | Tijdelijk geen gezag omdat een ouder overleden is en de andere ouder minderjarig is         |
        | staat onder curatele | is minderjarig       | Tijdelijk geen gezag omdat een ouder onder curatele staat en de andere ouder minderjarig is |

  Regel: Er is tijdelijk geen gezag als de ouder met eenhoofdig ouderlijk gezag overleden of niet bevoegd is

    Voorbeeld: Er is één ouder en die is overleden
      Gegeven de minderjarige persoon 'Bert' met één ouder 'Gerda'
      En 'Gerda' is overleden
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' tijdelijk geen gezag met de toelichting 'Tijdelijk geen gezag omdat de ouder overleden is.'

  Regel: De partner heeft voogdij als de ouder met gezamenlijk gezag overleden of niet bevoegd is

    Voorbeeld: Minderjarige heeft ouder die gehuwd is en de ouder staat onder curatele
      Gegeven de minderjarige persoon 'Bert' met één ouder 'Gerda' die gehuwd is met 'Ariana'
      En 'Gerda' staat onder curatele
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' voogdij met derde 'Ariana'

  Regel: Er is sprake van voogdij als de ouder met gezamenlijk gezag met een derde overleden of niet bevoegd is

    Voorbeeld: Het gezag is toegewezen aan een van de ouders met een derde en de ouder met gezag is overleden
      Gegeven de minderjarige persoon 'Bert' met twee gehuwde ouders 'Gerda' en 'Aart'
      En in een gerechtelijke uitspraak is het gezag toegewezen aan 'Gerda' en een derde
      En 'Gerda' is overleden
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' voogdij

  Regel: Er is sprake van eenhoofdig ouderlijk gezag als de partner met gezamenlijk gezag overleden of niet bevoegd is

    Voorbeeld: Minderjarige heeft ouder die gehuwd is en de partner staat onder curatele
      Gegeven de minderjarige persoon 'Bert' met één ouder 'Gerda' die gehuwd is met 'Ariana'
      En 'Ariana' staat onder curatele
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

  Regel: Er is tijdelijk geen gezag als de ouder en de partner met gezamenlijk gezag overleden of niet bevoegd zijn

    @to-do @skip-verify
    Voorbeeld: Minderjarige heeft ouder die gehuwd is en zowel de partner als de ouder staan onder curatele
      Gegeven de minderjarige persoon 'Bert' met één ouder 'Gerda' die gehuwd is met 'Ariana'
      En 'Gerda' staat onder curatele
      En 'Ariana' staat onder curatele
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' tijdelijk geen gezag met de toelichting 'Tijdelijk geen gezag omdat ouder en partner onder curatele staan.'
