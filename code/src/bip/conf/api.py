from zds_schema.conf.api import *  # noqa - imports white-listed

REST_FRAMEWORK = BASE_REST_FRAMEWORK.copy()


SWAGGER_SETTINGS = BASE_SWAGGER_SETTINGS.copy()
SWAGGER_SETTINGS.update({
    'DEFAULT_INFO': 'bip.api.schema.info',
    # no geo things here
    'DEFAULT_FIELD_INSPECTORS': BASE_SWAGGER_SETTINGS['DEFAULT_FIELD_INSPECTORS'][1:]
})

REDOC_SETTINGS = {
    'EXPAND_RESPONSES': '200,201'
}
