# language: nl

@ready @post-assert
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
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | burgerservicenummer | voornamen       | voorvoegsel | geslachtsnaam | volledigeNaam           |
    | 999995078           | Christina Maria |             | Maassen       | Christina Maria Maassen |
    | 999994542           | Gerrit          | den         | Braber        | Gerrit den Braber       |
    | 999994074           |                 |             | Obbadah       | Obbadah                 |
    | 999992703           | Mohamed         | El          | Rafi          | Mohamed El Rafi         |

Rule: een predicaat wordt opgenomen voor de voornamen met de omschrijving horend bij de waarde in tabel 38 in de vorm die hoort bij het geslacht en geschreven in kleine letters
  - wanneer er geen vorm is die hoort bij het predicaat (geslacht "O"), wordt de omschrijving horend bij de waarde in tabel 38 gebruikt

  Abstract Scenario: volledige naam van persoon met predikaat
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                        | waarde                |
    | burgerservicenummer         | <burgerservicenummer> |
    | geslachtsaanduiding (04.10) | <geslacht>            |
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
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | burgerservicenummer | geslacht | voornamen            | adellijkeTitelPredicaat | voorvoegsel | geslachtsnaam | volledigeNaam                               |
    | 999994669           | V        | Żáïŀëñøŕ Åłéèç Đëļŧå | JV                      | 'S          | Streeveld     | jonkvrouw Żáïŀëñøŕ Åłéèç Đëļŧå 'S Streeveld |
    | 555550001           | V        | Jo Anne              | JV                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | 555550002           | M        | Jo Anne              | JV                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    | 555550003           | O        | Jo Anne              | JV                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | 555550004           | V        | Jo Anne              | JH                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | 555550005           | M        | Jo Anne              | JH                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    | 555550006           | O        | Jo Anne              | JH                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    

Rule: een adellijke titel wordt opgenomen tussen de voornamen en het voorvoegsel met de omschrijving horend bij de waarde in tabel 38 in de vorm die hoort bij het geslacht en geschreven in kleine letters
  - wanneer er geen vorm is die hoort bij de adellijke titel (geslacht "O" of titel "R" met geslacht "V"), wordt de omschrijving horend bij de waarde in tabel 38 gebruikt

  Abstract Scenario: volledige naam van persoon met adellijke titel
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                        | waarde                |
    | burgerservicenummer         | <burgerservicenummer> |
    | geslachtsaanduiding (04.10) | <geslacht>            |
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
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | burgerservicenummer | geslacht | voornamen   | adellijkeTitelPredicaat | voorvoegsel | geslachtsnaam | volledigeNaam                     |
    | 999993951           | V        | Carolina    | BS                      | Van         | Naersen       | Carolina barones Van Naersen      |
    | 999990160           | M        | Hendrik Jan | R                       | de          | Brink         | Hendrik Jan ridder de Brink       |
    | 555550011           | V        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | 555550012           | M        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | 555550013           | O        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | 555550014           | V        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | 555550015           | M        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | 555550016           | O        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | 555550021           | V        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | 555550022           | M        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | 555550023           | O        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | 555550024           | V        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | 555550025           | M        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | 555550026           | O        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | 555550031           | V        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | 555550032           | M        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | 555550033           | O        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | 555550034           | V        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | 555550035           | M        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | 555550036           | O        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | 555550041           | V        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | 555550042           | M        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | 555550043           | O        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | 555550044           | V        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | 555550045           | M        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | 555550046           | O        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | 555550051           | V        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | 555550052           | M        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | 555550053           | O        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | 555550054           | V        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | 555550055           | M        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | 555550056           | O        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | 555550061           | V        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
    | 555550062           | M        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
    | 555550063           | O        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
