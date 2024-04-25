---
layout: page-with-side-nav
title: partner velden vragen met fields
---
#language: nl  


# Functionaliteit: partner velden vragen met fields


### Scenario: persoon heeft een actueel huwelijk

* __Gegeven__ de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens

  | burgerservicenummer (01.20) | soort verbintenis (15.10) | voornamen (02.10) |
  |-----------------------------|---------------------------|-------------------|
  | 123456789                   | H                         | Merel             |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000012                       |
  | fields              | partners                        |
* __Dan__ heeft de response een persoon met een 'partner' met alleen de volgende gegevens

  | naam                          | waarde    |
  |-------------------------------|-----------|
  | burgerservicenummer           | 123456789 |
  | soortVerbintenis.code         | H         |
  | soortVerbintenis.omschrijving | huwelijk  |
* __En__ heeft de 'partner' de volgende 'naam' gegevens

  | naam        | waarde |
  |-------------|--------|
  | voornamen   | Merel  |
  | voorletters | M.     |

### Scenario: persoon heeft een actueel partnerschap

* __Gegeven__ de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens

  | burgerservicenummer (01.20) | soort verbintenis (15.10) | voornamen (02.10) |
  |-----------------------------|---------------------------|-------------------|
  | 123456789                   | P                         | Reindert          |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000012                       |
  | fields              | partners                        |
* __Dan__ heeft de response een persoon met een 'partner' met alleen de volgende gegevens

  | naam                          | waarde                     |
  |-------------------------------|----------------------------|
  | burgerservicenummer           | 123456789                  |
  | soortVerbintenis.code         | P                          |
  | soortVerbintenis.omschrijving | geregistreerd partnerschap |
* __En__ heeft de 'partner' de volgende 'naam' gegevens

  | naam        | waarde   |
  |-------------|----------|
  | voornamen   | Reindert |
  | voorletters | R.       |

## Regel: Als er geen actueel huwelijk of geregistreerd partnerschap is, maar wel één of meerdere ontbonden huwelijk of geregistreerd partnerschappen, dan wordt alleen het meest recente ontbonden huwelijk of geregistreerd partnerschap geleverd


### Scenario: persoon heeft een ontbonden huwelijk/partnerschap

* __Gegeven__ de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens

  | burgerservicenummer (01.20) | soort verbintenis (15.10) | voornamen (02.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
  |-----------------------------|---------------------------|-------------------|--------------------------/-----------------------------------|
  | 123456789                   | H                         | Reindert          | 20011109                                                     |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000012                       |
  | fields              | partners                        |
* __Dan__ heeft de response een persoon met een 'partner' met alleen de volgende gegevens

  | naam                          | waarde    |
  |-------------------------------|-----------|
  | burgerservicenummer           | 123456789 |
  | soortVerbintenis.code         | H         |
  | soortVerbintenis.omschrijving | huwelijk  |
* __En__ heeft de 'partner' de volgende 'naam' gegevens

  | naam        | waarde   |
  |-------------|----------|
  | voornamen   | Reindert |
  | voorletters | R.       |
* __En__ heeft de 'partner' de volgende 'ontbindingHuwelijkPartnerschap' gegevens

  | naam              | waarde          |
  |-------------------|-----------------|
  | datum.type        | Datum           |
  | datum.datum       | 2001-11-09      |
  | datum.langFormaat | 9 november 2001 |

### Scenario: persoon heeft meerdere ontbonden huwelijk/partnerschappen

* __Gegeven__ de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens

  | burgerservicenummer (01.20) | soort verbintenis (15.10) | voornamen (02.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
  |-----------------------------|---------------------------|-------------------|--------------------------/-----------------------------------|
  | 123456789                   | H                         | Reindert          | 20011109                                                     |
* __En__ de persoon heeft nog een 'partner' met de volgende gegevens

  | burgerservicenummer (01.20) | soort verbintenis (15.10) | voornamen (02.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
  |-----------------------------|---------------------------|-------------------|--------------------------/-----------------------------------|
  | 234567890                   | H                         | Jan               | 20120401                                                     |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000012                       |
  | fields              | partners                        |
* __Dan__ heeft de response een persoon met een 'partner' met alleen de volgende gegevens

  | naam                          | waarde    |
  |-------------------------------|-----------|
  | burgerservicenummer           | 234567890 |
  | soortVerbintenis.code         | H         |
  | soortVerbintenis.omschrijving | huwelijk  |
* __En__ heeft de 'partner' de volgende 'naam' gegevens

  | naam        | waarde |
  |-------------|--------|
  | voornamen   | Jan    |
  | voorletters | J.     |
* __En__ heeft de 'partner' de volgende 'ontbindingHuwelijkPartnerschap' gegevens

  | naam              | waarde       |
  |-------------------|--------------|
  | datum.type        | Datum        |
  | datum.datum       | 2012-04-01   |
  | datum.langFormaat | 1 april 2012 |

## Regel: Als er een actueel huwelijk of geregistreerd partnerschap is wordt alleen dit actueel huwelijk of geregistreerd partnerschap geleverd


### Scenario: persoon heeft een actueel en een ontbonden huwelijk

* __Gegeven__ de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens

  | burgerservicenummer (01.20) | soort verbintenis (15.10) | voornamen (02.10) | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) |
  |-----------------------------|---------------------------|-------------------|--------------------------/-----------------------------------|
  | 123456789                   | H                         | Reindert          | 20011109                                                     |
* __En__ de persoon heeft nog een 'partner' met de volgende gegevens

  | burgerservicenummer (01.20) | soort verbintenis (15.10) | voornamen (02.10) | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
  |-----------------------------|---------------------------|-------------------|------------------------/-------------------------------------------|
  | 234567890                   | H                         | Karel             | 20051224                                                           |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000012                       |
  | fields              | partners                        |
* __Dan__ heeft de response een persoon met een 'partner' met alleen de volgende gegevens

  | naam                          | waarde    |
  |-------------------------------|-----------|
  | burgerservicenummer           | 234567890 |
  | soortVerbintenis.code         | H         |
  | soortVerbintenis.omschrijving | huwelijk  |
* __En__ heeft de 'partner' de volgende 'naam' gegevens

  | naam        | waarde |
  |-------------|--------|
  | voornamen   | Karel  |
  | voorletters | K.     |
* __En__ heeft de 'partner' de volgende 'aangaanHuwelijkPartnerschap' gegevens

  | naam              | waarde           |
  |-------------------|------------------|
  | datum.type        | Datum            |
  | datum.datum       | 2005-12-24       |
  | datum.langFormaat | 24 december 2005 |

