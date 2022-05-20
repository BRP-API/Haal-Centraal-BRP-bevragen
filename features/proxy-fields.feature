# language: nl

@proxy
Functionaliteit: vertalen van gevraagde samengestelde of afgeleide velden naar vragen van bron velden
  De proxy stelt sommige velden samen uit een of meerdere andere velden. Hiervoor moet de fields in het request worden vertaald van het doelveld naar de verschillende bronvelden.

  Rule: wanneer in het request een afgeleid of samengesteld veld wordt gevraagd, moet deze in het request naar de RvIG API worden vervangen door de velden waaruit deze wordt samengesteld

    @proxy
    Abstract Scenario: met fields is gevraagd om afgeleid gegeven <gevraagd aan proxy>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <gevraagd aan proxy>            |
      Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <vragen aan RvIG>               |

      Voorbeelden:
      | gevraagd aan proxy                 | vragen aan RvIG                                                                                          |
      | naam.voorletters                   | naam.voornamen                                                                                           |
      | volledigeNaam                      | naam                                                                                                     |
      | aanhef                             | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | aanschrijfwijze.naam               | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | aanschrijfwijze.aanspreekvorm      | naam.adellijkeTitelPredicaat,aanduidingNaamgebruik,geslacht                                              |
      | gebruikInLopendeTekst              | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | leeftijd                           | geboorte.datum                                                                                           |
      | indicatieOverleden                 | overlijden.datum                                                                                         |
      | datumVan                           | datumAanvangAdreshouding,datumAanvangAdresBuitenland                                                     |
      | vanuitVerblijfplaatsOnbekend       | landVanwaarIngeschreven                                                                                  |
      | indicatieVestigingVanuitBuitenland | datumVestigingInNederland                                                                                |
      #| adressering.adresregel1            | verblijfadres                                                                                                       |
      #| adressering.adresregel2            | verblijfadres,gemeenteVanInschrijving                                                                               |
      #| adressering.adresregel3            | verblijfadres                                                                                                       |
      #| adressering.land                   | verblijfadres                                                                                                       |

    @proxy
    Abstract Scenario: met fields is gevraagd om meerdere afgeleide en/of andere gegevens <gevraagd aan proxy>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <gevraagd aan proxy>            |
      Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <vragen aan RvIG>               |

      Voorbeelden:
      | gevraagd aan proxy                         | vragen aan RvIG                         |
      | naam.voorletters,leeftijd                  | naam.voornamen,geboorte.datum           |
      | burgerservicenummer,leeftijd,volledigeNaam | burgerservicenummer,geboorte.datum,naam |

    @proxy
    Abstract Scenario: met fields is gevraagd om meerdere afgeleide en andere gegevens met overlap <gevraagd aan proxy>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <gevraagd aan proxy>            |
      Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <vragen aan RvIG>               |

      Voorbeelden:
      | gevraagd aan proxy                                                              | vragen aan RvIG                                                                                          |
      | aanhef,aanschrijfwijze.naam                                                     | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | naam.volledigeNaam,naam.voorletters                                             | naam                                                                                                     |
      | aanhef,aanschrijfwijze.naam,aanschrijfwijze.aanspreekvorm,gebruikInLopendeTekst | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | datumVestigingInNederland,indicatieVestigingVanuitBuitenland                    | datumVestigingInNederland                                                                                |
      | nationaliteiten.type,nationaliteiten.nationaliteit                              | nationaliteit,aanduidingBijzonderNederlanderschap                                                        |
      | leeftijd,geboorte.datum                                                         | geboorte.datum                                                                                           |

    @proxy
    Abstract Scenario: met fields is groep <gevraagd aan proxy> gevraagd met daarin afgeleide gegevens
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <gevraagd aan proxy>            |
      Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <vragen aan RvIG>               |

      Voorbeelden:
      | gevraagd aan proxy | vragen aan RvIG                                                                                          |
      | aanschrijfwijze    | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | naam               | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |

    @proxy
    Abstract Scenario: met fields afgeleid gegeven vragen met of zonder pad <gevraagd aan proxy>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <gevraagd aan proxy>            |
      Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <vragen aan RvIG>               |

      Voorbeelden:
      | gevraagd aan proxy            | vragen aan RvIG                                                                                          |
      | overlijden.indicatieOverleden | overlijden.datum                                                                                         |
      | indicatieOverleden            | overlijden.datum                                                                                         |
      | volledigeNaam                 | naam                                                                                                     |
      | naam.volledigeNaam            | naam                                                                                                     |
      | naam.aanschrijfwijze.naam     | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | aanschrijfwijze.naam          | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | naam.aanschrijfwijze          | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | aanschrijfwijze               | naam,geslacht,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |

  @proxy
  Rule: wanneer een gegeven van een ouder, kind of partner wordt gevraagd, moet de hele ouder, partner of kind worden gevraagd
    # dit is nodig om het type te bepalen (Ouder, OuderOnbekend, Partner, PartnerOnbekend, Kind, KindOnbekend)
    # voor de partner is dit ook nodig voor ontbindingHuwelijkPartnerschap

    @proxy
    Abstract Scenario: vragen om <gevraagd aan proxy> moet het hele object vragen
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <gevraagd aan proxy>            |
      Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <vragen aan RvIG>               |

      Voorbeelden:
      | gevraagd aan proxy                                                    | vragen aan RvIG              |
      | ouders.geslacht                                                       | ouders                       |
      | ouders.naam.voornamen                                                 | ouders                       |
      | datumIngangFamilierechtelijkeBetrekking                               | ouders                       |
      | burgerservicenummer,kinderen.geboorte.datum,kinderen.naam.voornamen   | burgerservicenummer,kinderen |
      | datumIngangFamilierechtelijkeBetrekking.datum,kinderen.geboorte.datum | ouders,kinderen              |
      | ouders.naam                                                           | ouders                       |
      | kinderen.naam.voorletters                                             | kinderen                     |
      | ouders.indicatieOnbekend                                              | ouders                       |
      | ouders.type                                                           | ouders                       |
      | kinderen                                                              | kinderen                     |

  # @proxy
  # Rule: wanneer een gegeven van verblijfadres wordt gevraagd, moet het hele verblijfadres worden gevraagd
  #   # dit is nodig om het type verblijfplaats te bepalen (Adres, Locatie, VerblijfplaatsBuitenland, VerblijfplaatsOnbekend)

  #   Abstract Scenario: vragen om <gevraagd aan proxy> moet het hele verblijfadres vragen
  #     Als personen wordt gezocht met de volgende parameters
  #     | naam                | waarde                          |
  #     | type                | RaadpleegMetBurgerservicenummer |
  #     | burgerservicenummer | 999992934                       |
  #     | fields              | <gevraagd aan proxy>            |
  #     Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
  #     | naam                | waarde                          |
  #     | type                | RaadpleegMetBurgerservicenummer |
  #     | burgerservicenummer | 999992934                       |
  #     | fields              | <vragen aan RvIG>               |

  #     Voorbeelden:
  #     | gevraagd aan proxy                                  | vragen aan RvIG                        |
  #     | korteNaam                                           | verblijfadres                          |
  #     | straat                                              | verblijfadres                          |
  #     | huisnummer                                          | verblijfadres                          |
  #     | huisletter                                          | verblijfadres                          |
  #     | huisnummertoevoeging                                | verblijfadres                          |
  #     | aanduidingBijHuisnummer                             | verblijfadres                          |
  #     | postcode                                            | verblijfadres                          |
  #     | woonplaats                                          | verblijfadres,gemeenteVanInschrijving  |
  #     | adresseerbaarObjectIdentificatie                    | verblijfadres                          |
  #     | nummeraanduidingIdentificatie                       | verblijfadres                          |
  #     | locatiebeschrijving                                 | verblijfadres                          |
  #     | verblijfadres.land                                  | verblijfadres                          |
  #     | verblijfplaatsOnbekend                              | verblijfadres                          |
  #     | verblijfadres.adresregel1                           | verblijfadres                          |
  #     | verblijfadres.adresregel2                           | verblijfadres                          |
  #     | verblijfadres.adresregel3                           | verblijfadres                          |
  #     | verblijfadres.adresregel1,woonplaats                | verblijfadres,gemeenteVanInschrijving  |
  #     | verblijfadres.adresregel1,verblijfadres.adresregel2 | verblijfadres                          |
  #     | korteNaam,huisnummer,aanduidingBijHuisnummer        | verblijfadres                          |
  #     | verblijfadres                                       | verblijfadres,gemeenteVanInschrijving  |
  #     | verblijfplaats                                      | verblijfplaats,gemeenteVanInschrijving |

    # Abstract Scenario: zoeken van personen en vragen om <gevraagd aan proxy> moet hele verblijfadres vragen
    #   Als personen wordt gezocht met de volgende parameters
    #   | naam          | waarde                              |
    #   | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    #   | geslachtsnaam | Vries                               |
    #   | geboortedatum | 1975-07-30                          |
    #   | fields        | <gevraagd aan proxy>                |
    #   Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
    #   | naam          | waarde                              |
    #   | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    #   | geslachtsnaam | Vries                               |
    #   | geboortedatum | 1975-07-30                          |
    #   | fields        | <vragen aan RvIG>                   |

    #   Voorbeelden:
    #   | gevraagd aan proxy                   | vragen aan RvIG                                                     |
    #   | volledigeNaam,adresregel1,woonplaats | naam,verblijfadres,gemeenteVanInschrijving                          |
    #   | adressering                          | verblijfadres,gemeenteVanInschrijving                               |
    #   | voorletters,leeftijd,woonplaats      | naam.voornamen,geboorte.datum,verblijfadres,gemeenteVanInschrijving |

  Rule: wanneer een gegeven van nationaliteiten wordt gevraagd, moeten ook nationaliteit en aanduidingBijzonderNederlanderschap worden gevraagd

    Abstract Scenario: vragen om nationaliteitgegeven <gevraagd aan proxy>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <gevraagd aan proxy>            |
      Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992934                       |
      | fields              | <vragen aan RvIG>               |

      Voorbeelden:
      | gevraagd aan proxy                                | vragen aan RvIG                                                                                     |
      | nationaliteit                                     | nationaliteit,aanduidingBijzonderNederlanderschap                                                   |
      | nationaliteiten.redenOpname                       | nationaliteiten.redenOpname,nationaliteit,aanduidingBijzonderNederlanderschap                       |
      | redenOpname                                       | redenOpname,nationaliteit,aanduidingBijzonderNederlanderschap                                       |
      | nationaliteiten.datumIngangGeldigheid             | nationaliteiten.datumIngangGeldigheid,nationaliteit,aanduidingBijzonderNederlanderschap             |
      | redenOpname,nationaliteiten.datumIngangGeldigheid | redenOpname,nationaliteiten.datumIngangGeldigheid,nationaliteit,aanduidingBijzonderNederlanderschap |
      | nationaliteiten.type                              | nationaliteit,aanduidingBijzonderNederlanderschap                                                   |
      | nationaliteiten                                   | nationaliteiten                                                                                     |
