#language: nl

@gba
Functionaliteit: persoon: in onderzoek leveren bij vragen om gegevens van partner

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

    Abstract Scenario: meerdere categorieën in onderzoek en <fields> uit categorie Partner wordt gevraagd
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | partners.<fields>               |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                                      | waarde   |
      | <fields>                                  | <waarde> |
      | inOnderzoek.aanduidingGegevensInOnderzoek | 050000   |
      | inOnderzoek.datumIngangOnderzoek          | 20230105 |

      Voorbeelden:
      | fields                                           | waarde    |
      | aangaanHuwelijkPartnerschap                      |           |
      | aangaanHuwelijkPartnerschap.datum                |           |
      | aangaanHuwelijkPartnerschap.datum.langFormaat    |           |
      | aangaanHuwelijkPartnerschap.datum.type           |           |
      | aangaanHuwelijkPartnerschap.datum.datum          |           |
      | aangaanHuwelijkPartnerschap.datum.onbekend       |           |
      | aangaanHuwelijkPartnerschap.datum.jaar           |           |
      | aangaanHuwelijkPartnerschap.datum.maand          |           |
      | aangaanHuwelijkPartnerschap.land                 |           |
      | aangaanHuwelijkPartnerschap.land.code            |           |
      | aangaanHuwelijkPartnerschap.land.omschrijving    |           |
      | aangaanHuwelijkPartnerschap.plaats               |           |
      | aangaanHuwelijkPartnerschap.plaats.code          |           |
      | aangaanHuwelijkPartnerschap.plaats.omschrijving  |           |
      | burgerservicenummer                              | 555555555 |
      | geboorte                                         |           |
      | geboorte.datum                                   |           |
      | geboorte.datum.langFormaat                       |           |
      | geboorte.datum.type                              |           |
      | geboorte.datum.datum                             |           |
      | geboorte.datum.onbekend                          |           |
      | geboorte.datum.jaar                              |           |
      | geboorte.datum.maand                             |           |
      | geboorte.land                                    |           |
      | geboorte.land.code                               |           |
      | geboorte.land.omschrijving                       |           |
      | geboorte.plaats                                  |           |
      | geboorte.plaats.code                             |           |
      | geboorte.plaats.omschrijving                     |           |
      | geslacht                                         |           |
      | geslacht.code                                    |           |
      | geslacht.omschrijving                            |           |
      | naam.adellijkeTitelPredicaat                     |           |
      | naam.adellijkeTitelPredicaat.code                |           |
      | naam.adellijkeTitelPredicaat.omschrijving        |           |
      | naam.adellijkeTitelPredicaat.soort               |           |
      | naam.geslachtsnaam                               |           |
      | naam.voorletters                                 |           |
      | naam.voornamen                                   |           |
      | naam.voorvoegsel                                 |           |
      | ontbindingHuwelijkPartnerschap                   |           |
      | ontbindingHuwelijkPartnerschap.datum             |           |
      | ontbindingHuwelijkPartnerschap.datum.langFormaat |           |
      | ontbindingHuwelijkPartnerschap.datum.type        |           |
      | ontbindingHuwelijkPartnerschap.datum.datum       |           |
      | ontbindingHuwelijkPartnerschap.datum.onbekend    |           |
      | ontbindingHuwelijkPartnerschap.datum.jaar        |           |
      | ontbindingHuwelijkPartnerschap.datum.maand       |           |
      | soortVerbintenis                                 |           |
      | soortVerbintenis.code                            |           |
      | soortVerbintenis.omschrijving                    |           |
