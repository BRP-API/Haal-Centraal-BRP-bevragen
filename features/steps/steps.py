#!/usr/bin/python

from behave import *
import requests
import re
import config


@given('de registratie ingeschreven personen kent {eigenschappen}')
def step_impl(context, eigenschappen):
    pass


@given(u'in onderstaande scenario\'s wordt de expand parameter niet gebruikt, tenzij expliciet aangegeven')
def step_impl(context):
    pass


@given(u'de te raadplegen persoon {eigenschappen}')
def step_impl(context, eigenschappen):
    if eigenschappen=='verblijft in het buitenland':
        context.bsn = config.RAADPLEEGBSNBUITENLAND
    pass


@given(u'de gebruiker {eigenschappen}')
def step_impl(context, eigenschappen):
    pass


@given(u'de {attribute} van de geraadpleegde persoon is in onderzoek')
def step_impl(context, attribute):
    pass


@given(u'in onderstaande scenario\'s wordt de fields-parameter niet gebruikt, tenzij expliciet aangegeven')
def step_impl(context):
    pass


@given(u'{objectNaam} van de ingeschreven persoon heeft {eigenschappen}')
def step_impl(context, objectNaam, eigenschappen):
    pass


@given(u'het reisdocument {eigenschappen}')
def step_impl(context, eigenschappen):
    pass


@given(u'de API {eigenschappen}')
def step_impl(context, eigenschappen):
    pass


@given(u'nummeraanduidingen zijn te raadplegen in een BAG API')
def step_impl(context):
    pass


@given(u'de geraadpleegde {eigenschappen}')
def step_impl(context, eigenschappen):
    pass


@given(u'de registratie {eigenschappen}')
def step_impl(context, eigenschappen):
    pass


@given(u'Reden {eigenschappen}')
def step_impl(context, eigenschappen):
    pass


@when(u'de ingeschreven persoon met burgerservicenummer {burgerservicenummer} wordt geraadpleegd')
def step_impl(context, burgerservicenummer):
    url = config.BASEURL + '/ingeschrevenpersonen/' + burgerservicenummer
    context.response = requests.get(url)

@when(u'ingeschreven persoon met burgerservicenummer {burgerservicenummer} wordt geraadpleegd met {parameters}')
def step_impl(context, burgerservicenummer, parameters):
    url = config.BASEURL + '/ingeschrevenpersonen/' + burgerservicenummer + '?' + parameters
    context.response = requests.get(url)


@when(u'ingeschreven persoon met burgerservicenummer {burgerservicenummer} wordt geraadpleegd zonder {parameter}')
def step_impl(context, burgerservicenummer, parameter):
    url = config.BASEURL + '/ingeschrevenpersonen/' + burgerservicenummer
    context.response = requests.get(url)


@when(u'de link {link} wordt gevolgd')
def step_impl(context, link):
    links = GetAttribute(context.response.json(), '_links.' + link)
    if isinstance(links, list):
        url = GetAttribute(links[0], 'href')
    else:
        url = GetAttribute(links, 'href')

    assert url is not None
    context.response = requests.get(url)

@when('ingeschreven personen gezocht worden zonder parameters')
def step_impl(context):
    url = config.BASEURL + '/ingeschrevenpersonen'
    context.response = requests.get(url)


@when('ingeschreven personen gezocht worden met {querystring}')
def step_impl(context, querystring):
    url = config.BASEURL + '/ingeschrevenpersonen' + querystring
    context.response = requests.get(url)
    context.querystring = querystring


@when(u'een ingeschreven persoon wordt geraadpleegd zonder {parameter}')
def step_impl(context, parameter):
	url = config.BASEURL + '/ingeschrevenpersonen/' + config.RAADPLEEGBSN
	context.response = requests.get(url)


@when(u'een ingeschreven persoon wordt geraadpleegd met {querystring}')
def step_impl(context, querystring):
    if hasattr(context, 'bsn'):
        url = config.BASEURL + '/ingeschrevenpersonen/' + context.bsn + '?' + querystring
    else:
        url = config.BASEURL + '/ingeschrevenpersonen/' + config.RAADPLEEGBSN + '?' + querystring

    context.response = requests.get(url)


