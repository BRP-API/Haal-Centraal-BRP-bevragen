#language: nl

@gba
Functionaliteit: opschorting bijhouding

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 0123456789      | William           | de                  | Vries                 | 20040526              | M                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft een ouder '1' met de volgende gegevens
    | burgerservicenummer (01.20) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 000000036                   | Corry             | van                 | Zon                   | 19730428              | V                           |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 20040603                        |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | functie adres (10.10) | datum aanvang adreshouding (10.30) | gemeente van inschrijving (09.10) |
    | W                     | 20170423                           | 0518                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
    | 0518                 | Spui               | 70                 | 1234AA           |

Rule: bij het raadplegen van een persoon met afgevoerde persoonslijst wordt de reden opschorting geleverd en indien gevraagd de aNummer, burgerservicenummer en datum opschorting
    Een afgevoerde persoonslijst heeft opschorting bijhouding reden "F" (fout)

  Abstract Scenario: geraadpleegde persoon is opgeschort met reden "F" (fout) en veld(en) '<fields>' wordt gevraagd 
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam          | waarde          |
    | <naam veld 1> | <waarde veld 1> |
    En heeft de persoon de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde          |
    | reden.code         | F               |
    | reden.omschrijving | fout            |
    | <naam veld 2>      | <waarde veld 2> |

    Voorbeelden:
    | fields                                  | naam veld 1         | waarde veld 1 | naam veld 2 | waarde veld 2 |
    | aNummer                                 | aNummer             | 0123456789    |             |               |
    | burgerservicenummer                     | burgerservicenummer | 000000024     |             |               |
    | opschortingBijhouding                   |                     |               | datum       | 20220829      |
    | opschortingBijhouding.datum             |                     |               | datum       | 20220829      |
    | opschortingBijhouding.datum.type        |                     |               | datum       | 20220829      |
    | opschortingBijhouding.datum.datum       |                     |               | datum       | 20220829      |
    | opschortingBijhouding.datum.langFormaat |                     |               | datum       | 20220829      |
    | opschortingBijhouding.datum.jaar        |                     |               | datum       | 20220829      |
    | opschortingBijhouding.datum.maand       |                     |               | datum       | 20220829      |
    | opschortingBijhouding.datum.onbekend    |                     |               | datum       | 20220829      |

  Abstract Scenario: geraadpleegde persoon is opgeschort met reden "F" (fout) en veld(en) '<fields>' wordt gevraagd 
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde |
    | reden.code         | F      |
    | reden.omschrijving | fout   |

    Voorbeelden:
    | fields                  |
    | geboorte                |
    | gemeenteVanInschrijving |
    | geslacht                |
    | leeftijd                |
    | naam                    |
    | nationaliteiten         |
    | ouders                  |
    | verblijfplaats          |

  Abstract Scenario: geraadpleegde persoon is opgeschort met reden "<opschorting>" en met fields gevraagde velden worden wel geleverd 
    Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
    | anummer (01.10) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
    | 9876543210      | Anna              | Maassen               | 19630716              | V                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <opschorting>                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                 |
    | type                | RaadpleegMetBurgerservicenummer        |
    | burgerservicenummer | 000000048                              |
    | fields              | geboorte.datum,geslacht,naam.voornamen |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde   |
    | geboorte.datum        | 19630716 |
    | geslacht.code         | V        |
    | geslacht.omschrijving | vrouw    |
    | naam.voornamen        | Anna     |
    En heeft de persoon de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde                     |
    | reden.code         | <opschorting>              |
    | reden.omschrijving | <opschorting omschrijving> |

    Voorbeelden:
    | opschorting | opschorting omschrijving  |
    | O           | overlijden                |
    | E           | emigratie                 |
    | M           | ministerieel besluit      |
    | R           | pl is aangelegd in de rni |
    | .           | onbekend                  |
    
