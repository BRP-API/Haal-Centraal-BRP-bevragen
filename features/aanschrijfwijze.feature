# language: nl

# User story #13
Functionaliteit: Als gemeente wil ik de juiste en consistente aanschrijfwijze van mijn burgers
  Attribuut aanschrijfwijze bij een persoon wordt gevuld door de provider om op deze wijze op eenduidige wijze een persoon te kunnen aanschrijven.
  Bij het samenstellen van de aanschrijfwijze worden academische titels vooralsnog niet opgenomen. Academische titels zijn geen authentiek gegeven en daarom buiten scope geplaatst.
  
  De aanschrijfwijze wordt gebruikt als eerste regel in de adressering op een envelop, of links bovenaan een brief, direct boven het adres.
  
  Bij personen met een adellijke titel of predikaat wordt ook regelVoorafgaandAanAanschrijfwijze gevuld.
  Deze wordt in de adressering in de regel boven aanschrijfwijze geplaatst om een correcte aanschrijving van een adellijke persoon samen te stellen.

  De aanschrijfwijze kan ook worden gebruikt in lijsten met zoekresultaten, of op een website om te tonen op wie het betrekking heeft.

  Attribuut aanschrijfwijze wordt samengesteld op basis van:
  - voornamen (wordt omgezet naar voorletters)
  - adellijkeTitel_predikaat
  - voorvoegselGeslachtsnaam
  - geslachtsnaam
  - geslachtsaanduiding
  - aanduidingAanschrijving
  - voorvoegselGeslachtsnaam partner
  - geslachtsnaam partner
  - adellijkeTitel_predikaat partner
  - geslachtsaanduiding partner

  De waarde van aanduidingAanschrijving bepaalt hoe de aanschrijfwijze wordt samengesteld uit de naam van de persoon en de naam van de partner. Zie de tabel "Voorbeelden: met voorvoegsel" en "Voorbeelden: met voorvoegsel" hieronder.

  Wanneer er geen voorvoegsel is, wordt deze niet opgenomen. Er zit dan één spatie tussen de voorletters en de geslachtsnaam. Zie de tabel "Voorbeelden: met voorvoegsel" en "Voorbeelden: met voorvoegsel" hieronder.

  De voorletters worden opgenomen zoals beschreven in Voorletters.feature.

  Als er meerdere actuele (niet ontbonden) huwelijken/partnerschappen zijn
  En de aanduiding aanschijving is ongelijk aan 'Eigen',
  Dan wordt als partnernaam de naam van de eerste partner (oudste relatie) gebruikt.

  Als er meerdere ontbonden huwelijken/partnerschappen zijn
  En er geen actueel (niet ontbonden) huwelijk/partnerschap is
  En de aanduiding aanschijving is ongelijk aan 'Eigen'
  Dan wordt als partnernaam de naam van de laatst ontbinden relatie gebruikt.

  Op basis van attribuut adellijkeTitel_predikaat en de geslachtsaanduiding wordt de adelijke titel of het predikaat toegevoegd in de aanschrijfwijze.
  De adellijke titel of het predikaat wordt in aanschrijfwijze opgenomen in de vorm die hoort bij de geslachtsaanduiding:
  | adellijkeTitel_predikaat | vrouw     | man      | onbekend |
  | Graaf                    | gravin    | graaf    | -        |
  | Gravin                   | gravin    | graaf    | -        |
  | Baron                    | barones   | baron    | -        |
  | Barones                  | barones   | baron    | -        |
  | Hertog                   | hertogin  | hertog   | -        |
  | Hertogin                 | hertogin  | hertog   | -        |
  | Markies                  | markiezin | markies  | -        |
  | Markiezin                | markiezin | markies  | -        |
  | Prins                    | prinses   | prins    | -        |
  | Prinses                  | prinses   | prins    | -        |
  | Ridder                   | -         | ridder   | -        |
  | Jonkheer                 | jonkvrouw | jonkheer | -        |
  | Jonkvrouw                | jonkvrouw | jonkheer | -        |

  Als de adellijke titel geen vorm heeft die hoort bij de geslachtsaanduiding (in bovenstaande tabel opgenomen als - teken)
  Dan wordt de adellijke titel niet opgenomen in de aanschrijfwijze.

  Als de geslachtsaanduiding is "onbekend" (O) of er is geen waarde voor geslachtsaanduiding
  Dan wordt de (eventuele) adellijke titel of het predikaat niet opgenomen in de aanschrijfwijze.

  Als de persoon beschikt over een predikaat
  En de aanduiding aanschrijving is gelijk aan "E" (eigen) of "N" (partner na eigen geslachtsnaam)
  Dan wordt deze geplaatst vóór de voorletters
  En begin het predikaat in de aanschrijfwijze met een hoofdletter (J).

  Als de persoon beschikt over een predikaat
  En de aanduiding aanschrijving is gelijk aan "V" (partner voor eigen geslachtsnaam)
  Dan wordt deze geplaatst vóór het eigen voorvoegsel en geslachtsnaam
  En begin het predikaat in de aanschrijfwijze met een kleine letter (j).

  Als de persoon beschikt over een predikaat
  En de aanduiding aanschrijving is gelijk aan "P" (partner)
  Dan wordt het predikaat niet gebruikt.

  Als de persoon over een adelijke titel beschikt
  Dan wordt de adelijke titel geplaatst tussen voorletters en achternaam (voorvoegsel en geslachtsnaam).

  Als de persoon zelf beschikt over een adellijke titel
  En de persoon gebruikt de geslachtsnaam van de echtgenoot/partner in combinatie met de eigen achternaam
  Dan wordt de titel van betrokkene voor de eigen achternaam geplaatst.

  Als de persoon zelf beschikt over een adellijke titel
  En de persoon de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam (aanduiding aanschrijving is "P" - "partner")
  Dan wordt de adellijke titel niet gebruikt.

  Als de partner een adellijke titel heeft
  En de geslachtsaanduiding van de persoon is "vrouw"
  En de geslachtsaanduiding van de partner is "man"
  En de adellijke titel van de partner heeft een vrouwelijke vorm (zie tabel hieronder)
  En de persoon gebruikt de naam van haar partner (aanduidingNaamgebruik ongelijk aan "E" - "eigen")
  Dan wordt de adellijke titel van de partner in vrouwelijke vorm opgenomen voor het voorvoegsel van de naam van de partner
  | Titel | Vrouwelijke vorm |
  | Graaf | gravin           |
  | Baron | barones          |
  | Prins | prinses          |

  Als de persoon een adellijke titel of predikaat heeft, wordt de regelVoorafgaandAanAanschrijfwijze bepaald op basis van adellijkeTitel_predikaat en de geslachtsaanduiding volgens de volgende tabel:
  | adellijkeTitel_predikaat | geslachtsaanduiding | regelVoorafgaandAanAanschrijfwijze |
  | Baron, Barones           | man                 | De hoogwelgeboren heer             |
  | Baron, Barones           | vrouw               | De hoogwelgeboren vrouwe           |
  | Graaf, Gravin            | man                 | De hooggeboren heer                |
  | Graaf, Gravin            | vrouw               | De hooggeboren vrouwe              |
  | Hertog, Hertogin         | man                 | De hoogwelgeboren heer             |
  | Hertog, Hertogin         | vrouw               | De hoogwelgeboren vrouwe           |
  | Jonkheer, Jonkvrouw      | man                 | De hoogwelgeboren heer             |
  | Jonkheer, Jonkvrouw      | vrouw               | De hoogwelgeboren vrouwe           |
  | Markies, Markiezin       | man                 | De hoogwelgeboren heer             |
  | Markies, Markiezin       | vrouw               | De hoogwelgeboren vrouwe           |
  | Prins, Prinses           | man                 | De hoogheid                        |
  | Prins, Prinses           | vrouw               | De hoogheid                        |
  | Prins, Prinses           | onbekend            | De hoogheid                        |
  | Ridder                   | man                 | De hoogwelgeboren heer             |
  | Ridder                   | vrouw               | De hoogwelgeboren vrouwe           |

  Als de persoon een predikaat heeft
  En de geslachtsaanduiding is gelijk aan "vrouw"
  En betrokkene is getrouwd of heeft een geregistreerd partnerschap
  En het huwelijk dan wel geregistreerd partnerschap is niet beëindigd of ontbonden
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  Als de persoon een predikaat heeft
  En de geslachtsaanduiding is gelijk aan "vrouw"
  En de persoon is getrouwd geweest of heeft een geregistreerd partnerschap gehad
  En het huwelijk dan wel geregistreerd partnerschap is beëindigd of ontbonden
  En de (ex)partnernaam wordt nog gebruikt (aanduiding naamgebruik is "V", "N" of "P")
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  Als de persoon een adellijke titel of predikaat heeft
  En de geslachtsaanduiding is gelijk aan "onbekend" of er is geen waarde voor geslachtsaanduiding
  En de adellijke titel is ongelijk aan "prins" of "prinses" ("De hoogheid" is gender neutraal dus kan ook bij onbekend geslacht gebruikt worden)
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  Als de persoon geen adellijke titel of predikaat heeft
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  Als de persoon een adellijke titel of predikaat heeft
  En betrokkene de geslachtsnaam van de echtgenoot/partner gebruikt zonder de eigen geslachtsnaam (aanduiding aanschrijving is "P" - "partner")
  Dan wordt regelVoorafgaandAanAanschrijfwijze niet opgenomen.

  # In onderstaande tabellen betekenen de afkortingen:
  # VL = voorletters
  # VV = voorvoegselGeslachtsnaam
  # GN = geslachtsnaam
  # VP = voorvoegselGeslachtsnaam partner
  # GP = geslachtsnaam partner
  # AT = adelijke titel
  # AP = adellijke titel partner (in andersgeslachtelijke vorm)
  # PK = predikaat

  Rule: De aanschrijfwijze voor een alleenstaande wordt als volgt samengesteld:
        |                                                  | aanschrijfwijze |
        | geen adellijke titel/predikaat, geen voorvoegsel | VL GN           |
        | geen adellijke titel/predikaat, voorvoegsel      | VL VV GN        |
        | predikaat, geen voorvoegsel                      | PK VL GN        |
        | predikaat, voorvoegsel                           | PK VL VV GN     |
        | adellijke titel, geen voorvoegsel                | VL AT GN        |
        | adellijke titel, voorvoegsel                     | VL AT VV GN     |

    Abstract Scenario: Alleenstaande, <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde            |
      | voorvoegsel (02.30)                  | <voorvoegsel>     |
      | geslachtsnaam (02.40)                | <geslachtsnaam>   |
      | voornamen (02.10)                    | <voornamen>       |
      | aanduiding naamgebruik (61.10)       | E                 |
      | adellijke titel of predikaat (02.20) | <titel/predikaat> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam            | waarde            |
      | aanschrijfwijze | <aanschrijfwijze> |

      Voorbeelden:
      | voorvoegsel | geslachtsnaam | voornamen | titel/predikaat | aanschrijfwijze         | titel                                            |
      |             | Groenen       | Franklin  |                 | F. Groenen              | geen adellijke titel/predikaat, geen voorvoegsel |
      | In het      | Veld          | Henk      |                 | H. In het Veld          | geen adellijke titel/predikaat, voorvoegsel      |
      |             | Groenen       | Franklin  | G               | F. graaf Groenen        | adellijke titel, geen voorvoegsel                |
      |             | Groenen       | Franklin  | JH              | Jonkheer F. Groenen     | predikaat, geen voorvoegsel                      |
      | In het      | Veld          | Henk      | B               | H. baron In het Veld    | adellijke titel, voorvoegsel                     |
      | In het      | Veld          | Henk      | JH              | Jonkheer H. In het Veld | predikaat, voorvoegsel                           |

  Rule: De aanschrijfwijze voor een persoon met partner zonder adellijke titel/predikaat wordt als volgt samengesteld:
        |                                                                            | naamgebruik | aanschrijfwijze   | opmerking |
        | geen adellijke titel/predikaat, geen voorvoegsel                           | E           | VL GN             |           |
        | geen adellijke titel/predikaat, voorvoegsel                                | E           | VL VV GN          |           |
        | predikaat, geen voorvoegsel                                                | E           | PK VL GN          | 1         |
        | predikaat, voorvoegsel                                                     | E           | PK VL VV GN       | 1         |
        | adellijke titel, geen voorvoegsel                                          | E           | VL AT GN          | 4         |
        | adellijke titel, voorvoegsel                                               | E           | VL AT VV GN       | 4         |
        | geen adellijke titel/predikaat, partner geen voorvoegsel                   | P           | VL GP             |           |
        | geen adellijke titel/predikaat, partner voorvoegsel                        | P           | VL VP GP          |           |
        | predikaat, partner geen voorvoegsel                                        | P           | VL GP             | 2         |
        | predikaat, partner voorvoegsel                                             | P           | VL VP GP          | 2         |
        | adellijke titel, partner geen voorvoegsel                                  | P           | VL GP             | 5         |
        | adellijke titel, partner voorvoegsel                                       | P           | VL VP GP          | 5         |
        | geen adellijke titel/predikaat, geen voorvoegsel, partner geen voorvoegsel | N           | VL GN-GP          |           |
        | geen adellijke titel/predikaat, geen voorvoegsel, partner voorvoegsel      | N           | VL GN-VP GP       |           |
        | geen adellijke titel/predikaat, voorvoegsel, partner geen voorvoegsel      | N           | VL VV GN-GP       |           |
        | geen adellijke titel/predikaat, voorvoegsel, partner voorvoegsel           | N           | VL VV GN-VP GP    |           |
        | predikaat, geen voorvoegsel, partner geen voorvoegsel                      | N           | PK VL GN-GP       | 1         |
        | predikaat, geen voorvoegsel, partner voorvoegsel                           | N           | PK VL GN-VP GP    | 1         |
        | predikaat, voorvoegsel, partner geen voorvoegsel                           | N           | PK VL VV GN-GP    | 1         |
        | predikaat, voorvoegsel, partner voorvoegsel                                | N           | PK VL VV GN-VP GP | 1         |
        | adellijke titel, geen voorvoegsel, partner geen voorvoegsel                | N           | VL AT GN-GP       |           |
        | adellijke titel, geen voorvoegsel, partner voorvoegsel                     | N           | VL AT GN-VP GP    |           |
        | adellijke titel, voorvoegsel, partner geen voorvoegsel                     | N           | VL AT VV GN-GP    |           |
        | adellijke titel, voorvoegsel, partner voorvoegsel                          | N           | VL AT VV GN-VP GP |           |
        | geen adellijke titel/predikaat, geen voorvoegsel, partner geen voorvoegsel | V           | VL GP-GN          |           |
        | geen adellijke titel/predikaat, geen voorvoegsel, partner voorvoegsel      | V           | VL VP GP-GN       |           |
        | geen adellijke titel/predikaat, voorvoegsel, partner geen voorvoegsel      | V           | VL GP-VV GN       |           |
        | geen adellijke titel/predikaat, voorvoegsel, partner voorvoegsel           | V           | VL VP GP-VV GN    |           |
        | predikaat, geen voorvoegsel, partner geen voorvoegsel                      | V           | VL GP-PK GN       | 3         |
        | predikaat, geen voorvoegsel, partner voorvoegsel                           | V           | VL VP GP-PL GN    | 3         |
        | predikaat, voorvoegsel, partner geen voorvoegsel                           | V           | VL GP-PK VV GN    | 3         |
        | predikaat, voorvoegsel, partner voorvoegsel                                | V           | VL VP GP-PK VP GP | 3         |
        | adellijke titel, geen voorvoegsel, partner geen voorvoegsel                | V           | VL AT GN-GP       |           |
        | adellijke titel, geen voorvoegsel, partner voorvoegsel                     | V           | VL AT GN-VP GP    |           |
        | adellijke titel, voorvoegsel, partner geen voorvoegsel                     | V           | VL AT VV GN-GP    |           |
        | adellijke titel, voorvoegsel, partner voorvoegsel                          | V           | VL AT VV GN-VP GP |           |

        1. predikaat begint met hoofdletter en wordt geplaatst vóór de voorletters
        2. predikaat wordt niet opgenomen bij naamgebruik P
        3. predikaat begint met kleine letter en wordt geplaatst vóór eigen achternaam (voorvoegsel en geslachtsnaam) bij naamgebruik V
        4. adellijke titel wordt geplaatst tussen voorletters en achternaam (voorvoegsel en geslachtsnaam)
        5. adellijke titel wordt niet opgenomen bij naamgebruik P

    Abstract Scenario: Met partner zonder adellijke titel/predikaat, <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde            |
      | voorvoegsel (02.30)                  | <voorvoegsel>     |
      | geslachtsnaam (02.40)                | <geslachtsnaam>   |
      | voornamen (02.10)                    | <voornamen>       |
      | aanduiding naamgebruik (61.10)       | <naamgebruik>     |
      | adellijke titel of predikaat (02.20) | <titel/predikaat> |
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
      | naam            | waarde            |
      | aanschrijfwijze | <aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | voorvoegsel | geslachtsnaam | voornamen | titel/predikaat | voorvoegsel partner | geslachtsnaam partner | aanschrijfwijze                    | samenstelling aanschrijfwijze | titel                                                                      |
      | E           |             | Groenen       | Franklin  |                 |                     | Groenlo               | F. Groenen                         | VL GN                         | geen adellijke titel/predikaat, geen voorvoegsel                           |
      | N           |             | Groenen       | Franklin  |                 |                     | Groenlo               | F. Groenen-Groenlo                 | VL GN-GP                      | geen adellijke titel/predikaat, geen voorvoegsel, partner geen voorvoegsel |
      | P           |             | Groenen       | Franklin  |                 |                     | Groenlo               | F. Groenlo                         | VL GP                         | geen adellijke titel/predikaat, partner geen voorvoegsel                   |
      | V           |             | Groenen       | Franklin  |                 |                     | Groenlo               | F. Groenlo-Groenen                 | VL GP-GN                      | geen adellijke titel/predikaat, geen voorvoegsel, partner geen voorvoegsel |
      | E           | In het      | Veld          | Henk      |                 |                     | Groenlo               | H. In het Veld                     | VL VV GN                      | geen adellijke titel/predikaat, voorvoegsel                                |
      | N           | In het      | Veld          | Henk      |                 |                     | Groenlo               | H. In het Veld-Groenlo             | VL VV GN-GP                   | geen adellijke titel/predikaat, voorvoegsel, partner geen voorvoegsel      |
      | P           |             | Groenen       | Franklin  |                 | van                 | Velzen                | F. van Velzen                      | VL VP GP                      | geen adellijke titel/predikaat, partner voorvoegsel                        |
      | V           | In het      | Veld          | Henk      |                 | van                 | Velzen                | H. van Velzen-In het Veld          | VL VP GP-VV GN                | geen adellijke titel/predikaat, voorvoegsel, partner voorvoegsel           |
      | E           |             | Groenen       | Franklin  | R               |                     | Groenlo               | F. ridder Groenen                  | VL AT GN                      | adellijke titel, geen voorvoegsel                                          |
      | N           |             | Groenen       | Franklin  | R               | van                 | Velzen                | F. ridder Groenen-van Velzen       | VL AT GN-VP GP                | adellijke titel, geen voorvoegsel, partner voorvoegsel                     |
      | P           |             | Groenen       | Franklin  | R               |                     | Groenlo               | F. Groenlo                         | VL GP                         | adellijke titel, partner geen voorvoegsel                                  |
      | V           | In het      | Veld          | Henk      | JH              | van                 | Velzen                | H. van Velzen-jonkheer In het Veld | VL VP GP-PK VV GN             | predikaat, voorvoegsel, partner voorvoegsel                                |

  Rule: De aanschrijfwijze voor een persoon met partner met adellijke titel wordt als volgt samengesteld:
        |                                                                                          | naamgebruik | aanschrijfwijze   | opmerking |
        | geslachtsaanduiding "V", partner: geslachtsaanduiding "M", geen voorvoegsel              | P           | VL AP GP          | 1         |
        | geslachtsaanduiding "V", geen voorvoegsel, partner: geslachtsaanduiding "M", voorvoegsel | N           | VL GN-AP VP GP    | 1         |
        | geslachtsaanduiding "V", voorvoegsel, partner: geslachtsaanduiding "M", voorvoegsel      | V           | VL AP VP GP-VV GN | 1         |

        1. adellijke titel partner wordt in vrouwelijke vorm opgenomen voor de achternaam (voorvoegsel + geslachtsnaam) van de partner
          | titel | vrouwelijke vorm |
          | graaf | gravin           |
          | baron | barones          |
          | prins | prinses          |

    Abstract Scenario: persoon zonder adellijke titel/predikaat, partner met adellijke titel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde        |
      | geslachtsaanduiding (04,10)          | V             |
      | voorvoegsel (02.30)                  | In het        |
      | geslachtsnaam (02.40)                | Veld          |
      | voornamen (02.10)                    | Emma Louise   |
      | aanduiding naamgebruik (61.10)       | <naamgebruik> |
      | adellijke titel of predikaat (02.20) |               |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde            |
      | voorvoegsel (02.30)                  | van den           |
      | geslachtsnaam (02.40)                | Aedel             |
      | adellijke titel of predikaat (02.20) | <titel/predikaat> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam            | waarde            |
      | aanschrijfwijze | <aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | titel/predikaat partner | aanschrijfwijze                        | opmerkingen                                                                                                               |
      | E           | G                       | E.L. In het Veld                       |                                                                                                                           |
      | N           | B                       | E.L. In het Veld-barones van den Aedel |                                                                                                                           |
      | V           | P                       | E.L. barones van den Aedel-In het Veld |                                                                                                                           |
      | P           | G                       | E.L. barones van den Aedel             |                                                                                                                           |
      | N           | R                       | E.L. In het Veld-van den Aedel         | adellijke titel heeft geen vorm die hoort bij de geslachtsaanduiding en wordt daarom niet opgenomen in de aanschrijfwijze |

  Rule: Bij geslachtsaanduiding 'onbekend' of geen waarde wordt de (eventuele) adellijke titel/predikaat niet opgenomen in de aanschrijfwijze

    Abstract Scenario: <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde                |
      | geslachtsaanduiding (04,10)          | <geslachtsaanduiding> |
      | voorvoegsel (02.30)                  |                       |
      | geslachtsnaam (02.40)                | Groenen               |
      | voornamen (02.10)                    | Franklin              |
      | aanduiding naamgebruik (61.10)       | E                     |
      | adellijke titel of predikaat (02.20) | <titel/predikaat>     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam            | waarde            |
      | aanschrijfwijze | <aanschrijfwijze> |

      Voorbeelden:
      | geslachtsaanduiding | titel/predikaat | aanschrijfwijze | titel                                 |
      | O                   | G               | F. Groenen      | Geslachtsaanduiding is 'onbekend' (O) |
      |                     | JH              | F. Groenen      | Geslachtsaanduiding heeft geen waarde |

  Rule: Predikaat van een partner wordt niet opgenomen in de aanschrijfwijze

    Abstract Scenario: partner heeft een predikaat
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde        |
      | voorvoegsel (02.30)            | van der       |
      | geslachtsnaam (02.40)          | Berg          |
      | voornamen (02.10)              | Sjaak         |
      | aanduiding naamgebruik (61.10) | <naamgebruik> |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde |
      | voorvoegsel (02.30)                  | van    |
      | geslachtsnaam (02.40)                | Hoogh  |
      | adellijke titel of predikaat (02.20) | JV     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam            | waarde            |
      | aanschrijfwijze | <aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | aanschrijfwijze           |
      | E           | S. van der Berg           |
      | N           | S. van der Berg-van Hoogh |
      | P           | S. van Hoogh-van der Berg |
      | V           | S. van Hoogh              |

  Rule: Bij personen met een adellijke titel met partner met een adellijk titel worden beide titels opgenomen in de aanschrijfwijze

    Abstract Scenario: persoon en partner hebben beide een adellijke titel
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                                 | waarde         |
      | voorvoegsel (02.30)                  | van den        |
      | geslachtsnaam (02.40)                | Aedel          |
      | voornamen (02.10)                    | Hendrik Willem |
      | adellijke titel of predikaat (02.20) | G              |
      | aanduiding naamgebruik (61.10)       | <naamgebruik>  |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                                 | waarde |
      | voorvoegsel (02.30)                  | van    |
      | geslachtsnaam (02.40)                | Hoogh  |
      | adellijke titel of predikaat (02.20) | BS     |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam            | waarde            |
      | aanschrijfwijze | <aanschrijfwijze> |

      Voorbeelden:
      | naamgebruik | aanschrijfwijze                          |
      | E           | H.W. graaf van den Aedel                 |
      | N           | H.W. graaf van den Aedel-baron van Hoogh |
      | P           | H.W. baron van Hoogh-graaf van den Aedel |
      | V           | H.W. baron van Hoogh                     |

  Rule: Bij meerdere actuele (niet ontbonden) huwelijken/partnerschappen wordt naam gegevens van de eerste partner (oudste relatie) gebruikt voor het samenstellen van de aanschrijfwijze

    Abstract Scenario: meerdere actuele relaties
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde             |
      | voorvoegsel (02.30)            |                    |
      | geslachtsnaam (02.40)          | Groen              |
      | voornamen (02.10)              | Ferdinand Cornelis |
      | aanduiding naamgebruik (61.10) | V                  |
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
      | datum aangaan (06.10) | 19610808 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam            | waarde          |
      | aanschrijfwijze | F.C. Geel-Groen |

  Rule: Bij meerdere huwelijken/partnerschappen die allen ontbonden zijn, wordt naam gegevens van de laatst ontbonden partner gebruikt voor het samenstellen van de aanschrijfwijze

    Scenario: meerdere ontbonden relaties gebruikt de laatst ontbonden relatie
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde |
      | voorvoegsel (02.30)            |        |
      | geslachtsnaam (02.40)          | Wit    |
      | voornamen (02.10)              | Jan    |
      | aanduiding naamgebruik (61.10) | V      |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   |        |
      | geslachtsnaam (02.40) | Geel   |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                     | waarde   |
      | datum aangaan (06.10)    | 19580401 |
      | datum ontbinding (07.10) | 19601001 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992936 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   |        |
      | geslachtsnaam (02.40) | Roodt  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                     | waarde   |
      | datum aangaan (06.10)    | 19610422 |
      | datum ontbinding (07.10) | 20061014 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam            | waarde       |
      | aanschrijfwijze | J. Roodt-Wit |

    Scenario: meerdere ontbonden relaties en oudste relatie is het laatst ontbonden
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992934 |
      En de persoon heeft de volgende naam gegevens
      | naam                           | waarde |
      | voorvoegsel (02.30)            |        |
      | geslachtsnaam (02.40)          | Wit    |
      | voornamen (02.10)              | Jan    |
      | aanduiding naamgebruik (61.10) | V      |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   |        |
      | geslachtsnaam (02.40) | Zwart  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                     | waarde   |
      | datum aangaan (06.10)    | 19580401 |
      | datum ontbinding (07.10) | 20061001 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992936 |
      En de partner heeft de volgende naam gegevens
      | naam                  | waarde |
      | voorvoegsel (02.30)   |        |
      | geslachtsnaam (02.40) | Blaauw |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                     | waarde   |
      | datum aangaan (06.10)    | 19610422 |
      | datum ontbinding (07.10) | 19831014 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | naam.aanschrijfwijze            |
      Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
      | naam            | waarde       |
      | aanschrijfwijze | J. Zwart-Wit |

  TODO: regelVoorafgaandAanAanschrijfwijze

  # Abstract Scenario: met voorvoegsel
  #   Gegeven het systeem heeft een persoon met de volgende gegevens
  #   | naam                | waarde    |
  #   | burgerservicenummer | 999992934 |
  #   En de persoon heeft de volgende naam gegevens
  #   | naam                           | waarde                    |
  #   | voorvoegsel (02.30)            | <voorvoegsel>             |
  #   | geslachtsnaam (02.40)          | <geslachtsnaam>           |
  #   | voornamen (02.10)              | <voornamen>               |
  #   | aanduiding naamgebruik (61.10) | <aanduidingAanschrijving> |
  #   En de persoon heeft een partner met de volgende gegevens
  #   | naam                | waarde    |
  #   | burgerservicenummer | 999992934 |
  #   En de partner heeft de volgende naam gegevens
  #   | naam                  | waarde                  |
  #   | voorvoegsel (02.30)   | <voorvoegsel partner>   |
  #   | geslachtsnaam (02.40) | <geslachtsnaam partner> |
  #   Als personen wordt gezocht met de volgende parameters
  #   | naam                | waarde                          |
  #   | type                | RaadpleegMetBurgerservicenummer |
  #   | burgerservicenummer | 999992934                       |
  #   | fields              | naam.aanschrijfwijze            |
  #   Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
  #   | naam            | waarde            |
  #   | aanschrijfwijze | <aanschrijfwijze> |

  #   Voorbeelden: met voorvoegsel
  #     | aanduidingAanschrijving | samenstelling aanschrijfwijze | voorvoegsel | geslachtsnaam | voornamen | voorvoegsel partner | geslachtsnaam partner | aanschrijfwijze           |
  #     | E                       | VL VV GN                      | In het      | Veld          | Henk      | van                 | Velzen                | H. In het Veld            |
  #     | N                       | VL VV GN-VP GP                | van         | Velzen        | Ingrid    | In het              | Veld                  | I. van Velzen-In het Veld |
  #     | P                       | VL VP GP                      | In het      | Veld          | Suzanne   | van                 | Velzen                | S. van Velzen             |
  #     | V                       | VL VP GP-VV GN                | van         | Velzen        | Fred      | In het              | Veld                  | F. In het Veld-van Velzen |

  # Abstract Scenario: zonder voorvoegsel
  #   Gegeven het systeem heeft een persoon met de volgende gegevens
  #   | naam                | waarde    |
  #   | burgerservicenummer | 999992934 |
  #   En de persoon heeft de volgende naam gegevens
  #   | naam                           | waarde                    |
  #   | voorvoegsel (02.30)            |                           |
  #   | geslachtsnaam (02.40)          | <geslachtsnaam>           |
  #   | voornamen (02.10)              | <voornamen>               |
  #   | aanduiding naamgebruik (61.10) | <aanduidingAanschrijving> |
  #   En de persoon heeft een partner met de volgende gegevens
  #   | naam                | waarde    |
  #   | burgerservicenummer | 999992934 |
  #   En de partner heeft de volgende naam gegevens
  #   | naam                  | waarde                  |
  #   | voorvoegsel (02.30)   |                         |
  #   | geslachtsnaam (02.40) | <geslachtsnaam partner> |
  #   Als personen wordt gezocht met de volgende parameters
  #   | naam                | waarde                          |
  #   | type                | RaadpleegMetBurgerservicenummer |
  #   | burgerservicenummer | 999992934                       |
  #   | fields              | naam.aanschrijfwijze            |
  #   Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
  #   | naam            | waarde            |
  #   | aanschrijfwijze | <aanschrijfwijze> |

  #   Voorbeelden: zonder voorvoegsel
  #     | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen          | geslachtsnaam partner | aanschrijfwijze     |
  #     | E                       | VL GN                         | Groenen       | Franklin           | Groenink              | F. Groenen          |
  #     | N                       | VL GN-GP                      | Groenen       | Franka             | Groenink              | F. Groenen-Groenink |
  #     | P                       | VL GP                         | Groenink      | Johan Frank Robert | Groenen               | J.F.R. Groenen      |
  #     | V                       | VL GP-GN                      | Groenlo       | Franka             | Groenen               | F. Groenen-Groenlo  |

  # Abstract Scenario: betrokkene heeft een adelijke titel en partner heeft geen adellijke titel
  #   Gegeven het systeem heeft een persoon met de volgende gegevens
  #   | naam                | waarde    |
  #   | burgerservicenummer | 999992934 |
  #   En de persoon heeft de volgende naam gegevens
  #   | naam                                 | waarde                          |
  #   | geslachtsaanduiding (04,10)          | <geslachtsaanduiding>           |
  #   | voorvoegsel (02.30)                  | <voorvoegsel>                   |
  #   | geslachtsnaam (02.40)                | <geslachtsnaam>                 |
  #   | voornamen (02.10)                    | <voornamen>                     |
  #   | aanduiding naamgebruik (61.10)       | <aanduidingAanschrijving>       |
  #   | adellijke titel of predikaat (02.20) | <adellijkeTitel_predikaat code> |
  #   En de persoon heeft een partner met de volgende gegevens
  #   | naam                | waarde    |
  #   | burgerservicenummer | 999992934 |
  #   En de partner heeft de volgende naam gegevens
  #   | naam                  | waarde                  |
  #   | voorvoegsel (02.30)   | <voorvoegsel partner>   |
  #   | geslachtsnaam (02.40) | <geslachtsnaam partner> |
  #   En de waardetabel 'Adellijke titel/predicaat' heeft de volgende waarden
  #   | code                            | omschrijving               |
  #   | <adellijkeTitel_predikaat code> | <adellijkeTitel_predikaat> |
  #   Als personen wordt gezocht met de volgende parameters
  #   | naam                | waarde                                                       |
  #   | type                | RaadpleegMetBurgerservicenummer                              |
  #   | burgerservicenummer | 999992934                                                    |
  #   | fields              | naam.aanschrijfwijze,naam.regelVoorafgaandAanAanschrijfwijze |
  #   Dan bevat de persoon met burgerservicenummer '999992934' de volgende 'naam' gegevens
  #   | naam            | waarde            |
  #   | aanschrijfwijze | <aanschrijfwijze> |
  #   # | regelVoorafgaandAanAanschrijfwijze | <regelVoorafgaandAanAanschrijfwijze> |

  #   Voorbeelden: betrokkene heeft een adelijke titel en partner heeft geen adellijke titel
  #   | geslachtsaanduiding | aanduidingAanschrijving | samenstelling aanschrijfwijze | adellijkeTitel_predikaat code | adellijkeTitel_predikaat | voorvoegsel | geslachtsnaam | voornamen      | voorvoegsel partner | geslachtsnaam partner | aanschrijfwijze                        | regelVoorafgaandAanAanschrijfwijze |
  #   | man                 | E                       | VL AT VV GN                   | B                             | Baron                    | van den     | Aedel         | Hendrik Willem | van der             | Veen                  | H.W. baron van den Aedel               | De hoogwelgeboren heer             |
  #   | vrouw               | N                       | VL AT VV GN-VP GP             | GI                            | Gravin                   | van den     | Aedel         | Wilhelmina     | van der             | Veen                  | W. gravin van den Aedel-van der Veen   | De hooggeboren vrouwe              |
  #   | vrouw               | P                       | VL VP GP                      | BS                            | Barones                  | van den     | Aedel         | Frederique     | van der             | Veen                  | F. van der Veen                        | -                                  |
  #   | vrouw               | V                       | VL VP GP-AT VV GN             | GI                            | Gravin                   | van den     | Aedel         | Emma Louise    | van der             | Veen                  | E.L. van der Veen-gravin van den Aedel | De hooggeboren vrouwe              |
  #   # | man                 | E                       | VL AT VV GN                   | BS                            | Barones                  | van den     | Aedel         | Johan          | van der             | Veen                  | J. baron van den Aedel                 | De hoogwelgeboren heer             |
  #   # | vrouw               | N                       | VL AT VV GN-VP GP             | G                             | Graaf                    | van den     | Aedel         | Wilhelmina     | van der             | Veen                  | W. gravin van den Aedel-van der Veen   | De hooggeboren vrouwe              |
  #   # | vrouw               | P                       | VL VP GP                      | BS                            | Barones                  | van den     | Aedel         | Frederique     | van der             | Veen                  | F. van der Veen                        | -                                  |
  #   # | vrouw               | V                       | VL VP GP-AT VV GN             | B                             | Baron                    | van den     | Aedel         | Erica          | van der             | Veen                  | E. van der Veen-barones van den Aedel  | De hoogwelgeboren vrouwe           |
  #   # | vrouw               | E                       | VL AT VV GN                   | R                             | Ridder                   | van den     | Aedel         | Michael        | van der             | Veen                  | M. van den Aedel                       | -                                  |
  #   # | onbekend            | E                       | VL VV GN                      | BS                            | Barones                  | van den     | Aedel         | Johanna        | van der             | Veen                  | J. van den Aedel                       | -                                  |
  #   # | onbekend            | V                       | VL VP GP-AT VV GN             | R                             | Ridder                   | van den     | Aedel         | Simon          | van der             | Veen                  | S. van der Veen-van den Aedel          | -                                  |

  #   Als persoon wordt geraadpleegd
  #   Dan heeft de gevonden persoon naam.aanschrijfwijze=<aanschrijfwijze>




  #   Voorbeelden: betrokkene heeft een predikaat en partner heeft geen adellijke titel
  #     | geslacht | adellijkeTitel_predikaat | aanduidingNaamgebruik | partner | Ontbinding huwelijk/geregistreerd partnerschap | aanschrijfwijze                    | regelVoorafgaandAanAanschrijfwijze |
  #     | man      | Jonkheer                 | Eigen                 | Geen    | Geen                                           | Jonkheer T. van Hoogh              | De hoogwelgeboren heer             |
  #     | man      | Jonkheer                 | Eigen                 | Ja      | Geen                                           | Jonkheer T. van Hoogh              | De hoogwelgeboren heer             |
  #     | vrouw    | Jonkvrouw                | Eigen                 | Geen    | Geen                                           | Jonkvrouw T. van Hoogh             | De hoogwelgeboren vrouwe           |
  #     | vrouw    | Jonkvrouw                | Eigen                 | Ja      | Geen                                           | Jonkvrouw T. van Hoogh             | -                                  |
  #     | vrouw    | Jonkvrouw                | Eigen                 | Ja      | Ja                                             | Jonkvrouw T. van Hoogh             | De hoogwelgeboren vrouwe           |
  #     | vrouw    | Jonkheer                 | Eigen                 | Geen    | Geen                                           | Jonkvrouw T. van Hoogh             | De hoogwelgeboren vrouwe           |
  #     | vrouw    | Jonkheer                 | Eigen                 | Ja      | Geen                                           | Jonkvrouw T. van Hoogh             | -                                  |
  #     | onbekend | Jonkvrouw                | Eigen                 | Geen    | Geen                                           | T. van Hoogh                       | -                                  |
  #     | vrouw    | Jonkvrouw                | Partner na eigen      | Ja      | Geen                                           | Jonkvrouw T. van Hoogh-in het Veld | -                                  |
  #     | vrouw    | Jonkvrouw                | Partner na eigen      | Ja      | Ja                                             | Jonkvrouw T. van Hoogh-in het Veld | -                                  |
  #     | man      | Jonkheer                 | Partner na eigen      | Ja      | Geen                                           | Jonkheer T. van Hoogh-in het Veld  | De hoogwelgeboren heer             |
  #     | vrouw    | Jonkvrouw                | Partner               | Ja      | Geen                                           | T. in het Veld                     | -                                  |
  #     | vrouw    | Jonkvrouw                | Partner               | Ja      | Ja                                             | T. in het Veld                     | -                                  |
  #     | man      | Jonkheer                 | Partner               | Geen    | Geen                                           | T. in het Veld                     | -                                  |
  #     | vrouw    | Jonkvrouw                | Partner voor eigen    | Ja      | Geen                                           | T. in het Veld-jonkvrouw van Hoogh | -                                  |
  #     | vrouw    | Jonkheer                 | Partner voor eigen    | Ja      | Geen                                           | T. in het Veld-jonkvrouw van Hoogh | -                                  |
  #     | man      | Jonkvrouw                | Partner voor eigen    | Ja      | Geen                                           | T. in het Veld-jonkheer van Hoogh  | De hoogwelgeboren heer             |
  #     | onbekend | Jonkvrouw                | Partner voor eigen    | Ja      | Geen                                           | T. in het Veld-van Hoogh           | -                                  |

  #   Voorbeelden: partner heeft een adellijke titel
  #     | geslachtsaanduiding | geslachtsaanduiding partner | adellijkeTitel_predikaat partner | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen     | aanschrijfwijze                         | regelVoorafgaandAanAanschrijfwijze |
  #     | vrouw               | man                         | Baron                            | E                       | VL VV GN                      | Veen          | Anna Cornelia | A.C. van der Veen                       | -                                  |
  #     | vrouw               | man                         | Baron                            | N                       | VL VV GN-AP VP GP             | Veen          | Anna Cornelia | A.C. van der Veen-barones van den Aedel | -                                  |
  #     | vrouw               | man                         | Baron                            | P                       | VL AP VP GP                   | Veen          | Anna Cornelia | A.C. barones van den Aedel              | -                                  |
  #     | vrouw               | man                         | Baron                            | P                       | VL AP VP GP                   | Veen          | Anna Cornelia | A.C. barones van den Aedel              | -                                  |
  #     | vrouw               | man                         | Baron                            | V                       | VL AP VP GP-VV GN             | Veen          | Anna Cornelia | A.C. barones van den Aedel-van der Veen | -                                  |
  #     | vrouw               | man                         | Prins                            | E                       | VL VV GN                      | Veen          | Anna Cornelia | A.C. van der Veen                       | -                                  |
  #     | vrouw               | man                         | Prins                            | N                       | VL VV GN-AP VP GP             | Veen          | Anna Cornelia | A.C. van der Veen-prinses van den Aedel | -                                  |
  #     | vrouw               | man                         | Prins                            | P                       | VL AP VP GP                   | Veen          | Anna Cornelia | A.C. prinses van den Aedel              | -                                  |
  #     | vrouw               | man                         | Prins                            | V                       | VL AP VP GP-VV GN             | Veen          | Anna Cornelia | A.C. prinses van den Aedel-van der Veen | -                                  |
  #     | man                 | vrouw                       | Gravin                           | E                       | VL VV GN                      | Veen          | Johannes      | J. van der Veen                         | -                                  |
  #     | man                 | vrouw                       | Gravin                           | N                       | VL VV GN-VP GP                | Veen          | Johannes      | J. van der Veen-van den Aedel           | -                                  |
  #     | man                 | vrouw                       | Gravin                           | P                       | VL VP GP                      | Veen          | Johannes      | J. van den Aedel                        | -                                  |
  #     | man                 | vrouw                       | Gravin                           | V                       | VL VP GP-VV GN                | Veen          | Johannes      | J. van den Aedel-van der Veen           | -                                  |
  #     | vrouw               | man                         | Ridder                           | E                       | VL VV GN                      | Veen          | Marlies       | M. van der Veen                         | -                                  |
  #     | vrouw               | man                         | Ridder                           | N                       | VL VV GN-VP GP                | Veen          | Marlies       | M. van der Veen-van den Aedel           | -                                  |
  #     | vrouw               | man                         | Ridder                           | P                       | VL VP GP                      | Veen          | Marlies       | M. van den Aedel                        | -                                  |
  #     | vrouw               | man                         | Ridder                           | V                       | VL VP GP-VV GN                | Veen          | Marlies       | M. van den Aedel-van der Veen           | -                                  |
  #     | vrouw               | vrouw                       | Gravin                           | E                       | VL VV GN                      | Veen          | Sarah         | S. van der Veen                         | -                                  |
  #     | vrouw               | vrouw                       | Gravin                           | N                       | VL VV GN-VP GP                | Veen          | Sarah         | S. van der Veen-van den Aedel           | -                                  |
  #     | vrouw               | vrouw                       | Gravin                           | V                       | VL VP GP-VV GN                | Veen          | Sarah         | S. van den Aedel-van der Veen           | -                                  |
  #     | man                 | man                         | Baron                            | E                       | VL VV GN                      | Veen          | Willem        | W. van der Veen                         | -                                  |
  #     | man                 | man                         | Baron                            | N                       | VL VV GN-VP GP                | Veen          | Willem        | W. van der Veen-van den Aedel           | -                                  |
  #     | man                 | man                         | Baron                            | P                       | VL VP GP                      | Veen          | Willem        | W. van den Aedel                        | -                                  |
  #     | man                 | man                         | Baron                            | V                       | VL VP GP-VV GN                | Veen          | Willem        | W. van den Aedel-van der Veen           | -                                  |
  #     | onbekend            | man                         | Baron                            | P                       | VL AP VP GP                   | Veen          | Anna Cornelia | A.C. van den Aedel                      | -                                  |
  #     | vrouw               | onbekend                    | Baron                            | P                       | VL AP VP GP                   | Veen          | Anna Cornelia | A.C. van den Aedel                      | -                                  |

  #   Voorbeelden: partner heeft een predikaat
  #     | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen | aanschrijfwijze           | regelVoorafgaandAanAanschrijfwijze |
  #     | E                       | VL VV GN                      | Berg          | Sjaak     | S. van der Berg           | -                                  |
  #     | N                       | VL VV GN-VP GP                | Berg          | Peter     | P. van der Berg-van Hoogh | -                                  |
  #     | P                       | VL VP GP                      | Berg          | Marlies   | M. van Hoogh              | -                                  |
  #     | V                       | VL VP GP-VV GN                | Berg          | Fleur     | F. van Hoogh-van der Berg | -                                  |

  #   Voorbeelden: betrokkene heeft een adelijke titel en partner heeft een adellijke titel
  #     | aanduidingAanschrijving | samenstelling aanschrijfwijze | geslachtsnaam | voornamen      | aanschrijfwijze                             | regelVoorafgaandAanAanschrijfwijze |
  #     | E                       | VL AT VV GN                   | Aedel         | Hendrik Willem | H.W. graaf van den Aedel                    | De hooggeboren heer                |
  #     | N                       | VL AT VV GN-AP VP GP          | Aedel         | Wilhelmina     | W. gravin van den Aedel-barones van Hoogh   | De hooggeboren vrouwe              |
  #     | P                       | VL AP VP GP                   | Aedel         | Frederique     | F. barones van Hoogh                        | -                                  |
  #     | V                       | VL AP VP GP-AT VV GN          | Aedel         | Emma Louise    | E.L. barones van Hoogh-gravin van den Aedel | De hooggeboren vrouwe              |

  # Scenario: meerdere actuele relaties
  #   Gegeven de persoon F.C. Groen is getrouwd in 1958 met Geel
  #   En de persoon is getrouwd in 1961 met Roodt
  #   En geen van beide relaties is beëindigd
  #   En de persoon heeft aanduidingAanschrijving='V'
  #   Als de persoon wordt geraadpleegd
  #   Dan is in het antwoord naam.aanschrijfwijze=F.C. Geel-Groen

  # Scenario: meerdere ontbonden relaties gebruikt de laatst ontbonden relatie
  #   Gegeven de persoon J. Wit is getrouwd in 1958 met Geel
  #   En de persoon is getrouwd in 1961 met Roodt
  #   En het huwelijk met Geel is ontbonden in 1960
  #   En het huwelijk met Roodt is ontbonden in 2006
  #   En de persoon heeft aanduidingAanschrijving='V'
  #   Als de persoon wordt geraadpleegd
  #   Dan is in het antwoord naam.aanschrijfwijze=J. Roodt-Wit

  # Scenario: meerdere ontbonden relaties en oudste relatie is het laatst ontbonden
  #   Gegeven de persoon de heer J. Wit is getrouwd in 1958 met Zwart
  #   En de persoon is getrouwd in 1961 met Blaauw
  #   En het huwelijk met Blaauw is ontbonden in 1983
  #   En het huwelijk met Zwart is ontbonden in 2006
  #   En de persoon heeft aanduidingAanschrijving='V'
  #   Als de persoon wordt geraadpleegd
  #   Dan is in het antwoord naam.aanhef=J. Zwart-Wit
