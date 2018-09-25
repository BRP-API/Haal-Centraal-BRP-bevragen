"""
Serializers of the Basisregistratie Ingeschreven Personen REST API
"""
from rest_framework import serializers
from rest_framework_nested.serializers import NestedHyperlinkedModelSerializer
from zds_schema.validators import (
    InformatieObjectUniqueValidator, ObjectInformatieObjectValidator,
    UniekeIdentificatieValidator, URLValidator
)

from bip.datamodel.models import IngeschrevenNatuurlijkPersoon, Geboorte, \
    Verblijfstitel, \
    Nationaliteit, Overlijden, Naam, VoorvoegselGeslachtsnaam, \
    AdellijkeTitelPredikaat, Land, Naamgebruik, Reisdocument, Verblijfsplaats


class OverlijdenSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Overlijden
        fields = '__all__'


class GeboorteSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Geboorte
        fields = '__all__'


class VerblijfstitelSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Verblijfstitel
        fields = '__all__'


class NaamgebruikSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Naamgebruik
        fields = '__all__'


class NaamSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Naam
        fields = '__all__'


class NationaliteitSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Nationaliteit
        fields = '__all__'


# Nested level 2

class LandSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Land
        fields = '__all__'


class VoorvoegselGeslachtsnaamSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = VoorvoegselGeslachtsnaam
        fields = '__all__'


class AdellijkeTitelPredikaatSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = AdellijkeTitelPredikaat
        fields = '__all__'


# Related models

class ReisdocumentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Reisdocument
        fields = '__all__'


class VerblijfsplaatsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Verblijfsplaats
        fields = '__all__'


class NatuurlijkPersoonSerializer(serializers.HyperlinkedModelSerializer):
    overlijden = OverlijdenSerializer()

    reisdocumenten = ReisdocumentSerializer(many=True)

    class Meta:
        model = IngeschrevenNatuurlijkPersoon
        fields = '__all__'
        extra_kwargs = {
            'url': {
                'lookup_field': 'uuid',
            },
        }
