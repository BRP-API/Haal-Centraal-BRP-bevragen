#!/usr/bin/python

from behave import *
import requests
import re
import config


@given('de registratie ingeschreven personen kent met {eigenschappen}')
def step_impl(context, eigenschappen):
    pass


@given('de registratie ingeschreven personen kent zoals beschreven in {filename}')
def step_impl(context, filename):
    pass


@when('ingeschreven personen gezocht worden zonder parameters')
def step_impl(context):
    url = config.BASEURL + 'ingeschrevennatuurlijkpersonen'
    context.response = requests.get(url)


@when('ingeschreven personen gezocht worden met {querystring}')
def step_impl(context, querystring):
    url = 'http://localhost:8080/ingeschrevennatuurlijkpersonen' + querystring
    context.response = requests.get(url)
    context.querystring = querystring


@then('levert dit zoekresultaten')
def step_impl(context):
    if context.response.status_code >= 400:
        print("http statuscode: " + str(context.response.status_code))
        print("body: " + context.response.text)
    try:
        jsonresponse = context.response.json()
    except Exception as e:
        print("incorrecte json body: " + context.response.text)
        print (e)
        assert False
    assert context.response.status_code < 400


@then('levert dit een foutmelding')
def step_impl(context):
    if context.response.status_code < 400:
        print("http statuscode: " + str(context.response.status_code))
        # print("body: " + context.response.text)
    assert context.response.status_code >= 400


@then('heeft het antwoord een embedded lijst met {resource}')
def step_impl(context, resource):
    b = context.response.json()
    if '_embedded' in b:
        if resource in b['_embedded']:
            if not isinstance(b['_embedded'][resource], list):
                print('De collectie is geen array')
                print(type(b['_embedded'][resource]))
            assert isinstance(b['_embedded'][resource], list)
        else:
            print('Geen collectie ' + resource + ' gevonden in _embedded')
            # print(context.response.text)
            print(b['_embedded'])
            assert False
    else:
        print('Geen _embedded voor collectie van zoekresultaten gevonden')
        # print(context.response.text)
        assert False


@then('heeft elke van de gevonden {resource} {attribuut}={waarde}')
def step_impl(context, resource, attribuut, waarde):
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        attribuutWaarde = GetAttribute(item, attribuut)
        assert attribuutWaarde is not None

        if attribuutWaarde != waarde:
            print('Waarde van ' + attribuut + '=' + attribuutWaarde)
        assert attribuutWaarde == waarde


@then('wordt de ingeschreven persoon gevonden met {attribuut}={waarde}')
def step_impl(context, attribuut, waarde):
    resource = 'ingeschrevennatuurlijkpersonen'
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    resourceFound = False
    for item in collection:
        attribuutWaarde = GetAttribute(item, attribuut)

        if attribuutWaarde is not None and attribuutWaarde == waarde:
            resourceFound = True
            break

    if not resourceFound:
        print('Geen ingeschreven persoon gevonden met ' + attribuut + '=' + waarde)

    assert resourceFound


@then('wordt geen ingeschreven persoon gevonden met {attribuut}={waarde}')
def step_impl(context, attribuut, waarde):
    resource = 'ingeschrevennatuurlijkpersonen'
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        attribuutWaarde = GetAttribute(item, attribuut)

        assert attribuutWaarde is not None and attribuutWaarde == waarde


@then('voldoet elke van de gevonden {resource} aan de query {attribuut}={querywaarde}')
def step_impl(context, resource, attribuut, querywaarde):
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        attribuutWaarde = GetAttribute(item, attribuut)
        if attribuutWaarde is None:
            assert attribuutWaarde is not None
        else:
            queryMatch = AssertWildcardQuery(querywaarde, attribuutWaarde)

        if not queryMatch:
            print('Waarde van ' + attribuut + '=' + attribuutWaarde + ' voldoet niet aan de query ' + querywaarde)
        assert queryMatch


@then('is in elke van de gevonden {resource} attribuut {attribuut} niet aanwezig of null')
def step_impl(context, resource, attribuut):
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        attribuutWaarde = GetAttribute(item, attribuut, False)
        if attribuutWaarde is not None and type(attribuutWaarde) is str:
            print(attribuut + '=' + attribuutWaarde)
        assert attribuutWaarde is None


@then('bevatten alle gevonden {resource} alleen gevraagde embedded attributen')
def step_impl(context, resource):
    assert context.querystring is not None and context.querystring != ""
    if context.querystring.find('expand=') < 0:
        print('Query bevat geen expand parameter, maar die wordt wel verwacht')
    assert context.querystring.find('expand=') >= 0

    expand = context.querystring[context.querystring.find('expand=')+7:]
    if expand.find('&') >= 0:
        expand = expand[:expand.find('&')]

    expandlist = expand.split(',')

    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        embedded = GetAttribute(item, '_embedded', False)
        assert embedded is not None

        '''
        # test dat alle gevraagde attributen in het antwoord zitten
        for expandAttribute in expandlist:
            assert AttributeExists(embedded, expandAttribute)
        '''

        # test dat er geen andere attributen in het antwoord zitten
        assert OnlyAttributesInPathList(expandlist, embedded)

