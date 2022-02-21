# language: nl

Functionaliteit: Huwelijken en geregistreerd partnerschappen van een persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- het (de) huwelijk(en) of geregistreerd partnerschap(pen) geleverd.
  Dit bevat de gegevens over de relatie (huwelijk of partnerschap) plus enkele identificerende eigenschappen van de persoon waarmee het huwelijk of partnerschap is aangegaan.

  Rule: Alleen een actueel huwelijk of geregistreerd partnerschap wordt teruggegeven.
    # Een huwelijk of partnerschap is actueel wanneer het niet is ontbonden: groep 07 Ontbinding huwelijk/geregistreerd partnerschap komt niet voor (heeft geen waarde)

    # N.B. Je kan ontbonden/beëindigde huwelijken of partnerschappen raadplegen met de Haal-Centraal-BRP-historie-bevragen API.

    Scenario: Actueel huwelijk
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990184 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde |
      | voornamen (02.10) | Merel  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 20010215 |
      | soort verbintenis (15.10) | H        |
      | indicatie onjuist (84.10) |          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990184                       |
      | fields              | partners.naam.voornamen         |
      Dan heeft de persoon met burgerservicenummer '999990184' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992935           |
      En heeft de partner met burgerservicenummer '999992935' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Merel  |

    Scenario: Actueel partnerschap
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993380 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde   |
      | voornamen (02.10) | Reindert |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 20040506 |
      | soort verbintenis (15.10) | P        |
      | indicatie onjuist (84.10) |          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993380                       |
      | fields              | partners.naam.voornamen         |
      Dan heeft de persoon met burgerservicenummer '999993380' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992935           |
      En heeft de partner met burgerservicenummer '999992935' de volgende 'naam' gegevens
      | naam      | waarde   |
      | voornamen | Reindert |

    Scenario: Huwelijk/partnerschap is ontbonden
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992806 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde |
      | voornamen (02.10) | Osama  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 20000115 |
      | indicatie onjuist (84.10) |          |
      En de partner heeft de volgende ontbindingHuwelijkPartnerschap gegevens
      | naam                     | waarde   |
      | datum ontbinding (07.10) | 20011109 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993380                       |
      | fields              | partners.naam.voornamen         |
      Dan heeft de persoon met burgerservicenummer '999993380' GEEN 'partners'

    Scenario: Een actueel huwelijk en een ontbonden huwelijk
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999991553 |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992935 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde |
      | voornamen (02.10) | Karel  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 20091102 |
      | indicatie onjuist (84.10) |          |
      En de persoon heeft een partner met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992936 |
      En de partner heeft de volgende naam gegevens
      | naam              | waarde |
      | voornamen (02.10) | Björn  |
      En de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens
      | naam                      | waarde   |
      | datum aangaan (06.10)     | 19870714 |
      | indicatie onjuist (84.10) |          |
      En de partner heeft de volgende ontbindingHuwelijkPartnerschap gegevens
      | naam                     | waarde   |
      | datum ontbinding (07.10) | 20080706 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999991553                       |
      | fields              | partners.naam.voornamen         |
      Dan heeft de persoon met burgerservicenummer '999991553' alleen 'partners' met de volgende gegevens
      | burgerservicenummer |
      | 999992935           |
      En heeft de partner met burgerservicenummer '999992935' de volgende 'naam' gegevens
      | naam      | waarde |
      | voornamen | Karel  |


  Rule: Een partner wordt niet opgenomen wanneer het huwelijk of het partnerschap onjuist is
    # Een huwelijk of partnerschap is onjuist wanneer het categorie 5 voorkomen geen (waarden in) groepen 01, 02, 03, 04, 06, 07 en 15 heeft.
    # N.B. Het meest recente categorie 55 voorkomen heeft dan een waarde voor Onjuist (84.10).

    Scenario: Huwelijk/partnerschap is onjuist
      Gegeven de persoon met burgerservicenummer 999993008 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Voornamen (02.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | Onjuist (84.10) | Registergemeente akte (81.10) | Aktenummer (81.20) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
        | 5         |                   |                       |                           |                          |                          |                 | 0518                          | 5XC1111            | 20050818                        | 20050818                   |
        | 55        | Youssef Saïd      | 20050811              | P                         |                          |                          | O               | 0518                          | 5XC1111            | 20050811                        | 20050812                   |
      En in categorie 5 zijn alleen groepen of 81 of 82, 85 en 86 opgenomen en geen groepen 01, 02, 03, 04, 06, 07 en 15
      Als de persoon met burgerservicenummer 999993008 wordt geraadpleegd met fields=partners
      Dan bevat het antwoord GEEN partners


  Rule: de geleverde partnergegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
    # bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van de partner

    Scenario: De partner heeft geslachtswijziging ondergaan, maar de gevraagde persoon erkent dit niet
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Burgerservicenummer (01.20) | Voornamen | Geslachtsaanduiding (04.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) |
        | 5         | 555550002                   | Karel     | M                           | 20091102              |                          |
      En de partner met burgerservicenummer 555550002 heeft haar geslachtsaanduiding en voornamen gewijzigd zodat de volgende persoonsgegevens in de registratie op haar persoonslijst staan:
        | Categorie | Voornamen | Geslachtsaanduiding (04.10) |
        | 1         | Charlotte | V                           |
        | 51        | Karel     | M                           |
      Als de persoon met burgerservicenummer 555550001 wordt geraadpleegd met fields=partners
      Dan bevat het antwoord 1 partner
      En bevat het antwoord de partner met naam.voornamen "Karel" en geslachtsaanduiding "man"
      En bevat het antwoord GEEN partner met naam.voornamen "Charlotte" en geslachtsaanduiding "vrouw"
