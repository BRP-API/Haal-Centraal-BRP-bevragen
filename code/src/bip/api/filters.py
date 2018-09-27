import django_filters
from zds_schema.filtersets import FilterSet

from bip.datamodel.models import IngeschrevenNatuurlijkPersoon


class IngeschrevenNatuurlijkPersoonFilter(FilterSet):
    naam__geslachtsnaam = django_filters.CharFilter(
        method='wildcard_filter', help_text='Zoeken op geslachtsnaam met ondersteuning voor wildcards (*).'
    )

    class Meta:
        model = IngeschrevenNatuurlijkPersoon
        fields = (
            'burgerservicenummer',
            'geboorte__datum',
            'naam__geslachtsnaam',
        )

    def wildcard_filter(self, queryset, name, value):
        expression = r'^{}$'.format(value.replace('*', '.*'))

        return queryset.filter(**{
            f'{name}__iregex': expression
        })
