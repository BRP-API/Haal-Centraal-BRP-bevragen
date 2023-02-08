#language: nl

Functionaliteit: Persoon: verificatie velden vragen met fields
    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Vries                 | 19781103              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                             | waarde               |
      | datum verificatie (71.10)        | 20020701             |
      | omschrijving verificatie (71.20) | bewijs nationaliteit |

  Rule: verificatie van de persoonsgegevens wordt bij elke vraag teruggegeven

    Scenario: persoonsgegevens zijn geverifieerd en verificatie wordt niet gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Vries                               |
      | geboortedatum | 1978-11-03                          |
      | fields        | geslacht                            |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam              | waarde               |
      | datum.type        | Datum                |
      | datum.datum       | 2002-07-01           |
      | datum.langFormaat | 1 juli 2002          |
      | omschrijving      | bewijs nationaliteit |

    Abstract Scenario: persoonsgegevens zijn geverifieerd en verificatie wordt wel gevraagd
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Vries                               |
      | geboortedatum | 1978-11-03                          |
      | fields        | <fields>                            |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam              | waarde               |
      | datum.type        | Datum                |
      | datum.datum       | 2002-07-01           |
      | datum.langFormaat | 1 juli 2002          |
      | omschrijving      | bewijs nationaliteit |

      Voorbeelden:
      | fields                        |
      | verificatie                   |
      | verificatie.omschrijving      |
      | verificatie.datum             |
      | verificatie.datum.langFormaat |

    Abstract Scenario: 'datum verificatie (71.10)' van het type '<type>'
      Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) |
      | Maassen               | 20011027              |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                      | waarde     |
      | datum verificatie (71.10) | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 2001-10-27                          |
      | fields        | verificatie.datum                   |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam              | waarde        |
      | datum.type        | <type>        |
      | datum.datum       | <datum>       |
      | datum.jaar        | <jaar>        |
      | datum.maand       | <maand>       |
      | datum.onbekend    | <onbekend>    |
      | datum.langFormaat | <langFormaat> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
