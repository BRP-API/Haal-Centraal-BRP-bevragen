#!/usr/bin/env python

"""
Genereert csv bestand met alle mogelijke unieke paden naar velden in de response.
Het bestand heeft twee kolommen: "fields pad" en "volledig pad".
De gegenereerde lijst bevat in kolom "fields pad" alle mogelijke waarden die in de "fields" parameter ingevuld kunnen worden.
In kolom "volledig pad" staat dan de mapping naar het veld dat moet worden geleverd.
De kolom "fields pad" bevat het al dan niet ingekorte pad dat uniek verwijst naar één veld.
De kolom "volledig pad" bevat het volledige pad naar het veld.
Er kunnen meerdere rijen zijn, dus meerdere verschillende "fields pad" waarden, die verwijzen naar hetzelfde veld, dus met dezelfde waarde voor "volledig pad".
Er zijn rijen opgenomen voor simple type velden (string, integer, boolean), en ook voor objecten (groepen velden).

Deze lijst bevat ook velden die niet expliciet met fields gevraagd hoeven te worden, omdat die al automatisch geleverd zullen worden (bijv. geheimhouding, inOnderzoek en type).

De csv lijst wordt opgeslagen onder de naam "fields-mapping-{schemaComponent}.csv", waarbij {schemaComponent} de naam is van de schemacomponent voor de resource in de response.

Command line arguments:
--config        bestand van projectspecifieke configuratie json bestand
--debug   -d    toon debug info
--info    -i    toon voortgang info
--help    -h    toon help op command line arguments

Gebruik dit door bijvoorbeeld: python fields_mapping_generator.py --config"settings.json"
"""


import yaml, json
from collections import OrderedDict
import sys
import os.path



def writeComponent (path, ref, referer=""):
    if debug==True:
        print ("-- " + ref)
    refList = ref.split("/")
    component =  SWAGGER
    for refPart in refList:
        if refPart != "#":
            component = component.get(refPart)

    if refPart in SETTINGS.get("dateComponents"):
        path += "(D)"

    if component.get("properties") is not None:
        properties = sorted(component.get("properties").items())
        for property, propertyDef in properties:
            writeProperty(path, property, propertyDef)

    elif component.get("allOf") is not None:
        for object in component.get("allOf"):
            if "$ref" in object:
                if object.get("$ref")!=referer:
                    writeComponent (path, object.get("$ref"), ref)

            if "properties" in object:
                properties = sorted(object.get("properties").items())
                for property, propertyDef in properties:
                    writeProperty(path, property, propertyDef)

    if component.get("discriminator") is not None:
        for discriminator, component in  component.get("discriminator").get("mapping").items():
            if debug==True:
                print ("mapping: " + discriminator + " ==> " + component)

            writeComponent (path, component, ref)


def writeProperty(path, property, propertyDef):
    if path!="":
        fields.append(path + "." + property)
    else:
        fields.append(property)

    if path=="":
        path = property
    else:
        path = path + "." + property

    if "$ref" in propertyDef:
        writeComponent (path, propertyDef.get("$ref"))

    if "properties" in propertyDef:
        properties = sorted(propertyDef.get("properties"))
        for subProperty, subPropertyDef in properties:
            writeProperty(path, subProperty, subPropertyDef)

            if subProperty=="type":
                print ("type")

    if propertyDef.get('type') == "array":
        if "$ref" in propertyDef.get('items'):
            writeComponent (path, propertyDef.get("items").get("$ref"))


def inOnderzoek(path):
    if path.find("inOnderzoek")>-1:
        return path

    pl = path.split(".")
    pl.insert(-1, "inOnderzoek")
    return ".".join(pl)


def unique(path):
    if debug==True:
        print(path.get("shortPath"))
    
    if path.get("shortPath")==path.get("fullPath"):
        return True

    if path.get("fullPath")==inOnderzoek(path.get("fullPath")):
        if len(list(filter(lambda p: p.get("shortPath")==path.get("shortPath"), unfilteredFieldPaths)))==1:
            return True
    else:
        if len(list(filter(lambda p: p.get("shortPath")==path.get("shortPath") and p.get("fullPath")!=inOnderzoek(path.get("fullPath")), unfilteredFieldPaths)))==1:
            return True

    return False

    
def removeDateField(path):
    if "(D)" in path["fullPath"]:
        path["shortPath"] = path.get("shortPath").replace("(D)", "")

    if "(D)" in path["fullPath"]:
        path["fullPath"] = path.get("fullPath").split("(D)")[0]

    return path


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

if (not os.path.isdir(SETTINGS.get("projectFolder"))):
    print ("Geef een correcte projectFolder in het config bestand.")
    sys.exit()

if (not os.path.isfile(SETTINGS.get("projectFolder") + SETTINGS.get("sourceYaml"))):
    print ("Geef een correcte locatie op voor de API specificaties in sourceYaml.")
    sys.exit()

if (not os.path.isdir(SETTINGS.get("projectFolder") + SETTINGS.get("sheetFolder"))):
    print ("Geef een correcte locatie op voor de te genereren sheets in sheetFolder.")
    print (SETTINGS.get("projectFolder") + SETTINGS.get("sheetFolder"))
    sys.exit()


#lees bron API specificatiesbestand naar een Dict
SWAGGER = yaml.full_load(open(SETTINGS.get("projectFolder") + SETTINGS.get("sourceYaml")))

# voor elk schemaComponents item in het configuratiebestand wordt een bestand gegenereerd
for schemaComponent in SETTINGS.get("schemaComponents"):
    if info==True:
            print (schemaComponent.get("name"))

    filePath = SETTINGS.get("projectFolder") + SETTINGS.get("fieldslistFolder") + "fields-mapping-"  + schemaComponent.get("name") + ".csv"

    # lees alle velden uit de API specificaties van de resource schemacomponent
    fields = []
    writeComponent ("", "#/components/schemas/" + schemaComponent.get("name"))
    
    # verwijder dubbele fields paden
    fields = list(dict.fromkeys(fields)) 

    fieldPaths = []
    for field in fields:
        fieldPaths.append({ "shortPath": field, "fullPath": field})

        # voeg verkort pad toe aan veld
        pathList = field.split(".")
        if len(pathList)>1:
            for i in range(-len(pathList)+1, 0):
                fieldPaths.append({ "shortPath": ".".join(pathList[i:]), "fullPath": field})

    # verwijder niet-unieke paden
    unfilteredFieldPaths = fieldPaths
    fieldPaths = filter(unique, fieldPaths)

    # verwijder deelvelden van een datum
    fieldsList = list(map(removeDateField, fieldPaths))

    # voeg gba mapping toe
    fieldsList = list(map(addGbaMapping, fieldsList)) 

    # schrijf de lijst als csv bestand
    f = open (filePath, "w")
    f.write ("fields pad" + SETTINGS.get('csvSeperator') + "volledig pad\n")
    for field in fieldsList:
        f.write (field.get("shortPath") + SETTINGS.get('csvSeperator') + field.get("fullPath") + "\n")
    f.close()
