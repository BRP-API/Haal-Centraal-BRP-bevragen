#language: nl

@post-assert
Functionaliteit: Zoek met geslachtsnaam, voornamen en gemeente van inschrijving

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer | geslachtsaanduiding (04.10) |
    | 999995078           | M                           |
    | 999995082           | M                           |
    | 999995086           | V                           |
    | 999995088           | M                           |
    En het systeem heeft personen met de volgende 'naam' gegevens
    | burgerservicenummer | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
    | 999995078           | Maassen               | Pieter            |                     |
    | 999995082           | Maassen               | Jan Peter         | van                 |
    | 999995086           | Os                    | Miriam            |                     |
    | 999995088           | Maassen               | Jan Peter         |                     |
    En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
    | burgerservicenummer | gemeente van inschrijving (09.10) |
    | 999995078           | 0014                              |
    | 999995082           | 0014                              |
    | 999995086           | 0015                              |
    | 999995088           | 0014                              |
    
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
