# language: nl

@gba
Functionaliteit: partner

Rule: Als een persoon alleen ontbonden huwelijken/partnerschappen heeft, wordt alleen de ex-partner met de meest recente datum ontbinding geleverd

  Scenario: persoon heeft alleen ontbonden huwelijken/partnerschappen
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | 000000013                   | 20201001                                                     |
    En de persoon heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | 000000014                   | 20220414                                                     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met de volgende gegevens
    | naam                                 | waarde    |
    | burgerservicenummer                  | 000000014 |
    | ontbindingHuwelijkPartnerschap.datum | 20220414  |

  Scenario: persoon heeft een actuele en een ontbonden huwelijk/partnerschap
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | 000000013                   | 20151103                                                           |
    En de 'partner' is gewijzigd naar de volgende gegevens
    | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | 000000013                   | 20201001                                                     |
    En de persoon heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | 000000014                   | 20220414                                                           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met de volgende gegevens
    | naam                              | waarde    |
    | burgerservicenummer               | 000000014 |
    | aangaanHuwelijkPartnerschap.datum | 20220414  |
    