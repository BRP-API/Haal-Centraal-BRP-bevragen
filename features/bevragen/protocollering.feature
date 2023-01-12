#language: nl

Functionaliteit: Als burger wil ik zien wie welke gegegevens van mij heeft gezien of gebruikt
  Zoeken en raadplegen van gegevens van burgers worden "geprotocolleerd" (formeel gelogd).

  Protocollering moet gebeuren op twee niveau's:
  - bij de RvIG op het niveau van afnemende organisaties
  - bij de afnemende organisatie op het niveau van gebruikers

  Deze feature beschrijft alleen de werking van protocollering op het niveau van afnemende organisaties bij de bron (RvIG)

  Daarin worden de volgende gegevens vastgelegd:
  - request_id: unieke identificatie van de berichtuitwisseling waarmee het protocolleringsrecord te koppelen is aan andere logging van de API
  - request_datum: tijdstip waarop de protocollering is vastgelegd
  - afnemer_code: identificatiecode van de afnemende organisatie, zoals die is opgenomen in de gestuurde Oauth 2 token
  - anummer: het A-nummer van de persoon waarvan gegevens zijn gevraagd of geleverd
  - request_zoek_rubrieken: spatie gescheiden lijst van alle gegevens die met fields gevraagd zijn, vertaald naar LO-BRP elementnummers
  - request_geleverde_rubrieken: spatie gescheiden lijst van alle feitelijk geleverde gegevens, vertaald naar LO-BRP elementnummers
  - verwerkt: vaste waarde false (boolean)

  Rule: Gevraagde velden in fields worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën. Bijvoorbeeld 010120 is het burgerservicenummer (categorie 01, groep 01 en rubriek 20).

    Abstract Scenario: Gevraagde veld <fields veld> wordt vastgelegd als zoekrubriek <rubrieknummer>

    Scenario: Meerdere velden gevraagd

  Rule: Wanneer met fields een hele groep wordt gevraagd, worden alle velden in die groep vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: vragen om hele groep <groep>

    Scenario: vragen om hele relatie <relatie>

  Rule: Geleverde velden worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_geleverde_rubrieken'.
    Wanneer een gevraagd veld niet geleverd wordt, wordt het wel in het veld 'request_zoek_rubrieken' en niet in het veld 'request_geleverde_rubrieken' opgenomen.
    Een veld wordt bijvoorbeeld niet geleverd wanneer deze geen waarde heeft, of boolean false, of wegens logica in de API niet geleverd mag worden
    Protocollering gebeurt vanuit het perspectief van de gba API. Het is dus mogelijk dat een veld wel geleverd wordt door de gba API, maar de proxy API deze eruit filtert.

      Voorbeelden:
      | naam voorvoegsel heeft geen waarde         | naam                          |
      | persoon heeft geen partner                 | partners.naam                 |
      | persoon is niet overleden                  | overlijden.indicatieOverleden |
      | verblijfstitel heeft einddatum in verleden | verblijfstitel                |
      | niet leveren kind na ontkenning ouderschap | kinderen.naam.voornamen       |

    Scenario: Vragen om aangaanHuwelijkPartnerschap bij een actuele partner
    Scenario: Vragen om aangaanHuwelijkPartnerschap bij een ex-partner
    Scenario: Vragen om ouders en persooon heeft ouder 1 en ouder 2
    Scenario: Vragen om ouders en persoon heeft alleen ouder 1

    Scenario: Wel opnemen als geleverd met standaardwaarde
      | geboortedatum heeft alleen jaar bekend | leeftijd    |
      | naam ouder is heeft standaardwaarde    | ouders.naam |

  Rule: Wanneer een veld ongevraagd geleverd wordt, wordt het niet in 'request_geleverde_rubrieken' en niet in 'request_zoek_rubrieken' opgenomen.
    Dit betreft geheimhouding, opschorting, in onderzoek, RNI en verificatie

  Rule: Wanneer een veld wordt gevraagd dat wordt bepaald uit een of meerdere andere velden, dan worden alle daarvoor nodige velden in 'request_zoek_rubrieken' opgenomen.
    En worden de feitelijk geleverde velden opgenomen als geleverde rubrieken

      Voorbeelden:
      | leeftijd                             |
      | naam.voorletters                     |
      | naam.volledigeNaam                   |
      | overlijden.indicatieOverleden        |
      | verblijfplaats.verblijfadres.straat  |
      | verblijfplaats.datumVan              |
      | adressering.aanschrijfwijze          |
      | adressering.adresregel1              |
      | adressering.adresregel2              |
      | partners.aangaanHuwelijkPartnerschap |
      | ouders                               |

  Rule: Wanneer een veld wordt gevraagd waarbij meerdere velden worden meegeleverd voor het bepalen van het polymorfe type, dan worden alle daarvoor nodige velden in 'request_zoek_rubrieken' opgenomen
    En worden alleen de feitelijk geleverde velden 'request_geleverde_rubrieken' opgenomen.

      Voorbeelden:
      | nationaliteiten.nationaliteit |
      | nationaliteiten.redenOpname |
      | verblijfplaats.functieAdres |
  
  Rule: Wanneer een gevraagd veld meerdere keren in het antwoord voorkomt, worden de geleverde rubrieken één keer in 'request_geleverde_rubrieken' opgenomen.

    Scenario: Vragen om de kinderen en de persoon heeft 2 kinderen

  Rule: Wanneer in het antwoord meerdere personen worden geleverd, dan wordt er per geleverde persoon een protocolleringsrecord opgenomen

  Rule: Gevraagde en geleverde velden worden oplopend gesorteerd op elementnummer in 'request_zoek_rubrieken' en 'request_geleverde_rubrieken'
    # Vaste volgorde is gewenst ten behoeve van de testbaarheid van de functionaliteit, zodat bij elk request de protocollering voorspelbaar is.

    # fields = partners.geboorte.datum,naam.geslachtsnaam,naam.voornamen,verblijfplaats.functieAdres,geslacht,ouders.datumIngangFamilierechtelijkeBetrekking
    # request_zoek_rubrieken = 010210 010240 010410 026210 036210 050310 081010
