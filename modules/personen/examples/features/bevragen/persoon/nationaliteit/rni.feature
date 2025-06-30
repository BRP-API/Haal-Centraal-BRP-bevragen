#language: nl

Functionaliteit: nationaliteit

    Scenario: persoon heeft meerdere nationaliteiten aangeleverd door RNI deelnemer
      Gegeven de persoon met burgerservicenummer '000000140' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
      | 0263                  | 301                   | 19620107                        | 201                   |
      En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) | rni-deelnemer (88.10) |
      | 0052                  | 301                   | 19830326                        | 0501                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000140                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
      | naam                              | waarde                                   |
      | type                              | Nationaliteit                            |
      | nationaliteit.code                | 0263                                     |
      | nationaliteit.omschrijving        | Surinaamse                               |
      | redenOpname.code                  | 301                                      |
      | redenOpname.omschrijving          | Vaststelling bezit vreemde nationaliteit |
      | datumIngangGeldigheid.type        | Datum                                    |
      | datumIngangGeldigheid.datum       | 1962-01-07                               |
      | datumIngangGeldigheid.langFormaat | 7 januari 1962                           |
      En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
      | naam                              | waarde                                   |
      | type                              | Nationaliteit                            |
      | nationaliteit.code                | 0052                                     |
      | nationaliteit.omschrijving        | Belgische                                |
      | redenOpname.code                  | 301                                      |
      | redenOpname.omschrijving          | Vaststelling bezit vreemde nationaliteit |
      | datumIngangGeldigheid.type        | Datum                                    |
      | datumIngangGeldigheid.datum       | 1983-03-26                               |
      | datumIngangGeldigheid.langFormaat | 26 maart 1983                            |
      En heeft de persoon een 'rni' met de volgende gegevens
      | naam                   | waarde                                            |
      | deelnemer.code         | 0201                                              |
      | deelnemer.omschrijving | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |
      | categorie              | Nationaliteit                                     |
      En heeft de persoon nog een 'rni' met de volgende gegevens
      | naam                   | waarde                                                             |
      | deelnemer.code         | 0501                                                               |
      | deelnemer.omschrijving | Immigratie- en naturalisatiedienst (inzake nationaliteitsgegevens) |
      | categorie              | Nationaliteit                                                      |
