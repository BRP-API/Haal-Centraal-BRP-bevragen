#language: nl

@gba
Functionaliteit: Zoek met geslachtsnaam, voornamen en gemeente van inschrijving

Regel: voorvoegsel is niet hoofdlettergevoelig

  Scenario: Zoek een persoon met volledige voorvoegsel in hoofdletters
    Gegeven de persoon met burgerservicenummer '000000025' heeft de volgende gegevens
    | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
    | Maassen               | Jan Peter         | van                 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0014                              |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | Maassen                              |
    | voornamen               | Jan Peter                            |
    | voorvoegsel             | VAN                                  |
    | gemeenteVanInschrijving | 0014                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000025 |

  Scenario: Voorvoegsel hoeft geen geldig voorvoegsel in tabel 36 Voorvoegsels te zijn
    Gegeven de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
    | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
    | Maassen               | Jan Peter         | Iets                |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0014                              |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | Maassen                              |
    | voornamen               | Jan Peter                            |
    | voorvoegsel             | iets                                 |
    | gemeenteVanInschrijving | 0014                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000048 |
