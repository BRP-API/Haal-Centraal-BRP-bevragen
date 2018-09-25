from zds_schema.filtersets import FilterSet

from bip.datamodel.models import IngeschrevenNatuurlijkPersoon


class NatuurlijkPersoonFilter(FilterSet):
    class Meta:
        model = IngeschrevenNatuurlijkPersoon
        fields = (
            # 'identificatie',
            # 'verantwoordelijke_organisatie',
            # 'besluittype',
            # 'zaak',
        )
