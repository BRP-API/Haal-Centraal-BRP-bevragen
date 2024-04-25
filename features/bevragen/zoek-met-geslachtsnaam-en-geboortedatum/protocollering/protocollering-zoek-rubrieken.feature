#language: nl

@protocollering
Functionaliteit: Protocollering zoekrubrieken ZoekMetGeslachtsnaamEnGeboortedatum

  Regel: Gebruikte parameters worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met alleen de verplichte parameters
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Maassen               | 19830526              |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010240, 010310         |

    Scenario: Vind meerdere personen op de zoekvraag
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Jan Peter         | Maassen               | 19830526              |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Caroline          | Maassen               | 19830526              |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010240, 010310         |
      En heeft de persoon met burgerservicenummer '000000048' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010240, 010310         |

    Scenario: Zoek persoon met alle mogelijke parameters
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      | Jan Peter         | van                 | Maassen               | 19830526              | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam          | waarde |
      | gemeente_code | 0599   |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                              |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam           | Maassen                             |
      | geboortedatum           | 1983-05-26                          |
      | voornamen               | Jan Peter                           |
      | voorvoegsel             | van                                 |
      | geslacht                | M                                   |
      | gemeenteVanInschrijving | 0599                                |
      | fields                  | burgerservicenummer                 |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken                         |
      | 010210, 010230, 010240, 010310, 010410, 080910 |

    Abstract Scenario: zoek persoon met geslachtsnaam, geboortedatum en <zoekparameter>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      | Jan Peter         | van                 | Maassen               | 19830526              | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam          | waarde |
      | gemeente_code | 0599   |
      Als personen wordt gezocht met de volgende parameters
      | naam            | waarde                              |
      | type            | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam   | Maassen                             |
      | geboortedatum   | 1983-05-26                          |
      | <zoekparameter> | <zoekwaarde>                        |
      | fields          | burgerservicenummer                 |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | <zoekrubrieken>        |

      Voorbeelden:
      | zoekparameter           | zoekwaarde | zoekrubrieken          |
      | voornamen               | Jan Peter  | 010210, 010240, 010310 |
      | voorvoegsel             | van        | 010230, 010240, 010310 |
      | geslacht                | M          | 010240, 010310, 010410 |
      | gemeenteVanInschrijving | 0599       | 010240, 010310, 080910 |

  Regel: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met inclusiefOverledenPersonen
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Maassen               | 19830526              |
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Maassen                             |
      | geboortedatum              | 1983-05-26                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010240, 010310         |
