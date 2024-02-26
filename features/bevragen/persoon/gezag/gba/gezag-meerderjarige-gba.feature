#language: nl

@gba
Functionaliteit: gezagsrelaties van een meerderjarige


  Rule: een meerderjarige krijgt voor een minderjarig kind met twee ouders met gezag de gezagsrelatie naar beide ouders geleverd

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


  Rule: een meerderjarige die als enige gezag heeft over een minderjarig kind krijgt de gezagsrelatie naar zichzelf geleverd

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


  Rule: een meerderjarige die samen met diens partner gezag heeft over een minderjarig kind krijgt de gezagsrelatie naar de ouder en de partner geleverd

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


  Rule: een meerderjarige die gezag heeft over een minderjarig kind van de partner krijgt geen gezagsrelatie geleverd

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
      Dan heeft de response een persoon zonder 'gezag' gegevens


  Rule: een meerderjarige krijg voor een meerderjarig kind geen gezagsrelatie geleverd

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
      Dan heeft de response een persoon zonder 'gezag' gegevens


  Rule: een meerderjarige krijgt voor een minderjarig kind waarvoor het gezag niet bepaald kan worden geen gezagsrelatie geleverd

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
      Dan heeft de response een persoon zonder 'gezag' gegevens


  Rule: een meerderjarige krijgt voor een minderjarig kind waarover tijdelijk niemand gezag heeft geen gezagsrelatie geleverd

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
      Dan heeft de response een persoon zonder 'gezag' gegevens


  Rule: een meerderjarige die rechtswege gezag heeft over een minderjarige die geen kind is van de meerderjarige krijgt geen gezagsrelatie geleverd

    Scenario: de partner van overleden ouder heeft gezag over de minderjarige
      Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) |
      | 000000024                   |
      En voor de persoon met burgerservicenummer '000000012' gelden de volgende gezagsrelaties
      | bsnMinderjarige | soortGezag | bsnMeerderjarige |
      | 000000012       | V          | 000000048        |
      En de persoon met burgerservicenummer '000000024' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000048                   | 20120428                                                           |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 20231001 |
      En de persoon met burgerservicenummer '000000024' heeft geen gezagsrelaties
      En de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      | 000000024                   | 20120428                                                           |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | reden ontbinding huwelijk/geregistreerd partnerschap (07.40) |
      | 000000024                   | 20231001                                                     | O                                                            |
      En de persoon met burgerservicenummer '000000048' heeft geen gezagsrelaties
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000048                       |
      | fields              | gezag                           |
      Dan heeft de response een persoon zonder 'gezag' gegevens


  Rule: een meerderjarige die in RNI staat ingeschreven krijgt gezag niet te bepalen geleverd

    Scenario: gezag van meerderjarig persoon in RNI kan niet worden bepaald
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 19580119 |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20020701                             | R                                    |
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
      En heeft de persoon de volgende 'opschortingBijhouding' gegevens
      | naam               | waarde                    |
      | reden.code         | R                         |
      | reden.omschrijving | pl is aangelegd in de rni |


  Rule: een meerderjarige met gezag over meerdere minderjarigen krijgt de gezagsrelaties van al deze minderjarigen

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
