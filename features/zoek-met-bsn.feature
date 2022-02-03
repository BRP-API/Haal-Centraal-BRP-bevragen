#language: nl

Functionaliteit: Zoek met burgerservicenummer(s)

Rule: Er moet minimaal één burgerservicenummer worden opgegeven

    Scenario: Zoek met valide burgerservicenummer

        Gegeven het systeem heeft een persoon met de volgende gegevens
        | burgerservicenummer |
        | 999999321           |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                     |
        | type                | ZoekMetBurgerservicenummer |
        | burgerservicenummer | 999999321                  |
        | fields              | burgerservicenummer        |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999999321           |

    Scenario: Zoek met meerdere valide burgerservicenummers

        Gegeven het systeem heeft een persoon met de volgende gegevens
        | burgerservicenummer |
        | 999999321           |
        En het systeem heeft een persoon met de volgende gegevens
        | burgerservicenummer |
        | 999995492           |
        En het systeem heeft een persoon met de volgende gegevens
        | burgerservicenummer |
        | 999991802           |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                        |
        | type                | ZoekMetBurgerservicenummer    |
        | burgerservicenummer | 999999321,999995492,999991802 |
        | fields              | burgerservicenummer           |
        Dan bevat de response alleen personen met de volgende gegevens 
        | burgerservicenummer |
        | 999999321           |
        | 999995492           |
        | 999991802           |

    @fout-case
    Scenario: Zoek zonder burgerservicenummers
        Als personen wordt gezocht met de volgende parameters
        | naam   | waarde                     |
        | type   | ZoekMetBurgerservicenummer |
        | fields | burgerservicenummer        |
        Dan bevat de response een problemDetails met de volgende velden
        | naam   | waarde                                        |
        | title  | Één of meerdere parameters zijn niet correct. |
        | status | 400                                           |

    @fout-case
    Abstract Scenario: <titel>
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                     |
        | type                | ZoekMetBurgerservicenummer |
        | burgerservicenummer | <burgerservicenummers>     |
        | fields              | burgerservicenummer        |
        Dan bevat de response een problemDetails met de volgende velden
        | naam   | waarde                                        |
        | title  | Één of meerdere parameters zijn niet correct. |
        | status | 400                                           |

        Voorbeelden:
        | burgerservicenummers | titel                                   |
        |                      | Zoek met leeg burgerservicenummer lijst |
        | 1234567890           | Zoek met ongeldig burgerservicenummer   |

Rule: Er mag maximaal 10 burgerservicenummers worden opgegeven

    @fout-case
    Scenario: Zoek met meer dan 10 burgerservicenummers
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                                                                                                        |
        | type                | ZoekMetBurgerservicenummer                                                                                    |
        | burgerservicenummer | 999999321,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802 |
        | fields              | burgerservicenummer                                                                                           |
        Dan bevat de response een problemDetails met de volgende velden
        | naam   | waarde                                        |
        | title  | Één of meerdere parameters zijn niet correct. |
        | status | 400                                           |
