#language: nl

Functionaliteit: Zoek met geslachtsnaam en gemeente van inschrijving

Rule: Geslachtsnaam en gemeenteVanInschrijving zijn verplichte parameters

    Scenario: Zoek met valide geslachtsnaam en gemeenteVanInschrijving

        Gegeven het systeem heeft een persoon met de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 999995078 |
        En de persoon heeft de volgende naam gegevens
        | naam          | waarde |
        | geslachtsnaam | Groen  |
        En de persoon heeft de volgende verblijfplaats gegevens
        | naam                    | waarde |
        | gemeenteVanInschrijving | 0014   |
        Als personen wordt gezocht met de volgende parameters
        | naam                    | waarde                                        |
        | type                    | ZoekMetGeslachtsnaamEnGemeenteVanInschrijving |
        | geslachtsnaam           | groen                                         |
        | gemeenteVanInschrijving | 0014                                          |
        | fields                  | burgerservicenummer                           |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995078           |
        En bevat de persoon met burgerservicenummer '999995078' de volgende naam gegevens
        | naam          | waarde |
        | geslachtsnaam | Groen  |
