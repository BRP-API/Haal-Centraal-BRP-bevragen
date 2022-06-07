import csv
import json

def find_or_create_ouder(persoon, ouder_aanduiding):
    if not persoon.get('ouders'):
        persoon['ouders'] = []

    for ouder in persoon['ouders']:
        if ouder.get('ouderAanduiding') == ouder_aanduiding:
            return ouder

    ouder = {
        'ouderAanduiding': ouder_aanduiding
    }
    persoon['ouders'].append(ouder)

    return ouder

def find_or_create_collectie(persoon, collectiefield):
    if not persoon.get(collectiefield):
        persoon[collectiefield] = [{}]

    return persoon[collectiefield][0]

def map_dictionary(src_dict, fields_to_map):
    target_object = {}
    
    for field in fields_to_map.keys():
        value = src_dict.get(field)
        if not value:
            continue

        field_to_map = fields_to_map.get(field)
        subfields_to_map = field_to_map.split('.')
        tmp_object = target_object

        for subfield in subfields_to_map:
            if subfield == subfields_to_map[-1]:
                if subfield == 'europeesKiesrecht':
                    if value == '2':
                        tmp_object[subfield] = True
                elif subfield == 'uitgeslotenVanKiesrecht':
                    if value == 'A':
                        tmp_object[subfield] = True
                else:
                    tmp_object[subfield] = value
                continue
            elif '[1]' in subfield:
                tmp_object = find_or_create_ouder(tmp_object, "1")
                continue
            elif '[2]' in subfield:
                tmp_object = find_or_create_ouder(tmp_object, "2")
                continue
            elif '[]' in subfield:
                tmp_object = find_or_create_collectie(tmp_object, subfield.replace('[]', ''))
                continue
            elif not tmp_object.get(subfield):
                tmp_object[subfield] = {}
            tmp_object = tmp_object[subfield]

    return target_object

def convert_gba_v_testdata(fields_to_map, gba_v_testdata_file, gba_v_testdata_json_file):
    """
    Convert the GBA V test data file to a CSV file.
    """
    target = []

    with open(gba_v_testdata_file, 'r', encoding='utf-8-sig') as src:
        src_reader = csv.DictReader(src, delimiter=';')

        for row in src_reader:
            target_object = map_dictionary(row, fields_to_map)

            if not all(value == 0 for value in target_object.values()):
                target.append(target_object)

    with open(gba_v_testdata_json_file, 'w', encoding='utf-8') as dst:
        dst.write(json.dumps(target, indent=2, ensure_ascii=False))

