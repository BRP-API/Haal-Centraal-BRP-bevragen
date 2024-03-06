# language: nl

@autorisatie
Functionaliteit: autorisatie nationaliteitgegevens Persoon

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'nationaliteit' met de volgende gegevens
      | naam                  | waarde |
      | nationaliteit (05.10) | 0001   |

  Rule: Wanneer met fields gevraagd wordt om een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    Om een veld te mogen vragen moet de afnemer geautoriseerd zijn voor de LO BRP rubriek waar het veld mee gevuld wordt plus nationaliteit type (PA.NT.01)

    @fout-case
    Abstract Scenario: Afnemer vraagt <gevraagd veld> (<missende autorisatie>), waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000024                           |
      | fields              | burgerservicenummer,<gevraagd veld> |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | gevraagd veld                                     | ad hoc rubrieken         | missende autorisatie |
      | nationaliteiten.type                              | 40510 46310 46510 48510  | PANT01               |
      | nationaliteiten.nationaliteit                     | 46310 46510 48510 PANT01 | 40510                |
      | nationaliteiten.nationaliteit                     | 40510 46310 46510 48510  | PANT01               |
      | nationaliteiten.nationaliteit.code                | 46310 46510 48510 PANT01 | 40510                |
      | nationaliteiten.nationaliteit.omschrijving        | 4631 465100 48510 PANT01 | 40510                |
      | nationaliteiten.redenOpname                       | 40510 46510 48510 PANT01 | 46310                |
      | nationaliteiten.redenOpname                       | 40510 46310 46510 48510  | PANT01               |
      | nationaliteiten.redenOpname.code                  | 40510 46510 48510 PANT01 | 46310                |
      | nationaliteiten.redenOpname.omschrijving          | 40510 46510 48510 PANT01 | 46310                |
      | nationaliteiten.datumIngangGeldigheid             | 40510 46310 46510 PANT01 | 48510                |
      | nationaliteiten.datumIngangGeldigheid             | 46510 46310 46510 48510  | PANT01               |
      | nationaliteiten.datumIngangGeldigheid.langFormaat | 40510 46310 46510 PANT01 | 48510                |
      | nationaliteiten.datumIngangGeldigheid.type        | 40510 46310 46510 PANT01 | 48510                |
      | nationaliteiten.datumIngangGeldigheid.datum       | 40510 46310 46510 PANT01 | 48510                |
      | nationaliteiten.datumIngangGeldigheid.onbekend    | 40510 46310 46510 PANT01 | 48510                |
      | nationaliteiten.datumIngangGeldigheid.jaar        | 40510 46310 46510 PANT01 | 48510                |
      | nationaliteiten.datumIngangGeldigheid.maand       | 40510 46310 46510 PANT01 | 48510                |
      | nationaliteiten                                   | 46310 46510 48510 PANT01 | 40510                |
      | nationaliteiten                                   | 40510 46510 48510 PANT01 | 46310                |
      | nationaliteiten                                   | 40510 46310 46510 PANT01 | 48510                |
      | nationaliteiten                                   | 40510 46310 46510 48510  | PANT01               |

    Abstract Scenario: Afnemer vraagt <gevraagd veld>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000024                           |
      | fields              | burgerservicenummer,<gevraagd veld> |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | gevraagd veld                                     | ad hoc rubrieken         |
      | nationaliteiten.type                              | PANT01                   |
      | nationaliteiten.nationaliteit                     | 40510 PANT01             |
      | nationaliteiten.nationaliteit.code                | 40510 PANT01             |
      | nationaliteiten.nationaliteit.omschrijving        | 40510 PANT01             |
      | nationaliteiten.redenOpname                       | 46310 PANT01             |
      | nationaliteiten.redenOpname.code                  | 46310 PANT01             |
      | nationaliteiten.redenOpname.omschrijving          | 46310 PANT01             |
      | nationaliteiten.datumIngangGeldigheid             | 48510 PANT01             |
      | nationaliteiten.datumIngangGeldigheid.langFormaat | 48510 PANT01             |
      | nationaliteiten.datumIngangGeldigheid.type        | 48510 PANT01             |
      | nationaliteiten.datumIngangGeldigheid.datum       | 48510 PANT01             |
      | nationaliteiten.datumIngangGeldigheid.onbekend    | 48510 PANT01             |
      | nationaliteiten.datumIngangGeldigheid.jaar        | 48510 PANT01             |
      | nationaliteiten.datumIngangGeldigheid.maand       | 48510 PANT01             |
      | nationaliteiten                                   | 40510 46310 48510 PANT01 |
