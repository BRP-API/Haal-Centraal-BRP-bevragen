# language: nl

<<<<<<< HEAD
Functionaliteit: Ouders van een ingeschreven persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- de ouders geleverd.
  Dit bevat gegevens over de familierechtelijke betrekking plus enkele identificerende eigenschappen van de ouder.

  Rule: "ouder1" is de ouder in categorie 2 en "ouder2" is de ouder in categorie 3
=======
Functionaliteit: Ouders van een persoon raadplegen
  Van een inschreven persoon kunnen ouders worden opgevraagd als sub-resource van de persoon. De sub-resource ouders bevat de gegevens over de kind-ouderrelatie inclusief enkele eigenschappen van de betreffende ouder.

  Wanneer de ouder een persoon is, levert de sub-resource ouders de actuele gegevens van de ouder(s) zoals die op de PL van de betreffende ouder staan (dus NIET zoals ze in categorie 02/52 Ouder1 of 03/53 Ouder2 staan).
>>>>>>> 96452ba758f4213c93a9c32b1a6e1f1a81359dda

    Scenario: Persoon heeft twee ouders
      Gegeven de persoon met burgerservienummer 999993653 heeft de volgende ouders in de registratie
        | Categorie | Voornamen (02.10)  |
        | 2         | Lisette            |
        | 3         | Guîllaumé          |
      Als de ingeschreven persoon met burgerservicenummer 999993653 wordt geraadpleegd met fields=ouders
      Dan bevat het antwoord 2 ouders
      En bevat het antwoord de ouder met naam.voornamen "Lisette" en ouderAanduiding "ouder1"
      En bevat het antwoord de ouder met naam.voornamen "Guîllaumé" en ouderAanduiding "ouder2"

<<<<<<< HEAD

  Rule: de actuele gegevens van ouders worden geleverd
=======
  Scenario: er is geen ouder
    Gegeven de te raadplegen persoon heeft geen geregistreerde ouders
    Als de ouders worden geraadpleegd van de persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden ouders 0

  Abstract Scenario: een ouder is onjuist of onbekend
    Gegeven op de PL van een persoon is categorie ouder leeg met uitzondering van de <bij onjuist of onbekend ingevulde kenmerken> kenmerken
    Als de ouders worden geraadpleegd van de persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden ouders 0
    En zijn er geen links naar de onbekende ouders
>>>>>>> 96452ba758f4213c93a9c32b1a6e1f1a81359dda

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

<<<<<<< HEAD
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
=======
  Scenario: de ouders zijn personen
    Gegeven de te raadplegen persoon heeft een ouder die zelf persoon is
    En de Ouder1 van de persoon heeft in de registratie burgerservicenummer 999999382, naam Jonkheer Franciscus Theodorus in 't Groen
    En de Ouder2 van de persoon heeft in de registratie burgerservicenummer 999999394, naam Philomena Blaauw
    Als de ouders worden geraadpleegd van de persoon met burgerservicenummer 999999047
    Dan wordt de ouder gevonden met ouder_aanduiding=1
    En heeft deze ouder burgerservicenummer=999999382
    En heeft deze ouder geslachtsaanduiding=M
    En heeft deze ouder naam.voornamen=Franciscus Theodorus
    En heeft deze ouder naam.voorvoegsel=in 't
    En heeft deze ouder naam.geslachtsnaam=Groen
    En heeft deze ouder naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=Jonkheer
    En heeft deze gevonden ouder de ingeschrevenpersonen link met /ingeschrevenpersonen/999999382
    En wordt de ouder gevonden met ouder_aanduiding=2
    En heeft deze ouder burgerservicenummer=999999394
    En heeft deze ouder geslachtsaanduiding=V
    En heeft deze ouder naam.voornamen=Philomena
    En heeft deze ouder naam.voorvoegsel=null
    En heeft deze ouder naam.geslachtsnaam=Blaauw
    En heeft deze ouder naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En heeft deze gevonden ouder de ingeschrevenpersonen link met /ingeschrevenpersonen/999999394

  Scenario: de ouder is geen persoon
    Gegeven de te raadplegen persoon heeft een ouder die zelf geen persoon is
    En de Ouder2 van de persoon heeft volgens categorie 05/55 naam Markiezin Marie du Partenaire, geboren in Saintt-Quentin-en-Tourmont en geboortedatum 2 november 1979
    Als de ouders worden geraadpleegd van de persoon met burgerservicenummer 999999011
    Dan wordt de ouder gevonden met ouder_aanduiding=2
    En heeft deze ouder burgerservicenummer=null
    En heeft deze ouder naam.voornamen=Marie
    En heeft deze ouder naam.voorvoegsel=du
    En heeft deze ouder naam.geslachtsnaam=Partenaire
    En heeft deze ouder naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=Markiezin
    En heeft deze ouder geboorte.datum.datum=1972-08-31
    En heeft deze ouder geboorte.datum.dag=31
    En heeft deze ouder geboorte.datum.maand=08
    En heeft deze ouder geboorte.plaats=Saintt-Quentin-en-Tourmont
    En heeft deze ouder geboorte.land.landnaam=Frankrijk
    En heeft deze gevonden ouder een lege link ingeschrevenpersonen

  Scenario: de persoon heeft twee ouders
    Gegeven de te raadplegen persoon heeft meerdere (twee) ouders (Marie en Cornelis Petrus Johannus)
    Als de ouders worden geraadpleegd van de persoon met burgerservicenummer 999999011
    Dan is het aantal gevonden ouders 2
    En wordt de ouder gevonden met naam.voornamen=Marie
    En wordt de ouder gevonden met naam.voornamen=Cornelis Petrus Johannus

  Scenario: de persoon heeft drie ouders
    Gegeven de te raadplegen persoon heeft drie ouders
    Als de ouders worden geraadpleegd van de persoon met burgerservicenummer 999999448
    Dan is het aantal gevonden ouders 3

  Scenario: ouder ophalen vanuit links van persoon via sub-resource ouders
    Gegeven de te raadplegen persoon heeft één ouder dat zelf persoon is
    En de ouder van de persoon heeft in de registratie burgerservicenummer 999999291, naam Çelik	Groenen, geboren in januari 1975 (geboortedag is onbekend)
    Als de persoon met burgerservicenummer 999999424 wordt geraadpleegd
    En de link ouders wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999291
    En is in het antwoord naam.voornamen=Çelik
    En is in het antwoord naam.voorvoegsel=null
    En is in het antwoord naam.geslachtsnaam=Groenen
    En is in het antwoord naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En is in het antwoord geboorte.datum.datum=null
    En is in het antwoord geboorte.datum.jaar=1975
    En is in het antwoord geboorte.datum.maand=01
    En is in het antwoord geboorte.datum.dag niet aanwezig of null
    En is in het antwoord geslachtsaanduiding=V
    Als de link ingeschrevenpersonen wordt gevolgd
    Dan is in het antwoord burgerservicenummer=999999291
    En is in het antwoord naam.voornamen=Çelik
    En is in het antwoord geslachtsaanduiding=V
    En is in het antwoord datumVestigingInNederland=2002-08-12
>>>>>>> 96452ba758f4213c93a9c32b1a6e1f1a81359dda
