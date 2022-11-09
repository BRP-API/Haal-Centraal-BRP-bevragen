# Fields generator

Deze map bevat Python 3 scripts waarmee vanuit de open API specificaties de volgende bestanden worden gegenereerd:
- fields-mapping-Persoon.csv
- fields-mapping-PersoonBeperkt.csv
- fields-persoon.csv
- fields-persoonBeperkt.csv

## Voor je begint met genereren
- Voor Persoon en PersoonBeperkt gebruiken we brp_persoon.json. In de configuratie moet je in ieder geval "projectFolder" aanpassen, zodat dit correct verwijst naar waar de GitHub repository van BRP Personen bevragen staat, met daarin de specificaties (/specificatie/genereervariant/openapi.yaml) en de locatie waar de gegenereerde bestanden geplaatst worden (/features).
- Installeer -als je dat nog niet hebt- Python 3. De genereerscripts werken mogelijk niet correct met python 2.
- Installeer - als je dat nog niet hebt- het pyyaml package.

## fields-mapping-Persoon en fields-mapping-PersoonBeperkt
De bestanden fields-mapping-Persoon.csv en fields-mapping-PersoonBeperkt.csv bevatten alle mogelijke (toegestane) paden die verwijzen naar een veld in de response. Naar één veld kan op verschillende manieren worden verwezen, door een verkort pad te gebruiken. Er zijn rijen per veld, maar ook rijen voor het opvragen van een hele groep. 
Bij elk pad staat het bijbehorende volledige pad dat naar het veld verwijst. Bijvoorbeeld aanschrijfwijze,adressering.aanschrijfwijze. Dit betekent dat fields=["aanschrijfwijze"] het veld adressering.aanschrijfwijze moet leveren.

De bestanden fields-mapping-Persoon.csv en fields-mapping-PersoonBeperkt.csv worden gegenereerd door het script fields_mapping_generator.py. 

Dit script vraagt minimaal command line argument --config met daarin een verwijzing naar het configuratiebestand. 

Voer in de command line uit met bijvoorbeeld:
`python3 fields_mapping_generator.py --config"brp_persoon.json" --info`

## fields-persoon en fields-persoonBeperkt
De bestanden fields-persoon.csv en fields-persoonBeperkt.csv bevatten per veld in de response één rij met het kortst mogelijke pad dat uniek verwijst naar het veld.

De bestanden fields-persoon en fields-persoonBeperkt worden gegenereerd door het script fields_generator.py. 

Dit script gebruikt fields-mapping-Persoon.csv en fields-mapping-PersoonBeperkt.csv als input, dus fields mapping moet -na bijvoorbeeld specificatiewijzigingen- eerst gedraaid worden voor fields_generator.py kan worden gedraaid. De scripts in omgekeerde volgorde uitvoeren kan leiden tot inconsistenties tussen de verschillende bestanden.

Dit script vraagt minimaal command line argument --config met daarin een verwijzing naar het configuratiebestand. 

Voer in de command line uit met bijvoorbeeld:
`python3 fields_generator.py --config"brp_persoon.json" --info`
