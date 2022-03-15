# language: nl

@ready
Functionaliteit: volledige naam

Rule: de volledige naam wordt samengesteld door achter elkaar plaatsen van voornamen, voorvoegsels en geslachtsnaam

  Abstract Scenario: volledige naam van persoon
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde                |
    | burgerservicenummer | <burgerservicenummer> |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                                 | waarde          |
    | voornamen (02.10)                    | <voornamen>     |
    | adellijke titel of predikaat (02.20) |                 |
    | voorvoegsel (02.30)                  | <voorvoegsel>   |
    | geslachtsnaam (02.40)                | <geslachtsnaam> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | <burgerservicenummer>           |
    | fields              | naam.volledigeNaam              |
    Dan heeft de persoon met burgerservicenummer '<burgerservicenummer>' de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | burgerservicenummer | voornamen       | voorvoegsel | geslachtsnaam | volledigeNaam           |
    | 999995078           | Christina Maria |             | Maassen       | Christina Maria Maassen |
    | 999994542           | Gerrit          | den         | Braber        | Gerrit den Braber       |
    | 999994074           |                 |             | Obbadah       | Obbadah                 |

Rule: een predicaat wordt opgenomen voor de voornamen met de omschrijving horend bij de waarde in tabel 38 en geschreven in kleine letters

  Abstract Scenario: volledige naam van persoon met predikaat
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde                |
    | burgerservicenummer | <burgerservicenummer> |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                                 | waarde                    |
    | voornamen (02.10)                    | <voornamen>               |
    | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat> |
    | voorvoegsel (02.30)                  | <voorvoegsel>             |
    | geslachtsnaam (02.40)                | <geslachtsnaam>           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | <burgerservicenummer>           |
    | fields              | naam.volledigeNaam              |
    Dan heeft de persoon met burgerservicenummer '<burgerservicenummer>' de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | burgerservicenummer | voornamen            | adellijkeTitelPredicaat | voorvoegsel | geslachtsnaam | volledigeNaam                               |
    | 999994669           | Żáïŀëñøŕ Åłéèç Đëļŧå | JV                      | 'S          | Streeveld     | jonkvrouw Żáïŀëñøŕ Åłéèç Đëļŧå 'S Streeveld |

Rule: een adellijke titel wordt opgenomen tussen de voornamen en het voorvoegsel met de omschrijving horend bij de waarde in tabel 38 en geschreven in kleine letters

  Abstract Scenario: volledige naam van persoon met adellijke titel
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde                |
    | burgerservicenummer | <burgerservicenummer> |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                                 | waarde                    |
    | voornamen (02.10)                    | <voornamen>               |
    | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat> |
    | voorvoegsel (02.30)                  | <voorvoegsel>             |
    | geslachtsnaam (02.40)                | <geslachtsnaam>           |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | <burgerservicenummer>           |
    | fields              | naam.volledigeNaam              |
    Dan heeft de persoon met burgerservicenummer '<burgerservicenummer>' de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | burgerservicenummer | voornamen   | adellijkeTitelPredicaat | voorvoegsel | geslachtsnaam | volledigeNaam                |
    | 999993951           | Carolina    | BS                      | Van         | Naersen       | Carolina barones Van Naersen |
    | 999990160           | Hendrik Jan | R                       | de          | Brink         | Hendrik Jan ridder de Brink  |
