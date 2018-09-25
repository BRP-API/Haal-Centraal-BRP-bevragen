from django.conf import settings
from django.urls import reverse as _reverse, reverse_lazy as _reverse_lazy


def _inject_version(kwargs: dict):
    kwargs.setdefault('kwargs', {})
    kwargs['kwargs']['version'] = settings.REST_FRAMEWORK['DEFAULT_VERSION']


def reverse(*args, **kwargs):
    _inject_version(kwargs)
    return _reverse(*args, **kwargs)


def reverse_lazy(*args, **kwargs):
    _inject_version(kwargs)
    return _reverse_lazy(*args, **kwargs)