@when(u'de {subresource} worden geraadpleegd van de ingeschreven persoon met burgerservicenummer {burgerservicenummer}')
def step_impl(context, subresource, burgerservicenummer):
    url = config.BASEURL + '/ingeschrevenpersonen/' + burgerservicenummer + '/' + subresource
    context.response = requests.get(url)


@when(u'het reisdocument geraadpleegd met reisdocumentnummer {reisdocumentnummer}')
def step_impl(context, reisdocumentnummer):
    url = config.BASEURL + '/reisdocumenten/' + reisdocumentnummer
    context.response = requests.get(url)


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


@then(u'heeft de foutmelding betrekking op parameter {parameter}')
def step_impl(context, parameter):
    responsebody = context.response.json()
    if not 'invalid-params' in responsebody:
        print('Foutmelding heeft geen invalid-params')
    assert 'invalid-params' in responsebody
    if not isinstance(responsebody['invalid-params'], list):
        print('Foutmelding invalid-params is geen array')
    assert isinstance(responsebody['invalid-params'], list)
    if len(responsebody['invalid-params'])!=1:
        print('Meer parameterfouten dan verwacht: ' + len(responsebody['invalid-params']))
    assert len(responsebody['invalid-params'])==1
    if responsebody['invalid-params'][0]['name']!=parameter:
        print ('Fout heeft betrekking op andere parameter: ' + responsebody['invalid-params'][0]['name'])
    assert responsebody['invalid-params'][0]['name']==parameter


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


@then('heeft geen van de gevonden {resource} {attribuut}={waarde}')
def step_impl(context, resource, attribuut, waarde):
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        assert GetAttribute(item, attribuut) != waarde


@then(u'bevat het attribuut {attribute} in elke van de gevonden {embeddedResource} {part}')
def step_impl(context, embeddedResource, attribute, part):
    embeddedResources = GetAttribute(context.response.json(), embeddedResource)
    assert embeddedResources is not None

    for item in embeddedResources:
        value = GetAttribute(item, attribute)
        assert value is not None

        if part not in value:
            print (embeddedResource + '.' + attribute + '=' + value)
        assert part in value


@then(u'bevat het attribuut {attribute} in geen van de gevonden {embeddedResource} {part}')
def step_impl(context, embeddedResource, attribute, part):
    embeddedResources = GetAttribute(context.response.json(), embeddedResource)
    assert embeddedResources is not None

    for item in embeddedResources:
        value = GetAttribute(item, attribute)

        if part in value:
            print (embeddedResource + '.' + attribute + '=' + value)
        assert part not in value


@then(u'eindigt het attribuut {attribute} in geen van de gevonden {embeddedResource} op {suffix}')
def step_impl(context, embeddedResource, attribute, suffix):
    embeddedResources = GetAttribute(context.response.json(), embeddedResource)
    assert embeddedResources is not None

    for item in embeddedResources:
        value = GetAttribute(item, attribute)

        if value.endswith(suffix):
            print (embeddedResource + '.' + attribute + '=' + value)
        assert not value.endswith(suffix)


@then(u'begint het attribuut {attribute} in elk van de gevonden {embeddedResource} met http:// of https://')
def step_impl(context, embeddedResource, attribute):
    embeddedResources = GetAttribute(context.response.json(), embeddedResource)
    assert embeddedResources is not None

    for item in embeddedResources:
        attributeValue = GetAttribute(item, attribute)

        if not (attributeValue.startswith('http://') or attributeValue.startswith('https://')):
            print (embeddedResource + '.' + attribute + '=' + attributeValue + ' begint niet met http:// of https://')

        assert attributeValue.startswith('http://') or attributeValue.startswith('https://')


@then('heeft elke gevonden {objectNaam} attribuut {attribuut} met een waarde')
def step_impl(context, objectNaam, attribuut):
    responsebody = context.response.json()

    if objectNaam=='persoon':
        resource = 'ingeschrevenpersonen'

    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        attribuutWaarde = GetAttribute(item, attribuut)
        assert attribuutWaarde is not None

        if attribuutWaarde == "":
            print('Waarde van ' + attribuut + '=' + attribuutWaarde)
        assert attribuutWaarde != ""


