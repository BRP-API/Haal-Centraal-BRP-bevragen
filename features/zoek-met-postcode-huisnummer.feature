#language: nl

Functionaliteit: Zoek met postcode en huisnummer

Rule: Postcode en huisnummer zijn verplichte parameters

    Scenario: Zoek met valide postcode en huisnummer
        Gegeven het systeem heeft een persoon met de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 999995078 |
        En de persoon heeft de volgende verblijfplaats gegevens
        | naam       | waarde |
        | postcode   | 2628HJ |
        | huisnummer | 2      |
        Als personen wordt gezocht met de volgende parameters
        | naam       | waarde                      |
        | type       | ZoekMetPostcodeEnHuisnummer |
        | postcode   | 2628HJ                      |
        | huisnummer | 2                           |
        | fields     | burgerservicenummer         |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995078           |

    Scenario: Zoek met huisletter
        Gegeven het systeem heeft een persoon met de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 999995078 |
        En de persoon heeft de volgende verblijfplaats gegevens
        | naam       | waarde |
        | postcode   | 2628HJ |
        | huisnummer | 3      |
        | huisletter | A      |
        Als personen wordt gezocht met de volgende parameters
        | naam       | waarde                      |
        | type       | ZoekMetPostcodeEnHuisnummer |
        | postcode   | 2628HJ                      |
        | huisnummer | 3                           |
        | huisletter | A                           |
        | fields     | burgerservicenummer         |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995078           |

    Scenario: Zoek met huisnummertoevoeging
        Gegeven het systeem heeft een persoon met de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 999995078 |
        En de persoon heeft de volgende verblijfplaats gegevens
        | naam                 | waarde |
        | postcode             | 2628HJ |
        | huisnummer           | 4      |
        | huisnummertoevoeging | to     |
        Als personen wordt gezocht met de volgende parameters
        | naam                 | waarde                      |
        | type                 | ZoekMetPostcodeEnHuisnummer |
        | postcode             | 2628HJ                      |
        | huisnummer           | 4                           |
        | huisnummertoevoeging | to                          |
        | fields               | burgerservicenummer         |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995078           |

    Scenario: Zoek met geslachtsnaam
        Gegeven het systeem heeft een persoon met de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 999995078 |
        En de persoon heeft de volgende naam gegevens
        | naam                  | waarde  |
        | geslachtsnaam (02.40) | Maassen |
        En de persoon heeft de volgende verblijfplaats gegevens
        | naam       | waarde |
        | postcode   | 2628HJ |
        | huisnummer | 5      |
        Als personen wordt gezocht met de volgende parameters
        | naam          | waarde                      |
        | type          | ZoekMetPostcodeEnHuisnummer |
        | postcode      | 2628HJ                      |
        | huisnummer    | 5                           |
        | geslachtsnaam | Maassen                     |
        | fields        | burgerservicenummer         |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999995078           |
