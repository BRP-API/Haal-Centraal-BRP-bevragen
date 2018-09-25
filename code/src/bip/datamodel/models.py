import uuid as _uuid

from django.core.validators import MinValueValidator, MaxValueValidator, \
    RegexValidator
from django.db import models

from zds_schema.fields import RSINField
from zds_schema.models import APIMixin
from zds_schema.validators import (
    UntilNowValidator, alphanumeric_excluding_diacritic,
    validate_non_negative_string)

from .constants import GeslachtsAanduiding, NaamgebruikAanduiding, \
    AdresHerkomst, BurgerlijkeStaat, RedenOpschortingBijhouding, \
    AanduidingBijzonderNederlandschap


class IngeschrevenNatuurlijkPersoon(APIMixin, models.Model):
    uuid = models.UUIDField(default=_uuid.uuid4)

    burgerservicenummer = models.CharField(
        null=True, blank=True, max_length=9,
        validators=[validate_non_negative_string, ],
        help_text='Het burgerservicenummer, bedoeld in artikel 1.1 van de Wet '
                  'algemene bepalingen burgerservicenummer.'
    )
    a_nummer = models.IntegerField(
        null=True
    )
    geslachtsaanduiding = models.CharField(
        blank=True, max_length=1,
        choices=GeslachtsAanduiding.choices,
        help_text='Een aanduiding die aangeeft of de persoon een man of een '
                  'vrouw is, of dat het geslacht nog onbekend is.'
    )
    burgerlijke_staat = models.CharField(
        max_length=40, choices=BurgerlijkeStaat.choices
    )
    indicatie_geheim = models.CharField(
        max_length=200 # TODO: choices
    )
    gemeente_van_inschrijving = models.IntegerField(
        null=True
    )
    datum_inschrijving_in_gemeente = models.DateField()
    datum_begin_geldigheid_verblijfplaats = models.DateField()
    datum_vestiging_in_nederland = models.DateField(
        null=True
    )
    reden_opschorting_bijhouding = models.CharField(
        max_length=40, choices=RedenOpschortingBijhouding.choices
    )
    datum_opschorting_bijhouding = models.DateField()
    signalering_nederlands_reisdocument = models.IntegerField(
        null=True
    )
    overlijden = models.ForeignKey(
        'Overlijden', null=True, on_delete=models.CASCADE
    )
    geboorte = models.ForeignKey(
        'Geboorte', null=True, on_delete=models.CASCADE
    )
    verblijfstitel = models.ForeignKey(
        'Verblijfstitel', null=True, on_delete=models.CASCADE
    )
    naamgebruik = models.ForeignKey(
        'Naamgebruik', null=True, on_delete=models.CASCADE
    )
    naam = models.ForeignKey(
        'Naam', null=True, on_delete=models.CASCADE,
         help_text='Gegevens over de naam van de NATUURLIJK PERSOON'
    )
    nationaliteit = models.ForeignKey(
        'Nationaliteit', null=True, on_delete=models.CASCADE
    )

    # TODO: In spec is er maar 1 ouder
    kinderen = models.ManyToManyField(
        'self', null=True, related_name='ouders'
    )
    partners = models.ManyToManyField(
        'self', null=True, symmetrical=True
    )

    def __str__(self):
        return str(self.uuid)


class Overlijden(models.Model):
    datum = models.DateField()
    plaats = models.CharField(max_length=40)
    land = models.ForeignKey('Land', on_delete=models.CASCADE)


class Geboorte(models.Model):
    datum = models.DateField()
    plaats = models.CharField(max_length=40)
    land = models.ForeignKey('Land', on_delete=models.CASCADE)


class Verblijfstitel(models.Model):
    ingangsdatum = models.DateField()
    datumEinde = models.DateField()

    # TODO: Matcht totaal niet met model...
    numeriek = models.CharField(max_length=2)
    omschrijving = models.CharField(max_length=80)
    datum_aanvang_geldigheid = models.DateField()
    datum_einde_geldigheid = models.DateField(null=True)


class Naamgebruik(models.Model):
    aanduiding = models.CharField(
        max_length=20, choices=NaamgebruikAanduiding.choices,
    )
    aanschrijfwijze = models.CharField(
        max_length=50
    )


class Naam(models.Model):
    voornamen = models.CharField(
        blank=True, max_length=200,
        help_text='Voornamen bij de naam die de persoon wenst te voeren.'
    )
    geslachtsnaam = models.CharField(
        max_length=200,
        help_text='De stam van de geslachtsnaam.'
    )
    voorvoegsel_geslachtsnaam = models.ForeignKey(
        'VoorvoegselGeslachtsnaam', null=True, on_delete=models.SET_NULL,
    )
    adelijke_titel_predikaat = models.ForeignKey(
        'AdellijkeTitelPredikaat', null=True, on_delete=models.SET_NULL,
    )


class Nationaliteit(models.Model):
    aanduiding_bijzonder_nederlanderschap = models.CharField(
        max_length=40, choices=AanduidingBijzonderNederlandschap.choices
    )

    # TODO: ARGH INLINE ZOOI
    code = models.IntegerField()
    officiele_omschrijving = models.CharField(max_length=42)
    datum_einde_geldigheid = models.DateField(null=True)
    # End

    # redenOpnameNationaliteit
    # redenBeeindigenNationaliteit


# Nested level 2


class Land(models.Model):
    code = models.CharField(
        max_length=4,
        help_text='De code, behorende bij de landnaam, zoals opgenomen in de '
                  'Land/Gebied-tabel van de BRP.'
    )
    naam = models.CharField(
        max_length=40, help_text='De naam van het land, zoals opgenomen in de '
                                 'Land/Gebied-tabel van de BRP.'
    )


class VoorvoegselGeslachtsnaam(models.Model):
    voorvoegselnummer = models.IntegerField()
    voorvoegsel = models.CharField(max_length=10)
    scheidingsteken = models.CharField(max_length=1)


class AdellijkeTitelPredikaat(models.Model):
    predikaat = models.CharField(max_length=2)
    omschrijving = models.CharField(max_length=10)
    soort = models.CharField(max_length=10)


# Related models

class Reisdocument(models.Model):
    subject = models.ForeignKey(
        'IngeschrevenNatuurlijkPersoon', on_delete=models.CASCADE
    )
    # TODO...


class Verblijfsplaats(models.Model):
    adresherkomst = models.CharField(
        max_length=20, choices=AdresHerkomst.choices
    )
    huisletter = models.CharField(
        max_length=1, blank=True
    )
    identificatiecode_nummeraanduiding = models.CharField(
        max_length=29, blank=True
    )
    huisnummer = models.IntegerField()
    locatiebeschrijving = models.CharField(
        max_length=35, blank=True,
        help_text='Een geheel of gedeeltelijke omschrijving van de ligging van '
                  'een object.'
    )
    huisnummertoevoeging = models.CharField(
        max_length=4, blank=True
    )
    naam_openbare_ruimte = models.CharField(
        max_length=80,
    )
    postcode = models.CharField(
        max_length=6, validators=[RegexValidator(r'^[1-9]{1}[0-9]{3}[A-Z]{2}$')]
    )
