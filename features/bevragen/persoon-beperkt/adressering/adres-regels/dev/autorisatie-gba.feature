# language: nl

Functionaliteit: autorisatie adressering adresregels PersoonBeperkt 

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                  | waarde   |
      | geslachtsnaam (02.40) | Maassen  |
      | geboortedatum (03.10) | 19830526 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde          |
      | gemeentecode (92.10)              | 0599            |
      | straatnaam (11.10)                | Borgesiusstraat |
      | huisnummer (11.20)                | 103             |
      | postcode (11.60)                  | 2497BV          |
      | woonplaats (11.70)                | Scheveningen    |


  Rule: Vragen met fields om een adresregel, wanneer de gebruiker niet geautoriseerd is voor alle velden waaruit betreffende adresregel wordt afgeleid, geeft een foutmelding

    Scenario: Afnemer vraagt om adressering.adresregel1 en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                             | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10240 10310 81110 81120 81130 81140 81150 81210 81310 81330 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adressering.adresregel1             |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam       | waarde          |
      | straat     | Borgesiusstraat |
      | huisnummer | 103             |

    @fout-case
    Abstract Scenario: Afnemer vraagt om adressering.adresregel1 en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adressering.adresregel1             |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                      | missende autorisatie            |
      | 10240 10310 81120 81130 81140 81150 81210 81310 81330 | korteStraatnaam (81110)         |
      | 10240 10310 81110 81130 81140 81150 81210 81310 81330 | huisnummer (81120)              |
      | 10240 10310 81110 81120 81140 81150 81210 81310 81330 | huisletter (81130)              |
      | 10240 10310 81110 81120 81130 81150 81210 81310 81330 | huisnummertoevoeging (81140)    |
      | 10240 10310 81110 81120 81130 81140 81210 81310 81330 | aanduidingBijHuisnummer (81150) |
      | 10240 10310 81110 81120 81130 81140 81150 81310 81330 | locatiebeschrijving (81210)     |
      | 10240 10310 81110 81120 81130 81140 81150 81210 81330 | land (81310)                    |
      | 10240 10310 81110 81120 81130 81140 81150 81210 81310 | regel1 (81330)                  |

    Scenario: Afnemer vraagt om adresseringBinnenland.adresregel1 en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                 | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10240 10310 81110 81120 81130 81140 81150 81210 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adresseringBinnenland.adresregel1   |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam       | waarde          |
      | straat     | Borgesiusstraat |
      | huisnummer | 103             |

    Scenario: Afnemer vraagt om adressering.adresregel2 en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                             | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10240 10310 80910 81110 81120 81160 81170 81210 81310 81340 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adressering.adresregel2             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                 | waarde    |
      | gemeenteVanInschrijving.code         | 0599      |
      | gemeenteVanInschrijving.omschrijving | Rotterdam |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam       | waarde          |
      | straat     | Borgesiusstraat |
      | huisnummer | 103             |
      | postcode   | 2497BV          |
      | woonplaats | Scheveningen    |

    @fout-case
    Abstract Scenario: Afnemer vraagt om adressering.adresregel2 en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adressering.adresregel2             |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                      | missende autorisatie            |
      | 10240 10310 81110 81120 81160 81170 81210 81310 81340 | gemeenteVanInschrijving (80910) |
      | 10240 10310 80910 81120 81160 81170 81210 81310 81340 | korteStraatnaam (81110)         |
      | 10240 10310 80910 81110 81160 81170 81210 81310 81340 | huisnummer (81120)              |
      | 10240 10310 80910 81110 81120 81170 81210 81310 81340 | postcode (81160)                |
      | 10240 10310 80910 81110 81120 81160 81210 81310 81340 | woonplaats (81170)              |
      | 10240 10310 80910 81110 81120 81160 81170 81310 81340 | locatiebeschrijving (81210)     |
      | 10240 10310 80910 81110 81120 81160 81170 81210 81340 | land (81310)                    |
      | 10240 10310 80910 81110 81120 81160 81170 81210 81310 | regel2 (81340)                  |

    Scenario: Afnemer vraagt om adresseringBinnenland.adresregel2 en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                 | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10240 10310 80910 81110 81120 81160 81170 81210 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adresseringBinnenland.adresregel2   |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                 | waarde    |
      | gemeenteVanInschrijving.code         | 0599      |
      | gemeenteVanInschrijving.omschrijving | Rotterdam |
      En heeft de persoon de volgende 'verblijfplaats' gegevens
      | naam       | waarde          |
      | straat     | Borgesiusstraat |
      | huisnummer | 103             |
      | postcode   | 2497BV          |
      | woonplaats | Scheveningen    |

    Scenario: Afnemer vraagt om adressering.adresregel3 en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10240 10310 81310 81350         | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adressering.adresregel3             |
      Dan heeft de response een persoon met een leeg 'verblijfplaats' object

    @fout-case
    Abstract Scenario: Afnemer vraagt om adressering.adresregel3 en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adressering.adresregel3             |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken  | missende autorisatie |
      | 10240 10310 81350 | land (81310)         |
      | 10240 10310 81310 | regel3 (81350)       |

    Scenario: Afnemer vraagt om adressering.land en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10240 10310 81310 81330 81340 81350   | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                      |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields              | adressering.land |
      Dan heeft de response een persoon met een leeg 'verblijfplaats' object

    @fout-case
    Abstract Scenario: Afnemer vraagt om adressering.land en is niet geautoriseerd voor verblijfplaats <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | adressering.land                    |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken              | missende autorisatie |
      | 10240 10310 81330 81340 81350 | land (81310)         |
      | 10240 10310 81310 81340 81350 | regel1 (81330)       |
      | 10240 10310 81310 81330 81350 | regel2 (81340)       |
      | 10240 10310 81310 81330 81340 | regel3 (81350)       |
