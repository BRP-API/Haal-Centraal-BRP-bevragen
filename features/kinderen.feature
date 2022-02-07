# language: nl

<<<<<<< HEAD
Functionaliteit: Kinderen van een ingeschreven persoon raadplegen
  Van een inschreven persoon worden -indien gevraagd met de fields parameter- de kinderen geleverd.
  Dit bevat enkele identificerende eigenschappen van de kinderen.

  Rule: de actuele gegevens van kinderen worden geleverd

    Scenario: de naam van een kind is gecorrigeerd
      Gegeven de persoon met burgerservicenummer 999996150 heeft de volgende kinderen in de registratie
        | Categorie | Voornamen (02.10)  | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Onjuist (84.10) |
        | 9         | William            |                     | Postma                |                 |
        | 59        | William            | de                  | Vries                 |                 |
        | 59        | William            | de                  | Boer                  | O               |
        | 9         | Sebastiaan         | de                  | Boer                  |                 |
        | 9         | Walter             | de                  | Boer                  |                 |
        | 59        | Walter             |                     | Messeritz             | O               |
      Als de ingeschreven persoon met burgerservicenummer 999996150 wordt geraadpleegd met fields=kinderen
      Dan bevat het antwoord 3 kinderen
      En bevat het antwoord het kind met naam.voornamen "William" naam.geslachtsnaam "Postma"
      En bevat het antwoord het kind met naam.voornamen "Sebastiaan" naam.geslachtsnaam "Boer"
      En bevat het antwoord het kind met naam.voornamen "Walter" naam.geslachtsnaam "Boer"

    Scenario: naamswijziging kind
      Gegeven de persoon met burgerservicenummer 999996381 heeft de volgende kinderen in de registratie
        | Categorie | Voornamen (02.10) |
        | 9         | Vica              |
        | 59        | Celeke Lodivica   |
        | 9         | Bella             |
      Als de ingeschreven persoon met burgerservicenummer 999996381 wordt geraadpleegd met fields=kinderen
      Dan bevat het antwoord 2 kinderen
      En bevat het antwoord het kind met naam.voornamen "Vica"
      En bevat het antwoord het kind met naam.voornamen "Bella"
      En bevat het antwoord GEEN kind met naam.voornamen "Celeke Lodivica"
  

  Rule: Een kind wordt alleen teruggegeven als minimaal één gegeven in de identificatienummers (groep 01), naam (groep 02) of geboorte (groep 03) van het kind een waarde heeft.
    # wanneer in een categorie kind alleen gegevens zijn opgenomen in groep 81 of 82, 85 en 86, wordt dit kind niet opgenomen in het antwoord
    # wanneer een gegeven een onbekendwaarde heeft, zoals . (punt) bij geslachtsnaam en 00000000 bij geboortedatum, wordt die in deze regel beschouwd als leeg (geen waarde).

    Scenario: kind volledig onbekend
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende kinderen in de registratie
        | Categorie | Voornamen (02.10)  | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) |
        | 9         |                    |                     | .                     |                       |
      En er zijn geen andere gegevens geregistreerd over de identificatienummers (groep 01), naam (groep 02) of geboorte (groep 03) in categorie 9
      Als de ingeschreven persoon met burgerservicenummer 555550001 wordt geraadpleegd met fields=kinderen
      Dan bevat het antwoord GEEN kinderen

    Scenario: ontkenning ouderschap
      Gegeven de persoon met burgerservicenummer 555550002 heeft de volgende kinderen in de registratie
        | Categorie | Voornamen (02.10)  | Voorvoegsel (02.30) | Geslachtsnaam (02.40) | Geboortedatum (03.10) | Gemeente document (82.10) | Datum document (82.20) | Beschrijving document (82.30) | Ingangsdatum geldigheid (85.10) | Datum van opneming (86.10) |
        | 9         |                    |                     |                       |                       | 1926                      | 20040105               | D27894-2004-A782              | 20031107                        | 20040112                   |
        | 59        | Daan               | de                  | Vries                 | 20031107              | 0518                      | 20031109               | PL gerelateerde               | 20031107                        | 20031109                   |             
      En er zijn geen gegevens geregistreerd over de identificatienummers (groep 01), naam (groep 02) of geboorte (groep 03) in categorie 9
      Als de ingeschreven persoon met burgerservicenummer 555550002 wordt geraadpleegd met fields=kinderen
      Dan bevat het antwoord GEEN kinderen

  
