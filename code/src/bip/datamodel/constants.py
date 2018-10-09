from django.utils.translation import ugettext_lazy as _

from djchoices import ChoiceItem, DjangoChoices


class PostadresType(DjangoChoices):
    antwoordnummer = ChoiceItem(
        'Antwoordnummer',
        label=_('Antwoordnummer')
    )
    postbusnummer = ChoiceItem(
        'Postbusnummer',
        label=_('Postbusnummer')
    )


class GeslachtsAanduiding(DjangoChoices):
    man = ChoiceItem(
        'Man',
        label=_('Man')
    )
    vrouw = ChoiceItem(
        'Vrouw',
        label=_('Vrouw')
    )
    onbekend = ChoiceItem(
        'Onbekend',
        label=_('Onbekend')
    )


class NaamgebruikAanduiding(DjangoChoices):
    """
    De voorgedefinieerde waarden van naamgebruik volgens de centrale
    voorzieningen. Zie attribuut Naamgebruik van groep A.1.12 Naamgebruik van
    BRP.
    """
    eigen = ChoiceItem('E', 'eigen')
    partner = ChoiceItem('P', 'Partner')
    partner_eigen = ChoiceItem('V', 'Partner, eigen')
    eigen_partner = ChoiceItem('N', 'Eigen, partner')

# class IndicatieGeheim(DjangoChoices):
#     geen beperking, niet zonder toestemming aan derden ter uitvoering van een, niet aan kerken, niet aan vrije derden, niet zonder toestemming aan derden ter uitvoering van een algemeen verbindend voorschrift en niet aan kerken, niet zonder toestemming aan derden ter uitvoering van een algemeen verbindend voorschrift en niet aan vrije derden, niet aan kerken en niet aan vrije derden, niet zonder toestemming aan derden ter uitvoering van een algemeen verbindend voorschrift en niet aan vrije derden en niet aan kerken

class AdresHerkomst(DjangoChoices):
    woonadres = ChoiceItem('Woonadres')
    briefadres = ChoiceItem('Briefadres')


class BurgerlijkeStaat(DjangoChoices):
    onbekend = ChoiceItem('onbekend'),
    ongehuwd = ChoiceItem('ongehuwd en nooit gehuwd geweest')
    gehuwd = ChoiceItem('gehuwd')
    gescheiden = ChoiceItem('gescheiden')
    weduwe = ChoiceItem('weduwe / weduwnaar')
    parnterschap = ChoiceItem('partnerschap')
    parnterschap_beeindigd = ChoiceItem('partnerschap beeindigd')
    achtergleven_partner = ChoiceItem('achtergebleven partner')


class RedenOpschortingBijhouding(DjangoChoices):
    overlijden = ChoiceItem('overlijden')
    emigratie = ChoiceItem('emigratie')
    ministrieel_besluit = ChoiceItem('Ministerieel besluit')
    pl_aangelegd_in_de_rni = ChoiceItem('PL aangelegd in de RNI')
    fout = ChoiceItem('fout')
    standaardwaarde_indien_onbekend = ChoiceItem('standaardwaarde indien onbekend')


class AanduidingBijzonderNederlandschap(DjangoChoices):
    behandeld_als_nederlander = ChoiceItem('behandeld als Nederlander')
    vastgesteld_niet_nederlander = ChoiceItem('vastgesteld niet-Nederlander')
