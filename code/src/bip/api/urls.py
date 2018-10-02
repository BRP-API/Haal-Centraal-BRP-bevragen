from django.conf.urls import include, url

from zds_schema import routers

from .schema import schema_view
from .viewsets import (
    IngeschrevenNatuurlijkPersoonViewSet, LandViewSet, ReisdocumentViewSet
)

router = routers.DefaultRouter()
router.register(
    'ingeschrevennatuurlijkpersonen', IngeschrevenNatuurlijkPersoonViewSet)
router.register('reisdocumenten', ReisdocumentViewSet)
router.register('landen', LandViewSet)


urlpatterns = [
    url(r'^v(?P<version>\d+)/', include([

        # API documentation
        url(r'^schema/openapi(?P<format>\.json|\.yaml)$',
            schema_view.without_ui(cache_timeout=None),
            name='schema-json'),
        url(r'^schema/$',
            schema_view.with_ui('redoc', cache_timeout=None),
            name='schema-redoc'),

        # actual API
        url(r'^', include(router.urls)),
    ])),
]
