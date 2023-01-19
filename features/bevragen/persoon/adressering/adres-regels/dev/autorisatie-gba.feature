# language: nl

Functionaliteit: autorisatie adressering adresregels Persoon

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
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
      | Rubrieknummer ad hoc (35.95.60)                       | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81110 81120 81130 81140 81150 81210 81310 81330 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.adresregel1         |
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
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.adresregel1         |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve fields waarden zijn: adressering.adresregel1.               |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                | missende autorisatie            |
      | 10120 81120 81130 81140 81150 81210 81310 81330 | korteStraatnaam (81110)         |
      | 10120 81110 81130 81140 81150 81210 81310 81330 | huisnummer (81120)              |
      | 10120 81110 81120 81140 81150 81210 81310 81330 | huisletter (81130)              |
      | 10120 81110 81120 81130 81150 81210 81310 81330 | huisnummertoevoeging (81140)    |
      | 10120 81110 81120 81130 81140 81210 81310 81330 | aanduidingBijHuisnummer (81150) |
      | 10120 81110 81120 81130 81140 81150 81310 81330 | locatiebeschrijving (81210)     |
      | 10120 81110 81120 81130 81140 81150 81210 81330 | land (81310)                    |
      | 10120 81110 81120 81130 81140 81150 81210 81310 | regel1 (81330)                  |

    Scenario: Afnemer vraagt om adresseringBinnenland.adresregel1 en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)           | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81110 81120 81130 81140 81150 81210 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000024                         |
      | fields              | adresseringBinnenland.adresregel1 |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam       | waarde          |
      | straat     | Borgesiusstraat |
      | huisnummer | 103             |

    Scenario: Afnemer vraagt om adressering.adresregel2 en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                       | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 90910 81110 81120 81160 81170 81210 81310 81340 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.adresregel2         |
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
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.adresregel2         |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve fields waarden zijn: adressering.adresregel2.               |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken                                | missende autorisatie            |
      | 10120 81110 81120 81160 81170 81210 81310 81340 | gemeenteVanInschrijving (90910) |
      | 10120 90910 81120 81160 81170 81210 81310 81340 | korteStraatnaam (81110)         |
      | 10120 90910 81110 81160 81170 81210 81310 81340 | huisnummer (81120)              |
      | 10120 90910 81110 81120 81170 81210 81310 81340 | postcode (81160)                |
      | 10120 90910 81110 81120 81160 81210 81310 81340 | woonplaats (81170)              |
      | 10120 90910 81110 81120 81160 81170 81310 81340 | locatiebeschrijving (81210)     |
      | 10120 90910 81110 81120 81160 81170 81210 81340 | land (81310)                    |
      | 10120 90910 81110 81120 81160 81170 81210 81310 | regel2 (81340)                  |

    Scenario: Afnemer vraagt om adresseringBinnenland.adresregel2 en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)           | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 90910 81110 81120 81160 81170 81210 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                            |
      | type                | RaadpleegMetBurgerservicenummer   |
      | burgerservicenummer | 000000024                         |
      | fields              | adresseringBinnenland.adresregel2 |
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
      | 10120 81310 81350               | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.adresregel3         |
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
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.adresregel3         |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve fields waarden zijn: adressering.adresregel3.               |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken | missende autorisatie |
      | 10120 81350      | land (81310)         |
      | 10120 81310      | regel3 (81350)       |

    Scenario: Afnemer vraagt om adressering.land en heeft de daarvoor minimale autorisatie
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 81310 81330 81340 81350   | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0518   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                      |
      | type                | RaadpleegMetBurgerservicenummer             |
      | burgerservicenummer | 000000024                                   |
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
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | adressering.land                |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | detail   | De foutieve fields waarden zijn: adressering.land.                      |
      | code     | authorization                                                           |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | ad hoc rubrieken        | missende autorisatie |
      | 10120 81330 81340 81350 | land (81310)         |
      | 10120 81310 81340 81350 | regel1 (81330)       |
      | 10120 81310 81330 81350 | regel2 (81340)       |
      | 10120 81310 81330 81340 | regel3 (81350)       |
