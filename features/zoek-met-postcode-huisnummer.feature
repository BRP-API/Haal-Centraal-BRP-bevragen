#language: nl

Functionaliteit: Zoek met postcode en huisnummer

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer |
    | 999995078           |
    | 999995079           |
    | 999995080           |
    | 999995082           |
    En het systeem heeft personen met de volgende 'naam' gegevens
    | burgerservicenummer | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
    | 999995082           | Maassen               | Jan Peter         | van                 |
    En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
    | burgerservicenummer | postcode (11.60) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) |
    | 999995078           | 2628HJ           | 2                  |                    |                              |
    | 999995079           | 2628HJ           | 3                  | A                  |                              |
    | 999995080           | 2628HJ           | 4                  |                    | to                           |
    | 999995082           | 2628HJ           | 5                  |                    |                              |

Rule: Postcode en huisnummer zijn verplichte parameters

  Scenario: Zoek met valide postcode en huisnummer
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | 2                           |
    | fields     | burgerservicenummer         |
    Dan bevat de response alleen personen met de volgende gegevens 
    | burgerservicenummer |
    | 999995078           |

  @skip-verify
  Scenario: Zoek met huisletter
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | 3                           |
    | huisletter | A                           |
    | fields     | burgerservicenummer         |
    Dan bevat de response alleen personen met de volgende gegevens 
    | burgerservicenummer |
    | 999995079           |

  @skip-verify
  Scenario: Zoek met huisnummertoevoeging
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                      |
    | type                 | ZoekMetPostcodeEnHuisnummer |
    | postcode             | 2628HJ                      |
    | huisnummer           | 4                           |
    | huisnummertoevoeging | to                          |
    | fields               | burgerservicenummer         |
    Dan bevat de response alleen personen met de volgende gegevens 
    | burgerservicenummer |
    | 999995080           |

  @skip-verify
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
