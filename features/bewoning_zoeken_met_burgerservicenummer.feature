Functionaliteit: Bewoningen zoeken van een ingeschreven persoon op basis van zijn burgerservicenummer

Achtergrond:
    Gegeven de ingeschreven persoon met burgerservicenummer 999994669 kent de volgende verblijfplaatsen
    | datum aanvang adreshouding | datum tot  | adres            | identificatie code nummeraanduiding |
    | 1994-05-08                 | -          | Beethovenlaan 23 | 123456789                           |
    | 1993-09-10                 | 1994-05-08 | Kerkstraat 83    | 234567890                           |
    | 1993-02-15                 | 1993-09-10 | België           |                                     |
    | 1961-12-30                 | 1993-02-15 | Javaplein 11     | 345678901                           |

Scenario: Zoeken met een peildatum
    Als bewoningen wordt gezocht met burgerservicenummer 999994669 en peildatum vandaag
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Beethovenlaan        | 23         | 123456789                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 123456789 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot |
    | 999994669           | 1994-05-08                 | -         |

Scenario: Zoeken vanaf een datum
    Als bewoningen wordt gezocht met burgerservicenummer 999994669 en datumvan 1993-01-01
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Beethovenlaan        | 23         | 123456789                           |
    | Kerkstraat           | 83         | 234567890                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 123456789 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot |
    | 999994669           | 1994-05-08                 | -         |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 234567890 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999994669           | 1993-09-10                 | 1994-05-08 |

Scenario: Zoeken tot en met een datum
    Als bewoningen wordt gezocht met burgerservicenummer 999994669 en datumtotenmet 1994-01-01
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Kerkstraat           | 83         | 234567890                           |
    | Javaplein            | 11         | 345678901                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 234567890 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999994669           | 1993-09-10                 | 1994-05-08 |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 345678901 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999994669           | 1961-12-30                 | 1993-02-15 |

Scenario: Zoeken in een periode
    Als bewoningen wordt gezocht met burgerservicenummer 999994669, datumvan 1993-01-01 en datumtotenmet 1994-01-01
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Kerkstraat           | 83         | 234567890                           |
    | Javaplein            | 11         | 345678901                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 234567890 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999994669           | 1993-09-10                 | 1994-05-08 |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 345678901 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999994669           | 1961-12-30                 | 1993-02-15 |


Scenario: Zoeken in een periode en peildatum (verblijfplaats op peildatum is gelijk aan een verblijfplaats in de periode)
    Als bewoningen wordt gezocht met burgerservicenummer 999994669, datumvan 1993-01-01 en datumtotenmet 1994-01-01 en peildatum 1994-02-01
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Kerkstraat           | 83         | 234567890                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 234567890 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999994669           | 1993-09-10                 | 1994-05-08 |

Scenario: Zoeken in een periode en peildatum (verblijfplaats op peildatum is ongelijk aan een verblijfplaats in de periode)
    Als bewoningen wordt gezocht met burgerservicenummer 999994669, datumvan 1993-01-01 en datumtotenmet 1994-01-01 en peildatum 1994-06-01
    Dan wordt er geen bewoning teruggegeven
    