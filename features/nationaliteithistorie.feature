# language: nl

Functionaliteit: Tonen van Nationaliteithistorie
  Huidige en voormalige nationaliteiten van ingeschreven personen kunnen worden geraadpleegd.

  In het antwoord wordt indicatieNationaliteitBeeindigd opgenomen met de waarde true, wanneer in de actuele nationaliteit (categorie 04) GEEN nationaliteit (05.10) noch aanduiding bijzonder Nederlanderschap (65.10) is opgenomen, of wanneer in categorie 04 reden beëindigen nationaliteit (64.10) is opgenomen.

  Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap worden de eigenschappen overgenomen uit de jongste bijbehorende historische categorie (54) waarin deze zijn voorkomen. Dit betreft de volgende eigenschappen:
  - nationaliteit
  - aanduidingBijzonderNederlanderschap
  - redenOpname

  Voor een nationaliteit (actueel of beëindigd) wordt de datumIngangGeldigheid gevuld met de datum geldigheid (85.10) uit de oudste bijbehorende categorie (04 of 54) waarin er een waarde is voor 05.10 of voor 65.10.

  Voor een beëindigde nationaliteit wordt de redenBeeindigen overgenomen uit de bijbehorende actuele categorie (04).

  Voor een beëindigde nationaliteit wordt datumEindeGeldigheid gevuld met de datum geldigheid (85.10) uit de oudste bijbehorende categorie (04 of 54) waarin er geen waarde is voor 05.10 noch voor 65.10.

  Een onjuiste nationaliteit wordt niet opgenomen.
  Een actuele nationaliteit waarbij in categorie 04 indicatie onjuist (84.10) is gevuld, wordt niet opgenomen in het antwoord.
  Een beëindigde nationaliteit waarbij de jongste bijbehorende historische categorie 54 met nationaliteit (05.10) gevuld én indicatie onjuist (84.10) gevuld, wordt niet opgenomen in het antwoord.
  Voor een actuele nationaliteit (niet-beëindigd) met een bijbehorende historische categorie 54 met indicatie onjuist, worden de gegevens (incl. datum ingang) in de onjuiste categorie genegeerd.

  In het antwoord worden de eerst de actuele nationaliteiten opgenomen, gevolgd door de beëindigde nationaliteiten (gesorteerd op indicatieNationaliteitBeeindigd). Daarbinnen worden resultaten aflopend gesorteerd op datumEindeGeldigheid en vervolgens aflopend gesorteerd op datumIngangGeldigheid.


  Gegeven de ingeschreven persoon met burgerservicenummer 999991292 kent de volgende nationaliteiten:
    | Stapel | Categorie | 05.10 | 65.10 | 64.10 | 85.10    |
    | 1      | 04        |       |       | 404   | 20140601 |
    | 1      | 54        |       |       | 401   | 19940601 |
    | 1      | 54        | 0100  |       |       | 19890301 |
    | 2      | 04        | 0001  |       |       | 19910201 |
    | 3      | 04        |       |       | 404   | 20140601 |
    | 3      | 54        | 0057  |       |       | 19831213 |

  En de ingeschreven persoon met burgerservicenummer 999990457 kent de volgende nationaliteiten:
    | Stapel | Categorie | 05.10 | 65.10 | 64.10 | 85.10    |
    | 1      | 04        |       |       |       | 20120101 |
    | 1      | 54        | 0039  |       |       | 00000000 |
    | 2      | 04        |       |       |       | 20120101 |
    | 2      | 54        | 0078  |       |       | 00000000 |
    | 3      | 04        | 0038  |       |       | 00000000 |
    | 4      | 04        | 0027  |       |       | 00000000 |
    | 5      | 04        |       |       | 038   | 19911231 |
    | 5      | 54        | 0001  |       |       | 19861010 |

  En de ingeschreven persoon met burgerservicenummer 999992806 kent de volgende nationaliteiten:
    | Stapel | Categorie | 05.10 | 65.10 | 64.10 | 85.10    |
    | 1      | 04        | 0334  |       |       | 00000000 |
    | 2      | 04        |       |       | 404   | 20150131 |
    | 2      | 54        |       |       | 401   | 20000114 |
    | 2      | 54        | 0331  |       |       | 00000000 |
    | 3      | 04        |       | V     |       | 20000114 |

  En de ingeschreven persoon met burgerservicenummer 999995555 kent de volgende nationaliteiten:
    | Stapel | Categorie | 05.10 | 63.10 | 64.10 | 85.10    |
    | 1      | 04        | 0001  | 018   |       | 20180731 |
    | 1      | 04        | 0001  | 057   |       | 20160803 |
    | 2      | 54        |       |       | 403   | 20170526 |
    | 2      | 54        |       |       | 402   | 20170210 |
    | 2      | 54        | 0449  | 301   |       | 19930419 |

  En de ingeschreven persoon met burgerservicenummer 999992466 kent de volgende nationaliteiten:
    | Stapel | Categorie | 05.10 | 63.10 | 64.10 | 85.10    | 84.10 |
    | 1      | 04        | 0057  | 301   |       | 20160601 |       |
    | 1      | 54        | 0057  | 301   |       | 20160501 |       |
    | 1      | 54        | 0057  | 301   |       | 20160401 |       |
    | 1      | 54        | 0057  | 301   |       | 20160301 | O     |

  En de ingeschreven persoon met burgerservicenummer 999992855 kent de volgende nationaliteiten:
    | Stapel | Categorie | 05.10 | 63.10 | 64.10 | 85.10    | 84.10 |
    | 1      | 04        | 0001  | 018   |       | 20041015 |       |
    | 2      | 04        |       |       |       | 20121022 |       |
    | 2      | 54        | 0251  |       |       | 20121022 | O     |
    | 3      | 04        | 0445  |       |       | 19611230 |       |
    | 4      | 04        | 0446  |       |       | 19611230 |       |

  Scenario: actuele en beëindigde nationaliteiten in de juiste volgorde
    Als de nationaliteithistorie met burgerservicenummer 999991292 wordt geraadpleegd
    Dan bevat het antwoord 3 voorkomens
    En wordt de nationaliteithistorie teruggegeven in de volgorde en met waarden:
    | # | nationaliteit.code | aanduidingBijzonderNederlanderschap | datumIngangGeldigheid | datumEindeGeldigheid | indicatieNationaliteitBeeindigd | redenBeeindigen.code |
    | 0 | 0001               | -                                   | 1991-02-01            | -                    | -                               | -                    |
    | 0 | 0057               | -                                   | 1983-12-13            | 2014-06-01           | true                            | 404                  |
    | 0 | 0100               | -                                   | 1989-03-01            | 1994-06-01           | true                            | 404                  |

  Scenario: meerdere actuele en beëindigde nationaliteiten
    Als de nationalteithistorie met burgerservicenummer 999990457 wordt geraadpleegd
    Dan bevat het antwoord 5 voorkomens
    En wordt de nationaliteithistorie teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | aanduidingBijzonderNederlanderschap | datumIngangGeldigheid | datumEindeGeldigheid | indicatieNationaliteitBeeindigd | redenBeeindigen.code |
      | 0 | 0038               | -                                   | -                     | -                    | -                               | -                    |
      | 1 | 0027               | -                                   | -                     | -                    | -                               | -                    |
      | 2 | 0039               | -                                   | -                     | 2012-01-01           | true                            | -                    |
      | 3 | 0078               | -                                   | -                     | 2012-01-01           | true                            | -                    |
      | 4 | 0001               | -                                   | 1986-10-10            | 1991-12-31           | true                            | 038                  |

  Scenario: actuele nationaliteit, actueel bijzonder Nederlanderschap en beëindigde nationaliteit met gewijzigde reden
    Als de nationaliteithistorie met burgerservicenummer 999992806 wordt geraadpleegd
    Dan bevat het antwoord 3 voorkomens
    En worden de nationaliteiten teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | aanduidingBijzonderNederlanderschap | datumIngangGeldigheid | datumEindeGeldigheid | indicatieNationaliteitBeeindigd | redenBeeindigen.code |
      | 0 | -                  | vastgesteld_niet_nederlander        | 2000-01-14            | -                    | -                               | -                    |
      | 1 | 0334               | -                                   | -                     | -                    | -                               | -                    |
      | 2 | 0331               | -                                   | -                     | 2000-01-14           | true                            | 404                  |

  Scenario: ingangsdatum en einddatum bij gewijzigde nationaliteitsgegevens
    Als de nationaliteithistorie met burgerservicenummer 9999955555 wordt geraadpleegd
    Dan bevat het antwoord 2 voorkomens
    En worden de nationaliteiten teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | datumIngangGeldigheid | datumEindeGeldigheid | redenOpname.code | redenBeeindigen.code |
      | 0 | 0001               | 2016-08-03            | -                    | 018              | -                    |
      | 1 | 0449               | 1993-04-19            | 2017-02-10           | 301              | 403                  |

  Scenario: Historische nationaliteit is onjuist maar actuele is juist
    Als de nationaliteithistorie met burgerservicenummer 999992466 wordt geraadpleegd
    Dan bevat het antwoord 1 voorkomens
    En worden de nationaliteiten teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | datumIngangGeldigheid | datumEindeGeldigheid | redenOpname.code | redenBeeindigen.code |
      | 0 | 0057               | 2016-04-01            | -                    | 301              | -                    |

  Scenario: Nationaliteit is onjuist
    Als de nationaliteithistorie met burgerservicenummer 999992466 wordt geraadpleegd
    Dan bevat het antwoord 3 voorkomens
    En bevat het antwoord geen nationaliteit.code 0251
    En worden de nationaliteiten teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | datumIngangGeldigheid | datumEindeGeldigheid | redenOpname.code | redenBeeindigen.code |
      | 0 | 0001               | 2004-10-15            | -                    | 018              | -                    |
      | 1 | 0445               | 1961-12-30            | -                    | -                | -                    |
      | 2 | 0446               | 1961-12-30            | -                    | -                | -                    |
