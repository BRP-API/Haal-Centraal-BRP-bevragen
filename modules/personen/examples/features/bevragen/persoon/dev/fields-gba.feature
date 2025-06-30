#language: nl

@gba
Functionaliteit: persoon velden vragen met fields

  Abstract Scenario: persoon heeft veld: 'anummer (01.10)' <sub-titel>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam            | waarde       |
    | anummer (01.10) | <gba waarde> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | aNummer                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam    | waarde       |
    | aNummer | <gba waarde> |

    Voorbeelden:
    | sub-titel          | gba waarde |
    |                    | 1234567890 |
    | met voorloopnul    | 0123456789 |
    | met voorloopnullen | 0001234567 |

  Abstract Scenario: onbekend waarde voor: <element>
    Gegeven de persoon met burgerservicenummer '000000231' heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde   | 
    | functie adres (10.10) | W        | 
    | <element>             | <waarde> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000231                       |
    | fields              | burgerservicenummer,<veld>      |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000231 |
    | <veld>.code         | <waarde>  |
    | <veld>.omschrijving | Onbekend  |

    Voorbeelden:
    | veld                    | element                           | waarde |
    | gemeenteVanInschrijving | gemeente van inschrijving (09.10) | 0000   |

  Scenario: een onbekend waarde bij geslacht wordt wel opgenomen in de response
   Gegeven de persoon met burgerservicenummer '000000292' heeft de volgende gegevens
    | naam                        | waarde    |
    | geslachtsaanduiding (04.10) | O         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000292                       |
    | fields              | burgerservicenummer,geslacht    |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde    |
    | burgerservicenummer   | 000000292 |
    | geslacht.code         | O         |
    | geslacht.omschrijving | onbekend  |

  Scenario: volledig onbekende datum inschrijving 
     Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende 'verblijfplaats' gegevens
    | naam                                       | waarde    |
    | datum inschrijving in de gemeente (09.20)  | 00000000  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000358                       |
    | fields              | datumInschrijvingInGemeente     |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                        | waarde   |
    | datumInschrijvingInGemeente | 00000000 |
