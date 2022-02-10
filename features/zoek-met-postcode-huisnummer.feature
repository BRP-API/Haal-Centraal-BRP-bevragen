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

Scenario: Zoek met valide postcode, huisnummer, voornamen, geboortedatum, geboorteplaats, geslachtsaanduiding, gemeenteVanInschrijving, huisletter, huisnummertoevoeging

Scenario: Zoek met valide postcode, huisnummer, gemeentevaninschrijving, naamopenbareruimte(?) en identificatienummeraanduiding