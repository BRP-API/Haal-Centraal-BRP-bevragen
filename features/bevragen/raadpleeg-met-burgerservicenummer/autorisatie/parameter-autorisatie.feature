# language: nl

@autorisatie
Functionaliteit: autorisatie op parameters bij RaadpleegMetBurgerservicenummer

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam              | waarde |
      | voornamen (02.10) | Pieter |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0530                              |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | naam              | waarde |
      | voornamen (02.10) | Anna   |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |

  Rule: Wanneer een parameter wordt gebruikt van een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    
    @fout-case
    Abstract Scenario: Raadplegen met parameter <parameter niet toegestaan> waarvoor de afnemer niet geautoriseerd is (<ontbrekende rubriek>)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                          |
      | type                    | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer     | 000000024                       |
      | gemeenteVanInschrijving | 0599                            |
      | fields                  | naam.voornamen                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                    |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                               |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                 |
      | status   | 403                                                                                       |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): <parameter niet toegestaan>. |
      | code     | unauthorizedParameter                                                                     |
      | instance | /haalcentraal/api/brp/personen                                                            |

      Voorbeelden:
      | ad hoc rubrieken | parameter niet toegestaan | ontbrekende rubriek |
      | 10210 80910      | burgerservicenummer       | 10120               |
      | 10120 10210      | gemeenteVanInschrijving   | 80910               |

    Scenario: Afnemer raadpleegt met alleen de verplichte parameter en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response 1 persoon

    Scenario: Afnemer zoekt met de verplichte parameter en optionele parameter en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910                     | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                          |
      | type                    | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer     | 000000024                       |
      | gemeenteVanInschrijving | 0530                            |
      | fields                  | burgerservicenummer             |
      Dan heeft de response 1 persoon


  Rule: Een gemeente als afnemer is geautoriseerd voor alle zoekvragen
    Wanneer de afnemer gemeenteCode in de 'claim' van het OAuth token heeft, 
    dan wordt niet gekeken naar de autorisatie van de afnemer

    Scenario: Gemeente is niet geautoriseerd voor de zoekparameters
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10210                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                          |
      | type                    | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer     | 000000024                       |
      | gemeenteVanInschrijving | 0530                            |
      | fields                  | naam.voornamen                  |
      Dan heeft de response 1 persoon
      