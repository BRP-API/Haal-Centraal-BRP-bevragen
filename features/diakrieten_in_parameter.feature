# language: nl

Functionaliteit: Zoeken met diakrieten
  Wanneer een diakriet wordt opgegeven, wordt deze ook gebruikt. Dit geldt voor alle attributen die gedefinieerd zijn als string.
    Bijvoorbeeld zoeken op "Stöcker" vindt wel "Stöcker", maar niet "Stocker".

  Wanneer geen diakriet wordt opgegeven, worden equivalente diakrieten ook gevonden. Bijvoorbeeld zoeken op "Stocker" vindt "Stocker" én "Stöcker".

  Dit geldt niet wanneer de zoekparameter gedefinieerd is als enumeratie. In dat geval moet de exacte enumeratiewaarde worden gebruikt.

  Wanneer er een pattern is gedefinieerd op een attribuut, moet de invoer inclusief de eventuele diakrieten voldoen aan het patroon. Bijvoorbeeld zoeken op postcode=1234äB levert een foutmelding, want dit voldoet niet aan het patroon "^[1-9]{1}[0-9]{3}[A-Z]{2}".

Scenario: Wanneer een diakriet wordt opgegeven, wordt deze ook gebruikt
  Als personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=ve*&naam__voornamen=andré*
  Dan wordt de persoon gevonden met naam.voornamen=André
  En wordt geen persoon gevonden met naam.voornamen=Andrea
  Als personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=velden&naam__voornamen=Mariëlle
  Dan wordt de persoon gevonden met naam.voornamen=Mariëlle
  En wordt geen persoon gevonden met naam.voornamen=Marielle

Scenario: Wanneer geen diakriet wordt opgegeven, worden equivalente diakrieten ook gevonden
  Als personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=velden&naam__voornamen=andre
  Dan wordt de persoon gevonden met naam.voornamen=André
  #Als personen gezocht worden met ?geboorte__datum=1983-05-26&naam__geslachtsnaam=veld&geboorteplaats=malmo
  #Dan wordt de persoon gevonden met geboorte.plaats=Malmø
  Als personen gezocht worden met ?verblijfplaats__postcode=9744CZ&verblijfplaats__huisnummer=7&naam__voornamen=celik
  Dan wordt de persoon gevonden met naam.voornamen=Çelik
  Als personen gezocht worden met ?verblijfplaats__postcode=9744CZ&verblijfplaats__huisnummer=7&naam__voornamen=Celik
  Dan wordt de persoon gevonden met naam.voornamen=Çelik
