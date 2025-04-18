# language: nl
Functionaliteit: zoek personen met geslachtsnaam en geboortedatum

  Als consumer
  wil ik personen vinden door het opgeven van hun geslachtsnaam en geboortedatum

  Regel: personen worden gevonden als hun geboortedatum én hun geslachtsnaam overeenkomen met de opgegeven geboortedatum en geslachtsnaamhun (niet-hoofdlettergevoelig)

    Abstract Scenario: geslachtsnaam en geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam en geboortedatum
      Gegeven de persoon 'Pieter' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
        |              19830526 | Maassen               | Pieter            |
      En de persoon 'Jan' met burgerservicenummer '000000025'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        |              19830526 | Maassen               | Jan Peter         | van                 |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26'
      Dan worden 'Pieter en Jan' gevonden

      Voorbeelden:
        | geslachtsnaam |
        | Maassen       |
        | maassen       |
        | MAASSEN       |

    Abstract Scenario: de te vinden persoon heeft een geslachtsnaam van twee karakters lang
      Gegeven de persoon 'Marjan' met burgerservicenummer '000000026'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
        |              19830526 | Os                    | Marjan            |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'os' en geboortedatum '1983-05-26'
      Dan wordt 'Marjan' gevonden

    Abstract Scenario: geslachtsnaam van personen komen gedeeltelijk overeen met de opgegeven geslachtsnaam
      Gegeven de persoon 'Pieter' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
        |              19830526 | Maassen               | Pieter            |
      En de persoon 'Jan' met burgerservicenummer '000000025'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        |              19830526 | Maassen               | Jan Peter         | van                 |
      En de persoon 'Petra' met burgerservicenummer '000000026'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
        |              19830526 | Jansen                | Petra             |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26'
      Dan worden er geen personen gevonden

      Voorbeelden:
        | geslachtsnaam |
        | Maas          |
        | jans          |
        | MAAS          |

  Regel: personen met diakrieten in hun geslachtsnaam kunnen ook worden gevonden als het diakrietloos variant van de geslachtsnaam wordt opgegeven

    Abstract Scenario: de te vinden persoon heef diakrieten in zijn geslachtsnaam
      Gegeven de persoon 'Albertus' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) | voornamen (02.10) |
        |              19830526 | Kaster                | Käster                     | Albertus Johannes |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26'
      Dan worden 'Albertus' gevonden

      Voorbeelden:
        | geslachtsnaam |
        | Käster        |
        | Kaster        |

  Regel: de optionele 'voornamen' en 'voorvoegsels' parameters (niet hoofdlettergevoelig) kunnen worden gebruikt om de zoek criteria aan te scherpen

    Abstract Scenario: de geslachtsnaam, voornamen en geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam, voornamen en geboortedatum
      Gegeven de persoon 'Pieter' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
        |              19830526 | Maassen               | Pieter            |
      En de persoon 'Jan' met burgerservicenummer '000000025'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        |              19830526 | Maassen               | Jan Peter         | van                 |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26' en parameters
        | voornamen   |
        | <voornamen> |
      Dan wordt alleen '<persoon aanduiding>' gevonden

      Voorbeelden:
        | geslachtsnaam | voornamen | persoon aanduiding |
        | Maassen       | Pieter    | Pieter             |
        | maassen       | PIETER    | Pieter             |
        | MAASSEN       | pieter    | Pieter             |
        | maassen       | jan peter | Jan                |

    Abstract Scenario: de geslachtsnaam, voorvoegsels en geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam, voorvoegsels en geboortedatum
      Gegeven de persoon 'Pieter' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
        |              19830526 | Maassen               | Pieter            |
      En de persoon 'Jan' met burgerservicenummer '000000025'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        |              19830526 | Maassen               | Jan Peter         | van                 |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26' en parameters
        | voorvoegsel    |
        | <voorvoegsels> |
      Dan wordt alleen 'Jan' gevonden

      Voorbeelden:
        | geslachtsnaam | voorvoegsels |
        | Maassen       | van          |
        | maassen       | VAN          |
        | MAASSEN       | Van          |

  Regel: de optionele 'geslacht' parameter (niet hoofdlettergevoelig) kan worden gebruikt om de zoek criteria aan te scherpen

    Abstract Scenario: geslachtsnaam, geslacht en geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam, geslacht en geboortedatum
      Gegeven de persoon 'Aedel' met burgerservicenummer '000000027'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
        |              19830526 | V                           |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Aedel' en geboortedatum '1983-05-26' en parameters
        | geslacht              |
        | <geslachtsaanduiding> |
      Dan wordt alleen 'Aedel' gevonden

      Voorbeelden:
        | geslachtsaanduiding |
        | v                   |
        | V                   |

  Regel: de optionele 'inclusiefOverledenPersonen' parameter moet worden opgegeven om overleden personen te kunnen vinden

    Scenario: geslachtsnaam en geboortedatum van een overleden persoon komen exact overeen en de optionele 'inclusiefOverledenPersonen' parameter is niet opgegeven
      Gegeven de persoon 'Jansen' met burgerservicenummer '000000028'
      * heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19830526 |
      En 'Jansen' is overleden
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Jansen' en geboortedatum '1983-05-26'
      Dan worden er geen personen gevonden

    Scenario: geslachtsnaam en geboortedatum van een overleden persoon komen exact overeen en de optionele 'inclusiefOverledenPersonen' parameter is opgegeven
      Gegeven de persoon 'Jansen' met burgerservicenummer '000000028'
      * heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19830526 |
      En 'Jansen' is op 23-03-2023 overleden
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Jansen' en geboortedatum '1983-05-26' en parameters
        | inclusiefOverledenPersonen |
        | true                       |
      Dan wordt 'Jansen' gevonden
      En heeft 'Jansen' de volgende 'opschortingBijhouding' gegevens
        | reden.code | reden.omschrijving | datum.datum | datum.langFormaat | datum.type |
        | O          | overlijden         |  2023-03-23 |     23 maart 2023 | Datum      |

  Regel: de optionele 'gemeenteVanInschrijving' parameter kan worden gebruikt om de zoek criteria aan te scherpen

    Scenario: geslachtsnaam, geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam, geboortedatum maar de personen staan niet ingeschreven in de opgegeven gemeente
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        |                 0599 |                         0599010051001502 |
      En de persoon 'Aedel' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19830526 |
      En 'Aedel' is 3 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Aedel' en geboortedatum '1983-05-26' en parameters
        | gemeenteVanInschrijving |
        |                    0518 |
      Dan worden er geen personen gevonden

    Scenario: geslachtsnaam, geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam, geboortedatum maar de personen staan ingeschreven in de opgegeven gemeente
      Gegeven adres 'A1'
        | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
        |                 0599 |                         0599010051001502 |
      En de persoon 'Aedel' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19830526 |
      En 'Aedel' is 3 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Aedel' en geboortedatum '1983-05-26' en parameters
        | gemeenteVanInschrijving |
        |                    0599 |
      Dan wordt 'Aedel' gevonden

  Regel: wildcard matching (niet hoofdlettergevoelig) kan worden toegepast voor de geslachtsnaam en voornamen parameters
        Voor wildcard matching moet minimaal 3 letters  worden opgegeven, gevolgd door de wildcard teken (*)

    Scenario: geslachtsnaam van personen komen overeen met de opgegeven geslachtsnaam met wildcard matching
      Gegeven de persoon 'Groen' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19830526 |
      En de persoon 'Groot' met burgerservicenummer '000000025'
      * heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19830526 |
      En de persoon 'Groenlo' met burgerservicenummer '000000026'
      * heeft de volgende gegevens
        | geboortedatum (03.10) |
        |              19830526 |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam filter>' en geboortedatum '1983-05-26'
      Dan worden 'Groen, Groot en Groenlo' gevonden

      Voorbeelden:
        | geslachtsnaam filter |
        | gro*                 |
        | Gro*                 |
        | GRO*                 |

    Scenario: voornamen van personen komen overeen met de opgegeven voornamen met wildcard matching
      Gegeven de persoon 'Maassen' met burgerservicenummer '000000024'
      * heeft de volgende gegevens
        | geboortedatum (03.10) | voornamen (02.10) |
        |              19830526 | Jan Peter         |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Maassen' en geboortedatum '1983-05-26' en parameters
        | voornamen          |
        | <voornamen filter> |
      Dan wordt 'Maassen' gevonden

      Voorbeelden:
        | voornamen filter |
        | Jan*             |
        | jan*             |
        | JAN*             |
