# Design decisions
Dit document beschrijft ontwerpkeuzes die gemaakt zijn voor het ontwerpen en specificeren van de API's in dit koppelvlak.

Beslissing | Ratio
---------- | -----
Tabelentiteiten worden in het bericht opgenomen met zowel de code als de omschrijving | garanderen dat verschillende systemen binnen en buiten de gemeente dezelfde (toestand) van de tabel kennen is duur, ingewikkeld en foutgevoelig.
Enumeraties worden in het bericht opgenomen met de enumeratiewaarde (omschrijving), niet de code. Bijvoorbeeld voor geslacht wordt "Vrouw" of "Man" gestuurd, niet "V" of "M". | Uitgangspunt binnen Common Ground is gebruik van gegevens, niet opslag van gegevens. Dus de omschrijving (uitgeschreven waarde) is relevant voor de gebruiker.
Entiteittypen die een suptype zijn van een ander (al dan niet abstract) entiteittype (supertype), worden als zodanig gespecificeerd in de Open API specificaties. Bijvoorbeeld een "ingeschreven natuurlijk persoon" is een "natuurlijk persoon" is een "persoon" is een "subject". In Open API Specificaties 3 wordt dit gespecificeerd via allOf met referentie naar de schema component van het supertype.
