#language: nl

Functionaliteit: Zoek met geslachtsnaam en geboortedatum

Scenario: Zoek met valide geslachtsnaam en geboortedatum

    Gegeven in de BRP is een persoon met de volgende gegevens geregistreerd
    | burgerservicenummer |
    | 999995078           |
    En met de volgende naam gegevens
    | geslachtsnaam |
    | Maassen       |
    En met de volgende geboorte gegevens
    | datum    |
    | 19830526 |
    Als personen wordt gezocht met POST '/ingeschrevenpersonen'
    """
    {
        "type": "ZoekMetGeslachtsnaamEnGeboortedatum",
        "fields": "burgerservicenummer",
        "geslachtsnaam": "Maassen",
        "geboortedatum": "1983-05-26"
    }
    """
    Dan bevat de response alleen de volgende personen
    | burgerservicenummer |
    | 999999321           |