fields_to_map = {
    '01.01.10': 'aNummer',
    '01.01.20': 'burgerservicenummer',
    '01.02.10': 'naam.voornamen',
    '01.02.20': 'naam.adellijkeTitelPredicaat.code',
    '01.02.30': 'naam.voorvoegsel',
    '01.02.40': 'naam.geslachtsnaam',
    '01.03.10': 'geboorte.datum',
    '01.03.20': 'geboorte.plaats.code',
    '01.03.30': 'geboorte.land.code',
    '01.04.10': 'geslacht.code',
    '01.61.10': 'naam.aanduidingNaamgebruik.code',
    '01.83.10': 'inOnderzoek.aanduidingGegevensInOnderzoek',
    '01.83.20': 'inOnderzoek.datumIngangOnderzoek',
    '02.01.20': 'ouders[1].burgerservicenummer',
    '02.02.10': 'ouders[1].naam.voornamen',
    '02.02.20': 'ouders[1].naam.adellijkeTitelPredicaat.code',
    '02.02.30': 'ouders[1].naam.voorvoegsel',
    '02.02.40': 'ouders[1].naam.geslachtsnaam',
    '02.03.10': 'ouders[1].geboorte.datum',
    '02.03.20': 'ouders[1].geboorte.plaats.code',
    '02.03.30': 'ouders[1].geboorte.land.code',
    '02.04.10': 'ouders[1].geslachtsaanduiding.code',
    '02.62.10': 'ouders[1].datumIngangFamilierechtelijkeBetrekking',
    '02.83.10': 'ouders[1].inOnderzoek.aanduidingGegevensInOnderzoek',
    '02.83.20': 'ouders[1].inOnderzoek.datumIngangOnderzoek',
    '03.01.20': 'ouders[2].burgerservicenummer',
    '03.02.10': 'ouders[2].naam.voornamen',
    '03.02.20': 'ouders[2].naam.adellijkeTitelPredicaat.code',
    '03.02.30': 'ouders[2].naam.voorvoegsel',
    '03.02.40': 'ouders[2].naam.geslachtsnaam',
    '03.03.10': 'ouders[2].geboorte.datum',
    '03.03.20': 'ouders[2].geboorte.plaats.code',
    '03.03.30': 'ouders[2].geboorte.land.code',
    '03.04.10': 'ouders[2].geslachtsaanduiding.code',
    '03.62.10': 'ouders[2].datumIngangFamilierechtelijkeBetrekking',
    '03.83.10': 'ouders[2].inOnderzoek.aanduidingGegevensInOnderzoek',
    '03.83.20': 'ouders[2].inOnderzoek.datumIngangOnderzoek',
    '04.05.10': 'nationaliteiten[].nationaliteit.code',
    '04.63.10': 'nationaliteiten[].redenOpname.code',
    '04.65.10': 'nationaliteiten[].aanduidingBijzonderNederlanderschap',
    # '04.83.10': 'nationaliteiten[].inOnderzoek.aanduidingGegevensInOnderzoek',
    # '04.83.20': 'nationaliteiten[].inOnderzoek.datumIngangOnderzoek',
    '04.85.10': 'nationaliteiten[].datumIngangGeldigheid',
    '05.01.20': 'partners[].burgerservicenummer',
    '05.02.10': 'partners[].naam.voornamen',
    '05.02.20': 'partners[].naam.adellijkeTitelPredicaat.code',
    '05.02.30': 'partners[].naam.voorvoegsel',
    '05.02.40': 'partners[].naam.geslachtsnaam',
    '05.03.10': 'partners[].geboorte.datum',
    '05.03.20': 'partners[].geboorte.plaats.code',
    '05.03.30': 'partners[].geboorte.land.code',
    '05.04.10': 'partners[].geslachtsaanduiding.code',
    '05.06.10': 'partners[].aangaanHuwelijkPartnerschap.datum',
    '05.06.20': 'partners[].aangaanHuwelijkPartnerschap.plaats.code',
    '05.06.30': 'partners[].aangaanHuwelijkPartnerschap.land.code',
    '05.07.10': 'partners[].ontbindingHuwelijkPartnerschap.datum',
    '05.15.10': 'partners[].soortVerbintenis.code',
    '05.83.10': 'partners[].inOnderzoek.aanduidingGegevensInOnderzoek',
    '05.83.20': 'partners[].inOnderzoek.datumIngangOnderzoek',
    '06.08.10': 'overlijden.datum',
    '06.08.20': 'overlijden.plaats.code',
    '06.08.30': 'overlijden.land.code',
    '07.68.10': 'datumEersteInschrijvingGBA',
    '07.70.10': 'geheimhoudingPersoonsgegevens',
    '08.09.10': 'gemeenteVanInschrijving.code',
    '08.10.10': 'verblijfplaats.functieAdres.code',
    '08.11.10': 'verblijfplaats.straat',
    '08.11.15': 'verblijfplaats.naamOpenbareRuimte',
    '08.11.20': 'verblijfplaats.huisnummer',
    '08.11.30': 'verblijfplaats.huisletter',
    '08.11.40': 'verblijfplaats.huisnummertoevoeging',
    '08.11.50': 'verblijfplaats.aanduidingBijHuisnummer.code',
    '08.11.60': 'verblijfplaats.postcode',
    '08.11.70': 'verblijfplaats.woonplaats',
    '08.11.80': 'verblijfplaats.adresseerbaarObjectIdentificatie',
    '08.11.90': 'verblijfplaats.nummeraanduidingIdentificatie',
    '08.12.10': 'verblijfplaats.locatiebeschrijving',
    '08.13.30': 'verblijfplaats.adresregel1',
    '08.13.40': 'verblijfplaats.adresregel2',
    '08.13.50': 'verblijfplaats.adresregel3',
    '09.01.20': 'kinderen[].burgerservicenummer',
    '09.02.10': 'kinderen[].naam.voornamen',
    '09.02.20': 'kinderen[].naam.adellijkeTitelPredicaat.code',
    '09.02.30': 'kinderen[].naam.voorvoegsel',
    '09.02.40': 'kinderen[].naam.geslachtsnaam',
    '09.03.10': 'kinderen[].geboorte.datum',
    '09.03.20': 'kinderen[].geboorte.plaats.code',
    '09.03.30': 'kinderen[].geboorte.land.code',
    '10.39.10': 'verblijfstitel.aanduiding.code',
    '13.31.10': 'europeesKiesrecht.aanduiding.code',
    '13.31.30': 'europeesKiesrecht.einddatumUitsluiting',
    '13.38.10': 'uitsluitingKiesrecht.uitgeslotenVanKiesrecht',
    '13.38.20': 'uitsluitingKiesrecht.einddatum',
}

convert_gba_v_testdata(fields_to_map, '20220502_Testset_persoonslijsten_proefomgeving_GBA-V.csv', '../src/config/BrpService/test-data.json')
