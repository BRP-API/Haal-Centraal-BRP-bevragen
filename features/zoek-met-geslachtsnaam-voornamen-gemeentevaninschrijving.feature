#language: nl

Functionaliteit: Zoek met geslachtsnaam, voornamen en gemeente van inschrijving

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer |
    | 999995078           |
    | 999995082           |
    En het systeem heeft personen met de volgende 'naam' gegevens
    | burgerservicenummer | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
    | 999995078           | Maassen               | Pieter            |                     |
    | 999995082           | Maassen               | Jan Peter         | van                 |
    En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
    | burgerservicenummer | gemeente van inschrijving (09.10) |
    | 999995078           | 0014                              |
    | 999995082           | 0014                              |
    
Rule: Geslachtsnaam, voornamen en gemeenteVanInschrijving zijn verplichte parameters

  Scenario: Zoek met valide geslachtsnaam, voornamen en gemeenteVanInschrijving
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | maassen                              |
    | voornamen               | pieter                               |
    | gemeenteVanInschrijving | 0014                                 |
    | fields                  | burgerservicenummer                  |
    Dan bevat de response alleen personen met de volgende gegevens 
    | burgerservicenummer |
    | 999995078           |
