#language: nl

Functionaliteit: url formattering

    Als consumer van de Haal Centraal APIs
    Wil ik kunnen aangeven hoe de urls in een response moeten worden geformatteerd
    Zodat ik de urls op mijn gewenste manier kan verwerken.

    Als provider van een Haal Centraal API
    Wil ik [URI Template](https://datatracker.ietf.org/doc/html/rfc6570) gebruiken om URIs te beschrijven
    Zodat een verzameling van gelijksoortige urls met één URI template kan worden gerepresenteerd.

    Zie de [uri formattering](../docs/uri-formattering.md) voor uitgebreide uri formattering documentatie. 

    Hieronder zijn voorbeelden uitgewerkt voor de BRP Bevragen API
 
Achtergrond:
    * de Haal Centraal APIs met hun base url en base url template placeholder
    | Naam Haal Centraal API | base url                                                         | base url template placeholder |
    | BRP Bevragen           | https://www.haalcentraal.nl/haalcentraal/api/brp                 | {brpserverurl}                |
    | BAG Bevragen           | https://api.bag.acceptatie.kadaster.nl/esd/huidigebevragingen/v1 | {bagserverurl}                |
    * de persoon met burgerservicenummer "999993847"
    * de kinderen van persoon met burgerservicenummer "999993847"
        | burgerservicenummer kind |
        | 999994918                |
        | 999995121                |
    * de verblijfplaats van persoon met burgerservicenummer "999993847"
        | adresseerbaarobjectidentificatie |
        | 0518010000781379                 |

Rule: Met 'uri-reference' als uri format, worden 'same API links' als relatieve urls en 'externe API links' als absolute urls geformatteerd

    Scenario: uri-reference is opgegeven als Accept-Uri-Format header waarde
        Als GET "/ingeschrevenpersonen?burgerservicenummer=999993847" wordt aangeroepen met HTTP header "Accept-Uri-format"="uri-reference"
        Dan bevat _links in de response minimaal de volgende links
        | naam  | href                                                                                                                        | templated |
        | base  | https://www.haalcentraal.nl/haalcentraal/api/brp                                                                            |           |
        | self  | /ingeschrevenpersonen?burgerservicenummer=999993847                                                                         |           |
        | adres | https://api.bag.acceptatie.kadaster.nl/esd/huidigebevragingen/v1/adressen?adresseerbaarObjectIdentificatie=0518010000781379 |           |
        En bevat de response de volgende HTTP header
        | naam               | waarde        |
        | Content-Uri-Format | uri-reference |

Rule: 'uri-reference' is de default uri format

    Scenario: er is geen Accept-Uri-Format header in de request
        Als GET "/ingeschrevenpersonen?burgerservicenummer=999993847" wordt aangeroepen zonder HTTP header "Accept-Uri-Format"
        Dan bevat _links in de response minimaal de volgende links
        | naam  | href                                                                                                                        | templated |
        | base  | https://www.haalcentraal.nl/haalcentraal/api/brp                                                                            |           |
        | self  | /ingeschrevenpersonen?burgerservicenummer=999993847                                                                         |           |
        | adres | https://api.bag.acceptatie.kadaster.nl/esd/huidigebevragingen/v1/adressen?adresseerbaarObjectIdentificatie=0518010000781379 |           |
        En bevat de response de volgende HTTP header
        | naam               | waarde        |
        | Content-Uri-Format | uri-reference |

Rule: Met 'uri' als uri format, worden alle API links als absolute urls geformatteerd

    Scenario: uri is opgegeven als Accept-Uri-Format header waarde
        Als GET "/ingeschrevenpersonen?burgerservicenummer=999993847" wordt aangeroepen met HTTP header "Accept-Uri-format"="uri"
        Dan bevat _links in de response minimaal de volgende links
        | naam  | href                                                                                                                        | templated |
        | self  | https://www.haalcentraal.nl/haalcentraal/api/brp/ingeschrevenpersonen?burgerservicenummer=999993847                         |           |
        | adres | https://api.bag.acceptatie.kadaster.nl/esd/huidigebevragingen/v1/adressen?adresseerbaarObjectIdentificatie=0518010000781379 |           |
        En bevat de response de volgende HTTP header
        | naam               | waarde |
        | Content-Uri-Format | uri    |

Rule: Met 'uri-template' als uri format, worden bij alle API links de base url vervangen door een [xxx]serverurl expression

    Scenario: uri-template is opgegeven als uri-format header waarde
        Als GET "/ingeschrevenpersonen?burgerservicenummer=999993847" wordt aangeroepen met HTTP header "Accept-Uri-format"="uri-template"
        Dan bevat _links in de response minimaal de volgende links
        | naam         | href                                                                      | templated |
        | brpserverurl | https://www.haalcentraal.nl/haalcentraal/api/brp                          |           |
        | bagserverurl | https://api.bag.acceptatie.kadaster.nl/esd/huidigebevragingen/v1          |           |
        | self         | {brpserverurl}/ingeschrevenpersonen?burgerservicenummer=999993847         | true      |
        | adres        | {bagserverurl}/adressen?adresseerbaarObjectIdentificatie=0518010000781379 | true      |
        En bevat de response de volgende HTTP header
        | naam               | waarde       |
        | Content-Uri-Format | uri-template |

Rule: Gelijksoortige links naar 'Same API' resources en/of externe API resources worden gerepresenteerd door een templated URI

    Abstract Scenario: Gelijksoortige 'Same API' links met als uri format '<uri format>'
        Als GET "/ingeschrevenpersonen?burgerservicenummer=999993847" wordt aangeroepen met HTTP header "Accept-Uri-format"="<uri format>"
        Dan bevat _links in de response minimaal de volgende links
        | naam     | href                                                                              | templated |
        | kinderen | <baseuri>/ingeschrevenpersonen?burgerservicenummer={kinderen.burgerservicenummer} | true      |
        En bevat de response de volgende HTTP header
        | naam               | waarde       |
        | Content-Uri-Format | <uri format> |

        Voorbeelden:
            | uri format    | baseuri                                          |
            | uri-reference |                                                  |
            | uri           | https://www.haalcentraal.nl/haalcentraal/api/brp |
            | uri-template  | {brpserverurl}                                   |
