from django.shortcuts import get_object_or_404

from rest_framework import viewsets
from zds_schema.utils import lookup_kwargs_to_filters
from zds_schema.viewsets import NestedViewSetMixin

from bip.datamodel.models import IngeschrevenNatuurlijkPersoon, Reisdocument, \
    Land

from .filters import IngeschrevenNatuurlijkPersoonFilter
from .serializers import IngeschrevenNatuurlijkPersoonSerializer, \
    ReisdocumentSerializer, LandSerializer


class IngeschrevenNatuurlijkPersoonViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Opvragen van INGESCHREVEN NATUURLIJK PERSOON objecten.

    list:
    Geef een lijst van INGESCHREVEN NATUURLIJK PERSOON objecten, waarin
    gefiltered kan worden.

    retrieve:
    Geef de details van 1 enkel INGESCHREVEN NATUURLIJK PERSOON.
    """
    queryset = IngeschrevenNatuurlijkPersoon.objects.select_related(
        'overlijden',
        'overlijden__land',
        'geboorte',
        'geboorte__land',
        'verblijfstitel',
        'naamgebruik',
        'naam',
        'naam__voorvoegsel_geslachtsnaam',
        'naam__adellijke_titel_predikaat',
        'nationaliteit',
        'verblijfsplaats',
        'verblijfsplaats',
    ).prefetch_related(
        'kinderen',
        'partners',
        'ouders',
    )
    serializer_class = IngeschrevenNatuurlijkPersoonSerializer
    filter_class = IngeschrevenNatuurlijkPersoonFilter
    lookup_field = 'uuid'


class ReisdocumentViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Opvragen van REISDOCUMENT objecten.

    list:
    Geef een lijst van REISDOCUMENT objecten, waarin gefiltered kan worden.

    retrieve:
    Geef de details van 1 enkel REISDOCUMENT.
    """
    queryset = Reisdocument.objects.all()
    serializer_class = ReisdocumentSerializer
    # filter_class = ReisdocumentFilter
    lookup_field = 'uuid'


class LandViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Opvragen van LAND objecten.

    list:
    Geef een lijst van LAND objecten, waarin gefiltered kan worden.

    retrieve:
    Geef de details van 1 enkel LAND.
    """
    queryset = Land.objects.all()
    serializer_class = LandSerializer
    # filter_class = LandFilter
    lookup_field = 'uuid'
