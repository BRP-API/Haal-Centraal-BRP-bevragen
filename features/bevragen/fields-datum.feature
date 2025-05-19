# language: nl
Functionaliteit: vragen van een datumveld met fields

  Regel: Het vragen van één of meerdere velden van een 'datum' veld levert alle velden van de 'datum' veld

    Abstract Scenario: een 'VolledigeDatum' veld wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19561115 |
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
        | naam              | waarde           |
        | datum.type        | Datum            |
        | datum.datum       |       1956-11-15 |
        | datum.langFormaat | 15 november 1956 |

      Voorbeelden:
        | fields                                   |
        | geboorte.datum                           |
        | geboorte.datum.type                      |
        | geboorte.datum.datum                     |
        | geboorte.datum.langFormaat               |
        | geboorte.datum.jaar                      |
        | geboorte.datum.maand                     |
        | geboorte.datum.onbekend                  |
        | geboorte.datum.jaar,geboorte.datum.maand |

    Abstract Scenario: een 'JaarMaandDatum' veld wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000153' heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19780300 |
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000153 |
        | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
        | naam              | waarde         |
        | datum.type        | JaarMaandDatum |
        | datum.jaar        |           1978 |
        | datum.maand       |              3 |
        | datum.langFormaat | maart 1978     |

      Voorbeelden:
        | fields                                   |
        | geboorte.datum                           |
        | geboorte.datum.type                      |
        | geboorte.datum.datum                     |
        | geboorte.datum.langFormaat               |
        | geboorte.datum.jaar                      |
        | geboorte.datum.maand                     |
        | geboorte.datum.onbekend                  |
        | geboorte.datum.jaar,geboorte.datum.maand |

    Abstract Scenario: een 'JaarDatum' veld wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000154' heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19680000 |
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000154 |
        | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
        | naam              | waarde    |
        | datum.type        | JaarDatum |
        | datum.jaar        |      1968 |
        | datum.langFormaat |      1968 |

      Voorbeelden:
        | fields                                   |
        | geboorte.datum                           |
        | geboorte.datum.type                      |
        | geboorte.datum.datum                     |
        | geboorte.datum.langFormaat               |
        | geboorte.datum.jaar                      |
        | geboorte.datum.maand                     |
        | geboorte.datum.onbekend                  |
        | geboorte.datum.jaar,geboorte.datum.maand |

    Abstract Scenario: een 'DatumOnbekend' veld wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000155' heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              00000000 |
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000155 |
        | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
        | naam              | waarde        |
        | datum.type        | DatumOnbekend |
        | datum.onbekend    | true          |
        | datum.langFormaat | onbekend      |

      Voorbeelden:
        | fields                                   |
        | geboorte.datum                           |
        | geboorte.datum.type                      |
        | geboorte.datum.datum                     |
        | geboorte.datum.langFormaat               |
        | geboorte.datum.jaar                      |
        | geboorte.datum.maand                     |
        | geboorte.datum.onbekend                  |
        | geboorte.datum.jaar,geboorte.datum.maand |
