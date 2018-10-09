from drf_yasg import openapi
from drf_yasg.views import get_schema_view
from rest_framework import permissions

info = openapi.Info(
    title="Bevragingen-ingeschreven-personen (bip) API",
    default_version='1',
    description="Een API om een bevragingen ingeschreven personen uit te voeren.",
    contact=openapi.Contact(
        email="support@maykinmedia.nl",
        url="https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen"
    ),
    license=openapi.License(name="EUPL 1.2"),
)

schema_view = get_schema_view(
    # validators=['flex', 'ssv'],
    public=True,
    permission_classes=(permissions.AllowAny,),
)
