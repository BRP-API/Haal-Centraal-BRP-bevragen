# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van immigratie van Persoon

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
      | fields                                           | ad hoc rubrieken          |
      | immigratie                                       | 81410 81420 PAVP05 PAVP06 |
      | immigratie.datumVestigingInNederland             | 81420                     |
      | immigratie.datumVestigingInNederland.langFormaat | 81420                     |
      | immigratie.datumVestigingInNederland.type        | 81420                     |
      | immigratie.datumVestigingInNederland.datum       | 81420                     |
      | immigratie.datumVestigingInNederland.onbekend    | 81420                     |
      | immigratie.datumVestigingInNederland.jaar        | 81420                     |
      | immigratie.datumVestigingInNederland.maand       | 81420                     |
      | immigratie.indicatieVestigingVanuitBuitenland    | PAVP05                    |
      | immigratie.landVanwaarIngeschreven               | 81410                     |
      | immigratie.landVanwaarIngeschreven.code          | 81410                     |
      | immigratie.landVanwaarIngeschreven.omschrijving  | 81410                     |
      | immigratie.vanuitVerblijfplaatsOnbekend          | PAVP06                    |

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
      | fields                                           | missende autorisatie      | ad hoc rubrieken                                        |
      | immigratie                                       | 81410                     | 80910 81030 81110 81120 81210 81310 81420 PAVP05 PAVP06 |
      | immigratie                                       | 81420                     | 80910 81030 81110 81120 81210 81310 81410 PAVP05 PAVP06 |
      | immigratie                                       | PAVP05                    | 80910 81030 81110 81120 81210 81310 81410 81420 PAVP06  |
      | immigratie                                       | PAVP06                    | 80910 81030 81110 81120 81210 81310 81410 81420 PAVP05  |
      | immigratie                                       | 81410 81420 PAVP05 PAVP06 | 80910 81030 81110 81120 81210 81310                     |
      | immigratie                                       | PAVP05 PAVP06             | 80910 81030 81110 81120 81210 81310 81410 81420         |
      | immigratie                                       | 81410 81420               | 80910 81030 81110 81120 81210 81310 PAVP05 PAVP06       |
      | immigratie.datumVestigingInNederland             | 81420                     | 80910 81030 81110 81120 81210 81310 81410 PAVP05 PAVP06 |
      | immigratie.datumVestigingInNederland.langFormaat | 81420                     | 80910 81030 81110 81120 81210 81310 81410 PAVP05 PAVP06 |
      | immigratie.datumVestigingInNederland.type        | 81420                     | 80910 81030 81110 81120 81210 81310 81410 PAVP05 PAVP06 |
      | immigratie.datumVestigingInNederland.datum       | 81420                     | 80910 81030 81110 81120 81210 81310 81410 PAVP05 PAVP06 |
      | immigratie.datumVestigingInNederland.onbekend    | 81420                     | 80910 81030 81110 81120 81210 81310 81410 PAVP05 PAVP06 |
      | immigratie.datumVestigingInNederland.jaar        | 81420                     | 80910 81030 81110 81120 81210 81310 81410 PAVP05 PAVP06 |
      | immigratie.datumVestigingInNederland.maand       | 81420                     | 80910 81030 81110 81120 81210 81310 81410 PAVP05 PAVP06 |
      | immigratie.landVanwaarIngeschreven               | 81410                     | 80910 81030 81110 81120 81210 81310 81420 PAVP05 PAVP06 |
      | immigratie.landVanwaarIngeschreven.code          | 81410                     | 80910 81030 81110 81120 81210 81310 81420 PAVP05 PAVP06 |
      | immigratie.landVanwaarIngeschreven.omschrijving  | 81410                     | 80910 81030 81110 81120 81210 81310 81420 PAVP05 PAVP06 |
      | immigratie.indicatieVestigingVanuitBuitenland    | PAVP05                    | 80910 81030 81110 81120 81210 81310 81410 81420 PAVP06  |
      | immigratie.vanuitVerblijfplaatsOnbekend          | PAVP06                    | 80910 81030 81110 81120 81210 81310 81410 81420 PAVP05  |
