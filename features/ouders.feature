# language: nl

Functionaliteit: Ouders van een ingeschreven persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- het ouders geleverd.
  Dit bevat gegevens over de familierechtelijke betrekking plus enkele identificerende eigenschappen van de ouder.

  Rule: "ouder1" is de ouder in categorie 2 en "ouder2" is de ouder in categorie 3

    Scenario: Persoon heeft twee ouders
      Gegeven de persoon met burgerservienummer 999993653 heeft de volgende ouders in de registratie
        | Categorie | Voornamen (02.10)  |
        | 2         | Lisette            |
        | 3         | Guîllaumé          |
      Als de ingeschreven persoon met burgerservicenummer 999993653 wordt geraadpleegd met fields=ouders
      Dan bevat het antwoord 2 ouders
      En bevat het antwoord de ouder met naam.voornamen "Lisette" en ouderAanduiding "ouder1"
      En bevat het antwoord de ouder met naam.voornamen "Guîllaumé" en ouderAanduiding "ouder2"


  Rule: de actuele gegevens van ouders worden geleverd

    Scenario: oudergegevens gecorrigeerd
      Gegeven de persoon met burgerservienummer 999996186 heeft de volgende ouders in de registratie
        | Categorie | Voornamen (02.10)  | Onjuist (84.10) |
        | 2         | Chantal            |                 |
        | 3         | Mark               |                 |
        | 53        | Christiaan         | O               |
      Als de ingeschreven persoon met burgerservicenummer 999996186 wordt geraadpleegd met fields=ouders
      Dan bevat het antwoord 2 ouders
      En bevat het antwoord de ouder met naam.voornamen "Chantal" en ouderAanduiding "ouder1"
      En bevat het antwoord de ouder met naam.voornamen "Mark" en ouderAanduiding "ouder2"

    Scenario: geslachtswijziging ouder
      Gegeven de persoon met burgerservienummer 555550001 heeft de volgende ouders in de registratie
        | Categorie | Voornamen (02.10)  | Geslachtsaanduiding (04.10) |
        | 2         | Noa                | V                           |
        | 3         | Johanna            | V                           |
        | 53        | John               | M                           |
      Als de ingeschreven persoon met burgerservicenummer 555550001 wordt geraadpleegd met fields=ouders
      Dan bevat het antwoord 2 ouders
      En bevat het antwoord de ouder met naam.voornamen "Noa" en geslachtsaanduiding "vrouw"
      En bevat het antwoord de ouder met naam.voornamen "Johanna" en geslachtsaanduiding "vrouw"
      En bevat het antwoord GEEN ouder met naam.voornamen "John" en geslachtsaanduiding "man"

    Scenario: adoptie
      Gegeven de persoon met burgerservienummer 999996629 heeft de volgende ouders in de registratie
        | Categorie | Voornamen (02.10)  | Datum ingang familierechtelijke betrekking (62.10) | Onjuist (84.10) |
        | 2         | Olivia Ghislaine   | 20190317                                           |                 |
        | 52        | Me'Lisa            | 20170106                                           |                 |
        | 52        |                    | 00000000                                           | O               |
        | 3         | Kevin              | 20190317                                           |                 |
        | 53        |                    |                                                    |                 |
        | 53        |                    | 00000000                                           | O               |
      Als de ingeschreven persoon met burgerservicenummer 999996629 wordt geraadpleegd met fields=ouders
      Dan bevat het antwoord 2 ouders
      En bevat het antwoord de ouder met naam.voornamen "Olivia Ghislaine" en ouderAanduiding "ouder1"
      En bevat het antwoord de ouder met naam.voornamen "Kevin" en ouderAanduiding "ouder2"

    Scenario: ontkenning gevolgd door erkenning
      Gegeven de persoon met burgerservienummer 999996162 heeft de volgende ouders in de registratie
        | Categorie | Voornamen (02.10)  | Onjuist (84.10) |
        | 2         | Chantal            |                 |
        | 3         | Wieger             |                 |
        | 53        |                    |                 |
        | 53        | Mark               | O               |
      Als de ingeschreven persoon met burgerservicenummer 999996162 wordt geraadpleegd met fields=ouders
      Dan bevat het antwoord 2 ouders
      En bevat het antwoord de ouder met naam.voornamen "Chantal" en ouderAanduiding "ouder1"
      En bevat het antwoord de ouder met naam.voornamen "Wieger" en ouderAanduiding "ouder2"
  

