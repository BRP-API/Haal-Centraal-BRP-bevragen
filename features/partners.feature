# language: nl

<<<<<<< HEAD
Functionaliteit: Huwelijken en geregistreerd partnerschappen van een ingeschreven persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- het (de) huwelijk(en) of geregistreerd partnerschap(pen) geleverd. 
  Dit bevat de gegevens over de relatie (huwelijk of partnerschap) plus enkele identificerende eigenschappen van de persoon waarmee het huwelijk of partnerschap is aangegaan.
=======
Functionaliteit: Huwelijken en geregistreerd partnerschappen van een persoon raadplegen
  Van een inschreven persoon kan het/kunnen de huwelijk(en) of geregistreerd partnerschap(pen) worden opgevraagd als sub-resource van de persoon. De sub-resource partners bevat de gegevens over de relatie (huwelijk of partnerschap) inclusief enkele eigenschappen van de persoon waarmee het huwelijk of partnerschap is aangegaan.
>>>>>>> 96452ba758f4213c93a9c32b1a6e1f1a81359dda

  Rule: Alleen een actueel huwelijk of geregistreerd partnerschap wordt teruggegeven.
    # Een huwelijk of partnerschap is actueel wanneer het niet is ontbonden: groep 07 Ontbinding huwelijk/geregistreerd partnerschap komt niet voor (heeft geen waarde)

    # N.B. Je kan ontbonden/beëindigde huwelijken of partnerschappen raadplegen met de Haal-Centraal-BRP-historie-bevragen API.

<<<<<<< HEAD
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
=======
  Wanneer de partner een persoon is, levert de sub-resource partners de actuele gegevens van de partner zoals die op de PL van de partner staan (dus NIET zoals ze in categorie 05/55 Huwelijk/geregistreerd partnerschap staan).

  Scenario: er is geen partner
    Gegeven de te raadplegen persoon heeft geen (actuele) partner
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999011
    Dan is het aantal gevonden partners 0

  Scenario: de partner is persoon
    Gegeven de te raadplegen persoon heeft een partner die zelf persoon is
    En de partner van de persoon heeft in de registratie burgerservicenummer 999999047, voornaam Franklin en geslachtsnaam Groenen
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999023
    Dan is het aantal gevonden partners 1
    En wordt de partner gevonden met burgerservicenummer=999999047
    En heeft deze partner naam.voornamen=Franklin
    En heeft deze partner naam.geslachtsnaam=Groenen
    En heeft de gevonden partner link ingeschrevenpersonen met /ingeschrevenpersonen/999999047

  Scenario: de partner is geen persoon
    Gegeven de te raadplegen persoon heeft een partner die zelf geen persoon is
    En de partner van de persoon heeft volgens categorie 05/55 naam Dieter von Weit, geboren in Würzburg en geboortedatum 19 juni 1989
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999436
    Dan is het aantal gevonden partners 1
    En wordt de partner gevonden met burgerservicenummer=null
    En heeft deze partner naam.voornamen=Dieter
    En heeft deze partner naam.voorvoegsel=von
    En heeft deze partner naam.geslachtsnaam=Weit
    En heeft de gevonden partner een lege link ingeschrevenpersonen

  Scenario: de persoon heeft meerdere partners
    Gegeven de te raadplegen persoon heeft meerdere (twee) actuele partners (Ali en Iskander)
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden partners 2
    En wordt de partner gevonden met naam.voornamen=Ali
    En wordt de partner gevonden met naam.voornamen=Iskander

  Scenario: de persoon heeft een beëindigde relatie
    Gegeven de te raadplegen persoon heeft een beëindigde relatie
    En de te raadplegen persoon heeft geen andere of nieuwe relatie
    Als de partners worden geraadpleegd van de persoon met burgerservicenummer 999999321
    Dan is het aantal gevonden partners 0

  Scenario: partner ophalen vanuit links van persoon via sub-resource partners
    Gegeven de te raadplegen persoon heeft een partner die zelf persoon is
    En de partner van de persoon heeft in de registratie burgerservicenummer 999999047, voornaam Franklin en geslachtsnaam Groenen
    Als de persoon met burgerservicenummer 999999023 wordt geraadpleegd
    En de link partners wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999047
    En is in het antwoord naam.voornamen=Franklin
    En is in het antwoord naam.voorvoegsel=null
    En is in het antwoord naam.geslachtsnaam=Groenen
    En is in het antwoord naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En is in het antwoord geboorte.datum.datum=1983-05-26
    Als de link ingeschrevenpersonen wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999047
    En is in het antwoord naam.voornamen=Franklin
    En is in het antwoord geslachtsaanduiding=M
>>>>>>> 96452ba758f4213c93a9c32b1a6e1f1a81359dda
