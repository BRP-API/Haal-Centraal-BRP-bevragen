# language: nl
Functionaliteit: autorisatie verblijfplaatsgegevens

  Achtergrond:
    Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
    En adres 'A1'
      | identificatiecode verblijfplaats (11.80) |
      |                         0599010000219679 |
    En de persoon 'Robin'
    En 'Robin' is op 01-09-2007 ingeschreven op adres 'A1'

  Regel: Een afnemer moet geautoriseerd zijn voor alle LO BRP rubrieken waar het veld mee wordt gevuld of van wordt afgeleid

    Abstract Scenario: Afnemer vraagt '<gevraagd veld>', en heeft minimaal de autorisatie die nodig is om dit veld te mogen vragen
      Gegeven een nieuwe afnemer met indicatie '000008' is geautoriseerd voor het vragen van '<geautoriseerd veld>'
      Als '<gevraagd veld>' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin'
      Dan heeft 'Robin' de volgende 'verblijfplaats' gegevens
        | type  | datumVan.type | datumVan.datum | datumVan.langFormaat |
        | Adres | Datum         |     2007-09-01 |     1 september 2007 |

      Voorbeelden:
        | gevraagd veld                                  | geautoriseerd veld                |
        | verblijfplaats.datumVan                        | verblijfplaats.datumVan           |
        | verblijfplaats.datumVan.nietBestaand           | verblijfplaats.datumVan           |
        | verblijfplaatsBinnenland.datumVan              | verblijfplaatsBinnenland.datumVan |
        | verblijfplaatsBinnenland.datumVan.nietBestaand | verblijfplaatsBinnenland.datumVan |
        | verblijfplaatsBinnenland.datumVan              | verblijfplaats.datumVan           |
        | verblijfplaatsBinnenland.datumVan.nietBestaand | verblijfplaats.datumVan           |

    Abstract Scenario: Afnemer vraagt '<gevraagd veld>', en heeft minimaal de autorisatie die nodig is om dit veld te mogen vragen
      Gegeven een nieuwe afnemer met indicatie '000008' is geautoriseerd voor het vragen van alle 'verblijfplaats binnenland' velden
      Als '<gevraagd veld>' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin'
      Dan heeft 'Robin' de volgende 'verblijfplaats' gegevens
        | type  | datumVan.type | datumVan.datum | datumVan.langFormaat |
        | Adres | Datum         |     2007-09-01 |     1 september 2007 |

      Voorbeelden:
        | gevraagd veld                                  |
        | verblijfplaatsBinnenland.datumVan              |
        | verblijfplaatsBinnenland.datumVan.nietBestaand |

    @fout-case
    Abstract Scenario: Afnemer vraagt '<gevraagd veld>', maar heeft niet de autorisatie die nodig is om het veld te mogen vragen
      Gegeven een nieuwe afnemer met indicatie '000008' is geautoriseerd voor het vragen van '<geautoriseerd veld>'
      Als '<gevraagd veld>' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin'
      Dan heeft de response de volgende gegevens
        | naam     | waarde                                                                                     |
        | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                                |
        | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden.                    |
        | detail   | U bent niet geautoriseerd om de volgende gegevens op te vragen met fields: <gevraagd veld> |
        | status   |                                                                                        403 |
        | code     | unauthorizedField                                                                          |
        | instance | /haalcentraal/api/brp/personen                                                             |

      Voorbeelden:
        | gevraagd veld                     | geautoriseerd veld                               |
        | verblijfplaats.datumVan           | verblijfplaatsBinnenland.datumVan                |
        | verblijfplaats.datumVan           | verblijfplaats.adresseerbaarObjectIdentificatie  |
        | verblijfplaatsBinnenland.datumVan | verblijfplaats.verblijfadres.korteStraatnaam     |
        | verblijfplaatsBinnenland.datumVan | verblijfplaats.verblijfadres.officieleStraatnaam |

    @fout-case
    Scenario: Afnemer vraagt 'verblijfplaats.datumVan', maar heeft niet de autorisatie die nodig is om het veld te mogen vragen
      Gegeven een nieuwe afnemer met indicatie '000008' is geautoriseerd voor het vragen van alle 'verblijfplaats binnenland' velden
      Als 'verblijfplaats.datumVan' wordt gevraagd van personen gezocht met burgerservicenummer van 'Robin'
      Dan heeft de response de volgende gegevens
        | naam     | waarde                                                                                             |
        | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                                        |
        | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden.                            |
        | detail   | U bent niet geautoriseerd om de volgende gegevens op te vragen met fields: verblijfplaats.datumVan |
        | status   |                                                                                                403 |
        | code     | unauthorizedField                                                                                  |
        | instance | /haalcentraal/api/brp/personen                                                                     |