@then('is in het antwoord {attribute}={value}')
def step_impl(context, attribute, value):
    responsebody = context.response.json()
    responseValue = GetAttribute(responsebody, attribute)

    if value=='null':
        if responseValue is not None:
            print (attribute + '=' + str(responseValue))
        assert responseValue is None
    elif isinstance(responseValue, str):
        if responseValue!=value:
            print (attribute + '=' + responseValue)
        assert responseValue==value
    elif isinstance(responseValue, bool):
        if responseValue!=bool(value):
            print (attribute + '=' + str(responseValue))
        assert responseValue==bool(value)
    elif isinstance(responseValue, int):
        if responseValue!=int(value):
            print (attribute + '=' + str(responseValue))
        assert responseValue==int(value)
    else:
        if responseValue!=value:
            print (attribute + '==' + str(responseValue))
        assert responseValue==value

@then(u'is in het antwoord {attribute} niet aanwezig of null')
def step_impl(context, attribute):
    responsebody = context.response.json()

    value = GetAttribute(responsebody, attribute, False)

    if value is not None:
        print (attribute + '=' + str(value))

    assert value is None


@then('wordt de {objectNaam} gevonden met {attribuut}={waarde}')
def step_impl(context, objectNaam, attribuut, waarde):
    if objectNaam=='ingeschreven persoon':
        context.objectId = getResourceWithValue(context.response.json(), 'ingeschrevenpersonen', attribuut, waarde)
    if objectNaam=='partner':
        context.objectId = getResourceWithValue(context.response.json(), 'partners', attribuut, waarde)
    if objectNaam=='ouder':
        context.objectId = getResourceWithValue(context.response.json(), 'ouders', attribuut, waarde)

    assert context.objectId!=-1

@then('wordt het {objectNaam} gevonden met {attribuut}={waarde}')
def step_impl(context, objectNaam, attribuut, waarde):
    if objectNaam=='kind':
        context.objectId = getResourceWithValue(context.response.json(), 'kinderen', attribuut, waarde)
    if objectNaam=='reisdocument':
        context.objectId = getResourceWithValue(context.response.json(), 'reisducmenten', attribuut, waarde)

    assert context.objectId!=-1


@then(u'heeft deze gevonden {objectNaam} de {relatie} link met {uri}')
def step_impl(context, objectNaam, relatie, uri):
    if objectNaam=='ingeschreven persoon':
        assertLinkValue(context.response.json(), context.objectId, 'ingeschrevenpersonen', relatie, uri)
    if objectNaam=='partner':
        assertLinkValue(context.response.json(), context.objectId, 'partners', relatie, uri)
    if objectNaam=='ouder':
        assertLinkValue(context.response.json(), context.objectId, 'ouders', relatie, uri)


@then(u'heeft dit gevonden {objectNaam} de {relatie} link met {uri}')
def step_impl(context, objectNaam, relatie, uri):
    if objectNaam=='kind':
        assertLinkValue(context.response.json(), context.objectId, 'kinderen', relatie, uri)


@then(u'is het aantal links naar {relatie} gelijk aan {aantal}')
def step_impl(context, relatie, aantal):
    links = GetAttribute(context.response.json(), '_links.' + relatie)
    assert links is not None

    if len(links)!=int(aantal):
        print ('Aantal ' + relatie + ' links=' + str(len(links)))

    assert len(links)==int(aantal)


@then(u'is het aantal embedded {subresource} gelijk aan {aantal}')
def step_impl(context, subresource, aantal):
    embeddedResources = GetAttribute(context.response.json(), '_embedded.' + subresource)
    assert embeddedResources is not None

    if len(embeddedResources)!=int(aantal):
        print ('Aantal embedded ' + subresource + '=' + str(len(embeddedResources)))

    assert len(embeddedResources)==int(aantal)


