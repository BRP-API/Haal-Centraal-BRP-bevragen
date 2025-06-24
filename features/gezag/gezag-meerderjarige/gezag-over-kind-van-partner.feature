#language: nl

Functionaliteit: gezamenlijk gezag van een meerderjarige over een kind van een (ex)partner

  Gezamenlijk gezag is het gezag van een ouder en een niet-
  ouder samen. U kunt dit gezag automatisch of via de rechter krijgen.

  Het gezag krijgt u automatisch wanneer:
  • Het kind tijdens uw huwelijk of geregistreerd partnerschap is geboren.
  • U bent geen ouder geworden (omdat er van een onbekende donor gebruik is gemaakt) en er is ook geen andere ouder.

  Soms moet u aan de rechter vragen om het gezamenlijk gezag te krijgen. Dat is zo als u ouder bent van een kind, maar uw
  partner niet. U hebt een advocaat nodig om het gezamenlijk gezag aan de rechter te vragen.

  Voor erkenningen die zijn gedaan voor 1 januari 2023 geldt dat de erkenner niet automatisch het gezamenlijk gezag krijgt
  met de moeder, ook niet als het kind na 1 januari 2023 wordt geboren.

  Dit kan bijvoorbeeld voorkomen in de volgende situatie:
  • U hebt als vader of moeder alleen het gezag. Bijvoorbeeld na een scheiding of overlijden van uw partner.
  • U wilt met uw nieuwe partner het gezamenlijk gezag hebben.

  Wanneer je als partner gezamenlijk gezag hebt met de ouder van het kind is dit niet zichtbaar in uw eigen gegevens.
  De relatie is opgenomen in de gegevens van het kind en moet via deze gegevens worden bepaald.

  Bij de gezagbepaling worden daarom de gegevens van de kinderen opgehaald van u en de kinderen van uw partner.
  Vervolgens worden potentiële gezagsrelaties bepaald vanuit de gegevens van de kinderen. Hierbij is het belangrijk dat als een kind erkend is, de erkenning na 1 januari 2023 is gedaan.

  Achtergrond:
    Gegeven de persoon 'Ludo' met burgerservicenummer '000000012'
    * is meerderjarig
    * is ingeschreven in de BRP
    En de persoon 'Laura' met burgerservicenummer '000000024'
    * is meerderjarig
    En de persoon 'Linda' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * heeft 'Laura' als ouder 1

  Regel: een meerderjarige die gezamenlijk gezag heeft over een kind van de partner krijgt de gezagsrelatie geleverd

  Scenario: persoon heeft automatisch gezamenlijk gezag over het kind van diens partner er is sprake van GezamenlijkGezag
    Gegeven 'Ludo' en 'Laura' zijn met elkaar gehuwd
    Als 'gezag' wordt gevraagd van 'Ludo'
    Dan heeft 'Ludo' de volgende gezagsrelaties
    * is het gezag over 'Linda' gezamenlijk gezag met ouder 'Laura' en derde 'Ludo'

  Scenario: persoon heeft van rechtswege gezamenlijk gezag over het minderjarige kind van diens partners er is sprake van GezamenlijkOuderlijkGezag
    Gegeven persoon 'Linda'
    * is erkend door 'Ludo' als ouder 2 met gerechtelijke vaststelling ouderschap op 01-01-2023
    Als 'gezag' wordt gevraagd van 'Linda'
    Dan heeft 'Linda' de volgende gezagsrelaties
    * is het gezag over 'Linda' gezamenlijk ouderlijk gezag met ouder 'Ludo' en ouder 'Laura'

  Regel: wanneer de ouder komt te overlijden of onder curatele komt te staan heeft de partner alleen het gezag over het kind

  Scenario: de partner van ouder onder curatele heeft gezag over een binnen het huwelijk geboren niet-erkend kind er is sprake van Voogdij
    Gegeven persoon 'Laura'
    * staat onder curatele
    En 'Laura' en 'Ludo' zijn met elkaar gehuwd
    Als 'gezag' wordt gevraagd van 'Ludo'
    Dan heeft 'Ludo' de volgende gezagsrelaties
    * is het gezag over 'Linda' voogdij met derde 'Ludo'

  Scenario: de ex-partner van ouder onder curatele heeft gezag over een binnen het huwelijk geboren niet-erkend kind er is sprake van Voogdij
    Gegeven persoon 'Laura'
    * staat onder curatele
    En 'Laura' en 'Ludo' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 19 jaar                                                 |
    En 'Laura' en 'Ludo' zijn gescheiden met de volgende gegevens
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
      | gisteren - 2 jaar                                            |
    Als 'gezag' wordt gevraagd van 'Ludo'
    Dan heeft 'Ludo' de volgende gezagsrelaties
    * is het gezag over 'Linda' voogdij met derde 'Ludo'

  Scenario: de (ex)partner van overleden ouder heeft gezag over een binnen het huwelijk geboren niet-erkend kind er is sprake van Voogdij
    Gegeven 'Laura' en 'Ludo' zijn met elkaar gehuwd
    Gegeven persoon 'Laura'
    * is overleden
    En de persoon 'Janine' met burgerservicenummer '000000048'
    * is meerderjarig
    En 'Ludo' en 'Janine' zijn met elkaar gehuwd
    Als 'gezag' wordt gevraagd van 'Ludo'
    Dan heeft 'Ludo' de volgende gezagsrelaties
    * is het gezag over 'Linda' voogdij met derde 'Ludo'

  Scenario: de inmiddels met een ander getrouwde (ex)partner van overleden ouder heeft gezag over een binnen het huwelijk geboren niet-erkend kind er is sprake van Voogdij
    Gegeven 'Laura' en 'Ludo' zijn met elkaar gehuwd
    Gegeven persoon 'Laura'
    * is overleden
    En de persoon 'Janine' met burgerservicenummer '000000048'
    En 'Ludo' en 'Janine' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | gisteren - 1 jaar                                                  |
    Als 'gezag' wordt gevraagd van 'Ludo'
    Dan heeft 'Ludo' de volgende gezagsrelaties
    * is het gezag over 'Linda' voogdij met derde 'Ludo'
