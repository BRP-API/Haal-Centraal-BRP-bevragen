"""
Serializers of the Basisregistratie Ingeschreven Personen REST API
"""
from rest_framework import serializers

from bip.datamodel.models import (
    AdellijkeTitelPredikaat, Geboorte, IngeschrevenNatuurlijkPersoon, Land,
    Naam, Naamgebruik, Nationaliteit, Overlijden, Reisdocument,
    Verblijfsplaats, Verblijfstitel, VoorvoegselGeslachtsnaam
)

# Nested level 2

class VoorvoegselGeslachtsnaamSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = VoorvoegselGeslachtsnaam
        exclude = ('url', )


class AdellijkeTitelPredikaatSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = AdellijkeTitelPredikaat
        exclude = ('url', )


class VerblijfsplaatsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Verblijfsplaats
        exclude = ('url', )
        extra_kwargs = {
            'land': {
                'lookup_field': 'uuid',
            },
        }

# Nested level 1

class OverlijdenSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Overlijden
        exclude = ('url', )
        extra_kwargs = {
            'land': {
                'lookup_field': 'uuid',
            },
        }


class GeboorteSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Geboorte
        exclude = ('url', )
        extra_kwargs = {
            'land': {
                'lookup_field': 'uuid',
            },
        }


class VerblijfstitelSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Verblijfstitel
        exclude = ('url', )


class NaamgebruikSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Naamgebruik
        exclude = ('url', )


class NaamSerializer(serializers.HyperlinkedModelSerializer):
    voorvoegsel_geslachtsnaam = VoorvoegselGeslachtsnaamSerializer(required=False)
    adellijke_titel_predikaat = AdellijkeTitelPredikaatSerializer(required=False)

    class Meta:
        model = Naam
        exclude = ('url', )


class NationaliteitSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Nationaliteit
        exclude = ('url', )


# Related models

class ReisdocumentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Reisdocument
        fields = '__all__'
        extra_kwargs = {
            'url': {
                'lookup_field': 'uuid',
            },
        }


class LandSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Land
        fields = '__all__'
        extra_kwargs = {
            'url': {
                'lookup_field': 'uuid',
            },
        }


class IngeschrevenNatuurlijkPersoonSerializer(serializers.HyperlinkedModelSerializer):
    overlijden = OverlijdenSerializer(required=False)
    geboorte = GeboorteSerializer(required=False)
    verblijfstitel = VerblijfstitelSerializer(required=False)
    naamgebruik = NaamgebruikSerializer(required=False)
    naam = NaamSerializer(required=False)
    nationaliteit = NationaliteitSerializer(required=False)
    verblijfsplaats = VerblijfsplaatsSerializer(required=True)
    ouders = serializers.HyperlinkedRelatedField(
        many=True,
        required=False,
        view_name='ingeschrevennatuurlijkpersoon-detail',
        lookup_field='uuid',
        read_only=True,
    )

    class Meta:
        model = IngeschrevenNatuurlijkPersoon
        fields = '__all__'
        extra_kwargs = {
            'url': {
                'lookup_field': 'uuid',
            },
            'kinderen': {
                'lookup_field': 'uuid',
            },
            'partners': {
                'lookup_field': 'uuid',
            },
            'reisdocumenten': {
                'lookup_field': 'uuid',
            },
        }
