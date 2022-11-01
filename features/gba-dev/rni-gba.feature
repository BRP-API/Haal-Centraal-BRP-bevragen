# language: nl

Functionaliteit: RNI-deelnemer voor geleverde gegevens

    Achtergrond:
      Gegeven landelijke tabel "RNI-deelnemerstabel" heeft de volgende waarden
      | code | omschrijving                                      |
      | 101  | Belastingdienst (inzake heffingen en toeslagen)   |
      | 201  | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) |

    Scenario: met field wordt alleen rni gevraagd
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                         | waarde                                      |
      | voornamen (02.10)            | Peter                                       |
      | geslachtsnaam (02.40)        | Jansen                                      |
      | rni-deelnemer (88.10)        | 101                                         |
      | omschrijving verdrag (88.20) | Belastingverdrag tussen België en Nederland |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | rni                             |
      Dan heeft de response een persoon met een 'rni' met de volgende gegevens
      | naam                   | waarde                                          |
      | deelnemer.code         | 101                                             |
      | deelnemer.omschrijving | Belastingdienst (inzake heffingen en toeslagen) |
      | omschrijvingVerdrag    | Belastingverdrag tussen België en Nederland     |
      | categorie              | Persoon                                         |
