#language: nl

Functionaliteit: volledige naam bepaling

@info-api
Regel: de volledige naam wordt samengesteld door het achter elkaar plaatsen van voornamen, voorvoegsels en geslachtsnaam.

@info-api
Abstract Scenario: gevraagde persoon heeft <scenario>
  Gegeven de persoon met de volgende gegevens
  | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
  | <voornamen>       | <voorvoegsel>       | <geslachtsnaam>       |
  Als het 'naam.volledigeNaam' veld van de persoon wordt gevraagd
  Dan heeft de response een persoon
  * met de 'naam' veld
  | volledigeNaam    |
  | <volledige naam> |

  Voorbeelden:
  | scenario                                | voornamen                              | voorvoegsel | geslachtsnaam                     | volledige naam                                                                  |
  | geen voorvoegsel                        | Christina Maria                        |             | Maassen                           | Christina Maria Maassen                                                         |
  | voorvoegsel                             | Gerrit                                 | den         | Braber                            | Gerrit den Braber                                                               |
  | voorvoegsel met hoofdletter             | Mohamed                                | El          | Rafi                              | Mohamed El Rafi                                                                 |
  | een punt karakter in zijn geslachtsnaam | Lisanty Teresita del niño Jesús Virgen | De las      | do Livramento de La Salete Jansz. | Lisanty Teresita del niño Jesús Virgen De las do Livramento de La Salete Jansz. |
  | naamketen                               |                                        |             | Obbadah                           | Obbadah                                                                         |

@info-api
Regel: een geslachtsnaam met standaard waarde (.) wordt niet meegenomen in het samenstellen van de volledige naam

@info-api
Scenario: gevraagde persoon heeft een geslachtsnaam met standaard waarde
  Gegeven de persoon met de volgende gegevens
  | voornamen (02.10) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
  | Dian Marini Maya  |                     | .                     |
  Als het 'naam.volledigeNaam' veld van de persoon wordt gevraagd
  Dan heeft de response een persoon
  * met de 'naam' veld
  | volledigeNaam    |
  | Dian Marini Maya |

@data-api
Regel: voor de volledige naam bepaling moet de data-api de velden geslacht, voornamen, adellijkeTitelPredicaat, voorvoegsel en geslachtsnaam leveren

@data-api
Scenario: gevraagde persoon heeft alle benodigde velden voor het samenstellen van zijn volledige naam
Gegeven de persoon met de volgende gegevens
| geslachtsaanduiding (04.10) | voornamen (02.10) | adellijke titel of predicaat (02.20) | voorvoegsel (02.30) | geslachtsnaam (02.40) |
| V                           | Carolina          | BS                                   | Van                 | Naersen               |
Als het 'naam.volledigeNaam' veld van de persoon wordt gevraagd
Dan heeft de response een persoon
* met 'geslacht' velden
  | code | omschrijving |
  | V    | vrouw        |
* met 'naam' velden
  | voornamen | voorvoegsel | geslachtsnaam |
  | Carolina  | Van         | Naersen       |
* met 'naam.adellijkeTitelPredicaat' velden
  | code | soort | omschrijving |
  | BS   | titel | barones      |
