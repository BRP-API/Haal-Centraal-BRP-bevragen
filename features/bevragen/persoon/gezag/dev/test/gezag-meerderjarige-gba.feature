#language: nl

@gba
Functionaliteit: test gezagsrelaties van een meerderjarige

  Regel: een meerderjarige die van rechtswege gezag heeft over een minderjarige die geen kind is van de meerderjarige krijgt de gezagsrelatie naar zichzelf geleverd
    # de gezagsmodule levert bij het bevragen van de niet-ouder geen gezag
    # het gezag kan achterhaald worden door het gezag van de kinderen van de (ex)partner(s) op te vragen
    # voor elke gezagsrelatie van de minderjarige kinderen wordt bepaald of de niet-ouder voogd is van dit kind

    Scenario: de (ex)partner van overleden ouder heeft gezag over de minderjarige kinderen en heeft inmiddels andere partner waarmee de relatie ook beëindigd is
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | V          | 000000048        |
      En de persoon met burgerservicenummer '000000036' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20231001 |
      En de persoon met burgerservicenummer '000000036' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000036                   | 20120428                                                           |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000036                   | 20191001                                                     | O                                                            |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000061                   | 20230614                                                           |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000061                   | 20240217                                                     | S                                                            |
      En de persoon met burgerservicenummer '000000048' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000061' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000048                   | 20230614                                                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde    |
      | type                             | Voogdij   |
      | minderjarige.burgerservicenummer | 000000012 |
      En heeft 'gezag' een 'derde' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |

    Scenario: de (ex)partner van overleden ouder heeft gezag over de minderjarige kinderen en heeft daarna twee andere partners gehad
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | V          | 000000048        |
      En de persoon met burgerservicenummer '000000036' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20231001 |
      En de persoon met burgerservicenummer '000000036' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000036                   | 20120428                                                           |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000036                   | 20191001                                                     | O                                                            |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000061                   | 20230614                                                           |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000061                   | 20240217                                                     | S                                                            |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000072                   | 20230412                                                           |
      En de persoon met burgerservicenummer '000000048' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000061' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000048                   | 20230614                                                           |
      En de persoon met burgerservicenummer '000000072' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000048                   | 20230412                                                           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde    |
      | type                             | Voogdij   |
      | minderjarige.burgerservicenummer | 000000012 |
      En heeft 'gezag' een 'derde' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |

    Scenario: een (ex)partner van overleden ouder heeft gezag over de minderjarige kinderen en gezag van een andere ex-partner wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | V          | 000000048        |
      En de persoon met burgerservicenummer '000000036' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000048                   | 20191001                                                     | S                                                            |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000061                   | 20220614                                                           |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20231001 |
      En de persoon met burgerservicenummer '000000036' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000036                   | 20120428                                                           |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000036                   | 20191001                                                     | S                                                            |
      En de persoon met burgerservicenummer '000000061' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000036                   | 20220614                                                           |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000036                   | 20231001                                                     | O                                                            |
      En de persoon met burgerservicenummer '000000061' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gezag
