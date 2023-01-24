#language: nl

Functionaliteit: Protocollering zoekrubrieken ZoekMetGeslachtsnaamEnGeboortedatum

  Rule: Gebruikte parameters worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met alleen de verplichte parameters
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | 2683754153      | Maassen               | 19830526              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de persoon met anummer '2683754153' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken |
      | 2683754153 | 010240, 010310         |

    Scenario: Vind meerdere personen op de zoekvraag
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | 4075979626      | Jan Peter         | Maassen               | 19830526              |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | anummer (01.10) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | 7871538547      | Caroline          | Maassen               | 19830526              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | burgerservicenummer                 |
      Dan heeft de persoon met anummer '4075979626' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken |
      | 4075979626 | 010240, 010310         |
      En heeft de persoon met anummer '7871538547' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken |
      | 7871538547 | 010240, 010310         |

    Scenario: Zoek persoon met alle mogelijke parameters
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      | 1970420703      | Jan Peter         | van                 | Maassen               | 19830526              | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam          | waarde |
      | gemeente_code | 0599   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                    | waarde                              |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam           | Maassen                             |
      | geboortedatum           | 1983-05-26                          |
      | voornamen               | Jan Peter                           |
      | voorvoegsel             | van                                 |
      | geslacht                | M                                   |
      | gemeenteVanInschrijving | 0599                                |
      | fields                  | burgerservicenummer                 |
      Dan heeft de persoon met anummer '1970420703' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken                         |
      | 1970420703 | 010210, 010230, 010240, 010310, 010410, 080910 |

    Abstract Scenario: zoek persoon met postcode, huisnummer en <zoekparameter>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      | <A-nummer>      | Jan Peter         | van                 | Maassen               | 19830526              | M                           |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam          | waarde |
      | gemeente_code | 0599   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam            | waarde                              |
      | type            | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam   | Maassen                             |
      | geboortedatum   | 1983-05-26                          |
      | <zoekparameter> | <zoekwaarde>                        |
      Dan heeft de persoon met anummer '<A-nummer>' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken |
      | <A-nummer> | <zoekrubrieken>        |

      Voorbeelden:
      | zoekparameter           | zoekwaarde | A-nummer   | zoekrubrieken          |
      | voornamen               | Jan Peter  | 7287128758 | 010210, 010240, 010310 |
      | voorvoegsel             | van        | 1494898723 | 010230, 010240, 010310 |
      | geslacht                | M          | 6897124304 | 010240, 010310, 010410 |
      | gemeenteVanInschrijving | 0599       | 9815905468 | 010240, 010310, 080910 |

  Rule: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met inclusiefOverledenPersonen
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | 8980459813      | Maassen               | 19830526              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Maassen                             |
      | geboortedatum              | 1983-05-26                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer                 |
      Dan heeft de persoon met anummer '8980459813' de volgende 'protocollering' gegevens
      | anummer    | request_zoek_rubrieken |
      | 8980459813 | 010240, 010310         |