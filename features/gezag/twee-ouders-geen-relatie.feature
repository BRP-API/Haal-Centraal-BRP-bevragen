# language: nl
Functionaliteit: Twee ouders geen relatie
  Gezag bepalen voor een minderjarige met twee juridische ouders die na de geboorte van het kind niet gehuwd zijn of waren en geen partnerschap hebben of hadden.

  Achtergrond:
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is meerderjarig
    * is een vrouw
    En de persoon 'Aart' met burgerservicenummer '000000024'
    * is meerderjarig
    * is een man
    En de persoon 'Ariana' met burgerservicenummer '000000048'
    * is meerderjarig
    * is een vrouw
    En de persoon 'Bert' met burgerservicenummer '000000036'
    * is minderjarig
    * is ingeschreven in de BRP

  Regel: Als de minderjarige is geadopteerd door één of beide ouders dan hebben de ouders samen gezamenlijk ouderlijk gezag

    Voorbeeld: Minderjarige is geadopteerd door beide ouders
      Gegeven 'Bert' is geadopteerd door 'Gerda' en 'Aart'
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeeld: Minderjarige is geadopteerd door de stiefouder
      Gegeven persoon 'Bert'
      * heeft 'Gerda' als ouder
      En 'Bert' is geadopteerd door 'Aart'
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

  Regel: Als de minderjarige is erkend na 1 januari 2023 dan hebben de ouders samen gezamenlijk ouderlijk gezag

    Voorbeeld: Minderjarige is als ongeboren vrucht erkend na 1 januari 2023
      Gegeven 'Bert' is gisteren geboren
      * heeft 'Aart' en 'Gerda' als ouders vanaf de geboortedatum
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeeld: Minderjarige is erkend na 1 januari 2023
      Gegeven 'Bert' is geboren op 29-12-2022
      * heeft 'Gerda' als ouder vanaf de geboortedatum
      En 'Bert' is erkend door 'Aart' op 3-1-2023
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

  Regel: Als de ouders na de geboorte van minderjarige niet met elkaar gehuwd zijn (geweest) en geen partnerschap hebben (gehad) en de minderjarige is erkend voor 1 januari 2023 dan heeft de geboortemoeder eenhoofdig ouderlijk gezag

    Voorbeeld: Ouders zijn nooit met elkaar gehuwd geweest en minderjarige is erkend voor 1 januari 2023
      Gegeven 'Bert' is geboren op 29-11-2022
      * heeft 'Gerda' als ouder vanaf de geboortedatum
      En 'Bert' is erkend door 'Aart' op 30-12-2022
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

    Voorbeeld: Minderjarige is als ongeboren vrucht erkend voor 1 januari 2023
      Gegeven 'Bert' is geboren op 30-11-2022
      * heeft 'Aart' en 'Gerda' als ouders vanaf de geboortedatum
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

    @to-do @skip-verify
    Voorbeeld: Ouders waren met elkaar gehuwd en zijn voor geboorte van de minderjarige gescheiden
      Gegeven 'Gerda' en 'Aart' zijn gehuwd op 1-6-2015
      En 'Gerda' en 'Aart' zijn op 1-7-2020 gescheiden
      En persoon 'Bert'
      * is geboren op 30-11-2022
      * heeft 'Aart' en 'Gerda' als ouders vanaf de geboortedatum
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

    Voorbeeld: Minderjarige is geboren voor 1 januari 2023 en is als ongeboren vrucht erkend door andere ouder
      Gegeven 'Bert' is geboren op 30-11-2022
      * heeft 'Ariana' en 'Gerda' als ouders vanaf de geboortedatum
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'Gezag kan niet worden bepaald omdat niet kan worden vastgesteld welke ouder de geboortemoeder is.'

    Voorbeeld: Minderjarige is geboren voor 1 januari 2023 in een huwelijk van twee vrouwen en is als ongeboren vrucht erkend door de bekende donor
      Gegeven 'Gerda' en 'Ariana' zijn gehuwd op 1-6-2019
      En 'Bert' is geboren op 30-11-2022
      * heeft 'Aart' en 'Gerda' als ouders vanaf de geboortedatum
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

  Regel: Als minderjarige vóór de geboorte is erkend na 1 januari 2023, dan hebben de moeder en de erkenner gezamenlijk ouderlijk gezag
    ⁠Als de bekende donor vóór de geboorte erkent, dan heeft de bekende donor met de geboortemoeder gezamenlijk het gezag. De echtgenote (de meemoeder) heeft dan niks: is geen ouder en heeft geen gezag. (de tenzij van 1:253sa BW)

    Voorbeeld: Minderjarige is na 1 januari 2023 vóór de geboorte erkend door bekende donor en moeder is gehuwd met een vrouw
      Gegeven 'Gerda' en 'Ariana' zijn 2 jaar geleden gehuwd
      En 'Bert' is 1 jaar geleden geboren
      * heeft 'Gerda' en 'Aart' als ouders vanaf de geboortedatum
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeeld: Minderjarige is na 1 januari 2023 vóór de geboorte erkend door de vrouwlijke partner van de moeder (meemoeder)
      Gegeven 'Gerda' en 'Ariana' zijn 2 jaar geleden gehuwd
      En 'Bert' is 1 jaar geleden geboren
      * heeft 'Gerda' en 'Ariana' als ouders vanaf de geboortedatum
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Ariana'

  @to-do @skip-verify
  Regel: Als minderjarige na de geboorte is erkend en na 1 januari 2023 door een bekende donor, dan hebben de moeder en de partner van de moeder gezamenlijk gezag
    Vindt er vóór de geboorte géén erkenning plaats, dan heeft het kind vanaf de geboorte alleen een geboortemoeder en hebben beide moeders (geboortemoeder en haar partner) gezamenlijk het gezag (1:253sa BW). 
    De partner of de bekende donor kan daarna erkennen. Het gezag blijft bij de meemoeder en de moeder.

    De dag van erkenning maakt hier niet uit, kan ook de geboortedag zijn.

    Voorbeeld: Minderjarige is na 1 januari 2023 en bij geboorteaangifte erkend door de bekende donor en moeder is gehuwd met een vrouw
      Gegeven 'Gerda' en 'Ariana' zijn 2 jaar geleden gehuwd
      En 'Bert' is 1 jaar geleden geboren
      * heeft 'Gerda' als ouder vanaf de geboortedatum
      En 'Bert' is erkend door 'Aart' bij geboorteaangifte
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en ouder 'Ariana'

    Voorbeeld: Minderjarige is na 1 januari 2023 en na geboorte erkend door bekende donor en moeder is gehuwd met een vrouw
      Gegeven 'Gerda' en 'Ariana' zijn gehuwd op 28-9-2022
      En persoon 'Bert'
      * is geboren op 4-1-2023
      * heeft 'Gerda' als ouder vanaf de geboortedatum
      En 'Bert' is erkend door 'Aart' na geboorteaangifte op 3-2-2023
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk gezag met ouder 'Gerda' en derde 'Ariana'

  Regel: Als minderjarige na de geboorte en na 1 januari 2023 is erkend door de partner van de moeder, dan hebben de moeder en de partner van de moeder gezamenlijk ouderlijk gezag

    Voorbeeld: Minderjarige is na 1 januari 2023 en na de geboorte erkend door de vrouwelijke partner van de moeder (meemoeder)
      Gegeven 'Gerda' en 'Ariana' zijn gehuwd op 28-9-2022
      En persoon 'Bert'
      * is geboren op 4-1-2023
      * heeft 'Gerda' als ouder vanaf de geboortedatum
      En 'Bert' is erkend door 'Ariana' na geboorteaangifte op 3-2-2023
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Ariana'