@then(u'wordt een {relatie} link gevonden naar {uri}')
def step_impl(context, relatie, uri):
    links = GetAttribute(context.response.json(), '_links.' + relatie)
    assert links is not None

    if type(links) is list:
        objectId = -1
        for key, link in enumerate(links):
            href = GetAttribute(link, 'href')
            if href is not None and href.endswith(uri):
                objectId = key
                break

        if (objectId!=-1):
            context.objectId = objectId
        else:
            print ('Link ' + relatie + ' niet gevonden naar ' + uri)
            print (links)

        assert objectId!=-1

    if type(links) is dict:
        href = GetAttribute(links, 'href')
        if href is None:
            print ('Link ' + relatie + ' niet gevonden of leeg')
        if not href.endswith(uri):
            print ('Link ' + relatie + '=' + href)

        assert href is not None and href.endswith(uri)


@then(u'heeft deze gevonden {objectNaam} een lege link {relatie}')
def step_impl(context, objectNaam, relatie):
    if objectNaam=='ingeschreven persoon':
        assertEmptyLink(context.response.json(), context.objectId, 'ingeschrevenpersonen', relatie)
    if objectNaam=='partner':
        assertEmptyLink(context.response.json(), context.objectId, 'partners', relatie)
    if objectNaam=='ouder':
        assertEmptyLink(context.response.json(), context.objectId, 'ouders', relatie)


@then(u'heeft dit gevonden {objectNaam} een lege link {relatie}')
def step_impl(context, objectNaam, relatie):
    if objectNaam=='kind':
        assertEmptyLink(context.response.json(), context.objectId, 'kinderen', relatie)


@then('heeft deze {objectNaam} {attribuut}={waarde}')
def step_impl(context, objectNaam, attribuut, waarde):
    if objectNaam=='ingeschreven persoon':
        assertValueInItem(context.response.json(), context.objectId, 'ingeschrevenpersonen', attribuut, waarde)
    if objectNaam=='partner':
        assertValueInItem(context.response.json(), context.objectId, 'partners', attribuut, waarde)
    if objectNaam=='ouder':
        assertValueInItem(context.response.json(), context.objectId, 'ouders', attribuut, waarde)


@then('heeft dit {objectNaam} {attribuut}={waarde}')
def step_impl(context, objectNaam, attribuut, waarde):
    if objectNaam=='kind':
        assertValueInItem(context.response.json(), context.objectId, 'kinderen', attribuut, waarde)


@then('wordt geen {objectNaam} gevonden met {attribuut}={waarde}')
def step_impl(context, objectNaam, attribuut, waarde):
    if objectNaam=='ingeschreven persoon':
        resource = 'ingeschrevenpersonen'
    if objectNaam=='partner':
        resource = 'partners'
    if objectNaam=='ouder':
        resource = 'ouders'
    if objectNaam=='kind':
        resource = 'kinderen'

    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        attribuutWaarde = GetAttribute(item, attribuut)

        if waarde=='null':
            assert attribuutWaarde is not None
        else:
            if attribuutWaarde!=waarde:
                print(attribuut + ' gevonden met waarde ' + waarde)
            assert attribuutWaarde is not None and attribuutWaarde != waarde


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
    if collection is None:
        print(responsebody)
    assert collection is not None

    for item in collection:
        assertNoneObject(GetAttribute(item, attribuut, False))
        #attribuutWaarde = GetAttribute(item, attribuut, False)
        #if attribuutWaarde is not None :
        #    print(attribuut + '=' + str(attribuutWaarde))
        #assert attribuutWaarde is None


@then(u'geldt voor elk van de gevonden {resource} dat attribuut {attribute} de tekst {part} bevat')
def step_impl(context, resource, attribute, part):
    collection = GetCollection(context.response.json(), resource)

    if collection is None:
        print(responsebody)
    assert collection is not None

    for item in collection:
        attributeValue = GetAttribute(item, attribute)

        assert attributeValue is not None

        if part not in attributeValue:
            print (part + ' niet gevonden in ' + attribute + '=' + attributeValue)

        assert part in attributeValue


@then(u'geldt voor elk van de gevonden {resource} dat attribuut {attribute} begint met http:// of https://')
def step_impl(context, resource, attribute):
    collection = GetCollection(context.response.json(), resource)

    if collection is None:
        print(responsebody)
    assert collection is not None

    for item in collection:
        attributeValue = GetAttribute(item, attribute)

        assert attributeValue is not None

        if not (attributeValue.startswith('http://') or attributeValue.startswith('https://')):
            print (attribute + '=' + attributeValue + ' begint niet met http:// of https://')

        assert attributeValue.startswith('http://') or attributeValue.startswith('https://')


