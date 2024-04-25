#language: nl

Functionaliteit: samenstellen van adresregels in gezag persoon beperkt

  Als consumer van de BRP bevragen API
  Wil ik dat de verblijfplaats gegevens van een persoon kan worden gevraagd conform NEN 5825:2002
  Zodat ik de adresgegevens van de persoon op de correcte manier kan gebruiken

  Regel: adresregel1 wordt voor een adres met alleen straatnaam en huisnummer als volgt samengesteld: '[straatnaam][spatie][huisnummer]'

    Scenario: persoon heeft een adres met alleen een straatnaam en huisnummer als verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | functie adres (10.10) |
      | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10)       | huisnummer (11.20) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | Jonkheer van Riemsdijkln | 88                 | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | adressering.adresregel1                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                      |
      | adresregel1 | Jonkheer van Riemsdijkln 88 |

  Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer en huisletter als volgt samengesteld: '[straatnaam][spatie][huisnummer][spatie][huisletter]'

    Scenario: persoon heeft een adres met straatnaam, huisnummer en huisletter als verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | functie adres (10.10) |
      | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | Borgesiusstraat    | 103                | c                  | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | adressering.adresregel1                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                |
      | adresregel1 | Borgesiusstraat 103 c |

  Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer en huisnummertoevoeging die begint met een letter als volgt samengesteld: [straatnaam][spatie][huisnummer][spatie][huisnummertoevoeging]'

    Scenario: persoon heeft een adres met straatnaam, huisnummer en huisnummertoevoeging die begint met een letter als verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | functie adres (10.10) |
      | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10)    | huisnummer (11.20) | huisnummertoevoeging (11.40) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | Daniël Stalpertstraat | 35                 | III                          | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | adressering.adresregel1                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                       |
      | adresregel1 | Daniël Stalpertstraat 35 III |

  Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer en huisnummertoevoeging die begint met een cijfer als volgt samengesteld: [straatnaam][spatie][huisnummer]-[huisnummertoevoeging]'

    Scenario: persoon heeft een adres met straatnaam, huisnummer en huisnummertoevoeging die begint met een cijfer als verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | functie adres (10.10) |
      | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisnummertoevoeging (11.40) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | Atatürkstraat      | 9                  | 2                            | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | adressering.adresregel1                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde            |
      | adresregel1 | Atatürkstraat 9-2 |

  Regel: adresregel1 wordt voor een adres met straatnaam, huisnummer, huisletter en huisnummertoevoeging als volgt samengesteld: [straatnaam][spatie][huisnummer][spatie][huisletter][huisnummertoevoeging]'

    Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter en huisnummertoevoeging die begint met een letter als verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | functie adres (10.10) |
      | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | St. Jacobsstraat   | 400                | L                  | Toe                          | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | adressering.adresregel1                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                    |
      | adresregel1 | St. Jacobsstraat 400 LToe |

    Scenario: persoon heeft een adres met straatnaam, huisnummer, huisletter en huisnummertoevoeging die begint met een cijfer als verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | functie adres (10.10) |
      | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | Cronus             | 555                | B                  | 73c                          | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | adressering.adresregel1                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde          |
      | adresregel1 | Cronus 555 B73c |


  Regel: adresregel2 wordt voor een adres met postcode en woonplaats als volgt samengesteld: [postcode numeriek deel][spatie][postcode alfabetisch deel][2 spaties][woonplaats in hoofdletters]

    Scenario: persoon heeft een adres met postcode en woonplaats als verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) |
      | 0518                              | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | een straat         | 1                  | 2583XL           | Scheveningen       | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | adressering.adresregel2                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                |
      | adresregel2 | 2583 XL  SCHEVENINGEN |

  Regel: adresregel2 wordt voor een adres met postcode en zonder woonplaats als volgt samengesteld: [postcode numeriek deel][spatie][postcode alfabetisch deel][2 spaties][omschrijving gemeente van inschrijving in hoofdletters]

    Scenario: persoon heeft een adres met postcode en zonder woonplaats als verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000188' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) |
      | 0518                              | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | een straat         | 1                  | 2584BZ           | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | adressering.adresregel2                 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                 |
      | adresregel2 | 2584 BZ  'S-GRAVENHAGE |
