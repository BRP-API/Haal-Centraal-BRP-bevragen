# language: nl

@ready @post-assert
Functionaliteit: volledige naam

Rule: de volledige naam wordt samengesteld door achter elkaar plaatsen van voornamen, voorvoegsels en geslachtsnaam
  - standaardwaarde "." voor geslachtsnaam wordt niet opgenomen in volledigeNaam
  - wanneer de volledigeNaam geen inhoud heeft, gelijk is aan "", dan wordt volledigeNaam niet opgenomen

  Abstract Scenario: volledige naam van persoon <omschrijving>
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende gegevens
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
      | burgerservicenummer | voornamen                              | voorvoegsel | geslachtsnaam                     | volledigeNaam                                                                   | omschrijving                        |
      | 000000395           | Christina Maria                        |             | Maassen                           | Christina Maria Maassen                                                         | zonder voorvoegsel                  |
      | 000000401           | Gerrit                                 | den         | Braber                            | Gerrit den Braber                                                               | met voorvoegsel                     |
      | 000000413           |                                        |             | Obbadah                           | Obbadah                                                                         | naamketen                           |
      | 000000425           | Mohamed                                | El          | Rafi                              | Mohamed El Rafi                                                                 | voorvoegsel met hoofdletter         |
      | 000000437           | Dian Marini Maya                       |             | .                                 | Dian Marini Maya                                                                | geslachtsnaam heeft standaardwaarde |
      | 000000449           | Lisanty Teresita del niño Jesús Virgen | De las      | do Livramento de La Salete Jansz. | Lisanty Teresita del niño Jesús Virgen De las do Livramento de La Salete Jansz. | geslachtsnaam met punt              |
    
  Scenario: volledig onbekende naam
    Gegeven de persoon met burgerservicenummer '000000450' heeft de volgende gegevens
    | naam                                 | waarde |
    | voornamen (02.10)                    |        |
    | adellijke titel of predikaat (02.20) |        |
    | voorvoegsel (02.30)                  |        |
    | geslachtsnaam (02.40)                | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                 |
    | type                | RaadpleegMetBurgerservicenummer        |
    | burgerservicenummer | 000000450                              |
    | fields              | burgerservicenummer,naam.volledigeNaam |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000450 |
    En heeft de persoon een leeg 'naam' object

Rule: een predicaat wordt opgenomen voor de voornamen met de omschrijving horend bij de waarde in tabel 38 in de vorm die hoort bij het geslacht en geschreven in kleine letters
  - wanneer er geen vorm is die hoort bij het predicaat (geslacht "O"), wordt de omschrijving horend bij de waarde in tabel 38 gebruikt

  Abstract Scenario: volledige naam van persoon met predikaat
    Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende gegevens
    | naam                                 | waarde                    |
    | geslachtsaanduiding (04.10)          | <geslacht>                |
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
    | 000000541           | V        | Żáïŀëñøŕ Åłéèç Đëļŧå | JV                      | 'S          | Streeveld     | jonkvrouw Żáïŀëñøŕ Åłéèç Đëļŧå 'S Streeveld |
    | 000000553           | V        | Jo Anne              | JV                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | 000000565           | M        | Jo Anne              | JV                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    | 000000577           | O        | Jo Anne              | JV                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | 000000589           | V        | Jo Anne              | JH                      | van         | Hoogh         | jonkvrouw Jo Anne van Hoogh                 |
    | 000000590           | M        | Jo Anne              | JH                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    | 000000607           | O        | Jo Anne              | JH                      | van         | Hoogh         | jonkheer Jo Anne van Hoogh                  |
    

Rule: een adellijke titel wordt opgenomen tussen de voornamen en het voorvoegsel met de omschrijving horend bij de waarde in tabel 38 in de vorm die hoort bij het geslacht en geschreven in kleine letters
  - wanneer er geen vorm is die hoort bij de adellijke titel (geslacht "O" of titel "R" met geslacht "V"), wordt de omschrijving horend bij de waarde in tabel 38 gebruikt

  Abstract Scenario: volledige naam van persoon met adellijke titel
    Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende gegevens
    | naam                        | waarde                |
    | geslachtsaanduiding (04.10) | <geslacht>            |
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
    | 000000619           | V        | Carolina    | BS                      | Van         | Naersen       | Carolina barones Van Naersen      |
    | 000000620           | M        | Hendrik Jan | R                       | de          | Brink         | Hendrik Jan ridder de Brink       |
    | 000000632           | V        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | 000000644           | M        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | 000000656           | O        | Robin Sam   | G                       | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | 000000668           | V        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | 000000681           | M        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam graaf van den Aedel     |
    | 000000693           | O        | Robin Sam   | GI                      | van  den    | Aedel         | Robin Sam gravin van den Aedel    |
    | 000000711           | V        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | 000000723           | M        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | 000000735           | O        | Robin Sam   | B                       | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | 000000747           | V        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | 000000759           | M        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam baron van den Aedel     |
    | 000000760           | O        | Robin Sam   | BS                      | van  den    | Aedel         | Robin Sam barones van den Aedel   |
    | 000000772           | V        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | 000000784           | M        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | 000000796           | O        | Robin Sam   | H                       | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | 000000802           | V        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | 000000814           | M        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertog van den Aedel    |
    | 000000826           | O        | Robin Sam   | HI                      | van  den    | Aedel         | Robin Sam hertogin van den Aedel  |
    | 000000838           | V        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | 000000851           | M        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | 000000863           | O        | Robin Sam   | M                       | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | 000000875           | V        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | 000000887           | M        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markies van den Aedel   |
    | 000000899           | O        | Robin Sam   | MI                      | van  den    | Aedel         | Robin Sam markiezin van den Aedel |
    | 000000905           | V        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | 000000917           | M        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | 000000929           | O        | Robin Sam   | P                       | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | 000000930           | V        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | 000000942           | M        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prins van den Aedel     |
    | 000000954           | O        | Robin Sam   | PS                      | van  den    | Aedel         | Robin Sam prinses van den Aedel   |
    | 000000966           | V        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
    | 000000978           | M        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
    | 000000991           | O        | Robin Sam   | R                       | van  den    | Aedel         | Robin Sam ridder van den Aedel    |
