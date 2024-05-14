#language: nl

@gba
Functionaliteit: ZoekMetAdresseerbaarObjectIdentificatie van persoonslijst met opschorting bijhouding

  Regel: Een persoonslijst met reden opschorting bijhouding "W" (wissen) wordt niet geleverd

    Scenario: persoonslijst heeft opschorting bijhouding reden "W"
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001502                         |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | W                                    |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0800010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 0 personen


  Regel: Een persoonslijst met reden opschorting bijhouding "F" (fout) wordt niet geleverd

    Scenario: persoonslijst heeft opschorting bijhouding reden "F"
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001502                         |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | F                                    |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0800010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 0 personen

    Scenario: persoonslijst heeft opschorting bijhouding reden "F" en zelfde burgerservicenummer is gebruikt op andere persoonslijst
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001502                         |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) |
      | Maassen               |
      En de persoon is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | F                                    |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) |
      | Rafi                  |
      En de persoon is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0800010051001502                        |
      | fields                           | burgerservicenummer,naam.geslachtsnaam  |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |
      | naam.geslachtsnaam  | Rafi      |

    Scenario: persoonslijst heeft opschorting bijhouding reden "F" en zelfde burgerservicenummer is gebruikt op andere persoonslijst met andere verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) |
      | Maassen               |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001502                         |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | F                                    |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) |
      | Rafi                  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001234                         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0800010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 0 personen


  Regel: Een persoonslijst met reden opschorting bijhouding gelijk aan "O" (overleden) wordt alleen gevonden bij gebruik van parameter inclusiefOverledenPersonen met waarde true

    Scenario: persoonslijst heeft opschorting bijhouding reden "O" en parameter inclusiefOverledenPersonen wordt niet gebruikt
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001502                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0800010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |

    Scenario: persoonslijst heeft opschorting bijhouding reden "O" en parameter inclusiefOverledenPersonen wordt gebruikt met waarde false
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001502                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0800010051001502                        |
      | inclusiefOverledenPersonen       | false                                   |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000024 |

    Scenario: persoonslijst heeft opschorting bijhouding reden "O" en parameter inclusiefOverledenPersonen wordt gebruikt met waarde true
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001502                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde |
      | reden opschorting bijhouding (67.20) | O      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0800010051001502                        |
      | inclusiefOverledenPersonen       | true                                    |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 2 personen


  Regel: Een persoonslijst met overige reden opschorting bijhouding kan wel worden gevonden en geleverd

    Abstract Scenario: persoonslijst heeft opschorting bijhouding reden "<opschorting>"
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010051001502                         |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | <opschorting>                        |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0800010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response 1 persoon

      Voorbeelden:
      | opschorting | omschrijving              |
      | E           | emigratie                 |
      | M           | ministerieel besluit      |
      | R           | pl is aangelegd in de rni |
      | .           | onbekend                  |
