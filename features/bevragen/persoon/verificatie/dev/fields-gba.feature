#language: nl

Functionaliteit: GbaPersoon: verificatie velden vragen met fields
    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
      | naam                             | waarde               |
      | datum verificatie (71.10)        | 20020701             |
      | omschrijving verificatie (71.20) | bewijs nationaliteit |

  Rule: verificatie van de persoonsgegevens wordt bij elke vraag teruggegeven

    Abstract Scenario: persoonsgegevens zijn geverifieerd en verificatie wordt niet gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam         | waarde               |
      | datum        | 20020701             |
      | omschrijving | bewijs nationaliteit |

      Voorbeelden:
      | fields           |
      | naam.voorvoegsel |
      | verblijfstitel   |
      | overlijden.datum |
      | immigratie       |

    Abstract Scenario: persoonsgegevens zijn geverifieerd en verificatie wordt wel gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'verificatie' gegevens
      | naam         | waarde               |
      | datum        | 20020701             |
      | omschrijving | bewijs nationaliteit |

      Voorbeelden:
      | fields                        |
      | verificatie                   |
      | verificatie.omschrijving      |
      | verificatie.datum             |
      | verificatie.datum.langFormaat |
