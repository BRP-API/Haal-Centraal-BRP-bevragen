#language: nl

Functionaliteit: Zoek met burgerservicenummer(s)

Scenario: Zoek met valide burgerservicenummer

    Gegeven in de BRP is een persoon met de volgende gegevens geregistreerd
    | burgerservicenummer |
    | 999999321           |
    Als personen wordt gezocht met POST '/ingeschrevenpersonen'
    """
    {
        "type": "ZoekMetBurgerservicenummer",
        "fields": "burgerservicenummer",
        "burgerservicenummer": ["999999321"]
    }
    """
    Dan bevat de response alleen de volgende personen
    | burgerservicenummer |
    | 999999321           |
