#language: nl

Functionaliteit: Wanneer een gegeven in de registratie een gecodeerde waarde met een beperkte set mogelijke waarden heeft, wordt dit in de API geleverd als zowel een code als de bijbehorende betekenis.

De onderstaanden tabellen met de beschreven waarden worden geleverd door de "BRP tabellen bevragen"-API


  Voor de enumeratie AanduidingBijHuisnummer wordt de tabel met identificatie "aanduidingbijhuisnummer" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "De aanduiding "bij" of "tegenover" wordt gebruikt voor adressen die geen straatnaam en huisnummeraanduidingen hebben, maar verwijzen naar een (verblijf)plaats in de buurt."

  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                     |
    | ------------------------------------------------ | -------------------------------- |
    | to                                               | tegenover                        |
    | by                                               | bij                              |

  Voor de enumeratie Geslacht wordt de tabel met identificatie "Geslacht" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Geeft aan wat het geslacht is van persoon."
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                     |
    | ------------------------------------------------ | -------------------------------- |
    | M                                                | man                              |
    | V                                                | vrouw                            |
    | O                                                | onbekend                         |

  Voor de enumeratie Naamgebruik wordt de tabel met identificatie "Naamgebruik" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "De manier waarop de geslachtsnaam van persoon en partner van persoon moet worden verwerkt in de manier waarop persoon wil worden aangesproken."
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                               |
    | ------------------------------------------------ | ------------------------------------------ |
    | E                                                | gebruik alleen de eigen naam               |
    | N                                                | gebruik de eigennaam voor de partnernaam   |
    | P                                                | gebruik alleen de partnernaam              |
    | V                                                | gebruik de partnernaam voor de eigen naam  |

  Voor de enumeratie RedenOpschortingBijhouding wordt de tabel met identificatie "Reden_Opschorting_Bijhouding" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Redenen voor opschorting van de bijhouding"
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                         |
    | ------------------------------------------------ | ------------------------------------ |
    | O                                                | overlijden                           |
    | E                                                | emigratie                            |
    | M                                                | ministerieel besluit                 |4
    | R                                                | persoonslijst is aangelegd in de rni |
    | F                                                | fout                                 |
    | .                                                | onbekend                             |

  Voor de enumeratie SoortVerbintenis wordt de tabel met identificatie "Soort_Verbintenis" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Soort verbintenis die bij de burgerlijke stand is ingeschreven"
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                         |
    | ------------------------------------------------ | ------------------------------------ |
    | H                                                | huwelijk                             |
    | P                                                | geregistreerd partnerschap           |

    Voor de enumeratie SoortAdres wordt de tabel met identificatie "Functie_Adres" opgenomen.
    In de omschrijving wordt de volgende tekst opgenomen : "Aanduiding van de functie van het adres"
    In de waardetabel worden de volgende waarden opgenomen:
      | code                                             | omschrijving                         |
      | ------------------------------------------------ | ------------------------------------ |
      | W                                                | woonadres                            |
      | B                                                | briefadres                           |

      Voor de enumeratie indicatieGezagMinderjarige identificatie "Gezag_Minderjarige" opgenomen.
      In de omschrijving wordt de volgende tekst opgenomen : "Aanduiding van de functie van het adres"
      In de waardetabel worden de volgende waarden opgenomen:
        | code                                             | omschrijving                         |
        | ------------------------------------------------ | ------------------------------------ |
        | 1                                                | ouder1                               |
        | 2                                                | ouder2                               |
        | D                                                | derden                               |
        | 1D                                               | ouder1 en derde                      |
        | 2D                                               | ouder2 en derde                      |
        | 12                                               | ouder1 en ouder2                     |

  Scenario: een onbekende waarde wordt niet opgenomen in de response
    Gegeven in de registratie heeft de AanduidingBijHuisnummer van de verblijfplaats de waarde "naast"
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.aanduidingBijHuisnummer niet aanwezig

  Scenario: een bekende waarde wordt wel opgenomen in de response
    Gegeven in de registratie heeft het geslacht de waarde "O" (onbekend)
    Als de persoon wordt geraadpleegd
    Dan heeft attribuut geslacht de waarde "onbekend"
