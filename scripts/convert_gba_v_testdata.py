import csv
import json
import re

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

def set_field_value(target_object, field_name, value):
    if field_name == 'europeesKiesrecht':
        if value == '2':
            target_object[field_name] = True
    elif field_name == 'uitgeslotenVanKiesrecht':
        if value == 'A':
            target_object[field_name] = True
    elif field_name == 'indicatieCurateleRegister':
        if value == '1':
            target_object[field_name] = True
    else:
        target_object[field_name] = value

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
                set_field_value(tmp_object, subfield, value)
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

    gemeenten = import_landelijke_tabel('Tabel33 Gemeententabel.csv')
    landen = import_landelijke_tabel('Tabel34 Landentabel.csv')
    nationaliteiten = import_landelijke_tabel('Tabel32 Nationaliteitentabel.csv')
    reden_opnemen = import_landelijke_tabel('Tabel37 Reden opnemen.csv')
    gezagsverhoudingen = import_landelijke_tabel('Tabel61 Gezagsverhoudingtabel.csv')

    target = []

    with open(gba_v_testdata_file, 'r', encoding='utf-8-sig') as src:
        src_reader = csv.DictReader(src, delimiter=';')

        for row in src_reader:
            target_object = map_dictionary(row, fields_to_map)

            if(target_object.get('burgerservicenummer') != None and target_object.get('naam') != None):
                add_gemeente_van_inschrijving_omschrijving(target_object, gemeenten)
                add_plaats_en_land_omschrijvingen(target_object.get('geboorte'), gemeenten, landen)
                add_plaats_en_land_omschrijvingen(target_object.get('overlijden'), gemeenten, landen)
                add_omschrijving(target_object.get('indicatieGezagMinderjarige'), gezagsverhoudingen)
                add_ouders_omschrijvingen(target_object, gemeenten, landen)
                add_partners_omschrijvingen(target_object, gemeenten, landen)
                add_nationaliteiten_omschrijvingen(target_object, nationaliteiten, reden_opnemen)
                add_verblijfplaats_omschrijvingen(target_object, landen)

                target.append(target_object)

    with open(gba_v_testdata_json_file, 'w', encoding='utf-8') as dst:
        dst.write(json.dumps(target, indent=2, ensure_ascii=False))

def import_landelijke_tabel(landelijke_tabel_file):
    target = {}

    with open(landelijke_tabel_file, 'r', encoding='utf-8-sig') as src:
        src_reader = csv.DictReader(src, delimiter=';')

        for row in src_reader:
            code = row['code']
            omschrijving = row['omschrijving']
            target[code] = omschrijving

    return target

def add_omschrijving(target_object, tabel):
    if target_object == None:
        return

    code = target_object.get('code')
    if code == None:
        return

    omschrijving = tabel.get(code)
    if omschrijving != None:
        target_object['omschrijving'] = omschrijving

def add_cijfer_code_omschrijving(target_object, tabel):
    if target_object == None:
        return

    code = target_object.get('code')
    match = re.search('^\d{3,4}$', code)
    if match:
        omschrijving = tabel.get(code)
        if omschrijving != None:
            target_object['omschrijving'] = omschrijving
    else:
        target_object['omschrijving'] = code
        target_object.pop('code')

def add_gemeente_van_inschrijving_omschrijving(target_object, gemeenten_tabel):
    add_cijfer_code_omschrijving(target_object.get('gemeenteVanInschrijving'), gemeenten_tabel)

def add_plaats_en_land_omschrijvingen(target_object, gemeenten_tabel, landen_tabel):
    if target_object == None:
        return

    add_cijfer_code_omschrijving(target_object.get('plaats'), gemeenten_tabel)    
    add_cijfer_code_omschrijving(target_object.get('land'), landen_tabel)

def add_ouders_omschrijvingen(target_object, gemeenten_tabel, landen_tabel):
    ouders = target_object.get('ouders')

    if ouders == None:
        return

    for ouder in ouders:
        add_plaats_en_land_omschrijvingen(ouder.get('geboorte'), gemeenten_tabel, landen_tabel)

def add_partners_omschrijvingen(target_object, gemeenten_tabel, landen_tabel):
    partners = target_object.get('partners')

    if partners == None:
        return

    for partner in partners:
        add_plaats_en_land_omschrijvingen(partner.get('geboorte'), gemeenten_tabel, landen_tabel)
        add_plaats_en_land_omschrijvingen(partner.get('aangaanHuwelijkPartnerschap'), gemeenten_tabel, landen_tabel)

