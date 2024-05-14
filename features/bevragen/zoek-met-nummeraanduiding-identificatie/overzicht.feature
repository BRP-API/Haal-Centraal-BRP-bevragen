#language: nl

Functionaliteit: Zoek met nummeraanduiding identificatie

Regel: nummeraanduiding identificatie is een verplichte parameter

  Scenario: Zoek een persoon met de nummeraanduiding identificatie van zijn verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
    | 0599                 | 0599200000219679                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219679                     |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000024 |

  Scenario: Er zijn geen personen ingeschreven op het adres met de opgegeven nummeraanduiding identificatie
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0518200000366054                     |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 0 personen

  Scenario: Er zijn meerdere personen ingeschreven op het adres met de opgegeven nummeraanduiding identificatie
    Gegeven een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
    | 0518                 | 0518200000617227                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
    | gemeente van inschrijving (09.10) |
    | 0518                              |
    En de persoon met burgerservicenummer '000000025' is ingeschreven op het adres met de volgende gegevens
    | gemeente van inschrijving (09.10) |
    | 0518                              |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0518200000617227                     |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 2 personen
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000024 |
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000025 |

Regel: De optionele 'inclusiefOverledenPersonen' parameter moet worden opgegeven om een overleden persoon te kunnen vinden

  Scenario: Zoek overleden personen die zijn ingeschreven op het adres met de opgegeven nummeraanduiding identificatie
    Gegeven de persoon met burgerservicenummer '000000025' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
    | 0599                 | 0599200051001502                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde |
    | reden opschorting bijhouding (67.20) | O      |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200051001502                     |
    | inclusiefOverledenPersonen    | true                                 |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000025 |
    En heeft de persoon de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde     |
    | reden.code         | O          |
    | reden.omschrijving | overlijden |

Regel: De optionele 'gemeenteVanInschrijving' parameter kan worden toegevoegd om de zoek criteria aan te scherpen

  Scenario: Zoek met gemeenteVanInschrijving
    Gegeven de persoon met burgerservicenummer '000000025' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
    | 0599                 | 0599200051001502                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200051001502                     |
    | gemeenteVanInschrijving       | 0599                                 |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000025 |

  Scenario: Zoek met gemeenteVanInschrijving
    Gegeven de persoon met burgerservicenummer '000000025' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode nummeraanduiding (11.90) |
    | 0599                 | 0599200051001502                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200051001502                     |
    | gemeenteVanInschrijving       | 0518                                 |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 0 personen
