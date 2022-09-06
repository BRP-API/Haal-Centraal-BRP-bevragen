#language: nl

@post-assert
Functionaliteit: Zoek met geslachtsnaam, voornamen en gemeente van inschrijving

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer | geslachtsaanduiding (04.10) | gemeente van inschrijving (09.10) |
    | 999995078           | M                           | 0014                              |
    | 999995082           | M                           | 0014                              |
    | 999995086           | V                           | 0015                              |
    | 999995088           | M                           | 0014                              |
    En het systeem heeft personen met de volgende 'naam' gegevens
    | burgerservicenummer | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
    | 999995078           | Maassen               | Pieter            |                     |
    | 999995082           | Maassen               | Jan Peter         | van                 |
    | 999995086           | Os                    | Miriam            |                     |
    | 999995088           | Maassen               | Jan Peter         |                     |
    
Rule: Geslachtsnaam, voornamen en gemeenteVanInschrijving zijn verplichte parameters
      Zoeken is niet hoofdlettergevoelig

  Abstract Scenario: Zoek met volledige geslachtsnaam, voornamen en gemeenteVanInschrijving
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | <geslachtsnaam>                      |
    | voornamen               | <voornamen>                          |
    | gemeenteVanInschrijving | 0014                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |

    Voorbeelden:
    | geslachtsnaam | voornamen |
    | Maassen       | Pieter    |
    | MAASSEN       | PIETER    |
    | MAASSEN       | pieter    |

  Scenario: Zoek met geslachtsnaam van twee karakters lang
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | os                                   |
    | voornamen               | Miriam                               |
    | gemeenteVanInschrijving | 0015                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995086 |

  Abstract Scenario: Zoek met volledige voorvoegsel
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | Maassen                              |
    | voornamen               | Jan Peter                            |
    | voorvoegsel             | <voorvoegsel>                        |
    | gemeenteVanInschrijving | 0014                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995082 |

    Voorbeelden:
    | voorvoegsel |
    | van         |
    | Van         |
    | VAN         |


Rule: een afgevoerde persoonslijst moet niet worden gevonden
  - wanneer reden opschorting bijhouding (07.67.20) is opgenomen met de waarde "F" (fout), moet deze persoon(slijst) niet worden gevonden bij zoeken

  Scenario: Zoek met geslachtsnaam en gemeente van inschrijving van persoon op afgevoerde persoonslijst
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft de volgende 'persoon' gegevens
    | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
    | 000000012                   | Isnietgoed            |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam              | Isnietgoed                           |
    | gemeenteVanInschrijving    | 0530                                 |
    | inclusiefOverledenPersonen | true                                 |
    | fields                     | burgerservicenummer                  |
    Dan heeft de response 0 personen

  Abstract Scenario: Zoek met geslachtsnaam en gemeente van inschrijving van persoon op opgeschorte persoonslijst
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    En de persoon heeft de volgende 'persoon' gegevens
    | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
    | 000000024                   | Iswelgoed             |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0530                              |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam              | Iswelgoed                            |
    | gemeenteVanInschrijving    | <gemeente van inschrijving>          |
    | inclusiefOverledenPersonen | true                                 |
    | fields                     | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

    Voorbeelden:
    | gemeente van inschrijving | reden opschorting bijhouding | reden opschorting omschrijving |
    | 0530                      | O                            | overlijden                     |
    | 0530                      | E                            | emigratie                      |
    | 0530                      | M                            | ministerieel besluit           |
    | 1999                      | R                            | pl is aangelegd in de rni      |
    | 0530                      | .                            | onbekend                       |
