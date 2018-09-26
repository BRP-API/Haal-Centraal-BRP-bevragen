import django_filters
from zds_schema.filtersets import FilterSet

from bip.datamodel.models import IngeschrevenNatuurlijkPersoon


class IngeschrevenNatuurlijkPersoonFilter(FilterSet):
    # postcode = django_filters.CharFilter(field_name='verblijfsplaats__postcode')

    class Meta:
        model = IngeschrevenNatuurlijkPersoon
        fields = (
            'burgerservicenummer',
            # 'postcode'
        )
