#!/usr/bin/env python

"""
Genereert csv bestand met de optimale paden voor elk veld in de response.
Het bestand heeft twee kolommen: "fields pad" en "volledig pad".
De kolom "fields pad" bevat het pad die in de "fields" parameter ingevuld kan worden.
In kolom "volledig pad" staat het volledige pad naar het veld dat moet worden geleverd.
Per veld in de response is er één rij opgenomen met het kortst mogelijke pad dat uniek verwijst naar het veld.
Er zijn rijen opgenomen voor simple type velden (string, integer, boolean), en ook voor objecten (groepen velden).

Deze lijst bevat geen velden die al automatisch geleverd zullen worden (bijv. geheimhouding, inOnderzoek en type).
De velden die automatisch geleverd worden staan in het configuratiebestand in "autoFields".

De csv lijst wordt opgeslagen onder de naam "fields-{schemaComponent}.csv", waarbij {schemaComponent} de naam is van de schemacomponent voor de resource in de response.

Command line arguments:
--config        bestand van projectspecifieke configuratie json bestand
--debug   -d    toon debug info
--info    -i    toon voortgang info
--help    -h    toon help op command line arguments

Gebruik dit door bijvoorbeeld: python fields_generator.py --config"settings.json"

Als input wordt de fields mapping gebruikt die is gegevenereerd met fields_mapping_generator.py. Deze moet dus eerst gedraaid worden vóór fields_generator kan worden gedraaid.
"""


import yaml, json
from collections import OrderedDict
import sys
import os.path


# lees command line arguments
debug = False
info = False
settingsFileName = ""

for argument in sys.argv:
    if (argument[:8]=="--config"):
        settingsFileName = argument[8:]
    if (argument=="--debug" or argument=="-d"):
        debug = True
        info = True
    elif (argument=="--info" or argument=="-i"):
        info = True
    elif (argument=="--help" or argument=="-h"):
        print ('Command line arguments:')
        print ('--config         bestand van projectspecifieke configuratie json bestand')
        print (' --info    -i    toon voortgangs info')
        print (' --debug   -d    toon debug info')
        print (' --help    -h    toon help op command line arguments')
        sys.exit()

# lees configuratiebestand
if settingsFileName!="":
    with open(settingsFileName) as settingsFile:
        SETTINGS = json.load(settingsFile)
else:
    print ("Geef het gewenste config bestand op met parameter --config.")
    sys.exit()



def readFieldsFile (fileName):
    f = open (fileName, "r")
    fieldLines = f.read().splitlines() 
    f.close()

    fields = []
    for fieldLine in fieldLines[1:]:
        fields.append(readLine(fieldLine))

    return fields


def readLine (csvLine):
    row = csvLine.split(SETTINGS.get('csvSeperator'))
    return { "shortPath": row[0], "fullPath": row[1]}


def isAutoField (fieldPath, autoFields):
    for autoField in autoFields:
        if autoField in fieldPath:
            return True

    if fieldPath.lower().count("datum") > 1:
        if debug==True:
            print ("Dubbele Datum: " + fieldPath)
        return True

    return False


def fieldLength(e):
    return len(e.get("shortPath"))


def double(newItem, currentList):
    sameItem = next((item for item in currentList if item["fullPath"] == newItem.get("fullPath")), None)
    
    if sameItem is None:
        return False
    else:
        return True

# voor elk schemaComponents item in het configuratiebestand wordt een bestand gegenereerd
for schemaComponent in SETTINGS.get("schemaComponents"):
    if info==True:
        print (schemaComponent.get("name"))

    inputPath = SETTINGS.get("projectFolder") + SETTINGS.get("fieldslistFolder") + "fields-mapping-"  + schemaComponent.get("name") + ".csv"
    outputPath = SETTINGS.get("projectFolder") + SETTINGS.get("fieldslistFolder") + "fields-"  + schemaComponent.get("name") + ".csv"

    fields = readFieldsFile(inputPath)

    """
    voor een schemacomponent die een subset is van een andere schemacomponent (bijv. zoekresultaat bevat een deel van de velden van raadpleegresultaat)
    wordt de fields-mapping van de complete resource gebruikt
    om te voorkomen dat voor de kleinere component paden worden toegestaan die in de volledige resource niet uniek zijn
    """
    if schemaComponent.get("fullResource") is not None:
        if info==True:
            print ("  -- full resource:", schemaComponent.get("fullResource"))

        fullResourcePath = SETTINGS.get("projectFolder") + SETTINGS.get("fieldslistFolder") + "fields-mapping-"  + schemaComponent.get("fullResource") + ".csv"
        fullResourceFields = readFieldsFile(fullResourcePath)

    filteredFields = []
    for field in fields:
        # velden die automatisch (ongevraagd) worden geleverd worden niet opgenomen
        if isAutoField(field.get("fullPath"), SETTINGS["autoFields"]):
            continue

        # elk veld(pad) wordt maximaal 1 keer opgenomen
        if double(field, filteredFields):
            continue

        if schemaComponent.get("fullResource") is not None:
            samePath = list( filter(lambda f: f.get("fullPath")==field.get("fullPath"), fullResourceFields) )
        else:
            samePath = list( filter(lambda f: f.get("fullPath")==field.get("fullPath"), fields) )
            
        samePath.sort(key=fieldLength)        
        filteredFields.append(samePath[0])

    # schrijf de lijst als csv bestand
    f = open (outputPath, "w")
    f.write ("fields pad" + SETTINGS.get('csvSeperator') + "volledig pad\n")
    for field in filteredFields:
        f.write (field.get("shortPath") + SETTINGS.get('csvSeperator') + field.get("fullPath") + "\n")
    f.close()
