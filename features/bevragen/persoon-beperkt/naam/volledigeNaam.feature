# language: nl

Functionaliteit: volledige naam (persoon beperkt)

Regel: de volledige naam wordt samengesteld door achter elkaar plaatsen van voornamen, voorvoegsels en geslachtsnaam
  - standaardwaarde "." voor geslachtsnaam wordt niet opgenomen in volledigeNaam
  - wanneer de volledigeNaam geen inhoud heeft, gelijk is aan "", dan wordt volledigeNaam niet opgenomen

  Abstract Scenario: volledige naam van persoon <omschrijving>
    Gegeven de persoon met burgerservicenummer '000000395' heeft de volgende gegevens
    | naam                                 | waarde          |
    | voornamen (02.10)                    | <voornamen>     |
    | adellijke titel of predikaat (02.20) |                 |
    | voorvoegsel (02.30)                  | <voorvoegsel>   |
    | geslachtsnaam (02.40)                | <geslachtsnaam> |
    | geboortedatum (03.10)                | 19830526        |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.volledigeNaam                  |
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | voornamen                              | voorvoegsel | geslachtsnaam                     | volledigeNaam                                                                   | omschrijving                        |
    | Christina Maria                        |             | Maassen                           | Christina Maria Maassen                                                         | zonder voorvoegsel                  |
    | Gerrit                                 | den         | Braber                            | Gerrit den Braber                                                               | met voorvoegsel                     |
    |                                        |             | Obbadah                           | Obbadah                                                                         | naamketen                           |
    | Mohamed                                | El          | Rafi                              | Mohamed El Rafi                                                                 | voorvoegsel met hoofdletter         |
    | Dian Marini Maya                       |             | .                                 | Dian Marini Maya                                                                | geslachtsnaam heeft standaardwaarde |
    | Lisanty Teresita del niño Jesús Virgen | De las      | do Livramento de La Salete Jansz. | Lisanty Teresita del niño Jesús Virgen De las do Livramento de La Salete Jansz. | geslachtsnaam met punt              |
  
  Scenario: volledig onbekende naam
    Gegeven de persoon met burgerservicenummer '000000450' heeft de volgende gegevens
    | naam                                 | waarde   |
    | voornamen (02.10)                    |          |
    | adellijke titel of predikaat (02.20) |          |
    | voorvoegsel (02.30)                  |          |
    | geslachtsnaam (02.40)                | .        |
    | geboortedatum (03.10)                | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                 |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum    |
    | geslachtsnaam | .                                      |
    | geboortedatum | 1983-05-26                             |
    | fields        | burgerservicenummer,naam.volledigeNaam |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000450 |
    En heeft de persoon een leeg 'naam' object

Regel: een predicaat wordt opgenomen voor de voornamen met de omschrijving horend bij de waarde in tabel 38 in de vorm die hoort bij het geslacht en geschreven in kleine letters
  - wanneer er geen vorm is die hoort bij het predicaat (geslacht "O"), wordt de omschrijving horend bij de waarde van de code in tabel 38 gebruikt

  Abstract Scenario: volledige naam van persoon met predikaat
    Gegeven de persoon met burgerservicenummer '000000541' heeft de volgende gegevens
    | naam                                 | waarde                    |
    | geslachtsaanduiding (04.10)          | <geslacht>                |
    | voornamen (02.10)                    | <voornamen>               |
    | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat> |
    | voorvoegsel (02.30)                  | <voorvoegsel>             |
    | geslachtsnaam (02.40)                | <geslachtsnaam>           |
    | geboortedatum (03.10)                | 19830526                  |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.volledigeNaam                  |
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | geslacht | voornamen            | adellijkeTitelPredicaat | voorvoegsel | geslachtsnaam | volledigeNaam                               |
    | V        | Żáïŀëñøŕ Åłéèç Đëļŧå | JV                      | 'S          | Streeveld     | jonkvrouw Żáïŀëñøŕ Åłéèç Đëļŧå 'S Streeveld |
    | V        | Jo Anne              | JV                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | M        | Jo Anne              | JV                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    | O        | Jo Anne              | JV                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | V        | Jo Anne              | JH                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | M        | Jo Anne              | JH                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    | O        | Jo Anne              | JH                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    

Regel: een adellijke titel wordt opgenomen tussen de voornamen en het voorvoegsel met de omschrijving horend bij de waarde in tabel 38 in de vorm die hoort bij het geslacht en geschreven in kleine letters
  - wanneer er geen vorm is die hoort bij de adellijke titel (geslacht "O" of titel "R" met geslacht "V"), wordt de omschrijving horend bij de waarde van de code in tabel 38 gebruikt

  Abstract Scenario: volledige naam van persoon met adellijke titel
    Gegeven de persoon met burgerservicenummer '000000619' heeft de volgende gegevens
    | naam                                 | waarde                    |
    | geslachtsaanduiding (04.10)          | <geslacht>                |
    | voornamen (02.10)                    | <voornamen>               |
    | adellijke titel of predicaat (02.20) | <adellijkeTitelPredicaat> |
    | voorvoegsel (02.30)                  | <voorvoegsel>             |
    | geslachtsnaam (02.40)                | <geslachtsnaam>           |
    | geboortedatum (03.10)                | 19830526                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | geboortedatum | 1983-05-26                          |
    | fields              | naam.volledigeNaam              |
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam          | waarde          |
    | volledigeNaam | <volledigeNaam> |

    Voorbeelden:
    | geslacht | voornamen   | adellijkeTitelPredicaat | voorvoegsel | geslachtsnaam | volledigeNaam                     |
    | V        | Carolina    | BS                      | Van         | Naersen       | Carolina barones Van Naersen      |
    | M        | Hendrik Jan | R                       | de          | Brink         | Hendrik Jan ridder de Brink       |
    | V        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | M        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | O        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | V        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | M        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | O        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | V        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | M        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | O        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | V        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | M        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | O        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | V        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | M        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | O        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | V        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | M        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | O        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | V        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | M        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | O        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | V        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | M        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | O        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | V        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | M        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | O        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | V        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | M        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | O        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | V        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
    | M        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
    | O        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
