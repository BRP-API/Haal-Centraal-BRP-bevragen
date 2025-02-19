# language: nl
Functionaliteit: leveren van de (mogelijke) bewoners van een bewoning periode in een vaste volgorde (sortering)

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      |                 0800 |                         0800010000000001 |

  @info-api @data-api
  Regel: de (mogelijke) bewoners worden oplopend gesorteerd op basis van datum aanvang adreshouding zodat de eerste (mogelijke) bewoner op het adres als eerste in de (mogelijke) bewoners lijst staat.

    @info-api @valideer-volgorde
    Scenario: De bewoners in een gevraagde bewoning periode hebben verschillende datum aanvang adreshouding
      Gegeven de persoon
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
        |                   000000012 | Piet              | Zoutelande            |
      * is ingeschreven op adres 'A1' op '2024-02-01'
      En de persoon
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
        |                   000000024 | Jan               | Daal                  |
      * is ingeschreven op adres 'A1' op '2024-01-01'
      En de persoon
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
        |                   000000036 | Kees              | Albers                |
      * is ingeschreven op adres 'A1' op '2024-03-01'
      Als de bewoning wordt gevraagd van adres 'A1' voor peildatum '2024-07-01'
      Dan heeft de response een bewoning
        | type                 | adresseerbaarObjectIdentificatie | periode                   |
        | BewoningMetPeildatum |                 0800010000000001 | 2024-07-01 tot 2024-07-02 |
      * met de volgende bewoners
        | burgerservicenummer | naam.volledigeNaam |
        |           000000024 | Jan Daal           |
        |           000000012 | Piet Zoutelande    |
        |           000000036 | Kees Albers        |

    @data-api @valideer-volgorde
    Scenario: De bewoners in een gevraagde bewoning periode hebben verschillende datum aanvang adreshouding
      Gegeven de persoon
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
        |                   000000012 | Piet              | Zoutelande            |
      * is ingeschreven op adres 'A1' op '2024-02-01'
      En de persoon
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
        |                   000000024 | Jan               | Daal                  |
      * is ingeschreven op adres 'A1' op '2024-01-01'
      En de persoon
        | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
        |                   000000036 | Kees              | Albers                |
      * is ingeschreven op adres 'A1' op '2024-03-01'
      Als de bewoning wordt gevraagd van adres 'A1' voor peildatum '2024-07-01'
      Dan heeft de response een bewoning
        | type                 | adresseerbaarObjectIdentificatie | periode                   |
        | BewoningMetPeildatum |                 0800010000000001 | 2024-07-01 tot 2024-07-02 |
      * met de volgende bewoners
        | burgerservicenummer | naam.voornamen | naam.geslachtsnaam |
        |           000000024 | Jan            | Daal               |
        |           000000012 | Piet           | Zoutelande         |
        |           000000036 | Kees           | Albers             |
