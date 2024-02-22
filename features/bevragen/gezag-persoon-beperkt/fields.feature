#language: nl

Functionaliteit: Gezag Persoon beperkt velden vragen met fields

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | naam                        | waarde            |
      | geslachtsnaam (02.40)       | Maassen           |
      | geboortedatum (03.10)       | vandaag - 10 jaar |
      | geslachtsaanduiding (04.10) | V                 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0599                 | 0599010051001502                         |

    Scenario: 'burgerservicenummer (01.20)' wordt gevraagd met 'burgerservicenummer'
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000152 |

    Abstract Scenario: 'geslachtsaanduiding (04.10)' wordt gevraagd met '<fields>' 
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | <fields>                                |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                  | waarde |
      | geslacht.code         | V      |
      | geslacht.omschrijving | vrouw  |

      Voorbeelden:
      | fields                |
      | geslacht              |
      | geslacht.code         |
      | geslacht.omschrijving |

    Scenario: 'indicatie geheim (70.10)' wordt automatisch geleverd bij waarde groter dan 0
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                     | waarde |
      | indicatie geheim (70.10) | 1      |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde    |
      | burgerservicenummer           | 000000152 |
      | geheimhoudingPersoonsgegevens | true      |

    Scenario: 'leeftijd' vragen met 'leeftijd'
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | leeftijd                                |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam     | waarde |
      | leeftijd | 10     |
