# language: nl

@gba
Functionaliteit: partner

Regel: Als een persoon alleen ontbonden huwelijken/partnerschappen heeft, wordt alleen de ex-partner met de meest recente datum ontbinding geleverd

  Abstract Scenario: persoon heeft alleen ontbonden huwelijken/partnerschappen met <omschrijving>
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | 000000013                   | <datum huwelijkssluiting 1>                                        |
    En de 'partner' is gewijzigd naar de volgende gegevens
    | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | 000000013                   | 20201001                                                     |
    En de persoon heeft een 'partner' met de volgende gegevens
    | burgerservicenummer (01.20) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
    | 000000014                   | <datum huwelijkssluiting 2>                                        |
    En de 'partner' is gewijzigd naar de volgende gegevens
    | burgerservicenummer (01.20) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
    | 000000014                   | 20220414                                                     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners                        |
    Dan heeft de response een persoon met een 'partner' met de volgende gegevens
    | naam                                 | waarde                      |
    | burgerservicenummer                  | 000000014                   |
    | ontbindingHuwelijkPartnerschap.datum | 20220414                    |
    | aangaanHuwelijkPartnerschap.datum    | <datum huwelijkssluiting 2> |

    Voorbeelden:
    | datum huwelijkssluiting 1 | datum huwelijkssluiting 2 | omschrijving                                                                                                      |
    | 20080715                  | 20210523                  | twee achtereenvolgende relaties zijn beëindigd                                                                    |
    | 20100523                  | 20080715                  | twee gelijktijdige (polygame) relaties - eerste relatie laatst beëindigd                                          |
    | 20080715                  | 20100523                  | twee gelijktijdige (polygame) relaties - eerste relatie eerst beëindigd                                           |
    | 20100523                  | 00000000                  | laatst beëindigde relatie heeft onbekende begindatum                                                              |
    | 00000000                  | 20080715                  | eerste beëindigde relatie heeft onbekende begindatum                                                              |
    | 20100523                  | 20100523                  | twee gelijktijdige (polygame) relaties met gelijke begindatum                                                     |
    | 20100523                  | 20100000                  | twee gelijktijdige (polygame) relaties - laatst beëindigde relatie in zelfde jaar maar onbekende maand begindatum |
    | 00000000                  | 00000000                  | twee gelijktijdige (polygame) relaties met onbekende begindatum                                                   |

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

  Scenario: persoon heeft geen partner
    Gegeven de persoon met burgerservicenummer '000000061' heeft de volgende gegevens
    | naam                            | waarde          |
    | voornamen (02.10)               | Daan            |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000061                       |
    | fields              | partners                        |
    Dan heeft de response een persoon zonder 'partner' gegevens

Regel: Een partner wordt alleen teruggegeven als minimaal één gegeven in de identificatienummers (groep 01), naam (groep 02), geboorte (groep 03), aangaan (groep 06), ontbinding (groep 07) of 15 (soort verbintenis) van de partner een waarde heeft.

  Scenario: bestaan partner bekend, veld met onbekend waarde wordt gevraagd met fields
      Gegeven de persoon met burgerservicenummer '000000036' heeft een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) | geboortedatum (03.10) | 
      | .                     | 00000000              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000036                       |
      | fields              | partners.naam                   |
      Dan heeft de response een persoon met een 'partner' met de volgende 'naam' gegevens
      | naam          | waarde |
      | geslachtsnaam | .      |
	  
  Abstract Scenario: bestaan partner bekend (<rubriek>), veld wordt niet gevraagd met fields
    Gegeven de persoon met burgerservicenummer '000000048' heeft een 'partner' met de volgende gegevens
    | <rubriek> |
    | <waarde>  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000048                       |
    | fields              | partners.burgerservicenummer    |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | rubriek                                                            | waarde   |
    | geslachtsnaam (02.40)                                              | Groenen  |
    | geboortedatum (03.10)                                              | 19780623 |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20230126 |
    | soort verbintenis (15.10)                                          | H        |
    | geslachtsnaam (02.40)                                              | .        |
    | geboortedatum (03.10)                                              | 00000000 |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 00000000 |
    | soort verbintenis (15.10)                                          | .        |

  Scenario: huwelijk is onjuist
    Gegeven de persoon met burgerservicenummer '000000061' heeft een 'partner' met de volgende gegevens
    | naam                                                               | waarde          |
    | voornamen (02.10)                                                  | Daan            |
    | voorvoegsel (02.30)                                                | de              |
    | geslachtsnaam (02.40)                                              | Vries           |
    | geboortedatum (03.10)                                              | 19830715        |
    | soort verbintenis (15.10)                                          | H               |
    | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) | 20031107        |
    | gemeente document (82.10)                                          | 0518            |
    | datum document (82.20)                                             | 20031109        |
    | beschrijving document (82.30)                                      | PL gerelateerde |
    | ingangsdatum geldigheid (85.10)                                    | 20031107        |
    | datum van opneming (86.10)                                         | 20031109        |
    En het 'partner' is gecorrigeerd naar de volgende gegevens
    | naam                            | waarde           |
    | gemeente document (82.10)       | 0518             |
    | datum document (82.20)          | 20040105         |
    | beschrijving document (82.30)   | D27894-2004-A782 |
    | ingangsdatum geldigheid (85.10) | 20031107         |
    | datum van opneming (86.10)      | 20040112         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000061                       |
    | fields              | partners                        |
    Dan heeft de response een persoon zonder 'partner' gegevens

  Scenario: Geen partner, maar dat wordt wel onderzocht
    Gegeven de persoon met burgerservicenummer '000000061' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde           |
    | gemeente document (82.10)       | 0518             |
    | datum document (82.20)          | 20040105         |
    | aanduiding in onderzoek (83.10) | 050000           |
    | datum ingang onderzoek (83.20)  | 20230114         |
    | beschrijving document (82.30)   | D27894-2004-A782 |
    | ingangsdatum geldigheid (85.10) | 20031107         |
    | datum van opneming (86.10)      | 20040112         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000061                       |
    | fields              | partners                        |
    Dan heeft de response een persoon zonder 'partner' gegevens


Regel: Wanneer er meerdere actuele (niet-ontbonden) huwelijken/partnerschappen zijn, worden die allemaal geleverd

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
