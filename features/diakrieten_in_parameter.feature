# language: nl

Functionaliteit: Zoeken met diakrieten
  Wanneer een diakriet wordt opgegeven, wordt deze ook gebruikt. Dit geldt voor alle attributen die gedefinieerd zijn als string.
    Bijvoorbeeld zoeken op "Stöcker" vindt wel "Stöcker", maar niet "Stocker".

  Wanneer geen diakriet wordt opgegeven, worden equivalente diakrieten ook gevonden. Bijvoorbeeld zoeken op "Stocker" vindt "Stocker" én "Stöcker".

  Dit geldt niet wanneer de zoekparameter gedefinieerd is als enumeratie. In dat geval moet de exacte enumeratiewaarde worden gebruikt.

  Wanneer er een pattern is gedefinieerd op een attribuut, moet de invoer inclusief de eventuele diakrieten voldoen aan het patroon. Bijvoorbeeld zoeken op postcode=1234äB levert een foutmelding, want dit voldoet niet aan het patroon "^[1-9]{1}[0-9]{3}[A-Z]{2}".

Scenario: Wanneer een diakriet wordt opgegeven, wordt deze ook gebruikt
  Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam_geslachtsnaam=ve*&voornamen=andré*
  Dan wordt de ingeschreven persoon gevonden met naam.voornamen=André
  En wordt geen ingeschreven persoon gevonden met naam.voornamen=Andrea
  Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=velden&voornamen=Mariëlle
  Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Mariëlle
  En wordt geen ingeschreven persoon gevonden met naam.voornamen=Marielle

Scenario: Wanneer geen diakriet wordt opgegeven, worden equivalente diakrieten ook gevonden
  Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=groenen&voornamen=Andre
  Dan wordt de ingeschreven persoon gevonden met naam.voornamen=André
  Als ingeschreven personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=veld&geboorteplaats=malmo
  Dan wordt de ingeschreven persoon gevonden met geboorte.plaats=Malmø
  Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode&naam__voornamen=celik
  Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Çelik
  Als ingeschreven personen gezocht worden met ?verblijfplaats__postcode&naam__voornamen=Celik
  Dan wordt de ingeschreven persoon gevonden met naam.voornamen=Çelik
