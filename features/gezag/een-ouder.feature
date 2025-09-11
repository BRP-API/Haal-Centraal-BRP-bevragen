# language: nl
Functionaliteit: Eén ouder
  Gezag bepalen voor een minderjarige met één juridische ouder.
  
  Bij minderjarigen met één ouder kan er sprake zijn van gezamenlijk gezag. Gezamenlijk gezag is het gezag van een ouder en een niet ouder samen. Zij kunnen dit gezag op twee manieren krijgen: automatisch of via de rechter.

  Er is automatisch sprake van gezamenlijk gezag als:
  - Het kind is tijdens het huwelijk of geregistreerd partnerschap van de ouder geboren.
  - Een van beide vrouwelijke partners geen ouder is geworden omdat er van een onbekende donor gebruik is gemaakt en het kind is geboren voor 1 april 2014. Als het kind is geboren op of na 1 april 2014, dan was de "meemoeder" juridisch ouder geworden.

  In alle andere gevallen is gezamenlijk gezag aangevraagd bij de rechter. Als de rechter dit heeft toegekend is er sprake van gezamenlijk gezag via een gerechtelijke uitspraak. Zie 
  [feature gerechtelijke uitspraak](gerechtelijke-uitspraak.feature)

  Achtergrond:
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Aart' met burgerservicenummer '000000024'
    * is meerderjarig
    En de persoon 'Ariana' met burgerservicenummer '000000036'
    * is meerderjarig
    En de persoon 'Bert' met burgerservicenummer '000000048'
    * is minderjarig
    * is ingeschreven in de BRP
    * heeft 'Gerda' als ouder

  Regel: Als de minderjarige niet tijdens een huwelijk of partnerschap van de juridische ouder geboren is, dan heeft de ouder eenhoofdig ouderlijk gezag

    Voorbeeld: De ouder is nooit gehuwd en had nooit een geregistreerd partnerschap bij geboorte
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

    Voorbeeld: De ouder was gehuwd en is gescheiden voor de geboorte van minderjarige
      Gegeven 'Gerda' en 'Aart' zijn 7 jaar geleden gehuwd
      En 'Gerda' en 'Aart' zijn 5 jaar geleden gescheiden
      En 'Bert' is 2 jaar geleden geboren
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

    Voorbeeld: De ouder is gehuwd na geboorte van minderjarige
      Gegeven 'Bert' is 7 jaar geleden geboren
      En 'Gerda' en 'Aart' zijn 6 jaar geleden gehuwd
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

  Regel: Als de minderjarige tijdens het huwelijk of partnerschap van de juridische ouder geboren is, dan hebben de ouder en diens (toenmalige) partner gezamenlijk gezag

    Voorbeeld: Minderjarige heeft ouder die gehuwd is met een meemoeder
      Gegeven 'Gerda' en 'Ariana' zijn 7 jaar geleden gehuwd
      En 'Bert' is 6 jaar geleden geboren
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en derde 'Ariana'

    Voorbeeld: Minderjarige heeft ouder die partnerschap heeft met een meemoeder
      Gegeven 'Gerda' en 'Ariana' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
      En 'Bert' is 6 jaar geleden geboren
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en derde 'Ariana'

    Voorbeeld: Minderjarige is geboren voor 1 april 2014 en moeder heeft geregistreerd partnerschap
      Gegeven 'Gerda' en 'Aart' zijn een geregistreerd partnerschap aangegaan op 1-3-2010
      En 'Bert' is geboren op 1-1-2012
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en derde 'Aart'

    Voorbeeld: Minderjarige is geboren voor 1 april 2014 en moeder had bij geboorte geregistreerd partnerschap dat daarna is ontbonden
      Gegeven 'Gerda' en 'Ariana' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
      En 'Bert' is 6 jaar geleden geboren
      En het geregistreerd partnerschap van 'Gerda' en 'Ariana' is 3 jaar geleden ontbonden
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en derde 'Ariana'

  Regel: Als de minderjarige tijdens het huwelijk of partnerschap van de juridische ouder is geadopteerd, dan hebben de ouder en diens (toenmalige) partner gezamenlijk gezag
    De ouder was immers bij geboorte nog geen ouder. We moeten dus kijken naar de aanvang familierechtelijke betrekking en niet naar geboortedatum

    @to-do @skip-verify
    Voorbeeld: adoptieouder was niet gehuwd op geboortedatum van de minderjarige maar wel gehuwd ten tijde van de adoptiedatum
      Gegeven 'Gerda' en 'Aart' zijn 6 jaar geleden gehuwd en 2 jaar geleden gescheiden
      En persoon 'Bert'
      * is 7 jaar geleden als vondeling geboren
      En 'Bert' is 5 jaar geleden geadopteerd door 'Gerda'
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en derde 'Aart'

    @to-do @skip-verify
    Voorbeeld: adoptieouder was gehuwd op geboortedatum van de minderjarige maar niet gehuwd ten tijde van de adoptiedatum
      Gegeven 'Gerda' en 'Aart' zijn 6 jaar geleden gehuwd en 2 jaar geleden gescheiden
      En persoon 'Bert'
      * is 3 jaar geleden als vondeling geboren
      En 'Bert' is 1 jaar geleden geadopteerd door 'Gerda'
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

  Regel: Als de minderjarige tijdens het huwelijk of partnerschap van de juridische ouder geboren is en er sprake is van ontkenning vaderschap, dan heeft de ouder eenhoofdig ouderlijk gezag

    @to-do @skip-verify
    Voorbeeld: Minderjarige heeft ouder die gehuwd is en de partner heeft het vaderschap ontkend
      Gegeven 'Gerda' en 'Aart' zijn 7 jaar geleden gehuwd
      En 'Bert' is 1 jaar geleden geboren
      En 'Aart' heeft ontkend vader te zijn van 'Bert'
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

  Regel: De partner behoudt gezag ook na nietigverklaring van het huwelijk
    De nietigverklaring heeft terugwerkende kracht tot het tijdstip van de huwelijkssluiting of het aangaan van het geregistreerde partnerschap.
    Het huwelijk of het geregistreerde partnerschap wordt geacht niet te hebben bestaan.
    Een rechtsfeit dat heeft plaatsgevonden voor de nietigverklaring, behoudt het rechtsgevolg.

    Een nietigverklaring van een huwelijk is ongelijk aan een nietig huwelijk.
    Een nietig huwelijk of geregistreerd partnerschap heeft geen enkel rechtsgevolg.

    Voorbeeld: Het huwelijk is na geboorte van de minderjarige nietig verklaard
      Gegeven 'Gerda' en 'Ariana' zijn 7 jaar geleden gehuwd
      En 'Bert' is 6 jaar geleden geboren
      En het huwelijk van 'Gerda' en 'Ariana' is 5 jaar geleden nietig verklaard
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'
