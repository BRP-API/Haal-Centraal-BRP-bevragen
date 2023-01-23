#language: nl

Functionaliteit: Als burger wil ik zien wie welke gegegevens van mij heeft gezien of gebruikt
  Zoeken en raadplegen van gegevens van burgers worden "geprotocolleerd" (formeel gelogd).

  Protocollering moet gebeuren op twee niveau's:
  - bij de RvIG op het niveau van afnemende organisaties
  - bij de afnemende organisatie op het niveau van gebruikers

  Deze feature beschrijft alleen de werking van protocollering op het niveau van afnemende organisaties bij de bron (RvIG)

  Daarin worden de volgende gegevens vastgelegd:
  - request_id: unieke identificatie van de berichtuitwisseling
  - request_datum: tijdstip waarop de protocollering is vastgelegd
  - afnemer_code: identificatiecode van de afnemende organisatie, zoals die is opgenomen in de gestuurde Oauth 2 token
  - anummer: het A-nummer van de persoon waarvan gegevens zijn gevraagd of geleverd
  - request_zoek_rubrieken: lijst van alle parameters die in het request gebruikt zijn, vertaald naar LO-BRP elementnummers
  - request_gevraagde_rubrieken: lijst van alle gegevens die met fields gevraagd zijn, vertaald naar LO-BRP elementnummers
  - verwerkt: vaste waarde false (boolean)

  Zowel request_zoek_rubrieken als request_gevraagde_rubrieken bevatten de LO-BRP elementnummers als 6 cijferig rubrieknummer (incl. voorloopnul), gescheiden door komma spatie, en oplopend gesorteerd.

  Rule: Gebruikte parameters worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

  Rule: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

  Rule: Gevraagde velden in fields worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_gevraagde_rubrieken'.
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën. Bijvoorbeeld 010120 is het burgerservicenummer (categorie 01, groep 01 en rubriek 20).

    Abstract Scenario: Gevraagde veld <fields veld> wordt vastgelegd in 'request_gevraagde_rubrieken' als <rubrieknummer>

    Scenario: Meerdere velden gevraagd

  Rule: Wanneer met fields een hele groep wordt gevraagd, worden alle velden in die groep vastgelegd in het veld 'request_gevraagde_rubrieken'.

    Scenario: vragen om hele groep <groep>

    Scenario: vragen om hele relatie <relatie>

  Rule: Wanneer een gevraagd veld niet geleverd wordt (bijv. omdat het geen waarde heeft), wordt het wel in het veld 'request_gevraagde_rubrieken' opgenomen.
    
    Abstract Scenario: Vragen om <fields> en <omschrijving>
      Voorbeelden:
      | omschrijving                       | fields                     | gevraagde rubrieken            |
      | naam voorvoegsel heeft geen waarde | naam                       | 010210, 010220, 010230, 010240 |
      | persoon heeft geen partner         | partners.geboorte          | 050310, 050320, 050330         |
      | persoon is niet overleden          | overlijden.datum           | 060810                         |
      | persoon heeft geen verblijfstitel  | verblijfstitel.aanduiding  | 103910                         |
      | persoon heeft geen kind            | kinderen.naam.voornamen    | 090210                         |
      | persoon heeft alleen ouder 1       | ouders.burgerservicenummer | 020120, 030120                 |

  Rule: Wanneer een veld ongevraagd geleverd wordt, wordt het niet in 'request_gevraagde_rubrieken' opgenomen.
    Dit betreft geheimhouding, opschorting, in onderzoek, RNI en verificatie

  Rule: Wanneer een veld wordt gevraagd dat wordt bepaald uit een of meerdere andere velden, dan worden alle daarvoor nodige velden in 'request_gevraagde_rubrieken' opgenomen.

    Abstract Scenario: Vragen om <fields>
      Voorbeelden:
      | fields                               | gevraagde rubrieken                                                                    |
      | leeftijd                             | 010310, 060810                                                                         |
      | naam.voorletters                     | 010210                                                                                 |
      | naam.volledigeNaam                   | 010210, 010220, 010230, 010240, 010410                                                 |
      | overlijden.indicatieOverleden        | 060810                                                                                 |
      | verblijfplaats.datumVan              | 081030, 081320                                                                         |
      | adressering.aanschrijfwijze          | 010210, 010220, 010230, 010240, 010410, 016110, 050220, 050230, 050240, 050610, 050710 |
      | adressering.adresregel1              | 081110, 081120, 081130, 081140, 081150, 081210, 081310, 081330                         |
      | adressering.adresregel2              | 080910, 081110, 081120, 081160, 081170, 081210, 081310, 081340                         |
      | partners.aangaanHuwelijkPartnerschap | 050610, 550610                                                                         |
      | ouders.naam                          | 020210, 020220, 020230, 020240, 030210, 030220, 030230, 030240                         |

  Rule: Wanneer een veld wordt gevraagd waarbij meerdere velden worden meegeleverd voor het bepalen van het polymorfe type, dan worden alle daarvoor nodige velden in 'request_gevraagde_rubrieken' opgenomen.

    Abstract Scenario: Vragen om <fields> protocolleert ook benodigde velden voor het type
      Voorbeelden:
      | fields                        | gevraagde rubrieken            |
      | nationaliteiten.nationaliteit | 040510, 046510                 |
      | nationaliteiten.redenOpname   | 040510, 046310, 046510         |
      | verblijfplaats.functieAdres   | 081010, 081110, 081210, 081310 |
  
  Rule: Wanneer een gevraagde rubriek nodig is voor meerdere fields velden, wordt de rubrieken één keer in 'request_gevraagde_rubrieken' opgenomen.

    Scenario: Vragen om aanhef en aanschrijfwijze

    Scenario: Vragen om leeftijd en geboortedatum

    Scenario: Vragen om meerdere velden van verblijfplaats

  Rule: Gevraagde rubrieken worden oplopend gesorteerd op elementnummer in 'request_gevraagde_rubrieken'
    
    # fields = partners.geboorte.datum,adressering.aanschrijfwijze,ouders.datumIngangFamilierechtelijkeBetrekking
    # request_gevraagde_rubrieken = 010210, 010220, 010230, 010240, 010410, 016110, 026210, 036210, 050220, 050230, 050240, 050310, 050610, 050710

    # fields = partners.aangaanHuwelijkPartnerschap,overlijden.datum
    # request_gevraagde_rubrieken = 050610, 060810, 550610

  Rule: Wanneer in het antwoord meerdere personen worden geleverd, dan wordt er per geleverde persoon een protocolleringsrecord opgenomen