@then(u'geldt voor elk van de gevonden {resource} dat attribuut {attribute} geen waarde {part} bevat')
def step_impl(context, resource, attribute, part):
    collection = GetCollection(context.response.json(), resource)

    if collection is None:
        print(responsebody)
    assert collection is not None

    for item in collection:
        attributeValue = GetAttribute(item, attribute)

        assert attributeValue is not None

        if part in attributeValue:
            print (part + " gevonden in " + attributeValue)

        assert part not in attributeValue


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


@then(u'is het aantal gevonden {resource} {resultCount}')
def step_impl(context, resource, resultCount):
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    if len(collection)!=int(resultCount):
        print('Er zijn ' + str(len(collection)) + ' ' + resource + ' gevonden')
    assert len(collection)==int(resultCount)


@then(u'hebben alle gevonden {resource} embedded {nestedresource}')
def step_impl(context, resource, nestedresource):
    responsebody = context.response.json()
    collection = GetCollection(responsebody, resource)
    assert collection is not None

    for item in collection:
        embedded = GetAttribute(item, '_embedded.' + nestedresource, False)
        assert embedded is not None


@then(u'worden alle attributen van de resource teruggegeven')
def step_impl(context):
    responsebody = context.response.json()

    for name in config.SWAGGER['components']['schemas']['IngeschrevenPersoon']['properties']:
        if name in {'_embedded', '_links'}:
            continue

        if name not in responsebody:
            print(name + ' missing in response')
        assert name in responsebody


@then(u'worden alle relaties van de resource teruggegeven')
def step_impl(context):
    responsebody = context.response.json()['_links']

    for name in config.SWAGGER['components']['schemas']['IngeschrevenPersoon_links']['properties']:
        if name not in responsebody:
            print('_links.' + name + ' missing in response')
        assert name in responsebody


@then(u'wordt er geen gerelateerde sub-resource teruggegeven in _embedded')
def step_impl(context):
    responsebody = context.response.json()

    if '_embedded' in responsebody:
        for name in config.SWAGGER['components']['schemas']['IngeschrevenPersoon_embedded']['properties']:
            if name  in responsebody['_embedded']:
                print('_embedded.' + name + ' in response')
            assert name not in responsebody['_embedded']


@then(u'wordt geen enkele relatie van de resource in _links teruggegeven')
def step_impl(context):
    responsebody = context.response.json()

    if '_links' in responsebody:
        for name in config.SWAGGER['components']['schemas']['IngeschrevenPersoon_links']['properties']:
            if name=='self':
                continue

            if name in responsebody['_links']:
                print('_links.' + name + ' in response')
            assert name not in responsebody['_links']


@then(u'wordt attribuut {attribute} teruggegeven')
def step_impl(context, attribute):
    responsebody = context.response.json()

    assert AttributeExists(responsebody, attribute)


@then(u'wordt geen enkel ander attribuut dan {attribute} teruggegeven')
def step_impl(context, attribute):
    responsebody = context.response.json()

    attributeList = attribute.replace(' en ', ',').replace(', ', ',').split(',')

    for element in responsebody:
        if element=='_links':
            continue
        if element not in attributeList:
            print(element + ' found but not expected')
        assert element in attributeList


@then(u'worden alle attributen van de persoon teruggegeven, voor zover ze een waarde hebben')
def step_impl(context):
    pass


@then(u'wordt voor alle {subresource} in _embedded attribuut {attribute} teruggegeven')
def step_impl(context, subresource, attribute):
    resources = GetAttribute(context.response.json(), '_embedded.' + subresource)

    for resource in resources:
        if not AttributeExists(resource, attribute):
            print (attribute + ' niet gevonden in ' + subresource)
        assert AttributeExists(resource, attribute)


@then(u'is voor alle {subresource} in _embedded attribuut {attribute} niet aanwezig')
def step_impl(context, subresource, attribute):
    resources = GetAttribute(context.response.json(), '_embedded.' + subresource)

    for resource in resources:
        if AttributeExists(resource, attribute):
            print (attribute + ' gevonden in ' + subresource)
        assert not AttributeExists(resource, attribute)


