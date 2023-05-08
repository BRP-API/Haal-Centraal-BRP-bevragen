#language: nl

@gba
Functionaliteit: Persoon: adressering - in onderzoek

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | Holmes                | 010000                          | 20230101                       |
      En de persoon heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | Watson                | 050000                          | 20230105                       |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | land (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 6039         | 080000                          | 20230108                       |


    Scenario: 'persoon' en 'verblijfplaats' is in onderzoek en adressering wordt gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | adressering                     |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                                     | waarde           |
      | naam.geslachtsnaam                                       | Holmes           |
      | persoonInOnderzoek.aanduidingGegevensInOnderzoek         | 010000           |
      | persoonInOnderzoek.datumIngangOnderzoek                  | 20230101         |
      | verblijfplaats.land.code                                 | 6039             |
      | verblijfplaats.land.omschrijving                         | Groot-Brittannië |
      | verblijfplaats.inOnderzoek.aanduidingGegevensInOnderzoek | 080000           |
      | verblijfplaats.inOnderzoek.datumIngangOnderzoek          | 20230108         |
      En heeft de persoon een 'partner' met de volgende gegevens
      | naam                                      | waarde   |
      | naam.geslachtsnaam                        | Watson   |
      | inOnderzoek.aanduidingGegevensInOnderzoek | 050000   |
      | inOnderzoek.datumIngangOnderzoek          | 20230105 |

    Abstract Scenario: 'persoon' en 'verblijfplaats' is in onderzoek en <fields> wordt gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | adressering.<fields>            |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                             | waarde   |
      | naam.geslachtsnaam                               | Holmes   |
      | persoonInOnderzoek.aanduidingGegevensInOnderzoek | 010000   |
      | persoonInOnderzoek.datumIngangOnderzoek          | 20230101 |
      En heeft de persoon een 'partner' met de volgende gegevens
      | naam                                      | waarde   |
      | naam.geslachtsnaam                        | Watson   |
      | inOnderzoek.aanduidingGegevensInOnderzoek | 050000   |
      | inOnderzoek.datumIngangOnderzoek          | 20230105 |

      Voorbeelden:
      | fields                |
      | aanschrijfwijze       |
      | aanhef                |
      | gebruikInLopendeTekst |

    Abstract Scenario: 'persoon' en 'verblijfplaats' is in onderzoek en <fields> wordt gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | adressering.<fields>            |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                      | waarde           |
      | land.code                                 | 6039             |
      | land.omschrijving                         | Groot-Brittannië |
      | inOnderzoek.aanduidingGegevensInOnderzoek | 080000           |
      | inOnderzoek.datumIngangOnderzoek          | 20230108         |

      Voorbeelden:
      | fields      |
      | adresregel1 |
      | adresregel2 |
      | adresregel3 |
      | land        |
