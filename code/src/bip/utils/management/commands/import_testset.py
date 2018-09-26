import datetime

from django.core.management import BaseCommand
from django.db import transaction

from tablib import import_set

from bip.datamodel.constants import AdresHerkomst, BurgerlijkeStaat, \
    RedenOpschortingBijhouding
from ....datamodel.models import IngeschrevenNatuurlijkPersoon, Naam, AdellijkeTitelPredikaat, Land, Naamgebruik, Nationaliteit, Geboorte, Overlijden, Reisdocument, Verblijfsplaats, Verblijfstitel, VoorvoegselGeslachtsnaam


class Command(BaseCommand):
    help = 'Laad de test data set in van het RVIG. Bron: ' \
           'https://www.rvig.nl/documenten/richtlijnen/2018/09/20/testdataset-persoonslijsten-proefomgevingen-gba-v-en-bv-bsn'

    def add_arguments(self, parser):
        parser.add_argument('infile', help='Het ODS bestand om in te laden.')

    def handle(self, **options):
        with open(options['infile'], 'rb') as infile:
            dataset = import_set(infile.read(), format='xls')

        def parse_date(val, default=False):
            if val:
                try:
                    return datetime.datetime.strptime(val, '%Y%m%d')
                except:
                    default=True
            if default:
                if default is True:
                    return datetime.date(1000, 1, 1)
                return default
            return None

        for line in dataset.dict:
            try:
                int(line['01.01.10'])
            except:
                continue

            with transaction.atomic():
                if line['01.01.10']:
                    # Persoon

                    # TODO: Hier moet dus een bestaande lijst van zijn...
                    land, _ = Land.objects.get_or_create(
                        code=line['01.03.30'],
                        defaults=dict(
                            naam='Onbekend',
                        )
                    )
                    adellijke_titel_predikaat = AdellijkeTitelPredikaat.objects.create(
                        predikaat=line['01.02.20'],
                    )
                    voorvoegsel_geslachtsnaam = VoorvoegselGeslachtsnaam.objects.create(
                        voorvoegselnummer=0,  # FIXME
                        voorvoegsel=line['01.02.30'],
                    )
                    naam = Naam.objects.create(
                        voornamen=line['01.02.10'],
                        geslachtsnaam=line['01.02.40'],
                        adellijke_titel_predikaat=adellijke_titel_predikaat,
                        voorvoegsel_geslachtsnaam=voorvoegsel_geslachtsnaam,
                    )
                    geboorte = Geboorte.objects.create(
                        datum=parse_date(line['01.03.10'], default=True),
                        plaats=line['01.03.20'],
                        land=land,
                    )
                    naamgebruik = Naamgebruik.objects.create(
                        aanduiding=line['01.61.10']
                    )

                    # Nationaliteit
                    nationaliteit = Nationaliteit.objects.create(
                        code=int(line['04.05.10']) if line['04.05.10'] else 0,
                        aanduiding_bijzonder_nederlanderschap=line['04.65.10']
                    )

                    # Overlijden
                    overlijden = None
                    if line['06.08.10']:
                        land_overlijden, _ = Land.objects.get_or_create(
                            code=line['06.08.30'],
                            defaults=dict(
                                naam='Onbekend',
                            )
                        )
                        overlijden = Overlijden.objects.create(
                            datum=parse_date(line['06.08.10']),
                            plaats=line['06.08.20'],
                            land=land_overlijden,
                        )

                    # Inschrijving
                    # TODO

                    # Verblijfplaats
                    verblijfsplaats = Verblijfsplaats.objects.create(
                        adresherkomst=AdresHerkomst.woonadres if line['08.10.10'] == 'W' else AdresHerkomst.briefadres,
                        huisnummer=line['08.11.20'] if line['08.11.20'] else 0,
                        huisletter=line['08.11.30'],
                        huisnummertoevoeging=line['08.11.50'],
                        postcode=line['08.11.60'],
                        naam_openbare_ruimte=line['08.11.15'],
                        woonplaatsnaam=line['08.11.70'],
                    )

                    verblijfstitel = Verblijfstitel.objects.create(
                        ingangsdatum=parse_date(line['10.39.20'], default=True),
                        datum_einde=parse_date(line['10.39.30'], default=True),
                        numeriek=line['10.39.10'],
                        datum_aanvang_geldigheid=parse_date(line['10.85.10'], default=True),
                    )

                    IngeschrevenNatuurlijkPersoon.objects.get_or_create(
                        a_nummer=int(line['01.01.10']),
                        defaults=dict(
                            burgerservicenummer=str(line['01.01.20'])[:9],
                            geslachtsaanduiding=line['01.04.10'],
                            datum_inschrijving_in_gemeente=parse_date(line['08.09.20'], default=True),
                            datum_begin_geldigheid_verblijfplaats=parse_date(line['08.85.10'], default=True),
                            datum_opschorting_bijhouding=parse_date(line['07.67.10'], default=True),
                            reden_opschorting_bijhouding=RedenOpschortingBijhouding.emigratie if line['07.67.20'] == 'E' else '',
                            indicatie_geheim=line['07.70.10'],
                            naam=naam,
                            geboorte=geboorte,
                            naamgebruik=naamgebruik,
                            nationaliteit=nationaliteit,
                            verblijfsplaats=verblijfsplaats,
                            verblijfstitel=verblijfstitel,
                            overlijden=overlijden,
                        )
                    )

        inp = None
        for line in dataset.dict:
            # Kinderen zijn opgenamen NA elk INP in de Excel. Het eerste record
            # met een A-nummer is de ouder, daarna volgen de kinderen.
            if line['01.01.10']:
                inp = IngeschrevenNatuurlijkPersoon.objects.get(a_nummer=int(line['01.01.10']))
            else:
                # Kind
                if line['09.01.10']:
                    kind = IngeschrevenNatuurlijkPersoon.objects.filter(a_nummer=int(line['09.01.10'])).first()
                    if kind:
                        inp.kinderen.add(kind)
                    continue

            # Ouder 1
            # Controleer A-nummer. Indien niet ingeschreven, skip voor nu.
            if line['02.01.10']:
                ouder_1 = IngeschrevenNatuurlijkPersoon.objects.filter(a_nummer=int(line['02.01.10'])).first()
                if ouder_1:
                    ouder_1.kinderen.add(inp)

            # Ouder 2
            if line['03.01.10']:
                ouder_2 = IngeschrevenNatuurlijkPersoon.objects.filter(a_nummer=int(line['03.01.10'])).first()
                if ouder_2:
                    ouder_2.kinderen.add(inp)

            # Partner
            if line['05.01.10']:
                partner = IngeschrevenNatuurlijkPersoon.objects.filter(a_nummer=int(line['05.01.10'])).first()
                if partner:
                    inp.partners.add(partner)

                inp.burgerlijke_staat=BurgerlijkeStaat.gehuwd if line['05.15.10'] == 'H' else BurgerlijkeStaat.parnterschap
                inp.save()
