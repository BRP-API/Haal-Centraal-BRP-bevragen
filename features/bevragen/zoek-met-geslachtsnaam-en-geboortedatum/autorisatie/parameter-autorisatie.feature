# language: nl

@autorisatie
Functionaliteit: autorisatie op parameters bij ZoekMetGeslachtsnaamEnGeboortedatum

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                        | waarde   |
      | voornamen (02.10)           | Pieter   |
      | voorvoegsel (02.30)         | van      |
      | geslachtsnaam (02.40)       | Maassen  |
      | geboortedatum (03.10)       | 19830526 |
      | geslachtsaanduiding (04.10) | M        |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | naam                        | waarde   |
      | voornamen (02.10)           | Anna     |
      | voorvoegsel (02.30)         | de       |
      | geslachtsnaam (02.40)       | Vries    |
      | geboortedatum (03.10)       | 20010604 |
      | geslachtsaanduiding (04.10) | V        |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |

  Rule: Wanneer een parameter wordt gebruikt van een veld waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    
    @fout-case
    Abstract Scenario: Zoeken met parameter <parameter niet toegestaan> waarvoor de afnemer niet geautoriseerd is (<ontbrekende rubriek>)
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                              |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam           | Maassen                             |
      | geboortedatum           | 1983-05-26                          |
      | voornamen               | Pieter                              |
      | voorvoegsel             | van                                 |
      | geslacht                | M                                   |
      | gemeenteVanInschrijving | 0599                                |
      | fields                  | burgerservicenummer                 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                    |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                               |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                 |
      | status   | 403                                                                                       |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): <parameter niet toegestaan>. |
      | code     | unauthorizedParameter                                                                     |
      | instance | /haalcentraal/api/brp/personen                                                            |

      Voorbeelden:
      | ad hoc rubrieken                    | parameter niet toegestaan | ontbrekende rubriek |
      | 10120 10230 10240 10310 10410 80910 | voornamen                 | 10210               |
      | 10120 10210 10240 10310 10410 80910 | voorvoegsel               | 10230               |
      | 10120 10210 10230 10310 10410 80910 | geslachtsnaam             | 10240               |
      | 10120 10210 10230 10240 10410 80910 | geboortedatum             | 10310               |
      | 10120 10210 10230 10240 10310 80910 | geslacht                  | 10410               |
      | 10120 10210 10230 10240 10310 10410 | gemeenteVanInschrijving   | 80910               |

    @fout-case
    Scenario: Gebruik van meerdere parameters waarvoor de afnemer niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10240 10310 10410         | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                              |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam           | Vries                               |
      | geboortedatum           | 2001-06-04                          |
      | voornamen               | Anna                                |
      | voorvoegsel             | de                                  |
      | geslacht                | V                                   |
      | gemeenteVanInschrijving | 0599                                |
      | fields                  | burgerservicenummer                 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                                        |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                                                   |
      | title    | U bent niet geautoriseerd voor de gebruikte parameter(s).                                                     |
      | status   | 403                                                                                                           |
      | detail   | U bent niet geautoriseerd voor het gebruik van parameter(s): gemeenteVanInschrijving, voornamen, voorvoegsel. |
      | code     | unauthorizedParameter                                                                                         |
      | instance | /haalcentraal/api/brp/personen                                                                                |

    Scenario: Afnemer zoekt met alleen de verplichte parameters en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10240 10310               | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Vries                               |
      | geboortedatum | 2001-06-04                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de response 1 persoon

    Abstract Scenario: Afnemer zoekt met de verplichte parameters en <extra parameter> en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)             | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 10240 10310 <rubriek extra parameter> | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam              | waarde                              |
      | type              | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam     | Vries                               |
      | geboortedatum     | 2001-06-04                          |
      | <extra parameter> | <waarde>                            |
      | fields            | burgerservicenummer                 |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | extra parameter         | rubriek extra parameter | waarde |
      | voornamen               | 10210                   | Anna   |
      | voorvoegsel             | 10230                   | de     |
      | geslacht                | 10410                   | V      |
      | gemeenteVanInschrijving | 80910                   | 0599   |


  Rule: Een gemeente als afnemer is geautoriseerd voor alle zoekvragen
    Wanneer de afnemer gemeenteCode in de 'claim' van het OAuth token heeft, 
    dan wordt niet gekeken naar de autorisatie van de afnemer

    Scenario: Gemeente is niet geautoriseerd voor de zoekparameters maar zoekt alleen eigen inwoners
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                              |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam           | Maassen                             |
      | geboortedatum           | 1983-05-26                          |
      | voornamen               | Pieter                              |
      | voorvoegsel             | van                                 |
      | geslacht                | M                                   |
      | gemeenteVanInschrijving | 0800                                |
      | fields                  | burgerservicenummer                 |
      Dan heeft de response 1 persoon
      