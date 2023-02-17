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

  Scenario: persoon heeft meerdere ontbonden huwelijk/partnerschappen
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | Jan               | Groen                 | 19601007              | 19931002                                                           |
    En de 'partner' is gewijzigd naar de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | Jan               | Groen                 | 19601007              | 20000103                                                     |
    En de persoon heeft nog een 'partner' met de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | Cees              | Maassen               | 19611002              | 19820328                                                           |
    En de 'partner' is gewijzigd naar de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | Cees              | Maassen               | 19611002              | 19830328                                                     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                 | waarde   |
    | naam.voornamen                       | Jan      |
    | naam.geslachtsnaam                   | Groen    |
    | geboorte.datum                       | 19601007 |
    | aangaanHuwelijkPartnerschap.datum    | 19931002 |
    | ontbindingHuwelijkPartnerschap.datum | 20000103 |


  Scenario: persoon was getrouwd, gescheiden en daarna opnieuw met zelfde persoon getrouwd en daarna weer gescheiden
    Gegeven de persoon met burgerservicenummer '000000024' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | Jan               | Groen                 | 19601007              | 19931002                                                           |
    En de 'partner' is gewijzigd naar de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | Jan               | Groen                 | 19601007              | 20000103                                                     |
    En de persoon heeft nog een 'partner' met de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | Jan               | Groen                 | 19601007              | 19820328                                                           |
    En de 'partner' is gewijzigd naar de volgende gegevens
    | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | Jan               | Groen                 | 19601007              | 19830328                                                     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                 | waarde   |
    | naam.voornamen                       | Jan      |
    | naam.geslachtsnaam                   | Groen    |
    | geboorte.datum                       | 19601007 |
    | aangaanHuwelijkPartnerschap.datum    | 19931002 |
    | ontbindingHuwelijkPartnerschap.datum | 20000103 |


  Scenario: persoon heeft meerdere actuele huwelijken/partnerschappen
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | 000000013                   | 20201001                                                           |
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
    | burgerservicenummer               | 000000013 |
    | aangaanHuwelijkPartnerschap.datum | 20201001  |
    En heeft de persoon een 'partner' met de volgende gegevens
    | naam                              | waarde    |
    | burgerservicenummer               | 000000014 |
    | aangaanHuwelijkPartnerschap.datum | 20220414  |
