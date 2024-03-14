# Fields generator

Deze map bevat Python een script waarmee vanuit de open API specificaties de volgende bestanden worden gegenereerd:
- fields-persoon.csv
- fields-persoonBeperkt.csv
- fields-filtered-persoon.csv
- fields-filtered-persoonBeperkt.csv

## fields-Persoon en fields-PersoonBeperkt
De bestanden fields-Persoon.csv en fields-PersoonBeperkt.csv bevatten alle mogelijke (toegestane) paden die in de "fields" parameter ingevuld mogen worden. Vraag je met fields een veld dat niet in deze lijst voorkomt, dan geeft de API een foutmelding.

Deze lijst bevat ook velden die niet expliciet met fields gevraagd hoeven te worden, omdat die al automatisch geleverd zullen worden: type (van verblijfplaats en nationaliteit).

Deze lijst bevat ook velden van een datum en waardetabel. Die mag je invullen, maar in dat geval worden alle velden van dat datumveld dan wel die waardetabel (code en omschrijving) geleverd.

Er zijn rijen opgenomen voor losse velden (simple type velden zoals string, integer, boolean), en ook voor het vragen van hele groepen (objecten).

## fields-filtered-Persoon en fields-filtered-PersoonBeperkt
De bestanden fields-filtered-Persoon.csv en fields-filtered-PersoonBeperkt.csv bevatten alle paden die in de "fields" parameter ingevuld kunnen worden. Gebruik deze lijst om gewenste velden uit te kiezen om de fields parameter mee samen te stellen.

Deze lijst bevat geen velden die wel in de resource zitten, maar niet expliciet met fields gevraagd hoeven te worden, omdat die al automatisch geleverd zullen worden.
Deze lijst bevat ook geen sub-velden van een datum of waardetabel, omdat datum- of waardetabelobjecten altijd in zijn geheel geleverd worden. Idem voor adellijkeTitelPredicaat (is uitgebreide waardetabel). Zelfde geldt voor gezag, omdat het vragen van een veld uit gezag altijd alle relevante velden van gezag levert.

Er zijn rijen opgenomen voor losse velden (simple type velden zoals string, integer, boolean), en ook voor het vragen van hele groepen (objecten).

## Voor je begint met genereren
- Voor Persoon en PersoonBeperkt gebruiken we brp_persoon.json. In de configuratie moet je in ieder geval "projectFolder" aanpassen, zodat dit correct verwijst naar waar de GitHub repository van BRP Personen bevragen staat, met daarin de specificaties (/specificatie/genereervariant/openapi.yaml) en de locatie waar de gegenereerde bestanden geplaatst worden (/features).
- Installeer -als je dat nog niet hebt- Python 3. De genereerscripts werken mogelijk niet correct met python 2.
- Installeer - als je dat nog niet hebt- het pyyaml package.

## Genereren van de fields lijsten
De bestanden worden gegenereerd door het script fields_generator.py. 

Dit script vraagt minimaal command line argument --config met daarin een verwijzing naar het configuratiebestand. 

Voer in de command line uit met bijvoorbeeld:
`python3 fields_generator.py --config"brp_persoon.json"`

Om fields-filtered-Persoon en fields-filtered-PersoonBeperkt te genereren voeg je command line argument --filter toe.
Bijvoorbeeld:
`python3 fields_generator.py --config"brp_persoon.json" --filter`