@then(u'is het resultaat {expectedResult}')
def step_impl(context, expectedResult):
    if expectedResult=='foutmelding':
        if context.response.status_code < 400:
            print("http statuscode: " + str(context.response.status_code))
            # print("body: " + context.response.text)
        assert context.response.status_code >= 400
    if expectedResult=='zoekresultaten':
        if context.response.status_code >= 400:
            print("http statuscode: " + str(context.response.status_code))
            # print("body: " + context.response.text)
        assert context.response.status_code < 400


@then(u'wordt in {groupName} geen enkel ander attribuut dan {attribute} teruggegeven')
def step_impl(context, groupName, attribute):
    responsebody = GetAttribute(context.response.json(), groupName)

    attributeList = attribute.replace(' en ', ',').replace(', ', ',').split(',')

    for element in responsebody.keys():
        if element not in attributeList:
            print ('element: ' + element)
        assert element in attributeList


@then(u'is elke link {relationLink} een geldige uri')
def step_impl(context, relationLink):
    responsebody = GetAttribute(context.response.json(), '_links.' + relationLink)
    regExp = '^https?:\/\/[a-z0-9]+[a-zA-Z0-9\_\-\.\/]+[a-zA-Z0-9\_\-]+$'

    for link in responsebody:
        if re.match(regExp, link['href']) is None:
            print ('incorrect url: ' + link['href'])
        assert re.match(regExp, link['href']) is not None


@then(u'bevat het antwoord {attribute} met een waarde')
def step_impl(context, attribute):
    responsebody = GetAttribute(context.response.json(), attribute)

    assert responsebody is not None


@then(u'is in het antwoord {attribute} een geldige uri')
def step_impl(context, attribute):
    responsebody = GetAttribute(context.response.json(), attribute)
    regExp = '^https?:\/\/[a-z0-9]+[a-zA-Z0-9\_\-\.\/]+[a-zA-Z0-9\_\-]+$'

    assert responsebody is not None

    if re.match(regExp, responsebody) is None:
        print ('incorrect url: ' + responsebody)
    assert re.match(regExp, responsebody) is not None

@then(u'is in het antwoord attribuut {attribute} niet aanwezig')
def step_impl(context, attribute):
    responsebody = context.response.json()

    assert not AttributeExists(responsebody, attribute)


@then(u'is in het antwoord attribuut {attribute} null, leeg of afwezig')
def step_impl(context, attribute):
    assertNoneObject(GetAttribute(context.response.json(), attribute, False))
    #if AttributeExists(context.response.json(), attribute):
    #    attributeValue = GetAttribute(context.response.json(), attribute)
    #    assert attributeValue=='' or attributeValue is None
    #else:
    #    pass


@then(u'is {attribute} leeg')
def step_impl(context, attribute):
    list = GetAttribute(context.response.json(), attribute)

    if len(list)>0:
        print (attribute + ' heeft ' + str(len(list)) + ' items')

    assert len(list)==0


@then(u'worden voor alle {subresource} in _embedded alle attributen van {groupName} teruggegeven voor zover ze een waarde hebben ({attributes})')
def step_impl(context, subresource, groupName, attributes):
    resources = GetAttribute(context.response.json(), '_embedded.' + subresource)
    attributeList = attributes.replace(' en ', ',').replace(', ', ',').split(',')

    for resource in resources:
        group = GetAttribute(resource, groupName)

        for attribute in attributeList:
            assert AttributeExists(group, attribute)


@then(u'wordt voor alle {subresource} in _embedded geen enkel ander attribuut dan {attributes} teruggegeven')
def step_impl(context, subresource, attributes):
    resources = GetAttribute(context.response.json(), '_embedded.' + subresource)
    attributeList = attributes.replace(' en ', ',').replace(', ', ',').split(',')

    for resource in resources:
        for element in resource.keys():
            if element not in attributeList:
                print ('element: ' + element)
            assert element in attributeList


@then(u'wordt voor alle {subresource} in _embedded geen enkel ander attribuut van {groupName} teruggegeven dan {attributes}')
def step_impl(context, subresource, groupName, attributes):
    resources = GetAttribute(context.response.json(), '_embedded.' + subresource)
    attributeList = attributes.replace(' en ', ',').replace(', ', ',').split(',')

    for resource in resources:
        group = GetAttribute(resource, groupName)

        for element in group.keys():
            if element not in attributeList:
                print ('element: ' + element)
            assert element in attributeList


