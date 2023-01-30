# language: nl

Functionaliteit: geheimhouding: niet verstrekken van gegevens van een persoon aan derden

  Wanneer een consumer van de BRP API gegevens bevraagt van een persoon die geen toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden
  Dan wil de consumer hiervan worden geattendeerd middels een indicatie bij de gevraagde gegevens

  Abstract Scenario: persoon die toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden, wordt geraadpleegd met burgerservicenummer en <sub titel> 
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 0      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

    Voorbeelden:
    | sub titel                                              | fields                                            |
    | geheimhoudingPersoonsgegevens veld wordt gevraagd      | burgerservicenummer,geheimhoudingPersoonsgegevens |
    | geheimhoudingPersoonsgegevens veld wordt niet gevraagd | burgerservicenummer                               |

  Abstract Scenario: persoon die geen toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden, wordt geraadpleegd met burgerservicenummer en <sub titel>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde   |
    | indicatie geheim (70.10) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde    |
    | burgerservicenummer           | 000000152 |
    | geheimhoudingPersoonsgegevens | true      |

    Voorbeelden:
    | sub titel                                              | waarde | fields                                            |
    | geheimhoudingPersoonsgegevens veld wordt gevraagd      | 1      | burgerservicenummer,geheimhoudingPersoonsgegevens |
    | geheimhoudingPersoonsgegevens veld wordt niet gevraagd | 7      | burgerservicenummer                               |
