#language: nl

Functionaliteit: gezag van een meerderjarige die niet in de BRP staat ingeschreven

  Achtergrond:
    Gegeven de persoon 'Mark' met burgerservicenummer '000000012'
    * is ingeschreven in de BRP
    * is meerderjarig
    En de persoon 'Marlies' met burgerservicenummer '000000024'
    * is ingeschreven in de BRP
    * is meerderjarig
    En 'Mark' en 'Marlies' zijn met elkaar gehuwd

  Regel: een persoon die in RNI staat ingeschreven krijgt gezag niet te bepalen geleverd wanneer de leeftijd lager is dan 18 jaar
    # wanneer de persoon meerderjarig is, moet geen 'gezag niet te bepalen' worden geleverd
    # 'gezag niet te bepalen' wordt alleen geleverd wanneer de persoon minderjarig is

  Scenario: minderjarig persoon in RNI
    Gegeven de persoon 'Mees' met burgerservicenummer '000000036'
    * is ingeschreven in de RNI
    * is minderjarig
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Marlies' als ouder 1
    * heeft 'Mark' als ouder 2
    Als 'gezag' wordt gevraagd van 'Mees'
    Dan is het gezag over 'Mees' niet te bepalen met de toelichting 'Gezag kan niet worden bepaald omdat minderjarige niet in Nederland woont.'

  Scenario: een meerderjarig persoon in RNI en zonder kinderen
    Gegeven de persoon 'Mees' met burgerservicenummer '000000036'
    * is ingeschreven in de RNI
    * is meerderjarig
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Marlies' als ouder 1
    * heeft 'Mark' als ouder 2
    Als 'gezag' wordt gevraagd van 'Mees'
    Dan heeft 'Mees' de volgende gezagsrelaties
    * heeft de persoon geen gezag

  Scenario: meerderjarige persoon in RNI met gezag over kind
    Gegeven de persoon 'Michiel' met burgerservicenummer '000000048'
    * is ingeschreven in de BRP
    * is meerderjarig
    En de persoon 'Marielle' met burgerservicenummer '000000061'
    * is ingeschreven in de RNI
    * is meerderjarig
    En 'Michiel' en 'Marielle' zijn met elkaar gehuwd
    En de persoon 'Maud' met burgerservicenummer '000000036'
    * is ingeschreven in de BRP
    * is minderjarig
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Marielle' als ouder 1
    * heeft 'Michiel' als ouder 2
    Als 'gezag' wordt gevraagd van 'Marielle'
    Dan heeft 'Marielle' de volgende gezagsrelaties
    * is het gezag over 'Maud' gezamenlijk ouderlijk gezag met ouder 'Michiel' en ouder 'Marielle'

  Regel: een persoon die in RNI staat ingeschreven met een onvolledige geboortedatum krijgt gezag niet te bepalen geleverd wanneer de persoon op de eerste dag van de onzekerheidsperiode niet ouder dan 18 jaar is
    # leeftijd wordt berekend op basis van een fixtieve geboortedatum gelijk aan de eerste dag van de onzekerheidsperiode
    # wanneer de persoon meerderjarig is, moet geen 'gezag niet te bepalen' worden geleverd
    # 'gezag niet te bepalen' wordt alleen geleverd wanneer de persoon nog minderjarig is

  Abstract Scenario: persoon in RNI <omschrijving>
    Gegeven de persoon 'Mees' met burgerservicenummer '000000036'
    * is ingeschreven in de RNI
    * heeft de volgende gegevens
      | geboortedatum (03.10) |
      | <geboortedatum>       |
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Marlies' als ouder 1
    * heeft 'Mark' als ouder 2
    Als 'gezag' wordt gevraagd van 'Mees'
    Dan is het gezag over 'Mees' niet te bepalen met de toelichting 'Gezag kan niet worden bepaald omdat minderjarige niet in Nederland woont.'

    Voorbeelden:
      | geboortedatum            | leeftijd      | omschrijving                                                                             |
      | deze maand - 5 jaar      | 4 of 5 jaar   | met alleen maand en jaar van geboortedatum bekend en is de hele maand jonger dan 18 jaar |
      | dit jaar - 5 jaar        | 4 of 5 jaar   | met alleen jaar van geboortedatum bekend en is het hele jaar jonger dan 18 jaar          |
      | volgende maand - 18 jaar | 17 jaar       | met alleen maand en jaar van geboortedatum bekend en wordt volgende maand 18 jaar        |
      | dit jaar - 17 jaar       | 16 of 17 jaar | met alleen jaar van geboortedatum bekend en is of wordt dit jaar 17 jaar                 |

  Abstract Scenario: persoon in RNI <omschrijving>
    Gegeven de persoon 'Mees' met burgerservicenummer '000000036'
    * is ingeschreven in de RNI
    * heeft de volgende gegevens
      | geboortedatum (03.10) |
      | <geboortedatum>       |
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Marlies' als ouder 1
    * heeft 'Mark' als ouder 2
    Als 'gezag' wordt gevraagd van 'Mees'
    Dan heeft 'Mees' de volgende gezagsrelaties
    * heeft de persoon geen gezag

    Voorbeelden:
      | geboortedatum          | leeftijd      | omschrijving                                                                            |
      | deze maand - 35 jaar   | 34 of 35 jaar | met alleen maand en jaar van geboortedatum bekend en is de hele maand ouder dan 18 jaar |
      | dit jaar - 35 jaar     | 34 of 35 jaar | met alleen jaar van geboortedatum bekend en is het hele jaar ouder dan 18 jaar          |
      | deze maand - 18 jaar   | 17 of 18 jaar | met alleen maand en jaar van geboortedatum bekend en is of wordt deze maand 18 jaar     |
      | vorige maand - 18 jaar | 18 jaar       | met alleen maand en jaar van geboortedatum bekend en werd vorige maand 18 jaar          |
      | dit jaar - 18 jaar     | 17 of 18 jaar | met alleen jaar van geboortedatum bekend en is of wordt dit jaar 18 jaar                |
      | dit jaar - 19 jaar     | 18 of 19 jaar | met alleen jaar van geboortedatum bekend en is 18 en is of wordt dit jaar 19 jaar       |


  Regel: een persoon die in RNI staat ingeschreven met een volledig onbekende geboortedatum krijgt geen gezag geleverd
    # wanneer de geboortedatum is gelijk aan 00000000, is de persoon meerderjarig

  Scenario: persoon in RNI en geboortedatum is volledig onbekend
    Gegeven de persoon 'Mees' met burgerservicenummer '000000036'
    * is ingeschreven in de RNI
    * heeft de volgende gegevens
      | geboortedatum (03.10) |
      | 00000000              |
    * is in Nederland geboren
    * is niet geëmigreerd geweest
    * heeft 'Marlies' als ouder 1
    * heeft 'Mark' als ouder 2
    Als 'gezag' wordt gevraagd van 'Mees'
    Dan heeft 'Mees' de volgende gezagsrelaties
    * heeft de persoon geen gezag