@then(u'heeft de gevonden {objectNaam} {attribuut}={waarde}')
def step_impl(context, objectNaam, attribuut, waarde):
    if objectNaam=='ingeschreven persoon':
        resource = 'ingeschrevenpersonen'
    if objectNaam=='partner':
        resource = 'partners'
    if objectNaam=='ouder':
        resource = 'ouders'
    if objectNaam=='kind':
        resource = 'kinderen'

    collection = GetCollection(context.response.json(), resource)
    if collection is None:
        print(responsebody)
    assert collection is not None

    attribuutWaarde = GetAttribute(collection[0], attribuut)

    if waarde=='null':
        if attribuutWaarde is not None:
            print(attribuut + '=' + attribuutWaarde)
        assert attribuutWaarde is None
    else:
        if attribuutWaarde!=waarde:
            print(attribuut + '=' + str(attribuutWaarde))
        assert attribuutWaarde==waarde


@then(u'heeft de gevonden {objectNaam} link {relatie} met {uri}')
def step_impl(context, objectNaam, relatie, uri):
    if objectNaam=='ingeschreven persoon':
        resource = 'ingeschrevenpersonen'
    if objectNaam=='partner':
        resource = 'partners'
    if objectNaam=='ouder':
        resource = 'ouders'
    if objectNaam=='kind':
        resource = 'kinderen'

    collection = GetCollection(context.response.json(), resource)
    if collection is None:
        print(responsebody)
    assert collection is not None

    attribuutWaarde = GetAttribute(collection[0], '_links.' + relatie + '.href')

    if not attribuutWaarde.endswith(uri):
        print(relatie + '=' + attribuutWaarde)
    assert attribuutWaarde.endswith(uri)


@then(u'heeft de gevonden {objectNaam} een lege link {relatie}')
def step_impl(context, objectNaam, relatie):
    if objectNaam=='ingeschreven persoon':
        resource = 'ingeschrevenpersonen'
    if objectNaam=='partner':
        resource = 'partners'
    if objectNaam=='ouder':
        resource = 'ouders'
    if objectNaam=='kind':
        resource = 'kinderen'

    collection = GetCollection(context.response.json(), resource)
    if collection is None:
        print(responsebody)
    assert collection is not None

    attribuutWaarde = GetAttribute(collection[0], '_links.' + relatie + '.href')

    if attribuutWaarde is not None:
        print (relatie + '=' + attribuutWaarde)
    assert attribuutWaarde is None


@then(u'heeft attribuut {attribute} de waarde {expectedValue}')
def step_impl(context, attribute, expectedValue):
    attributeValue = GetAttribute(context.response.json(), attribute)

    assert attributeValue is not None

    if not attributeValue==expectedValue:
        print (attribute + '=' + attributeValue)

    assert attributeValue==expectedValue


@then(u'eindigt attribuut {attribute} met {suffix}')
def step_impl(context, attribute, suffix):
    attributeValue = GetAttribute(context.response.json(), attribute)

    assert attributeValue is not None

    if not attributeValue.endswith(suffix):
        print (attribute + '=' + attributeValue + ' eindigt niet op ' + suffix)

    assert attributeValue.endswith(suffix)


@then(u'eindigt attribuut {attribute} niet op {suffix}')
def step_impl(context, attribute, suffix):
    attributeValue = GetAttribute(context.response.json(), attribute)

    assert attributeValue is not None

    if attributeValue.endswith(suffix):
        print (attribute + '=' + attributeValue + ' eindigt op ' + suffix)

    assert not attributeValue.endswith(suffix)


@then(u'begint attribuut {attribute} met http:// of https://')
def step_impl(context, attribute):
    attributeValue = GetAttribute(context.response.json(), attribute)

    assert attributeValue is not None

    if not (attributeValue.startswith('http://') or attributeValue.startswith('https://')):
        print (attribute + '=' + attributeValue + ' begint niet met http:// of https://')

    assert attributeValue.startswith('http://') or attributeValue.startswith('https://')

