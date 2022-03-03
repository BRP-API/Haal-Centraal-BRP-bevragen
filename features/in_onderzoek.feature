# language: nl

Functionaliteit: in onderzoek
  Wanneer de juistheid van een gegeven onderzocht wordt, en daardoor de waarde van een geleverd gegeven mogelijk onjuist is, wordt naast het betreffende veld ook in inOnderzoek een veld met dezelfde naam opgenomen. Deze krijgt dan de boolean waarde true.

  Een categorie kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele groepen of elementen binnen de categorie in onderzoek zijn.
  
  Een veld dat niet in onderzoek is, wordt niet in inOnderzoek opgenomen, ook niet met de waarde false of null.

  De vertaling van een inOnderzoek elementwaarde (gegeven 83.10) naar inOnderzoek velden in het antwoord staat in /features/in onderzoek.xlsx

  Ook wanneer een gegeven geen waarde heeft en daardoor niet in het antwoord opgenomen wordt kan het in onderzoek zijn. In dat geval wordt alleen in inOnderzoek een veld opgenomen met die naam en de waarde true.

Rule: wanneer een element in de bron in onderzoek is, wordt het gegeven in het antwoord dat daaruit gevuld wordt ook in inOnderzoek opgenomen met de waarde true

  Abstract Scenario: adres heeft <veld> in onderzoek

  Voorbeelden:
  | waarde | veld                    |
  | 081120 | huisnummer              |
  | 081130 | huisletter              |
  | 081140 | huisnummertoevoeging    |
  | 081150 | aanduidingBijHuisnummer |
  | 081160 | postcode                |
  | 081170 | woonplaats              |
  | 081210 | locatiebeschrijving     |



Rule: wanneer een groep in de bron in onderzoek is, wordt elk gegeven in het antwoord dat gevuld wordt uit een van de elementen in die groep ook in inOnderzoek opgenomen met de waarde true
  - de elementcode voor onderzoek eindigt op 00

Rule: wanneer een categorie in de bron in onderzoek is, wordt elk gegeven in het antwoord dat gevuld wordt uit een van de elementen in die categorie ook in inOnderzoek opgenomen met de waarde true
  - de elementcode voor onderzoek eindigt op 0000

Rule: in onderzoek wordt niet opgenomen wanneer het onderzoek beëindigd is
  - Datum einde onderzoek (83.30) heeft een waarde

  @gba
  Scenario: onderzoek is beëindigd
  Als de persoon met burgerservicenummer 999994888 wordt geraadpleegd
  Dan is in het antwoord inOnderzoek niet aanwezig of null

Rule: een afgeleid gegeven wordt in inOnderzoek opgenomen wanneer ten minste één van de gegevens waaruit het wordt afgeleid in onderzoek staat
  
  Abstract Scenario: leeftijd van de persoon in onderzoek omdat <reden>
  
  voorbeelden:
  | reden                                        | waarde |
  | geboortedatum van de persoon is in onderzoek | 010310 |
  | groep geboorte is in onderzoek               | 010300 |
  | categorie persoon is in onderzoek            | 010000 |

  Abstract Scenario: indicatieOverleden van de persoon in onderzoek omdat <reden>
  
  voorbeelden:
  | reden                                   | waarde |
  | voornamen van het kind is in onderzoek  | 090210 |
  | groep naam van het kind is in onderzoek | 090200 |
  | categorie kind is in onderzoek          | 090000 |

  Abstract Scenario: voorletters van een ouder in onderzoek omdat <reden>
  
  voorbeelden:
  | reden                                  | waarde | ouder  |
  | voornamen van ouder 1 is in onderzoek  | 020210 | ouder1 |
  | groep naam van ouder 1 is in onderzoek | 020200 | ouder1 |
  | categorie ouder 1 is in onderzoek      | 020000 | ouder1 |
  | voornamen van ouder 2 is in onderzoek  | 030210 | ouder2 |
  | groep naam van ouder 2 is in onderzoek | 030200 | ouder2 |
  | categorie ouder 2 is in onderzoek      | 030000 | ouder2 |

  Abstract Scenario: verblijfplaats datumVan in onderzoek omdat <rede>

  Scenario: indicatieVestigingVanuitBuitenland in onderzoek omdat landVanWaarIngeschreven is in onderzoek

  Abstract Scenario: verblijfplaats datumVan in onderzoek omdat <reden> in onderzoek

  voorbeelden:
  | reden                       | waarde |
  | datumAanvangAdreshouding    | 081030 |
  | datumAanvangAdresBuitenland | 081320 |
  | groep adreshouding          | 081000 |
  | groep verblijf buitenland   | 081300 |
  | categorie verblijfplaats    | 080000 |

  Abstract Scenario: verblijfplaats woonplaats in onderzoek omdat <reden> in onderzoek

  voorbeelden:
  | reden                    | waarde |
  | woonplaatsnaam           | 081170 |
  | gemeenteVanInschrijving  | 080910 |
  | groep adres              | 081100 |
  | groep gemeente           | 080900 |
  | categorie verblijfplaats | 080000 |

  voorbeelden:
  | reden                                        | waarde | adresregel1 | adresregel2 |
  | huisnummer is in onderzoek                   | 081130 | WEL         | NIET        |
  | postcode is in onderzoek                     | 081160 | NIET        | WEL         |
  | woonplaats is in onderzoek                   | 081170 | NIET        | WEL         |
  | gemeenteVanInschrijving is in onderzoek      | 080910 | NIET        | WEL         |
  | locatiebeschrijving is in onderzoek          | 081210 | WEL         | NIET        |
  | regel 1 adres buitenland is in onderzoek     | 081330 | WEL         | NIET        |
  | regel 2 adres buitenland is in onderzoek     | 081340 | WEL         | NIET        |
  | land adres buitenland is in onderzoek        | 081310 | NIET        | NIET        |
  | groep adres is in onderzoek                  | 081100 | WEL         | WEL         |
  | groep verblijf buitenland is in onderzoek    | 081300 | WEL         | WEL         |
  | categorie verblijfplaats is in onderzoek     | 080000 | WEL         | WEL         |

Rule: onderzoek van een partnergegeven leidt alleen tot inOnderzoek van een samengesteld naamgegeven wanneer daarin de partnernaam wordt gebruikt
  - naam.aanduidingNaamgebruik is ongelijk aan 'E'
  - een of meerdere van de partner naamgegevens voorvoegsel, adellijkeTitelPredicaat of geslachtsnaam zijn in onderzoek
  - betreft aanhef, aanschrijfwijze en gebruikInLopendeTekst

  Abstract Scenario: samengestelde namen bij <omschrijving>
  voorbeelden:
  | omschrijving                                            | waarde | aanduidingNaamgebruik | inOnderzoek |
  | partner in onderzoek en gebruik eigen naam              | 050000 | E                     | NIET        |
  | partner in onderzoek en gebruik partner naam            | 050000 | P                     | WEL         |
  | partner in onderzoek en gebruik partner na eigen naam   | 050000 | N                     | WEL         |
  | partner in onderzoek en gebruik partner voor eigen naam | 050000 | V                     | WEL         |
  | groep naam van partner in onderzoek                     | 050200 | P                     | WEL         |
  | voornamen in onderzoek                                  | 050210 | P                     | NIET        |
  | voorvoegsel in onderzoek                                | 050210 | P                     | WEL         |
  | adellijkeTitelPredicaat in onderzoek                    | 050210 | P                     | WEL         |
  | geslachtsnaam in onderzoek                              | 050210 | P                     | WEL         |
  | aangaanHuwelijkPartnerschap in onderzoek                | 050600 | P                     | NIET        |
