# language: nl

Functionaliteit: Tonen van Partnerhistorie
  Huidige en beëindigde huwelijken en geregistreerd partnerschappen van ingeschreven personen kunnen worden geraadpleegd.

  Alleen huwelijken en partnerschappen uit categorie 05 worden opgenomen in het antwoord.
  Bij het ophalen van ontbonden huwelijken en partnerschappen uit GBA-V wordt Datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) uit de eerste historische huwelijk/partnerschap (categorie 55) na het actuele huwelijk/partnerschap waarin Datum huwelijkssluiting/aangaan geregistreerd partnerschap een waarde heeft.

  De gebruiker kan het huwelijk of partnerschap raadplegen op een specifieke peildatum (in het verleden).
  De gebruiker kan de huwelijken of partnerschappen raadplegen over een specifieke periode.
  Filteren op peildatum of periode wordt gedaan op basis Datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) en Datum ontbinding huwelijk/geregistreerd partnerschap (07.10).

  Op periode gefilterde gegevens tonen alle huwelijken/partnerschappen die de persoon gedurende de periode heeft gehad.
  Als de persoon al voor de periode een huwelijk of partnerschap had die binnen de gevraagde periode niet ontbonden is, dan wordt dat huwelijk of partnerschap opgenomen in het antwoord.
  Als de persoon tijdens (een deel van) de periode een huwelijk sloot of partnerschap aanging die aan het einde de gevraagde periode nog niet ontbonden is, dan wordt dat huwelijk of partnerschap opgenomen in het antwoord.
  Als de persoon tijdens de periode een huwelijk sloot of partnerschap aanging die voor het einde van de gevraagde periode werd ontbonden, dan wordt dat huwelijk of partnerschap opgenomen in het antwoord.
  Als partnerhistorie wordt gevraagd met peildatum gelijk aan de Datum ontbinding huwelijk/geregistreerd partnerschap van een huwelijk/partnerschap, dan wordt dat huwelijk of partnerschap niet opgenomen in het antwoord.
  Als partnerhistorie wordt gevraagd met datumvan gelijk aan de Datum ontbinding huwelijk/geregistreerd partnerschap van een huwelijk/partnerschap, dan wordt dat huwelijk of partnerschap niet opgenomen in het antwoord.

  Wanneer de datum sluiting/aangaan gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd deze partner heeft gehad.
  Wanneer van de sluiting/aangaan alleen het jaar bekend is, wordt voor de filtering aangenomen dat de persoon het hele jaar deze partner heeft gehad.
  Wanneer van de sluiting/aangaan alleen het jaar en de maand bekend is, wordt voor de filtering aangenomen dat de persoon de hele maand deze partner heeft gehad.
  Wanneer de sluiting/aangaan geheel onbekend is, wordt voor de filtering aangenomen dat de persoon deze partner altijd heeft gehad.

  Wanneer de datum ontbinding gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd deze partner heeft gehad.
  Wanneer van de ontbinding alleen het jaar bekend is, wordt voor de filtering aangenomen dat de persoon het hele jaar deze partner heeft gehad.
  Wanneer van de ontbinding alleen het jaar en maand bekend is, wordt voor de filtering aangenomen dat de persoon de hele maand deze partner heeft gehad.


  De huwelijken/partnerschappen worden in het antwoord aflopend gesorteerd op Datum huwelijkssluiting/aangaan geregistreerd partnerschap, zodat de meest laatst gesloten huwelijk/partnerschap bovenaan staat.

  Als een huwelijk/partnerschap, actueel of ontbonden, in onderzoek is, en dit onderzoek is niet afgerond (Datum einde onderzoek is leeg), wordt inOnderzoek gevuld voor betreffende huwelijk/partnerschap.

  Als wel het begin van de periode (datumvan) wordt opgegeven, maar geen einde van de periode (datumtotenmet), dan worden alle huwelijken/partnerschappen vanaf de datumvan in het antwoord opgenomen.
  Als wel het einde van de periode (datumtotenmet) wordt opgegeven, maar geen begin van de periode (datumtotenmet), dan worden alle huwelijken/partnerschappen tot en met de datumtotenmet in het antwoord opgenomen.

  Achtergrond:
    Gegeven de persoon met burgerservienummer 999991553 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Voornamen | Datum aangaan (06.10) | Datum ontbinding (07.10) |
      | 5         | Karel     | 20091102              |                          |
      | 5         | Björn     |                       | 20080706                 |
      | 55        | Björn     | 19870714              |                          |
      | 55        | Björn     | 19870714              |                          |

    En de persoon met burgerservienummer 999995182 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Voornamen | Datum aangaan (06.10) | Datum ontbinding (07.10) |
      | 5         | Erik     |                        | 19730812                 |
      | 55        | Erik     |                        | 19730812                 |
      | 55        | Erik     | 19650812               |                          |
      | 5         | Henk     | 19740808               |                          |

    En de persoon met burgerservienummer 999992806 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Voornamen | Datum aangaan (06.10) | Datum ontbinding (07.10) |
      | 5         | Osama     |                       | 20011109                 |
      | 55        | Osama     | 20000115              |                          |

    En de persoon met burgerservienummer 999991139 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Voornamen | Datum aangaan (06.10) | Datum ontbinding (07.10) |
      | 5         | Ayaan     | 19360000              |                          |

  Scenario: ontbonden en actueel huwelijk
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Karel          | 2009-11-02                        |                                      |
      | 1 | Björn          | 1987-07-14                        | 2008-07-06                           |

  Scenario: ontbonden en actueel huwelijk (in omgekeerde volgorde in registratie)
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999995182
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Henk           | 1974-08-08                        |                                      |
      | 1 | Erik           | 1965-08-12                        | 1973-08-12                           |

  Scenario: ontbonden huwelijk
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999992806
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Osama          | 2000-01-15                        | 2001-11-09                           |

  Scenario: peildatum in actueel huwelijk/partnerschap
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met peildatum "2019-09-11"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Karel          | 2009-11-02                        |                                      |

  Scenario: peildatum in ontbonden huwelijk/partnerschap
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met peildatum "2006-01-01"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Björn          | 1987-07-14                        | 2008-07-06                           |

  Scenario: peildatum gelijk aan datum ontbinding
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met peildatum "2008-07-06"
    Dan wordt geen enkele partner teruggegeven

  Scenario: periode begint tijdens huwelijk/partnerschap
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met datumvan "2019-01-01"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Karel          | 2009-11-02                        |                                      |

  Scenario: periode begint vóór aangaan huwelijk/partnerschap
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met datumvan "2009-01-01"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Karel          | 2009-11-02                        |                                      |

  Scenario: periode over meerdere huwelijken/partnerschappen
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met datumvan "2008-01-01" en datumtotenmet "2009-12-31"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Karel          | 2009-11-02                        |                                      |
      | 1 | Björn          | 1987-07-14                        | 2008-07-06                           |

  Scenario: datumvan gelijk aan datum ontbinding
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999992806 met datumvan "2001-11-09"
    Dan wordt geen enkele partner teruggegeven

  Scenario: datumtotenmet gelijk aan datum aangaan
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met datumvan "2009-10-02" en datumtotenmet "2009-11-02"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Karel          | 2009-11-02                        |                                      |

  Scenario: gedeeltelijk onbekende datum huwelijkssluiting
    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met peildatum "1936-01-01"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.jaar  | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Ayaan          | 1936                              |                                      |

    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met datumtotenmet "1936-01-01"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.jaar  | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Ayaan          | 1936                              |                                      |

    Als de partnerhistorie wordt gevraagd van de persoon met burgerservicenummer 999991553 met datumvan "1936-12-31"
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
      | # | naam.voornamen | aangaanHuwelijkPartnerschap.jaar  | ontbindingHuwelijkPartnerschap.datum |
      | 0 | Ayaan          | 1936                              |                                      |