Rule: de geleverde kindgegevens zijn de gegevens zoals die staan op de persoonslijst van de gevraagde persoon
  # bij het raadplegen van een persoon worden alleen gegevens uit de persoonslijst van de gevraagde persoon gebruikt, en nooit gegevens van de persoonslijst van het kind

  Scenario: Het kind heeft geslachtswijziging ondergaan, maar de gevraagde persoon erkent dit niet
    Gegeven de persoon met burgerservicenummer 555550003 heeft de volgende kinderen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Voornamen |
      | 9         | 555550004                   | Karel     |
      | 9         | 555550005                   | Ellen     |
    En het kind met burgerservicenummer 555550004 heeft haar geslachtsaanduiding en voornamen gewijzigd zodat de volgende persoonsgegevens in de registratie op haar persoonslijst staan:
      | Categorie | Voornamen | Geslachtsaanduiding (04.10) |
      | 1         | Charlotte | V                           |
      | 51        | Karel     | M                           |
    Als de ingeschreven persoon met burgerservicenummer 555550003 wordt geraadpleegd met fields=kinderen
    Dan bevat het antwoord 2 kinderen
    En bevat het antwoord het kind met naam.voornamen "Karel"
    En bevat het antwoord het kind met naam.voornamen "Ellen"
    En bevat het antwoord GEEN kind met naam.voornamen "Charlotte"
=======
Functionaliteit: Kinderen van een persoon raadplegen
  Van een inschreven persoon kunnen kinderen worden opgevraagd als sub-resource van de persoon. De sub-resource kinderen bevat de gegevens over de ouder-kindrelatie inclusief enkele eigenschappen van het betreffende kind.

  Wanneer het kind een persoon is, levert de sub-resource kinderen de actuele gegevens van het kind zoals die op de PL van het betreffende kind staan (dus NIET zoals ze in categorie 09/59 Kind staan).

  Scenario: de persoon heeft geen kind
    Gegeven de te raadplegen persoon heeft geen (geregistreerde) kinderen
    Als de kinderen worden geraadpleegd van de persoon met burgerservicenummer 999999011
    Dan is het aantal gevonden kinderen 0

  Scenario: het kind is een personen
    Gegeven de te raadplegen persoon heeft een kind dat zelf persoon is
    En het kind van de persoon heeft in de registratie burgerservicenummer 999999047, naam Franklin	Groenen, geboren op 26 mei 1983
    Als de kinderen worden geraadpleegd van de persoon met burgerservicenummer 999999382
    Dan is het aantal gevonden kinderen 1
    En wordt het kind gevonden met burgerservicenummer=999999047
    En heeft dit kind naam.voornamen=Franklin
    En heeft dit kind naam.voorvoegsel=null
    En heeft dit kind naam.geslachtsnaam=Groenen
    En heeft dit kind naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En heeft dit kind geboorte.datum.datum=1983-05-26
    En heeft dit gevonden kind de ingeschrevenpersonen link met /ingeschrevenpersonen/999999047

  Scenario: het kind is geen persoon
    Gegeven de te raadplegen persoon heeft een kind die zelf geen persoon is
    En het kind van de persoon heeft volgens categorie 09/59 naam Chantal Groenen, geboren in Istanbul en geboortedatum 2 januari 2002
    Als de kinderen worden geraadpleegd van de persoon met burgerservicenummer 999999291
    Dan wordt het kind gevonden met naam.voornamen=Chantal
    En heeft dit kind burgerservicenummer=null
    En heeft dit kind naam.voorvoegsel=null
    En heeft dit kind naam.geslachtsnaam=Groenen
    En heeft dit kind naam.adellijkeTitel_predikaat.omschrijvingAdellijkeTitel_predikaat=null
    En heeft dit kind geboorte.datum.datum=2002-01-02
    En heeft dit kind geboorte.datum.dag=02
    En heeft dit kind geboorte.datum.maand=01
    En heeft dit kind geboorte.plaats=Istanbul
    En heeft dit kind geboorte.land.landnaam=Turkije
    En heeft dit gevonden kind een lege link ingeschrevenpersonen

  Scenario: de persoon twee kinderen
    Gegeven de te raadplegen persoon heeft meerdere (twee) kinderen (Lisa en Daan)
    Als de kinderen worden geraadpleegd van de persoon met burgerservicenummer 999999047
    Dan is het aantal gevonden kinderen 2
    En wordt het kind gevonden met naam.voornamen=Lisa
    En wordt het kind gevonden met naam.voornamen=Daan

  Scenario: de persoon heeft drie kinderen
    Gegeven de te raadplegen persoon heeft drie kinderen (Jip, Chantal en Jesse)
    Als de kinderen worden geraadpleegd van de persoon met burgerservicenummer 999999291
    Dan is het aantal gevonden kinderen 3
    En wordt het kind gevonden met naam.voornamen=Jip
    En wordt het kind gevonden met naam.voornamen=Chantal
    En wordt het kind gevonden met naam.voornamen=Jesse

  Scenario: kind ophalen vanuit links van persoon via sub-resource kinderen
    Gegeven de te raadplegen persoon heeft een kind dat zelf persoon is
    En het kind van de persoon heeft in de registratie burgerservicenummer 999999047, naam Franklin	Groenen, geboren op 26 mei 1983
    Als de persoon met burgerservicenummer 999999382 wordt geraadpleegd
    En de link kinderen wordt gevolgd
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
