# language: nl

Functionaliteit: autorisatie voor het gebruik van de API

Rule: Een parameter mag alleen worden gebruikt bij zoeken wanneer de gebruiker voor dit gegeven geautoriseerd is

    Scenario: gebruik van een parameter waarvoor de gebruiker niet geautoriseerd is
        Gegeven de gebruiker is geautoriseerd voor naam.geslachtsnaam (01.02.40)
        En de gebruiker is geautoriseerd voor geboorte.datum (01.03.10)
        En de gebruiker is NIET geautoriseerd voor geboorte.plaats (01.03.20)
        En de gebruiker is NIET geautoriseerd voor geboorte.land (01.03.30)
        Als personen worden gezocht met:
        """
        {
            "geslachtsnaam": "Test",
            "geboortedatum": "2022-01-31",
            "geboorteplaats": "Rotterdam",
            "fields": "naam.geslachtsnaam,geboorte.datum"
        }
        """
        Dan is de http status code van het antwoord 403
        En bevat het antwoord veld "title" met waarde "U bent niet geautoriseerd voor de gebruikte parameter(s)."
        En bevat het antwoord veld "detail" met waarde "U bent niet geautoriseerd voor het gebruik van de parameter geboorte__plaats."
        En bevat het antwoord veld "code" met waarde "unauthorizedParameter"

Rule: Wanneer met fields gevraagd wordt om een gegeven waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    # dit betekent dat wanneer een gebruiker (developer) niet vooraf weet of de persoon binnengemeentelijk is, deze mogelijk een 403 foutmelding krijgt
    # dan wel pas na opvragen gemeente van inschrijving alle overige gegevens kan vragen

    Scenario: vragen om een gegeven waarvoor de gebruiker niet geautoriseerd is
        Gegeven de gebruiker is geautoriseerd voor geboorte.datum (01.03.10)
        En de gebruiker is NIET geautoriseerd voor geboorte.plaats (01.03.20)
        En de gebruiker is NIET geautoriseerd voor geboorte.land (01.03.30)
        Als personen worden geraadpleegd met "/personen/17623716253?fields=geboorte.datum,geboorte.plaats"
        Dan is de http status code van het antwoord 403
        En bevat het antwoord veld "title" met waarde "U bent niet geautoriseerd voor de in fields gevraagde gegevens."
        En bevat het antwoord veld "detail" met waarde "U bent niet geautoriseerd voor gegeven geboorte.plaats"
        En bevat het antwoord veld "code" met waarde "unauthorizedFields"

Rule: Wanneer met fields gevraagd wordt om een groep gegevens, en de gebruiker is niet geautoriseerd voor een gegeven binnen de groep, wordt een foutmelding gegeven 

    Scenario: vragen om een groep met een gegeven waarvoor de gebruiker niet geautoriseerd is
        Gegeven de gebruiker is geautoriseerd voor geboorte.datum (01.03.10)
        En de gebruiker is NIET geautoriseerd voor geboorte.plaats (01.03.20)
        En de gebruiker is NIET geautoriseerd voor geboorte.land (01.03.30)
        En de persoon met uuid "17623716253" is geen binnengemeentelijk persoon voor de gebruiker
        Als personen worden geraadpleegd met "/personen/17623716253?fields=geboorte"
        Dan is de http status code van het antwoord 403
        En bevat het antwoord veld "title" met waarde "U bent niet geautoriseerd voor de in fields gevraagde gegevens."
        En bevat het antwoord veld "detail" met waarde "U bent niet geautoriseerd voor gegeven geboorte.plaats, geboorte.land"
        En bevat het antwoord veld "code" met waarde "unauthorizedFields"

Rule: Een gemeente is geautoriseerd voor alle gegevens van de eigen inwoners

    Scenario: gemeente vraagt gegevens van eigen inwoner
        Gegeven de gebruiker is een gemeente met code "0518"
        En in autorisatietabel 35 van deze gemeente is er autorisatie voor nationaliteit (04.05.10) en Aanduiding bijzonder Nederlanderschap (04.65.10)
        En in autorisatietabel 35 van deze gemeente is er GEEN autorisatie voor nationaliteit.datumIngangGeldigheid (04.85.10)
        En de persoon met uuid "17623716253" heeft verblijfplaats.gemeenteVanInschrijving.code (08.09.10) met waarde "0518"
        Als personen worden geraadpleegd met "/personen/17623716253?fields=nationaliteit.datumIngangGeldigheid"
        Dan is de http status code van het antwoord 200
        En bevat het antwoord veld "nationaliteit.datumIngangGeldigheid" met een waarde

    Scenario: gemeente vraagt gegevens van inwoner van andere gemeente
        Gegeven de gebruiker is een gemeente met code "0518"
        En in autorisatietabel 35 van deze gemeente is er autorisatie voor nationaliteit (04.05.10) en Aanduiding bijzonder Nederlanderschap (04.65.10)
        En in autorisatietabel 35 van deze gemeente is er GEEN autorisatie voor nationaliteit.datumIngangGeldigheid (04.85.10)
        En de persoon met uuid "846956294728" heeft verblijfplaats.gemeenteVanInschrijving.code (08.09.10) met waarde "0363"
        Als personen worden geraadpleegd met "/personen/846956294728?fields=nationaliteit.datumIngangGeldigheid"
        Dan is de http status code van het antwoord 403
        En bevat het antwoord veld "title" met waarde "U bent niet geautoriseerd voor de in fields gevraagde gegevens."
        En bevat het antwoord veld "detail" met waarde "U bent niet geautoriseerd voor gegeven geboorte.plaats, geboorte.land"
        En bevat het antwoord veld "code" met waarde "unauthorizedFields"

Rule: Wanneer de gebruiker niet geautoriseerd is voor adresvragen (35.95.66 is ongelijk aan "1") dan moet bij zoeken ten minste één van de parameters burgerservicenummer, geslachtsnaam, geboortedatum en/of postcode gebruikt worden

    Abstract Scenario: zoeken zonder adresvraagbevoegdheid en geen 
        Gegeven in autorisatietabel 35 van de gebruiker is heeft Adresvraagbevoegdheid (35.95.66) de waarde "0"
        Als personen worden gezocht met:
        """
        <query>
        """
        Dan is de http status code van het antwoord 403
        En bevat het antwoord veld "title" met waarde "U bent niet geautoriseerd voor de gebruikte parametercombinatie."
        En bevat het antwoord veld "detail" met waarde "Bij zoeken moet u ten minste één van de parameters burgerservicenummer, geslachtsnaam, geboortedatum en/of postcode gebruiken."
        En bevat het antwoord veld "code" met waarde "adressSearch"

        Voorbeelden: 
            | query                                                                                                                     |
            | { "nummeraanduidingIdentificatie": "0200200000003734" }                                                                   |
            | { "gemeenteVanInschrijving": "0518", "straat": "Spui", "huisnummer": 80 }                                                 |
            | { "nummeraanduidingIdentificatie": "0200200000003734", "voornamen": "john", "geslachtsaanduiding": "M" }                  |
            | { "gemeenteVanInschrijving": "0518", "straat": "Spui", "huisnummer": 80, "huisletter": "a", "huisnummertoevoeging": "2" } |
            | { "nummeraanduidingIdentificatie": "0200200000003734", "geboorteplaats": "Rotterdam" }                                    |