def add_nationaliteiten_omschrijvingen(target_object, nationaliteiten_tabel, reden_opnemen_tabel):
    nationaliteiten = target_object.get('nationaliteiten')

    if nationaliteiten == None:
        return
    
    for nationaliteit in nationaliteiten:
        add_cijfer_code_omschrijving(nationaliteit.get('nationaliteit'), nationaliteiten_tabel)
        add_cijfer_code_omschrijving(nationaliteit.get('redenOpname'), reden_opnemen_tabel)

def add_verblijfplaats_omschrijvingen(target_object, landen_tabel):
    verblijfplaats = target_object.get('verblijfplaats')

    if verblijfplaats == None:
        return

    add_cijfer_code_omschrijving(verblijfplaats.get('landVanwaarIngeschreven'), landen_tabel)

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
    '01.08.10': 'overlijden.datum',
    '01.08.20': 'overlijden.plaats.code',
    '01.08.30': 'overlijden.land.code',
    '01.61.10': 'naam.aanduidingNaamgebruik.code',
    '01.83.10': 'persoonInOnderzoek.aanduidingGegevensInOnderzoek',
    '01.83.20': 'persoonInOnderzoek.datumIngangOnderzoek',
    '02.01.20': 'ouders[1].burgerservicenummer',
    '02.02.10': 'ouders[1].naam.voornamen',
    '02.02.20': 'ouders[1].naam.adellijkeTitelPredicaat.code',
    '02.02.30': 'ouders[1].naam.voorvoegsel',
    '02.02.40': 'ouders[1].naam.geslachtsnaam',
    '02.03.10': 'ouders[1].geboorte.datum',
    '02.03.20': 'ouders[1].geboorte.plaats.code',
    '02.03.30': 'ouders[1].geboorte.land.code',
    '02.04.10': 'ouders[1].geslacht.code',
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
    '03.04.10': 'ouders[2].geslacht.code',
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
    '05.04.10': 'partners[].geslacht.code',
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
    '07.67.10': 'opschortingBijhouding.datum',
    '07.67.20': 'opschortingBijhouding.reden.code',
    '07.68.10': 'datumEersteInschrijvingGBA',
    '07.70.10': 'geheimhoudingPersoonsgegevens',
    '08.09.10': 'gemeenteVanInschrijving.code',
    '08.09.20': 'datumInschrijvingInGemeente',
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
    '08.13.20': 'verblijfplaats.datumAanvangAdresBuitenland',
    '08.13.30': 'verblijfplaats.adresregel1',
    '08.13.40': 'verblijfplaats.adresregel2',
    '08.13.50': 'verblijfplaats.adresregel3',
    '08.14.10': 'verblijfplaats.landVanwaarIngeschreven.code',
    '08.14.20': 'verblijfplaats.datumVestigingInNederland',
    '09.01.20': 'kinderen[].burgerservicenummer',
    '09.02.10': 'kinderen[].naam.voornamen',
    '09.02.20': 'kinderen[].naam.adellijkeTitelPredicaat.code',
    '09.02.30': 'kinderen[].naam.voorvoegsel',
    '09.02.40': 'kinderen[].naam.geslachtsnaam',
    '09.03.10': 'kinderen[].geboorte.datum',
    '09.03.20': 'kinderen[].geboorte.plaats.code',
    '09.03.30': 'kinderen[].geboorte.land.code',
    '10.39.10': 'verblijfstitel.aanduiding.code',
    '10.39.20': 'verblijfstitel.datumEinde',
    '10.39.30': 'verblijfstitel.datumIngang',
    '11.32.10': 'indicatieGezagMinderjarige.code',
    '11.33.10': 'indicatieCurateleRegister',
    '11.83.10': 'gezagInOnderzoek.aanduidingGegevensInOnderzoek',
    '11.83.20': 'gezagInOnderzoek.datumIngangOnderzoek',
    '13.31.10': 'europeesKiesrecht.aanduiding.code',
    '13.31.30': 'europeesKiesrecht.einddatumUitsluiting',
    '13.38.10': 'uitsluitingKiesrecht.uitgeslotenVanKiesrecht',
    '13.38.20': 'uitsluitingKiesrecht.einddatum',
}

convert_gba_v_testdata(fields_to_map, '20220502_Testset_persoonslijsten_proefomgeving_GBA-V.csv', '../src/config/BrpService/test-data.json')
