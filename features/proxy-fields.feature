# language: nl

@proxy
Functionaliteit: vertalen van gevraagde samengestelde of afgeleide velden naar vragen van bron velden
  De proxy stelt sommige velden samen uit een of meerdere andere velden. Hiervoor moet de fields in het request worden vertaald van het doelveld naar de verschillende bronvelden.

  Rule: wanneer in het request een afgeleid of samengesteld veld wordt gevraagd, moet deze in het request naar de RvIG API worden vervangen door de velden waaruit deze wordt samengesteld
    Het gaat om de volgende vertalingen:
      | gevraagd aan proxy                 | vragen aan RvIG                                                                                                     |
      | naam.voorletters                   | naam.voornamen                                                                                                      |
      | volledigeNaam                      | naam                                                                                                                |
      | aanhef                             | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | aanschrijfwijze.naam               | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | aanschrijfwijze.aanspreekvorm      | naam.adellijkeTitelPredicaat,aanduidingNaamgebruik,geslachtsaanduiding                                              |
      | gebruikInLopendeTekst              | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | leeftijd                           | geboorte.datum                                                                                                      |
      | ouders.naam.voorletters            | ouders.naam.voornamen                                                                                               |
      | nationaliteiten.type               | nationaliteit,aanduidingBijzonderNederlanderschap                                                                   |
      | partners.naam.voorletters          | partners.naam.voornamen                                                                                             |
      | kinderen.naam.voorletters          | kinderen.naam.voornamen                                                                                             |
      | overlijden.indicatieOverleden      | overlijden.datum                                                                                                    |
      | verblijfplaats.datumVan            | datumAanvangAdreshouding,datumAanvangAdresBuitenland                                                                |
      | korteNaam                          | straat                                                                                                              |
      | straat                             | straat,naamOpenbareRuimte                                                                                           |
      | woonplaats                         | woonplaats,gemeenteVanInschrijving                                                                                  |
      | verblijfplaatsOnbekend             | verblijfplaats.land                                                                                                 |
      | adresregel1                        | adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huisnummertoevoeging,aanduidingBijHuisnummer           |
      | adresregel2                        | adresregel2,postcode,woonplaats,gemeenteVanInschrijving                                                             |
      | vanuitVerblijfplaatsOnbekend       | landVanwaarIngeschreven                                                                                             |
      | indicatieVestigingVanuitBuitenland | datumVestigingInNederland                                                                                           |

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
      | gevraagd aan proxy            | vragen aan RvIG                                                                                                     |
      | naam.voorletters              | naam.voornamen                                                                                                      |
      | volledigeNaam                 | naam                                                                                                                |
      | aanhef                        | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | aanschrijfwijze.naam          | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | aanschrijfwijze.aanspreekvorm | naam.adellijkeTitelPredicaat,aanduidingNaamgebruik,geslachtsaanduiding                                              |
      | gebruikInLopendeTekst         | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | leeftijd                      | geboorte.datum                                                                                                      |
      | nationaliteiten.type          | nationaliteit,aanduidingBijzonderNederlanderschap                                                                   |
      | overlijden.indicatieOverleden | overlijden.datum                                                                                                    |

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
      | gevraagd aan proxy                                                              | vragen aan RvIG                                                                                                     |
      | aanhef,aanschrijfwijze.naam                                                     | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | naam.volledigeNaam,naam.voorletters                                             | naam                                                                                                                |
      | aanhef,aanschrijfwijze.naam,aanschrijfwijze.aanspreekvorm,gebruikInLopendeTekst | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | datumVestigingInNederland,indicatieVestigingVanuitBuitenland                    | datumVestigingInNederland                                                                                           |
      | nationaliteiten.type,nationaliteiten.nationaliteit                              | nationaliteit,aanduidingBijzonderNederlanderschap                                                                   |
      | leeftijd,geboorte.datum                                                         | geboorte.datum                                                                                                      |

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
      | gevraagd aan proxy | vragen aan RvIG                                                                                                     |
      | aanschrijfwijze    | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | naam               | naam,geslachtsaanduiding,partners.naam,partners.aangaanHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap |
      | verblijfplaats     | verblijfplaats                                                                                                      |
      | leeftijd,geboorte  | geboorte                                                                                                            |
      | nationaliteiten    | nationaliteiten                                                                                                     |

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
      | gevraagd aan proxy                                 | vragen aan RvIG                                   |
      | nationaliteiten.type,nationaliteiten.nationaliteit | nationaliteit,aanduidingBijzonderNederlanderschap |
      | nationaliteiten.type,nationaliteit                 | nationaliteit,aanduidingBijzonderNederlanderschap |
      | overlijden.indicatieOverleden                      | overlijden.datum                                  |
      | indicatieOverleden                                 | overlijden.datum                                  |
      | volledigeNaam                                      | naam                                              |
      | naam.volledigeNaam                                 | naam                                              |

  Rule: wanneer een gegeven van een ouder, kind of partner wordt gevraagd, moet ook de geslachtsnaam worden gevraagd
    # deze is nodig om het type te bepalen (Ouder, OnbekendOuder, Partner, OnbekendPartner, Kind, OnbekendKind)

    Abstract Scenario: vragen om <gevraagd aan proxy> moet ook naam geslachtsnaam vragen
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
      | gevraagd aan proxy                                                                   | vragen aan RvIG                                                                                                             |
      | ouders.geslachtsaanduiding,datumIngangFamilierechtelijkeBetrekking                   | ouders.geslachtsaanduiding,datumIngangFamilierechtelijkeBetrekking,ouders.naam.geslachtsnaam                                |
      | burgerservicenummer,kinderen.geboorte.datum,kinderen.naam.voornamen,gezagsverhouding | burgerservicenummer,kinderen.geboorte.datum,kinderen.naam.voornamen,gezagsverhouding,kinderen.naam.geslachtsnaam            |
      | datumIngangFamilierechtelijkeBetrekking.datum,kinderen.geboorte.datum                | datumIngangFamilierechtelijkeBetrekking.datum,kinderen.geboorte.datum,ouders.naam.geslachtsnaam,kinderen.naam.geslachtsnaam |
      | ouders.naam                                                                          | ouders.naam                                                                                                                 |
      | kinderen.naam.voorletters                                                            | kinderen.naam.voornamen,kinderen.naam.geslachtsnaam                                                                         |
      | ouders.indicatieOnbekend                                                             | ouders.naam.geslachtsnaam                                                                                                   |
      | ouders.type                                                                          | ouders.naam.geslachtsnaam                                                                                                 |
      | kinderen                                                                             | kinderen                                                                                                                    |

  
  Rule: Wanneer een gegegen van een partner wordt gevraagd, moet ook ontbindingHuwelijkPartnerschap worden gevraagd
    # deze is nodig om te bepalen of een partner actueel is of de relatie is ontbonden (en niet geleverd mag worden)

    Abstract Scenario: vragen om <gevraagd aan proxy> moet ook naam geslachtsnaam vragen
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
      | gevraagd aan proxy                                    | vragen aan RvIG                                                                                                        |
      | partners.aangaanHuwelijkPartnerschap                  | partners.aangaanHuwelijkPartnerschap,partners.naam.geslachtsnaam,partners.ontbindingHuwelijkPartnerschap               |
      | aangaanHuwelijkPartnerschap                           | aangaanHuwelijkPartnerschap,partners.naam.geslachtsnaam,partners.ontbindingHuwelijkPartnerschap                        |
      | soortVerbintenis,aangaanHuwelijkPartnerschap.datum    | soortVerbintenis,aangaanHuwelijkPartnerschap.datum,partners.naam.geslachtsnaam,partners.ontbindingHuwelijkPartnerschap |
      | partners.naam.voorvoegsel,partners.naam.geslachtsnaam | partners.naam.voorvoegsel,partners.naam.geslachtsnaam,partners.ontbindingHuwelijkPartnerschap                          |
      | partners.geboorte                                     | partners.geboorte,partners.naam.geslachtsnaam,partners.ontbindingHuwelijkPartnerschap                                  |
      | partners.naam                                         | partners.naam,partners.ontbindingHuwelijkPartnerschap                                                                  |
      | partners.type                                         | partners.naam.geslachtsnaam,partners.ontbindingHuwelijkPartnerschap                                                    |

  
  Rule: wanneer een gegeven van verblijfplaats wordt gevraagd, moeten ook straat, huisnummer, locatiebeschrijving en verblijfplaats.land worden gevraagd
    # deze zijn nodig om het type verblijfplaats te bepalen (Adres, Locatie, VerblijfplaatsBuitenland, VerblijfplaatsOnbekend)

    Abstract Scenario: vragen om <gevraagd aan proxy> moet ook minimale verblijfplaatsgegevens vragen
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
      | gevraagd aan proxy                     | vragen aan RvIG                                                                                                                                                                       |
      | huisletter                             | huisletter,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                                  |
      | datumAanvangAdreshouding               | datumAanvangAdreshouding,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                    |
      | gemeenteVanInschrijving                | gemeenteVanInschrijving,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                     |
      | locatiebeschrijving                    | locatiebeschrijving,straat,huisnummer,verblijfplaats.land                                                                                                                             |
      | landVanwaarIngeschreven                | landVanwaarIngeschreven,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                     |
      | verblijfplaats.landVanwaarIngeschreven | verblijfplaats.landVanwaarIngeschreven,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                      |
      | datumIngangGeldigheid                  | datumIngangGeldigheid,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                       |
      | verblijfplaats.type                    | straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                                             |
      | verblijfplaats.datumVan                | datumAanvangAdreshouding,datumAanvangAdresBuitenland,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                        |
      | korteNaam                              | straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                                             |
      | straat                                 | straat,naamOpenbareRuimte,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                          |
      | woonplaats                             | woonplaats,gemeenteVanInschrijving,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                          |
      | verblijfplaatsOnbekend                 | straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                                             |
      | adresregel1                            | adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huisnummertoevoeging,aanduidingBijHuisnummer,verblijfplaats.land                                                         |
      | adresregel2                            | adresregel2,postcode,woonplaats,gemeenteVanInschrijving,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                     |
      | adresregel1,adresregel2                | adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huisnummertoevoeging,aanduidingBijHuisnummer,adresregel2,postcode,woonplaats,gemeenteVanInschrijving,verblijfplaats.land |
      | vanuitVerblijfplaatsOnbekend           | landVanwaarIngeschreven,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                     |
      | indicatieVestigingVanuitBuitenland     | datumVestigingInNederland,straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                                                   |

    Abstract Scenario: zoeken van personen en vragen om <gevraagd aan proxy> moet ook minimale verblijfplaatsgegevens vragen
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Vries                               |
      | geboortedatum | 1975-07-30                          |
      | fields        | <gevraagd aan proxy>                |
      Dan zoekt de proxy de persoon bij RvIG met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Vries                               |
      | geboortedatum | 1975-07-30                          |
      | fields        | <vragen aan RvIG>                   |

      Voorbeelden:
      | gevraagd aan proxy                   | vragen aan RvIG                                                                                                                    |
      | volledigeNaam,adresregel1,woonplaats | naam,adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huisnummertoevoeging,aanduidingBijHuisnummer,verblijfplaats.land |
      | postcode,huisnummer,huisletter       | postcode,huisnummer,huisletter,straat,locatiebeschrijving,verblijfplaats.land                                                      |
      | voorletters,leeftijd,woonplaats      | naam.voornamen,geboorte.datum,woonplaats,gemeenteVanInschrijving,straat,huisnummer,locatiebeschrijving,verblijfplaats.land         |
