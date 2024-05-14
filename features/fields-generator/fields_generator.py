#!/usr/bin/env python

"""
Genereert csv bestand met alle toegestane paden naar velden in de response.
De gegenereerde lijst bevat alle mogelijke waarden die in de "fields" parameter ingevuld kunnen worden.

Er zijn rijen opgenomen voor simple type velden (string, integer, boolean), en ook voor objecten (groepen velden).

Deze lijst bevat ook velden die niet expliciet met fields gevraagd hoeven te worden, omdat die al automatisch geleverd 
zullen worden: type (van verblijfplaats en nationaliteit), sub-velden van datum (datum, langFormaat, enz.), sub-velden van waardetabel (code en omschrijving).
Gebruik command line argument --filter om de lijst velden te krijgen zonder de automatisch geleverde velden.

De csv lijst wordt opgeslagen onder de naam "fields-{schemaComponent}.csv", waarbij {schemaComponent} de naam is van de 
schemacomponent voor de resource in de response.
Bij gebruik van het --filter argument wordt de csv lijst opgeslagen onder de naam "fields-filtered-{schemaComponent}.csv", waarbij {schemaComponent} de naam is van de 
schemacomponent voor de resource in de response.

Command line arguments:
--config        bestand van projectspecifieke configuratie json bestand
--filter        velden die automatisch worden geleverd worden niet opgenomen in de lijst
--debug   -d    toon debug info
--info    -i    toon voortgang info
--help    -h    toon help op command line arguments

Gebruik dit door bijvoorbeeld: python fields_generator.py --config"settings.json"
"""


import yaml, json
from collections import OrderedDict
import sys
import os.path

def writeComponent (path, ref, referer=""):
    if debug==True:
        print ("-- " + ref)

    if ref in SETTINGS.get("forbiddenFields"):
        return

    refList = ref.split("/")
    component =  SWAGGER
    for refPart in refList:
        if refPart != "#":
            component = component.get(refPart)

    if refPart in SETTINGS.get("autoComponents"):
        path += "(A)"

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

    if component.get('type') == "array":
        if "$ref" in component.get('items'):
            writeComponent (path, component.get("items").get("$ref"))

    if component.get("discriminator") is not None:
        for discriminator, component in  component.get("discriminator").get("mapping").items():
            if debug==True:
                print ("mapping: " + discriminator + " ==> " + component)

            writeComponent (path, component, ref)


def writeProperty(path, property, propertyDef):
    if property in SETTINGS.get("forbiddenFields"):
        return

    if property in SETTINGS.get("autoFields"):
        property += '(A)'

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

    if "allOf" in propertyDef:
        for object in propertyDef.get("allOf"):
            if "$ref" in object:
                writeComponent (path, object.get("$ref"))

            if "properties" in object:
                properties = sorted(object.get("properties").items())
                for property, propertyDef in properties:
                    writeProperty(path, property, propertyDef)

    if "properties" in propertyDef:
        properties = sorted(propertyDef.get("properties"))
        for subProperty, subPropertyDef in properties:
            writeProperty(path, subProperty, subPropertyDef)

            if subProperty=="type":
                print ("type")

    if propertyDef.get('type') == "array":
        if "$ref" in propertyDef.get('items'):
            writeComponent (path, propertyDef.get("items").get("$ref"))


def isAutoField(field):
    return not "(A)" in field


def aliasExcluded(field, aliasField, aliasExcludedFields):
    if not field.startswith(aliasField):
        return False

    for i in range(len(field.split("."))-1, 0, -1):
        if field.split(".")[i] in aliasExcludedFields:
            return False

    return True


def createAliasFields(filterAutoFields, fields):
    aliasFields = []

    if filterAutoFields==True:
        aliasList = SETTINGS.get("aliasesFiltered")
    else:
        aliasList = SETTINGS.get("aliases")

    for alias in aliasList:
        for field in fields:
            if aliasExcluded(field, alias["field"], alias["excludeFields"]):
                aliasFields.append(field.replace(alias["field"], alias["alias"]))

    return aliasFields




# read command line arguments
debug = False
info = False
filterAutoFields = False
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
        print ('--filter         velden die automatisch worden geleverd worden niet opgenomen in de lijst')
        print (' --info    -i    toon voortgangs info')
        print (' --debug   -d    toon debug info')
        print (' --help    -h    toon help op command line arguments')
        sys.exit()
    if (argument=="--filter"):
        filterAutoFields = True


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

if (not os.path.isdir(SETTINGS.get("projectFolder") + SETTINGS.get("fieldslistFolder"))):
    print ("Geef een correcte locatie op voor de te genereren csv bestanden in fieldslistFolder.")
    print (SETTINGS.get("projectFolder") + SETTINGS.get("fieldslistFolder"))
    sys.exit()


#read source API specifications file into a Dict
SWAGGER = yaml.full_load(open(SETTINGS.get("projectFolder") + SETTINGS.get("sourceYaml")))

for schemaComponent in SETTINGS.get("schemaComponents"):
    if info==True:
            print (schemaComponent.get("name"))

    if filterAutoFields==True:
        filePath = SETTINGS.get("projectFolder") + SETTINGS.get("fieldslistFolder") + "fields-filtered-"  + schemaComponent.get("name") + ".csv"
    else:
        filePath = SETTINGS.get("projectFolder") + SETTINGS.get("fieldslistFolder") + "fields-"  + schemaComponent.get("name") + ".csv"

    fields = []
    writeComponent ("", "#/components/schemas/" + schemaComponent.get("name"))
    
    fields = list(dict.fromkeys(fields)) # remove double fields paths

    if filterAutoFields==True:
        fields = list(filter(isAutoField, fields))

    fields = [ field.replace("(A)", "") for field in fields ] # remove indicator "(A)" for autofields

    fields.extend(createAliasFields(filterAutoFields, fields))

    f = open (filePath, "w")

    f.write ("pad\n")
    for field in fields:
        f.write (field + "\n")
    f.close()
