# language: nl
Functionaliteit: persoon/persoon beperkt velden vragen met fields
  Als afnemer van de BRP API
  Wil ik kunnen aangeven welke velden van de gevraagde persoon/personen moet worden geleverd
  Zodat ik alleen de velden krijg waarvoor ik doelbinding heb en tegelijk bijdraag data minimalisatie

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | anummer (01.10) | voornamen (02.10) | geslachtsnaam (02.40) | aanduiding naamgebruik (61.10) | geslachtsaanduiding (04.10) | geboortedatum (03.10) |
      |      1234567890 | Yvonne Johanna    | Kierkegaarde          | E                              | V                           |              19561115 |
    En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) |
      |                   999992971 | Robert            | Bronwaßer             |

  Regel: Alleen met fields gevraagde velden worden geleverd

    Scenario: de 'root' veld van een persoon wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | aNummer                         |
      Dan heeft de response een persoon met alleen de volgende gegevens
        | naam    | waarde     |
        | aNummer | 1234567890 |

    Scenario: de 'root' veld van een 'persoon beperkt' wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | Kierkegaarde                        |
        | geboortedatum |                          1956-11-15 |
        | fields        | burgerservicenummer                 |
      Dan heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 000000152 |

    Scenario: meerdere 'root' velden van een persoon wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | aNummer,burgerservicenummer     |
      Dan heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde     |
        | aNummer             | 1234567890 |
        | burgerservicenummer |  000000152 |

    Scenario: alle velden van een 'gegevensgroep' veld van een persoon wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | naam                            |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
        | naam                               | waarde                      |
        | voornamen                          | Yvonne Johanna              |
        | geslachtsnaam                      | Kierkegaarde                |
        | voorletters                        | Y.J.                        |
        | volledigeNaam                      | Yvonne Johanna Kierkegaarde |
        | aanduidingNaamgebruik.code         | E                           |
        | aanduidingNaamgebruik.omschrijving | eigen geslachtsnaam         |

    Scenario: alle velden van een 'gegevensgroep' veld van een 'persoon beperkt' wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | Kierkegaarde                        |
        | geboortedatum |                          1956-11-15 |
        | fields        | naam                                |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
        | naam          | waarde                      |
        | voornamen     | Yvonne Johanna              |
        | geslachtsnaam | Kierkegaarde                |
        | voorletters   | Y.J.                        |
        | volledigeNaam | Yvonne Johanna Kierkegaarde |

  Regel: Het volledige pad van een veld is de samenvoeging van de naam van het veld en de namen van zijn 'ouder' velden met een '.' karakter tussen de veld namen

    Scenario: een veld van een 'gegevensgroep' veld van een persoon wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | naam.geslachtsnaam              |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
        | naam          | waarde       |
        | geslachtsnaam | Kierkegaarde |

    Scenario: meerdere velden van een 'gegevensgroep' veld van een persoon wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer |                         000000152 |
        | fields              | naam.geslachtsnaam,naam.voornamen |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
        | naam          | waarde         |
        | geslachtsnaam | Kierkegaarde   |
        | voornamen     | Yvonne Johanna |

    Scenario: velden van meerdere 'gegevensgroepen' van een persoon wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                            |
        | type                | RaadpleegMetBurgerservicenummer   |
        | burgerservicenummer |                         000000152 |
        | fields              | naam.geslachtsnaam,geboorte.datum |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
        | naam          | waarde       |
        | geslachtsnaam | Kierkegaarde |
      En heeft de persoon de volgende 'geboorte' gegevens
        | naam              | waarde           |
        | datum.type        | Datum            |
        | datum.datum       |       1956-11-15 |
        | datum.langFormaat | 15 november 1956 |

    Scenario: een veld van een 'gegevensgroep collectie' veld van een persoon wordt gevraagd
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | partners.burgerservicenummer    |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 999992971 |

  Regel: Een veld waarvan het volledig pad deels overeenkomt met een opgegeven veld pad wordt niet geleverd

    Scenario: het opgegeven pad is het volledig pad van het voornamen veld én een deel van het volledig pad van het voornamen veld van de partner/ouder/kind velden van de persoon
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | naam.voornamen                  |
      Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
        | naam      | waarde         |
        | voornamen | Yvonne Johanna |

  Regel: Een gevraagd veld zonder waarde wordt niet geleverd

    Scenario: het gevraagde veld heeft geen waarde
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | naam.adellijkeTitelPredicaat    |
      Dan heeft de response een persoon zonder 'naam' gegevens
