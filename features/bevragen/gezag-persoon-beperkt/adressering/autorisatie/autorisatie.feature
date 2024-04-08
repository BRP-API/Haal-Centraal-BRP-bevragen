# language: nl

@autorisatie
Functionaliteit: autorisatie adressering adresregels PersoonBeperkt 

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                     | waarde           |
      | gemeentecode (92.10)                     | 0599             |
      | identificatiecode verblijfplaats (11.80) | 0599010051001502 |


  Rule: Vragen met fields om een adres in adressering wanneer de gebruiker niet geautoriseerd is voor (een) betreffend adresgegeven, geeft een foutmelding

    Abstract Scenario: Afnemer vraagt om <fields> en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 81180 <minimale autorisatie>    | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | <fields>                                |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | fields                            | minimale autorisatie      |
      | adressering.adresregel1           | PAVP03                    |
      | adressering.adresregel2           | PAVP04                    |
      | adressering.adresregel3           | 81350                     |
      | adressering.land                  | 81310                     |
      | adressering                       | 81310 81350 PAVP03 PAVP04 |
      | adresseringBinnenland.adresregel1 | PAVP03                    |
      | adresseringBinnenland.adresregel2 | PAVP04                    |
      | adresseringBinnenland             | PAVP03 PAVP04             |

    @fout-case
    Abstract Scenario: Afnemer vraagt om <fields> en is niet geautoriseerd voor <missende autorisatie>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 81180 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | <fields>                                |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                            | ad hoc rubrieken                                                                                                          | missende autorisatie |
      | adressering.adresregel1           | 81110 81120 81130 81140 81150 81160 81170 81210 81310 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP04  | adresregel1 (PAVP03) |
      | adressering.adresregel2           | 81110 81120 81130 81140 81150 81160 81170 81210 81310 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03  | adresregel2 (PAVP04) |
      | adressering.adresregel3           | 81110 81120 81130 81140 81150 81160 81170 81210 81310 81330 81340 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03 PAVP04 | adresregel3 (81350)  |
      | adressering.land                  | 81110 81120 81130 81140 81150 81160 81170 81210 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03 PAVP04 | land (81310)         |
      | adresseringBinnenland.adresregel1 | 81110 81120 81130 81140 81150 81160 81170 81210 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP04                          | adresregel1 (PAVP03) |
      | adresseringBinnenland.adresregel2 | 81110 81120 81130 81140 81150 81160 81170 81210 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03                          | adresregel2 (PAVP04) |
      | adressering                       | 81110 81120 81130 81140 81150 81160 81170 81210 81310 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP04  | adresregel1 (PAVP03) |
      | adressering                       | 81110 81120 81130 81140 81150 81160 81170 81210 81310 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03  | adresregel2 (PAVP04) |
      | adressering                       | 81110 81120 81130 81140 81150 81160 81170 81210 81310 81330 81340 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03 PAVP04 | adresregel3 (81350)  |
      | adressering                       | 81110 81120 81130 81140 81150 81160 81170 81210 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03 PAVP04 | land (81310)         |
      | adresseringBinnenland             | 81110 81120 81130 81140 81150 81160 81170 81210 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP04                          | adresregel1 (PAVP03) |
      | adresseringBinnenland             | 81110 81120 81130 81140 81150 81160 81170 81210 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03                          | adresregel2 (PAVP04) |
