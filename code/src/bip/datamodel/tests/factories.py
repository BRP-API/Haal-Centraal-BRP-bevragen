from datetime import timedelta

from django.utils import timezone

import factory


class BesluitFactory(factory.django.DjangoModelFactory):
    verantwoordelijke_organisatie = factory.Faker('ssn', locale='nl_NL')
    besluittype = factory.Faker('url')
    zaak = factory.Faker('url')
    datum = factory.Faker('date_time_this_decade', after_now=False, tzinfo=timezone.utc)

    class Meta:
        model = 'datamodel.Besluit'

    @factory.lazy_attribute
    def ingangsdatum(self):
        _ingangsdatum = factory.Faker(
            'date_time_between',
            start_date=self.datum,
            end_date=self.datum + timedelta(days=180),
            tzinfo=self.datum.tzinfo
        )
        return _ingangsdatum.evaluate(self, None, None)


class BesluitInformatieObjectFactory(factory.django.DjangoModelFactory):
    besluit = factory.SubFactory(BesluitFactory)
    informatieobject = factory.Faker('url')

    class Meta:
        model = 'datamodel.BesluitInformatieObject'
