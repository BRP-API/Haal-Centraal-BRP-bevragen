# language: nl

# User story #13
Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  De attributen aanschrijfwijze.naam en aanschrijfwijze.aanspreekvorm bij een persoon worden gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven.
  Bij het samenstellen van de aanschrijfwijze worden academische titels vooralsnog niet opgenomen. Academische titels zijn geen authentiek gegeven en daarom buiten scope geplaatst.
  
  De aanschrijfwijze wordt gebruikt als eerste regel(s) in de adressering op een envelop, of links bovenaan een brief, direct boven het adres.
  
  Bij personen met een adellijke titel of predicaat bevat de aanschrijfwijze ook de aanspreekvorm.
  Deze wordt in de adressering in de regel boven de naam van de aanschrijfwijze geplaatst om een correcte aanschrijving van een adellijke persoon samen te stellen.

  De aanschrijfwijze.naam kan ook worden gebruikt in lijsten met zoekresultaten, of op een website om te tonen op wie het betrekking heeft.

  Attribuut aanschrijfwijze.naam wordt samengesteld op basis van:
  - voornamen (wordt omgezet naar voorletters)
  - adellijke titel/predicaat
  - voorvoegsel geslachtsnaam
  - geslachtsnaam
  - geslacht
  - aanduiding naamgebruik
  - voorvoegsel geslachtsnaam partner
  - geslachtsnaam partner
  - adellijke titel/predicaat partner

  De waarde van aanduiding naamgebruik bepaalt hoe de aanschrijfwijze.naam en aanschrijfwijze.aanspreekvorm worden samengesteld uit de naam van de persoon en de naam van de partner.

  Rule: De naam in aanschrijfwijze wordt op basis van aanduiding naamgebruik als volgt samengesteld:
        | aanduiding naamgebruik | omschrijving                 | naam in aanschrijfwijze |
        | E                      | eigen naam                   | PK VL AT VV GN          |
        | P                      | partner naam                 | VL HT VP GP             |
        | V                      | partner naam voor eigen naam | VL HT VP GP-PK AT VV GN |
        | N                      | partner naam na eigen naam   | PK VL AT VV GN-HT VP GP |
        Betekenis afkortingen in aanschrijfwijze:
          VL = voorletters
          VV = voorvoegselGeslachtsnaam
          GN = geslachtsnaam
          VP = voorvoegselGeslachtsnaam partner
          GP = geslachtsnaam partner
          AT = adelijke titel
          HT = hoffelijkheidstitel of 'titre de courtoisie'
          PK = predicaat
        Toelichting:
        - de aanschrijfwijze.naam start en eindigt niet met een spatie, heeft geen dubbele spaties en heeft geen spatie vóór en na de "-"
        - de voorletters worden opgenomen zoals beschreven in voorletters.feature
        - de eerste naamcomponent in de aanschrijfwijze.naam begint met een hoofdletter
        - het voorvoegsel wordt met kleine letters opgenomen
        - aanduiding naamgebruik "E" (eigen naam) wordt gehanteerd voor een persoon die geen actuele en geen ontbonden huwelijken/partnerschappen heeft gehad
        - de adellijke titel en het predicaat wordt opgenomen in de vorm die hoort bij het geslacht van de persoon:
           | adellijke titel/predicaat | vrouw     | man      | onbekend |
           | JH                        | jonkvrouw | jonkheer |          |
           | JV                        | jonkvrouw | jonkheer |          |
           | R                         |           | ridder   |          |
           | B                         | barones   | baron    |          |
           | BS                        | barones   | baron    |          |
           | H                         | hertogin  | hertog   |          |
           | HI                        | hertogin  | hertog   |          |
           | G                         | gravin    | graaf    |          |
           | GI                        | gravin    | graaf    |          |
           | M                         | markiezin | markies  |          |
           | MI                        | markiezin | markies  |          |
           | P                         | prinses   | prins    |          |
           | PS                        | prinses   | prins    |          |
        - de adellijke titel en het predicaat wordt niet opgenomen als er geen vorm is horende bij het geslacht van de persoon
        - de adellijke titel en het predicaat worden met kleine letters opgenomen
        - de adellijke titel of het predicaat van de persoon wordt niet opgenomen bij aanduiding naamgebruik "P" (partner naam)
        - de hoffelijkheidstitel ('titre de courtoisie') wordt opgenomen als de persoon geslacht "V" (vrouw) heeft en de adellijke titel van de (ex)partner een bijbehorende hoffelijksheidstitel heeft:
          | adellijke titel (ex)partner | hoffelijkheidstitel |
          | B                           | barones             |
          | G                           | gravin              |
          | H                           | hertogin            |
          | M                           | markiezin           |
          | P                           | prinses             |
        - de hoffelijkheidstitel ('titre de courtoisie') wordt niet opgenomen bij aanduiding naamgebruik "E" (eigen naam)
        - het predicaat begint met een hoofdletter als de aanschrijfwijze begint met een predicaat 
        - het predicaat van de partner wordt niet opgenomen
        - het predicaat van de persoon wordt opgenomen achter het streepje en voor eigen voorvoegsel en geslachtsnaam bij aanduiding naamgebruik "V" (partner naam voor eigen naam)
        - bij meerdere actuele (niet ontbonden) huwelijken/partnerschappen, worden de naamgegevens van de eerste partner (oudste relatie) gebruikt voor het samenstellen van de aanschrijfwijze
        - bij geen actueel huwelijk/partnerschap en meerdere ontbonden huwelijken/partnerschappen, worden de naamgegevens van de laatst ontbonden partner gebruikt voor het samenstellen van de aanschrijfwijze

    Abstract Scenario: Persoon zonder voorvoegsel, zonder adellijke titel/predicaat, zonder actuele en/of ontbonden huwelijk/geregistreerd partnerschap
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde                   |
      | geslachtsnaam (02.40)          | Groenen                  |
      | voornamen (02.10)              | Franklin                 |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze.naam       |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | aanduiding naamgebruik | naam in aanschrijfwijze |
      | E                      | F. Groenen              |
      | P                      | F. Groenen              |
      | V                      | F. Groenen              |
      | N                      | F. Groenen              |

    Abstract Scenario: Persoon met voorvoegsel, zonder adellijke titel/predicaat, zonder actuele en/of ontbonden huwelijk/geregistreerd partnerschap
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde                   |
      | voorvoegsel (02.30)            | <voorvoegsel>            |
      | geslachtsnaam (02.40)          | Groenen                  |
      | voornamen (02.10)              | Franklin                 |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze.naam       |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | voorvoegsel | aanduiding naamgebruik | naam in aanschrijfwijze |
      | van         | E                      | F. van Groenen          |
      | Van         | P                      | F. van Groenen          |
      | in het      | V                      | F. in het Groenen       |
      | In Den      | N                      | F. in den Groenen       |

    Abstract Scenario: Persoon met adellijke titel/predicaat, zonder actuele en/of ontbonden huwelijk/geregistreerd partnerschap
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde            |
      | voorvoegsel (02.30)                  | <voorvoegsel>     |
      | geslachtsnaam (02.40)                | <geslachtsnaam>   |
      | voornamen (02.10)                    | <voornamen>       |
      | adellijke titel of predicaat (02.20) | <titel/predicaat> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze.naam       |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | geslacht | voornamen | voorvoegsel | geslachtsnaam | titel/predicaat | naam in aanschrijfwijze    |
      | M        | Franklin  | van den     | Aedel         | JH              | Jonkheer F. van den Aedel  |
      | V        | Francisca |             | Groenen       | JV              | Jonkvrouw F. Groenen       |
      | M        | Franklin  |             | Groenen       | JV              | Jonkheer F. Groenen        |
      | V        | Francisca | van den     | Aedel         | JH              | Jonkvrouw F. van den Aedel |
      | M        | Franklin  | van den     | Aedel         | R               | F. ridder van den Aedel    |
      | V        | Francisca | van den     | Aedel         | R               | F. van den Aedel           |
      | M        | Franklin  | van den     | Aedel         | B               | F. baron van den Aedel     |
      | V        | Francisca |             | Groenen       | BI              | F. barones Groenen         |
      | M        | Franklin  | van den     | Aedel         | H               | F. hertog van den Aedel    |
      | V        | Francisca |             | Groenen       | HI              | F. hertogin Groenen        |
      | M        | Franklin  | van den     | Aedel         | G               | F. graaf van den Aedel     |
      | V        | Francisca | van den     | Aedel         | GI              | F. gravin van den Aedel    |
      | M        | Franklin  | van den     | Aedel         | M               | F. markies van den Aedel   |
      | V        | Francisca | van den     | Aedel         | M               | F. markiezin van den Aedel |
      | M        | Franklin  | van den     | Aedel         | P               | F. prins van den Aedel     |
      | V        | Francisca | van den     | Aedel         | PS              | F. prinses van den Aedel   |
      | M        | Franklin  | van den     | Aedel         | PS              | F. prins van den Aedel     |
      | V        | Francisca | van den     | Aedel         | P               | F. prinses van den Aedel   |
      | O        | Franklin  | van den     | Aedel         | M               | F. van den Aedel           |

    Abstract Scenario: Persoon zonder adellijke titel/predicaat, met een actuele/ontbonden partner met adellijke titel/predicaat heeft aanduiding naamgebruik "E" (eigen naam)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde      |
      | geslachtsnaam (02.40)          | Groenen     |
      | voornamen (02.10)              | <voornamen> |
      | aanduiding naamgebruik (61.10) | E           |
      En de persoon heeft een <partner type> partner met <adellijke titel of predicaat type>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze.naam       |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde     |
      | aanschrijfwijze.naam | F. Groenen |

      Voorbeelden:
      | geslacht | voornamen | partner type | adellijke titel of predicaat type |
      | M        | Franklin  | actuele      | adellijke titel                   |
      | V        | Francisca | ontbonden    | predicaat                         |
      | O        | Franklin  | actuele      | predicaat                         |
      | O        | Francisca | ontbonden    | adellijke titel                   |

    Abstract Scenario: Persoon zonder adellijke titel/predicaat heeft één actuele/ontbonden partner zonder adellijke titel/predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde                   |
      | voorvoegsel (02.30)            | <voorvoegsel>            |
      | geslachtsnaam (02.40)          | <geslachtsnaam>          |
      | voornamen (02.10)              | <voornamen>              |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde                  |
      | voorvoegsel (02.30)   | <voorvoegsel partner>   |
      | geslachtsnaam (02.40) | <geslachtsnaam partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | voornamen | voorvoegsel | geslachtsnaam | aanduiding naamgebruik | voorvoegsel partner | geslachtsnaam partner | naam in aanschrijfwijze     |
      | Franklin  |             | Groenen       | E                      |                     | Groenlo               | F. Groenen                  |
      | Franklin  |             | Groenen       | P                      |                     | Groenlo               | F. Groenlo                  |
      | Franklin  |             | Groenen       | V                      |                     | Groenlo               | F. Groenlo-Groenen          |
      | Franklin  |             | Groenen       | N                      |                     | Groenlo               | F. Groenen-Groenlo          |
      | Henk      | van         | Velzen        | E                      |                     | Groenlo               | H. van Velzen               |
      | Henk      | van         | Velzen        | P                      |                     | Groenlo               | H. Groenlo                  |
      | Henk      | van         | Velzen        | V                      |                     | Groenlo               | H. Groenlo-van Velzen       |
      | Henk      | van         | Velzen        | N                      |                     | Groenlo               | H. van Velzen-Groenlo       |
      | Franklin  |             | Groenen       | E                      | van den             | Aedel                 | F. Groenen                  |
      | Franklin  |             | Groenen       | P                      | van den             | Aedel                 | F. van den Aedel            |
      | Franklin  |             | Groenen       | V                      | van den             | Aedel                 | F. van den Aedel-Groenen    |
      | Franklin  |             | Groenen       | N                      | van den             | Aedel                 | F. Groenen-van den Aedel    |
      | Henk      | van         | Velzen        | E                      | van den             | Aedel                 | H. van Velzen               |
      | Henk      | van         | Velzen        | P                      | van den             | Aedel                 | H. van den Aedel            |
      | Henk      | van         | Velzen        | V                      | van den             | Aedel                 | H. van den Aedel-van Velzen |
      | Henk      | van         | Velzen        | N                      | van den             | Aedel                 | H. van Velzen-van den Aedel |

    Abstract Scenario: Persoon met adellijke titel/predicaat heeft één actuele/ontbonden partner zonder adellijke titel/predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde                   |
      | voorvoegsel (02.30)                  | <voorvoegsel>            |
      | geslachtsnaam (02.40)                | <geslachtsnaam>          |
      | voornamen (02.10)                    | <voornamen>              |
      | adellijke titel of predicaat (02.20) | <titel/predicaat>        |
      | aanduiding naamgebruik (61.10)       | <aanduiding naamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde                  |
      | voorvoegsel (02.30)   | <voorvoegsel partner>   |
      | geslachtsnaam (02.40) | <geslachtsnaam partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | geslacht | voornamen | voorvoegsel | geslachtsnaam | titel/predicaat | aanduiding naamgebruik | voorvoegsel partner | geslachtsnaam partner | naam in aanschrijfwijze     |
      | M        | Franklin  |             | Groenen       | JH              | E                      |                     | Groenlo               | Jonkheer F. Groenen         |
      | M        | Franklin  |             | Groenen       | JH              | P                      |                     | Groenlo               | F. Groenlo                  |
      | M        | Franklin  |             | Groenen       | JH              | V                      |                     | Groenlo               | F. Groenlo-jonkheer Groenen |
      | M        | Franklin  |             | Groenen       | JH              | N                      |                     | Groenlo               | Jonkheer F. Groenen-Groenlo |
      | M        | Henk      | van         | Velzen        | B               | E                      |                     | Groenlo               | H. baron van Velzen         |
      | M        | Henk      | van         | Velzen        | B               | P                      |                     | Groenlo               | H. Groenlo                  |
      | M        | Henk      | van         | Velzen        | B               | V                      |                     | Groenlo               | H. Groenlo-baron van Velzen |
      | M        | Henk      | van         | Velzen        | B               | N                      |                     | Groenlo               | H. baron van Velzen-Groenlo |

    Abstract Scenario: Persoon zonder adellijke titel/predicaat heeft één actuele/ontbonden partner met adellijke titel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde                   |
      | voorvoegsel (02.30)            | <voorvoegsel>            |
      | geslachtsnaam (02.40)          | <geslachtsnaam>          |
      | voornamen (02.10)              | <voornamen>              |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde                    |
      | voorvoegsel (02.30)                  | <voorvoegsel partner>     |
      | geslachtsnaam (02.40)                | <geslachtsnaam partner>   |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | geslacht | voornamen | voorvoegsel | geslachtsnaam | aanduiding naamgebruik | voorvoegsel partner | geslachtsnaam partner | adellijke titel partner | naam in aanschrijfwijze      |
      | M        | Franklin  |             | Groenen       | E                      |                     | Groenlo               | BS                      | F. Groenen                   |
      | M        | Franklin  |             | Groenen       | P                      |                     | Groenlo               | BS                      | F. Groenlo                   |
      | M        | Franklin  |             | Groenen       | V                      |                     | Groenlo               | BS                      | F. Groenlo-Groenen           |
      | M        | Franklin  |             | Groenen       | N                      |                     | Groenlo               | BS                      | F. Groenen-Groenlo           |
      | M        | Franklin  |             | Groenen       | E                      |                     | Groenlo               | B                       | F. Groenen                   |
      | M        | Franklin  |             | Groenen       | P                      |                     | Groenlo               | B                       | F. Groenlo                   |
      | M        | Franklin  |             | Groenen       | V                      |                     | Groenlo               | B                       | F. Groenlo-Groenen           |
      | M        | Franklin  |             | Groenen       | N                      |                     | Groenlo               | B                       | F. Groenen-Groenlo           |
      | O        | Franklin  |             | Groenen       | E                      |                     | Groenlo               | B                       | F. Groenen                   |
      | O        | Franklin  |             | Groenen       | P                      |                     | Groenlo               | B                       | F. Groenlo                   |
      | O        | Franklin  |             | Groenen       | V                      |                     | Groenlo               | B                       | F. Groenlo-Groenen           |
      | O        | Franklin  |             | Groenen       | N                      |                     | Groenlo               | B                       | F. Groenen-Groenlo           |
      | V        | Julia     | van         | Velzen        | E                      |                     | Groenlo               | G                       | J. van Velzen                |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | G                       | J. gravin Groenlo            |
      | V        | Julia     | van         | Velzen        | V                      |                     | Groenlo               | G                       | J. gravin Groenlo-van Velzen |
      | V        | Julia     | van         | Velzen        | N                      |                     | Groenlo               | G                       | H. van Velzen-gravin Groenlo |
      | V        | Julia     | van         | Velzen        | V                      |                     | Groenlo               | GI                      | J. Groenlo-van Velzen        |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | R                       | J. Groenlo                   |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | B                       | J. barones Groenlo           |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | BS                      | J. Groenlo                   |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | H                       | J. hertogin Groenlo          |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | HI                      | J. Groenlo                   |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | G                       | J. gravin Groenlo            |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | GI                      | J. Groenlo                   |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | M                       | J. markiezin Groenlo         |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | MI                      | J. Groenlo                   |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | P                       | J. prinses Groenlo           |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | PS                      | J. Groenlo                   |

    Abstract Scenario: Persoon zonder adellijke titel/predicaat heeft één actuele/ontbonden partner met predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde                   |
      | voorvoegsel (02.30)            | <voorvoegsel>            |
      | geslachtsnaam (02.40)          | <geslachtsnaam>          |
      | voornamen (02.10)              | <voornamen>              |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde                  |
      | voorvoegsel (02.30)                  | <voorvoegsel partner>   |
      | geslachtsnaam (02.40)                | <geslachtsnaam partner> |
      | adellijke titel of predicaat (02.20) | <predicaat partner>     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | geslacht | voornamen | voorvoegsel | geslachtsnaam | aanduiding naamgebruik | voorvoegsel partner | geslachtsnaam partner | predicaat partner | naam in aanschrijfwijze |
      | M        | Franklin  |             | Groenen       | E                      |                     | Groenlo               | JV                | F. Groenen              |
      | M        | Franklin  |             | Groenen       | N                      |                     | Groenlo               | JV                | F. Groenen-Groenlo      |
      | M        | Henk      | van         | Velzen        | P                      |                     | Groenlo               | JV                | H. Groenlo              |
      | M        | Henk      | van         | Velzen        | V                      |                     | Groenlo               | JV                | H. Groenlo-van Velzen   |
      | V        | Julia     | van         | Velzen        | E                      |                     | Groenlo               | JH                | J. van Velzen           |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | JH                | J. Groenlo              |
      | V        | Julia     | van         | Velzen        | V                      |                     | Groenlo               | JH                | J. Groenlo-van Velzen   |
      | V        | Julia     | van         | Velzen        | N                      |                     | Groenlo               | JH                | H. van Velzen-Groenlo   |
      | M        | Franklin  | van         | Velzen        | P                      |                     | Groenlo               | JH                | F. Groenlo              |
      | V        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | JV                | J. Groenlo              |
      | O        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | JH                | J. Groenlo              |
      | O        | Julia     | van         | Velzen        | P                      |                     | Groenlo               | JV                | J. Groenlo              |

    Abstract Scenario: Persoon met adellijke titel/predicaat heeft één actuele/ontbonden partner met adellijke titel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde                      |
      | voorvoegsel (02.30)                  |                             |
      | geslachtsnaam (02.40)                | <geslachtsnaam>             |
      | voornamen (02.10)                    | <voornamen>                 |
      | aanduiding naamgebruik (61.10)       | <aanduiding naamgebruik>    |
      | adellijke titel of predicaat (02.20) | <adellijke titel/predicaat> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde                    |
      | voorvoegsel (02.30)                  |                           |
      | geslachtsnaam (02.40)                | <geslachtsnaam partner>   |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | geslacht | voornamen | geslachtsnaam | adellijke titel/predicaat | aanduiding naamgebruik | geslachtsnaam partner | adellijke titel partner | naam in aanschrijfwijze           |
      | M        | Franklin  | Groenen       | G                         | E                      | Groenlo               | BS                      | F. graaf Groenen                  |
      | M        | Franklin  | Groenen       | G                         | P                      | Groenlo               | BS                      | F. Groenlo                        |
      | M        | Franklin  | Groenen       | G                         | V                      | Groenlo               | BS                      | F. Groenlo-graaf Groenen          |
      | M        | Franklin  | Groenen       | G                         | N                      | Groenlo               | BS                      | F. graaf Groenen-Groenlo          |
      | V        | Francisca | Groenen       | GI                        | E                      | Groenlo               | B                       | F. gravin Groenen                 |
      | V        | Francisca | Groenen       | GI                        | P                      | Groenlo               | B                       | F. barones Groenlo                |
      | V        | Francisca | Groenen       | GI                        | V                      | Groenlo               | B                       | F. barones Groenlo-gravin Groenen |
      | V        | Francisca | Groenen       | GI                        | N                      | Groenlo               | B                       | F. gravin Groenen-barones Groenlo |

    Abstract Scenario: Persoon met meerdere actuele partners
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde                   |
      | geslachtsnaam (02.40)          | Groen                    |
      | voornamen (02.10)              | Ferdinand Cornelis       |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   |        |
      | geslachtsnaam (02.40) | Geel   |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                  | waarde   |
      | datum aangaan (06.10) | 19580401 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992936 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   |        |
      | geslachtsnaam (02.40) | Roodt  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                  | waarde   |
      | datum aangaan (06.10) | 19610831 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | aanduiding naamgebruik | naam in aanschrijfwijze |
      | E                      | F.C. Groen              |
      | P                      | F.C. Geel               |
      | V                      | F.C. Geel-Groen         |
      | N                      | F.C. Groen-Geel         |

    Abstract Scenario: Persoon met meerdere ontbonden partners
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde                   |
      | voorvoegsel (02.30)            |                          |
      | geslachtsnaam (02.40)          | Wit                      |
      | voornamen (02.10)              | Jan                      |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de laatst ontbonden partner van de persoon heeft de volgende naam gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   |        |
      | geslachtsnaam (02.40) | Geel   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                 | waarde                    |
      | aanschrijfwijze.naam | <naam in aanschrijfwijze> |

      Voorbeelden:
      | aanduiding naamgebruik | naam in aanschrijfwijze |
      | E                      | J. Wit                  |
      | P                      | J. Geel                 |
      | V                      | J. Geel-Wit             |
      | N                      | J. Wit-Geel             |

    Abstract Scenario: persoon heeft een naamketen
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde          |
      | voornamen (02.10)                    |                 |
      | adellijke titel of predicaat (02.20) |                 |
      | voorvoegsel (02.30)                  |                 |
      | geslachtsnaam (02.40)                | <geslachtsnaam> |
      | aanduidingNaamgebruik (61.10)        | <naamgebruik>   |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   | van    |
      | geslachtsnaam (02.40) | Velzen |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                  | waarde                    |
      | aanschrijfwijze.naam  | <naam in aanschrijfwijze> |

      Voorbeelden:
      | geslacht | geslachtsnaam     | naamgebruik | naam in aanschrijfwijze      |
      | M        | Ali bin Mohammed  | E           | Ali bin Mohammed             |
      | M        | Ali bin Mohammed  | P           | Van Velzen                   |
      | M        | Ali bin Mohammed  | V           | Van Velzen-Ali bin Mohammed  |
      | M        | Ali bin Mohammed  | N           | Ali bin Mohammed-van Velzen  |
      | V        | Ibin binti Yalniz | E           | Ibin binti Yalniz            |
      | V        | Ibin binti Yalniz | P           | Van Velzen                   |
      | V        | Ibin binti Yalniz | V           | Van Velzen-Ibin binti Yalniz |
      | V        | Ibin binti Yalniz | N           | Ibin binti Yalniz-van Velzen |
      | O        | Ali bin Mohammed  | E           | Ali bin Mohammed             |
      | O        | Ali bin Mohammed  | P           | Van Velzen                   |
      | O        | Ibin binti Yalniz | V           | Van Velzen-Ibin binti Yalniz |
      | O        | Ibin binti Yalniz | N           | Ibin binti Yalniz-van Velzen |

    Abstract Scenario: persoon met een naamketen heeft een partner met adellijke titel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde          |
      | voornamen (02.10)                    |                 |
      | adellijke titel of predicaat (02.20) |                 |
      | voorvoegsel (02.30)                  |                 |
      | geslachtsnaam (02.40)                | <geslachtsnaam> |
      | aanduidingNaamgebruik (61.10)        | <naamgebruik>   |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde                    |
      | voorvoegsel (02.30)                  | van                       |
      | geslachtsnaam (02.40)                | Velzen                    |
      | adellijke titel of predicaat (02.20) | <adellijke titel partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                  | waarde                    |
      | aanschrijfwijze.naam  | <naam in aanschrijfwijze> |

      Voorbeelden:
      | geslacht | geslachtsnaam     | naamgebruik | adellijke titel partner | naam in aanschrijfwijze                |
      | M        | Ali bin Mohammed  | E           | BS                      | Ali bin Mohammed                       |
      | M        | Ali bin Mohammed  | P           | GI                      | Van Velzen                             |
      | M        | Ali bin Mohammed  | V           | MI                      | Van Velzen-Ali bin Mohammed            |
      | M        | Ali bin Mohammed  | N           | HI                      | Ali bin Mohammed-van Velzen            |
      | V        | Ibin binti Yalniz | E           | B                       | Ibin binti Yalniz                      |
      | V        | Ibin binti Yalniz | P           | G                       | Gravin van Velzen                      |
      | V        | Ibin binti Yalniz | V           | H                       | Hertogin van Velzen-Ibin binti Yalniz  |
      | V        | Ibin binti Yalniz | N           | M                       | Ibin binti Yalniz-markiezin van Velzen |
      | O        | Ali bin Mohammed  | E           | BS                      | Ali bin Mohammed                       |
      | O        | Ali bin Mohammed  | P           | G                       | Van Velzen                             |
      | O        | Ibin binti Yalniz | V           | MI                      | Van Velzen-Ibin binti Yalniz           |
      | O        | Ibin binti Yalniz | N           | H                       | Ibin binti Yalniz-van Velzen           |

  Rule: de aanspreekvorm in aanschrijfwijze wordt als volgt samengesteld:
        | adellijke titel/predicaat | vrouw                    | man                    | onbekend    |
        | JH                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | JV                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | R                         | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | B                         | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | BS                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | H                         | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | HI                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | G                         | De hooggeboren vrouwe    | De hooggeboren heer    |             |
        | GI                        | De hooggeboren vrouwe    | De hooggeboren heer    |             |
        | M                         | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | MI                        | De hoogwelgeboren vrouwe | De hoogwelgeboren heer |             |
        | P                         | De hoogheid              | De hoogheid            | De hoogheid |
        | PS                        | De hoogheid              | De hoogheid            | De hoogheid |
        toelichting:
        - er is geen aanspreekvorm als:
          - de persoon geen adellijke titel/predicaat heeft
          - de persoon gebruikt aanduiding naamgebruik "P" (naam partner)
          - er geen adellijke titel/predicaat vorm is die hoort bij de geslachtsaanduiding van de persoon
          - de persoon een predicaat, de geslachtsaanduiding "V" (vrouw) en een actuele (niet ontbonden) partner heeft
          - de persoon een predicaat, de geslachtsaanduiding "V" (vrouw), geen actuele (maar mogelijk wel ontbonden) partner en een aanduiding naamgebruik ongelijk aan "E" (eigen naam) heeft

    Abstract Scenario: Persoon heeft geen adellijke titel/predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde                   |
      | geslachtsnaam (02.40)          | Groenen                  |
      | voornamen (02.10)              | Franklin                 |
      | aanduiding naamgebruik (61.10) | <aanduiding naamgebruik> |
      En de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 999992934                          |
      | fields              | naam.aanschrijfwijze.aanspreekvorm |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                          | waarde |
      | aanschrijfwijze.aanspreekvorm |        |

      Voorbeelden:
      | aanduiding naamgebruik |
      | E                      |
      | P                      |
      | V                      |
      | N                      |

    Abstract Scenario: Persoon heeft adellijke titel/predicaat en gebruikt aanduiding naamgebruik "P"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde     |
      | burgerservicenummer         | 999992934  |
      | geslachtsaanduiding (04.10) | <geslacht> |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde                   |
      | adellijke titel of predicaat (02.20) | <titel/predicaat>        |
      | aanduiding naamgebruik (61.10)       | <aanduiding naamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde                    |
      | adellijke titel of predicaat (02.20) | <titel/predicaat partner> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 999992934                          |
      | fields              | naam.aanschrijfwijze.aanspreekvorm |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | geslacht | aanduiding naamgebruik | titel/predicaat | titel/predicaat partner | aanspreekvorm            |
      | M        | E                      | JH              |                         | De hoogwelgeboren heer   |
      | M        | P                      | R               | GI                      |                          |
      | M        | V                      | R               |                         | De hoogwelgeboren heer   |
      | M        | N                      | B               | BS                      | De hoogwelgeboren heer   |
      | M        | E                      | H               |                         | De hoogwelgeboren heer   |
      | M        | P                      | G               | GI                      |                          |
      | M        | V                      | G               | BS                      | De hoogwelgeboren heer   |
      | M        | N                      | M               |                         | De hoogwelgeboren heer   |
      | M        | E                      | P               |                         | De hoogheid              |
      | V        | E                      | JV              |                         | De hoogwelgeboren vrouwe |
      | V        | P                      | BS              |                         |                          |
      | V        | V                      | BS              | BS                      | De hoogwelgeboren vrouwe |
      | V        | N                      | HI              | GI                      | De hoogwelgeboren vrouwe |
      | V        | E                      | GI              |                         | De hoogwelgeboren vrouwe |
      | V        | P                      | MI              | GI                      |                          |
      | V        | V                      | MI              | BS                      | De hoogwelgeboren vrouwe |
      | V        | N                      | PS              |                         | De hoogheid              |

    Abstract Scenario: Persoon heeft geslacht O en heeft een adellijke titel/predicaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | O         |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde            |
      | adellijke titel of predicaat (02.20) | <titel/predicaat> |
      | aanduiding naamgebruik (61.10)       | E                 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 999992934                          |
      | fields              | naam.aanschrijfwijze.aanspreekvorm |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | titel/predicaat | aanspreekvorm |
      | JH              |               |
      | JV              |               |
      | R               |               |
      | B               |               |
      | BS              |               |
      | H               |               |
      | HI              |               |
      | G               |               |
      | GI              |               |
      | M               |               |
      | MI              |               |
      | P               | De hoogheid   |
      | PS              | De hoogheid   |

    Abstract Scenario: Persoon heeft een predicaat, heeft geslacht "V" en heeft een actuele partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde                   |
      | adellijke titel of predicaat (02.20) | <predicaat>              |
      | aanduiding naamgebruik (61.10)       | <aanduiding naamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                  | waarde   |
      | datum aangaan (06.10) | 19580401 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 999992934                          |
      | fields              | naam.aanschrijfwijze.aanspreekvorm |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                          | waarde |
      | aanschrijfwijze.aanspreekvorm |        |

      Voorbeelden:
      | predicaat | aanduiding naamgebruik |
      | JH        | E                      |
      | JH        | P                      |
      | JH        | V                      |
      | JH        | N                      |
      | JV        | E                      |
      | JV        | P                      |
      | JV        | V                      |
      | JV        | N                      |

    Abstract Scenario: Persoon heeft een predicaat, heeft geslacht "V" en heeft geen actuele partner(s)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999992934 |
      | geslachtsaanduiding (04.10) | V         |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde                   |
      | adellijke titel of predicaat (02.20) | <predicaat>              |
      | aanduiding naamgebruik (61.10)       | <aanduiding naamgebruik> |
      En de persoon heeft alleen ontbonden partners
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 999992934                          |
      | fields              | naam.aanschrijfwijze.aanspreekvorm |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam                          | waarde          |
      | aanschrijfwijze.aanspreekvorm | <aanspreekvorm> |

      Voorbeelden:
      | predicaat | aanduiding naamgebruik | aanspreekvorm            |
      | JH        | E                      | De hoogwelgeboren vrouwe |
      | JH        | P                      |                          |
      | JH        | V                      |                          |
      | JH        | N                      |                          |
      | JV        | E                      | De hoogwelgeboren vrouwe |
      | JV        | P                      |                          |
      | JV        | V                      |                          |
      | JV        | N                      |                          |
