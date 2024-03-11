# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van gemeente van persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) |
      | 19830526              | Maassen               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                  |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
      | status   | 403                                                                     |
      | code     | unauthorizedField                                                       |
      | instance | /haalcentraal/api/brp/personen                                          |

      Voorbeelden:
      | fields                                  | missende autorisatie                                                    | ad hoc rubrieken                                                         |
      | gemeenteVanInschrijving                 | 080910                                                                  | 080920 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | gemeenteVanInschrijving.code            | 080910                                                                  | 080920 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | gemeenteVanInschrijving.omschrijving    | 080910                                                                  | 080920 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | datumInschrijvingInGemeente             | 080920                                                                  | 080910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | datumInschrijvingInGemeente.langFormaat | 080920                                                                  | 080910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | datumInschrijvingInGemeente.type        | 080920                                                                  | 080910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | datumInschrijvingInGemeente.datum       | 080920                                                                  | 080910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | datumInschrijvingInGemeente.onbekend    | 080920                                                                  | 080910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | datumInschrijvingInGemeente.jaar        | 080920                                                                  | 080910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |
      | datumInschrijvingInGemeente.maand       | 080920                                                                  | 080910 81030 81110 81115 81120 81130 81140 81150 81160 81170 81210 81310 |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) |
      | 19830526              | Maassen               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | fields                                  | ad hoc rubrieken |
      | gemeenteVanInschrijving                 | 080910           |
      | gemeenteVanInschrijving.code            | 080910           |
      | gemeenteVanInschrijving.omschrijving    | 080910           |
      | datumInschrijvingInGemeente             | 080920           |
      | datumInschrijvingInGemeente.langFormaat | 080920           |
      | datumInschrijvingInGemeente.type        | 080920           |
      | datumInschrijvingInGemeente.datum       | 080920           |
      | datumInschrijvingInGemeente.onbekend    | 080920           |
      | datumInschrijvingInGemeente.jaar        | 080920           |
      | datumInschrijvingInGemeente.maand       | 080920           |
