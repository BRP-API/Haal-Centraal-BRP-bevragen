# language: nl

@gba
Functionaliteit: aangaan huwelijk/partnerschap bij actuele of ontbonden relatie

  Bij het registreren van het ontbinden van een huwelijk of partnerschap worden alle gegevens over het huwelijk of partnerschap 
  en alle gegegevens over de partner overgenomen in het actuele voorkomen, behalve de gegevens over het aangaan van 
  het huwelijk of partnerschap.
  Het gevolg is dat bij een ontbonden huwelijk of partnerschap de gegevens over het aangaan van het huwelijk/partnerschap niet 
  in het actuele voorkomen in de registratie staan. De gegevens over aangaan van het huwelijk/partnerschap moeten worden gehaald
  uit het eerste historische voorkomen waarin deze voorkomen.

  Regel: aangaanHuwelijkPartnerschap wordt bij een niet-ontbonden partner -indien gevraagd met fields- geleverd

    Scenario: partnerschap is niet ontbonden
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

    Scenario: partnerschap is niet ontbonden en gegevens over het aangaan van het huwelijk zijn gewijzigd
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                                                                | waarde    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | 20010809  |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | Parijs    |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 5002      |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                                | waarde    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | 20010908  |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | Brussel   |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 5010      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetBurgerservicenummer      |
      | burgerservicenummer | 000000012                            |
      | fields              | partners.aangaanHuwelijkPartnerschap |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde   |
      | datum               | 20010908 |
      | plaats.omschrijving | Brussel  |
      | land.code           | 5010     |
      | land.omschrijving   | België   |

  Regel: aangaanHuwelijkPartnerschap wordt bij een ontbonden partner gehaald uit het meest recente voorkomen van de partner waarbij aangaanHuwelijkPartnerschap een waarde heeft

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
      | datum               | 20010808  |
      | plaats.omschrijving | Parijs    |
      | land.code           | 5002      |
      | land.omschrijving   | Frankrijk |

    Scenario: partnerschap is ontbonden en gegevens over het aangaan en ontbinden zijn gewijzigd
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                                                                | waarde    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | 20010801  |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | Parijs    |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 5002      |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                                | waarde    |
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)  | 20010902  |
      | plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20) | Brussel   |
      | land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)   | 5010      |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20180103 |
      En de 'partner' is gewijzigd naar de volgende gegevens
      | naam                                                         | waarde   |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20180104 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetBurgerservicenummer      |
      | burgerservicenummer | 000000012                            |
      | fields              | partners.aangaanHuwelijkPartnerschap |
      Dan heeft de response een persoon met een 'partner' met alleen de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam                | waarde   |
      | datum               | 20010902 |
      | plaats.omschrijving | Brussel  |
      | land.code           | 5010     |
      | land.omschrijving   | België   |
