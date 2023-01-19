# language: nl

Functionaliteit: aangaan huwelijk/partnerschap bij actuele of ontbonden relatie

  Rule: aangaanHuwelijkPartnerschap wordt -indien gevraagd met fields- geleverd voor zowel een actuele als een ontbonden huwelijk of partnerschap

    Scenario: partnerschap is actueel
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                                                                | waarde    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | 20010809  |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | Parijs    |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 5002      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetBurgerservicenummer      |
      | burgerservicenummer | 000000012                            |
      | fields              | partners.aangaanHuwelijkPartnerschap |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20010809  |
      | plaats.omschrijving | Parijs    |
      | land.code           | 5002      |
      | land.omschrijving   | Frankrijk |

    Scenario: partnerschap is ontbonden
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                                                                | waarde    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | 20010808  |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | Parijs    |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 5002      |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20180317 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetBurgerservicenummer      |
      | burgerservicenummer | 000000012                            |
      | fields              | partners.aangaanHuwelijkPartnerschap |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde    |
      | datum               | 20010809  |
      | plaats.omschrijving | Parijs    |
      | land.code           | 5002      |
      | land.omschrijving   | Frankrijk |
