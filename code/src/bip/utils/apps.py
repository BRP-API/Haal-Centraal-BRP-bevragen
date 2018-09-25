from django.apps import AppConfig


class UtilsConfig(AppConfig):
    name = 'bip.utils'

    def ready(self):
        from . import checks  # noqa
