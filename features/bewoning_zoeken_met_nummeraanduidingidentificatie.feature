Functionaliteit: Bewoningen zoeken op een verblijfplaats op basis van een nummeraanduiding identificatie

Achtergrond:
    Gegeven de verblijfplaats
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Beethovenlaan        | 23         | 123456789                           |
    En de verblijfplaats met identificatie code nummeraanduiding 123456789 kent de volgende bewoners
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999994669           | 1994-05-08                 | -          |
    | 999992338           | 1994-01-02                 | -          |
    | 999993483           | 1992-03-05                 | 1994-04-30 |


Scenario: Zoeken met een peildatum
    Als bewoningen wordt gezocht met nummeraanduiding identificatie 123456789 en peildatum vandaag
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Beethovenlaan        | 23         | 123456789                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 123456789 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot |
    | 999992338           | 1994-01-02                 | -         |
    | 999994669           | 1994-05-08                 | -         |

Scenario: Zoeken vanaf een datum
    Als bewoningen wordt gezocht met nummeraanduiding identificatie 123456789 en datumvan 1993-01-01
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Beethovenlaan        | 23         | 123456789                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 123456789 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999993483           | 1992-03-05                 | 1994-04-30 |
    | 999992338           | 1994-01-02                 | -          |
    | 999994669           | 1994-05-08                 | -          |

Scenario: Zoeken tot en met een datum
    Als bewoningen wordt gezocht met nummeraanduiding identificatie 123456789 en datumtotenmet 1994-01-01
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Beethovenlaan        | 23         | 123456789                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 123456789 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999993483           | 1992-03-05                 | 1994-04-30 |

Scenario: Zoeken in een periode
    Als bewoningen wordt gezocht met nummeraanduiding identificatie 123456789, datumvan 1993-01-01 en datumtotenmet 1994-01-31
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Beethovenlaan        | 23         | 123456789                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 123456789 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999993483           | 1992-03-05                 | 1994-04-30 |
    | 999992338           | 1994-01-02                 | -          |

Scenario: Zoeken in een periode en peildatum (bewoner verblijft in periode en op peildatum op de opgegeven verblijfplaats)
    Als bewoningen wordt gezocht met nummeraanduiding identificatie 123456789, datumvan 1993-01-01 en datumtotenmet 1994-01-31 en peildatum 1994-04-01
    Dan wordt de volgende bewoning teruggegeven
    | naam openbare ruimte | huisnummer | identificatie code nummeraanduiding |
    | Beethovenlaan        | 23         | 123456789                           |
    En wordt bij de bewoning met identificatiecodenummeraanduiding 123456789 de volgende bewoners teruggegeven
    | burgerservicenummer | datum aanvang adreshouding | datum tot  |
    | 999993483           | 1992-03-05                 | 1994-04-30 |
    | 999992338           | 1994-01-02                 | -          |

Scenario: Zoeken in een periode en peildatum (geen enkele bewoner verblijft in periode en op peildatum op de opgegeven verblijfplaats)
    Als bewoningen wordt gezocht met nummeraanduiding identificatie 123456789, datumvan 1993-01-01 en datumtotenmet 1994-01-31 en peildatum 1992-01-01
    Dan wordt er geen bewoning teruggegeven
