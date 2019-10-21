# language: nl

Functionaliteit: Tonen van verblijfplaatsen

  Huidige en vorige verblijfplaatsen van ingeschreven personen kunnen worden opgezocht.

  De gebruiker kan de verblijfplaats raadplegen op een specifieke peildatum (in het verleden).
  De gebruiker kan de verblijfplaatsen raadplegen over een specifieke periode.
  Filteren op peildatum of periode wordt gedaan op basis van de datum aanvang adreshouding van de verblijfplaats(en).
  Op periode gefilterde gegevens tonen alle verblijfplaatsen waar de persoon gedurende de periode heeft verbleven. Ook wanneer de persoon al voor de periode op een verblijfplaats verbleef en binnen de gevraagde periode nog steeds, wordt de verblijfplaats opgenomen in het antwoord. Ook wanneer de persoon tijdens (een deel van) de periode op een verblijfplaats verbleef en na de gevraagde periode nog steeds, wordt de verblijfplaats opgenomen in het antwoord.

  Wanneer de datum aanvang gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd op het adres heeft verbleven. Wanneer van de datum aanvang adreshouding alleen het jaar bekend is, wordt aangenomen dat de persoon het hele jaar op deze verblijfplaats heeft verbleven.
  Wanneer van de datum aanvang adreshouding alleen het jaar en de maand bekend is, wordt aangenomen dat de persoon de hele maand op deze verblijfplaats heeft verbleven.
  Wanneer de datum aanvang adreshouding geheel onbekend is, wordt voor de filtering aangenomen dat de persoon daar altijd al woonde.

  Bij een historische verblijfplaats wordt een datumTot opgenomen, die gelijk is aan de datum aanvang adreshouding van de daarop volgende (actuele of historische) verblijfplaats.

  Wanneer in de registratie voor de persoon meer dan één verblijfplaats, actueel (categorie 8) of historisch (categorie 58), bevat met exact dezelfde datum aanvang adreshouding, dan wordt alleen het voorkomen met de meest recente datum ingang geldigheid opgenomen. Dit speelt bijvoorbeeld wanneer er een correctie is uitgevoerd op de verblijfplaats, of wanneer er een adres hernummering is gedaan.
  Wanneer verblijfplaatshistorie wordt samengesteld op basis van een GBA-V bevraging, en het autorisatieprofiel geeft geen toegang tot datum ingang geldigheid, dan wordt steeds het eerste (bovenste) voorkomen gebruikt, wanneer er meerdere voorkomens zijn met exact dezelfde datum aanvang adreshouding.

  Historische voorkomens die onjuist zijn worden niet opgenomen in het antwoord.

  De verblijfplaatsen worden in het antwoord aflopend gesorteerd op datum aanvang adreshouding, zodat de meest actuele bovenaan staat.

  Wanneer een verblijfplaats een buitenlands adres betreft, wordt datumAanvangAdreshouding gevuld met de waarde in Datum aanvang adres buitenland (element 13.20). In dit geval wordt ook de sortering in het antwoord, de filtering op peildatum of periode, en het afleiden van de datumTot bepaald op basis van Datum aanvang adres buitenland (element 13.20).

  Wanneer een verblijfplaats, actueel of historisch, in onderzoek is, en dit onderzoek is niet afgerond (Datum einde onderzoek is leeg), wordt inOnderzoek gevuld voor betreffende verblijfplaats.

  Achtergrond:
    Gegeven de ingeschreven persoon met burgerservicenummer 999994669 kent de volgende verblijfplaatsen:
      | Categorie | Datum aanvang adreshouding | Datum aanvang adres buitenland | Datum ingang geldigheid | Adres            |
      | 8         | 19940508                   | -                              | 20110205                | Beethovenlaan 23 |
      | 58        | 19940508                   | -                              | 19940508                | Beethovenlaan 5  |
      | 58        | 19930910                   | -                              | 19930910                | Kerkstraat 83    |
      | 58        | -                          | 19930215                       | 19930215                | België           |
      | 58        | 19611230                   | -                              | 19611230                | Javaplein 11     |

    En de ingeschreven persoon met burgerservicenummer 999992338 kent de volgende verblijfplaatsen:
      | Categorie | Datum aanvang adreshouding | Datum aanvang adres buitenland | Datum ingang geldigheid | Adres            |
      | 8         | 20010508                   | -                              | 20010508                | Leyweg 61        |
      | 58        | -                          | 19960000                       | 19960000                | België           |

    En de ingeschreven persoon met burgerservicenummer 999993483 kent de volgende verblijfplaatsen:
      | Categorie | Datum aanvang adreshouding | Datum aanvang adres buitenland | Datum ingang geldigheid | Adres            |
      | 8         | 20120305                   | -                              | 20120305                | Zonegge 27       |
      | 58        | 00000000                   | -                              | 00000000                | Leyweg 61        |

    En de ingeschreven persoon met burgerservicenummer 999990378 kent de volgende verblijfplaatsen:
      | Categorie | Datum aanvang adreshouding | Onderzoek | Datum einde onderzoek | Adres               |
      | 8         | 20150601                   | -         | -                     | Rietzangerstraat 20 |
      | 58        | 19881118                   | 580000    | -                     | Voorhofdreef 30     |

    En de ingeschreven persoon met burgerservicenummer 999990263 kent de volgende verblijfplaatsen:
      | Categorie | Datum aanvang adreshouding | Onderzoek | Datum einde onderzoek | Adres               |
      | 8         | 20150601                   | -         | 20120305              | Rapheëlstraat 1     |
      | 58        | 19890501                   | 580000    | 19920102              | Oudegracht 380      |

  Scenario: Verblijfplaats raadplegen zonder peildatum of periode
    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1994-05-08               | -          | 2011-02-05            | Beethovenlaan 23 |
      | 1 | 1993-09-10               | 1994-05-08 | 1993-09-10            | Kerkstraat 83    |
      | 2 | 1993-02-15               | 1993-09-10 | 1993-02-15            | België           |
      | 3 | 1961-12-30               | 1993-02-15 | 1961-12-30            | Javaplein 11     |

  Scenario: Verblijfplaats opvragen op een peildatum
    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met peildatum 2019-09-11
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1994-05-08               | -          | 2011-02-05            | Beethovenlaan 23 |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met peildatum 1994-05-08
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1994-05-08               | -          | 2011-02-05            | Beethovenlaan 23 |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met peildatum 1994-05-07
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 1 | 1993-09-10               | 1994-05-08 | 1993-09-10            | Kerkstraat 83    |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met peildatum 1993-07-01
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 2 | 1993-02-15               | 1993-09-10 | 1993-02-15            | België           |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met peildatum 1961-12-29
    Dan wordt geen enkele verblijfplaats teruggegeven

  Scenario: Verblijfplaatsen opvragen over een periode
    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met datumvan 1961-12-29 en datumtotenmet 2019-09-11
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1994-05-08               | -          | 2011-02-05            | Beethovenlaan 23 |
      | 1 | 1993-09-10               | 1994-05-08 | 1993-09-10            | Kerkstraat 83    |
      | 2 | 1993-02-15               | 1993-09-10 | 1993-02-15            | België           |
      | 3 | 1961-12-30               | 1993-02-15 | 1961-12-30            | Javaplein 11     |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met datumvan 2012-01-01 en datumtotenmet 2019-09-11
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1994-05-08               | -          | 2011-02-05            | Beethovenlaan 23 |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met datumvan 1995-01-01 en datumtotenmet 1996-01-01
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1994-05-08               | -          | 2011-02-05            | Beethovenlaan 23 |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met datumvan 1950-01-01 en datumtotenmet 1993-09-09
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1993-02-15               | 1993-09-10 | 1993-02-15            | België           |
      | 1 | 1961-12-30               | 1993-02-15 | 1961-12-30            | Javaplein 11     |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met datumvan 1950-01-01 en datumtotenmet 1993-09-10
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1993-09-10               | 1994-05-08 | 1993-09-10            | Kerkstraat 83    |
      | 1 | 1993-02-15               | 1993-09-10 | 1993-02-15            | België           |
      | 2 | 1961-12-30               | 1993-02-15 | 1961-12-30            | Javaplein 11     |

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met datumvan 1950-01-01 en datumtotenmet 1961-12-29
    Dan wordt geen enkele verblijfplaats teruggegeven

    Als de ingeschreven persoon met burgerservicenummer 999994669 wordt geraadpleegd met datumvan 1950-01-01 en datumtotenmet 1961-12-30
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1961-12-30               | 1993-02-15 | 1961-12-30            | Javaplein 11     |

  Scenario: Verblijfplaats heeft gedeeltelijk onbekende datum aanvang adreshouding
    Als de ingeschreven persoon met burgerservicenummer 999992338 wordt geraadpleegd
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 2001-05-08               | -          | 2001-05-08            | Leyweg 61        |
      | 1 | 1996                     | 2001-05-08 | 1996                  | België           |

    Als de ingeschreven persoon met burgerservicenummer 999992338 wordt geraadpleegd met peildatum 1996-01-01
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 1996                     | 2001-05-08 | 1996                  | België           |

    Als de ingeschreven persoon met burgerservicenummer 999992338 wordt geraadpleegd met peildatum 1995-12-31
    Dan wordt geen enkele verblijfplaats teruggegeven

    Als de ingeschreven persoon met burgerservicenummer 999992338 wordt geraadpleegd met datumvan 1995-01-01 en datumtotenmet 1996-01-01
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 2 | 1996                     | 1994-05-08 | 1996                  | België           |

    Als de ingeschreven persoon met burgerservicenummer 999992338 wordt geraadpleegd met datumvan 1995-01-01 en datumtotenmet 1995-12-31
    Dan wordt geen enkele verblijfplaats teruggegeven

  Scenario: Verblijfplaats heeft geheel onbekende datum aanvang adreshouding
    Als de ingeschreven persoon met burgerservicenummer 999993483 wordt geraadpleegd
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | 2012-03-05               | -          | 2012-03-05            | Zonegge 27       |
      | 1 | -                        | 2012-03-05 | -                     | Leyweg 61        |

    Als de ingeschreven persoon met burgerservicenummer 999993483 wordt geraadpleegd met peildatum 2012-03-04
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | -                        | 2012-03-05 | -                     | Leyweg 61        |

    Als de ingeschreven persoon met burgerservicenummer 999993483 wordt geraadpleegd met peildatum 1853-07-30
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | -                        | 2012-03-05 | -                     | Leyweg 61        |

    Als de ingeschreven persoon met burgerservicenummer 999993483 wordt geraadpleegd met datumvan 1850-01-01 en datumtotenmet 1900-01-01
    Dan worden de verblijfplaatsen teruggegeven in de volgorde en met waarden:
      | # | datumAanvangAdreshouding | datumTot   | datumIngangGeldigheid | Adres            |
      | 0 | -                        | 2012-03-05 | -                     | Leyweg 61        |

  Scenario: Historische verblijfplaats is in onderzoek
    Als de ingeschreven persoon met burgerservicenummer 999990378 wordt geraadpleegd met peildatum 2010-01-01
    Dan bevat verblijfplaats met straatnaam Rapheëlstraat inOnderzoek

  Scenario: Historische verblijfplaats is in onderzoek geweest
    Als de ingeschreven persoon met burgerservicenummer 999990263 wordt geraadpleegd met peildatum 2010-01-01
    Dan bevat verblijfplaats met straatnaam Rapheëlstraat geen inOnderzoek
