  #language: nl
  
  Functionaliteit: Leveren verblijfplaats.inOnderzoek.nummeraanduiding boolean 

    Rule: Als aanduiding in onderzoek een waarde heeft waarmee aangeduid wordt dat de identificatie Nummeraanduiding in onderzoek is wordt de corresponderende boolean geleverd. 
  
      Abstract Scenario: 'identificatiecode nummeraanduiding (11.90)' is in onderzoek
        Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
        | naam                            | waarde                    |
        | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
        | datum ingang onderzoek (83.20)  | 20020701                  |
        En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | naam                                       | waarde           |
        | gemeentecode (92.10)                       | 0518             |
        | straatnaam (11.10)                         | Spui             |
        | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                                       |
        | type                | RaadpleegMetBurgerservicenummer              |
        | burgerservicenummer | 000000152                                    |
        | fields              | verblijfplaats.nummeraanduidingIdentificatie |
        Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
        | naam                                         | waarde           |
        | type                                         | Adres            |
        | nummeraanduidingIdentificatie                | 0599200000219678 |
        | inOnderzoek.nummeraanduidingIdentificatie    | true             |
        | inOnderzoek.datumIngangOnderzoek.type        | Datum            |
        | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01       |
        | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002      |

        Voorbeelden:
        | gba in onderzoek waarde |
        | 080000                  |
        | 081100                  |
        | 081190                  |

      Abstract Scenario: 'identificatiecode nummeraanduiding (11.90)' is in onderzoek, maar wordt niet gevraagd
        Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
        | naam                            | waarde                    |
        | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
        | datum ingang onderzoek (83.20)  | 20020701                  |
        En de 'verblijfplaats' heeft de volgende 'adres' gegevens
        | naam                                       | waarde           |
        | gemeentecode (92.10)                       | 0518             |
        | straatnaam (11.10)                         | Spui             |
        | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                                          |
        | type                | RaadpleegMetBurgerservicenummer                 |
        | burgerservicenummer | 000000152                                       |
        | fields              | verblijfplaats.adresseerbaarObjectIdentificatie |
        Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
        | naam | waarde |
        | type | Adres  |

        Voorbeelden:
        | gba in onderzoek waarde |
        | 081190                  |