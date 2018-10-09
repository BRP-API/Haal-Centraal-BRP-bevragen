from zds_schema.filters import WildcardFilter
from zds_schema.filtersets import FilterSet

from bip.datamodel.models import IngeschrevenNatuurlijkPersoon


class IngeschrevenNatuurlijkPersoonFilter(FilterSet):
    naam__geslachtsnaam = WildcardFilter(
        help_text='Zoeken op geslachtsnaam met ondersteuning voor wildcards '
                  '(*).')

    class Meta:
        model = IngeschrevenNatuurlijkPersoon
        fields = (
            'burgerservicenummer',
            'geboorte__datum',
            'naam__geslachtsnaam',
        )