@then(u'hebben alle gevonden {resource} embedded {nestedresource}')
def step_impl(context, resource, nestedresource):
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        embedded = GetAttribute(item, '_embedded.' + nestedresource, False)
        assert embedded is not None


def OnlyAttributesInPathList(toegestanePaden, jsonObject, contextPad=""):
    # Geeft True wanneer elk (groeps)attribuut in jsonObject ook in
    # toegestanePaden zit. Geeft False wanneer een attribuut niet in
    # toegestanePaden is opgenomen.
    # toegestanePaden definieert door punt gescheiden pad naar attributen in
    # json wanneer een groepsattribuut gedefinieerd is in toegestanePaden, zijn
    # ook alle attributen daarin toegestaan.
    if type(jsonObject) is list:
        for inhoud in jsonObject:
            if not OnlyAttributesInPathList(toegestanePaden, inhoud, contextPad):
                return False

    if type(jsonObject) is dict:
        for naam, inhoud in jsonObject.items():
            if contextPad == "":
                pad = naam
            else:
                pad = contextPad + "." + naam
            if not AttributeInPathList(naam, inhoud, pad, toegestanePaden):
                return False

    return True


def AttributeInPathList(naam, inhoud, pad, toegestanePaden):
    if naam in {"_links", "_embedded"}:
        return True
    if pad in toegestanePaden:
        # dit attribuut is toegestaan, door naar de volgende
        return True
    if len(filter(lambda tp: pad in tp, toegestanePaden)) > 0:
        # er is ten minste één attribuut dieper op dit pad toegestaan
        # dus moeten we de inhoud doorzoeken
        if OnlyAttributesInPathList(toegestanePaden, inhoud, pad):
            # de inhoud is gecontroleerd en goed, dus dit attribut ook
            return True
    else:
        print('Attribuut ' + pad + ' niet toegestaan')
    return False


def GetCollection(jsonObject, resource, printError=True):
    # Geeft de collectie (lijst) van resultaten van een zoekopdracht
    # Verwacht json HAL met resource-attribuut als array in _embedded
    # jsonObject bevat _embedded: { resource: [ collectie ] }
    collection = GetAttribute(jsonObject, '_embedded.' + resource, printError)
    if not isinstance(collection, list) and printError:
        print('De collectie is geen array, maar een ' + str(type(collection)))

    return collection


def GetAttribute(jsonObject, jsonAttribute, printError=True):
    # Geeft de inhoud/waarde van een attribuut of None wanneer deze niet
    # gevonden is.
    # jsonAttribute kan de attribuutnaam zijn of het pad naar het gevraagde
    # attribuut, waarbij het pad naar een attribuut wordt gegeven met een .
    # (punt) of __ (dubbele underscore) als scheidingsteken
    # bijvoorbeeld in  {'adres': {'straat': 'broadstreet', 'nummer': 123}}
    # kunnen we met 'adres.straat' or 'adres__straat' de straat ophalen
    jsonpath = jsonAttribute.replace("__", ".").split(".")

    for attribute in jsonpath:
        if isinstance(jsonObject, list):
            jsonObject = next(iter(jsonObject), None)
        if jsonObject is None or attribute not in jsonObject:
            if printError:
                print('Attribuut ' + jsonAttribute + ' is niet gevonden')
            return None

        jsonObject = jsonObject[attribute]

    return jsonObject


def AttributeExists(jsonObject, jsonAttribute):
    # Geeft True wanneer het attribuut gevonden wordt in het jsonObject
    # Geeft False wanneer het attribuut niet gevonden wordt in het jsonObject
    # Wanneer het attribuut wel voorkomt, maar waarde None (null) heeft,
    # wordt True teruggegeven (het attribuut zit immers in het antwoord).
    # jsonAttribute kan de attribuutnaam zijn of het pad naar het gevraagde
    # attribuut, waarbij het pad naar een attribuut wordt gegeven met een .
    # (punt) of __ (dubbele underscore) als scheidingsteken
    # bijvoorbeeld in  {'adres': {'straat': 'broadstreet', 'nummer': 123}}
    # kunnen we met 'adres.straat' or 'adres__straat' de straat zoeken

    jsonpath = jsonAttribute.replace("__", ".").split(".")

    for attribute in jsonpath:
        if isinstance(jsonObject, list):
            jsonObject = next(iter(jsonObject), None)
        if attribute not in jsonObject:
            print('Attribuut ' + jsonAttribute + ' niet gevonden.')
            return False

        jsonObject = jsonObject[attribute]

    return True

def AssertWildcardQuery(querystring, teststring):
    # Geeft True wanneer teststring voldoet aan de querystring
    # Geeft False wanneer teststring niet voldoet aan de querystring
    # Ondersteunt querystring met wildcards
    # Valideert case-insensitive
    # Bijvoorbeeld querystring='jan*' geeft True op 'Jansen'
    # en False op 'Vries'
    querystring = querystring.lower()
    teststring = teststring.lower()
    # wildcard character "?" is regular expression character "."
    # wildcard character "*" is regular expression ".*"
    querystring = '^' + querystring.replace('?', '.').replace('*', '.*') + '$'
    return re.match(querystring, teststring) is not None
