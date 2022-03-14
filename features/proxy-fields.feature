# language: nl


Functionaliteit: vertalen van gevraagde samengestelde of afgeleide velden naar vragen van bron velden
  De proxy stelt sommige velden samen uit een of meerdere andere velden. Hiervoor moet de fields in het request worden vertaald van het doelveld naar de verschillende bronvelden.

  Rule: wanneer in het request een afgeleid of samengesteld veld wordt gevraagd, moet deze in het request naar de RvIG API worden vervangen door de velden waaruit deze wordt samengesteld
    Het gaat om de volgende vertalingen:
      | gevraagd aan proxy                 | vragen aan RvIG                                                                                                                         |
      | naam.voorletters                   | naam.voornamen                                                                                                                          |
      | volledigeNaam                      | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam                                                         |
      | aanhef                             | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,aanduidingNaamgebruik,geslachtsaanduiding,partners.naam |
      | aanschrijfwijze.naam               | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,aanduidingNaamgebruik,geslachtsaanduiding,partners.naam |
      | aanschrijfwijze.aanspreekvorm      | naam.adellijkeTitelPredicaat,aanduidingNaamgebruik,geslachtsaanduiding                                                                  |
      | gebruikInLopendeTekst              | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,aanduidingNaamgebruik,geslachtsaanduiding,partners.naam |
      | leeftijd                           | geboorte.datum                                                                                                                          |
      | ouders.type                        | ouders                                                                                                                                  |
      | ouders.indicatieOnbekend           | ouders                                                                                                                                  |
      | ouders.naam.voorletters            | ouders.naam.voornamen                                                                                                                   |
      | nationaliteiten.type               | nationaliteit,aanduidingBijzonderNederlanderschap                                                                                       |
      | partners.type                      | partners                                                                                                                                |
      | partners.indicatieOnbekend         | partners                                                                                                                                |
      | partners.naam.voorletters          | partners.naam.voornamen                                                                                                                 |
      | kinderen.type                      | kinderen                                                                                                                                |
      | kinderen.indicatieOnbekend         | kinderen                                                                                                                                |
      | kinderen.naam.voorletters          | kinderen.naam.voornamen                                                                                                                 |
      | kinderen.leeftijd                  | kinderen.geboorte.datum                                                                                                                 |
      | overlijden.indicatieOverleden      | overlijden.datum                                                                                                                        |
      | verblijfplaats.type                | straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                               |
      | verblijfplaats.datumVan            | datumAanvangAdreshouding,datumAanvangAdresBuitenland                                                                                    |
      | korteNaam                          | straat                                                                                                                                  |
      | straat                             | straat,naamOpenbareRuimte                                                                                                               |
      | woonplaats                         | woonplaats,gemeenteVanInschrijving,straat,locatiebeschrijving                                                                           |
      | verblijfplaatsOnbekend             | verblijfplaats.land                                                                                                                     |
      | adresregel1                        | adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huistoevoeging,aanduidingBijHuisnummer                                     |
      | adresregel2                        | adresregel2,postcode,woonplaats,gemeenteVanInschrijving                                                                                 |
      | vanuitVerblijfplaatsOnbekend       | landVanwaarIngeschreven                                                                                                                 |
      | indicatieVestigingVanuitBuitenland | datumVestigingInNederland                                                                                                               |

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
      | gevraagd aan proxy                 | vragen aan RvIG                                                                                                                         |
      | naam.voorletters                   | naam.voornamen                                                                                                                          |
      | volledigeNaam                      | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam                                                         |
      | aanhef                             | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,aanduidingNaamgebruik,geslachtsaanduiding,partners.naam |
      | aanschrijfwijze.naam               | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,aanduidingNaamgebruik,geslachtsaanduiding,partners.naam |
      | aanschrijfwijze.aanspreekvorm      | naam.adellijkeTitelPredicaat,aanduidingNaamgebruik,geslachtsaanduiding                                                                  |
      | gebruikInLopendeTekst              | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,aanduidingNaamgebruik,geslachtsaanduiding,partners.naam |
      | leeftijd                           | geboorte.datum                                                                                                                          |
      | ouders.type                        | ouders                                                                                                                                  |
      | ouders.indicatieOnbekend           | ouders                                                                                                                                  |
      | ouders.naam.voorletters            | ouders.naam.voornamen                                                                                                                   |
      | nationaliteiten.type               | nationaliteit,aanduidingBijzonderNederlanderschap                                                                                       |
      | partners.type                      | partners                                                                                                                                |
      | partners.indicatieOnbekend         | partners                                                                                                                                |
      | partners.naam.voorletters          | partners.naam.voornamen                                                                                                                 |
      | kinderen.type                      | kinderen                                                                                                                                |
      | kinderen.indicatieOnbekend         | kinderen                                                                                                                                |
      | kinderen.naam.voorletters          | kinderen.naam.voornamen                                                                                                                 |
      | kinderen.leeftijd                  | kinderen.geboorte.datum                                                                                                                 |
      | overlijden.indicatieOverleden      | overlijden.datum                                                                                                                        |
      | verblijfplaats.type                | straat,huisnummer,locatiebeschrijving,verblijfplaats.land                                                                               |
      | verblijfplaats.datumVan            | datumAanvangAdreshouding,datumAanvangAdresBuitenland                                                                                    |
      | korteNaam                          | straat                                                                                                                                  |
      | straat                             | straat,naamOpenbareRuimte                                                                                                               |
      | woonplaats                         | woonplaats,gemeenteVanInschrijving,straat,locatiebeschrijving                                                                           |
      | verblijfplaatsOnbekend             | verblijfplaats.land                                                                                                                     |
      | adresregel1                        | adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huistoevoeging,aanduidingBijHuisnummer                                     |
      | adresregel2                        | adresregel2,postcode,woonplaats,gemeenteVanInschrijving                                                                                 |
      | vanuitVerblijfplaatsOnbekend       | landVanwaarIngeschreven                                                                                                                 |
      | indicatieVestigingVanuitBuitenland | datumVestigingInNederland                                                                                                               |

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
      | gevraagd aan proxy                                         | vragen aan RvIG                                                                                                                                                                               |
      | naam.voorletters,naam.geslachtsnaam,adresregel1,woonplaats | naam.voornamen,naam.geslachtsnaam,adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huistoevoeging,aanduidingBijHuisnummer,adresregel2,postcode,woonplaats,gemeenteVanInschrijving |
      | kinderen.voornamen,kinderen.leeftijd                       | kinderen.voornamen,kinderen.geboorte.datum                                                                                                                                                    |
      | burgerservicenummer,leeftijd,volledigeNaam                 | burgerservicenummer,geboorte.datum,naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam                                                                            |

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
      | aanhef,aanschrijfwijze.naam                                  | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,aanduidingNaamgebruik,geslachtsaanduiding,partners.naam |
      | naam.volledigeNaam,naam.voorletters                          | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam                                                         |
      | datumVestigingInNederland,indicatieVestigingVanuitBuitenland | datumVestigingInNederland                                                                                                               |
      | nationaliteiten.type,nationaliteiten.nationaliteit           | nationaliteit,aanduidingBijzonderNederlanderschap                                                                                       |
      | leeftijd,geboorte.datum                                      | geboorte.datum                                                                                                                          |

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
      | aanschrijfwijze   | naam.voornamen,naam.adellijkeTitelPredicaat,naam.voorvoegsel,naam.geslachtsnaam,aanduidingNaamgebruik,geslachtsaanduiding,partners.naam |
      | naam              | naam,geslachtsaanduiding,partners.naam                                                                                                  |
      | verblijfplaats    | verblijfplaats                                                                                                                          |
      | leeftijd,geboorte | geboorte                                                                                                                                |
      | partners.naam     | partners.naam                                                                                                                           |
      | kinderen          | kinderen                                                                                                                                |
      | nationaliteiten   | nationaliteiten                                                                                                                         |

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
      | adresregel1,woonplaats                               | adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huistoevoeging,aanduidingBijHuisnummer,woonplaats,gemeenteVanInschrijving |
      | verblijfplaats.adresregel1,verblijfplaats.woonplaats | adresregel1,straat,locatiebeschrijving,huisnummer,huisletter,huistoevoeging,aanduidingBijHuisnummer,woonplaats,gemeenteVanInschrijving |
      | vanuitVerblijfplaatsOnbekend                         | landVanwaarIngeschreven                                                                                                                |
      | verblijfplaats.vanuitVerblijfplaatsOnbekend          | landVanwaarIngeschreven                                                                                                                |
      | nationaliteiten.type,nationaliteiten.nationaliteit   | nationaliteit,aanduidingBijzonderNederlanderschap                                                                                      |
      | nationaliteiten.type,nationaliteit                   | nationaliteit,aanduidingBijzonderNederlanderschap                                                                                      |
      | overlijden.indicatieOverleden                        | overlijden.datum                                                                                                                       |
      | indicatieOverleden                                   | overlijden.datum                                                                                                                       |
