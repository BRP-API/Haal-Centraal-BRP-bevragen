#language: nl

@gba
Functionaliteit: persoon: in onderzoek leveren bij vragen om gegevens van nationaliteit

    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 010000                          | 20230101                       |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 222222222                   | 020000                          | 20230102                       |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0052                  | 040000                          | 20230104                       |
      En de persoon heeft een 'partner' met de volgende gegevens
      | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 555555555                   | 050000                          | 20230105                       |
      En de persoon heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 20020701                 | 060000                          | 20230106                       |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0000                          | 080000                          | 20230108                       |
      En de persoon heeft een 'kind' met de volgende gegevens
      | burgerservicenummer (01.20) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 999999999                   | 090000                          | 20230109                       |
      En de persoon heeft de volgende 'verblijfstitel' gegevens
      | aanduiding verblijfstitel (39.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 37                                | 100000                          | 20230110                       |
      En de persoon heeft de volgende 'gezagsverhouding' gegevens
      | indicatie curateleregister (33.10) | indicatie gezag minderjarige (32.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1                                  | 12                                   | 110000                          | 20230111                       |

  Regel: onderzoek wordt geleverd wanneer ten minste één gegeven uit die categorie is gevraagd

    Abstract Scenario: meerdere categorieën in onderzoek en <fields> uit categorie Nationaliteit wordt gevraagd  
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | nationaliteiten.<fields>        |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                                      | waarde    |
      | nationaliteit.code                        | 0052      |
      | nationaliteit.omschrijving                | Belgische |
      | inOnderzoek.aanduidingGegevensInOnderzoek | 040000    |
      | inOnderzoek.datumIngangOnderzoek          | 20230104  |

      Voorbeelden:
      | fields                            |
      | redenOpname                       |
      | redenOpname.code                  |
      | redenOpname.omschrijving          |
      | type                              |
      | datumIngangGeldigheid             |
      | datumIngangGeldigheid.langFormaat |
      | datumIngangGeldigheid.type        |
      | datumIngangGeldigheid.datum       |
      | datumIngangGeldigheid.onbekend    |
      | datumIngangGeldigheid.jaar        |
      | datumIngangGeldigheid.maand       |
      | nationaliteit.code                |
      | nationaliteit.omschrijving        |
