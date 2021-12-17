Functionaliteit: Als developer wil ik waardetabellen gebruiken in plaats van enumeraties
  zodat ik mijn code niet hoef aan te passen als een enumeratielijst wordt aangepast die ik in mijn functionaliteit niet gebruik.

  Wanneer in de registratie specifieke waarden in een enumeratie voorkomen, worden deze waarden in de API doorgegeven middels een waardetabel.
  Wanneer in de registratie een omschrijving gekoppeld is aan een specifieke enumeratiewaarde, wordt deze omschrijving raadpleegbaar gemaakt middels de waardetabellen API.


  Voor de enumeratie AanduidingBijzonderNederlanderschap wordt de tabel met tabelidentificatie "aanduidingbijzondernederlanderschap" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Geeft aan dat de persoon behandeld wordt als Nederlander, of dat door de rechter is vastgesteld dat de persoon niet de Nederlandse nationaliteit bezit."
  In de tabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                     |
    | ------------------------------------------------ | -------------------------------- |
    | B                                                | Behandeld als nederlander        |
    | V                                                | Vastgesteld Niet-Nederlander     |

  Voor de enumeratie AanduidingBijHuisnummer wordt de tabel met identificatie "aanduidingbijhuisnummer" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "De aanduiding die wordt gebruikt voor adressen die geen straatnaam en huisnummeraanduidingen hebben."
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                     |
    | ------------------------------------------------ | -------------------------------- |
    | to                                               | tegenover                        |
    | by                                               | bij                              |

  Voor de enumeratie Geslacht wordt de tabel met identificatie "geslacht" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Geeft aan dat de persoon een man of vrouw is, of dat het geslacht (nog) onbekend is."
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                     |
    | ------------------------------------------------ | -------------------------------- |
    | M                                                | man                              |
    | V                                                | vrouw                            |
    | O                                                | onbekend                         |

  Voor de enumeratie IndicatieGezagMinderjarige wordt de tabel met identificatie "indicatiegezagminderjarige" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Geeft aan wie het gezag heeft over de minderjarige persoon."
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                     |
    | ------------------------------------------------ | -------------------------------- |
    | 1                                                | ouder1                           |
    | 2                                                | ouder2                           |
    | D                                                | derden                           |
    | 1D                                               | ouder1 en derde                  |
    | 2d                                               | ouder2 en derde                  |
    | 12                                               | ouder1 en ouder2                 |

  Voor de enumeratie Naamgebruik wordt de tabel met identificatie "naamgebruik" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "De manier waarop de geslachtsnaam van persoon en partner van persoon moet worden verwerkt in de manier waarop persoon wil worden aangesproken."
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                               |
    | ------------------------------------------------ | ------------------------------------------ |
    | E                                                | gebruik alleen de eigen naam               |
    | N                                                | gebruik de eigennaam voor de partnernaam   |
    | P                                                | gebruik alleen de partnernaam              |
    | V                                                | gebruik de partnernaam voor de eigen naam  |

  Voor de enumeratie OuderAanduiding wordt de tabel met identificatie "ouderaanduiding" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Geeft aan om welke ouder het gaat volgens de BRP."
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                     |
    | ------------------------------------------------ | -------------------------------- |
    | 1                                                | ouder1                           |
    | 2                                                | ouder2                           |

  Voor de enumeratie RedenOpschortingBijhouding wordt de tabel met identificatie "redenopschortingbijhouding" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Redenen voor opschorting van de bijhouding"
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                         |
    | ------------------------------------------------ | ------------------------------------ |
    | O                                                | overlijden                           |
    | E                                                | emigratie                            |
    | M                                                | ministerieel besluit                 |
    | R                                                | persoonslijst is aangelegd in de rni |
    | F                                                | fout                                 |

  Voor de enumeratie SoortVerbintenis wordt de tabel met identificatie "soortverbintenis" opgenomen.
  In de omschrijving wordt de volgende tekst opgenomen : "Soort verbintenis die bij de burgerlijke stand is ingeschreven"
  In de waardetabel worden de volgende waarden opgenomen:
    | code                                             | omschrijving                         |
    | ------------------------------------------------ | ------------------------------------ |
    | H                                                | huwelijk                             |
    | P                                                | geregistreerd partnerschap           |

  Scenario: een onbekende waarde wordt niet opgenomen in de response
    Gegeven in de registratie heeft de AanduidingBijHuisnummer van de verblijfplaats de waarde "naast"
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.aanduidingBijHuisnummer niet aanwezig

  Scenario: een bekende waarde wordt wel opgenomen in de response
    Gegeven in de registratie heeft de geslachtsaanduiding de waarde "O" (onbekend)
    Als de persoon wordt geraadpleegd
    Dan heeft attribuut geslachtsaanduiding de waarde "onbekend"
