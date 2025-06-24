#language: nl

Functionaliteit: Gezag uitspreken over meerderjarig verklaarde minderjarigen

  Scenario: De moeder is minderjarig en meerderjarig verklaard door middel van een gerechtelijke uitspraak.
    Gegeven de persoon 'Lieke' met burgerservicenummer '000000012'
    * is minderjarig
    En de persoon 'Ronald' met burgerservicenummer '000000024'
    * is minderjarig
    * is in Nederland geboren
    * is ingeschreven in de BRP
    * heeft 'Lieke' als ouder 1
    En voor 'Ronald' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens
      | indicatie gezag minderjarige (32.10) | ingangsdatum geldigheid (85.10) |
      | 1                                    | 20250101                        |
    Als 'gezag' wordt gevraagd van 'Ronald'
    Dan is het gezag over 'Ronald' tijdelijk geen gezag met de toelichting 'Tijdelijk geen gezag omdat de ouder minderjarig is.'
