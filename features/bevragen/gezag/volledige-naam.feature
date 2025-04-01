# language: nl
Functionaliteit: leveren van de volledige naam van de minderjarige, ouder(s) en derde(n) van een gezagsrelatie

  Achtergrond:
    Gegeven de persoon 'Saskia' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Maarten' met burgerservicenummer '000000024'
    * is meerderjarig
    En 'Saskia' en 'Maarten' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      |                                                           20100401 |
    En de persoon 'Rachel' met burgerservicenummer '000000036'
    * heeft 'Saskia' als ouder 1
    * is geboren op 1-12-2022
    * is in Nederland geboren
    * is ingeschreven in de BRP

  Regel: de volledige naam wordt samengesteld door het achter elkaar plaatsen van voornamen, voorvoegsels en geslachtsnaam

    Abstract Scenario: gezag over gevraagde persoon is gezamenlijk gezag en de minderjarige in de gezagsrelatie heeft <naam omschrijving>
      Gegeven de persoon 'Rachel' heeft de volgende gegevens
        | geslachtsaanduiding (04.10) | voornamen (02.10) | geslachtsnaam (02.40) | voorvoegsel (02.30) | adellijke titel of predicaat (02.20) |
        | <geslacht>                  | <voornamen>       | <geslachtsnaam>       | <voorvoegsel>       | <adellijke titel of predicaat>       |
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Rachel'
      Dan is het gezag over 'Rachel' gezamenlijk gezag met ouder 'Saskia' en derde 'Maarten'
      En heeft de minderjarige de volgende gegevens
        | naam.volledigeNaam |
        | <volledige naam>   |

      Voorbeelden:
        | geslacht | voornamen | geslachtsnaam | voorvoegsel | adellijke titel of predicaat | volledige naam            | naam omschrijving |
        | M        |           | Braber        |             |                              | Braber                    | een naamketen     |
        | V        | Rachel    | Braber        |             |                              | Rachel Braber             | geen voorvoegsel  |
        | O        | Rachel    | Braber        | den         |                              | Rachel den Braber         | voorvoegsel       |
        | V        | Rachel    | Braber        |             | JV                           | jonkvrouw Rachel Braber   | predicaat         |
        | V        | Rachel    | Braber        | den         | BS                           | Rachel barones den Braber | adellijke titel   |

  @gezag-api
  Regel: geslachtsaanduiding, voornamen, adellijke titel/predicaat, voorvoegsel en geslachtsnaam worden geleverd voor de minderjarige, ouder(s) en derde(n) van een gezagsrelatie
    geslacht.omschrijving, adellijkeTitelPredicaat.soort en omschrijving worden niet geleverd omdat deze niet noodzakelijk zijn voor het samenstellen van de volledige naam

    @gezag-api
    Abstract Scenario: gezag over gevraagde persoon is gezamenlijk gezag en de <houder> in de gezagsrelatie heeft <naam omschrijving>
      Gegeven de persoon '<persoon>' heeft de volgende gegevens
        | geslachtsaanduiding (04.10) | voornamen (02.10) | geslachtsnaam (02.40) | voorvoegsel (02.30) | adellijke titel of predicaat (02.20) |
        | <geslacht>                  | <voornamen>       | <geslachtsnaam>       | <voorvoegsel>       | <adellijke titel of predicaat>       |
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Rachel'
      Dan is het gezag over 'Rachel' gezamenlijk gezag met ouder 'Saskia' en derde 'Maarten'
      En heeft de <houder> de volgende gegevens
        | geslacht.code | naam.voornamen | naam.geslachtsnaam | naam.voorvoegsel | naam.adellijkeTitelPredicaat.code |
        | <geslacht>    | <voornamen>    | <geslachtsnaam>    | <voorvoegsel>    | <adellijke titel of predicaat>    |

      Voorbeelden:
        | persoon | houder       | geslacht | voornamen       | geslachtsnaam | voorvoegsel | adellijke titel of predicaat | naam omschrijving |
        | Rachel  | minderjarige | M        |                 | Braber        |             |                              | een naamketen     |
        | Saskia  | ouder        | V        | Saskia          | Maassen       |             |                              | geen voorvoegsel  |
        | Maarten | derde        | O        | Maarten         | Jager         | den         |                              | voorvoegsel       |
        | Rachel  | minderjarige | V        | Rachel          | Braber        |             | JV                           | predicaat         |
        | Saskia  | ouder        | V        | Christina Maria | Hoogh         | van         | BS                           | adellijke titel   |

  @gezag-api
  Regel: als de minderjarige, ouder(s) en derde(n) van een gezagsrelatie ook voornamen en/of geslachtsnaam met diakrieten heeft, dan wordt deze geleverd
    in dit geval zijn zowel de diakriet en niet-diakriet velden gevuld

    @gezag-api
    Scenario: gezag over gevraagde persoon is gezamenlijk gezag en de ouder en de derde in de gezagsrelatie hebben diakrieten in hun voornamen/geslachtsnaam
      Gegeven de persoon 'Saskia' heeft de volgende gegevens
        | geslachtsaanduiding (04.10) | voornamen (02.10) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) |
        | V                           | Saskia            | del nino Jesus Virgen | del niño Jesús Virgen      |
      En de persoon 'Maarten' heeft de volgende gegevens
        | geslachtsaanduiding (04.10) | voornamen (02.10) | voornamen (diakrieten) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) |
        | M                           | Ateec Delta       | Åłéèç Đëļŧå            | Zaileneur             | Żáïŀëñøŕ                   |
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Rachel'
      Dan is het gezag over 'Rachel' gezamenlijk gezag met ouder 'Saskia' en derde 'Maarten'
      En heeft de ouder de volgende gegevens
        | geslacht.code | naam.voornamen | naam.geslachtsnaam    |
        | V             | Saskia         | del niño Jesús Virgen |
      En heeft de derde de volgende gegevens
        | geslacht.code | naam.voornamen | naam.geslachtsnaam |
        | M             | Åłéèç Đëļŧå    | Żáïŀëñøŕ           |