@then(u'bevat attribuut {attribute} {part}')
def step_impl(context, attribute, part):
    attributeValue = GetAttribute(context.response.json(), attribute)

    assert attributeValue is not None

    if part not in attributeValue:
        print (part + ' niet gevonden in ' + attribute + '=' + attributeValue)

    assert part in attributeValue


@then(u'zit er geen {part} in {attribute}')
def step_impl(context, attribute, part):
    attributeValue = GetAttribute(context.response.json(), attribute)

    assert attributeValue is not None

    if part in attributeValue:
        print (part + ' gevonden in ' + attribute + '=' + attributeValue)

    assert part not in attributeValue


@then(u'levert een GET request naar de url in {attribute} een antwoord')
def step_impl(context, attribute):
    url = GetAttribute(context.response.json(), attribute)

    assert url is not None

    response = requests.get(url)

    if response.status_code >= 400:
        print ('GET ' + url + ' geeft foutcode: ' + response.status_code)
    assert response.status_code < 400

@then(u'levert voor elk van de gevonden {resource} een GET request naar de url in {attribute} een antwoord')
def step_impl(context, resource, attribute):
    collection = GetCollection(context.response.json(), resource)

    assert collection is not None

    for item in collection:
        url = GetAttribute(item, attribute)

        assert url is not None

        response = requests.get(url)

        if response.status_code >= 400:
            print ('GET ' + url + ' geeft foutcode: ' + response.status_code)
        assert response.status_code < 400


@then(u'levert voor alle gevonden {linkedResource} een GET request naar de url in {attribute} een antwoord')
def step_impl(context, linkedResource, attribute):
    links = GetAttribute(context.response.json(), linkedResource)
    assert links is not None

    for item in links:
        url = GetAttribute(item, attribute)
        assert url is not None

        response = requests.get(url)

        if response.status_code >= 400:
            print ('GET ' + url + ' geeft foutcode: ' + response.status_code)
        assert response.status_code < 400


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

def assertLinkValue(responsebody, objectId, resource, link, uri):
    collection = GetCollection(responsebody, resource)
    if collection is None:
        print(responsebody)
    assert collection is not None

    attribuutWaarde = GetAttribute(collection[objectId], '_links.' + link + '.href')

    assert attribuutWaarde is not None

    if not attribuutWaarde.endswith(uri):
        print(link + '=' + attribuutWaarde)
    assert attribuutWaarde.endswith(uri)


def getResourceWithValue(responsebody, resource, attribute, expectedValue):
    collection = GetCollection(responsebody, resource)
    if collection is None:
        print(responsebody)
    assert collection is not None

    objectId = -1
    for key, item in enumerate(collection):
        value = GetAttribute(item, attribute)

        if expectedValue=='null' and value is None:
            objectId = key
            break

        if value is not None and value==expectedValue:
            objectId = key
            break

    if objectId<0:
        print('Geen ' + resource + ' gevonden met ' + attribute + '=' + expectedValue)

    return objectId

def assertEmptyLink(responsebody, objectId, resource, link):
    collection = GetCollection(responsebody, resource)
    if collection is None:
        print(responsebody)
    assert collection is not None

    value = GetAttribute(collection[objectId], '_links.' + link + '.href')

    if value is not None:
        print (link + '=' + value)
    assert value is None

def assertValueInItem(responsebody, objectId, resource, attribute, expectedValue):
    collection = GetCollection(responsebody, resource)
    if collection is None:
        print(responsebody)
    assert collection is not None

    value = GetAttribute(collection[objectId], attribute)

    if expectedValue=='null':
        if value is not None:
            print (attribute + '=' + str(value))
        assert value is None
    else:
        if value!=expectedValue:
            print (attribute + '=' + str(value))
            assert value==expectedValue


def assertNoneObject(jsonObject):
    if isinstance(jsonObject, dict):
        for attr, value in jsonObject.items():
            assertNoneObject(value)
    elif isinstance(jsonObject, list):
        if len(jsonObject)>0:
            print(str(jsonObject))
        assert len(jsonObject)==0
    else:
        if jsonObject is not None:
            print (str(jsonObject))
        assert jsonObject is None
