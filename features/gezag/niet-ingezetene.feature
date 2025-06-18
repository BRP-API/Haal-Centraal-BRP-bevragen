# language: nl
Functionaliteit: Gezag bepalen voor personen die in het buitenland verblijven

  @to-do @skip-verify
  Regel: Het gezag kan niet worden bepaald voor een minderjarige die een gewone verblijfplaats in het buitenland heeft
    Dit geldt voor:
    - een minderjarige die nooit een gewone verblijfplaats in Nederland heeft gehad
    - een minderjarige die geëmigreerd is, omdat we niet weten wat er in het buitenland gebeurd is
    
    Voor niet-ingezeten personen worden gegevens over gerelateerden (ouders) en over gezagsuitspraken niet bijgehouden. 
    Buitenlandse uitspraken over ouders en het gezag die in Nederland in het gezagsregister worden ingeschreven, worden niet in de Registratie Niet Ingezetenen (RNI) geregistreerd. 
    Het is daarmee niet mogelijk om over alle informatie te beschikken die nodig is om het gezag te bepalen. 

    Bij het bepalen van gezag wordt gekeken naar waar de persoon de "gewone" verblijfplaats heeft. Een persoon die als niet-ingezetene staat ingeschreven, maar een tijdelijke verblijfplaats in Nederland heeft, heeft op dat moment nog steeds de gewone verblijfplaats in het buitenland.
    In de API beschouwen we de gemeente van inschrijving van een persoon bepalend voor de gewone verblijfplaats. Is de persoon ingeschreven in een Nederlandse gemeente, dan heeft de persoon een Nederlands adres als gewone verblijfplaats.

    Achtergrond:
      Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
      * is meerderjarig
      En de persoon 'Aart' met burgerservicenummer '000000024'
      * is meerderjarig
      En de persoon 'Bert' met burgerservicenummer '000000036'
      * is minderjarig
      En de persoon 'Zoe' met burgerservicenummer '000000048'
      * is meerderjarig

    Voorbeeld: minderjarige staat ingeschreven als niet-ingezetene en heeft nooit een gewone verblijfplaats in Nederland gehad
      Gegeven persoon 'Bert'
      * is ingeschreven als niet-ingezetene met een verblijfplaats in België
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet Nederland als gewone verblijfplaats heeft.'

    Voorbeeld: minderjarige is nooit ingezetene van Nederland geweest en heeft een tijdelijke verblijfplaats in Nederland
      Gegeven persoon 'Bert'
      * is ingeschreven als niet-ingezetene met een verblijfplaats in België
      * is ingeschreven met een tijdelijke verblijfplaats in Nederland
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet Nederland als gewone verblijfplaats heeft.'

    Voorbeeld: minderjarige is geëmigreerd naar het buitenland en heeft twee ouders die op het moment van emigratie met elkaar gehuwd waren
      Gegeven 'Gerda' en 'Aart' zijn met elkaar gehuwd
      En persoon 'Bert'
      * heeft 'Aart' en 'Gerda' als ouders
      * is geboren in Nederland
      En 'Bert' is 1 jaar geleden geëmigreerd naar Duitsland
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet Nederland als gewone verblijfplaats heeft.'

    Voorbeeld: Er is in een gerechtelijke uitspraak gezag toegewezen en daarna is de minderjarige geëmigreerd
      Gegeven persoon 'Bert'
      * heeft 'Aart' en 'Gerda' als ouders
      En 2 jaar geleden is in een gerechtelijke uitspraak het gezag toegewezen aan <toegewezen aan>
      En 'Bert' is 1 jaar geleden geëmigreerd naar België
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet Nederland als gewone verblijfplaats heeft.'

      Voorbeelden:
        | toegewezen aan             | gezag uitspraak in Nederland                                  |
        | 'Gerda'                    | eenhoofdig ouderlijk gezag met ouder 'Gerda'                  |
        | 'Aart'                     | eenhoofdig ouderlijk gezag met ouder 'Aart'                   |
        | beide ouders               | gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart' |
        | een voogdijinstelling      | voogdij                                                       |
        | ouder 'Gerda' en een derde | gezamenlijk gezag met ouder 'Gerda' en een onbekende derde    |
        | ouder 'Aart' en een derde  | gezamenlijk gezag met ouder 'Aart' en een onbekende derde     |

  @to-do @skip-verify
  Regel: Gezag als er sprake is van opschorting bijhouding ministerieel besluit

    Voorbeeld: Bijhouding is opgeschort voor minderjarig kind van NAVO militair
      Gegeven 'Gerda' en 'Aart' zijn met elkaar gehuwd
      En persoon 'Bert'
      * heeft 'Aart' en 'Gerda' als ouders
      * is geboren in Nederland
      En 'Bert' is 1 jaar geleden geëmigreerd met onbekende bestemming
      En 1 jaar geleden is geconstateerd dat 'Aart' behoort tot de categorie NAVO-militair
      Als 'gezag' wordt gevraagd van 'Bert'
      Dan is het gezag over 'Bert' niet te bepalen met de toelichting 'gezag is niet te bepalen omdat minderjarige niet Nederland als gewone verblijfplaats heeft.'
