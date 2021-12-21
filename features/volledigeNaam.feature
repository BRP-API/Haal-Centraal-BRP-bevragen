# language: nl

Functionaliteit: volledige naam

Rule: de volledige naam wordt samengesteld door achter elkaar plaatsen van voornamen, voorvoegsels en geslachtsnaam

    Abstract Scenario: volledige naam van persoon
        Gegeven de persoon met burgerservicenummer "{burgerservicenummer}" heeft de volgende gegevens:
        | voornamen (02.10)                    | {voornamen}               |
        | adellijke titel of predikaat (02.20) | {adellijkeTitelPredikaat} |
        | voorvoegsel (02.30)                  | {voorvoegsel}             |
        | geslachtsnaam (02.40)                | {geslachtsnaam}           |
        Als persoon met burgerservicenummer "{burgerservicenummer}" wordt opgevraagd met fields=naam.volledigeNaam
        Dan is in het antwoord naam.volledigeNaam gelijk aan "{volledigeNaam}"

        Voorbeelden:
        | burgerservicenummer | voornamen            | adellijkeTitelPredikaat | voorvoegsel | geslachtsnaam | volledigeNaam                               |
        | 999995078           | Christina Maria      |                         |             | Maassen       | Christina Maria Maassen                     |
        | 999994542           | Gerrit               |                         | den         | Braber        | Gerrit den Braber                           |
        | 999994074           |                      |                         |             | Obbadah       | Obbadah                                     |


    Abstract Scenario: volledige naam van ouder
        Gegeven de persoon met burgerservicenummer "{burgerservicenummer}" heeft de volgende gegevens van ouder 1:
        | voornamen (02.10)                    | {voornamen}               |
        | adellijke titel of predikaat (02.20) | {adellijkeTitelPredikaat} |
        | voorvoegsel (02.30)                  | {voorvoegsel}             |
        | geslachtsnaam (02.40)                | {geslachtsnaam}           |
        Als persoon met burgerservicenummer "{burgerservicenummer}" wordt opgevraagd met fields=ouders.naam.volledigeNaam
        Dan is in het antwoord in de ouder met ouderAanduiding gelijk aan "ouder1" de naam.volledigeNaam gelijk aan "{volledigeNaam}"

        Voorbeelden:
        | burgerservicenummer | voornamen     | adellijkeTitelPredikaat | voorvoegsel | geslachtsnaam | volledigeNaam          |
        | 999991711           | Barbara       |                         |               | Bultenaar   | Barbara Bultenaar      |
        | 999995078           | Karin Monique |                         | du            | Burck       | Karin Monique du Burck |
        | 999992077           |               |                         |               |             |                        |

Rule: een predikaat wordt opgenomen voor de voornamen met de omschrijving horend bij de waarde in tabel 38 en geschreven in kleine letters

    Abstract Scenario: volledige naam van persoon met adellijke titel of predikaat
        Gegeven de persoon met burgerservicenummer "{burgerservicenummer}" heeft de volgende gegevens:
        | voornamen (02.10)                    | {voornamen}               |
        | adellijke titel of predikaat (02.20) | {adellijkeTitelPredikaat} |
        | voorvoegsel (02.30)                  | {voorvoegsel}             |
        | geslachtsnaam (02.40)                | {geslachtsnaam}           |
        Als persoon met burgerservicenummer "{burgerservicenummer}" wordt opgevraagd met fields=naam.volledigeNaam
        Dan is in het antwoord naam.volledigeNaam gelijk aan "{volledigeNaam}"

        Voorbeelden:
        | burgerservicenummer | voornamen            | adellijkeTitelPredikaat | voorvoegsel | geslachtsnaam | volledigeNaam                               |
        | 999994669           | Żáïŀëñøŕ Åłéèç Đëļŧå | JV                      | 'S          | Streeveld     | jonkvrouw Żáïŀëñøŕ Åłéèç Đëļŧå 'S Streeveld |

Rule: een adellijke titel wordt opgenomen tussen de voornamen en het voorvoegsel met de omschrijving horend bij de waarde in tabel 38 en geschreven in kleine letters

    Abstract Scenario: volledige naam van persoon met adellijke titel of predikaat
        Gegeven de persoon met burgerservicenummer "{burgerservicenummer}" heeft de volgende gegevens:
        | voornamen (02.10)                    | {voornamen}               |
        | adellijke titel of predikaat (02.20) | {adellijkeTitelPredikaat} |
        | voorvoegsel (02.30)                  | {voorvoegsel}             |
        | geslachtsnaam (02.40)                | {geslachtsnaam}           |
        Als persoon met burgerservicenummer "{burgerservicenummer}" wordt opgevraagd met fields=naam.volledigeNaam
        Dan is in het antwoord naam.volledigeNaam gelijk aan "{volledigeNaam}"

        Voorbeelden:
        | burgerservicenummer | voornamen            | adellijkeTitelPredikaat | voorvoegsel | geslachtsnaam | volledigeNaam                |
        | 999993951           | Carolina             | BS                      | Van         | Naersen       | Carolina barones Van Naersen |
        | 999990160           | Hendrik Jan          | R                       | de          | Brink         | Hendrik Jan ridder de Brink  |