Rule: Een ouder wordt alleen teruggegeven als minimaal één gegeven in de naam (groep 02), geboorte (groep 03) van de ouder is gevuld.
  # Een onbekende geslachtsnaam opgenomen als . (punt) wordt hier beschouwd als NIET gevuld

  Scenario: ouder volledig onbekend
    Gegeven de persoon met burgerservienummer 999991796 heeft de volgende ouders in de registratie
      | Categorie | Geslachtsnaam (02.40)  | Geboortedatum (03.10) | Geslachtsaanduiding (04.10) | Datum ingang familierechtelijke betrekking (62.10) | Onjuist (84.10) |
      | 2         | .                      |                       | V                           | 19800506                                           |                 |
      | 3         | .                      |                       | M                           | 19800506                                           |                 |
    En er zijn geen andere gegevens geregistreerd over de naam (groep 02), geboorte (groep 03) of burgerservicenummer (01.20) in categorie 2
    En er zijn geen andere gegevens geregistreerd over de naam (groep 02), geboorte (groep 03) of burgerservicenummer (01.20) in categorie 3
    Als de ingeschreven persoon met burgerservicenummer 999991796 wordt geraadpleegd met fields=ouders
    Dan bevat het antwoord GEEN ouders

  Scenario: ontkenning ouderschap
    Gegeven de persoon met burgerservienummer 555550002 heeft de volgende ouders in de registratie
      | Categorie | Voornamen (02.10)  | Geslachtsnaam (02.40)  | Geboortedatum (03.10) | Onjuist (84.10) |
      | 2         | Margriet           | Vries                  | 19280621              |                 |
      | 3         |                    |                        |                       |                 |
      | 53        | Sjaak              | Groenen                | 19239519              | O               |
    En er zijn geen gegevens geregistreerd over de naam (groep 02), geboorte (groep 03) of burgerservicenummer (01.20) in categorie 3
    Als de ingeschreven persoon met burgerservicenummer 555550002 wordt geraadpleegd met fields=ouders
    Dan bevat het antwoord 1 ouder
    En bevat het antwoord de ouder met naam.voornamen "Margriet" en ouderAanduiding "ouder1"
    En bevat het antwoord GEEN ouder met naam.voornamen "Sjaak" en ouderAanduiding "ouder2"

  
Rule: de geleverde oudergegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
  # bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van de ouder

  Scenario: De ouder heeft geslachtswijziging ondergaan, maar de gevraagde persoon erkent dit niet
    Gegeven de persoon met burgerservicenummer 555550003 heeft de volgende ouders in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen | Geslachtsaanduiding (04.10) |
      | 2         | 555550004                   | Karel     | M                           |
      | 3         | 555550005                   | Ellen     | V                           |
    En de ouder met burgerservicenummer 555550004 heeft haar geslachtsaanduiding en voornamen gewijzigd zodat de volgende persoonsgegevens in de registratie op haar persoonslijst staan:
      | Categorie | Voornamen | Geslachtsaanduiding (04.10) |
      | 1         | Charlotte | V                           |
      | 51        | Karel     | M                           |
    Als de ingeschreven persoon met burgerservicenummer 555550003 wordt geraadpleegd met fields=ouders
    Dan bevat het antwoord 2 ouders
    En bevat het antwoord de ouder met naam.voornamen "Karel" en geslachtsaanduiding "man"
    En bevat het antwoord de ouder met naam.voornamen "Ellen" en geslachtsaanduiding "vrouw"
    En bevat het antwoord GEEN ouder met naam.voornamen "Charlotte" en geslachtsaanduiding "vrouw"  
