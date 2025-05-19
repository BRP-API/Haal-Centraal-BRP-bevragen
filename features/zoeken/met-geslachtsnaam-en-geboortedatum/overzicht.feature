# language: nl
Functionaliteit: zoek personen met geslachtsnaam en geboortedatum

  Als consumer
  wil ik personen vinden door het opgeven van hun geslachtsnaam en geboortedatum

  Regel: personen worden gevonden als hun geboortedatum én hun geslachtsnaam overeenkomen met de opgegeven geboortedatum en geslachtsnaam (niet-hoofdlettergevoelig)

    Abstract Scenario: geslachtsnaam en geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam en geboortedatum
      Gegeven de op 26-05-1983 geboren 'Pieter'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) |
        | Maassen               | Pieter            |
      En de op 26-05-1983 geboren 'Jan'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        | Maassen               | Jan Peter         | van                 |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26'
      Dan worden 'Pieter en Jan' gevonden

      Voorbeelden:
        | geslachtsnaam |
        | Maassen       |
        | maassen       |
        | MAASSEN       |

    Abstract Scenario: de te vinden persoon heeft een geslachtsnaam van twee karakters lang
      Gegeven de op 26-05-1983 geboren 'Marjan'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) |
        | Os                    | Marjan            |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'os' en geboortedatum '1983-05-26'
      Dan wordt 'Marjan' gevonden

    Abstract Scenario: geslachtsnaam van personen komen gedeeltelijk overeen met de opgegeven geslachtsnaam
      Gegeven de op 26-05-1983 geboren 'Pieter'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) |
        | Maassen               | Pieter            |
      En de op 26-05-1983 geboren 'Jan'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        | Maassen               | Jan Peter         | van                 |
      En de op 26-05-1983 geboren 'Petra'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) |
        | Jansen                | Petra             |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26'
      Dan worden er geen personen gevonden

      Voorbeelden:
        | geslachtsnaam |
        | Maas          |
        | jans          |
        | MAAS          |

  Regel: personen met diakrieten in hun geslachtsnaam kunnen ook worden gevonden als de diakrietloze variant van de geslachtsnaam wordt opgegeven

    Abstract Scenario: de te vinden persoon heef diakrieten in zijn geslachtsnaam
      Gegeven de op 26-05-1983 geboren 'Albertus'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | geslachtsnaam (diakrieten) |
        | Kaster                | Käster                     |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26'
      Dan worden 'Albertus' gevonden

      Voorbeelden:
        | geslachtsnaam |
        | Käster        |
        | Kaster        |

  Regel: de optionele 'voornamen' en 'voorvoegsels' parameters (niet hoofdlettergevoelig) kunnen worden gebruikt om de zoekcriteria aan te scherpen

    Abstract Scenario: de geslachtsnaam, voornamen en geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam, voornamen en geboortedatum
      Gegeven de op 26-05-1983 geboren 'Pieter'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) |
        | Maassen               | Pieter            |
      En de op 26-05-1983 geboren 'Jan'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        | Maassen               | Jan Peter         | van                 |
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
      Gegeven de op 26-05-1983 geboren 'Pieter'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) |
        | Maassen               | Pieter            |
      En de op 26-05-1983 geboren 'Jan'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
        | Maassen               | Jan Peter         | van                 |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>' en geboortedatum '1983-05-26' en parameters
        | voorvoegsel    |
        | <voorvoegsels> |
      Dan wordt alleen 'Jan' gevonden

      Voorbeelden:
        | geslachtsnaam | voorvoegsels |
        | Maassen       | van          |
        | maassen       | VAN          |
        | MAASSEN       | Van          |

  Regel: de optionele 'geslacht' parameter (niet hoofdlettergevoelig) kan worden gebruikt om de zoekcriteria aan te scherpen

    Abstract Scenario: geslachtsnaam, geslacht en geboortedatum van personen komen exact overeen met de opgegeven geslachtsnaam, geslacht en geboortedatum
      Gegeven de op 26-05-1983 geboren vrouw 'Adele'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) |
        | Maassen               |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Maassen' en geboortedatum '1983-05-26' en parameters
        | geslacht              |
        | <geslachtsaanduiding> |
      Dan wordt alleen 'Adele' gevonden

      Voorbeelden:
        | geslachtsaanduiding |
        | v                   |
        | V                   |

  Regel: wildcard matching (niet hoofdlettergevoelig) kan worden toegepast voor de geslachtsnaam en voornamen parameters
        Voor wildcard matching moet minimaal 3 letters  worden opgegeven, gevolgd door de wildcard teken (*)

    Scenario: geslachtsnaam van personen komt overeen met de opgegeven geslachtsnaam met wildcard matching
      Gegeven de op 26-05-1983 geboren 'Groen'
      En de op 26-05-1983 geboren 'Groot'
      En de op 26-05-1983 geboren 'Groenlo'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam filter>' en geboortedatum '1983-05-26'
      Dan worden 'Groen, Groot en Groenlo' gevonden

      Voorbeelden:
        | geslachtsnaam filter |
        | gro*                 |
        | Gro*                 |
        | GRO*                 |

    Scenario: voornamen van personen komen overeen met de opgegeven voornamen met wildcard matching
      Gegeven de op 26-05-1983 geboren 'Maassen'
      * heeft de volgende gegevens
        | voornamen (02.10) |
        | Jan Peter         |
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Maassen' en geboortedatum '1983-05-26' en parameters
        | voornamen          |
        | <voornamen filter> |
      Dan wordt 'Maassen' gevonden

      Voorbeelden:
        | voornamen filter |
        | Jan*             |
        | jan*             |
        | JAN*             |
