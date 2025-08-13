#language: nl

Functionaliteit: Wie is de geboortemoeder van het kind?

  Er zijn situaties waar voor het kind twee personen als ouder geregistreerd zijn, maar het onbekend is wie de moeder van het kind is.
  Bij gezag bepaling is het belangrijk om te weten wie de moeder is, gezien deze normaal gezien automatisch het gezag over het kind krijgt bij de geboorte.
  Er zijn situaties waarbij dit niet zo, zie daarvoor bijvoorbeeld: 4a.3 ouder overleden of onbevoegd tot gezag.

  Wanneer een kind bij geboorte erkend is (erkenning ongeboren vrucht) is op te merken dat we daar niet kunnen vaststellen wie de erkenning heeft gedaan.
  Bij erkenning na 1-1-2023 geen probleem want dan hebben beide ouders gezag. Bij erkenning voor 1-1-2023 is dit wel een probleem want dan heeft alleen de geboortemoeder automatisch gezag.
  Daarnaast komt de situatie waarbij een kind twee moeders heeft, een geboortemoeder en een meemoeder.

  Om vast te stellen wie de geboortemoeder wordt de geslachtsaanduiding gecontrolleerd.
  Met geslachtsaanduiding is onderscheid te maken tussen man en vrouw.
  Wat betekend in de situaties waarbij de ouders man en vrouw zijn, duidelijk is wie de geboortemoeder is.

  Voor de situatie met een mee-moeder, waarbij dus beide ouders vrouw zijn kan gekeken worden naar de geslachtsnaam van het kind.
  Wanneer de geslachtsnaam van het kind overeenkomt met één van de vrouwen (ouders) is dat de geboortemoeder.

  Bij de situatie dat beide ouders man zijn, is de geboortemoeder niet te achterhalen.

  Aanbeveling
  Er wordt gewerkt aan een vastlegging middels een indicatie wie de geboortemoeder is.

  Achtergrond:
    Gegeven de persoon 'Noah' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Marijn' met burgerservicenummer '000000024'
    * is meerderjarig
    En de persoon 'Vanessa' met burgerservicenummer '000000036'
    * is minderjarig
    * is in Nederland geboren
    * is ingeschreven in de BRP

  Regel: een kind geboren voor 01-01-2023

  Scenario: Voor een kind waarvan beide ouders geen geslachtsaanduiding hebben, kan niet worden bepaald wie gezag heeft er is sprake van GezagNietTeBepalen
    Gegeven persoon 'Vanessa'
    * heeft 'Noah' als ouder 1
    * heeft 'Marijn' als ouder 2
    Als 'gezag' wordt gevraagd van 'Vanessa'
    Dan is het gezag over 'Vanessa' niet te bepalen met de toelichting 'Gezag kan niet worden bepaald omdat niet kan worden vastgesteld welke ouder de geboortemoeder is.'

  Scenario: Voor een kind waarvan beide ouders een onbekende geslachtsaanduiding hebben, kan niet worden bepaald wie gezag heeft er is sprake van GezagNietTeBepalen
    Gegeven persoon 'Vanessa'
    * heeft 'Noah' als ouder 1 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | O                           | gisteren - 17 jaar                                 |
    * heeft 'Marijn' als ouder 2 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | O                           | gisteren - 17 jaar                                 |
    Als 'gezag' wordt gevraagd van 'Vanessa'
    Dan is het gezag over 'Vanessa' niet te bepalen met de toelichting 'Gezag kan niet worden bepaald omdat niet kan worden vastgesteld welke ouder de geboortemoeder is.'

  Scenario: Voor een kind waarvan een ouder de geslachtsaanduiding vrouw heeft, kan worden bepaald wie gezag heeft er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Noah'
    * is een vrouw
    Gegeven persoon 'Vanessa'
    * heeft 'Noah' als ouder 1 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | V                           | gisteren - 17 jaar                                 |
    * heeft 'Marijn' als ouder 2
    Als 'gezag' wordt gevraagd van 'Vanessa'
    Dan is het gezag over 'Vanessa' eenhoofdig ouderlijk gezag met ouder 'Noah'

  Scenario: Voor een kind waarvan de tweede ouder de geslachtsaanduiding vrouw heeft, kan worden bepaald wie gezag heeft er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Marijn'
    * is een vrouw
    Gegeven persoon 'Vanessa'
    * heeft 'Noah' als ouder 1
    * heeft 'Marijn' als ouder 2 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | V                           | gisteren - 17 jaar                                 |
    Als 'gezag' wordt gevraagd van 'Vanessa'
    Dan is het gezag over 'Vanessa' eenhoofdig ouderlijk gezag met ouder 'Marijn'

  Scenario: Voor een kind waarvan een ouder de geslachtsaanduiding vrouw heeft en de andere man, kan worden bepaald wie gezag heeft er is sprake van EenhoofdigOuderlijkGezag
    Gegeven persoon 'Noah'
    * is een vrouw
    Gegeven persoon 'Marijn'
    * is een vrouw
    Gegeven persoon 'Vanessa'
    * heeft 'Noah' als ouder 1 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | V                           | gisteren - 17 jaar                                 |
    * heeft 'Marijn' als ouder 2 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | M                           | gisteren - 17 jaar                                 |
    Als 'gezag' wordt gevraagd van 'Vanessa'
    Dan is het gezag over 'Vanessa' eenhoofdig ouderlijk gezag met ouder 'Noah'

  Scenario: Voor een kind waarvan beide ouders de geslachtsaanduiding vrouw hebben, kan niet worden bepaald wie gezag heeft er is sprake van GezagNietTeBepalen
    Gegeven persoon 'Noah'
    * is een vrouw
    Gegeven persoon 'Marijn'
    * is een vrouw
    Gegeven persoon 'Vanessa'
    * heeft 'Noah' als ouder 1 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | V                           | gisteren - 17 jaar                                 |
    * heeft 'Marijn' als ouder 2 met de volgende gegevens
      | geslachtsaanduiding (04.10) | datum ingang familierechtelijke betrekking (62.10) |
      | V                           | gisteren - 17 jaar                                 |
    Als 'gezag' wordt gevraagd van 'Vanessa'
    Dan is het gezag over 'Vanessa' niet te bepalen met de toelichting 'Gezag kan niet worden bepaald omdat niet kan worden vastgesteld welke ouder de geboortemoeder is.'
