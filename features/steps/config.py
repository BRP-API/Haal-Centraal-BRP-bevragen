#!/usr/bin/python

BASEURL = 'http://localhost/VNG-sandbox/api/bevragingen_ingeschreven_personen/v1'
#BASEURL = 'http://www.quality-of-service.nl/api/brp/v1'

RAADPLEEGBSN = '999999047'
RAADPLEEGBSNBUITENLAND = '999999084'

import json

with open('../api-specificatie/Bevraging-Ingeschreven-Persoon/openapi.json') as json_file:
    SWAGGER = json.load(json_file)
