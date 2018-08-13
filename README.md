# RSGB-bevragingen

RSGB bevragingen is een berichtenstandaard voor het opvragen van gegevens zoals beschreven in het RSGB.

Inhoudelijk startpunt voor de bevragingen zijn de geïnventariseerde vragen die zijn opgesteld door de werkgroep RSGB bevragingen en vastgelegd in standaard [RSGB-bevragingen 1.0](https://www.gemmaonline.nl/index.php/RSGB_Bevragingen).

Startpunt voor informatiemodellen van gegevens in de berichten is RSGB 3.

Startpunt voor technische uitwisselafspraken voor de te ontwikkelen RESTfull API operaties is de DSO API strategie en DSO URI strategie. 

De koppelvlakstandaard voor bevragings-API’s zijn modulair opgebouwd. De koppelvlakstandaard is opgebouwd in 6 modules, voor de verschillende domeinen:
* BAG (basisgegevens adressen en gebouwen)
  * Module adressen en gebouwen
* BRK (basisresgistratie Kadaster)
  * Module kadastrale onroerende zaken
* BRP (basisregistratie personen)
  * Module ingeschreven personen
* HR (handelsregister)
  * Module maatschappelijke activiteiten
  * Module vestiging
  * Module Ingeschreven Niet-Natuurlijk Persoon

## Achtergrond
In 2017 is koppelvlakstandaard [RSGB-bevragingen 1.0](https://www.gemmaonline.nl/index.php/RSGB_Bevragingen) ontwikkeld en vastgesteld, met daarin een aantal geïnventariseerde vragen op RSGB. Deze versie is gebaseerd op informatiemodel RSGB 2.0. Technisch bestaat deze standaard uit een SOAP/XML (niet StUF) variant en een RPC/JSON variant.

Inmiddels is er bij gemeenten behoefte ontstaan aan de architectuurontwikkeling [Common Ground](https://vng.nl/samen-organiseren/common-ground). Als onderdeel van die ontwikkeling is er behoefte aan het direct bij de bron kunnen bevragen van gegevens, inplaats van het distribureren en kopiëren van gegevens over veel verschillende gemeentelijke systemen. Daarom worden er afspraken gemaakt met de bronhouders (landelijke voorzieningen en basisregistraties), bijvoorbeeld het Kadaster voor BAG en BRK en Kamer van Koophandel voor HR) voor het ontsluiten van de gegevens.

Hierbij hoort ook een transitie naar actuele informatiemodellen, in dit geval de overgang naar RSGB 3, én naar moderne uitwisseltechnieken en -architectuurstijlen (in dit geval RESTfull API's op basis van JSON). We streven voor de uitwisseltechnieken naar het bewegen richting één overheidsbrede API strategie. Het startpunt hiervoor is de [DSO API strategie](https://aandeslagmetdeomgevingswet.nl/digitaal-stelsel/documenten/documenten/api-uri-strategie/).

In 2018 is er een pilot gedaan met de gemeente Den Haag en het Kadaster voor het direct bevragen van BRK gegevens bij het Kadaster. Naar aanleiding van constateringen uit deze pilot is/wordt RSGB 3 geactualiseerd, zodat het beter aansluit op de informatiemodellen en datamodellen van de bronnen waaruit gegevens worden bevraagd.
Voor het domein BRP is juist RSGB 3 aangepast naar het GBA model, aangezien de ontwikkeling van BRP is stopgezet.

Vanuit VNG Realisatie, en op verzoek van verschillende gemeenten, is ook de manier waarop koppelvlakstandaarden worden ontwikkeld aangepast. Een meer agile aanpak, waarbij direct getoetst wordt op een aantal criteria, met name met betrekking tot de eenvoud van implementatie. Het ontwikkelen van test- of referentie-implementaties maakt direct onderdeel uit van het ontwikkelen van koppelvlakken.

## Documentatie
* Hoe u kunt [bijdragen](https://github.com/VNG-Realisatie/Tutorial/blob/master/CONTRIBUTING.md)
* [Omgangsvormen](https://github.com/VNG-Realisatie/Tutorial/blob/master/CODE_OF_CONDUCT.md)

## Contactpersonen:
* Projectleider: Frank Samwel frank.samwel@vng.nl
* Berichtontwerper: Johan Boer johan.boer@vng.nl

## Licentie
Licensed onder [EUPL](https://eupl.eu/1.2/nl/)
