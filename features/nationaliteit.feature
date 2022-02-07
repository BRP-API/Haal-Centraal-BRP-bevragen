# language: nl

Functionaliteit: Bepalen van de actuele nationaliteit van een persoon
  Niet-beëindigde nationaliteiten van de persoon wordt opgenomen.

  In het antwoord voor personen worden alleen nationaliteiten opgenomen waarbij in categorie 04 nationaliteit (05.10) of aanduiding bijzonder Nederlanderschap (65.10) is opgenomen, en in categorie 04 GEEN reden beëindigen nationaliteit (64.10) is opgenomen.

  Voor een nationaliteit wordt de datumIngangGeldigheid gevuld met de datum geldigheid (85.10) uit de oudste bijbehorende categorie (04 of 54) waarin er een waarde is voor 05.10 of voor 65.10.
  De overige gegevens over een nationaliteit worden gehaald uit categorie 04.

  Een onjuiste nationaliteit wordt niet opgenomen. Een nationaliteit waarbij indicatie onjuist (84.10) is gevuld, wordt niet opgenomen in het antwoord.
  Voor een actuele nationaliteit met een bijbehorende historische categorie 54 met indicatie onjuist, worden de gegevens in de onjuiste categorie (incl. datum ingang) genegeerd.

  Gegeven de persoon met burgerservicenummer 999995555 kent de volgende nationaliteiten:
     | Stapel | Categorie | 05.10 | 63.10 | 64.10 | 85.10    |
     | 1      | 04        | 0001  | 018   |       | 20180731 |
     | 1      | 04        | 0001  | 057   |       | 20160803 |
     | 2      | 54        |       |       | 403   | 20170526 |
     | 2      | 54        |       |       | 402   | 20170210 |
     | 2      | 54        | 0449  | 301   |       | 19930419 |

  En de persoon met burgerservicenummer 999992466 kent de volgende nationaliteiten:
    | Stapel | Categorie | 05.10 | 63.10 | 64.10 | 85.10    | 84.10 |
    | 1      | 04        | 0057  | 301   |       | 20160601 |       |
    | 1      | 54        | 0057  | 301   |       | 20160501 |       |
    | 1      | 54        | 0057  | 301   |       | 20160401 |       |
    | 1      | 54        | 0057  | 301   |       | 20160301 | O     |

  En de persoon met burgerservicenummer 999992855 kent de volgende nationaliteiten:
    | Stapel | Categorie | 05.10 | 63.10 | 64.10 | 85.10    | 84.10 |
    | 1      | 04        | 0001  | 018   |       | 20041015 |       |
    | 2      | 04        |       |       |       | 20121022 |       |
    | 2      | 54        | 0251  |       |       | 20121022 | O     |
    | 3      | 04        | 0445  |       |       | 19611230 |       |
    | 4      | 04        | 0446  |       |       | 19611230 |       |

  Scenario: ingangsdatum en einddatum bij gewijzigde nationaliteitsgegevens
    Als de nationaliteithistorie met burgerservicenummer 9999955555 wordt geraadpleegd
    Dan bevat het antwoord 1 voorkomens van nationaliteit
    En worden de volgende nationaliteiten teruggegeven:
      | # | nationaliteit.code | datumIngangGeldigheid | redenOpname.code |
      | 0 | 0001               | 2016-08-03            | 018              |

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
