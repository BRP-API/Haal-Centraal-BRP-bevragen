# language: nl

Functionaliteit: Huwelijken en geregistreerd partnerschappen van een persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- het (de) huwelijk(en) of geregistreerd partnerschap(pen) geleverd.
  Dit bevat de gegevens over de relatie (huwelijk of partnerschap) plus enkele identificerende eigenschappen van de persoon waarmee het huwelijk of partnerschap is aangegaan.

  Rule: Alleen een actueel huwelijk of geregistreerd partnerschap wordt teruggegeven.
    # Een huwelijk of partnerschap is actueel wanneer het niet is ontbonden: groep 07 Ontbinding huwelijk/geregistreerd partnerschap komt niet voor (heeft geen waarde)

    # N.B. Je kan ontbonden/beëindigde huwelijken of partnerschappen raadplegen met de Haal-Centraal-BRP-historie-bevragen API.

    Scenario: Actueel huwelijk
      Gegeven de persoon met burgerservicenummer 999990184 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | soort verbintenis (15.10) | Voornamen (02.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) | Onjuist (84.10) |
        | 5         | H                         | Merel             | 20010215              |                          |                 |
      Als de ingeschreven persoon met burgerservicenummer 999990184 wordt geraadpleegd met fields=partners
      Dan bevat het antwoord een partner met naam.voornamen "Merel"

    Scenario: Actueel partnerschap
      Gegeven de persoon met burgerservicenummer 999993380 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | soort verbintenis (15.10) | Voornamen (02.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) | Onjuist (84.10) |
        | 5         | P                         | Reindert          | 20040506              |                          |                 |
      Als de ingeschreven persoon met burgerservicenummer 999993380 wordt geraadpleegd met fields=partners
      Dan bevat het antwoord een partner met naam.voornamen "Reindert"

    Scenario: Huwelijk/partnerschap is ontbonden
      Gegeven de persoon met burgerservicenummer 999992806 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Voornamen (02.10) | Datum aangaan (06.10) | Datum ontbinding (07.10) | Onjuist (84.10) |
        | 5         | Osama             |                       | 20011109                 |                 |
        | 55        | Osama             | 20000115              |                          |                 |
      Als de ingeschreven persoon met burgerservicenummer 999992806 wordt geraadpleegd met fields=partners
      Dan bevat het antwoord GEEN partners

    Scenario: Een actueel huwelijk en een ontbonden huwelijk
      Gegeven de persoon met burgerservicenummer 999991553 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Voornamen | Datum aangaan (06.10) | Datum ontbinding (07.10) |
        | 5         | Karel     | 20091102              |                          |
        | 5         | Björn     |                       | 20080706                 |
        | 55        | Björn     | 19870714              |                          |
        | 55        | Björn     | 19870714              |                          |
      Als de ingeschreven persoon met burgerservicenummer 999991553 wordt geraadpleegd met fields=partners
      Dan bevat het antwoord 1 partner
      En bevat het antwoord de partner met naam.voornamen "Karel"
      En bevat het antwoord GEEN partner met naam.voornamen "Björn"


  Rule: Een partner wordt niet opgenomen wanneer het huwelijk of het partnerschap onjuist is
    # Een huwelijk of partnerschap is onjuist wanneer het categorie 5 voorkomen geen (waarden in) groepen 01, 02, 03, 04, 06, 07 en 15 heeft.
    # N.B. Het meest recente categorie 55 voorkomen heeft dan een waarde voor Onjuist (84.10).

    Scenario: Huwelijk/partnerschap is onjuist
      Gegeven de persoon met burgerservicenummer 999993008 heeft de volgende huwelijken/partnerschappen in de registratie
        | Categorie | Voornamen (02.10) | Datum aangaan (06.10) | soort verbintenis (15.10) | Datum ontbinding (07.10) | Reden ontbinding (07.40) | Onjuist (84.10) | Registergemeente akte (81.10) | Aktenummer (81.20) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
        | 5         |                   |                       |                           |                          |                          |                 | 0518                          | 5XC1111            | 20050818                        | 20050818                   |
        | 55        | Youssef Saïd      | 20050811              | P                         |                          |                          | O               | 0518                          | 5XC1111            | 20050811                        | 20050812                   |
      En in categorie 5 zijn alleen groepen of 81 of 82, 85 en 86 opgenomen en geen groepen 01, 02, 03, 04, 06, 07 en 15
      Als de ingeschreven persoon met burgerservicenummer 999993008 wordt geraadpleegd met fields=partners
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
      Als de ingeschreven persoon met burgerservicenummer 555550001 wordt geraadpleegd met fields=partners
      Dan bevat het antwoord 1 partner
      En bevat het antwoord de partner met naam.voornamen "Karel" en geslachtsaanduiding "man"
      En bevat het antwoord GEEN partner met naam.voornamen "Charlotte" en geslachtsaanduiding "vrouw"
