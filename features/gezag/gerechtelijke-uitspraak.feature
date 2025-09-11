# language: nl
Functionaliteit: Gerechtelijke uitspraak
  Voor een minderjarige waarover gerechtelijke uitspraak over gezag is gedaan, is de uitspraak alleen bepalend voor gezag als er geen ontkenning vaderschap, adoptie of (reparatie)huwelijk na de uitspraak heeft plaatsgevonden. De meest recente gebeurtenis is bepalend voor het gezag.

  Achtergrond:
    Gegeven de persoon 'Ariana'
    * is meerderjarig
    En de persoon 'Gerard'
    * is meerderjarig

  Regel: Als er een gerechtelijke uitspraak is dat één ouder het gezag heeft, en de ouders zijn daarna (opnieuw) met elkaar gehuwd, dan is er gezamenlijk ouderlijk gezag
    Opmerking: dit is niet altijd zo. als het gezag is beëindigd door een gezagsbeëindigende maatregel van de kinderrechter, dan herstelt het reparatiehuwelijk het gezag niet

    @to-do @skip-verify
    Voorbeeld: ouders zijn opnieuw met elkaar gehuwd (reparatiehuwelijk) na de gerechtelijke uitspraak
      Gegeven de minderjarige persoon 'Bert' met twee gehuwde ouders 'Gerda' en 'Aart'
      En 'Gerda' en 'Aart' zijn 7 jaar geleden gescheiden
      En 6 jaar geleden is in een gerechtelijke uitspraak het gezag toegewezen aan 'Aart'
      En 'Gerda' en 'Aart' zijn 2 jaar geleden opnieuw gehuwd
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    @to-do @skip-verify
    Voorbeeld: ouders zijn voor het eerst met elkaar gehuwd na de gerechtelijke uitspraak
      Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
      En 6 jaar geleden is in een gerechtelijke uitspraak het gezag toegewezen aan 'Aart'
      En 'Gerda' en 'Aart' zijn 2 jaar geleden gehuwd
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeeld: ouders zijn met een ander gehuwd na de gerechtelijke uitspraak
      Gegeven de minderjarige persoon 'Bert' met twee gehuwde ouders 'Gerda' en 'Aart'
      En 'Gerda' en 'Aart' zijn 7 jaar geleden gescheiden
      En 6 jaar geleden is in een gerechtelijke uitspraak het gezag toegewezen aan 'Aart'
      En 'Gerda' en 'Gerard' zijn 2 jaar geleden gehuwd
      En 'Aart' en 'Ariana' zijn 1 jaar geleden gehuwd
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Aart'

  Regel: Als er een gerechtelijke uitspraak is, en daarna is de minderjarige geadopteerd, dan wordt het gezag bepaald van rechtswege

    @to-do @skip-verify
    Voorbeeld: na de gerechtelijke uitspraak is de minderjarige geadopteerd
      Gegeven de minderjarige persoon 'Bert' met één ouder 'Gerda'
      En 6 jaar geleden is in een gerechtelijke uitspraak het gezag toegewezen aan een voogdijinstelling
      En 'Bert' is 2 jaar geleden geadopteerd door 'Ariana' en 'Gerard'
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Ariana' en ouder 'Gerard'

    Voorbeeld: na adoptie is er gerechtelijke uitspraak over gezag
      Gegeven de minderjarige persoon 'Bert' met één ouder 'Gerda'
      En 'Bert' is 6 jaar geleden geadopteerd door 'Ariana' en 'Gerard'
      En 2 jaar geleden is in een gerechtelijke uitspraak het gezag toegewezen aan een voogdijinstelling
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' voogdij

  Regel: Als er een gerechtelijke uitspraak is dat beide ouders gezag hebben, en het ouderschap is ontkend, dan heeft de overgebleven ouder eenhoofdig ouderlijk gezag

    @to-do @skip-verify
    Voorbeeld: na uitspraak over gezag aan beide ouders heeft vader ouderschap ontkend
      Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
      En 6 jaar geleden is in een gerechtelijke uitspraak het gezag toegewezen aan beide ouders
      En 4 jaar geleden heeft 'Aart' het ouderschap ontkend
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

    @to-do @skip-verify
    Voorbeeld: na uitspraak over gezag aan vader heeft vader ouderschap ontkend
      Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
      En 6 jaar geleden is in een gerechtelijke uitspraak het gezag toegewezen aan 'Aart'
      En 4 jaar geleden heeft 'Aart' het ouderschap ontkend
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' tijdelijk geen gezag met de toelichting 'Tijdelijk geen gezag omdat ouderschap door de gezagshouder is ontkend.'

  Regel: Als er een gerechtelijke uitspraak is dat één ouder het gezag heeft, dan is er eenhoofdig ouderlijk gezag

    Voorbeeld: het gezag is toegewezen aan één van de twee ouders
      Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
      En in een gerechtelijke uitspraak is het gezag toegewezen aan 'Aart'
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Aart'

  Regel: Als er een gerechtelijke uitspraak is dat beide ouders het gezag hebben, dan is er gezamenlijk ouderlijk gezag

    Voorbeeld: het gezag is toegewezen aan beide ouders
      Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
      En in een gerechtelijke uitspraak is het gezag toegewezen aan beide ouders
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

  Regel: Als er een gerechtelijke uitspraak is dat een voogd gezag heeft, dan is er sprake is van voogdij

    Voorbeeld: het gezag is toegewezen aan een voogdijinstelling
      Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
      En in een gerechtelijke uitspraak is een voogdijinstelling tot voogd benoemd
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' voogdij

    Voorbeeld: het gezag is toegewezen aan een derde
      Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
      En in een gerechtelijke uitspraak is een derde tot voogd benoemd
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' voogdij

  Regel: Als er een gerechtelijke uitspraak is dat één van de ouders gezag heeft samen met een derde, dan is er sprake van gezamenlijk gezag

    Voorbeeld: het gezag is toegewezen aan een van de ouders en een derde
      Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
      En in een gerechtelijke uitspraak is het gezag toegewezen aan 'Gerda' en een derde
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en een onbekende derde
