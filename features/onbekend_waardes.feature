# language: nl

Functionaliteit: Als gebruiker van de API wil ik geen onbekend waardes ontvangen
  zodat ik deze niet hoef te (kunnen) interpreteren en ik geen code voor hoef te schrijven om deze situatie af te vangen

  Wanneer in de registratie specifieke waarden gereserveerd zijn voor ee onbekende waarde, worden deze waarden niet doorgegeven in de API.
  Wanneer een element in de registratie een onbekendwaarde heeft, wordt het corresponderende attribbuut niet opgenomen in de response.
  Wanneer op basis van een elementwaarde een link naar een andere resource wordt opgebouwd, wordt in geval van een onbekendwaarde de link niet opgenomen in de response.

  Uitzondering is geslachtsaanduiding waarde "O" (onbekend), deze wordt doorgegeven in de API.

  Voor onbekend waardes voor datumvelden, zie feature onvolledige_datum.feature.

  Het gaat om de volgende properties en onbekend waardes van de persoon:
    | property                                         | onbekend waarde  |
    | ------------------------------------------------ | ---------------- |
    | naam.geslachtsnaam                               | .                |
    | geboorte.plaats                                  | 0000             |
    | geboorte.land                                    | 0000             |
    | overlijden.plaats                                | 0000             |
    | overlijden.land                                  | 0000             |
    | nationaliteit.nationaliteit                      | 0000             |
    | nationaliteit.redenOpname                        | 000              |
    | verblijfplaats.gemeenteVanInschrijving           | 0000             |
    | verblijfplaats.straatnaam                        | .                |
    | verblijfplaats.huisnummer                        | 0                |
    | verblijfplaats.woonplaatsnaam                    | .                |
    | verblijfplaats.identificatiecodeNummeraanduiding | 0000000000000000 |
    | verblijfplaats.identificatiecodeVerblijfplaats   | 0000000000000000 |
    | verblijfplaats.verblijfBuitenland.land           | 0000             |
    | verblijfplaats.landVanwaarIngeschreven           | 0000             |
    | verblijfstitel.aanduiding                        | 00               |

  Het gaat om de volgende properties en onbekend waardes van de ouder:
    | property                                         | onbekend waarde  |
    | ------------------------------------------------ | ---------------- |
    | naam.geslachtsnaam                               | .                |
    | geboorte.plaats                                  | 0000             |
    | geboorte.land                                    | 0000             |

  Het gaat om de volgende properties en onbekend waardes van de partner:
    | property                                         | onbekend waarde  |
    | ------------------------------------------------ | ---------------- |
    | naam.geslachtsnaam                               | .                |
    | geboorte.plaats                                  | 0000             |
    | geboorte.land                                    | 0000             |
    | soortVerbintenis                                 | .                |
    | aangaanHuwelijk_Partnerschap.plaats              | 0000             |
    | aangaanHuwelijk_Partnerschap.land                | 0000             |

  Het gaat om de volgende properties en onbekend waardes van het kind:
    | property                                         | onbekend waarde  |
    | ------------------------------------------------ | ---------------- |
    | naam.geslachtsnaam                               | .                |
    | geboorte.plaats                                  | 0000             |
    | geboorte.land                                    | 0000             |


  Het gaat om de volgende properties en onbekend waardes van het reisdocument:
    | property                                         | onbekend waarde  |
    | ------------------------------------------------ | ---------------- |
    | reisdocumentnummer                               | .........        |
    | soortReisdocument                                | ..
    | autoriteitAfgifte                                | ..               |
    | aanduidingInhoudingOfVermissing                  | .                |

  Een aantal onbekendwaardes worden vertaald naar indicatoren die de betekenis van de onbekendwaarde, dan wel de betekenis van de aanwezigheid van een waarde.
  - verblijfplaats.indicatieVestigingVanuitBuitenland krijgt de waarde true wanneer verblijfplaats.datumVestigingInNederland een waarde heeft (incl. 00000000)
  - verblijfplaats.vanuitVertrokkenOnbekendWaarheen krijgt de waarde true wanneer verblijfplaats.landVanwaarIngeschreven = 0000
  - verblijfplaats.verblijfBuitenland.vertrokkenOnbekendWaarheen krijgt de waarde true wanneer verblijfplaats.verblijfBuitenland.land = 0000.
  - overlijden.indicatieOverleden: zie feature onvolledige_datum.feature


  Scenario: een onbekendwaarde wordt niet opgenomen in de response
    Gegeven in de registratie heeft de straatnaam van de verblijfplaats de waarde "."
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.straatnaam niet aanwezig

    Gegeven de geboorteplaats van de ouder is niet bekend
    Als de ouder wordt geraadpleegd
    Dan is in het antwoord geboorte.plaats niet aanwezig

  Scenario: een onbekendwaarde bij geslachtsaanduiding wordt wel opgenomen in de response
    Gegeven in de registratie heeft de geslachtsaanduiding de waarde "O" (onbekend)
    Als de persoon wordt geraadpleegd
    Dan heeft attribuut geslachtsaanduiding de waarde "Onbekend"

  Scenario: er wordt geen link gemaakt op basis van een onbekendwaarde
    Gegeven de persoon heeft een reisdocument met reisdocumentnummer "........."
    En de persoon heeft geen ander actueel reisdocument
    Als de persoon wordt geraadpleegd
    Dan is in het antwoord _links.reisdocumenten niet aanwezig

  Scenario: vullen van indicatieVestigingVanuitBuitenland
    Gegeven de registratie persoon 999990317 kent een verblijfplaats.datumVestigingInNederland = 19900808
    Als de persoon met burgerservicenummer 999990317 wordt geraadpleegd
    Dan heeft in het antwoord verblijfplaats.datumVestigingInNederland.datum de waarde 1990-08-08
    En heeft attribuut verblijfplaats.indicatieVestigingVanuitBuitenland de waarde true

    Gegeven de registratie persoon kent een verblijfplaats.datumVestigingInNederland = 00000000
    Als de persoon wordt geraadpleegd
    Dan heeft attribuut verblijfplaats.indicatieVestigingVanuitBuitenland de waarde true
    En is in het antwoord verblijfplaats.datumVestigingInNederland niet aanwezig

    Gegeven de registratie persoon 999993653 kent geen verblijfplaats.datumVestigingInNederland
    Als de persoon met burgerservicenummer 999993653 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.datumVestigingInNederland niet aanwezig
    En is in het antwoord verblijfplaats.indicatieVestigingVanuitBuitenland niet aanwezig

  Scenario: vullen van vanuitVertrokkenOnbekendWaarheen
    Gegeven de registratie persoon 999995121 kent een verblijfplaats.landVanwaarIngeschreven = 0000
    Als de persoon met burgerservicenummer 999995121 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.landVanwaarIngeschreven niet aanwezig
    En heeft attribuut verblijfplaats.vanuitVertrokkenOnbekendWaarheen de waarde true

    Gegeven de registratie persoon 999990317 kent een verblijfplaats.landVanwaarIngeschreven = 7046
    Als de persoon met burgerservicenummer 999990317 wordt geraadpleegd
    Dan heeft attribuut verblijfplaats.landVanwaarIngeschreven.code de waarde 7046
    En is in het antwoord verblijfplaats.vanuitVertrokkenOnbekendWaarheen niet aanwezig

    Gegeven de registratie persoon 999993653 kent geen verblijfplaats.landVanwaarIngeschreven
    Als de persoon met burgerservicenummer 999993653 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.landVanwaarIngeschreven niet aanwezig
    En is in het antwoord verblijfplaats.vanuitVertrokkenOnbekendWaarheen niet aanwezig

  Scenario: vullen van vertrokkenOnbekendWaarheen
    Gegeven de registratie persoon 999993586 kent een verblijfplaats.verblijfBuitenland.land = 0000
    Als de persoon met burgerservicenummer 999993586 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.verblijfBuitenland.land niet aanwezig
    En heeft attribuut verblijfplaats.verblijfBuitenland.vertrokkenOnbekendWaarheen de waarde true

    Gegeven de registratie persoon 999992326 kent een verblijfplaats.verblijfBuitenland.land = 6003
    Als de persoon met burgerservicenummer 999992326 wordt geraadpleegd
    Dan heeft attribuut verblijfplaats.verblijfBuitenland.land.code de waarde 6003
    En is in het antwoord verblijfplaats.verblijfBuitenland.vertrokkenOnbekendWaarheen niet aanwezig

    Gegeven de registratie persoon 999993653 is in een Nederlandse gemeente
    Als de persoon met burgerservicenummer 999993653 wordt geraadpleegd
    Dan is in het antwoord verblijfplaats.verblijfBuitenland niet aanwezig
