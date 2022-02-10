#language: nl

Functionaliteit: Zoek met geslachtsnaam en geboortedatum

Rule: Geslachtsnaam en geboortedatum zijn verplichte parameters

    Scenario: Zoek met valide geslachtsnaam en geboortedatum

        Gegeven het systeem heeft een persoon met de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 999995078 |
        En de persoon heeft de volgende geboorte gegevens
        | naam        | waarde   |
        | datum.type  | GbaDatum |
        | datum.datum | 19830526 |
        En de persoon heeft de volgende naam gegevens
        | naam                  | waarde  |
        | geslachtsnaam (02.40) | Maassen |
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | Maassen                             |
        | geboortedatum | 1983-05-26                          |
        | fields        | burgerservicenummer                 |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995078           |
        En bevat de persoon met burgerservicenummer '999995078' de volgende geboorte gegevens
        | naam        | waarde     |
        | datum.type  | Datum      |
        | datum.datum | 1983-05-26 |
        En bevat de persoon met burgerservicenummer '999995078' de volgende naam gegevens
        | naam          | waarde  |
        | geslachtsnaam | Maassen |

    @fout-case
    Abstract Scenario: <titel>
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                              |
        | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
        | geslachtsnaam | <geslachtsnaam>                     |
        | geboortedatum | <geboortedatum>                     |
        | fields        | burgerservicenummer                 |
        Dan bevat de response de volgende gegevens
        | naam     | waarde                                        |
        | title    | Één of meerdere parameters zijn niet correct. |
        | status   | 400                                           |
        | detail   | TODO                                          |
        | code     | TODO                                          |
        | instance | TODO                                          |
        En bevat de response een invalidParams met de volgende gegevens
        | code | name | reason |
        | TODO | TODO | TODO   |

        Voorbeelden:
        | geslachtsnaam | geboortedatum | titel                                      |
        |               |               | Zoek zonder geslachtsnaam en geboortedatum |
        | Maassen       |               | Zoek met alleen valide geslachtsnaam       |
        |               | 1983-05-26    | Zoek met alleen valide geboortedatum       |
        
Scenario: Zoek met geslachtsnaam, geboortedatum en voornamen

Scenario: Zoek met geslachtsnaam, geboortedatum, voornamen, geboorteplaats, geslachtsaanduiding, gemeenteVanInschrijving

Scenario: Zoek met geslachtsnaam, geboortedatum en postcode

Scenario: Zoek met geslachtsnaam, geboortedatum en identificatienummeraanduiding
