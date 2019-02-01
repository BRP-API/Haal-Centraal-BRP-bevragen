# language: nl

Functionaliteit: Sommige datum-attributen kunnen een onvolledige datum bevatten
  Mogelijk onvolledige datums worden in het bericht weergegeven met vier attributen:
    - datum
    - jaar
    - maand
    - dag

  Wanneer de volledige datum bekend is, worden alle vier attributen gevuld met een waarde.

  Wanneer niet de volledige datum bekend is, hebben alleen de attributen waarvan de waarde bekend is een waarde.

  Scenario: Volledige datum bekend
    Gegeven de registratie ingeschreven persoon 999999047 kent met geboortedatum 26 mei 1983 (19830526)
    Als de ingeschreven persoon 999999047 wordt geraadpleegd
    Dan heeft attribuut geboorte.datum.datum de waarde "1983-05-26"
    En heeft attribuut geboorte.datum.jaar de waarde 1983
    En heeft attribuut geboorte.datum.maand de waarde 5
    En heeft attribuut geboorte.datum.dag de waarde 26

  Scenario: Jaar en maand van de datum zijn bekend
    Gegeven de registratie ingeschreven persoon 999999291 kent met geboortedatum januari 1975 (19750100)
    Dan is attribuut geboorte.datum.datum niet aanwezig of null
    En heeft attribuut geboorte.datum.jaar de waarde 1975
    En heeft attribuut geboorte.datum.maand de waarde 1
    En is attribuut geboorte.datum.dag niet aanwezig of null

  Scenario: Alleen jaar van de datum is bekend
    Gegeven de registratie ingeschreven persoon 999999308 kent met geboortedatum 1975 (19750000)
    Dan is attribuut geboorte.datum.datum niet aanwezig of null
    En heeft attribuut geboorte.datum.jaar de waarde 1975
    En is attribuut geboorte.datum.maand niet aanwezig of null
    En is attribuut geboorte.datum.dag niet aanwezig of null

  Scenario: Er is geen geboortedatum bekend
    Gegeven de registratie ingeschreven persoon 999999308 kent geen geboortedatum (00000000)
    Dan is groep geboorte.datum niet aanwezig of null
    
