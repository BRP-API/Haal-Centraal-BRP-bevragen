# language: nl
Functionaliteit: gezag van een meerderjarige over een kind

  Regel: een meerderjarige die gezag heeft over een minderjarig kind krijgt de gezagsrelatie geleverd

  Abstract Scenario: persoon heeft gezamenlijk ouderlijk gezag over het minderjarige kind
    Gegeven de persoon 'Aart' met burgerservicenummer '000000012'
    * is ingeschreven in de BRP
    * is meerderjarig
    En de persoon 'Gerda' met burgerservicenummer '000000024'
    * is ingeschreven in de BRP
    * is meerderjarig
    En 'Aart' en 'Gerda' zijn met elkaar gehuwd
    En de persoon 'Bert' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Gerda' als ouder 1
    * heeft 'Aart' als ouder 2
    Als 'gezag' wordt gevraagd van '<naam>'
    Dan heeft '<naam>' de volgende gezagsrelaties
    * is het gezag over 'Bert' gezamenlijk ouderlijk gezag met ouder 'Aart' en ouder 'Gerda'

    Voorbeelden:
      | omschrijving            | naam  |
      | vraag gezag van ouder 1 | Gerda |
      | vraag gezag van ouder 2 | Aart  |

  Scenario: persoon heeft eenhoofdig ouderlijk gezag over het minderjarige kind
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is ingeschreven in de BRP
    * is meerderjarig
    En de persoon 'Bert' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Gerda' als ouder 1
    Als 'gezag' wordt gevraagd van 'Gerda'
    Dan heeft 'Gerda' de volgende gezagsrelaties
    * is het gezag over 'Bert' eenhoofdig ouderlijk gezag met ouder 'Gerda'

  Regel: een meerderjarige die geen gezag heeft over een minderjarig kind krijgt de gezagsrelatie niet geleverd

  Scenario: vader heeft geen gezag over minderjarig kind omdat deze niet gehuwd is noch partnerschap heeft met de moeder
    Gegeven de persoon 'Aart' met burgerservicenummer '000000012'
    * is ingeschreven in de BRP
    * is meerderjarig
    En de persoon 'Gerda' met burgerservicenummer '000000024'
    * is ingeschreven in de BRP
    * is meerderjarig
    En de persoon 'Bert' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Gerda' als ouder 1
    * heeft 'Aart' als ouder 2
    Als 'gezag' wordt gevraagd van 'Aart'
    Dan heeft 'Aart' de volgende gezagsrelaties
    * heeft de persoon geen gezag

  Abstract Scenario: vader heeft geen gezag over minderjarig kind omdat er in een gerechtelijke uitspraak over gezag het gezag is toegewezen aan <omschrijving gezag>
    Gegeven de persoon 'Aart' met burgerservicenummer '000000012'
    * is ingeschreven in de BRP
    * is meerderjarig
    En de persoon 'Gerda' met burgerservicenummer '000000024'
    * is ingeschreven in de BRP
    * is meerderjarig
    En 'Aart' en 'Gerda' zijn met elkaar gehuwd
    En de persoon 'Bert' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Gerda' als ouder 1
    * heeft 'Aart' als ouder 2
    En voor 'Bert' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | <indicatie gezag>                    | gisteren - 1 jaar               |
    Als 'gezag' wordt gevraagd van 'Aart'
    Dan heeft 'Aart' de volgende gezagsrelaties
    * heeft de persoon geen gezag

    Voorbeelden:
      | indicatie gezag | omschrijving gezag           |
      | D               | een derde                    |
      | 1               | de andere ouder              |
      | 1D              | de andere ouder en een derde |

  Abstract Scenario: vader heeft geen gezag over minderjarig kind omdat gezag niet kan worden bepaald
    Gegeven de persoon 'Aart' met burgerservicenummer '000000012'
    * is ingeschreven in de BRP
    * is meerderjarig
    En de persoon 'Gerda' met burgerservicenummer '000000024'
    * is ingeschreven in de BRP
    * is meerderjarig
    En 'Aart' en 'Gerda' zijn met elkaar gehuwd
    En de persoon 'Bert' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * is geëmigreerd geweest
    * heeft 'Gerda' als ouder 1
    * heeft 'Aart' als ouder 2
    Als 'gezag' wordt gevraagd van 'Aart'
    Dan heeft 'Aart' de volgende gezagsrelaties
    * heeft de persoon geen gezag
