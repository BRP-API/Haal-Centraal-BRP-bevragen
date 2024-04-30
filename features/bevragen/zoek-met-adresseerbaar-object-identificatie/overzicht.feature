#language: nl

Functionaliteit: Zoek met adresseerbaar object identificatie

  Regel: adresseerbaar object identificatie is een verplichte parameter

    Scenario: Zoek een persoon met de adresseerbaar object identificatie van zijn verblijfplaats
        Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
        | gemeente van inschrijving (09.10) |
        | 0599                              |
        En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0599                 | 0599010000219679                         |
        Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie | 0599010000219679                        |
        | fields                           | burgerservicenummer                     |
        Dan heeft de response 1 persoon
        En heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 000000024 |

    Scenario: Er zijn geen personen ingeschreven op het adres met de opgegeven adresseerbaar object identificatie
        Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie | 0518200000366054                        |
        | fields                           | burgerservicenummer                     |
        Dan heeft de response 0 personen

    Scenario: Er zijn meerdere personen ingeschreven op het adres met de opgegeven adresseerbaar object identificatie
        Gegeven een adres heeft de volgende gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0518                 | 0518200000617227                         |
        En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        | 0518                              |
        En de persoon met burgerservicenummer '000000025' is ingeschreven op het adres met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        | 0518                              |
        Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie | 0518200000617227                        |
        | fields                           | burgerservicenummer                     |
        Dan heeft de response 2 personen
        En heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 000000024 |
        En heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 000000025 |

  Regel: Overleden persoon ingeschreven op het adresseerbaar object worden niet gevonden

    Scenario: Vind niet overleden personen die zijn ingeschreven op het adres met de opgegeven adresseerbaar object identificatie
        Gegeven een adres heeft de volgende gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0599                 | 0599010051001502                         |
        En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        | 0599                              |
        En de persoon met burgerservicenummer '000000025' is ingeschreven op het adres met de volgende gegevens
        | gemeente van inschrijving (09.10) |
        | 0599                              |
        En de persoon heeft de volgende 'inschrijving' gegevens
        | naam                                 | waarde |
        | reden opschorting bijhouding (67.20) | O      |
        Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie | 0599010051001502                        |
        | fields                           | burgerservicenummer                     |
        Dan heeft de response 1 persoon
        En heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 000000024 |

  Regel: De optionele 'gemeenteVanInschrijving' parameter kan worden toegevoegd om de zoek criteria aan te scherpen

    Scenario: Zoek met gemeenteVanInschrijving
        Gegeven de persoon met burgerservicenummer '000000025' heeft de volgende 'verblijfplaats' gegevens
        | gemeente van inschrijving (09.10) |
        | 0599                              |
        En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0599                 | 0599010051001502                         |
        Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie | 0599010051001502                        |
        | gemeenteVanInschrijving          | 0599                                    |
        | fields                           | burgerservicenummer                     |
        Dan heeft de response 1 persoon
        En heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 000000025 |

    Scenario: Zoek met gemeenteVanInschrijving
        Gegeven de persoon met burgerservicenummer '000000025' heeft de volgende 'verblijfplaats' gegevens
        | gemeente van inschrijving (09.10) |
        | 0599                              |
        En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        | 0599                 | 0599010051001502                         |
        Als personen wordt gezocht met de volgende parameters
        | naam                             | waarde                                  |
        | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
        | adresseerbaarObjectIdentificatie | 0599010051001502                        |
        | gemeenteVanInschrijving          | 0518                                    |
        | fields                           | burgerservicenummer                     |
        Dan heeft de response 0 personen
