#language: nl

@gba
Functionaliteit: gezagsrelaties van een meerderjarige


  Regel: een meerderjarige krijgt voor een minderjarig kind met twee ouders met gezag de gezagsrelatie naar beide ouders geleverd

    Scenario: beide ouders hebben gezag over het minderjarige kind van bevraagde persoon
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000024        |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000024        |
      | 000000012       | OG2        | 000000048        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | TweehoofdigOuderlijkGezag |
      | minderjarige.burgerservicenummer | 000000012                 |
      En heeft 'gezag' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
      En heeft 'gezag' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |


  Regel: een meerderjarige die als enige gezag heeft over een minderjarig kind krijgt de gezagsrelatie naar zichzelf geleverd

    Scenario: alleen de bevraagde persoon heeft gezag over de minderjarige
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG1        | 000000024        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                   |
      | type                             | EenhoofdigOuderlijkGezag |
      | minderjarige.burgerservicenummer | 000000012                |
      | ouder.burgerservicenummer        | 000000024                |


  Regel: een meerderjarige die samen met diens partner gezag heeft over een minderjarig kind krijgt de gezagsrelatie naar de ouder en de partner geleverd

    Scenario: de ouder en diens partner hebben gezag over het kind
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000024        |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000024        |
      | 000000012       | GG         | 000000048        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde           |
      | type                             | GezamenlijkGezag |
      | minderjarige.burgerservicenummer | 000000012        |
      | ouder.burgerservicenummer        | 000000024        |
      | derde.burgerservicenummer        | 000000048        |


  Regel: een meerderjarige die gezag heeft over een minderjarig kind van de partner krijgt de gezagsrelatie naar de ouder en zichzelf geleverd
    # de gezagsmodule levert bij het bevragen van de niet-ouder geen gezag
    # het gezag kan achterhaald worden door het gezag van de kinderen van de partner op te vragen
    # voor elke gezagsrelatie van de minderjarige kinderen wordt bepaald of de niet-ouder gezamenlijk gezag heeft over het kind

    Scenario: persoon heeft van rechtswege gezamenlijk gezag over het minderjarige kind van diens partner
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000024        |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000024        |
      | 000000012       | GG         | 000000048        |
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon met burgerservicenummer '000000048' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde           |
      | type                             | GezamenlijkGezag |
      | minderjarige.burgerservicenummer | 000000012        |
      | ouder.burgerservicenummer        | 000000024        |
      | derde.burgerservicenummer        | 000000048        |

    Scenario: persoon heeft van rechtswege gezamenlijk gezag over enkele van de minderjarige kinderen van diens partner
      Gegeven de persoon met burgerservicenummer '000000048' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En voor de persoon met burgerservicenummer '000000048' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000048        |
      | 000000024       | GG         | 000000048        |
      | 000000036       | GG         | 000000048        |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000048        |
      | 000000012       | GG         | 000000061        |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | GG         | 000000061        |
      | 000000024       | GG         | 000000048        |
      En de persoon met burgerservicenummer '000000036' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000036' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000036       | GG         | 000000048        |
      | 000000036       | GG         | 000000073        |
      En de persoon met burgerservicenummer '000000061' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon met burgerservicenummer '000000061' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde           |
      | type                             | GezamenlijkGezag |
      | minderjarige.burgerservicenummer | 000000012        |
      | ouder.burgerservicenummer        | 000000048        |
      | derde.burgerservicenummer        | 000000061        |
      En heeft de persoon een 'gezag' met de volgende gegevens
      | naam                             | waarde           |
      | type                             | GezamenlijkGezag |
      | minderjarige.burgerservicenummer | 000000024        |
      | ouder.burgerservicenummer        | 000000048        |
      | derde.burgerservicenummer        | 000000061        |

    Scenario: persoon heeft geen gezag over het minderjarige kind van diens partner
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000024        |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000024        |
      | 000000012       | OG2        | 000000036        |
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon met burgerservicenummer '000000048' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gezag

    Scenario: persoon heeft gezag over een eigen kind en heeft van rechtswege gezamenlijk gezag over het minderjarige kind van diens partner
      Gegeven de persoon met burgerservicenummer '000000036' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000036' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000036        |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | GG         | 000000036        |
      | 000000012       | GG         | 000000048        |
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000048' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | OG2        | 000000048        |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | OG2        | 000000048        |
      | 000000024       | OG2        | 000000061        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde           |
      | type                             | GezamenlijkGezag |
      | minderjarige.burgerservicenummer | 000000012        |
      | ouder.burgerservicenummer        | 000000036        |
      | derde.burgerservicenummer        | 000000048        |
      En heeft de persoon een 'gezag' met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | TweehoofdigOuderlijkGezag |
      | minderjarige.burgerservicenummer | 000000024                 |
      En heeft 'gezag' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |
      En heeft 'gezag' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000061 |

    Abstract Scenario: voor het minderjarige kind van de partner <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon met burgerservicenummer '000000024' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag    | bsnMeerderjarige |
      | 000000012       | <soort gezag> | <meerderjarige>  |
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon met burgerservicenummer '000000048' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gezag

      Voorbeelden:
      | soort gezag | omschrijving                      | meerderjarige |
      | N           | kan het gezag niet bepaald worden |               |
      | G           | is er tijdelijk geen gezag        |               |
      | OG1         | heeft alleen de ouder gezag       | 000000024     |


  Regel: een meerderjarige krijg voor een meerderjarig kind geen gezagsrelatie geleverd

    Scenario: gezag wordt gevraagd van ouder met meerderjarig kind
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 20040730 |
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon met burgerservicenummer '000000012' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon met burgerservicenummer '000000024' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gezag


  Regel: een meerderjarige krijgt voor een minderjarig kind waarvoor het gezag niet bepaald kan worden geen gezagsrelatie geleverd

    Scenario: gezag over minderjarige kind kan niet worden bepaald
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon met burgerservicenummer '000000024' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | N          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gezag


  Regel: een meerderjarige krijgt voor een minderjarig kind waarover tijdelijk niemand gezag heeft geen gezagsrelatie geleverd

    Scenario: tijdelijk heeft niemand gezag over een minderjarig kind
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft de volgende 'gezagsverhouding' gegevens
      | naam                               | waarde |
      | indicatie curateleregister (33.10) | 1      |
      En de persoon met burgerservicenummer '000000024' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | G          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gezag


  Regel: een meerderjarige die van rechtswege gezag heeft over een minderjarige die geen kind is van de meerderjarige krijgt de gezagsrelatie naar zichzelf geleverd
    # de gezagsmodule levert bij het bevragen van de niet-ouder geen gezag
    # het gezag kan achterhaald worden door het gezag van de kinderen van de (ex)partner(s) op te vragen
    # voor elke gezagsrelatie van de minderjarige kinderen wordt bepaald of de niet-ouder voogd is van dit kind

    Scenario: de partner van overleden ouder heeft gezag over de minderjarige kinderen
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | V          | 000000048        |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | V          | 000000048        |
      En de persoon met burgerservicenummer '000000036' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20231001 |
      En de persoon met burgerservicenummer '000000036' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000036                   | 20120428                                                           |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000036                   | 20231001                                                     | O                                                            |
      En de persoon met burgerservicenummer '000000048' heeft geen gezagsrelaties
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
      En heeft de persoon een 'gezag' met de volgende gegevens
      | naam                             | waarde    |
      | type                             | Voogdij   |
      | minderjarige.burgerservicenummer | 000000024 |
      En heeft 'gezag' een 'derde' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |

    Scenario: de partner van ouder onder curatele heeft gezag over een minderjarig kind, maar niet over alle kinderen
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | N          |                  |
      En de persoon met burgerservicenummer '000000024' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | V          | 000000073        |
      En de persoon met burgerservicenummer '000000036' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En voor de persoon met burgerservicenummer '000000036' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000036       | OG1        | 000000152        |
      En de persoon met burgerservicenummer '000000048' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En de persoon met burgerservicenummer '000000048' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000061' heeft de volgende 'gezagsverhouding' gegevens
      | naam                               | waarde |
      | indicatie curateleregister (33.10) | 1      |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000073                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000048                   |
      En de persoon met burgerservicenummer '000000061' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000073' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000061                   |
      En de persoon met burgerservicenummer '000000073' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000073                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde    |
      | type                             | Voogdij   |
      | minderjarige.burgerservicenummer | 000000024 |
      En heeft 'gezag' een 'derde' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000073 |

    Scenario: de partner van overleden ouder heeft gezag over de minderjarige kinderen en heeft inmiddels andere partner
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
  

  Regel: een persoon die in RNI staat ingeschreven krijgt gezag niet te bepalen geleverd wanneer de leeftijd lager is dan 18 jaar
    # voor een persoon die staat ingeschreven in RNI (gemeente van inschrijving is gelijk aan 1999) levert de gezagsmodule altijd soort gezag 'N' (niet te bepalen)
    # wanneer zeker is dat de persoon meerderjarig is, moet geen 'gezag niet te bepalen' worden geleverd
    # wanneer de leeftijd exact bepaald kan worden (zie ../leeftijd/overzicht.feature), wordt 'gezag niet te bepalen' alleen geleverd wanneer de leeftijd lager is dan 18 jaar

    Abstract Scenario: gezag van minderjarig persoon in RNI kan niet worden bepaald
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                  | waarde          |
      | geboortedatum (03.10) | <geboortedatum> |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde |
      | gemeente van inschrijving (09.10) | 1999   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | N          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam | waarde             |
      | type | GezagNietTeBepalen |

      Voorbeelden:
      | geboortedatum            | berekende leeftijd |
      | gisteren - 5 jaar        | 5                  |
      | vandaag - 17 jaar        | 17                 |
      | morgen - 18 jaar         | 17                 |
      | vorige maand - 10 jaar   | 10                 |
      | vorige maand - 17 jaar   | 17                 |
      | volgende maand - 18 jaar | 17                 |

    Abstract Scenario: voor een meerderjarig persoon in RNI wordt geen gezag geleverd
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                  | waarde          |
      | geboortedatum (03.10) | <geboortedatum> |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde |
      | gemeente van inschrijving (09.10) | 1999   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | N          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gezag

      Voorbeelden:
      | geboortedatum            | berekende leeftijd |
      | 19590210                 | 65+                |
      | vandaag - 18 jaar        | 18                 |
      | vorige maand - 18 jaar   | 18                 |
      | volgende maand - 19 jaar | 18                 |


  Regel: een persoon die in RNI staat ingeschreven met een onvolledige geboortedatum krijgt gezag niet te bepalen geleverd wanneer het geboortejaar is ten minste 19 jaar voor het huidige jaar
    # wanneer de leeftijd niet exact bepaald kan worden en er is wel een geboortejaar bekend, wordt 'gezag niet te bepalen' alleen geleverd wanneer de persoon aan het begin van het jaar al meerderjarig (18 jaar) is

    Abstract Scenario: gezag van minderjarig persoon in RNI kan niet worden bepaald
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                  | waarde          |
      | geboortedatum (03.10) | <geboortedatum> |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde |
      | gemeente van inschrijving (09.10) | 1999   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | N          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam | waarde             |
      | type | GezagNietTeBepalen |

      Voorbeelden:
      | geboortedatum        | leeftijd      |
      | deze maand - 5 jaar  | 4 of 5 jaar   |
      | dit jaar - 5 jaar    | 4 of 5 jaar   |
      | deze maand - 18 jaar | 17 of 18 jaar |
      | dit jaar - 18 jaar   | 17 of 18 jaar |

    Abstract Scenario: voor een meerderjarig persoon in RNI wordt geen gezag geleverd
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                  | waarde          |
      | geboortedatum (03.10) | <geboortedatum> |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde |
      | gemeente van inschrijving (09.10) | 1999   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | N          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder gezag

      Voorbeelden:
      | geboortedatum        | leeftijd      |
      | deze maand - 35 jaar | 34 of 35 jaar |
      | dit jaar - 35 jaar   | 34 of 35 jaar |
      | deze maand - 19 jaar | 18 of 19 jaar |
      | dit jaar - 19 jaar   | 18 of 19 jaar |


  Regel: een persoon die in RNI staat ingeschreven krijgt gezag niet te bepalen geleverd wanneer de geboortedatum volledig onbekend is

    Scenario: gezag van minderjarig persoon in RNI kan niet worden bepaald
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 00000000 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde |
      | gemeente van inschrijving (09.10) | 1999   |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | N          |                  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam | waarde             |
      | type | GezagNietTeBepalen |


  Regel: een meerderjarige met gezag over meerdere minderjarigen krijgt de gezagsrelaties van al deze minderjarigen

    Scenario: meerderjarige heeft gezag over meerdere kinderen
      Gegeven de persoon met burgerservicenummer '000000048' heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000012                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000036                   |
      En voor de persoon met burgerservicenummer '000000048' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000048        |
      | 000000024       | OG1        | 000000048        |
      | 000000036       | GG         | 000000048        |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | OG2        | 000000048        |
      | 000000012       | OG2        | 000000061        |
      En voor de persoon met burgerservicenummer '000000024' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000024       | OG1        | 000000048        |
      En voor de persoon met burgerservicenummer '000000036' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000036       | GG         | 000000048        |
      | 000000036       | GG         | 000000073        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon met een 'gezag' met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | TweehoofdigOuderlijkGezag |
      | minderjarige.burgerservicenummer | 000000012                 |
      En heeft 'gezag' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000048 |
      En heeft 'gezag' een 'ouder' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000061 |
      En heeft de persoon een 'gezag' met de volgende gegevens
      | naam                             | waarde                   |
      | type                             | EenhoofdigOuderlijkGezag |
      | minderjarige.burgerservicenummer | 000000024                |
      | ouder.burgerservicenummer        | 000000048                |
      En heeft de persoon een 'gezag' met de volgende gegevens
      | naam                             | waarde           |
      | type                             | GezamenlijkGezag |
      | minderjarige.burgerservicenummer | 000000036        |
      | ouder.burgerservicenummer        | 000000048        |
      | derde.burgerservicenummer        | 000000073        |
